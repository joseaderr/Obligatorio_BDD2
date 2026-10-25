-- ============================================================================
-- CASOS DE PRUEBA - REQUERIMIENTO 2.5
-- PRC_INGRESAR_RESENA(param_id_cuenta, param_id_lugar, param_descripcion, param_idioma, param_puntos, puntaje_avg OUT)
-- ============================================================================
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
SET SERVEROUTPUT ON;

-- ===== INICIANDO PRUEBAS REQUERIMIENTO 2.5 =====

-- ---------------------------------------------------------------------------
-- CASO 1: Cuenta NULL o no existe -> Debe retornar error -20030
-- ---------------------------------------------------------------------------
DECLARE
  v_avg LUGAR.puntos%TYPE;
BEGIN
  PRC_INGRESAR_RESENA(NULL, 1, 'Buena experiencia', 'Español', 4, v_avg);
  DBMS_OUTPUT.PUT_LINE('ERROR: se esperaba excepción -20030 y no ocurrió');
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE = -20030 THEN
      DBMS_OUTPUT.PUT_LINE('TODO OK - CASO 1a: param_id_cuenta NULL');
    ELSE
      DBMS_OUTPUT.PUT_LINE('ERROR: se esperaba -20030, se obtuvo ' || SQLCODE || ' - ' || SQLERRM);
    END IF;
END;
/

DECLARE
  v_avg LUGAR.puntos%TYPE;
BEGIN
  PRC_INGRESAR_RESENA(99999, 1, 'Buena experiencia', 'Español', 4, v_avg);
  DBMS_OUTPUT.PUT_LINE('ERROR: se esperaba excepción -20030 y no ocurrió');
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE = -20030 THEN
      DBMS_OUTPUT.PUT_LINE('TODO OK - CASO 1b: Cuenta no existe');
    ELSE
      DBMS_OUTPUT.PUT_LINE('ERROR: se esperaba -20030, se obtuvo ' || SQLCODE || ' - ' || SQLERRM);
    END IF;
END;
/

-- ---------------------------------------------------------------------------
-- CASO 2: Lugar NULL o no existe -> Debe retornar error -20031
-- ---------------------------------------------------------------------------
DECLARE
  v_avg LUGAR.puntos%TYPE;
BEGIN
  PRC_INGRESAR_RESENA(1, NULL, 'Buena experiencia', 'Español', 4, v_avg);
  DBMS_OUTPUT.PUT_LINE('ERROR: se esperaba excepción -20031 y no ocurrió');
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE = -20031 THEN
      DBMS_OUTPUT.PUT_LINE('TODO OK - CASO 2a: param_id_lugar NULL');
    ELSE
      DBMS_OUTPUT.PUT_LINE('ERROR: se esperaba -20031, se obtuvo ' || SQLCODE || ' - ' || SQLERRM);
    END IF;
END;
/

DECLARE
  v_avg LUGAR.puntos%TYPE;
BEGIN
  PRC_INGRESAR_RESENA(1, 99999, 'Buena experiencia', 'Español', 4, v_avg);
  DBMS_OUTPUT.PUT_LINE('ERROR: se esperaba excepción -20031 y no ocurrió');
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE = -20031 THEN
      DBMS_OUTPUT.PUT_LINE('TODO OK - CASO 2b: Lugar no existe');
    ELSE
      DBMS_OUTPUT.PUT_LINE('ERROR: se esperaba -20031, se obtuvo ' || SQLCODE || ' - ' || SQLERRM);
    END IF;
END;
/

-- ---------------------------------------------------------------------------
-- CASO 3: Descripción NULL o vacía -> Debe retornar error -20033
-- ---------------------------------------------------------------------------
DECLARE
  v_avg LUGAR.puntos%TYPE;
BEGIN
  PRC_INGRESAR_RESENA(1, 7, NULL, 'Español', 4, v_avg);
  DBMS_OUTPUT.PUT_LINE('ERROR: se esperaba excepción -20033 y no ocurrió');
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE = -20033 THEN
      DBMS_OUTPUT.PUT_LINE('TODO OK - CASO 3a: Descripción NULL');
    ELSE
      DBMS_OUTPUT.PUT_LINE('ERROR: se esperaba -20033, se obtuvo ' || SQLCODE || ' - ' || SQLERRM);
    END IF;
END;
/

DECLARE
  v_avg LUGAR.puntos%TYPE;
BEGIN
  PRC_INGRESAR_RESENA(1, 7, '', 'Español', 4, v_avg);
  DBMS_OUTPUT.PUT_LINE('ERROR: se esperaba excepción -20033 y no ocurrió');
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE = -20033 THEN
      DBMS_OUTPUT.PUT_LINE('TODO OK - CASO 3b: Descripción vacía');
    ELSE
      DBMS_OUTPUT.PUT_LINE('ERROR: se esperaba -20033, se obtuvo ' || SQLCODE || ' - ' || SQLERRM);
    END IF;
END;
/

DECLARE
  v_avg LUGAR.puntos%TYPE;
BEGIN
  PRC_INGRESAR_RESENA(1, 7, '   ', 'Español', 4, v_avg);
  DBMS_OUTPUT.PUT_LINE('ERROR: se esperaba excepción -20033 y no ocurrió');
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE = -20033 THEN
      DBMS_OUTPUT.PUT_LINE('TODO OK - CASO 3c: Descripción con solo espacios');
    ELSE
      DBMS_OUTPUT.PUT_LINE('ERROR: se esperaba -20033, se obtuvo ' || SQLCODE || ' - ' || SQLERRM);
    END IF;
END;
/

-- ---------------------------------------------------------------------------
-- CASO 4: Puntos NULL, menor a 1 o mayor a 5 -> Debe retornar error -20032
-- ---------------------------------------------------------------------------
DECLARE
  v_avg LUGAR.puntos%TYPE;
BEGIN
  PRC_INGRESAR_RESENA(1, 7, 'Muy bueno', 'Español', NULL, v_avg);
  DBMS_OUTPUT.PUT_LINE('ERROR: se esperaba excepción -20032 y no ocurrió');
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE = -20032 THEN
      DBMS_OUTPUT.PUT_LINE('TODO OK - CASO 4a: Puntos NULL');
    ELSE
      DBMS_OUTPUT.PUT_LINE('ERROR: se esperaba -20032, se obtuvo ' || SQLCODE || ' - ' || SQLERRM);
    END IF;
END;
/

DECLARE
  v_avg LUGAR.puntos%TYPE;
BEGIN
  PRC_INGRESAR_RESENA(1, 7, 'Muy bueno', 'Español', 0, v_avg);
  DBMS_OUTPUT.PUT_LINE('ERROR: se esperaba excepción -20032 y no ocurrió');
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE = -20032 THEN
      DBMS_OUTPUT.PUT_LINE('TODO OK - CASO 4b: Puntos = 0');
    ELSE
      DBMS_OUTPUT.PUT_LINE('ERROR: se esperaba -20032, se obtuvo ' || SQLCODE || ' - ' || SQLERRM);
    END IF;
END;
/

DECLARE
  v_avg LUGAR.puntos%TYPE;
BEGIN
  PRC_INGRESAR_RESENA(1, 7, 'Muy bueno', 'Español', 6, v_avg);
  DBMS_OUTPUT.PUT_LINE('ERROR: se esperaba excepción -20032 y no ocurrió');
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE = -20032 THEN
      DBMS_OUTPUT.PUT_LINE('TODO OK - CASO 4c: Puntos = 6');
    ELSE
      DBMS_OUTPUT.PUT_LINE('ERROR: se esperaba -20032, se obtuvo ' || SQLCODE || ' - ' || SQLERRM);
    END IF;
END;
/

-- ---------------------------------------------------------------------------
-- CASO 5: Idioma NULL o vacío -> Debe retornar error -20034
-- ---------------------------------------------------------------------------
DECLARE
  v_avg LUGAR.puntos%TYPE;
BEGIN
  PRC_INGRESAR_RESENA(1, 7, 'Muy bueno', NULL, 4, v_avg);
  DBMS_OUTPUT.PUT_LINE('ERROR: se esperaba excepción -20034 y no ocurrió');
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE = -20034 THEN
      DBMS_OUTPUT.PUT_LINE('TODO OK - CASO 5a: Idioma NULL');
    ELSE
      DBMS_OUTPUT.PUT_LINE('ERROR: se esperaba -20034, se obtuvo ' || SQLCODE || ' - ' || SQLERRM);
    END IF;
END;
/

DECLARE
  v_avg LUGAR.puntos%TYPE;
BEGIN
  PRC_INGRESAR_RESENA(1, 7, 'Muy bueno', '', 4, v_avg);
  DBMS_OUTPUT.PUT_LINE('ERROR: se esperaba excepción -20034 y no ocurrió');
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE = -20034 THEN
      DBMS_OUTPUT.PUT_LINE('TODO OK - CASO 5b: Idioma vacío');
    ELSE
      DBMS_OUTPUT.PUT_LINE('ERROR: se esperaba -20034, se obtuvo ' || SQLCODE || ' - ' || SQLERRM);
    END IF;
END;
/

DECLARE
  v_avg LUGAR.puntos%TYPE;
BEGIN
  PRC_INGRESAR_RESENA(1, 7, 'Muy bueno', '   ', 4, v_avg);
  DBMS_OUTPUT.PUT_LINE('ERROR: se esperaba excepción -20034 y no ocurrió');
EXCEPTION
  WHEN OTHERS THEN
    IF SQLCODE = -20034 THEN
      DBMS_OUTPUT.PUT_LINE('TODO OK - CASO 5c: Idioma con solo espacios');
    ELSE
      DBMS_OUTPUT.PUT_LINE('ERROR: se esperaba -20034, se obtuvo ' || SQLCODE || ' - ' || SQLERRM);
    END IF;
END;
/

-- ---------------------------------------------------------------------------
-- CASO 6: Inserción exitosa de nueva reseña
-- ---------------------------------------------------------------------------
DECLARE
  v_avg          LUGAR.puntos%TYPE;
  v_count_antes  NUMBER;
  v_count_despues NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_count_antes FROM RESENA WHERE id_cuenta = 18 AND id_lugar = 14;

  PRC_INGRESAR_RESENA(18, 14, 'Hermoso lugar para pasear con familia', 'Español', 5, v_avg);

  SELECT COUNT(*) INTO v_count_despues FROM RESENA WHERE id_cuenta = 18 AND id_lugar = 14;

  IF v_count_antes = 0 AND v_count_despues = 1 AND v_avg IS NOT NULL THEN
    DBMS_OUTPUT.PUT_LINE('TODO OK - CASO 6: Inserción exitosa de nueva reseña (puntaje_avg=' || v_avg || ')');
  ELSE
    DBMS_OUTPUT.PUT_LINE('ERROR: inserción de reseña falló. Antes: ' || v_count_antes || ', Después: ' || v_count_despues);
  END IF;
END;
/

-- ---------------------------------------------------------------------------
-- CASO 7: Upsert - Actualización de reseña existente
-- ---------------------------------------------------------------------------
DECLARE
  v_avg            LUGAR.puntos%TYPE;
  v_puntaje_antes  RESENA.puntaje%TYPE;
  v_puntaje_despues RESENA.puntaje%TYPE;
  v_count          NUMBER;
BEGIN
  SELECT puntaje INTO v_puntaje_antes FROM RESENA WHERE id_cuenta = 18 AND id_lugar = 14;

  PRC_INGRESAR_RESENA(18, 14, 'Lugar bonito pero con mucha gente', 'Español', 3, v_avg);

  SELECT puntaje INTO v_puntaje_despues FROM RESENA WHERE id_cuenta = 18 AND id_lugar = 14;
  SELECT COUNT(*) INTO v_count FROM RESENA WHERE id_cuenta = 18 AND id_lugar = 14;

  IF v_count = 1 AND v_puntaje_antes = 5 AND v_puntaje_despues = 3 AND v_avg IS NOT NULL THEN
    DBMS_OUTPUT.PUT_LINE('TODO OK - CASO 7: Upsert/actualización exitosa (puntaje_avg=' || v_avg || ')');
  ELSE
    DBMS_OUTPUT.PUT_LINE('ERROR: upsert falló. Antes: ' || v_puntaje_antes || ', Después: ' || v_puntaje_despues || ', Registros: ' || v_count);
  END IF;

  -- Limpiar reseña de prueba
  DELETE FROM RESENA WHERE id_cuenta = 18 AND id_lugar = 14;
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

-- ===== FIN PRUEBAS REQUERIMIENTO 2.5 =====
