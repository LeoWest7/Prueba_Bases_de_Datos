-- =====================================================
-- PROYECTO: SISTEMA DE GESTIÓN DE BIBLIOTECA
-- ARCHIVO: 04_record_varray.sql
-- PARTE 1: RECORD
-- =====================================================

DECLARE

    -- Definimos un RECORD para almacenar
    -- información de un libro.
    TYPE t_libro_record IS RECORD (
        id_libro libro.id_libro%TYPE,
        titulo   libro.titulo%TYPE,
        autor    libro.autor%TYPE,
        stock    libro.stock%TYPE
    );

    -- Creamos una variable del tipo RECORD.
    v_libro t_libro_record;

BEGIN

    -- Buscamos el libro con ID 1.
    SELECT
        id_libro,
        titulo,
        autor,
        stock
    INTO
        v_libro.id_libro,
        v_libro.titulo,
        v_libro.autor,
        v_libro.stock
    FROM libro
    WHERE id_libro = 1;

    -- Mostramos la información almacenada.
    DBMS_OUTPUT.PUT_LINE('================================');
    DBMS_OUTPUT.PUT_LINE('      INFORMACION DEL LIBRO');
    DBMS_OUTPUT.PUT_LINE('================================');
    DBMS_OUTPUT.PUT_LINE('ID:     ' || v_libro.id_libro);
    DBMS_OUTPUT.PUT_LINE('Titulo: ' || v_libro.titulo);
    DBMS_OUTPUT.PUT_LINE('Autor:  ' || v_libro.autor);
    DBMS_OUTPUT.PUT_LINE('Stock:  ' || v_libro.stock);
    DBMS_OUTPUT.PUT_LINE('================================');

END;
/

-- =====================================================
-- PARTE 2: VARRAY
-- =====================================================

DECLARE

    -- Creamos un VARRAY que puede almacenar
    -- como máximo 5 títulos de libros.
    TYPE t_lista_libros IS VARRAY(5) OF VARCHAR2(200);

    -- Variable del tipo VARRAY.
    v_libros t_lista_libros;

BEGIN

    -- Cargamos cinco libros.
    v_libros := t_lista_libros(
        'Oracle PL/SQL',
        'Fundamentos de Bases de Datos',
        'Clean Code',
        'Introduccion a la Programacion',
        'Don Quijote de la Mancha'
    );

    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('================================');
    DBMS_OUTPUT.PUT_LINE('          LISTA DE LIBROS');
    DBMS_OUTPUT.PUT_LINE('================================');

    -- Recorremos el VARRAY.
    FOR i IN 1 .. v_libros.COUNT LOOP

        DBMS_OUTPUT.PUT_LINE(
            i || '. ' || v_libros(i)
        );

    END LOOP;

    DBMS_OUTPUT.PUT_LINE('================================');

END;
/