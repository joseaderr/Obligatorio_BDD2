-- ============================================================================
-- CASOS DE PRUEBA - REQUERIMIENTO 2.2
-- PRC_transferir_titularidad(lugar_id, cuenta_id_destino, cuenta_id_origen)
-- ============================================================================
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
SET SERVEROUTPUT ON;

-- ===== INICIANDO PRUEBAS REQUERIMIENTO 2.2 =====

-- ---------------------------------------------------------------------------
-- CASO 1: lugar_id NULL -> Debe retornar error -20010
-- ---------------------------------------------------------------------------
BEGIN
  PRC_transferir_titularidad(NULL, 11, 7);
  DBMS_OUTPUT.PUT_LINE('ERROR: se esperaba excepción -20010 y no ocurrió');
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE = -20010 THEN
      DBMS_OUTPUT.PUT_LINE('TODO OK - CASO 1: lugar_id NULL');
    ELSE
      DBMS_OUTPUT.PUT_LINE('ERROR: se esperaba -20010, se obtuvo ' || SQLCODE || ' - ' || SQLERRM);
    END IF;
END;
/

-- ---------------------------------------------------------------------------
-- CASO 2: cuenta_id_destino NULL -> Debe retornar error -20011
-- ---------------------------------------------------------------------------
BEGIN
  PRC_transferir_titularidad(2, NULL, 7);
  DBMS_OUTPUT.PUT_LINE('ERROR: se esperaba excepción -20011 y no ocurrió');
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE = -20011 THEN
      DBMS_OUTPUT.PUT_LINE('TODO OK - CASO 2: cuenta_id_destino NULL');
    ELSE
      DBMS_OUTPUT.PUT_LINE('ERROR: se esperaba -20011, se obtuvo ' || SQLCODE || ' - ' || SQLERRM);
    END IF;
END;
/

-- ---------------------------------------------------------------------------
-- CASO 3: cuenta_id_origen NULL -> Debe retornar error -20012
-- ---------------------------------------------------------------------------
BEGIN
  PRC_transferir_titularidad(2, 11, NULL);
  DBMS_OUTPUT.PUT_LINE('ERROR: se esperaba excepción -20012 y no ocurrió');
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE = -20012 THEN
      DBMS_OUTPUT.PUT_LINE('TODO OK - CASO 3: cuenta_id_origen NULL');
    ELSE
      DBMS_OUTPUT.PUT_LINE('ERROR: se esperaba -20012, se obtuvo ' || SQLCODE || ' - ' || SQLERRM);
    END IF;
END;
/

-- ---------------------------------------------------------------------------
-- CASO 4: Lugar sin administrador actual -> Debe retornar error -20013
-- ---------------------------------------------------------------------------
-- LUGAR 1 (Mall Costanera Center) tiene id_cuenta_admin NULL según datos_prueba
BEGIN
  PRC_transferir_titularidad(1, 11, 7);
  DBMS_OUTPUT.PUT_LINE('ERROR: se esperaba excepción -20013 y no ocurrió');
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE = -20013 THEN
      DBMS_OUTPUT.PUT_LINE('TODO OK - CASO 4: Lugar sin administrador');
    ELSE
      DBMS_OUTPUT.PUT_LINE('ERROR: se esperaba -20013, se obtuvo ' || SQLCODE || ' - ' || SQLERRM);
    END IF;
END;
/

-- ---------------------------------------------------------------------------
-- CASO 5: Cuenta de origen no es propietaria del lugar -> Debe retornar error -20015
-- ---------------------------------------------------------------------------
-- LUGAR 2 tiene admin 7. Intentamos transferir con cuenta_id_origen = 11
BEGIN
  PRC_transferir_titularidad(2, 13, 11);
  DBMS_OUTPUT.PUT_LINE('ERROR: se esperaba excepción -20015 y no ocurrió');
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE = -20015 THEN
      DBMS_OUTPUT.PUT_LINE('TODO OK - CASO 5: Cuenta de origen no es propietaria');
    ELSE
      DBMS_OUTPUT.PUT_LINE('ERROR: se esperaba -20015, se obtuvo ' || SQLCODE || ' - ' || SQLERRM);
    END IF;
END;
/

-- ---------------------------------------------------------------------------
-- CASO 6: Cuenta de destino no ha sido verificada como propietaria -> Debe retornar error -20014
-- ---------------------------------------------------------------------------
INSERT INTO CUENTA (email, nombre, pais, idioma, fecha_creacion, estado) 
VALUES ('propietario.sinverif@test.com', 'Propietario Sin Verificar', 'Chile', 'Español', SYSDATE, 'Activa');

INSERT INTO CUENTA_PROPIETARIA (id_cuenta, rut, razon_social, metodo_verificacion, fecha_verificacion)
VALUES ((SELECT id_cuenta FROM CUENTA WHERE email = 'propietario.sinverif@test.com'), '123456789012', 'Sin Verificar Spa', 'Postal', NULL);

DECLARE
  v_cuenta_destino CUENTA.ID_CUENTA%TYPE;
BEGIN
  SELECT id_cuenta
    INTO v_cuenta_destino
    FROM CUENTA
   WHERE email = 'propietario.sinverif@test.com';

  BEGIN
    PRC_transferir_titularidad(2, v_cuenta_destino, 7);
    DBMS_OUTPUT.PUT_LINE('ERROR: se esperaba excepción -20014 y no ocurrió');
  EXCEPTION
    WHEN OTHERS THEN
      IF SQLCODE = -20014 THEN
        DBMS_OUTPUT.PUT_LINE('TODO OK - CASO 6: Cuenta de destino sin fecha de verificación');
      ELSE
        DBMS_OUTPUT.PUT_LINE('ERROR: se esperaba -20014, se obtuvo ' || SQLCODE || ' - ' || SQLERRM);
      END IF;
  END;
END;
/

-- ---------------------------------------------------------------------------
-- CASO 7: Transferencia exitosa
-- ---------------------------------------------------------------------------
DECLARE
  v_admin_antes  LUGAR.id_cuenta_admin%TYPE;
  v_admin_despues LUGAR.id_cuenta_admin%TYPE;
BEGIN
  SELECT id_cuenta_admin INTO v_admin_antes FROM LUGAR WHERE id_lugar = 3;

  PRC_transferir_titularidad(3, 13, 11);

  SELECT id_cuenta_admin INTO v_admin_despues FROM LUGAR WHERE id_lugar = 3;

  IF v_admin_antes = 11 AND v_admin_despues = 13 THEN
    DBMS_OUTPUT.PUT_LINE('TODO OK - CASO 7: Transferencia exitosa');
  ELSE
    DBMS_OUTPUT.PUT_LINE('ERROR: se esperaba que el admin cambiara de 11 a 13. Antes: ' || v_admin_antes || ', Después: ' || v_admin_despues);
  END IF;

  -- Revertir cambio para no afectar otros tests
  UPDATE LUGAR SET id_cuenta_admin = 11 WHERE id_lugar = 3;
END;
/
COMMIT;

-- Limpieza de datos de prueba
DELETE FROM CUENTA_PROPIETARIA WHERE id_cuenta = (SELECT id_cuenta FROM CUENTA WHERE email = 'propietario.sinverif@test.com');
DELETE FROM CUENTA WHERE email = 'propietario.sinverif@test.com';
COMMIT;

-- ===== FIN PRUEBAS REQUERIMIENTO 2.2 =====
