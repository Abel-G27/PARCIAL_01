USE pixel_db;

-- 1. Insercion en Tipo_usuario (roles)
INSERT INTO Tipo_usuario (Rol) VALUES
('Cliente'),
('Admin'),
('Auditor'),
('Invitado');

-- 2. Insercion en Tipo_prueba
INSERT INTO Tipo_prueba (Referencia, Nombre, Estado, Descripcion, Fecha_ingreso, prueba_automatizada) VALUES
('PRUEBA-01', 'Pentesting Web OWASP Top 10', 'Activo', 'Evaluacion de vulnerabilidades comunes en aplicaciones web', '2026-01-05', TRUE),
('PRUEBA-02', 'Auditoria de Redes Wi-Fi', 'Activo', 'Pruebas de penetracion inalambrica corporativa', '2026-01-12', FALSE),
('PRUEBA-03', 'Analisis de Codigo Fuente (SAST)', 'Activo', 'Revision estatica de seguridad en repositorios', '2026-01-20', TRUE),
('PRUEBA-04', 'Simulacion de Phishing', 'Activo', 'Campana controlada de correo malicioso para empleados', '2026-02-01', TRUE),
('PRUEBA-05', 'Pruebas de Docker y Contenedores', 'En Desarrollo', 'Auditoria de configuraciones y fugas en imagenes', '2026-02-10', TRUE),
('PRUEBA-06', 'Revision de Firewall perimetral', 'Activo', 'Validacion de reglas de filtrado y puertos abiertos', '2026-02-15', FALSE),
('PRUEBA-07', 'Pentesting de APIs RESTful', 'Activo', 'Pruebas de inyeccion y control de acceso en endpoints', '2026-03-01', TRUE),
('PRUEBA-08', 'Analisis Forense Digital', 'Descontinuado', 'Investigacion de incidentes de seguridad historicos', '2026-03-05', FALSE),
('PRUEBA-09', 'Hardening de Sistemas Linux', 'Activo', 'Blindaje de configuraciones base en Ubuntu/Mint', '2026-03-12', FALSE),
('PRUEBA-10', 'Evaluacion de Cifrado y BD', 'Activo', 'Verificacion de seguridad en bases de datos Oracle/MySQL', '2026-03-20', TRUE);

-- 3. Insercion en Usuario
INSERT INTO Usuario (ID_tipo_usuario, Nombre, Apellido, Nombre_usuario, Tipo_empresa, Token, Sexo, Contrasena, Estado_civil, Ciudad, verificado) VALUES
(1, 'Roberto', 'Mendoza', 'rmendoza', 'Fintech Latam', 'tok_p111', 'Masculino', 'PixelPass1$', 'Casado', 'Panama', TRUE),
(1, 'Valeria', 'Rios', 'vrios', 'Logistica Global', 'tok_p222', 'Femenino', 'PixelPass2$', 'Soltero', 'Colon', TRUE),
(2, 'Esteban', 'Quintero', 'equintero', 'Pixel Security Core', 'tok_p333', 'Masculino', 'PixelPass3$', 'Soltero', 'Panama', TRUE),
(3, 'Carla', 'Soto', 'csoto', 'Auditores Asociados', 'tok_p444', 'Femenino', 'PixelPass4$', 'Casado', 'David', TRUE),
(1, 'Marcos', 'Vargas', 'mvargas', 'E-Commerce Central', NULL, 'Masculino', 'PixelPass5$', 'Soltero', 'Santiago', FALSE),
(1, 'Daniela', 'Navarro', 'dnavarro', 'Cloud Solutions', 'tok_p666', 'Femenino', 'PixelPass6$', 'Casado', 'Panama', TRUE),
(4, 'Julian', 'Acosta', 'jacosta', 'Invitados Externos', NULL, 'Masculino', 'PixelPass7$', 'Soltero', 'Chitre', FALSE),
(3, 'Monica', 'Salas', 'msalas', 'Global Compliance', 'tok_p888', 'Femenino', 'PixelPass8$', 'Casado', 'Panama', TRUE),
(1, 'Gabriel', 'Ortiz', 'gortiz', 'Retail Digital', 'tok_p999', 'Masculino', 'PixelPass9$', 'Soltero', 'Penonome', TRUE),
(1, 'Sofia', 'Jimenez', 'sjimenez', 'HealthTech Secure', 'tok_p101', 'Femenino', 'PixelPass10$', 'Casado', 'Panama', TRUE);

-- 4. Insercion en Autenticacion
INSERT INTO Autenticacion (ID_usuario, Agente_usuario, Nombre_usuario, Contrasena, Token) VALUES
(1, 'Mozilla/5.0 (Windows NT 10.0)', 'rmendoza', 'PixelPass1$', 'tok_auth1'),
(2, 'Mozilla/5.0 (Macintosh)', 'vrios', 'PixelPass2$', 'tok_auth2'),
(3, 'Mozilla/5.0 (X11; Linux x86_64)', 'equintero', 'PixelPass3$', 'tok_auth3'),
(4, 'Mozilla/5.0 (Windows NT 10.0)', 'csoto', 'PixelPass4$', 'tok_auth4'),
(5, 'Mozilla/5.0 (iPhone; CPU iPhone)', 'mvargas', 'PixelPass5$', NULL),
(6, 'Mozilla/5.0 (Android 14)', 'dnavarro', 'PixelPass6$', 'tok_auth6'),
(7, 'Mozilla/5.0 (Windows NT 10.0)', 'jacosta', 'PixelPass7$', NULL),
(8, 'Mozilla/5.0 (Macintosh)', 'msalas', 'PixelPass8$', 'tok_auth8'),
(9, 'Mozilla/5.0 (X11; Ubuntu)', 'gortiz', 'PixelPass9$', 'tok_auth9'),
(10, 'Mozilla/5.0 (iPad; CPU OS)', 'sjimenez', 'PixelPass10$', 'tok_auth10');

-- 5. Insercion en Reporte
INSERT INTO Reporte (ID_usuario, ID_prueba, Resultado) VALUES
(1, 1, 'Se encontraron 2 vulnerabilidades de tipo XSS reflejado en los formularios de contacto.'),
(2, 2, 'Red Wi-Fi corporativa segura con protocolo WPA3 Enterprise implementado correctamente.'),
(4, 3, 'El codigo fuente presenta credenciales hardcodeadas en el archivo de configuracion principal.'),
(5, 4, 'El 15% de los empleados cayo en la simulacion de phishing corporativo.'),
(6, 5, 'Contenedor Docker ejecutandose con privilegios de root excesivos.'),
(8, 6, 'Reglas de firewall correctas, se detecto un puerto innecesario abierto (21 FTP).'),
(9, 7, 'Falta de validacion de tokens JWT en endpoints criticos de la API de pagos.'),
(10, 9, 'Hardening de Linux aplicado con exito, servicios innecesarios deshabilitados.'),
(1, 10, 'Base de datos con cifrado de columnas activo, contraseñas seguras con Argon2.'),
(2, 1, 'Revision periodica de seguridad realizada satisfactoriamente.');

-- 6. Insercion en Pago (10 registros de tarjetas para Pixel)
INSERT INTO Pago (ID_usuario, Numero_tarjeta, CVV, Es_tarjeta_defecto) VALUES
(1, '4532189023418821', '492', TRUE),
(2, '5412758091234410', '182', TRUE),
(3, '4000123456789010', '881', TRUE),
(4, '378282246310005', '391', TRUE),
(5, '4532189023419999', '123', FALSE),
(6, '5412758091235555', '456', TRUE),
(7, '4000123456781111', '789', TRUE),
(8, '378282246312222', '321', FALSE),
(9, '4532189023413333', '654', TRUE),
(10, '5412758091237777', '987', TRUE);