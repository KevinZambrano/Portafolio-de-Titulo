CREATE TABLE persona(
rut NUMBER(8) NOT NULL,
digito_verificador VARCHAR2(2)
nombres VARCHAR2(50) NOT NULL,
apellido_paterno VARCHAR2(40) NOT NULL,
apellido_materno VARCHAR2(40) NOT NULL,
direccion VARCHAR2(50) NOT NULL,
id_comuna NUMBER(11) NOT NULL,
id_provincia NUMBER(11) NOT NULL,
id_region NUMBER(11) NOT NULL,
fecha_nacimiento DATE NOT NULL,
genero VARCHAR2(10) NOT NULL,
correo_electronico VARCHAR2(40) NOT NULL,
numero_telefonico VARCHAR2(50) NOT NULL,
fecha_registro DATE NOT NULL,
fecha_modificacion DATE NOT NULL,
PRIMARY KEY(rut),
FOREIGN KEY (id_comuna) REFERENCES comuna (id_comuna),
FOREIGN KEY (id_provincia) REFERENCES provincia (id_provincia),
FOREIGN KEY (id_region) REFERENCES region (id_region)
);

CREATE TABLE comuna(
id_comuna NUMBER(11) NOT NULL AUTO_INCREMENT,
nombre VARCHAR2(50) NOT NULL,
codigo_postal VARCHAR2(15) NOT NULL,
fecha_modificacion DATE NOT NULL,
id_provincia NUMBER(11) NOT NULL,
PRIMARY KEY (id_comuna),
FOREIGN KEY (id_provincia) REFERENCES provincia(id_provincia)
);

CREATE TABLE provincia(
id_provincia NUMBER(11) NOT NULL AUTO_INCREMENT,
nombre VARCHAR2(50) NOT NULL,
fecha_modificacion DATE NOT NULL,
id_region NUMBER(11) NOT NULL,
PRIMARY KEY (id_provincia),
FOREIGN KEY (id_region) REFERENCES region(id_region)
);

CREATE TABLE region(
id_region NUMBER(11) NOT NULL AUTO_INCREMENT,
nombre VARCHAR2(50) NOT NULL,
fecha_modificacion DATE NOT NULL,
PRIMARY KEY (id_region)
);

CREATE TABLE cliente(
nombre_cliente VARCHAR2(12) NOT NULL,
password VARCHAR2(8) NOT NULL,
vigente BOOLEAN NOT NULL,
fecha_modificacion DATE NOT NULL,
rut NUMBER(8) NOT NULL,
PRIMARY KEY (nombre_cliente),
FOREIGN KEY (rut) REFERENCES persona(rut)
);

CREATE TABLE usuario(
nombre_usuario VARCHAR2(12) NOT NULL,
password VARCHAR2(8) NOT NULL,
fecha_contratacion DATE,
tipo_trabajador VARCHAR2(50),
fecha_modificacion DATE NOT NULL,
vigente BOOLEAN NOT NULL,
rut NUMBER(8) NOT NULL,
PRIMARY KEY (nombre_usuario),
FOREIGN KEY (rut) REFERENCES persona(rut)
);

CREATE TABLE producto(
id_producto NUMBER(11) NOT NULL AUTO_INCREMENT,
nombre VARCHAR2(20) NOT NULL,
fecha_modificacion DATE NOT NULL,
categoria VARCHAR2(20) NOT NULL,
estado BOOLEAN NOT NULL,
PRIMARY KEY (id_producto)
);

CREATE TABLE stock(
id_stock NUMBER(70) NOT NULL AUTO_INCREMENT,
cantidad_disponible NUMBER(11) NOT NULL,
id_producto NUMBER(11) NOT NULL,
estado BOOLEAN NOT NULL,
PRIMARY KEY (id_stock),
FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

CREATE TABLE menu(
id_menu NUMBER(11) NOT NULL AUTO_INCREMENT,
nombre VARCHAR2(50) NOT NULL,
precio NUMBER(11) NOT NULL,
estado BOOLEAN,
fecha_modificacion DATE NOT NULL,
id_producto NUMBER(11) NOT NULL,
PRIMARY KEY (id_menu),
FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);

CREATE TABLE pedido(
id_pedido NUMBER(100) NOT NULL AUTO_INCREMENT,
fecha_modificacion DATE NOT NULL,
id_menu NUMBER(11) NOT NULL,
cantidad NUMBER(11) NOT NULL,
PRIMARY KEY(id_pedido),
FOREIGN KEY (id_menu) REFERENCES menu(id_menu)
);

CREATE TABLE chofer(
id_chofer NUMBER(11) NOT NULL AUTO_INCREMENT,
disponibilidad BOOLEAN NOT NULL,
nombre_usuario VARCHAR2(12) NOT NULL,
PRIMARY KEY(id_chofer),
FOREIGN KEY (nombre_usuario) REFERENCES usuario(nombre_usuario)
);

CREATE TABLE pedido_web(
id_pedido NUMBER(100) NOT NULL AUTO_INCREMENT,
fecha_modificacion DATE NOT NULL,
id_menu NUMBER(11) NOT NULL,
cantidad NUMBER(11) NOT NULL,
id_chofer NUMBER(11) NOT NULL,
PRIMARY KEY(id_pedido),
FOREIGN KEY (id_menu) REFERENCES menu(id_menu),
FOREIGN KEY (id_chofer) REFERENCES chofer(id_chofer)
);

create table detalle_boleta(
id_detalle_boleta NUMBER(100) NOT NULL AUTO_INCREMENT,
fecha_modificacion DATE NOT NULL,
id_boleta NUMBER(100) NOT NULL,
id_pedido NUMBER(100) NOT NULL,
total NUMBER(11) NOT NULL,
forma_pago VARCHAR2(30) NOT NULL,
PRIMARY KEY(id_detalle_boleta),
FOREIGN KEY (id_boleta) REFERENCES boleta(id_boleta),
FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
);

CREATE TABLE boleta(
id_boleta NUMBER(100) NOT NULL AUTO_INCREMENT,
fecha_emision DATE NOT NULL,
fecha_modificacion DATE NOT NULL,
nombre_usuario VARCHAR2(12) NOT NULL,
nombre_cliente VARCHAR2(12) NOT NULL,
PRIMARY KEY(id_boleta),
FOREIGN KEY (nombre_usuario) REFERENCES usuario(nombre_usuario),
FOREIGN KEY (nombre_cliente) REFERENCES cliente(nombre_cliente)
);

CREATE TABLE venta(
id_venta NUMBER(100) NOT NULL AUTO_INCREMENT,
id_detalle_boleta NUMBER(100),
total_mensual NUMBER(15) NOT NULL,
PRIMARY KEY (id_venta),
FOREIGN KEY (id_detalle_boleta) REFERENCES detalle_boleta(id_detalle_boleta)
);