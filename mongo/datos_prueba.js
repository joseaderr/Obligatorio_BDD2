// Seed de transporte público. Ejecutar con: mongosh < mongo/datos_prueba.js
// Los identificadores 1001-1008 y ObjectId 000...001-000...026 quedan
// reservados para este seed; se reemplazan al reejecutarlo, sin borrar otros datos.
const conn = db.getSiblingDB("maps");

const linea = (codigo, nombre, desde, hasta = null) => ({
    codigo,
    nombre,
    fechaDesde: ISODate(desde),
    fechaHasta: hasta === null ? null : ISODate(hasta)
});

const vehiculos = [
    {
        _id: NumberLong("1001"), tipo: "Autobús", operador: "CUTCSA",
        modelo: "Mercedes-Benz OH 1621L / Marcopolo Torino", datosExtra: { capacidadPasajeros: 80, tienePisoBajo: true },
        lineas: [linea("121", "Plaza Independencia - Carrasco", "2025-03-01T00:00:00Z")]
    },
    {
        _id: NumberLong("1002"), tipo: "Autobús", operador: "CUTCSA",
        modelo: "Volvo B270F / Marcopolo Torino", datosExtra: { capacidadPasajeros: 70, tienePisoBajo: true },
        lineas: [
            linea("121", "Plaza Independencia - Carrasco", "2025-03-01T00:00:00Z", "2025-04-16T08:00:00Z"),
            linea("104", "Plaza Independencia - Portones", "2025-04-16T08:00:00Z")
        ]
    },
    {
        _id: NumberLong("1003"), tipo: "Autobús", operador: "COETC",
        modelo: "Mercedes-Benz OH 1621L / Marcopolo Torino", datosExtra: { capacidadPasajeros: 65, tienePisoBajo: false },
        lineas: [
            linea("121", "Plaza Independencia - Carrasco", "2025-03-01T00:00:00Z", "2025-04-15T23:59:00Z"),
            linea("183", "Plaza España - Paso de la Arena", "2025-04-16T00:00:00Z")
        ]
    },
    {
        _id: NumberLong("2001"), tipo: "Autobús", operador: "UCOT",
        modelo: "Volvo B270F / Marcopolo Torino", datosExtra: { capacidadPasajeros: 75, tienePisoBajo: true },
        lineas: [linea("104", "Plaza Independencia - Portones", "2025-03-10T00:00:00Z")]
    },
    {
        _id: NumberLong("2002"), tipo: "Autobús", operador: "UCOT",
        modelo: "Mercedes-Benz OH 1621L / Marcopolo Torino", datosExtra: { capacidadPasajeros: 60, tienePisoBajo: false },
        lineas: [
            linea("104", "Plaza Independencia - Portones", "2025-03-10T00:00:00Z", "2025-04-16T07:00:00Z"),
            linea("121", "Plaza Independencia - Carrasco", "2025-04-16T07:00:00Z")
        ]
    },
    {
        _id: NumberLong("3001"), tipo: "Autobús", operador: "CUTCSA",
        modelo: "Volvo B270F / Marcopolo Torino", datosExtra: { capacidadPasajeros: 80, tienePisoBajo: true },
        lineas: [linea("121", "Plaza Independencia - Carrasco", "2025-03-01T00:00:00Z")]
    },
    {
        _id: NumberLong("3002"), tipo: "Autobús", operador: "COME",
        modelo: "Mercedes-Benz OH 1621L / Marcopolo Torino", datosExtra: { capacidadPasajeros: 55, tienePisoBajo: false },
        lineas: [linea("183", "Plaza España - Paso de la Arena", "2025-04-01T00:00:00Z")]
    },
    {
        _id: NumberLong("4001"), tipo: "Autobús", operador: "COME",
        modelo: "Marcopolo Torino", datosExtra: { capacidadPasajeros: 45, tienePisoBajo: false },
        lineas: [linea("183", "Plaza España - Paso de la Arena", "2025-03-01T00:00:00Z")]
    }
];

const reporte = (n, idVehiculo, codigoLinea, fecha, longitud, latitud, velocidad, destino, extras = {}) => ({
    _id: ObjectId(n.toString(16).padStart(24, "0")),
    id_vehiculo: NumberLong(String(idVehiculo)),
    linea: codigoLinea,
    ubicacion: { type: "Point", coordinates: [longitud, latitud] },
    fecha: ISODate(fecha),
    velocidad,
    destino,
    extras
});

// Montevideo: punto de referencia Plaza Independencia (-56.2036, -34.9057).
// Incluye posiciones dentro y fuera de 1 km; 3002 aún no reportó posición.
const reportes = [
    reporte(1, 1001, "121", "2025-04-16T08:00:00Z", -56.2036, -34.9057, 0.0, "Carrasco", { ocupacion: 0.35, puertasAbiertas: true }),
    reporte(2, 1001, "121", "2025-04-16T08:05:00Z", -56.1980, -34.9064, 18.5, "Carrasco", { ocupacion: 0.42, temperaturaInterior: 21.5 }),
    reporte(3, 1001, "121", "2025-04-16T08:10:00Z", -56.1917, -34.9061, 24.0, "Carrasco", { ocupacion: 0.51 }),
    reporte(4, 1001, "121", "2025-04-16T08:15:00Z", -56.1850, -34.9045, 12.0, "Carrasco", { puertasAbiertas: true }),
    reporte(5, 1001, "121", "2025-04-16T08:20:00Z", -56.1780, -34.9010, 0.0, "Carrasco", { ocupacion: 0.58, puertasAbiertas: false }),

    reporte(6, 1002, "121", "2025-04-16T07:50:00Z", -56.1980, -34.9070, 22.0, "Carrasco"),
    reporte(7, 1002, "104", "2025-04-16T08:00:00Z", -56.2030, -34.9060, 0.0, "Portones", { ocupacion: 0.72, puertasAbiertas: true }),
    reporte(8, 1002, "104", "2025-04-16T08:05:00Z", -56.1870, -34.9010, 16.0, "Portones"),
    reporte(9, 1002, "104", "2025-04-16T08:10:00Z", -56.1700, -34.8940, 25.0, "Portones", { ocupacion: 0.64 }),

    reporte(10, 1003, "121", "2025-04-15T23:40:00Z", -56.2100, -34.9070, 20.0, "Carrasco"),
    reporte(11, 1003, "121", "2025-04-15T23:50:00Z", -56.2030, -34.9060, 14.0, "Carrasco"),
    reporte(12, 1003, "183", "2025-04-16T08:15:00Z", -56.2250, -34.8980, 19.0, "Paso de la Arena", { ocupacion: 0.28 }),

    reporte(13, 2001, "104", "2025-04-16T08:00:00Z", -56.2030, -34.9060, 0.0, "Portones"),
    reporte(14, 2001, "104", "2025-04-16T08:05:00Z", -56.1900, -34.8990, 26.0, "Portones"),
    reporte(15, 2001, "104", "2025-04-16T08:10:00Z", -56.1760, -34.8900, 31.0, "Portones", { ocupacion: 0.81 }),
    reporte(16, 2001, "104", "2025-04-16T08:15:00Z", -56.1580, -34.8780, 18.0, "Portones", { temperaturaInterior: 19.0 }),

    reporte(17, 2002, "104", "2025-04-16T06:50:00Z", -56.1900, -34.8990, 15.0, "Portones"),
    reporte(18, 2002, "121", "2025-04-16T07:10:00Z", -56.1980, -34.9060, 35.0, "Carrasco"),
    reporte(19, 2002, "121", "2025-04-16T07:15:00Z", -56.1910, -34.9060, 0.0, "Carrasco", { puertasAbiertas: true }),

    reporte(20, 3001, "121", "2025-04-16T08:00:00Z", -56.1750, -34.9000, 42.0, "Carrasco"),
    reporte(21, 3001, "121", "2025-04-16T08:05:00Z", -56.1550, -34.8950, 45.0, "Carrasco"),
    reporte(22, 3001, "121", "2025-04-16T08:10:00Z", -56.1300, -34.8900, 38.0, "Carrasco", { ocupacion: 0.91 }),
    reporte(23, 3001, "121", "2025-04-16T08:15:00Z", -56.1050, -34.8850, 0.0, "Carrasco", { puertasAbiertas: false }),

    reporte(24, 4001, "183", "2025-04-16T08:00:00Z", -56.2100, -34.9060, 8.0, "Paso de la Arena", { ocupacion: 0.45 }),
    reporte(25, 4001, "183", "2025-04-16T08:05:00Z", -56.2300, -34.8950, 10.5, "Paso de la Arena"),
    reporte(26, 4001, "183", "2025-04-16T08:10:00Z", -56.2500, -34.8800, 7.0, "Paso de la Arena", { temperaturaInterior: 20.0 })
];

conn.vehiculos.bulkWrite(vehiculos.map(documento => ({
    replaceOne: { filter: { _id: documento._id }, replacement: documento, upsert: true }
})));
conn.reportes.bulkWrite(reportes.map(documento => ({
    replaceOne: { filter: { _id: documento._id }, replacement: documento, upsert: true }
})));

print(`Seed aplicado: ${vehiculos.length} vehículos y ${reportes.length} reportes.`);
