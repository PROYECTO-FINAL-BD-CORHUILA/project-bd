SELECT df.id, p.nombre, df.cantidad
FROM detalle_factura df
JOIN producto p ON df.producto_id = p.id;