-- =====================================================
-- PROYECTO: SISTEMA DE GESTIÓN DE BIBLIOTECA
-- ARCHIVO: 05_cursores.sql
-- PARTE 1: CURSOR EXPLÍCITO
-- =====================================================

DECLARE

    -- Declaramos el cursor.
    CURSOR c_libros IS
        SELECT
            id_libro,
            titulo,
            autor,
            stock
        FROM libro
        ORDER BY id_libro;

    -- Variables para almacenar los datos.
    v_id_libro libro.id_libro%TYPE;
    v_titulo   libro.titulo%TYPE;
    v_autor    libro.autor%TYPE;
    v_stock    libro.stock%TYPE;

BEGIN

    -- Abrimos el cursor.
    OPEN c_libros;

    LOOP

        -- Obtenemos un registro del cursor.
        FETCH c_libros
        INTO
            v_id_libro,
            v_titulo,
            v_autor,
            v_stock;

        -- Si no quedan registros, terminamos.
        EXIT WHEN c_libros%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE(
            'ID: ' || v_id_libro ||
            ' | Titulo: ' || v_titulo ||
            ' | Autor: ' || v_autor ||
            ' | Stock: ' || v_stock
        );

    END LOOP;

    -- Cerramos el cursor.
    CLOSE c_libros;

END;
/

-- =====================================================
-- PARTE 2: CURSOR PARAMETRIZADO
-- =====================================================

DECLARE

    -- Cursor que recibe como parámetro el ID de la categoría.
    CURSOR c_libros_categoria (
        p_id_categoria NUMBER
    ) IS
        SELECT
            id_libro,
            titulo,
            autor,
            stock
        FROM libro
        WHERE id_categoria = p_id_categoria
        ORDER BY id_libro;

BEGIN

    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('================================');
    DBMS_OUTPUT.PUT_LINE('   LIBROS DE BASES DE DATOS');
    DBMS_OUTPUT.PUT_LINE('================================');

    -- Utilizamos el cursor para la categoría 1.
    FOR libro_rec IN c_libros_categoria(1) LOOP

        DBMS_OUTPUT.PUT_LINE(
            'ID: ' || libro_rec.id_libro ||
            ' | Titulo: ' || libro_rec.titulo ||
            ' | Autor: ' || libro_rec.autor ||
            ' | Stock: ' || libro_rec.stock
        );

    END LOOP;

END;
/


-- =====================================================
-- PARTE 3: CURSOR MAESTRO-DETALLE ANIDADO
-- =====================================================

DECLARE

    -- CURSOR MAESTRO
    -- Obtiene todas las categorías.
    CURSOR c_categorias IS
        SELECT
            id_categoria,
            nombre
        FROM categoria
        ORDER BY id_categoria;

    -- CURSOR DETALLE
    -- Recibe como parámetro la categoría
    -- y obtiene sus libros.
    CURSOR c_libros (
        p_id_categoria NUMBER
    ) IS
        SELECT
            id_libro,
            titulo,
            autor,
            stock
        FROM libro
        WHERE id_categoria = p_id_categoria
        ORDER BY id_libro;

BEGIN

    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('==========================================');
    DBMS_OUTPUT.PUT_LINE('       CATEGORIAS Y SUS LIBROS');
    DBMS_OUTPUT.PUT_LINE('==========================================');

    -- RECORRIDO DEL CURSOR MAESTRO
    FOR categoria_rec IN c_categorias LOOP

        DBMS_OUTPUT.PUT_LINE('');
        DBMS_OUTPUT.PUT_LINE(
            'CATEGORIA: ' || categoria_rec.nombre
        );

        DBMS_OUTPUT.PUT_LINE(
            '------------------------------------------'
        );

        -- RECORRIDO DEL CURSOR DETALLE
        FOR libro_rec IN c_libros(categoria_rec.id_categoria) LOOP

            DBMS_OUTPUT.PUT_LINE(
                '  - ' || libro_rec.titulo ||
                ' | Autor: ' || libro_rec.autor ||
                ' | Stock: ' || libro_rec.stock
            );

        END LOOP;

    END LOOP;

    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('==========================================');

END;
/