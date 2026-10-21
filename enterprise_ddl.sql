USE enterprise_db;

CREATE TABLE IF NOT EXISTS Usuario (
    ID_usuario INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Correo VARCHAR(100) NOT NULL UNIQUE,
    Fecha_registro DATE NOT NULL,
    Estado ENUM('Activo', 'Inactivo', 'Suspendido') NOT NULL,
    activo_sistema BOOLEAN DEFAULT TRUE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Autenticacion (
    ID_auten INT AUTO_INCREMENT PRIMARY KEY,
    ID_usuario INT NOT NULL,
    Contrasena VARCHAR(255) NOT NULL,
    Token VARCHAR(255) UNIQUE,
    Dispositivo VARCHAR(100) NOT NULL,
    Ultimo_acceso TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_autenticacion_usuario FOREIGN KEY (ID_usuario) REFERENCES Usuario(ID_usuario) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Servicio (
    ID_servicio INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_servicio VARCHAR(100) NOT NULL UNIQUE,
    Descripcion TEXT NOT NULL,
    Costo_base DECIMAL(10,2) NOT NULL,
    disponible BOOLEAN DEFAULT TRUE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Detalle_servicio (
    detalle_id INT AUTO_INCREMENT PRIMARY KEY,
    ID_usuario INT NOT NULL,
    ID_servicio INT NOT NULL,
    CONSTRAINT fk_detalle_usuario FOREIGN KEY (ID_usuario) REFERENCES Usuario(ID_usuario) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_detalle_servicio FOREIGN KEY (ID_servicio) REFERENCES Servicio(ID_servicio) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Pago (
    ID_pago INT AUTO_INCREMENT PRIMARY KEY,
    ID_usuario INT NOT NULL,
    Monto DECIMAL(10,2) NOT NULL,
    Fecha_pago DATE NOT NULL,
    Metodo_pago ENUM('Tarjeta', 'PayPal', 'Transferencia', 'Crypto') NOT NULL,
    Estado_pago ENUM('Completado', 'Pendiente', 'Fallido') NOT NULL,
    notificado_correo BOOLEAN DEFAULT FALSE,
    CONSTRAINT fk_pago_usuario FOREIGN KEY (ID_usuario) REFERENCES Usuario(ID_usuario) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Auditoria_acceso (
    ID_auditoria INT AUTO_INCREMENT PRIMARY KEY,
    ID_usuario INT NOT NULL,
    Accion VARCHAR(150) NOT NULL,
    IP_origen VARCHAR(45) NOT NULL,
    Fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_auditoria_usuario FOREIGN KEY (ID_usuario) REFERENCES Usuario(ID_usuario) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;