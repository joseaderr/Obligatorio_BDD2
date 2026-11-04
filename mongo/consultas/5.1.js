db.reportes.aggregate([
    { $match: { linea : "104" } },
    {
        $sort: {
            fecha: -1
            }
        },
    {
        $group: {
            _id : "$linea",
            ubi : {$first : "$ubicacion"}
            }
    }
]);

// Consulta para obtener la última ubicación de los vehículos de la línea dada, primero filtra por linea,
//  luego ordena los resultados por fecha y los agrupa quedandose con el primer registro de cada grupo.