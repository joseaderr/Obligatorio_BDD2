// Requerimiento 5.4: Mostrar el historial de asignaciones de una línea, con los datos de cada vehículo que la prestó.

// Ejemplo para la linea L42
db.vehiculos.aggregate([
    {
		//Utilizando el indice ix_vehiculos_linea descarta los vehículos que nunca estuvieron asignados a la linea L42
        $match: { "lineas.codigo": "L42" }
    },
    {
        $unwind: "$lineas"
    },
    {
		// Obtiene el vehículo asociado sólo a la linea L42
        $match: { "lineas.codigo": "L42" }
    },
    {
        $sort: { "lineas.fechaDesde": -1 }
    },
    {
        $project: {
            _id: 0,
            id_vehiculo: "$_id",
            tipo: 1,
            operador: 1,
            modelo: 1,
            datosExtra: 1,
            asignacion: {
                codigo_linea: "$lineas.codigo",
                nombre_linea: "$lineas.nombre",
                fecha_desde: "$lineas.fechaDesde",
                fecha_hasta: "$lineas.fechaHasta"
            }
        }
    }
]);
