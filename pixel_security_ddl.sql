-- Base de datos principal
USE parcial_db;

-- 1. Tabla de Zonas de Vigilancia
CREATE TABLE IF NOT EXISTS zonas (
    zona_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_zona VARCHAR(100) NOT NULL,
    ubicacion_fisica VARCHAR(150) NOT NULL,
    nivel_riesgo VARCHAR(30) DEFAULT 'Moderado'
) ENGINE=InnoDB;

-- 2. Tabla de Dispositivos (Cámaras, Sensores, etc.)
CREATE TABLE IF NOT EXISTS dispositivos (
    dispositivo_id INT AUTO_INCREMENT PRIMARY KEY,
    zona_id INT NOT NULL,
    tipo_dispositivo VARCHAR(50) NOT NULL, -- Ej: Cámara IP, Sensor de Movimiento
    estado_operativo VARCHAR(30) DEFAULT 'Activo',
    fecha_instalacion DATE NOT NULL,
    
    CONSTRAINT fk_dispositivo_zona 
        FOREIGN KEY (zona_id) REFERENCES zonas(zona_id) 
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 3. Tabla de Personal de Seguridad
CREATE TABLE IF NOT EXISTS personal_seguridad (
    personal_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    turno VARCHAR(30) NOT NULL,
    telefono VARCHAR(20) NOT NULL
) ENGINE=InnoDB;

-- 4. Tabla de Alertas e Incidentes Registrados
CREATE TABLE IF NOT EXISTS alertas_incidentes (
    alerta_id INT AUTO_INCREMENT PRIMARY KEY,
    dispositivo_id INT NOT NULL,
    personal_id INT,
    descripcion_incidente TEXT NOT NULL,
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    gravedad VARCHAR(30) NOT NULL, -- Baja, Media, Alta, Crítica
    
    CONSTRAINT fk_alerta_dispositivo 
        FOREIGN KEY (dispositivo_id) REFERENCES dispositivos(dispositivo_id) 
        ON DELETE CASCADE ON UPDATE CASCADE,
        
    CONSTRAINT fk_alerta_personal 
        FOREIGN KEY (personal_id) REFERENCES personal_seguridad(personal_id) 
        ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB;