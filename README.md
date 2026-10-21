# PARCIAL_01
-__- Parcial #1 de BdD II

## PARTE I: Sistema Empresarial de Servicios Digitales

### 1. Descripción General del Sistema
El módulo del **Sistema Empresarial de Servicios Digitales** está diseñado para gestionar el ciclo de vida completo de la interacción de los usuarios dentro de la plataforma corporativa. Contempla la administración de identidades, credenciales de acceso, suscripción a servicios digitales, procesamiento de pagos y un registro detallado de auditoría de seguridad para cada evento de acceso.

---

### 2. Definición y Justificación de las Tablas (Entidades)

#### A. Tabla: `USUARIO`
* **Propósito:** Almacenar la información básica de identificación de los clientes o usuarios de la plataforma empresarial.
* **Campos y Definiciones:**
  * `ID_usuario` (PK, INT, AUTO_INCREMENT): Identificador único primordial de cada usuario dentro del sistema.
  * `Nombre` (VARCHAR(100), NOT NULL): Nombre completo o razón social del usuario registrado.
  * `Correo` (VARCHAR(100), UNIQUE, NOT NULL): Correo electrónico principal. Se establece como `UNIQUE` para evitar registros duplicados.
  * `Fecha_registro` (DATETIME, NOT NULL): Fecha y hora exacta en la que el usuario creó su cuenta.
  * `Estado` (BOOLEAN, NOT NULL): Estado activo (`1`) o inactivo (`0`) de la cuenta.

#### B. Tabla: `AUTENTICACION`
* **Propósito:** Desacoplar los datos sensibles de inicio de sesión de la tabla principal de usuarios, mejorando la seguridad y permitiendo un control rígido sobre los tokens y dispositivos de acceso.
* **Campos y Definiciones:**
  * `ID_auten` (PK, INT, AUTO_INCREMENT): Identificador único del registro de credenciales.
  * `ID_usuario` (FK, INT, UNIQUE, NOT NULL): Clave foránea que conecta directamente con la tabla `USUARIO`. Al ser `UNIQUE`, garantiza la relación 1 a 1.
  * `Contraseña` (VARCHAR(255), NOT NULL): Hash encriptado de la clave de acceso del usuario (nunca en texto plano).
  * `Token` (VARCHAR(255), NULL): Token JWT o de sesión para la autenticación de solicitudes en la plataforma.
  * `Dispositivo` (VARCHAR(100), NOT NULL): Nombre o User-Agent del dispositivo registrado desde el cual se autentica.
  * `Ultimo_acceso` (DATETIME, NULL): Marca temporal de la última vez que el usuario inició sesión exitosamente.

#### C. Tabla: `SERVICIO`
* **Propósito:** Funcionar como el catálogo centralizado de servicios digitales ofrecidos por la empresa (p. ej., hosting, licencias de software, almacenamiento en la nube).
* **Campos y Definiciones:**
  * `ID_servicio` (PK, INT, AUTO_INCREMENT): Identificador único del servicio dentro del catálogo.
  * `Nombre_servicio` (VARCHAR(100), NOT NULL): Denominación comercial del servicio.
  * `Descripcion` (TEXT, NULL): Detalle y alcance del servicio digital.
  * `Costo_base` (DECIMAL(10,2), NOT NULL): Monto monetario estandarizado del servicio.

#### D. Tabla: `SERVICIO_CONTRATADO` (Entidad Asociativa / Intermedia)
* **Propósito:** Resolver la relación de Muchos a Muchos (N:M) entre usuarios y servicios, permitiendo además registrar atributos propios del contrato o suscripción.
* **Campos y Definiciones:**
  * `ID_contrato` (PK, INT, AUTO_INCREMENT): Identificador único de la suscripción/contratación.
  * `ID_usuario` (FK, INT, NOT NULL): Referencia al usuario que adquiere el servicio.
  * `ID_servicio` (FK, INT, NOT NULL): Referencia al servicio contratado.
  * `Fecha_contratacion` (DATETIME, NOT NULL): Fecha en la que se activa la suscripción.
  * `Estado_servicio` (ENUM('Activo', 'Suspendido', 'Cancelado'), NOT NULL): Estado de la suscripción del servicio para ese usuario particular.

#### E. Tabla: `PAGO`
* **Propósito:** Registrar las transacciones financieras ejecutadas por los usuarios dentro del sistema.
* **Campos y Definiciones:**
  * `ID_pago` (PK, INT, AUTO_INCREMENT): Identificador único de la transacción de pago.
  * `ID_usuario` (FK, INT, NOT NULL): Clave foránea que vincula la transacción con el usuario que realiza el pago.
  * `Monto` (DECIMAL(10,2), NOT NULL): Valor numérico total pagado en la transacción.
  * `Fecha_pago` (DATETIME, NOT NULL): Marca de tiempo del procesamiento del pago.
  * `Metodo_pago` (ENUM('Tarjeta', 'Transferencia', 'PayPal'), NOT NULL): Canal utilizado para procesar la transacción.
  * `Estado_pago` (ENUM('Completado', 'Pendiente', 'Fallido'), NOT NULL): Estatus del procesamiento del cobro.

#### F. Tabla: `AUDITORIA_ACCESO`
* **Propósito:** Mantener un registro inmutable de eventos de acceso para cumplir con políticas de trazabilidad y ciberseguridad.
* **Campos y Definiciones:**
  * `ID_auditoria` (PK, INT, AUTO_INCREMENT): Identificador único del evento de auditoría.
  * `ID_usuario` (FK, INT, NOT NULL): Referencia al usuario que generó el evento de acceso.
  * `Accion` (VARCHAR(100), NOT NULL): Descripción del evento (p. ej., "Login exitoso", "Intento fallido", "Cambio de contraseña").
  * `IP_origen` (VARCHAR(45), NOT NULL): Dirección IP (IPv4 o IPv6) desde la cual se realizó la petición.
  * `Fecha_hora` (DATETIME, NOT NULL): Momento exacto del registro del evento.

---

### 3. Justificación Técnica de las Relaciones y Cardinalidades

1. **`USUARIO` a `AUTENTICACION` — Relación (1:1)**
   * **Justificación:** Un usuario registrado en la plataforma posee un único perfil/conjunto de credenciales activas de autenticación en la tabla `AUTENTICACION`, y a su vez, cada registro de credencial pertenece a un solo usuario. Esta separación permite aislar datos sensibles y aplicar políticas estricta de seguridad sin recargar la tabla principal de perfil de usuario.

2. **`USUARIO` a `PAGO` — Relación (1:N)**
   * **Justificación:** Un único usuario puede realizar múltiples transacciones financieras a lo largo del tiempo (1 a Muchos). Sin embargo, un registro de pago específico pertenece obligatoriamente a un solo usuario emisor.

3. **`USUARIO` a `AUDITORIA_ACCESO` — Relación (1:N)**
   * **Justificación:** Un usuario puede generar infinitos eventos de acceso y actividad a lo largo del tiempo (1 a Muchos). Cada fila en la tabla de auditoría corresponde a un evento único generado por un solo usuario específico.

4. **`USUARIO` a `SERVICIO` — Relación (N:M) mediante `SERVICIO_CONTRATADO`**
   * **Justificación:** Un usuario puede contratar múltiples servicios digitales al mismo tiempo, y un servicio del catálogo puede ser adquirido por múltiples usuarios diferentes (Muchos a Muchos). Para cumplir con la **Primera Forma Normal (1FN)** y evitar campos repetitivos, la relación se descompone en dos relaciones (1:N) utilizando la entidad asociativa `SERVICIO_CONTRATADO`.
   ## Diagrama Entidad-Relación (Parte I)
![DER Sistema Empresarial](./Imagenes/Captura%20de%20pantalla%202026-10-19%20120342.png)

---

## PARTE III: Startup Pixel-Security-360 (Pentesting Platform)

### 1. Descripción General del Sistema
La plataforma web ***One-Click One-Security*** desarrollada para la startup **Pixel-Security-360** permite a los clientes solicitar, visualizar y administrar ejecuciones de pruebas de penetración de seguridad (*pentesting*). El modelo de datos administra el ciclo completo: desde el registro y autenticación del cliente, la gestión de roles empresariales, la selección del tipo de prueba basada en el estándar del proceso de ciberseguridad, la pasarela de pagos mediante tarjeta y la emisión del informe técnico correspondiente.

---

### 2. Definición y Justificación de las Tablas (Entidades y Módulos)

#### A. Módulo de Roles: `TIPO_USUARIO`
* **Propósito:** Categorizar el perfil y nivel de acceso de los usuarios dentro de la plataforma.
* **Campos y Definiciones:**
  * `ID_tipo_usuario` (PK, INT, AUTO_INCREMENT): Identificador único del rol.
  * `Rol` (VARCHAR(50), NOT NULL): Nombre del rol dentro del sistema (`Cliente`, `Administrador`, `Vendedor`, `Ejecutivo`, u otros).

#### B. Módulo de Usuario: `USUARIO`
* **Propósito:** Almacenar la información demográfica, corporativa y personal de los clientes y personal interno.
* **Campos y Definiciones:**
  * `ID_usuario` (PK, INT, AUTO_INCREMENT): Identificador único del usuario.
  * `ID_tipo_usuario` (FK, INT, NOT NULL): Clave foránea que asigna un rol desde la tabla `TIPO_USUARIO`.
  * `Nombre` (VARCHAR(50), NOT NULL): Nombre del usuario.
  * `Apellido` (VARCHAR(50), NOT NULL): Apellido del usuario.
  * `Nombre_usuario` (VARCHAR(50), UNIQUE, NOT NULL): Nombre de usuario/alias para acceso al sistema.
  * `Tipo_empresa` (ENUM('pública', 'privada'), NOT NULL): Clasificación del tipo de organización del cliente.
  * `Ciudad` (VARCHAR(100), NOT NULL): Ciudad de ubicación del cliente/empresa.
  * `Sexo` (VARCHAR(20), NOT NULL): Identificador de género del usuario.
  * `Estado_civil` (VARCHAR(20), NOT NULL): Estado civil registrado del usuario.
  * `Direccion` (TEXT, NOT NULL): Dirección física completa.

#### C. Módulo de Autenticación: `AUTENTICACION`
* **Propósito:** Aislar las credenciales de acceso, sesiones activas y trazabilidad de los dispositivos conectados.
* **Campos y Definiciones:**
  * `ID_autenticacion` (PK, INT, AUTO_INCREMENT): Identificador único de la sesión/credencial.
  * `ID_usuario` (FK, INT, NOT NULL): Clave foránea vinculada al usuario emisor.
  * `Nombre_usuario` (VARCHAR(50), NOT NULL): Alias utilizado durante el evento de autenticación.
  * `Contraseña` (VARCHAR(255), NOT NULL): Hash encriptado de la contraseña de acceso.
  * `Agente_usuario` (VARCHAR(255), NOT NULL): Identificador del navegador o dispositivo desde el cual se realiza el acceso (`User-Agent`).
  * `Token` (VARCHAR(255), NOT NULL): Token de seguridad o JWT emitido para validar la sesión.

#### D. Módulo de Catálogo: `TIPO_PRUEBA`
* **Propósito:** Registrar el catálogo oficial de servicios de pruebas de penetración basados en el ciclo de vida del *pentesting*.
* **Campos y Definiciones:**
  * `ID_prueba` (PK, INT, AUTO_INCREMENT): Identificador del tipo de prueba.
  * `Referencia` (VARCHAR(50), UNIQUE, NOT NULL): Código alfanumérico único para identificación en catálogo.
  * `Nombre` (VARCHAR(100), NOT NULL): Fase de seguridad correspondiente (`1. Reconocimiento`, `2. Análisis de Vulnerabilidades`, `3. Explotación`, `4. Escalar Privilegios o Post-Explotación`, `5. Informe`).
  * `Descripcion` (TEXT, NULL): Detalle metodológico y alcance de la prueba de ciberseguridad.
  * `Fecha_ingreso` (DATE, NOT NULL): Fecha en la que la prueba fue dada de alta en el sistema.
  * `Estado` (ENUM('activo', 'desactivado'), NOT NULL): Disponibilidad del servicio en el catálogo.

#### E. Módulo de Transacciones: `PAGO`
* **Propósito:** Almacenar la información necesaria del método y formulario de pago registrado por el usuario para contratar pruebas de seguridad.
* **Campos y Definiciones:**
  * `ID_pago` (PK, INT, AUTO_INCREMENT): Identificador único del registro de pago.
  * `ID_usuario` (FK, INT, NOT NULL): Referencia al cliente que realiza el pago.
  * `Numero_tarjeta` (VARCHAR(20), NOT NULL): Número de la tarjeta de crédito (Visa, Mastercard, Discover, etc.).
  * `Nombre_titular` (VARCHAR(100), NOT NULL): Nombre del tarjetahabiente tal como figura en el plástico.
  * `CVV` (VARCHAR(4), NOT NULL): Código de seguridad del reverso de la tarjeta.
  * `Fecha_expiracion` (VARCHAR(7), NOT NULL): Fecha de caducidad de la tarjeta (`MM/YYYY`).
  * `Es_tarjeta_defecto` (BOOLEAN, NOT NULL): Indicador de si la tarjeta está marcada como método de pago predeterminado.

#### F. Módulo de Evaluación: `REPORTE` (Entidad Asociativa N:M)
* **Propósito:** Relacionar a los clientes con las pruebas de penetración contratadas y almacenar el resultado técnico o informe final.
* **Campos y Definiciones:**
  * `ID_reporte` (PK, INT, AUTO_INCREMENT): Identificador único del informe de evaluación.
  * `ID_usuario` (FK, INT, NOT NULL): Clave foránea del cliente destinatario del reporte.
  * `ID_prueba` (FK, INT, NOT NULL): Clave foránea que especifica el tipo de prueba de pentesting aplicada.
  * `Resultado` (TEXT, NULL): Detalle técnico, hallazgos o estado del entregable final de la prueba.
  * `Fecha_generacion` (DATETIME, NOT NULL): Marca temporal de creación del reporte.

---

### 3. Justificación Técnica de las Relaciones y Cardinalidades

1. **`TIPO_USUARIO` a `USUARIO` — Relación (1:N)**
   * **Justificación:** Un tipo de usuario o rol (p. ej., `Cliente`) puede asignarse a miles de usuarios dentro del sistema, pero cada usuario individual posee un único rol primario dentro del modelo.

2. **`USUARIO` a `AUTENTICACION` — Relación (1:N)**
   * **Justificación:** Un usuario puede registrar múltiples inicios de sesión desde distintos dispositivos (`Agente_usuario`) generando diversos registros de autenticación a lo largo del tiempo.

3. **`USUARIO` a `PAGO` — Relación (1:N)**
   * **Justificación:** Un usuario puede registrar múltiples métodos o formularios de pago en la plataforma. Cada registro de pago está enlazado a un único usuario propietario.

4. **`USUARIO` y `TIPO_PRUEBA` a `REPORTE` — Relación (N:M) mediante `REPORTE`**
   * **Justificación:** Un cliente puede solicitar múltiples tipos de pruebas de pentesting a lo largo del tiempo, y un mismo tipo de prueba de catálogo (p. ej., *Análisis de Vulnerabilidades*) es ejecutado para múltiples clientes. Para normalizar esta relación de Muchos a Muchos (N:M), la tabla `REPORTE` actúa como la entidad asociativa que conecta al cliente con la prueba correspondiente y guarda el resultado.

---

## Diagrama Entidad-Relación (Parte III)
![DER Pixel-Security-360](./Imagenes/Captura%20de%20pantalla%202026-10-19%20125300.png)


### Justificación Técnica de las Especificaciones del Contenedor

Para garantizar la portabilidad, seguridad y persistencia de la infraestructura del proyecto, se configuraron los siguientes parámetros en el archivo `docker-compose.yml`:

1. **Versión de la Imagen (`image: mysql:8.0`)**:
   * **Justificación**: Se seleccionó MySQL 8.0 por ser el estándar de la industria actual. Ofrece mejoras críticas en rendimiento, optimización de consultas, soporte robusto para restricciones de integridad relacional (DDL/DML) y compatibilidad total con las extensiones de desarrollo en VS Code.

2. **Mapeo de Puertos (`ports: "3306:3306"`)**:
   * **Justificación**: Permite enlazar el puerto estándar de MySQL dentro del contenedor (`3306`) con el mismo puerto en la máquina anfitriona. Esto facilita la conexión directa desde herramientas de gestión de bases de datos locales sin necesidad de instalar un servidor de base de datos pesado directamente en el sistema operativo del equipo.

3. **Persistencia de Datos mediante Volúmenes (`volumes: mysql_data:/var/lib/mysql`)**:
   * **Justificación**: Los contenedores de Docker son efímeros por naturaleza (si se destruyen, se pierde su contenido interno). Implementar un volumen con nombre (`mysql_data`) garantiza que los archivos de datos y tablas de MySQL se almacenen de forma segura en el disco duro del host, asegurando que la información persista aunque el contenedor se apague, se reinicie o se elimine.

4. **Automatización de Variables de Entorno (`MYSQL_ROOT_PASSWORD` y `MYSQL_DATABASE`)**:
   * **Justificación**: Permiten el aprovisionamiento automático (*zero-configuration bootstrap*). Al iniciar el contenedor por primera vez, se configura de manera segura la contraseña del usuario administrador (`root`) y se crea instantáneamente la base de datos vacía llamada `parcial_db`, evitando pasos de configuración manual y estandarizando el entorno para todos los colaboradores del equipo.

## Fase III: Diseño y Estructuración de Bases de Datos (DDL)

Para este proyecto se han diseñado e implementado dos sistemas relacionales independientes dentro de la base de datos `parcial_db`, aplicando restricciones de integridad referencial (`PRIMARY KEY`, `FOREIGN KEY`), llaves candidatas únicas (`UNIQUE`), control de borrados/actualizaciones en cascada y utilizando el motor transaccional `InnoDB` de MySQL 8.0.

### 1. Sistema: Enterprise Digital Services (`enterprise_ddl.sql`)
Este módulo gestiona la relación comercial corporativa, el catálogo de servicios y la asignación de recursos humanos y contractuales:
* **`clientes`**: Almacena la información jurídica y de contacto de las empresas clientes, asegurando la unicidad mediante el RUC/NIT.
* **`empleados`**: Registra al personal corporativo y gestores internos de la organización.
* **`servicios_digitales`**: Catálogo con los servicios tecnológicos ofrecidos y sus respectivos costos mensuales.
* **`contratos`**: Tabla relacional que vincula un cliente, un servicio digital y un empleado asignado, garantizando integridad referencial estricta.

### 2. Sistema: Pixel-Security-360 (`pixel_security_ddl.sql`)
Este módulo está enfocado en la administración de infraestructura de seguridad inteligente, monitoreo de zonas críticas y gestión de incidentes:
* **`zonas`**: Define las áreas físicas de vigilancia y evalúa su nivel de riesgo operativo.
* **`dispositivos`**: Administra los equipos instalados (cámaras, sensores) asociados de forma directa a una zona específica.
* **`personal_seguridad`**: Catálogo del personal operativo, turnos de vigilancia y vías de contacto.
* **`alertas_incidentes`**: Bitácora centralizada de eventos y alertas generadas por los dispositivos, con trazabilidad del personal de seguridad a cargo.