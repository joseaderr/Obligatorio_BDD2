-- ============================================================================
-- SCRIPT DE INSERCIÓN DE DATOS DE PRUEBA (VOLUMEN AMPLIADO x5)
-- Generado para Oracle Database
-- ============================================================================

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
ALTER SESSION SET NLS_TIMESTAMP_FORMAT = 'YYYY-MM-DD HH24:MI:SS';

-- 1. TABLA: CUENTA (Mínimo 25-30 registros para abastecer las jerarquías y evitar colisiones)
-- Cuentas 1 a 30
INSERT INTO CUENTA (email, nombre, pais, idioma, fecha_creacion, estado) VALUES ('juan.perez@email.com', 'Juan Pérez', 'Chile', 'Español', TO_DATE('2025-01-10', 'YYYY-MM-DD'), 'Activa');
INSERT INTO CUENTA (email, nombre, pais, idioma, fecha_creacion, estado) VALUES ('maria.gomez@email.com', 'María Gómez', 'Chile', 'Español', TO_DATE('2025-01-12', 'YYYY-MM-DD'), 'Activa');
INSERT INTO CUENTA (email, nombre, pais, idioma, fecha_creacion, estado) VALUES ('carlos.andrade@email.com', 'Carlos Andrade', 'México', 'Español', TO_DATE('2025-01-15', 'YYYY-MM-DD'), 'Activa');
INSERT INTO CUENTA (email, nombre, pais, idioma, fecha_creacion, estado) VALUES ('ana.martinez@email.com', 'Ana Martínez', 'España', 'Español', TO_DATE('2025-01-20', 'YYYY-MM-DD'), 'Activa');
INSERT INTO CUENTA (email, nombre, pais, idioma, fecha_creacion, estado) VALUES ('john.doe@email.com', 'John Doe', 'Estados Unidos', 'Inglés', TO_DATE('2025-01-22', 'YYYY-MM-DD'), 'Activa');
INSERT INTO CUENTA (email, nombre, pais, idioma, fecha_creacion, estado) VALUES ('luisa.fuentes@email.com', 'Luisa Fuentes', 'Colombia', 'Español', TO_DATE('2025-02-01', 'YYYY-MM-DD'), 'Activa');
INSERT INTO CUENTA (email, nombre, pais, idioma, fecha_creacion, estado) VALUES ('pedro.soto@email.com', 'Pedro Soto', 'Chile', 'Español', TO_DATE('2025-02-05', 'YYYY-MM-DD'), 'Activa');
INSERT INTO CUENTA (email, nombre, pais, idioma, fecha_creacion, estado) VALUES ('sofia.castro@email.com', 'Sofía Castro', 'Argentina', 'Español', TO_DATE('2025-02-10', 'YYYY-MM-DD'), 'Activa');
INSERT INTO CUENTA (email, nombre, pais, idioma, fecha_creacion, estado) VALUES ('diego.reyes@email.com', 'Diego Reyes', 'Perú', 'Español', TO_DATE('2025-02-14', 'YYYY-MM-DD'), 'Suspendida');
INSERT INTO CUENTA (email, nombre, pais, idioma, fecha_creacion, estado) VALUES ('lucia.mendez@email.com', 'Lucía Méndez', 'México', 'Español', TO_DATE('2025-02-18', 'YYYY-MM-DD'), 'Activa');
INSERT INTO CUENTA (email, nombre, pais, idioma, fecha_creacion, estado) VALUES ('roberto.diaz@email.com', 'Roberto Díaz', 'Chile', 'Español', TO_DATE('2025-02-20', 'YYYY-MM-DD'), 'Activa');
INSERT INTO CUENTA (email, nombre, pais, idioma, fecha_creacion, estado) VALUES ('elena.torres@email.com', 'Elena Torres', 'España', 'Español', TO_DATE('2025-02-25', 'YYYY-MM-DD'), 'Activa');
INSERT INTO CUENTA (email, nombre, pais, idioma, fecha_creacion, estado) VALUES ('javier.lopez@email.com', 'Javier López', 'Colombia', 'Español', TO_DATE('2025-03-01', 'YYYY-MM-DD'), 'Activa');
INSERT INTO CUENTA (email, nombre, pais, idioma, fecha_creacion, estado) VALUES ('claudia.silva@email.com', 'Claudia Silva', 'Brasil', 'Portugués', TO_DATE('2025-03-03', 'YYYY-MM-DD'), 'Activa');
INSERT INTO CUENTA (email, nombre, pais, idioma, fecha_creacion, estado) VALUES ('ricardo.morales@email.com', 'Ricardo Morales', 'Chile', 'Español', TO_DATE('2025-03-05', 'YYYY-MM-DD'), 'Activa');
INSERT INTO CUENTA (email, nombre, pais, idioma, fecha_creacion, estado) VALUES ('amanda.wallace@email.com', 'Amanda Wallace', 'Reino Unido', 'Inglés', TO_DATE('2025-03-10', 'YYYY-MM-DD'), 'Activa');
INSERT INTO CUENTA (email, nombre, pais, idioma, fecha_creacion, estado) VALUES ('fernando.herrera@email.com', 'Fernando Herrera', 'México', 'Español', TO_DATE('2025-03-12', 'YYYY-MM-DD'), 'Activa');
INSERT INTO CUENTA (email, nombre, pais, idioma, fecha_creacion, estado) VALUES ('gabriela.vargas@email.com', 'Gabriela Vargas', 'Costa Rica', 'Español', TO_DATE('2025-03-15', 'YYYY-MM-DD'), 'Activa');
INSERT INTO CUENTA (email, nombre, pais, idioma, fecha_creacion, estado) VALUES ('manuel.rojas@email.com', 'Manuel Rojas', 'Chile', 'Español', TO_DATE('2025-03-18', 'YYYY-MM-DD'), 'Activa');
INSERT INTO CUENTA (email, nombre, pais, idioma, fecha_creacion, estado) VALUES ('patricia.bravos@email.com', 'Patricia Bravos', 'Argentina', 'Español', TO_DATE('2025-03-20', 'YYYY-MM-DD'), 'Activa');
INSERT INTO CUENTA (email, nombre, pais, idioma, fecha_creacion, estado) VALUES ('hugo.sanchez@email.com', 'Hugo Sánchez', 'España', 'Español', TO_DATE('2025-03-22', 'YYYY-MM-DD'), 'Activa');
INSERT INTO CUENTA (email, nombre, pais, idioma, fecha_creacion, estado) VALUES ('isabel.flores@email.com', 'Isabel Flores', 'Perú', 'Español', TO_DATE('2025-03-25', 'YYYY-MM-DD'), 'Activa');
INSERT INTO CUENTA (email, nombre, pais, idioma, fecha_creacion, estado) VALUES ('andres.mendoza@email.com', 'Andrés Mendoza', 'Colombia', 'Español', TO_DATE('2025-03-28', 'YYYY-MM-DD'), 'Activa');
INSERT INTO CUENTA (email, nombre, pais, idioma, fecha_creacion, estado) VALUES ('valeria.guzman@email.com', 'Valeria Guzmán', 'México', 'Español', TO_DATE('2025-04-01', 'YYYY-MM-DD'), 'Activa');
INSERT INTO CUENTA (email, nombre, pais, idioma, fecha_creacion, estado) VALUES ('jorge.miranda@email.com', 'Jorge Miranda', 'Chile', 'Español', TO_DATE('2025-04-03', 'YYYY-MM-DD'), 'Activa');
INSERT INTO CUENTA (email, nombre, pais, idioma, fecha_creacion, estado) VALUES ('camila.toledo@email.com', 'Camila Toledo', 'Chile', 'Español', TO_DATE('2025-04-05', 'YYYY-MM-DD'), 'Activa');
INSERT INTO CUENTA (email, nombre, pais, idioma, fecha_creacion, estado) VALUES ('tomas.vidal@email.com', 'Tomás Vidal', 'España', 'Español', TO_DATE('2025-04-08', 'YYYY-MM-DD'), 'Activa');
INSERT INTO CUENTA (email, nombre, pais, idioma, fecha_creacion, estado) VALUES ('barbara.campos@email.com', 'Bárbara Campos', 'Chile', 'Español', TO_DATE('2025-04-10', 'YYYY-MM-DD'), 'Activa');
INSERT INTO CUENTA (email, nombre, pais, idioma, fecha_creacion, estado) VALUES ('marcelo.salas@email.com', 'Marcelo Salas', 'Chile', 'Español', TO_DATE('2025-04-12', 'YYYY-MM-DD'), 'Activa');
INSERT INTO CUENTA (email, nombre, pais, idioma, fecha_creacion, estado) VALUES ('natalia.pardo@email.com', 'Natalia Pardo', 'Argentina', 'Español', TO_DATE('2025-04-15', 'YYYY-MM-DD'), 'Activa');

-- 2. TABLA: CUENTA_TELEFONO (Mínimo 15-20 registros)
INSERT INTO CUENTA_TELEFONO (id_cuenta, telefono) VALUES (1, '+56911112222');
INSERT INTO CUENTA_TELEFONO (id_cuenta, telefono) VALUES (1, '+56223334444');
INSERT INTO CUENTA_TELEFONO (id_cuenta, telefono) VALUES (2, '+56922223333');
INSERT INTO CUENTA_TELEFONO (id_cuenta, telefono) VALUES (3, '+525511223344');
INSERT INTO CUENTA_TELEFONO (id_cuenta, telefono) VALUES (4, '+34600112233');
INSERT INTO CUENTA_TELEFONO (id_cuenta, telefono) VALUES (5, '+12025550199');
INSERT INTO CUENTA_TELEFONO (id_cuenta, telefono) VALUES (6, '+573001234567');
INSERT INTO CUENTA_TELEFONO (id_cuenta, telefono) VALUES (7, '+56944445555');
INSERT INTO CUENTA_TELEFONO (id_cuenta, telefono) VALUES (8, '+541199998888');
INSERT INTO CUENTA_TELEFONO (id_cuenta, telefono) VALUES (10, '+525577665544');
INSERT INTO CUENTA_TELEFONO (id_cuenta, telefono) VALUES (11, '+56977778888');
INSERT INTO CUENTA_TELEFONO (id_cuenta, telefono) VALUES (12, '+34699887766');
INSERT INTO CUENTA_TELEFONO (id_cuenta, telefono) VALUES (13, '+573159876543');
INSERT INTO CUENTA_TELEFONO (id_cuenta, telefono) VALUES (15, '+56988889999');
INSERT INTO CUENTA_TELEFONO (id_cuenta, telefono) VALUES (17, '+525544332211');

-- 3. TABLA: CUENTA_GUIA_LOCAL (Mínimo 10-15 registros, niveles 1 a 8)
INSERT INTO CUENTA_GUIA_LOCAL (id_cuenta, nivel, fecha_ingreso) VALUES (1, 5, TO_DATE('2025-02-01', 'YYYY-MM-DD'));
INSERT INTO CUENTA_GUIA_LOCAL (id_cuenta, nivel, fecha_ingreso) VALUES (2, 3, TO_DATE('2025-02-15', 'YYYY-MM-DD'));
INSERT INTO CUENTA_GUIA_LOCAL (id_cuenta, nivel, fecha_ingreso) VALUES (3, 7, TO_DATE('2025-01-20', 'YYYY-MM-DD'));
INSERT INTO CUENTA_GUIA_LOCAL (id_cuenta, nivel, fecha_ingreso) VALUES (4, 2, TO_DATE('2025-03-01', 'YYYY-MM-DD'));
INSERT INTO CUENTA_GUIA_LOCAL (id_cuenta, nivel, fecha_ingreso) VALUES (6, 4, TO_DATE('2025-02-20', 'YYYY-MM-DD'));
INSERT INTO CUENTA_GUIA_LOCAL (id_cuenta, nivel, fecha_ingreso) VALUES (8, 6, TO_DATE('2025-03-05', 'YYYY-MM-DD'));
INSERT INTO CUENTA_GUIA_LOCAL (id_cuenta, nivel, fecha_ingreso) VALUES (12, 8, TO_DATE('2025-03-10', 'YYYY-MM-DD'));
INSERT INTO CUENTA_GUIA_LOCAL (id_cuenta, nivel, fecha_ingreso) VALUES (14, 1, TO_DATE('2025-03-15', 'YYYY-MM-DD'));
INSERT INTO CUENTA_GUIA_LOCAL (id_cuenta, nivel, fecha_ingreso) VALUES (16, 5, TO_DATE('2025-03-20', 'YYYY-MM-DD'));
INSERT INTO CUENTA_GUIA_LOCAL (id_cuenta, nivel, fecha_ingreso) VALUES (20, 3, TO_DATE('2025-03-25', 'YYYY-MM-DD'));

-- 4. TABLA: CUENTA_PROPIETARIA (Mínimo 10-15 registros, RUT de exactamente 12 números digitales)
INSERT INTO CUENTA_PROPIETARIA (id_cuenta, rut, razon_social, metodo_verificacion, fecha_verificacion) VALUES (7, '761234567890', 'Inversiones Gastronómicas Soto EIRL', 'Postal', TO_DATE('2025-02-10', 'YYYY-MM-DD'));
INSERT INTO CUENTA_PROPIETARIA (id_cuenta, rut, razon_social, metodo_verificacion, fecha_verificacion) VALUES (11, '883456789012', 'Comercializadora de Café Díaz Ltda', 'Telefónico', TO_DATE('2025-02-28', 'YYYY-MM-DD'));
INSERT INTO CUENTA_PROPIETARIA (id_cuenta, rut, razon_social, metodo_verificacion, fecha_verificacion) VALUES (13, '995678901234', 'Hotelería y Turismo López S.A.S.', 'Video', TO_DATE('2025-03-05', 'YYYY-MM-DD'));
INSERT INTO CUENTA_PROPIETARIA (id_cuenta, rut, razon_social, metodo_verificacion, fecha_verificacion) VALUES (15, '771112223334', 'Restaurantes Morales Spa', 'Postal', TO_DATE('2025-03-12', 'YYYY-MM-DD'));
INSERT INTO CUENTA_PROPIETARIA (id_cuenta, rut, razon_social, metodo_verificacion, fecha_verificacion) VALUES (17, '654445556667', 'Entretenimiento Mexicano SA de CV', 'Telefónico', TO_DATE('2025-03-20', 'YYYY-MM-DD'));
INSERT INTO CUENTA_PROPIETARIA (id_cuenta, rut, razon_social, metodo_verificacion, fecha_verificacion) VALUES (19, '823334445556', 'Librerías y Cultura Rojas EIRL', 'Video', TO_DATE('2025-03-25', 'YYYY-MM-DD'));
INSERT INTO CUENTA_PROPIETARIA (id_cuenta, rut, razon_social, metodo_verificacion, fecha_verificacion) VALUES (21, '915556667778', 'Servicios Turísticos Sánchez SL', 'Postal', TO_DATE('2025-03-28', 'YYYY-MM-DD'));
INSERT INTO CUENTA_PROPIETARIA (id_cuenta, rut, razon_social, metodo_verificacion, fecha_verificacion) VALUES (23, '737778889990', 'Boutique y Moda Mendoza S.A.S.', 'Telefónico', TO_DATE('2025-04-02', 'YYYY-MM-DD'));
INSERT INTO CUENTA_PROPIETARIA (id_cuenta, rut, razon_social, metodo_verificacion, fecha_verificacion) VALUES (25, '848889990001', 'Centro Médico Miranda Ltda', 'Video', TO_DATE('2025-04-05', 'YYYY-MM-DD'));
INSERT INTO CUENTA_PROPIETARIA (id_cuenta, rut, razon_social, metodo_verificacion, fecha_verificacion) VALUES (29, '959990001112', 'Gimnasios e Infraestructura Salas Spa', 'Postal', TO_DATE('2025-04-15', 'YYYY-MM-DD'));

-- 5. TABLA: CATEGORIA (Mínimo 10-15 registros)
INSERT INTO CATEGORIA (nombre, descripcion) VALUES ('Restaurante', 'Establecimientos destinados al consumo de alimentos y bebidas.');
INSERT INTO CATEGORIA (nombre, descripcion) VALUES ('Cafetería', 'Lugares especialistas en la venta de café, repostería y snacks.');
INSERT INTO CATEGORIA (nombre, descripcion) VALUES ('Hotel', 'Alojamientos turísticos con servicios incluidos.');
INSERT INTO CATEGORIA (nombre, descripcion) VALUES ('Museo', 'Espacios culturales de exposición e historia.');
INSERT INTO CATEGORIA (nombre, descripcion) VALUES ('Parque', 'Áreas verdes y recreativas al aire libre.');
INSERT INTO CATEGORIA (nombre, descripcion) VALUES ('Librería', 'Venta de libros, novelas y material de estudio.');
INSERT INTO CATEGORIA (nombre, descripcion) VALUES ('Centro Comercial', 'Complejo de tiendas, retail y entretenimiento.');
INSERT INTO CATEGORIA (nombre, descripcion) VALUES ('Gimnasio', 'Centros deportivos y de acondicionamiento físico.');
INSERT INTO CATEGORIA (nombre, descripcion) VALUES ('Bar', 'Establecimientos de entretenimiento y venta de licores.');
INSERT INTO CATEGORIA (nombre, descripcion) VALUES ('Centro Médico', 'Atención de salud, consultas y urgencias.');

-- 6. TABLA: LUGAR (Mínimo 15-20 registros, respetando contenedores y administradores)
-- Lugares 1 a 15
INSERT INTO LUGAR (nombre, calle, numero, ciudad, pais, latitud, longitud, estado, id_categoria_principal, id_lugar_contenedor, id_cuenta_admin) VALUES ('Mall Costanera Center', 'Av. Andrés Bello', '2425', 'Santiago', 'Chile', -33.4168000, -70.6067000, 'Operativo', 7, NULL, NULL);
INSERT INTO LUGAR (nombre, calle, numero, ciudad, pais, latitud, longitud, estado, id_categoria_principal, id_lugar_contenedor, id_cuenta_admin) VALUES ('Restaurante Giratorio', 'Av. Nueva Providencia', '2250', 'Santiago', 'Chile', -33.4221000, -70.6095000, 'Operativo', 1, NULL, 7);
INSERT INTO LUGAR (nombre, calle, numero, ciudad, pais, latitud, longitud, estado, id_categoria_principal, id_lugar_contenedor, id_cuenta_admin) VALUES ('Café de la Esquina', 'Paseo de la Reforma', '450', 'CDMX', 'México', 19.4271000, -99.1676000, 'Operativo', 2, NULL, 11);
INSERT INTO LUGAR (nombre, calle, numero, ciudad, pais, latitud, longitud, estado, id_categoria_principal, id_lugar_contenedor, id_cuenta_admin) VALUES ('Hotel Plaza Central', 'Av. El Dorado', '68-95', 'Bogotá', 'Colombia', 4.6585000, -74.0942000, 'Operativo', 3, NULL, 13);
INSERT INTO LUGAR (nombre, calle, numero, ciudad, pais, latitud, longitud, estado, id_categoria_principal, id_lugar_contenedor, id_cuenta_admin) VALUES ('Pizzería Bella Italia', 'Av. Vitacura', '3500', 'Santiago', 'Chile', -33.4012000, -70.5784000, 'Operativo', 1, 1, 15); -- Dentro de Costanera
INSERT INTO LUGAR (nombre, calle, numero, ciudad, pais, latitud, longitud, estado, id_categoria_principal, id_lugar_contenedor, id_cuenta_admin) VALUES ('Museo del Prado', 'Calle de Ruiz de Alarcón', '23', 'Madrid', 'España', 40.4137000, -3.6921000, 'Operativo', 4, NULL, 21);
INSERT INTO LUGAR (nombre, calle, numero, ciudad, pais, latitud, longitud, estado, id_categoria_principal, id_lugar_contenedor, id_cuenta_admin) VALUES ('Parque del Retiro', 'Plaza de la Independencia', '7', 'Madrid', 'España', 40.4153000, -3.6844000, 'Operativo', 5, NULL, NULL);
INSERT INTO LUGAR (nombre, calle, numero, ciudad, pais, latitud, longitud, estado, id_categoria_principal, id_lugar_contenedor, id_cuenta_admin) VALUES ('Librería Cultura Viva', 'Av. Corrientes', '1240', 'Buenos Aires', 'Argentina', -34.6037000, -58.3816000, 'Operativo', 6, NULL, 19);
INSERT INTO LUGAR (nombre, calle, numero, ciudad, pais, latitud, longitud, estado, id_categoria_principal, id_lugar_contenedor, id_cuenta_admin) VALUES ('Bar El Callejón', 'Calle Madero', '15', 'CDMX', 'México', 19.4334000, -99.1362000, 'Operativo', 9, NULL, 17);
INSERT INTO LUGAR (nombre, calle, numero, ciudad, pais, latitud, longitud, estado, id_categoria_principal, id_lugar_contenedor, id_cuenta_admin) VALUES ('Clínica Las Condes Médica', 'Av. Estoril', '450', 'Santiago', 'Chile', -33.3892000, -70.5213000, 'Operativo', 10, NULL, 25);
INSERT INTO LUGAR (nombre, calle, numero, ciudad, pais, latitud, longitud, estado, id_categoria_principal, id_lugar_contenedor, id_cuenta_admin) VALUES ('SmartFit Gimnasio', 'Av. Andrés Bello', '2425', 'Santiago', 'Chile', -33.4168000, -70.6067000, 'Operativo', 8, 1, 29); -- Dentro de Costanera
INSERT INTO LUGAR (nombre, calle, numero, ciudad, pais, latitud, longitud, estado, id_categoria_principal, id_lugar_contenedor, id_cuenta_admin) VALUES ('Boutique Exclusiva', 'Av. Larco', '740', 'Lima', 'Perú', -12.1214000, -77.0298000, 'Operativo', 7, NULL, 23);
INSERT INTO LUGAR (nombre, calle, numero, ciudad, pais, latitud, longitud, estado, id_categoria_principal, id_lugar_contenedor, id_cuenta_admin) VALUES ('Restaurante Antiguo', 'Calle Mayor', '4', 'Madrid', 'España', 40.4166000, -3.7056000, 'Cerrado temporalmente', 1, NULL, 21);
INSERT INTO LUGAR (nombre, calle, numero, ciudad, pais, latitud, longitud, estado, id_categoria_principal, id_lugar_contenedor, id_cuenta_admin) VALUES ('Café Literario Retiro', 'Paseo de la Infanta', 'S/N', 'Madrid', 'España', 40.4111000, -3.6811000, 'Operativo', 2, 7, NULL); -- Dentro del Retiro
INSERT INTO LUGAR (nombre, calle, numero, ciudad, pais, latitud, longitud, estado, id_categoria_principal, id_lugar_contenedor, id_cuenta_admin) VALUES ('Viejo Almacén Histórico', 'Balcarce', '799', 'Buenos Aires', 'Argentina', -34.6181000, -58.3712000, 'Cerrado definitivamente', 9, NULL, NULL);

-- 7. TABLA: LUGAR_TELEFONO (Mínimo 15 registros)
INSERT INTO LUGAR_TELEFONO (id_lugar, telefono) VALUES (1, '+56229169200');
INSERT INTO LUGAR_TELEFONO (id_lugar, telefono) VALUES (1, '+56229169201');
INSERT INTO LUGAR_TELEFONO (id_lugar, telefono) VALUES (2, '+56222321822');
INSERT INTO LUGAR_TELEFONO (id_lugar, telefono) VALUES (3, '+525541628394');
INSERT INTO LUGAR_TELEFONO (id_lugar, telefono) VALUES (4, '+5717424242');
INSERT INTO LUGAR_TELEFONO (id_lugar, telefono) VALUES (5, '+56223344556');
INSERT INTO LUGAR_TELEFONO (id_lugar, telefono) VALUES (6, '+34913302800');
INSERT INTO LUGAR_TELEFONO (id_lugar, telefono) VALUES (8, '+541148123456');
INSERT INTO LUGAR_TELEFONO (id_lugar, telefono) VALUES (9, '+525599887766');
INSERT INTO LUGAR_TELEFONO (id_lugar, telefono) VALUES (10, '+56226108000');
INSERT INTO LUGAR_TELEFONO (id_lugar, telefono) VALUES (11, '+56229995544');
INSERT INTO LUGAR_TELEFONO (id_lugar, telefono) VALUES (12, '+51144556677');
INSERT INTO LUGAR_TELEFONO (id_lugar, telefono) VALUES (13, '+34915223344');
INSERT INTO LUGAR_TELEFONO (id_lugar, telefono) VALUES (14, '+34914445566');

-- 8. TABLA: LUGAR_WEB (Mínimo 15 registros)
INSERT INTO LUGAR_WEB (id_lugar, web) VALUES (1, 'www.costaneracenter.cl');
INSERT INTO LUGAR_WEB (id_lugar, web) VALUES (1, 'tiendas.costaneracenter.cl');
INSERT INTO LUGAR_WEB (id_lugar, web) VALUES (2, 'www.restaurantegiratorio.cl');
INSERT INTO LUGAR_WEB (id_lugar, web) VALUES (3, 'www.cafedelaesquina.mx');
INSERT INTO LUGAR_WEB (id_lugar, web) VALUES (4, 'www.hotelplazacentral.com.co');
INSERT INTO LUGAR_WEB (id_lugar, web) VALUES (5, 'www.bellaitaliapizza.cl');
INSERT INTO LUGAR_WEB (id_lugar, web) VALUES (6, 'www.museodelprado.es');
INSERT INTO LUGAR_WEB (id_lugar, web) VALUES (6, 'tienda.museodelprado.es');
INSERT INTO LUGAR_WEB (id_lugar, web) VALUES (7, 'www.madrid.es/retiro');
INSERT INTO LUGAR_WEB (id_lugar, web) VALUES (8, 'www.culturavivalibros.com.ar');
INSERT INTO LUGAR_WEB (id_lugar, web) VALUES (10, 'www.clinicalascondes.cl');
INSERT INTO LUGAR_WEB (id_lugar, web) VALUES (11, 'www.smartfit.cl/costanera');
INSERT INTO LUGAR_WEB (id_lugar, web) VALUES (12, 'www.boutiqueexclusiva.pe');
INSERT INTO LUGAR_WEB (id_lugar, web) VALUES (13, 'www.restauranteantiguomadrid.com');

-- 9. TABLA: LUGAR_CATEGORIA_SECUNDARIA (Mínimo 15 registros)
INSERT INTO LUGAR_CATEGORIA_SECUNDARIA (id_lugar, id_categoria) VALUES (1, 2); -- Costanera tiene Cafeterías
INSERT INTO LUGAR_CATEGORIA_SECUNDARIA (id_lugar, id_categoria) VALUES (1, 1); -- Costanera tiene Restaurantes
INSERT INTO LUGAR_CATEGORIA_SECUNDARIA (id_lugar, id_categoria) VALUES (1, 8); -- Costanera tiene Gimnasio
INSERT INTO LUGAR_CATEGORIA_SECUNDARIA (id_lugar, id_categoria) VALUES (2, 9); -- Giratorio es Bar también
INSERT INTO LUGAR_CATEGORIA_SECUNDARIA (id_lugar, id_categoria) VALUES (3, 6); -- Café vende Libros
INSERT INTO LUGAR_CATEGORIA_SECUNDARIA (id_lugar, id_categoria) VALUES (4, 1); -- Hotel tiene Restaurante
INSERT INTO LUGAR_CATEGORIA_SECUNDARIA (id_lugar, id_categoria) VALUES (4, 2); -- Hotel tiene Cafetería
INSERT INTO LUGAR_CATEGORIA_SECUNDARIA (id_lugar, id_categoria) VALUES (6, 5); -- Museo colinda/tiene jardines
INSERT INTO LUGAR_CATEGORIA_SECUNDARIA (id_lugar, id_categoria) VALUES (7, 4); -- Parque tiene estatuas/monumentos culturales
INSERT INTO LUGAR_CATEGORIA_SECUNDARIA (id_lugar, id_categoria) VALUES (8, 2); -- Librería tiene un Café adentro
INSERT INTO LUGAR_CATEGORIA_SECUNDARIA (id_lugar, id_categoria) VALUES (9, 1); -- Bar vende comida de Restaurante
INSERT INTO LUGAR_CATEGORIA_SECUNDARIA (id_lugar, id_categoria) VALUES (13, 9); -- Restaurante antiguo tiene Bar
INSERT INTO LUGAR_CATEGORIA_SECUNDARIA (id_lugar, id_categoria) VALUES (14, 6); -- Café literario tiene libros

-- 10. TABLA: HORARIO (Mínimo 15 registros, coherencia de horas garantizada)
INSERT INTO HORARIO (id_lugar, dia_semana, hora_apertura, hora_cierre) VALUES (1, 'Lunes', TO_TIMESTAMP('2026-01-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-01-01 22:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO HORARIO (id_lugar, dia_semana, hora_apertura, hora_cierre) VALUES (1, 'Martes', TO_TIMESTAMP('2026-01-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-01-01 22:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO HORARIO (id_lugar, dia_semana, hora_apertura, hora_cierre) VALUES (2, 'Lunes', TO_TIMESTAMP('2026-01-01 12:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-01-01 23:30:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO HORARIO (id_lugar, dia_semana, hora_apertura, hora_cierre) VALUES (3, 'Lunes', TO_TIMESTAMP('2026-01-01 07:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-01-01 20:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO HORARIO (id_lugar, dia_semana, hora_apertura, hora_cierre) VALUES (4, 'Todos', TO_TIMESTAMP('2026-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-01-01 23:59:59', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO HORARIO (id_lugar, dia_semana, hora_apertura, hora_cierre) VALUES (5, 'Lunes', TO_TIMESTAMP('2026-01-01 11:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-01-01 23:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO HORARIO (id_lugar, dia_semana, hora_apertura, hora_cierre) VALUES (6, 'Martes', TO_TIMESTAMP('2026-01-01 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-01-01 20:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO HORARIO (id_lugar, dia_semana, hora_apertura, hora_cierre) VALUES (7, 'Todos', TO_TIMESTAMP('2026-01-01 06:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-01-01 22:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO HORARIO (id_lugar, dia_semana, hora_apertura, hora_cierre) VALUES (8, 'Lunes', TO_TIMESTAMP('2026-01-01 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-01-01 21:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO HORARIO (id_lugar, dia_semana, hora_apertura, hora_cierre) VALUES (9, 'Viernes', TO_TIMESTAMP('2026-01-01 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-01-02 03:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO HORARIO (id_lugar, dia_semana, hora_apertura, hora_cierre) VALUES (10, 'Lunes', TO_TIMESTAMP('2026-01-01 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-01-01 20:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO HORARIO (id_lugar, dia_semana, hora_apertura, hora_cierre) VALUES (11, 'Lunes', TO_TIMESTAMP('2026-01-01 06:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-01-01 23:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO HORARIO (id_lugar, dia_semana, hora_apertura, hora_cierre) VALUES (12, 'Sábado', TO_TIMESTAMP('2026-01-01 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-01-01 21:00:00', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO HORARIO (id_lugar, dia_semana, hora_apertura, hora_cierre) VALUES (14, 'Miércoles', TO_TIMESTAMP('2026-01-01 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2026-01-01 19:00:00', 'YYYY-MM-DD HH24:MI:SS'));

-- 11. TABLA: FOTOGRAFIA (Mínimo 15 registros)
INSERT INTO FOTOGRAFIA (id_lugar, numero_foto, url_fotografia, fecha_tomada, fecha_subida, descripcion, id_cuenta_sube) VALUES (1, 1, 'http://images.com/costanera1.jpg', TO_DATE('2025-05-01', 'YYYY-MM-DD'), TO_DATE('2025-05-02', 'YYYY-MM-DD'), 'Vista panorámica exterior', 1);
INSERT INTO FOTOGRAFIA (id_lugar, numero_foto, url_fotografia, fecha_tomada, fecha_subida, descripcion, id_cuenta_sube) VALUES (1, 2, 'http://images.com/costanera2.jpg', TO_DATE('2025-05-03', 'YYYY-MM-DD'), TO_DATE('2025-05-03', 'YYYY-MM-DD'), 'Interior tiendas', 2);
INSERT INTO FOTOGRAFIA (id_lugar, numero_foto, url_fotografia, fecha_tomada, fecha_subida, descripcion, id_cuenta_sube) VALUES (2, 1, 'http://images.com/giratorio1.jpg', TO_DATE('2025-05-05', 'YYYY-MM-DD'), TO_DATE('2025-05-06', 'YYYY-MM-DD'), 'Plato principal filete', 3);
INSERT INTO FOTOGRAFIA (id_lugar, numero_foto, url_fotografia, fecha_tomada, fecha_subida, descripcion, id_cuenta_sube) VALUES (3, 1, 'http://images.com/cafe1.jpg', TO_DATE('2025-05-10', 'YYYY-MM-DD'), TO_DATE('2025-05-10', 'YYYY-MM-DD'), 'Fachada del café', 4);
INSERT INTO FOTOGRAFIA (id_lugar, numero_foto, url_fotografia, fecha_tomada, fecha_subida, descripcion, id_cuenta_sube) VALUES (4, 1, 'http://images.com/hotel1.jpg', TO_DATE('2025-05-12', 'YYYY-MM-DD'), TO_DATE('2025-05-12', 'YYYY-MM-DD'), 'Lobby principal', 5);
INSERT INTO FOTOGRAFIA (id_lugar, numero_foto, url_fotografia, fecha_tomada, fecha_subida, descripcion, id_cuenta_sube) VALUES (5, 1, 'http://images.com/pizza1.jpg', TO_DATE('2025-05-15', 'YYYY-MM-DD'), TO_DATE('2025-05-15', 'YYYY-MM-DD'), 'Pizza de Pepperoni', 6);
INSERT INTO FOTOGRAFIA (id_lugar, numero_foto, url_fotografia, fecha_tomada, fecha_subida, descripcion, id_cuenta_sube) VALUES (6, 1, 'http://images.com/prado1.jpg', TO_DATE('2025-05-20', 'YYYY-MM-DD'), TO_DATE('2025-05-21', 'YYYY-MM-DD'), 'Entrada de Goya', 8);
INSERT INTO FOTOGRAFIA (id_lugar, numero_foto, url_fotografia, fecha_tomada, fecha_subida, descripcion, id_cuenta_sube) VALUES (7, 1, 'http://images.com/retiro1.jpg', TO_DATE('2025-05-25', 'YYYY-MM-DD'), TO_DATE('2025-05-25', 'YYYY-MM-DD'), 'El estanque grande', 12);
INSERT INTO FOTOGRAFIA (id_lugar, numero_foto, url_fotografia, fecha_tomada, fecha_subida, descripcion, id_cuenta_sube) VALUES (8, 1, 'http://images.com/libros1.jpg', TO_DATE('2025-06-01', 'YYYY-MM-DD'), TO_DATE('2025-06-01', 'YYYY-MM-DD'), 'Estantería de novedades', 14);
INSERT INTO FOTOGRAFIA (id_lugar, numero_foto, url_fotografia, fecha_tomada, fecha_subida, descripcion, id_cuenta_sube) VALUES (9, 1, 'http://images.com/bar1.jpg', TO_DATE('2025-06-03', 'YYYY-MM-DD'), TO_DATE('2025-06-03', 'YYYY-MM-DD'), 'Barra de cocteles', 16);
INSERT INTO FOTOGRAFIA (id_lugar, numero_foto, url_fotografia, fecha_tomada, fecha_subida, descripcion, id_cuenta_sube) VALUES (10, 1, 'http://images.com/medica1.jpg', TO_DATE('2025-06-05', 'YYYY-MM-DD'), TO_DATE('2025-06-06', 'YYYY-MM-DD'), 'Sala de espera limpia', 20);
INSERT INTO FOTOGRAFIA (id_lugar, numero_foto, url_fotografia, fecha_tomada, fecha_subida, descripcion, id_cuenta_sube) VALUES (11, 1, 'http://images.com/gym1.jpg', TO_DATE('2025-06-10', 'YYYY-MM-DD'), TO_DATE('2025-06-10', 'YYYY-MM-DD'), 'Zona de máquinas de cardio', 1);
INSERT INTO FOTOGRAFIA (id_lugar, numero_foto, url_fotografia, fecha_tomada, fecha_subida, descripcion, id_cuenta_sube) VALUES (12, 1, 'http://images.com/boutique1.jpg', TO_DATE('2025-06-12', 'YYYY-MM-DD'), TO_DATE('2025-06-12', 'YYYY-MM-DD'), 'Vestidos de temporada', 2);
INSERT INTO FOTOGRAFIA (id_lugar, numero_foto, url_fotografia, fecha_tomada, fecha_subida, descripcion, id_cuenta_sube) VALUES (14, 1, 'http://images.com/cafelit1.jpg', TO_DATE('2025-06-15', 'YYYY-MM-DD'), TO_DATE('2025-06-15', 'YYYY-MM-DD'), 'Mesas al aire libre', 3);

-- 12. TABLA: RESENA (Mínimo 15-20 registros. IMPORTANTE: Evitar id_lugar=15 cerrado definitivamente, no id_cuenta=9 suspendida)
-- Reseñas con IDs generados secuencialmente. 
INSERT INTO RESENA (id_cuenta, id_lugar, puntaje, texto, fecha, idioma) VALUES (1, 1, 5, 'Excelente centro comercial, muy grande.', TO_DATE('2025-07-01', 'YYYY-MM-DD'), 'Español');
INSERT INTO RESENA (id_cuenta, id_lugar, puntaje, texto, fecha, idioma) VALUES (2, 2, 4, 'Muy linda vista panorámica, comida buena.', TO_DATE('2025-07-02', 'YYYY-MM-DD'), 'Español');
INSERT INTO RESENA (id_cuenta, id_lugar, puntaje, texto, fecha, idioma) VALUES (3, 3, 5, 'El café de especialidad estuvo increíble.', TO_DATE('2025-07-03', 'YYYY-MM-DD'), 'Español');
INSERT INTO RESENA (id_cuenta, id_lugar, puntaje, texto, fecha, idioma) VALUES (4, 4, 3, 'Servicio algo lento en recepción.', TO_DATE('2025-07-04', 'YYYY-MM-DD'), 'Español');
INSERT INTO RESENA (id_cuenta, id_lugar, puntaje, texto, fecha, idioma) VALUES (5, 5, 5, 'La masa e ingredientes de gran calidad.', TO_DATE('2025-07-05', 'YYYY-MM-DD'), 'Inglés');
INSERT INTO RESENA (id_cuenta, id_lugar, puntaje, texto, fecha, idioma) VALUES (6, 6, 5, 'Una colección de arte inigualable.', TO_DATE('2025-07-06', 'YYYY-MM-DD'), 'Español');
INSERT INTO RESENA (id_cuenta, id_lugar, puntaje, texto, fecha, idioma) VALUES (7, 7, 4, 'Ideal para pasear un fin de semana.', TO_DATE('2025-07-07', 'YYYY-MM-DD'), 'Español');
INSERT INTO RESENA (id_cuenta, id_lugar, puntaje, texto, fecha, idioma) VALUES (8, 8, 5, 'Gran variedad de libros y buen café.', TO_DATE('2025-07-08', 'YYYY-MM-DD'), 'Español');
INSERT INTO RESENA (id_cuenta, id_lugar, puntaje, texto, fecha, idioma) VALUES (10, 9, 4, 'Buen ambiente y música en vivo.', TO_DATE('2025-07-09', 'YYYY-MM-DD'), 'Español');
INSERT INTO RESENA (id_cuenta, id_lugar, puntaje, texto, fecha, idioma) VALUES (11, 10, 4, 'Atención profesional y rápida.', TO_DATE('2025-07-10', 'YYYY-MM-DD'), 'Español');
INSERT INTO RESENA (id_cuenta, id_lugar, puntaje, texto, fecha, idioma) VALUES (12, 11, 3, 'Demasiada gente en hora punta.', TO_DATE('2025-07-11', 'YYYY-MM-DD'), 'Español');
INSERT INTO RESENA (id_cuenta, id_lugar, puntaje, texto, fecha, idioma) VALUES (13, 12, 5, 'Ropa muy exclusiva y excelente atención.', TO_DATE('2025-07-12', 'YYYY-MM-DD'), 'Español');
INSERT INTO RESENA (id_cuenta, id_lugar, puntaje, texto, fecha, idioma) VALUES (14, 14, 4, 'Tranquilo y rodeado de naturaleza.', TO_DATE('2025-07-13', 'YYYY-MM-DD'), 'Portugués');
INSERT INTO RESENA (id_cuenta, id_lugar, puntaje, texto, fecha, idioma) VALUES (15, 1, 4, 'Estacionamiento costoso pero buen centro comercial.', TO_DATE('2025-07-14', 'YYYY-MM-DD'), 'Español');
INSERT INTO RESENA (id_cuenta, id_lugar, puntaje, texto, fecha, idioma) VALUES (16, 2, 5, 'Maravillosa experiencia en 360 grados.', TO_DATE('2025-07-15', 'YYYY-MM-DD'), 'Inglés');

-- 13. TABLA: ME_GUSTA (Mínimo 15-20 registros, respetando la regla No Auto-Like)
-- ID_RESENA va de 1 a 15 de acuerdo con las inserciones de arriba.
-- Verificamos autores para evitar auto-likes:
-- R1: autor=1. R2: autor=2. R3: autor=3. R4: autor=4. R5: autor=5. R6: autor=6. R7: autor=7. R8: autor=8. R9: autor=10. R10: autor=11. R11: autor=12. R12: autor=13. R13: autor=14. R14: autor=15. R15: autor=16.
INSERT INTO ME_GUSTA (id_cuenta_mg, id_resena, fecha) VALUES (2, 1, TO_DATE('2025-07-02', 'YYYY-MM-DD'));
INSERT INTO ME_GUSTA (id_cuenta_mg, id_resena) VALUES (3, 1);
INSERT INTO ME_GUSTA (id_cuenta_mg, id_resena, fecha) VALUES (1, 2, TO_DATE('2025-07-03', 'YYYY-MM-DD'));
INSERT INTO ME_GUSTA (id_cuenta_mg, id_resena, fecha) VALUES (4, 3, TO_DATE('2025-07-04', 'YYYY-MM-DD'));
INSERT INTO ME_GUSTA (id_cuenta_mg, id_resena, fecha) VALUES (5, 3, TO_DATE('2025-07-05', 'YYYY-MM-DD'));
INSERT INTO ME_GUSTA (id_cuenta_mg, id_resena, fecha) VALUES (2, 4, TO_DATE('2025-07-05', 'YYYY-MM-DD'));
INSERT INTO ME_GUSTA (id_cuenta_mg, id_resena, fecha) VALUES (1, 5, TO_DATE('2025-07-06', 'YYYY-MM-DD'));
INSERT INTO ME_GUSTA (id_cuenta_mg, id_resena, fecha) VALUES (8, 6, TO_DATE('2025-07-07', 'YYYY-MM-DD'));
INSERT INTO ME_GUSTA (id_cuenta_mg, id_resena, fecha) VALUES (12, 7, TO_DATE('2025-07-08', 'YYYY-MM-DD'));
INSERT INTO ME_GUSTA (id_cuenta_mg, id_resena, fecha) VALUES (14, 8, TO_DATE('2025-07-09', 'YYYY-MM-DD'));
INSERT INTO ME_GUSTA (id_cuenta_mg, id_resena, fecha) VALUES (3, 9, TO_DATE('2025-07-10', 'YYYY-MM-DD'));
INSERT INTO ME_GUSTA (id_cuenta_mg, id_resena, fecha) VALUES (4, 10, TO_DATE('2025-07-11', 'YYYY-MM-DD'));
INSERT INTO ME_GUSTA (id_cuenta_mg, id_resena, fecha) VALUES (5, 11, TO_DATE('2025-07-12', 'YYYY-MM-DD'));
INSERT INTO ME_GUSTA (id_cuenta_mg, id_resena, fecha) VALUES (6, 12, TO_DATE('2025-07-13', 'YYYY-MM-DD'));
INSERT INTO ME_GUSTA (id_cuenta_mg, id_resena, fecha) VALUES (1, 14, TO_DATE('2025-07-15', 'YYYY-MM-DD'));

-- 14. TABLA: RESPUESTA (Mínimo 5-10 registros, solo propietario asignado al lugar puede responder, fecha posterior o igual a reseña)
-- Reseñas asignadas a lugares con administradores:
-- R2 (id_resena=2) -> id_lugar=2 -> admin=7. Fecha reseña: 2025-07-02
-- R3 (id_resena=3) -> id_lugar=3 -> admin=11. Fecha reseña: 2025-07-03
-- R4 (id_resena=4) -> id_lugar=4 -> admin=13. Fecha reseña: 2025-07-04
-- R5 (id_resena=5) -> id_lugar=5 -> admin=15. Fecha reseña: 2025-07-05
-- R9 (id_resena=9) -> id_lugar=9 -> admin=17. Fecha reseña: 2025-07-09
-- R10 (id_resena=10) -> id_lugar=10 -> admin=25. Fecha reseña: 2025-07-10
-- R11 (id_resena=11) -> id_lugar=11 -> admin=29. Fecha reseña: 2025-07-11
-- R12 (id_resena=12) -> id_lugar=12 -> admin=23. Fecha reseña: 2025-07-12
INSERT INTO RESPUESTA (id_resena, id_cuenta_prop, texto, fecha_publicacion) VALUES (2, 7, 'Muchas gracias por su visita, nos alegra que disfrutara la hermosa vista.', TO_DATE('2025-07-03', 'YYYY-MM-DD'));
INSERT INTO RESPUESTA (id_resena, id_cuenta_prop, texto, fecha_publicacion) VALUES (3, 11, 'Agradecemos su comentario, trabajamos duro para ofrecer el mejor café.', TO_DATE('2025-07-04', 'YYYY-MM-DD'));
INSERT INTO RESPUESTA (id_resena, id_cuenta_prop, texto, fecha_publicacion) VALUES (4, 13, 'Lamentamos el inconveniente en la recepción, tomaremos medidas de mejora.', TO_DATE('2025-07-06', 'YYYY-MM-DD'));
INSERT INTO RESPUESTA (id_resena, id_cuenta_prop, texto, fecha_publicacion) VALUES (5, 15, 'Thank you! We always look forward to serving you high-quality pizza.', TO_DATE('2025-07-05', 'YYYY-MM-DD'));
INSERT INTO RESPUESTA (id_resena, id_cuenta_prop, texto, fecha_publicacion) VALUES (9, 17, '¡Qué bueno que te gustara la música! Te esperamos el próximo fin de semana.', TO_DATE('2025-07-10', 'YYYY-MM-DD'));
INSERT INTO RESPUESTA (id_resena, id_cuenta_prop, texto, fecha_publicacion) VALUES (10, 25, 'Gracias por confiar en nuestros profesionales de salud.', TO_DATE('2025-07-11', 'YYYY-MM-DD'));
INSERT INTO RESPUESTA (id_resena, id_cuenta_prop, texto, fecha_publicacion) VALUES (11, 29, 'Agradecemos el feedback, estamos optimizando el control de aforo.', TO_DATE('2025-07-12', 'YYYY-MM-DD'));
INSERT INTO RESPUESTA (id_resena, id_cuenta_prop, texto, fecha_publicacion) VALUES (12, 23, 'Nos alegra que los diseños exclusivos hayan sido de todo su agrado.', TO_DATE('2025-07-13', 'YYYY-MM-DD'));

COMMIT;
