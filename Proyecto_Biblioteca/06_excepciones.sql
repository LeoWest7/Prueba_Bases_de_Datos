-- =====================================================
-- PROYECTO: SISTEMA DE GESTIÓN DE BIBLIOTECA
-- ARCHIVO: 06_excepciones.sql
-- PARTE 1: EXCEPCIÓN PREDEFINIDA
-- =====================================================

DECLARE

    v_titulo libro.titulo%TYPE;

BEGIN

    -- Intentamos buscar un libro que no existe.
    SELECT titulo
    INTO v_titulo
    FROM libro
    WHERE id_libro = 999;

    DBMS_OUTPUT.PUT_LINE(
        'Libro encontrado: ' || v_titulo
    );

EXCEPTION

    -- Oracle genera esta excepción automáticamente
    -- cuando SELECT INTO no encuentra ningún registro.
    WHEN NO_DATA_FOUND THEN

        DBMS_OUTPUT.PUT_LINE(
            'ERROR: El libro solicitado no existe.'
        );

END;
/



-- =====================================================
-- PARTE 2: EXCEPCIÓN PERSONALIZADA
-- =====================================================

DECLARE

    v_stock libro.stock%TYPE;

    -- Creamos nuestra propia excepción.
    e_sin_stock EXCEPTION;

BEGIN

    -- Consultamos el stock del libro con ID 1.
    SELECT stock
    INTO v_stock
    FROM libro
    WHERE id_libro = 1;

    DBMS_OUTPUT.PUT_LINE(
        'Stock actual del libro: ' || v_stock
    );

    -- Validamos si existe stock disponible.
    IF v_stock <= 0 THEN

        RAISE e_sin_stock;

    ELSE

        DBMS_OUTPUT.PUT_LINE(
            'El libro se encuentra disponible para préstamo.'
        );

    END IF;

EXCEPTION

    -- Capturamos nuestra excepción personalizada.
    WHEN e_sin_stock THEN

        DBMS_OUTPUT.PUT_LINE(
            'ERROR: No se puede realizar el préstamo porque el libro no tiene stock.'
        );

    WHEN NO_DATA_FOUND THEN

        DBMS_OUTPUT.PUT_LINE(
            'ERROR: El libro no existe.'
        );

END;
/


--- comprobar si hay o no stock
---UPDATE libro
--SET stock = 0
--WHERE id_libro = 1;