-- =====================================================
-- PROYECTO: SISTEMA DE GESTIÓN DE BIBLIOTECA
-- ARCHIVO: 08_funciones.sql
-- FUNCIÓN: CALCULAR MULTA
-- =====================================================

CREATE OR REPLACE FUNCTION calcular_multa (
    p_dias_atraso IN NUMBER
)
RETURN NUMBER
IS
    v_multa NUMBER(10,2);
BEGIN

    -- Si existen días de atraso, se cobran $500 por día.
    IF p_dias_atraso > 0 THEN
        v_multa := p_dias_atraso * 500;
    ELSE
        v_multa := 0;
    END IF;

    -- La función devuelve el monto calculado.
    RETURN v_multa;

END;
/

--- multa por atraso ---
BEGIN
    DBMS_OUTPUT.PUT_LINE(
        'Multa por 3 dias de atraso: $' ||
        calcular_multa(3)
    );
END;
/

--- sin multa ---
BEGIN

    DBMS_OUTPUT.PUT_LINE(
        'Multa sin atraso: $' ||
        calcular_multa(0)
    );

END;
/


-- =====================================================
-- FUNCIÓN: CANTIDAD DE PRÉSTAMOS ACTIVOS
-- =====================================================

CREATE OR REPLACE FUNCTION cantidad_prestamos_activos (
    p_id_usuario IN NUMBER
)
RETURN NUMBER
IS
    v_cantidad NUMBER;
BEGIN

    SELECT COUNT(*)
    INTO v_cantidad
    FROM prestamo
    WHERE id_usuario = p_id_usuario
      AND estado = 'ACTIVO';

    RETURN v_cantidad;

END;
/

--- Prueba de cantidad de prestamos activos ---
BEGIN

    DBMS_OUTPUT.PUT_LINE(
        'Prestamos activos de Ana: ' ||
        cantidad_prestamos_activos(21)
    );

END;
/