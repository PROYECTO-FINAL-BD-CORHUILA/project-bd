# Taller de Contenedores

## Requisitos
- Docker instalado
- Visual Studio Code (opcional)

## Pasos

### 1. Levantar PostgreSQL
docker run --name postgres_db -e POSTGRES_PASSWORD=123456 -e POSTGRES_DB=laboratorio_docker -p 5432:5432 -d postgres

### 2. Acceder a PostgreSQL
docker exec -it postgres_db psql -U postgres

### 3. Ejecutar script postgres.sql

### 4. Levantar MySQL
docker run --name mysql_db -e MYSQL_ROOT_PASSWORD=123456 -e MYSQL_DATABASE=laboratorio_docker -p 3306:3306 -d mysql

### 5. Acceder a MySQL
docker exec -it mysql_db mysql -u root -p

### 6. Ejecutar script mysql.sql
