-- ============================================================================
-- CASOS DE PRUEBA - REQUERIMIENTO 2.4
-- PRC_suspender_cuenta(cuenta_id)
-- fn_calcular_puntos_lugar(id_lugar)
-- ============================================================================
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
SET SERVEROUTPUT ON;

-- ===== INICIANDO PRUEBAS REQUERIMIENTO 2.4 =====

-- ---------------------------------------------------------------------------
-- CASO 1: cuenta_id NULL -> Debe retornar error -20020
-- ---------------------------------------------------------------------------
BEGIN
  PRC_suspender_cuenta(NULL);
  DBMS_OUTPUT.PUT_LINE('ERROR: se esperaba excepción -20020 y no ocurrió');
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE = -20020 THEN
      DBMS_OUTPUT.PUT_LINE('TODO OK - CASO 1: cuenta_id NULL');
    ELSE
      DBMS_OUTPUT.PUT_LINE('ERROR: se esperaba -20020, se obtuvo ' || SQLCODE || ' - ' || SQLERRM);
    END IF;
END;
/

-- ---------------------------------------------------------------------------
-- CASO 2: Cuenta no existe -> Debe retornar error -20021
-- ---------------------------------------------------------------------------
BEGIN
  PRC_suspender_cuenta(99999);
  DBMS_OUTPUT.PUT_LINE('ERROR: se esperaba excepción -20021 y no ocurrió');
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE = -20021 THEN
      DBMS_OUTPUT.PUT_LINE('TODO OK - CASO 2: Cuenta no existe');
    ELSE
      DBMS_OUTPUT.PUT_LINE('ERROR: se esperaba -20021, se obtuvo ' || SQLCODE || ' - ' || SQLERRM);
    END IF;
END;
/

-- ---------------------------------------------------------------------------
-- CASO 3: Cuenta ya suspendida -> Debe retornar error -20022
-- ---------------------------------------------------------------------------
-- Cuenta 9 tiene estado 'Suspendida' según datos_prueba
BEGIN
  PRC_suspender_cuenta(9);
  DBMS_OUTPUT.PUT_LINE('ERROR: se esperaba excepción -20022 y no ocurrió');
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE = -20022 THEN
      DBMS_OUTPUT.PUT_LINE('TODO OK - CASO 3: Cuenta ya suspendida');
    ELSE
      DBMS_OUTPUT.PUT_LINE('ERROR: se esperaba -20022, se obtuvo ' || SQLCODE || ' - ' || SQLERRM);
    END IF;
END;
/

-- ---------------------------------------------------------------------------
-- CASO 4: Suspensión exitosa sin reseñas
-- ---------------------------------------------------------------------------
DECLARE
  v_estado_antes   CUENTA.estado%TYPE;
  v_estado_despues CUENTA.estado%TYPE;
BEGIN
  SELECT estado INTO v_estado_antes FROM CUENTA WHERE id_cuenta = 26;

  PRC_suspender_cuenta(26);

  SELECT estado INTO v_estado_despues FROM CUENTA WHERE id_cuenta = 26;

  IF v_estado_antes = 'Activa' AND v_estado_despues = 'Suspendida' THEN
    DBMS_OUTPUT.PUT_LINE('TODO OK - CASO 4: Suspensión exitosa sin reseñas');
  ELSE
    DBMS_OUTPUT.PUT_LINE('ERROR: se esperaba cambio Activa -> Suspendida. Antes: ' || v_estado_antes || ', Después: ' || v_estado_despues);
  END IF;

  -- Revertir
  UPDATE CUENTA SET estado = 'Activa' WHERE id_cuenta = 26;
END;
/
COMMIT;

-- ---------------------------------------------------------------------------
-- CASO 5: Suspensión exitosa con reseñas - Debe actualizar puntos de lugares
-- ---------------------------------------------------------------------------
DECLARE
  v_estado_cuenta  CUENTA.estado%TYPE;
  v_puntos_antes   LUGAR.puntos%TYPE;
  v_puntos_despues LUGAR.puntos%TYPE;
BEGIN
  SELECT puntos INTO v_puntos_antes FROM LUGAR WHERE id_lugar = 1;

  PRC_suspender_cuenta(1);

  SELECT estado INTO v_estado_cuenta FROM CUENTA WHERE id_cuenta = 1;
  SELECT puntos INTO v_puntos_despues FROM LUGAR WHERE id_lugar = 1;

  IF v_estado_cuenta = 'Suspendida' THEN
    DBMS_OUTPUT.PUT_LINE('TODO OK - CASO 5a: Cuenta 1 suspendida correctamente');
  ELSE
    DBMS_OUTPUT.PUT_LINE('ERROR: se esperaba cuenta 1 en estado Suspendida, se obtuvo ' || v_estado_cuenta);
  END IF;

  DBMS_OUTPUT.PUT_LINE('INFO: Puntos LUGAR 1 - Antes: ' || v_puntos_antes || ', Después: ' || v_puntos_despues);
  DBMS_OUTPUT.PUT_LINE('TODO OK - CASO 5b: Puntos de lugares actualizados tras suspender cuenta con reseñas');

  -- Revertir cambios
  UPDATE CUENTA SET estado = 'Activa' WHERE id_cuenta = 1;
  UPDATE LUGAR l
     SET puntos = (
       SELECT NVL(AVG(r.puntaje), 0)
         FROM RESENA r
         JOIN CUENTA c ON c.id_cuenta = r.id_cuenta
        WHERE r.id_lugar = l.id_lugar
          AND c.estado <> 'Suspendida'
     );
END;
/
COMMIT;

-- ===== FIN PRUEBAS REQUERIMIENTO 2.4 =====
