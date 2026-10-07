-- =====================================================
-- PROYECTO: SISTEMA DE GESTIÓN DE BIBLIOTECA
-- ARCHIVO: 07_procedimientos.sql
-- PARTE 1: PROCEDIMIENTO REGISTRAR USUARIO
-- =====================================================

CREATE OR REPLACE PROCEDURE registrar_usuario (
    p_nombre   IN VARCHAR2,
    p_apellido IN VARCHAR2,
    p_email    IN VARCHAR2
)
IS
BEGIN
    registrar_usuario(
        'Ana',
        'Torres',
        'ana.torres@gmail.com'
    );
END;
/

SELECT *
FROM usuario
ORDER BY id_usuario;


-- =====================================================
-- PARTE 2: PROCEDIMIENTO REALIZAR PRÉSTAMO
-- =====================================================

CREATE OR REPLACE PROCEDURE realizar_prestamo (
    p_id_usuario IN NUMBER,
    p_id_libro   IN NUMBER
)
IS
    v_stock          libro.stock%TYPE;
    v_estado_usuario usuario.estado%TYPE;

    e_sin_stock          EXCEPTION;
    e_usuario_bloqueado  EXCEPTION;

BEGIN

    -- Verificar que el usuario existe y obtener su estado.
    SELECT estado
    INTO v_estado_usuario
    FROM usuario
    WHERE id_usuario = p_id_usuario;

    -- Verificar que el usuario esté activo.
    IF v_estado_usuario <> 'ACTIVO' THEN
        RAISE e_usuario_bloqueado;
    END IF;

    -- Verificar que el libro existe y obtener su stock.
    SELECT stock
    INTO v_stock
    FROM libro
    WHERE id_libro = p_id_libro;

    -- Verificar disponibilidad.
    IF v_stock <= 0 THEN
        RAISE e_sin_stock;
    END IF;

    -- Registrar el préstamo por 7 días.
    INSERT INTO prestamo (
        id_usuario,
        id_libro,
        fecha_prestamo,
        fecha_vencimiento,
        estado
    )
    VALUES (
        p_id_usuario,
        p_id_libro,
        SYSDATE,
        SYSDATE + 7,
        'ACTIVO'
    );

    -- Disminuir el stock del libro.
    UPDATE libro
    SET stock = stock - 1
    WHERE id_libro = p_id_libro;

    DBMS_OUTPUT.PUT_LINE(
        'Préstamo realizado correctamente.'
    );

EXCEPTION

    WHEN e_usuario_bloqueado THEN
        DBMS_OUTPUT.PUT_LINE(
            'ERROR: El usuario está bloqueado y no puede realizar préstamos.'
        );

    WHEN e_sin_stock THEN
        DBMS_OUTPUT.PUT_LINE(
            'ERROR: El libro no tiene stock disponible.'
        );

    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE(
            'ERROR: El usuario o el libro no existe.'
        );

END;
/

--- Comprobar que se hizo el prestamo y el stock ---
BEGIN
    realizar_prestamo(
        21,  -- ID de Ana
        1    -- ID del libro Oracle PL/SQL
    );
END;
/

SELECT *
FROM prestamo
ORDER BY id_prestamo;

SELECT id_libro, titulo, stock
FROM libro
WHERE id_libro = 1;