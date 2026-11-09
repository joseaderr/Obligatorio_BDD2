// Requerimiento 5.2: Obtener los vehículos que se encuentran a menos de 1 km de un punto dado.

db.reportes.aggregate([
    {
        // Usamos geoNear para obtener las distancias en relación a un punto
        $geoNear: {
            near: { type: "Point", coordinates: [-56.1645, -34.9011] }, // [long, lat]
            distanceField: "distancia_metros",
            maxDistance: 1000, // 1 km en metros
            spherical: true
        }
    },
    {
        $sort: { fecha: -1 }
    },
    {
        $group: {
            _id: "$id_vehiculo",
            distancia_minima_metros: { $first: "$distancia_metros" },
            ultima_ubicacion: { $first: "$ubicacion.coordinates" },
            fecha_reporte: { $first: "$fecha" }
        }
    },
    {
        $project: {
            _id: 0,
            id_vehiculo: "$_id",
            distancia_minima_metros: 1,
            ultima_ubicacion: 1
        }
    }
]);
