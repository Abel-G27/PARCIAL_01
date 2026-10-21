USE enterprise_db;

-- 1. Insercion en Usuario
INSERT INTO Usuario (Nombre, Correo, Fecha_registro, Estado, activo_sistema) VALUES
('Carlos Gomez', 'carlos.gomez@empresa.com', '2026-01-10', 'Activo', TRUE),
('Ana Rodriguez', 'ana.rodriguez@empresa.com', '2026-01-15', 'Activo', TRUE),
('Luis Martinez', 'luis.martinez@empresa.com', '2026-02-01', 'Inactivo', FALSE),
('Maria Perez', 'maria.perez@empresa.com', '2026-02-10', 'Activo', TRUE),
('Jorge Torres', 'jorge.torres@empresa.com', '2026-02-20', 'Suspendido', FALSE),
('Lucia Fernandez', 'lucia.fernandez@empresa.com', '2026-03-01', 'Activo', TRUE),
('Pedro Ramirez', 'pedro.ramirez@empresa.com', '2026-03-05', 'Activo', TRUE),
('Sofia Castro', 'sofia.castro@empresa.com', '2026-03-12', 'Inactivo', TRUE),
('David Morales', 'david.morales@empresa.com', '2026-03-18', 'Activo', TRUE),
('Elena Ruiz', 'elena.ruiz@empresa.com', '2026-03-25', 'Activo', TRUE);

-- 2. Insercion en Servicio
INSERT INTO Servicio (Nombre_servicio, Descripcion, Costo_base, disponible) VALUES
('Hosting Cloud Basico', 'Servidor en la nube con 2GB RAM y 50GB SSD', 15.00, TRUE),
('Hosting Cloud Pro', 'Servidor en la nube con 8GB RAM y 200GB SSD', 45.00, TRUE),
('Base de Datos SQL Master', 'Instancia administrada de base de datos relacional', 30.00, TRUE),
('Respaldo Automatico Diario', 'Copias de seguridad cifradas en la nube', 10.00, TRUE),
('Certificado SSL Wildcard', 'Seguridad HTTPS para subdominios ilimitados', 50.00, TRUE),
('Dominio .com Anual', 'Registro de dominio web por un año', 12.00, TRUE),
('CDN Global Enterprise', 'Distribucion de contenido de alta velocidad', 80.00, TRUE),
('Monitoreo 24/7 de Servidores', 'Alertas tempranas y supervision de caidas', 25.00, TRUE),
('Correo Corporativo Pro', 'Buzones de correo electronico con dominio propio', 20.00, TRUE),
('Proteccion DDoS Avanzada', 'Mitigacion de ataques de denegacion de servicio', 100.00, TRUE);

-- 3. Insercion en Autenticacion (10 registros, vinculados a los 10 usuarios)
INSERT INTO Autenticacion (ID_usuario, Contrasena, Token, Dispositivo, Ultimo_acceso) VALUES
(1, 'HashSecurePass1$', 'tok_abc111', 'Windows PC - Chrome', CURRENT_TIMESTAMP),
(2, 'HashSecurePass2$', 'tok_abc222', 'MacBook Pro - Safari', CURRENT_TIMESTAMP),
(3, 'HashSecurePass3$', NULL, 'Linux Mint - Firefox', CURRENT_TIMESTAMP),
(4, 'HashSecurePass4$', 'tok_abc444', 'Windows PC - Edge', CURRENT_TIMESTAMP),
(5, 'HashSecurePass5$', NULL, 'iPhone 15 - Safari Mobile', CURRENT_TIMESTAMP),
(6, 'HashSecurePass6$', 'tok_abc666', 'Android - Chrome Mobile', CURRENT_TIMESTAMP),
(7, 'HashSecurePass7$', 'tok_abc777', 'Windows PC - Chrome', CURRENT_TIMESTAMP),
(8, 'HashSecurePass8$', NULL, 'MacBook Air - Chrome', CURRENT_TIMESTAMP),
(9, 'HashSecurePass9$', 'tok_abc999', 'Linux Ubuntu - Brave', CURRENT_TIMESTAMP),
(10, 'HashSecurePass10$', 'tok_abc101', 'iPad Pro - Safari', CURRENT_TIMESTAMP);

-- 4. Insercion en Detalle_servicio (usuarios y servicios)
INSERT INTO Detalle_servicio (ID_usuario, ID_servicio) VALUES
(1, 1),
(1, 4),
(2, 2),
(3, 6),
(4, 3),
(5, 7),
(6, 5),
(7, 8),
(8, 9),
(9, 10);

-- 5. Insercion en Pago
INSERT INTO Pago (ID_usuario, Monto, Fecha_pago, Metodo_pago, Estado_pago, notificado_correo) VALUES
(1, 25.00, '2026-01-11', 'Tarjeta', 'Completado', TRUE),
(2, 45.00, '2026-01-16', 'PayPal', 'Completado', TRUE),
(3, 12.00, '2026-02-02', 'Transferencia', 'Completado', TRUE),
(4, 30.00, '2026-02-11', 'Crypto', 'Completado', TRUE),
(5, 80.00, '2026-02-21', 'Tarjeta', 'Fallido', FALSE),
(6, 50.00, '2026-03-02', 'PayPal', 'Completado', TRUE),
(7, 25.00, '2026-03-06', 'Tarjeta', 'Completado', TRUE),
(8, 20.00, '2026-03-13', 'Transferencia', 'Pendiente', FALSE),
(9, 100.00, '2026-03-19', 'Crypto', 'Completado', TRUE),
(10, 15.00, '2026-03-26', 'Tarjeta', 'Completado', TRUE);

-- 6. Insercion en Auditoria_acceso
INSERT INTO Auditoria_acceso (ID_usuario, Accion, IP_origen, Fecha_hora) VALUES
(1, 'LOGIN_SUCCESS', '190.140.22.10', CURRENT_TIMESTAMP),
(2, 'UPDATE_PROFILE', '186.177.10.5', CURRENT_TIMESTAMP),
(3, 'PASSWORD_CHANGE', '201.220.15.88', CURRENT_TIMESTAMP),
(4, 'LOGIN_SUCCESS', '190.140.22.11', CURRENT_TIMESTAMP),
(5, 'LOGIN_FAILED', '181.115.40.2', CURRENT_TIMESTAMP),
(6, 'SERVICE_SUBSCRIBE', '190.140.22.15', CURRENT_TIMESTAMP),
(7, 'LOGIN_SUCCESS', '186.177.10.9', CURRENT_TIMESTAMP),
(8, 'LOGOUT', '201.220.15.99', CURRENT_TIMESTAMP),
(9, 'API_KEY_GENERATE', '190.140.22.30', CURRENT_TIMESTAMP),
(10, 'LOGIN_SUCCESS', '186.177.10.22', CURRENT_TIMESTAMP);