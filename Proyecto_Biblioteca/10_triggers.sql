-- =====================================================
-- PROYECTO: SISTEMA DE GESTIÓN DE BIBLIOTECA
-- ARCHIVO: 10_triggers.sql
-- TRIGGER: VALIDAR STOCK
-- =====================================================

CREATE OR REPLACE TRIGGER trg_validar_stock
BEFORE INSERT OR UPDATE OF stock
ON libro
FOR EACH ROW

BEGIN

    -- Evita que el stock de un libro sea negativo.
    IF :NEW.stock < 0 THEN

        RAISE_APPLICATION_ERROR(
            -20001,
            'ERROR: El stock de un libro no puede ser negativo.'
        );

    END IF;

END;
/

--- Para mostrar que un valor no puede ser negativo ---
UPDATE libro
SET stock = -1
WHERE id_libro = 1;

--- Probamos con valor positivo ---
SELECT id_libro, titulo, stock
FROM libro
WHERE id_libro = 1;


-- =====================================================
-- TRIGGER: ACTUALIZAR ESTADO DEL PRÉSTAMO
-- =====================================================

CREATE OR REPLACE TRIGGER trg_actualizar_prestamo
AFTER INSERT
ON devolucion
FOR EACH ROW

BEGIN

    -- Al registrar una devolución,
    -- el préstamo pasa automáticamente a DEVUELTO.
    UPDATE prestamo
    SET estado = 'DEVUELTO'
    WHERE id_prestamo = :NEW.id_prestamo;

END;
/