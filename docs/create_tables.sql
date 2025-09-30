-- Archivo SQL para crear todas las tablas del schema de Prisma en PostgreSQL
-- Generado a partir de schema.prisma
-- Fecha: 29 de septiembre de 2025

-- Eliminar tablas si existen (en orden inverso por dependencias)
DROP TABLE IF EXISTS detalle_nomina_concepto CASCADE;
DROP TABLE IF EXISTS concepto_empleado CASCADE;
DROP TABLE IF EXISTS detalle_nomina CASCADE;
DROP TABLE IF EXISTS registro_acceso CASCADE;
DROP TABLE IF EXISTS historial_cargo CASCADE;
DROP TABLE IF EXISTS hijo CASCADE;
DROP TABLE IF EXISTS usuario CASCADE;
DROP TABLE IF EXISTS concepto_salarial CASCADE;
DROP TABLE IF EXISTS cargo CASCADE;
DROP TABLE IF EXISTS empleado CASCADE;
DROP TABLE IF EXISTS nomina CASCADE;
DROP TABLE IF EXISTS tipo_concepto_salarial CASCADE;
DROP TABLE IF EXISTS estado_civil CASCADE;
DROP TABLE IF EXISTS departamento CASCADE;
DROP TABLE IF EXISTS categoria_salarial CASCADE;
DROP TABLE IF EXISTS rol_usuario CASCADE;

-- Crear tablas base (sin dependencias)

-- Tabla categoria_salarial
CREATE TABLE categoria_salarial (
    id_categoria_salarial SERIAL PRIMARY KEY,
    monto INTEGER NOT NULL
);

-- Tabla rol_usuario
CREATE TABLE rol_usuario (
    id_rol_usuario SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion_rol VARCHAR(50) NOT NULL
);

-- Tabla nomina
CREATE TABLE nomina (
    id_nomina SERIAL PRIMARY KEY,
    anho INTEGER NOT NULL,
    fecha_generacion DATE NOT NULL,
    estado VARCHAR(20) NOT NULL,
    mes INTEGER NOT NULL
);

-- Tabla tipo_concepto_salarial
CREATE TABLE tipo_concepto_salarial (
    id_concepto_salarial SERIAL PRIMARY KEY,
    descripcion VARCHAR(255) NOT NULL
);

-- Tabla estado_civil
CREATE TABLE estado_civil (
    id_estado SERIAL PRIMARY KEY,
    descripcion VARCHAR(20) NOT NULL
);

-- Tabla departamento
CREATE TABLE departamento (
    id_departamento SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    ubicacion VARCHAR(100) NOT NULL
);

-- Tablas con dependencias de primer nivel

-- Tabla empleado
CREATE TABLE empleado (
    id_empleado SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    cedula VARCHAR(15) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    correo VARCHAR(50) NOT NULL,
    fecha_ingreso DATE NOT NULL,
    telefono VARCHAR(13) NOT NULL,
    fecha_egreso DATE NULL,
    direccion VARCHAR(100) NOT NULL,
    afiliado_IPS BOOLEAN NOT NULL,
    id_estado_civil INTEGER NOT NULL,
    FOREIGN KEY (id_estado_civil) REFERENCES estado_civil(id_estado)
);

-- Tabla concepto_salarial
CREATE TABLE concepto_salarial (
    id_concepto SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    recurrente BOOLEAN NOT NULL,
    afecta_IPS BOOLEAN NOT NULL,
    afecta_aguinaldo BOOLEAN NOT NULL,
    id_concepto_salarial INTEGER NOT NULL,
    FOREIGN KEY (id_concepto_salarial) REFERENCES tipo_concepto_salarial(id_concepto_salarial)
);

-- Tabla cargo
CREATE TABLE cargo (
    id_cargo SERIAL PRIMARY KEY,
    nombre_cargo VARCHAR(50) NOT NULL,
    departamento VARCHAR(50) NOT NULL,
    id_departamento INTEGER NOT NULL,
    Activo BOOLEAN NOT NULL,
    id_categoria_salarial INTEGER NOT NULL,
    FOREIGN KEY (id_departamento) REFERENCES departamento(id_departamento),
    FOREIGN KEY (id_categoria_salarial) REFERENCES categoria_salarial(id_categoria_salarial)
);

-- Tabla usuario
CREATE TABLE usuario (
    id_usuario SERIAL PRIMARY KEY,
    nombre_usuario VARCHAR(50) NOT NULL,
    estado BOOLEAN NOT NULL,
    clave VARCHAR(255) NOT NULL,
    id_rol_usuario INTEGER NOT NULL,
    id_empleado INTEGER NOT NULL UNIQUE,
    FOREIGN KEY (id_rol_usuario) REFERENCES rol_usuario(id_rol_usuario),
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado)
);

-- Tablas con dependencias de segundo nivel

-- Tabla detalle_nomina
CREATE TABLE detalle_nomina (
    id_detalle SERIAL PRIMARY KEY,
    total_descuentos DECIMAL(12,2) NOT NULL,
    total_bonificaciones DECIMAL(12,2) NOT NULL,
    neto_a_cobrar INTEGER NOT NULL,
    creado_por INTEGER NOT NULL,
    id_nomina INTEGER NOT NULL,
    id_empleado INTEGER NOT NULL,
    FOREIGN KEY (creado_por) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_nomina) REFERENCES nomina(id_nomina),
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado)
);

-- Tabla detalle_nomina_concepto
CREATE TABLE detalle_nomina_concepto (
    id_detalle_conceptos INTEGER PRIMARY KEY,
    monto DECIMAL(12,2) NOT NULL,
    id_concepto INTEGER NOT NULL,
    id_detalle INTEGER NOT NULL,
    origen VARCHAR(10) NOT NULL,
    FOREIGN KEY (id_concepto) REFERENCES concepto_salarial(id_concepto),
    FOREIGN KEY (id_detalle) REFERENCES detalle_nomina(id_detalle)
);

-- Tabla registro_acceso
CREATE TABLE registro_acceso (
    id_registro SERIAL PRIMARY KEY,
    id_usuario INTEGER NOT NULL,
    ip_origen VARCHAR(15) NOT NULL,
    accion VARCHAR(255) NOT NULL,
    fecha_hora TIMESTAMP NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

-- Tabla hijo
CREATE TABLE hijo (
    id_hijo SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    certificado_vida_residencia TEXT NOT NULL,
    fecha_vencimiento_certificado DATE NOT NULL,
    id_empleado INTEGER NOT NULL,
    discapacidad BOOLEAN NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    certificado_nacimiento TEXT NOT NULL,
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado)
);

-- Tabla historial_cargo
CREATE TABLE historial_cargo (
    id_historial SERIAL PRIMARY KEY,
    id_empleado INTEGER NOT NULL,
    Fecha_Inicio DATE NOT NULL,
    fecha_fin DATE NULL,
    Salario_Asignado INTEGER NOT NULL,
    id_cargo INTEGER NOT NULL,
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado),
    FOREIGN KEY (id_cargo) REFERENCES cargo(id_cargo)
);

-- Tabla concepto_empleado
CREATE TABLE concepto_empleado (
    id_concepto_empleado SERIAL PRIMARY KEY,
    monto DECIMAL(12,2) NOT NULL,
    id_empleado INTEGER NOT NULL,
    observacion VARCHAR(255) NOT NULL,
    activo BOOLEAN NOT NULL,
    id_concepto INTEGER NOT NULL,
    FOREIGN KEY (id_empleado) REFERENCES empleado(id_empleado),
    FOREIGN KEY (id_concepto) REFERENCES concepto_salarial(id_concepto)
);

-- Crear índices para mejorar el rendimiento
CREATE INDEX idx_empleado_cedula ON empleado(cedula);
CREATE INDEX idx_empleado_estado_civil ON empleado(id_estado_civil);
CREATE INDEX idx_usuario_empleado ON usuario(id_empleado);
CREATE INDEX idx_detalle_nomina_empleado ON detalle_nomina(id_empleado);
CREATE INDEX idx_detalle_nomina_nomina ON detalle_nomina(id_nomina);
CREATE INDEX idx_historial_cargo_empleado ON historial_cargo(id_empleado);
CREATE INDEX idx_concepto_empleado_empleado ON concepto_empleado(id_empleado);
CREATE INDEX idx_hijo_empleado ON hijo(id_empleado);
CREATE INDEX idx_registro_acceso_usuario ON registro_acceso(id_usuario);

-- Comentarios sobre las tablas
COMMENT ON TABLE categoria_salarial IS 'Categorías salariales disponibles en la empresa';
COMMENT ON TABLE rol_usuario IS 'Roles de usuario para el sistema';
COMMENT ON TABLE nomina IS 'Nóminas generadas por período';
COMMENT ON TABLE tipo_concepto_salarial IS 'Tipos de conceptos salariales (descuentos, bonificaciones, etc.)';
COMMENT ON TABLE estado_civil IS 'Estados civiles de los empleados';
COMMENT ON TABLE departamento IS 'Departamentos de la empresa';
COMMENT ON TABLE empleado IS 'Información personal y laboral de los empleados';
COMMENT ON TABLE concepto_salarial IS 'Conceptos salariales específicos';
COMMENT ON TABLE cargo IS 'Cargos disponibles en la empresa';
COMMENT ON TABLE usuario IS 'Usuarios del sistema vinculados a empleados';
COMMENT ON TABLE detalle_nomina IS 'Detalles específicos de cada empleado en una nómina';
COMMENT ON TABLE detalle_nomina_concepto IS 'Conceptos aplicados en cada detalle de nómina';
COMMENT ON TABLE registro_acceso IS 'Registro de accesos al sistema';
COMMENT ON TABLE hijo IS 'Información de hijos de empleados para beneficios';
COMMENT ON TABLE historial_cargo IS 'Historial de cargos ocupados por cada empleado';
COMMENT ON TABLE concepto_empleado IS 'Conceptos salariales específicos asignados a empleados';

-- Script completado exitosamente
-- Todas las tablas han sido creadas.