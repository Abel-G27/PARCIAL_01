USE pixel_db;

CREATE TABLE IF NOT EXISTS Tipo_usuario (
    ID_tipo_usuario INT AUTO_INCREMENT PRIMARY KEY,
    Rol ENUM('Cliente', 'Admin', 'Auditor', 'Invitado') NOT NULL UNIQUE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Usuario (
    ID_usuario INT AUTO_INCREMENT PRIMARY KEY,
    ID_tipo_usuario INT NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    Apellido VARCHAR(100) NOT NULL,
    Nombre_usuario VARCHAR(50) NOT NULL UNIQUE,
    Tipo_empresa VARCHAR(100) NOT NULL,
    Token VARCHAR(255) UNIQUE,
    Sexo ENUM('Masculino', 'Femenino', 'Otro') NOT NULL,
    Contrasena VARCHAR(255) NOT NULL,
    Estado_civil ENUM('Soltero', 'Casado', 'Otro') NOT NULL,
    Ciudad VARCHAR(100) NOT NULL,
    verificado BOOLEAN DEFAULT FALSE,
    CONSTRAINT fk_usuario_tipo FOREIGN KEY (ID_tipo_usuario) REFERENCES Tipo_usuario(ID_tipo_usuario) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Autenticacion (
    ID_autenticacio INT AUTO_INCREMENT PRIMARY KEY,
    ID_usuario INT NOT NULL,
    Agente_usuario VARCHAR(255) NOT NULL,
    Nombre_usuario VARCHAR(50) NOT NULL,
    Contrasena VARCHAR(255) NOT NULL,
    Token VARCHAR(255) UNIQUE,
    CONSTRAINT fk_auth_pixel_usuario FOREIGN KEY (ID_usuario) REFERENCES Usuario(ID_usuario) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Tipo_prueba (
    ID_prueba INT AUTO_INCREMENT PRIMARY KEY,
    Referencia VARCHAR(50) NOT NULL UNIQUE,
    Nombre VARCHAR(100) NOT NULL,
    Estado ENUM('Activo', 'Descontinuado', 'En Desarrollo') NOT NULL,
    Descripcion TEXT NOT NULL,
    Fecha_ingreso DATE NOT NULL,
    prueba_automatizada BOOLEAN DEFAULT TRUE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Reporte (
    ID_reporte INT AUTO_INCREMENT PRIMARY KEY,
    ID_usuario INT NOT NULL,
    ID_prueba INT NOT NULL,
    Resultado TEXT NOT NULL,
    CONSTRAINT fk_reporte_usuario FOREIGN KEY (ID_usuario) REFERENCES Usuario(ID_usuario) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_reporte_prueba FOREIGN KEY (ID_prueba) REFERENCES Tipo_prueba(ID_prueba) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS Pago (
    ID_pago INT AUTO_INCREMENT PRIMARY KEY,
    ID_usuario INT NOT NULL,
    Numero_tarjeta VARCHAR(20) NOT NULL UNIQUE,
    CVV VARCHAR(4) NOT NULL,
    Es_tarjeta_defecto BOOLEAN DEFAULT FALSE,
    CONSTRAINT fk_pago_pixel_usuario FOREIGN KEY (ID_usuario) REFERENCES Usuario(ID_usuario) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;