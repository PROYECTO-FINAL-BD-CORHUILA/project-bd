-- 1. Aseguramos que existan los roles básicos
-- 1. Limpiamos las tablas para empezar de cero (RESTART IDENTITY resetea los IDs a 1)
TRUNCATE TABLE detalle_factura, factura, usuario, persona, producto, rol RESTART IDENTITY CASCADE;

-- 2. Insertamos los roles
INSERT INTO rol (nombre) VALUES ('admin'), ('cliente');

-- 3. Insertamos las 8 personas
INSERT INTO persona (nombre, apellido, documento) VALUES
('Juan', 'Perez', '123'),
('Ana', 'García', '101020'),
('Carlos', 'Ruiz', '303040'),
('Elena', 'Martínez', '505060'),
('Diego', 'López', '707080'),
('Sofía', 'Pérez', '909010'),
('Andrés', 'Castro', '111213'),
('Lucía', 'Méndez', '141516');

-- 4. Insertamos los 8 usuarios (ahora los IDs serán fijos del 1 al 8)
INSERT INTO usuario (persona_id, rol_id, username, password) VALUES
(1, 1, 'juanp', '1234'),
(2, 2, 'anag', 'pass456'),
(3, 2, 'cruiz', 'admin88'),
(4, 1, 'elenam', 'elena2024'),
(5, 2, 'diegol', 'diego77'),
(6, 2, 'sofiap', 'sofia123'),
(7, 1, 'andres_c', 'acastro99'),
(8, 2, 'luciam', 'mendez00');

-- 5. Insertamos un par de productos para que no esté vacía
INSERT INTO producto (nombre, precio) VALUES ('Laptop', 2500), ('Mouse', 50);