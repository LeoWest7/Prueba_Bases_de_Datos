-- =====================================================
-- PROYECTO: SISTEMA DE GESTIÓN DE BIBLIOTECA
-- ARCHIVO: 09_package.sql
-- PACKAGE SPECIFICATION
-- =====================================================

CREATE OR REPLACE PACKAGE pkg_biblioteca
IS

    -- Procedimiento para mostrar información de un libro.
    PROCEDURE mostrar_libro (
        p_id_libro IN NUMBER
    );

    -- Función para consultar el stock de un libro.
    FUNCTION obtener_stock (
        p_id_libro IN NUMBER
    )
    RETURN NUMBER;

END pkg_biblioteca;
/

-- =====================================================
-- PACKAGE BODY
-- =====================================================

CREATE OR REPLACE PACKAGE BODY pkg_biblioteca
IS

    -- ==========================================
    -- PROCEDIMIENTO MOSTRAR LIBRO
    -- ==========================================

    PROCEDURE mostrar_libro (
        p_id_libro IN NUMBER
    )
    IS
        v_titulo libro.titulo%TYPE;
        v_autor  libro.autor%TYPE;
        v_stock  libro.stock%TYPE;

    BEGIN

        SELECT
            titulo,
            autor,
            stock
        INTO
            v_titulo,
            v_autor,
            v_stock
        FROM libro
        WHERE id_libro = p_id_libro;

        DBMS_OUTPUT.PUT_LINE(
            'Titulo: ' || v_titulo
        );

        DBMS_OUTPUT.PUT_LINE(
            'Autor: ' || v_autor
        );

        DBMS_OUTPUT.PUT_LINE(
            'Stock: ' || v_stock
        );

    EXCEPTION

        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE(
                'ERROR: El libro no existe.'
            );

    END mostrar_libro;


    -- ==========================================
    -- FUNCIÓN OBTENER STOCK
    -- ==========================================

    FUNCTION obtener_stock (
        p_id_libro IN NUMBER
    )
    RETURN NUMBER
    IS
        v_stock libro.stock%TYPE;

    BEGIN

        SELECT stock
        INTO v_stock
        FROM libro
        WHERE id_libro = p_id_libro;

        RETURN v_stock;

    EXCEPTION

        WHEN NO_DATA_FOUND THEN
            RETURN -1;

    END obtener_stock;


END pkg_biblioteca;
/


-- =====================================================
-- PRUEBA DEL PROCEDIMIENTO DEL PACKAGE
-- =====================================================

BEGIN
    pkg_biblioteca.mostrar_libro(1);
END;
/


-- =====================================================
-- PRUEBA DE LA FUNCIÓN DEL PACKAGE
-- =====================================================

BEGIN
    DBMS_OUTPUT.PUT_LINE(
        'Stock disponible: ' ||
        pkg_biblioteca.obtener_stock(1)
    );
END;
/

