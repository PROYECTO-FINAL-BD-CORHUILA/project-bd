SELECT f.id, u.username, f.fecha
FROM factura f
JOIN usuario u ON f.usuario_id = u.id;