// Requerimiento 5.1: Devolver las coordenadas de la última posición conocida de todos los vehículos de una línea.

db.reportes.aggregate([
    { $match: { linea: "104" } },
    { $sort: { fecha: -1 } },
    {
        $group: {
            _id: "$id_vehiculo",
            ubicacion: { $first: "$ubicacion.coordinates" }, // [longitud, latitud]
            fecha: { $first: "$fecha" }
        }
    }
]);

// Filtra por línea, ordena los reportes del más nuevo al más viejo y agrupa POR VEHÍCULO,
// quedándose con el primer reporte de cada grupo (el último conocido).
//
// Corrección respecto de la versión anterior: antes se agrupaba por "$linea", lo que devolvía
// una sola posición por línea (la del vehículo que reportó último). La letra pide la última
// posición de TODOS los vehículos de la línea, es decir, una por vehículo, por eso se agrupa
// por "$id_vehiculo". Se agrega además "fecha" para saber de cuándo es cada posición.
// Con los datos de prueba, la línea "104" devuelve los vehículos 1002, 2001 y 2002.
