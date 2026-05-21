-- PostgreSQL script
CREATE TABLE estudiante (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50),
    edad INT,
    carrera VARCHAR(50)
);

INSERT INTO estudiante (nombre, edad, carrera)
VALUES 
('Juan Perez', 20, 'Ingenieria'),
('Maria Gomez', 21, 'Administracion'),
('Carlos Lopez', 19, 'Sistemas');

SELECT * FROM estudiante;
