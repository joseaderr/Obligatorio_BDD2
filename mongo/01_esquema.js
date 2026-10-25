// ============================================================================
// Parte 4 - Ubicación en tiempo real
// Creación de colecciones, schema validators e índices (MongoDB 5.0+)
//
// Ejecutar con:
//   mongosh "mongodb://localhost:27017" mongo/01_esquema.js
//
// OJO: el script elimina y recrea las colecciones. Es solo para desarrollo.
// ============================================================================

const conn = db.getSiblingDB("maps_tiempo_real");

conn.vehiculos.drop();
conn.reportes.drop();

// ============================================================================
// 1. vehiculos
//    Catálogo de vehículos + historial de asignaciones a líneas.
//    El código interno del vehículo es el _id (único por definición).
// ============================================================================
conn.createCollection("vehiculos", {
    validator: {
        $and: [
            {
                $jsonSchema: {
                    bsonType: "object",
                    required: ["_id", "tipo", "operador", "modelo"],
                    additionalProperties: false,
                    properties: {
                        _id: { bsonType: "long", description: "Código interno único" },
                        tipo: { enum: ["Autobús", "Tranvía", "Metro", "Ferry"] },
                        operador: { bsonType: "string", minLength: 1 },
                        modelo: { bsonType: "string", minLength: 1 },
                        datosExtra: { bsonType: "object" },
                        lineas: {
                            bsonType: "array",
                            items: {
                                bsonType: "object",
                                required: ["codigo", "nombre", "fechaDesde"],
                                additionalProperties: false,
                                properties: {
                                    codigo: { bsonType: "string", minLength: 1 },
                                    nombre: { bsonType: "string", minLength: 1 },
                                    fechaDesde: { bsonType: "date" },
                                    // null o ausente = asignación abierta (actual)
                                    fechaHasta: { bsonType: ["date", "null"] }
                                }
                            }
                        }
                    },
                    // datosExtra es obligatorio y su forma depende del tipo
                    oneOf: [
                        {
                            required: ["datosExtra"],
                            properties: {
                                tipo: { enum: ["Autobús"] },
                                datosExtra: {
                                    bsonType: "object",
                                    required: ["capacidadPasajeros", "tienePisoBajo"],
                                    additionalProperties: false,
                                    properties: {
                                        capacidadPasajeros: { bsonType: ["int", "long"], minimum: 0 },
                                        tienePisoBajo: { bsonType: "bool" }
                                    }
                                }
                            }
                        },
                        {
                            required: ["datosExtra"],
                            properties: {
                                tipo: { enum: ["Ferry"] },
                                datosExtra: {
                                    bsonType: "object",
                                    required: ["capacidadVehiculos"],
                                    additionalProperties: false,
                                    properties: {
                                        capacidadVehiculos: { bsonType: ["int", "long"], minimum: 0 }
                                    }
                                }
                            }
                        },
                        {
                            required: ["datosExtra"],
                            properties: {
                                tipo: { enum: ["Tranvía", "Metro"] },
                                datosExtra: {
                                    bsonType: "object",
                                    required: ["cantidadCoches"],
                                    additionalProperties: false,
                                    properties: {
                                        cantidadCoches: { bsonType: ["int", "long"], minimum: 1 }
                                    }
                                }
                            }
                        }
                    ]
                }
            },
            // fechaHasta posterior a fechaDesde (cuando fechaHasta existe)
            {
                $expr: {
                    $allElementsTrue: [{
                        $map: {
                            input: { $ifNull: ["$lineas", []] },
                            as: "l",
                            in: {
                                $or: [
                                    { $eq: [{ $ifNull: ["$$l.fechaHasta", null] }, null] },
                                    { $gt: [{ $ifNull: ["$$l.fechaHasta", null] }, "$$l.fechaDesde"] }
                                ]
                            }
                        }
                    }]
                }
            },
            // A lo sumo una asignación abierta por vehículo
            {
                $expr: {
                    $lte: [{
                        $size: {
                            $filter: {
                                input: { $ifNull: ["$lineas", []] },
                                as: "l",
                                cond: { $eq: [{ $ifNull: ["$$l.fechaHasta", null] }, null] }
                            }
                        }
                    }, 1]
                }
            }
        ]
    },
    validationLevel: "strict",
    validationAction: "error"
});

// ============================================================================
// 2. reportes
//    Una medición por documento. Los datos variables van en "extras",
//    que queda abierto para incorporar nuevos tipos sin tocar el esquema.
// ============================================================================
conn.createCollection("reportes", {
    validator: {
        $jsonSchema: {
            bsonType: "object",
            // Si se permiten reportes de vehículos sin línea, quitar "linea"
            required: ["_id", "id_vehiculo", "linea", "ubicacion", "fecha", "velocidad", "destino"],
            additionalProperties: false,
            properties: {
                _id: { bsonType: "objectId" },
                id_vehiculo: { bsonType: "long", description: "Referencia a vehiculos._id" },
                linea: { bsonType: "string", minLength: 1 },
                ubicacion: {
                    bsonType: "object",
                    required: ["type", "coordinates"],
                    additionalProperties: false,
                    properties: {
                        type: { enum: ["Point"] },
                        // GeoJSON: [longitud, latitud]
                        coordinates: {
                            bsonType: "array",
                            minItems: 2,
                            maxItems: 2,
                            items: [
                                { bsonType: "double", minimum: -180, maximum: 180 },
                                { bsonType: "double", minimum: -90, maximum: 90 }
                            ]
                        }
                    }
                },
                fecha: { bsonType: "date" },
                velocidad: { bsonType: "double", minimum: 0 },
                destino: { bsonType: "string", minLength: 1 },
                extras: { bsonType: "object" }
            }
        }
    },
    validationLevel: "strict",
    validationAction: "error"
});

// ============================================================================
// 3. Índices
// ============================================================================

// 5.1 / 5.4: vehículos por línea
conn.vehiculos.createIndex(
    { "lineas.codigo": 1 },
    { name: "ix_vehiculos_linea" }
);

// 5.1 y 5.3: último reporte / recorrido de un vehículo
conn.reportes.createIndex(
    { id_vehiculo: 1, fecha: -1 },
    { name: "ix_reportes_vehiculo_fecha" }
);

// 5.1 por línea / analítica
conn.reportes.createIndex(
    { linea: 1, fecha: -1 },
    { name: "ix_reportes_linea_fecha" }
);

// 5.2: proximidad geográfica
conn.reportes.createIndex(
    { ubicacion: "2dsphere" },
    { name: "ix_reportes_geo" }
);
