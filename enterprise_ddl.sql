-- Base de datos principal
USE parcial_db;

-- 1. Tabla de Clientes Corporativos
CREATE TABLE IF NOT EXISTS clientes (
    cliente_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_empresa VARCHAR(150) NOT NULL,
    ruc_nit VARCHAR(50) UNIQUE NOT NULL,
    correo_contacto VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- 2. Tabla de Empleados / Gestores de Servicios
CREATE TABLE IF NOT EXISTS empleados (
    empleado_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    correo_corporativo VARCHAR(100) UNIQUE NOT NULL,
    cargo VARCHAR(50) NOT NULL,
    fecha_contratacion DATE NOT NULL
) ENGINE=InnoDB;

-- 3. Tabla de Servicios Digitales ofrecidos
CREATE TABLE IF NOT EXISTS servicios_digitales (
    servicio_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_servicio VARCHAR(100) NOT NULL,
    descripcion TEXT,
    costo_mensual DECIMAL(10, 2) NOT NULL
) ENGINE=InnoDB;

-- 4. Tabla de Contratos (Relación muchos a muchos entre Clientes, Servicios y Empleados)
CREATE TABLE IF NOT EXISTS contratos (
    contrato_id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    servicio_id INT NOT NULL,
    empleado_asignado_id INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    estado VARCHAR(30) DEFAULT 'Activo',
    
    -- Restricciones de Llaves Foráneas (Foreign Keys)
    CONSTRAINT fk_contrato_cliente 
        FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id) 
        ON DELETE CASCADE ON UPDATE CASCADE,
        
    CONSTRAINT fk_contrato_servicio 
        FOREIGN KEY (servicio_id) REFERENCES servicios_digitales(servicio_id) 
        ON DELETE RESTRICT ON UPDATE CASCADE,
        
    CONSTRAINT fk_contrato_empleado 
        FOREIGN KEY (empleado_asignado_id) REFERENCES empleados(empleado_id) 
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;