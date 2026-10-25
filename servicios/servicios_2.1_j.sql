CREATE OR REPLACE PROCEDURE SP_CREAR_LUGAR (
    p_nombre                 IN LUGAR.nombre%TYPE,
    p_calle                  IN LUGAR.calle%TYPE,
    p_numero                 IN LUGAR.numero%TYPE,
    p_ciudad                 IN LUGAR.ciudad%TYPE,
    p_pais                   IN LUGAR.pais%TYPE,
    p_latitud                IN LUGAR.latitud%TYPE,
    p_longitud               IN LUGAR.longitud%TYPE,
    p_id_categoria_principal IN LUGAR.id_categoria_principal%TYPE,
    p_id_lugar_contenedor    IN LUGAR.id_lugar_contenedor%TYPE DEFAULT NULL,
    p_id_cuenta_admin        IN LUGAR.id_cuenta_admin%TYPE DEFAULT NULL,
    p_estado                 IN LUGAR.estado%TYPE DEFAULT 'Operativo',
    p_id_lugar_creado        OUT LUGAR.id_lugar%TYPE
) AS
    v_valida_cat  NUMBER;
    v_valida_cont NUMBER;
    v_valida_prop NUMBER;
BEGIN
    -- 1. Validar que la categoría principal exista
    SELECT COUNT(1) INTO v_valida_cat 
    FROM CATEGORIA 
    WHERE id_categoria = p_id_categoria_principal;
    
    IF v_valida_cat = 0 THEN
        RAISE_APPLICATION_ERROR(-20010, 'Error: La categoría principal especificada no existe.');
    END IF;

    -- 2. Validar el lugar contenedor (si se proporciona)
    IF p_id_lugar_contenedor IS NOT NULL THEN
        -- Verificar que no sea autocontención (aunque hay un check, se valida antes)
        IF p_id_lugar_contenedor = p_id_lugar_creado THEN
            RAISE_APPLICATION_ERROR(-20011, 'Error: Un lugar no puede contenerse a sí mismo.');
        END IF;

        SELECT COUNT(1) INTO v_valida_cont 
        FROM LUGAR 
        WHERE id_lugar = p_id_lugar_contenedor;
        
        IF v_valida_cont = 0 THEN
            RAISE_APPLICATION_ERROR(-20012, 'Error: El lugar contenedor especificado no existe.');
        END IF;
    END IF;

    -- 3. Validar la cuenta propietaria/administradora (si se proporciona)
    IF p_id_cuenta_admin IS NOT NULL THEN
        SELECT COUNT(1) INTO v_valida_prop 
        FROM CUENTA_PROPIETARIA 
        WHERE id_cuenta = p_id_cuenta_admin;
        
        IF v_valida_prop = 0 THEN
            RAISE_APPLICATION_ERROR(-20013, 'Error: La cuenta propietaria especificada no existe o no es una cuenta propietaria válida.');
        END IF;
    END IF;

    -- 4. Inserción del nuevo lugar
    INSERT INTO LUGAR (
        nombre,
        calle,
        numero,
        ciudad,
        pais,
        latitud,
        longitud,
        estado,
        id_categoria_principal,
        id_lugar_contenedor,
        id_cuenta_admin
    ) VALUES (
        p_nombre,
        p_calle,
        p_numero,
        p_ciudad,
        p_pais,
        p_latitud,
        p_longitud,
        p_estado,
        p_id_categoria_principal,
        p_id_lugar_contenedor,
        p_id_cuenta_admin
    )
    RETURNING id_lugar INTO p_id_lugar_creado;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Lugar creado exitosamente con ID: ' || p_id_lugar_creado);

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END SP_CREAR_LUGAR;
/
-- ejemplo de invocación del procedimiento
DECLARE
    v_nuevo_id NUMBER;
BEGIN
    SP_CREAR_LUGAR(
        p_nombre                 => 'Café Central',
        p_calle                  => 'Av. Principal',
        p_numero                 => '123',
        p_ciudad                 => 'Santiago',
        p_pais                   => 'Chile',
        p_latitud                => -33.4488900,
        p_longitud               => -70.6692650,
        p_id_categoria_principal => 1,          -- Asume que la categoría con ID 1 existe
        p_id_lugar_contenedor    => NULL,       -- No pertenece a otro lugar (ej. no está dentro de un mall)
        p_id_cuenta_admin        => NULL,       -- Sin cuenta administradora asignada
        p_estado                 => 'Operativo',
        p_id_lugar_creado        => v_nuevo_id
    );
    
    DBMS_OUTPUT.PUT_LINE('El ID generado es: ' || v_nuevo_id);
END;
/

-- Pruebas de errores controlados. Cada bloque debe ejecutarse por separado.

-- Error -20010: la categoría principal no existe.
DECLARE
    v_id             NUMBER;
    v_categoria_test NUMBER := -1;
    v_cantidad       NUMBER;
BEGIN
    LOOP
        SELECT COUNT(1) INTO v_cantidad
        FROM CATEGORIA
        WHERE id_categoria = v_categoria_test;
        EXIT WHEN v_cantidad = 0;
        v_categoria_test := v_categoria_test - 1;
    END LOOP; --verificar que el valor de la categoría no existe

    SP_CREAR_LUGAR(
        p_nombre                 => 'Prueba categoría inexistente',
        p_calle                  => 'Calle de prueba',
        p_numero                 => '1',
        p_ciudad                 => 'Santiago',
        p_pais                   => 'Chile',
        p_latitud                => -33.4488900,
        p_longitud               => -70.6692650,
        p_id_categoria_principal => v_categoria_test,
        p_id_cuenta_admin        => NULL,
        p_id_lugar_creado        => v_id
    );
    RAISE_APPLICATION_ERROR(-20991, 'La prueba no produjo el error -20010 esperado.');
END;
/

-- Error -20012: el lugar contenedor no existe.
DECLARE
    v_id             NUMBER;
    v_categoria      NUMBER;
    v_contenedor_test NUMBER := -1;
    v_cantidad       NUMBER;
BEGIN
    SELECT MIN(id_categoria) INTO v_categoria FROM CATEGORIA;
    IF v_categoria IS NULL THEN
        RAISE_APPLICATION_ERROR(-20990, 'Se necesita al menos una categoría para esta prueba.');
    END IF;

    LOOP
        SELECT COUNT(1) INTO v_cantidad
        FROM LUGAR
        WHERE id_lugar = v_contenedor_test;
        EXIT WHEN v_cantidad = 0;
        v_contenedor_test := v_contenedor_test - 1;
    END LOOP;

    SP_CREAR_LUGAR(
        p_nombre                 => 'Prueba contenedor inexistente',
        p_calle                  => 'Calle de prueba',
        p_numero                 => '1',
        p_ciudad                 => 'Santiago',
        p_pais                   => 'Chile',
        p_latitud                => -33.4488900,
        p_longitud               => -70.6692650,
        p_id_categoria_principal => v_categoria,
        p_id_lugar_contenedor    => v_contenedor_test,
        p_id_cuenta_admin        => NULL,
        p_id_lugar_creado        => v_id
    );
    RAISE_APPLICATION_ERROR(-20991, 'La prueba no produjo el error -20012 esperado.');
END;
/

-- Error -20013: la cuenta administradora no existe en CUENTA_PROPIETARIA.
DECLARE
    v_id             NUMBER;
    v_categoria      NUMBER;
    v_admin_test     NUMBER := -1;
    v_cantidad       NUMBER;
BEGIN
    SELECT MIN(id_categoria) INTO v_categoria FROM CATEGORIA;
    IF v_categoria IS NULL THEN
        RAISE_APPLICATION_ERROR(-20990, 'Se necesita al menos una categoría para esta prueba.');
    END IF;

    LOOP
        SELECT COUNT(1) INTO v_cantidad
        FROM CUENTA_PROPIETARIA
        WHERE id_cuenta = v_admin_test;
        EXIT WHEN v_cantidad = 0;
        v_admin_test := v_admin_test - 1;
    END LOOP;

    SP_CREAR_LUGAR(
        p_nombre                 => 'Prueba cuenta administradora inexistente',
        p_calle                  => 'Calle de prueba',
        p_numero                 => '1',
        p_ciudad                 => 'Santiago',
        p_pais                   => 'Chile',
        p_latitud                => -33.4488900,
        p_longitud               => -70.6692650,
        p_id_categoria_principal => v_categoria,
        p_id_cuenta_admin        => v_admin_test,
        p_id_lugar_creado        => v_id
    );
    RAISE_APPLICATION_ERROR(-20991, 'La prueba no produjo el error -20013 esperado.');
END;
/

