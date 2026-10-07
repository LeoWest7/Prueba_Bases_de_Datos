-- =====================================================
-- PROYECTO: SISTEMA DE GESTIÓN DE BIBLIOTECA
-- ARCHIVO: 11_pruebas_finales.sql
-- PROCEDIMIENTO: REALIZAR DEVOLUCIÓN
-- =====================================================

CREATE OR REPLACE PROCEDURE realizar_devolucion (
    p_id_prestamo IN NUMBER
)
IS
    v_id_libro          prestamo.id_libro%TYPE;
    v_fecha_vencimiento prestamo.fecha_vencimiento%TYPE;
    v_estado            prestamo.estado%TYPE;
    v_dias_atraso       NUMBER;
    v_multa             NUMBER(10,2);

    e_prestamo_devuelto EXCEPTION;

BEGIN

    -- Obtener información del préstamo.
    SELECT
        id_libro,
        fecha_vencimiento,
        estado
    INTO
        v_id_libro,
        v_fecha_vencimiento,
        v_estado
    FROM prestamo
    WHERE id_prestamo = p_id_prestamo;

    -- Evitar devolver dos veces el mismo préstamo.
    IF v_estado = 'DEVUELTO' THEN
        RAISE e_prestamo_devuelto;
    END IF;

    -- Calcular días de atraso.
    v_dias_atraso :=
        GREATEST(
            TRUNC(SYSDATE) - TRUNC(v_fecha_vencimiento),
            0
        );

    -- Utilizamos nuestra función del archivo 08.
    v_multa := calcular_multa(v_dias_atraso);

    -- Registrar la devolución.
    INSERT INTO devolucion (
        id_prestamo,
        fecha_devolucion,
        dias_atraso,
        multa
    )
    VALUES (
        p_id_prestamo,
        SYSDATE,
        v_dias_atraso,
        v_multa
    );

    -- Devolver una unidad al stock.
    UPDATE libro
    SET stock = stock + 1
    WHERE id_libro = v_id_libro;

    DBMS_OUTPUT.PUT_LINE(
        'Devolucion realizada correctamente.'
    );

    DBMS_OUTPUT.PUT_LINE(
        'Dias de atraso: ' || v_dias_atraso
    );

    DBMS_OUTPUT.PUT_LINE(
        'Multa: $' || v_multa
    );

EXCEPTION

    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE(
            'ERROR: El prestamo no existe.'
        );

    WHEN e_prestamo_devuelto THEN
        DBMS_OUTPUT.PUT_LINE(
            'ERROR: Este prestamo ya fue devuelto.'
        );

END;
/

--- Prueba ---
SELECT
    p.id_prestamo,
    u.id_usuario,
    u.nombre,
    u.apellido,
    l.titulo,
    p.fecha_prestamo,
    p.fecha_vencimiento,
    p.estado
FROM prestamo p
JOIN usuario u
    ON p.id_usuario = u.id_usuario
JOIN libro l
    ON p.id_libro = l.id_libro
WHERE u.id_usuario = 21
ORDER BY p.id_prestamo;

-- =====================================================
-- PRUEBA DE DEVOLUCIÓN
-- =====================================================

BEGIN
    realizar_devolucion(1);
END;
/

-- 1. Verificar el préstamo
--- demuestra que nuestro trigger de actualizar prestamo funciona
SELECT
    id_prestamo,
    id_usuario,
    id_libro,
    estado
FROM prestamo
WHERE id_prestamo = 1;

-- 2. Verificar la devolución
--- 
SELECT *
FROM devolucion
WHERE id_prestamo = 1;

-- 3. Verificar el stock
SELECT
    id_libro,
    titulo,
    stock
FROM libro
WHERE id_libro = 1;