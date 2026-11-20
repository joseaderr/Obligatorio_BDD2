// Requerimiento 5.3: Devolver el recorrido de un vehículo durante un intervalo de tiempo dado.

const conn = db.getSiblingDB("maps");

const idVehiculo = NumberLong("1001");
const desde = ISODate("2025-04-16T08:00:00Z");
const hasta = ISODate("2025-04-16T08:20:00Z");

conn.reportes.aggregate([
    {
        // Usa el índice ix_reportes_vehiculo_fecha (id_vehiculo, fecha)
        $match: {
            id_vehiculo: idVehiculo,
            fecha: { $gte: desde, $lte: hasta }
        }
    },
    // Orden cronológico: es el orden en que se recorrió el trayecto
    { $sort: { fecha: 1 } },
    {
        $project: {
            _id: 0,
            fecha: 1,
            linea: 1,
            coordenadas: "$ubicacion.coordinates", // [longitud, latitud]
            velocidad: 1,
            destino: 1
        }
    }
]);

// Consulta: filtra los reportes del vehículo dentro del intervalo [desde, hasta] y los
// ordena por fecha ascendente, devolviendo cada punto del recorrido (coordenadas, velocidad,
// línea y destino). Con los datos de prueba, el vehículo 1001 devuelve 5 puntos.
