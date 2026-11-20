// Requerimiento 5.2: Obtener los vehículos que se encuentran a menos de 1 km de un punto dado.

// Solo se consideran reportes desde este instante. En producción sería "ahora menos 1 o 2 minutos".
const desde = ISODate("2025-04-16T08:00:00Z");

db.reportes.aggregate([
    {
        // Usamos geoNear para obtener las distancias en relación a un punto
        $geoNear: {
            near: { type: "Point", coordinates: [-56.2036, -34.9057] }, // [long, lat] Plaza Independencia
            distanceField: "distancia_metros",
            maxDistance: 1000, // 1 km en metros
            spherical: true,
            query: { fecha: { $gte: desde } }
        }
    },
    {
        $sort: { fecha: -1 }
    },
    {
        $group: {
            _id: "$id_vehiculo",
            distancia_metros: { $first: "$distancia_metros" },
            ultima_ubicacion: { $first: "$ubicacion.coordinates" },
            fecha_reporte: { $first: "$fecha" }
        }
    },
    {
        $project: {
            _id: 0,
            id_vehiculo: "$_id",
            distancia_metros: 1,
            ultima_ubicacion: 1,
            fecha_reporte: 1
        }
    }
]);

// Correcciones respecto de la versión anterior:
//
// 1. Se agrega "query: { fecha: { $gte: desde } }" dentro de $geoNear. Antes se buscaba en todo el
//    historial, por lo que un vehículo que pasó cerca hace horas aparecía aunque hoy esté lejos.
//    La letra pide los vehículos que SE ENCUENTRAN a menos de 1 km, o sea según su posición actual.
//    Limitar a reportes recientes se acerca a eso y sigue usando el índice 2dsphere.
//    Limitación: un vehículo que se alejó dentro de la ventana todavía puede aparecer.
//
// 2. "distancia_minima_metros" pasa a "distancia_metros". Después del $sort por fecha, $first toma la
//    distancia del reporte más reciente, no la menor, así que "mínima" era engañoso.
//
// 3. "fecha_reporte" se calculaba en el $group pero el $project final la descartaba. Ahora se incluye.
//
// 4. El punto de consulta pasa a [-56.2036, -34.9057] (Plaza Independencia), que es la referencia de
//    datos_prueba.js. El punto anterior no estaba cerca de ninguna posición de prueba.
