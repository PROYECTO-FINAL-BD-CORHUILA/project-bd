-- MySQL script
USE laboratorio_docker;

CREATE TABLE estudiante (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    edad INT,
    carrera VARCHAR(50)
);

INSERT INTO estudiante (nombre, edad, carrera)
VALUES 
('Ana Torres', 22, 'Contaduria'),
('Luis Martinez', 23, 'Ingenieria'),
('Sofia Ramirez', 20, 'Derecho');

SELECT * FROM estudiante;
