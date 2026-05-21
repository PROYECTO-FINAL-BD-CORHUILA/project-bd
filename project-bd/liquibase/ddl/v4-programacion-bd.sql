-- liquibase formatted sql
-- changeset santiago:componentes-avanzados-programables splitStatements:false

-- =======================================================
-- 1. FUNCTION (Retorna un valor/tabla)
-- =======================================================
-- Función para calcular el valor total de un pedido específico multiplicando cantidades por precios
CREATE OR REPLACE FUNCTION fn_calcular_total_pedido(p_id_pedido INT)
RETURNS DECIMAL(12,2) AS $$
DECLARE
    v_total DECIMAL(12,2);
BEGIN
    SELECT COALESCE(SUM(cantidad_vendida_kg * precio_por_kg), 0.00)
    INTO v_total
    FROM detalle_pedidos
    WHERE id_pedido = p_id_pedido;
    
    RETURN v_total;
END;
$$ LANGUAGE plpgsql;

-- =======================================================
-- 2. PROCEDURE (Ejecuta acciones/operaciones)
-- =======================================================
-- Procedimiento para actualizar el estado de un pedido de forma segura y controlada
CREATE OR REPLACE PROCEDURE pr_actualizar_estado_pedido(
    IN p_id_pedido INT,
    IN p_nuevo_estado VARCHAR
) AS $$
BEGIN
    UPDATE pedidos
    SET estado = p_nuevo_estado
    WHERE id_pedido = p_id_pedido;
    
    COMMIT;
END;
$$ LANGUAGE plpgsql;

-- =======================================================
-- 3. TRIGGER (Automatización por Eventos)
-- =======================================================
-- Función interna que usará el disparador para descontar stock del lote vendido
CREATE OR REPLACE FUNCTION fn_trigger_actualizar_stock()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE lotes
    SET cantidad_kg = cantidad_kg - NEW.cantidad_vendida_kg
    WHERE id_lote = NEW.id_lote;

    -- Validación de seguridad en caliente
    IF (SELECT cantidad_kg FROM lotes WHERE id_lote = NEW.id_lote) < 0 THEN
        RAISE EXCEPTION 'Operación cancelada: No hay stock suficiente en el lote para procesar la venta.';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Declaración oficial del TRIGGER sobre la tabla detalle_pedidos
CREATE OR REPLACE TRIGGER trg_descontar_inventario_lote
AFTER INSERT ON detalle_pedidos
FOR EACH ROW
EXECUTE FUNCTION fn_trigger_actualizar_stock();