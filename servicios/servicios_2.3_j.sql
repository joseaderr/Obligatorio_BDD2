CREATE OR REPLACE PROCEDURE SP_SUBIR_FOTOGRAFIA (
    p_id_lugar        IN FOTOGRAFIA.id_lugar%TYPE,
    p_id_cuenta_sube  IN FOTOGRAFIA.id_cuenta_sube%TYPE,
    p_url_fotografia  IN FOTOGRAFIA.url_fotografia%TYPE,
    p_fecha_tomada    IN FOTOGRAFIA.fecha_tomada%TYPE DEFAULT NULL,
    p_descripcion     IN FOTOGRAFIA.descripcion%TYPE DEFAULT NULL,
    p_numero_asignado OUT FOTOGRAFIA.numero_foto%TYPE -- Devuelve el correlativo calculado
) AS
    v_id_lugar_bloqueado LUGAR.id_lugar%TYPE;
    v_existe_cuenta NUMBER;
BEGIN
    -- 1. Validar que el lugar exista y bloquearlo temporalmente (FOR UPDATE) 
    -- para evitar conflictos de concurrencia al calcular el número correlativo.
    BEGIN
        SELECT id_lugar INTO v_id_lugar_bloqueado
        FROM LUGAR
        WHERE id_lugar = p_id_lugar
        FOR UPDATE;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20020, 'Error: El lugar especificado no existe.');
    END;

    -- 2. Validar que la cuenta que sube la foto exista (si se proporciona)
    IF p_id_cuenta_sube IS NOT NULL THEN
        SELECT COUNT(1) INTO v_existe_cuenta 
        FROM CUENTA 
        WHERE id_cuenta = p_id_cuenta_sube;
        
        IF v_existe_cuenta = 0 THEN
            RAISE_APPLICATION_ERROR(-20021, 'Error: La cuenta especificada no existe.');
        END IF;
    END IF;

    -- 3. Calcular el número correlativo para este lugar específico
    -- Busca el max número de foto actual para el lugar y le suma 1 (si no hay, empieza en 1)
    SELECT NVL(MAX(numero_foto), 0) + 1 
    INTO p_numero_asignado 
    FROM FOTOGRAFIA 
    WHERE id_lugar = p_id_lugar;

    -- 4. Insertar la fotografía con el número correlativo calculado
    INSERT INTO FOTOGRAFIA (
        id_lugar,
        numero_foto,
        url_fotografia,
        fecha_tomada,
        fecha_subida,
        descripcion,
        id_cuenta_sube
    ) VALUES (
        p_id_lugar,
        p_numero_asignado,
        p_url_fotografia,
        p_fecha_tomada,
        TRUNC(SYSDATE),
        p_descripcion,
        p_id_cuenta_sube
    );

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Foto subida con éxito. Lugar ID: ' || p_id_lugar || ' | N° de Foto asignado: ' || p_numero_asignado);

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END SP_SUBIR_FOTOGRAFIA;
/
-- prueba invocación del procedimiento
DECLARE
    v_nro_foto_generado NUMBER;
BEGIN
    SP_SUBIR_FOTOGRAFIA(
        p_id_lugar       => 1,                               -- ID del lugar al que se le sube la foto
        p_id_cuenta_sube => 10,                              -- ID de la cuenta que sube la foto
        p_url_fotografia => 'https://ejemplo.com/fotos/lugar1_img1.jpg',
        p_fecha_tomada   => TO_DATE('2026-10-05', 'YYYY-MM-DD'), -- Opcional
        p_descripcion    => 'Vista frontal del local principal', -- Opcional
        p_numero_asignado => v_nro_foto_generado             -- Recibe el correlativo (ej. 1, 2, 3...)
    );
    
    DBMS_OUTPUT.PUT_LINE('El número de foto asignado fue: ' || v_nro_foto_generado);
END;
/

-- Prueba del error -20020: el lugar especificado no existe.
DECLARE
    v_id_lugar_test NUMBER := -1;
    v_cantidad      NUMBER;
    v_nro_foto      NUMBER;
BEGIN
    LOOP
        SELECT COUNT(1) INTO v_cantidad
        FROM LUGAR
        WHERE id_lugar = v_id_lugar_test;
        EXIT WHEN v_cantidad = 0;
        v_id_lugar_test := v_id_lugar_test - 1;
    END LOOP;

    SP_SUBIR_FOTOGRAFIA(
        p_id_lugar        => v_id_lugar_test,
        p_id_cuenta_sube  => NULL,
        p_url_fotografia  => 'https://ejemplo.com/fotos/prueba.jpg',
        p_numero_asignado => v_nro_foto
    );
END;
/

-- Prueba del error -20021: la cuenta especificada no existe.
DECLARE
    v_id_lugar_test  LUGAR.id_lugar%TYPE;
    v_id_cuenta_test NUMBER := -1;
    v_cantidad       NUMBER;
    v_nro_foto       NUMBER;
BEGIN
    SELECT MIN(id_lugar) INTO v_id_lugar_test FROM LUGAR;
    IF v_id_lugar_test IS NULL THEN
        RAISE_APPLICATION_ERROR(-20990, 'Se necesita al menos un lugar para probar el error -20021.');
    END IF;

    LOOP
        SELECT COUNT(1) INTO v_cantidad
        FROM CUENTA
        WHERE id_cuenta = v_id_cuenta_test;
        EXIT WHEN v_cantidad = 0;
        v_id_cuenta_test := v_id_cuenta_test - 1;
    END LOOP;

    SP_SUBIR_FOTOGRAFIA(
        p_id_lugar        => v_id_lugar_test,
        p_id_cuenta_sube  => v_id_cuenta_test,
        p_url_fotografia  => 'https://ejemplo.com/fotos/prueba.jpg',
        p_numero_asignado => v_nro_foto
    );
END;
/