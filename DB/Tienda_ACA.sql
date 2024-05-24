USE bdtienda_aca;


CREATE TABLE administradores(
id_admin INT NOT NULL AUTO_INCREMENT,
Usuario VARCHAR (20) NOT NULL,
contraseña VARCHAR (12) NOT NULL,
Cedula INT NOT NULL,
nombre VARCHAR (60) NOT NULL,
apellido VARCHAR (60) NOT NULL,
email VARCHAR (60) NOT NULL,
telefono VARCHAR (20) NOT NULL,
direccion varchar (60) NOT NULL,
PRIMARY KEY (id_admin));

CREATE TABLE proveedores (
id_proveedores INT NOT NULL AUTO_INCREMENT,
Nit_O_CC INT NOT NULL,
razon_social VARCHAR (60) NOT NULL,
dirección VARCHAR (60) NOT NULL,
telefono INT NOT NULL,
nombre_de_contacto VARCHAR (50),
apellido_de_contacto VARCHAR (50),
PRIMARY KEY (id_proveedores));

ALTER TABLE proveedores ADD referencia_producto varchar (50);

CREATE TABLE clientes(
id_clientes INT NOT NULL AUTO_INCREMENT,
cod_producto INT,
nombre VARCHAR (50) NOT NULL,
apellido VARCHAR (50) NOT NULL,
direccion VARCHAR (50),
telefono int,
email varchar (50),
FOREIGN KEY (cod_producto) references productos (cod_producto),
PRIMARY KEY (id_clientes));

CREATE TABLE productos (
cod_producto INT NOT NULL AUTO_INCREMENT,
administrador INT DEFAULT NULL,
proveedor INT DEFAULT NULL,
referencia_Producto VARCHAR (50),
nombre_producto VARCHAR (80),
valor_producto DOUBLE,
PRIMARY KEY (cod_producto),
FOREIGN KEY (administrador)references administradores(id_admin),
FOREIGN KEY (proveedor)references proveedores (id_proveedores));


CREATE TABLE carrito (
cod_pedido INT NOT NULL AUTO_INCREMENT,
id_clientes INT DEFAULT NULL,
fecha date DEFAULT NULL,
hora TIME DEFAULT NULL,
PRIMARY KEY (cod_pedido),
FOREIGN KEY (id_clientes) REFERENCES clientes (id_clientes));

INSERT INTO carrito (cod_pedido, id_clientes, fecha, hora)
Values ('1','1', '24-05-19', '13:00:00');

INSERT INTO carrito (id_clientes, fecha, hora) 
VALUES (2, '2024-05-20', '14:30:00');

INSERT INTO carrito (id_clientes, fecha, hora) 
VALUES (3, '2024-05-21', '15:45:00');

CREATE TABLE factura (
id_factura INT NOT NULL AUTO_INCREMENT,
cod_pedido INT NOT NULL,
producto INT NOT NULL,
cantidad_Producto INT NOT NULL,
valor_produtos DOUBLE,
valor_descuanto DOUBLE,
valor_iva DOUBLE,
valor_total DOUBLE,
PRIMARY KEY (id_factura),
FOREIGN KEY (producto) references productos (cod_producto),
FOREIGN KEY (cod_pedido) REFERENCES carrito (cod_pedido));

SELECT c.nombre, c.apellido, p.referencia_producto, p.nombre_producto, p.valor_producto
FROM carrito cr
INNER JOIN clientes c ON cr.id_clientes = c.id_clientes
INNER JOIN factura f ON cr.cod_pedido = f.cod_pedido
INNER JOIN productos p ON f.producto = p.cod_producto;


SELECT v.id_venta, f.id_factura, f.cod_pedido, f.producto, f.cantidad_Producto, f.valor_produtos, f.valor_descuanto, f.valor_iva, f.valor_total, p.referencia_producto, p.nombre_producto
FROM venta v
INNER JOIN factura f ON v.factura = f.id_factura
INNER JOIN productos p ON f.producto = p.cod_producto;

-- Crear factura para el producto en el carrito con código de pedido 1
INSERT INTO factura (cod_pedido, producto, cantidad_Producto, valor_produtos, valor_descuanto, valor_iva, valor_total)
VALUES (1, 1, 1, 150000, 0, 28500, 178500);

-- Crear factura para el producto en el carrito con código de pedido 2
INSERT INTO factura (cod_pedido, producto, cantidad_Producto, valor_produtos, valor_descuanto, valor_iva, valor_total)
VALUES (2, 2, 1, 148000, 0, 28120, 176120);

-- Crear factura para el producto en el carrito con código de pedido 3
INSERT INTO factura (cod_pedido, producto, cantidad_Producto, valor_produtos, valor_descuanto, valor_iva, valor_total)
VALUES (3, 3, 1, 152000, 0, 28880, 180880);

CREATE TABLE venta (
id_venta INT  NOT NULL AUTO_INCREMENT,
factura INT  NOT NULL,
Numero_oreden_despacho INT ,
fecha_y_hora_de_entrega DATETIME DEFAULT NULL,
PRIMARY KEY (id_venta),
FOREIGN KEY (factura) REFERENCES factura (id_factura) );

-- Realizar venta para la factura con ID 1
INSERT INTO venta (factura, Numero_oreden_despacho, fecha_y_hora_de_entrega)
VALUES (1, 1, '2024-05-20 09:00:00');

-- Realizar venta para la factura con ID 2
INSERT INTO venta (factura, Numero_oreden_despacho, fecha_y_hora_de_entrega)
VALUES (2, 2, '2024-05-21 10:30:00');

-- Realizar venta para la factura con ID 3
INSERT INTO venta (factura, Numero_oreden_despacho, fecha_y_hora_de_entrega)
VALUES (3, 3, '2024-05-22 11:45:00');




INSERT INTO administradores (usuario, contraseña, cedula, nombre, apellido, email, telefono, direccion)
VALUES ('christian', '1234', '8888', 'CHRISTIAN CAMILO', 'CRUZ ROMERO', 'abcd@sql.sql', '4321', 'calle 80 # 110 - 20');
INSERT INTO administradores (usuario, contraseña, cedula, nombre, apellido, email, telefono, direccion)
VALUES ('edgardo', '5678', '77777', 'EDGARDO', 'RANGEL RODRIGUEZ', 'ghi@sql.sql', '65432', 'calle 54 # 80 - 59');

INSERT INTO proveedores (Nit_O_CC, razon_social, dirección, telefono, nombre_de_contacto, apellido_de_contacto)
VALUES ('9999', 'SLSCS', 'CALLE 26 86-01', '76543', 'CARLO', 'RIVAS');
INSERT INTO proveedores (Nit_O_CC, razon_social, dirección, telefono, nombre_de_contacto, apellido_de_contacto)
VALUES (55555, 'SLSCS', 'CALLE 26 86-01', 75558454, 'NATALIA', 'PEREZ');
INSERT INTO proveedores (Nit_O_CC, razon_social, dirección, telefono, nombre_de_contacto, apellido_de_contacto)
VALUES (553425, 'ABC', 'CALLE 26 86-01', 79558395, 'MARIANA', 'ROJAS');
INSERT INTO proveedores (Nit_O_CC, razon_social, dirección, telefono, nombre_de_contacto, apellido_de_contacto)
VALUES (551341, 'HDJ', 'CALLE 65 72-45', 79558395, 'MARIA LUCIA', 'RODRIGUEZ');
INSERT INTO proveedores (Nit_O_CC, razon_social, dirección, telefono, nombre_de_contacto, apellido_de_contacto)
VALUES (983425, 'ABC', 'CALLE 107 27-01', 69556325, 'MILENA', 'ALDANA');
INSERT INTO proveedores (Nit_O_CC, razon_social, dirección, telefono, nombre_de_contacto, apellido_de_contacto)
VALUES (435435, 'ABC', 'CALLE 189 45-01', 68553392, 'JOHN', 'GOMEZ');
INSERT INTO proveedores (Nit_O_CC, razon_social, dirección, telefono, nombre_de_contacto, apellido_de_contacto)
VALUES (285331, 'LKJ', 'CALLE 99 70-10', 43558834, 'ANGELICA', 'DOMINGUES');
INSERT INTO proveedores (Nit_O_CC, razon_social, dirección, telefono, nombre_de_contacto, apellido_de_contacto)
VALUES (3456708, 'JHLKGK', 'CALLE 12 35-20', 89836396, 'CAMILO', 'VALENCIA');
INSERT INTO proveedores (Nit_O_CC, razon_social, dirección, telefono, nombre_de_contacto, apellido_de_contacto)
VALUES (5712478, 'VBNNM', 'CALLE 48 72-02', 77686375, 'LUZ ANGELA', 'MORENO');
INSERT INTO proveedores (Nit_O_CC, razon_social, dirección, telefono, nombre_de_contacto, apellido_de_contacto)
VALUES (9879785, 'GJKGKJ', 'CALLE 107 27-01', 8976365, 'LUIZ ALBERTO', 'TORRES');
INSERT INTO proveedores (Nit_O_CC, razon_social, dirección, telefono, nombre_de_contacto, apellido_de_contacto)
VALUES (56789876, 'DFGHJHH', 'CALLE 32 15-01', 985567831, 'PABLO', 'PEREZ');



INSERT INTO clientes (nombre, apellido,  direccion, telefono, email)
VALUES ('MAIRA ALEJANDRA', 'MURCIA GARABITO', 'calle 45 # 35 - 20', 4567889, 'alejandra@sql.sql');
INSERT INTO clientes (nombre, apellido,  direccion, telefono, email)
VALUES ('VALERIA SOFIA', 'RIOS CADENA', 'carrera 69 # 24 - 40', 8765443, 'valeria@sql.sql');
INSERT INTO clientes (nombre, apellido,  direccion, telefono, email)
VALUES ('FAIBER', 'CORTES BERMEO', 'calle 87 # 63 - 50', 87654343, 'faiber@sql.sql');
INSERT INTO clientes (nombre, apellido,  direccion, telefono, email)
VALUES ('CARLOS ARIEL', 'CORDOBA MONTENEGRO', 'calle 189 # 54 - 40', 9876543, 'alejandra@sql.sql');
INSERT INTO clientes (nombre, apellido,  direccion, telefono, email)
VALUES ('PRODUCCION FGHJK & CIA', 'N/A', 'calle 127 # 48 - 80', 628344, 'produccioncia@sql.sql');
INSERT INTO clientes (nombre, apellido,  direccion, telefono, email)
VALUES ('INGENIERIA POIUYHJL', 'GDHJKL', 'CARRERA 38 # 35 - 23', 4567889, 'ingenieria@sql.sql');
INSERT INTO clientes (nombre, apellido,  direccion, telefono, email)
VALUES ('CARLOS ERNESTO', 'JARAMILLO', 'TRANSVERSAL 53 # 22 - 87', 4576329, 'carlose@sql.sql');
INSERT INTO clientes (nombre, apellido,  direccion, telefono, email)
VALUES ('ANA MARIA', 'RIAÑO PATIÑO', 'DIGONAL 12 # 35 - 20', 56483920, 'anamaria@sql.sql');
INSERT INTO clientes (nombre, apellido,  direccion, telefono, email)
VALUES ('JASSON ANDRES', 'RAMIREZ MEJIA', 'carrera 27 # 128 - 16', 64784909, 'jramirez@sql.sql');
INSERT INTO clientes (nombre, apellido,  direccion, telefono, email)
VALUES ('YEIMMY CAROLINA', 'MORENO ROJAS', 'carrera 78 # 87 - 73', 6473821, 'yeimic@sql.sql');


DELETE FROM clientes WHERE id_clientes = 5 ;
UPDATE clientes SET email = 'carlosa@sql.sql'
WHERE id_clientes = 8;



INSERT INTO productos (referencia_producto, nombre_producto, valor_producto)
Values ('217 Dama Negro', 'Pantalon Negro Dril', 150000);
INSERT INTO productos (referencia_producto, nombre_producto,valor_producto)
Values ('213 Dama Azul', 'Pantalon Azul Dril', 148000);
INSERT INTO productos (referencia_producto, nombre_producto,valor_producto)
Values ('215 Dama Lila', 'Pantalon Lila Dril', 152000);
INSERT INTO productos (referencia_producto, nombre_producto,valor_producto)
Values ('214 Dama Beige', 'Pantalon Beige Dril', 154000);
INSERT INTO productos (referencia_producto, nombre_producto,valor_producto)
Values ('317 Dama Negro', 'Blusa negro seda', 90000);
INSERT INTO productos (referencia_producto, nombre_producto,valor_producto)
Values ('318 Dama Blanco', 'Blusa Blanco seda', 92000);
INSERT INTO productos (referencia_producto, nombre_producto,valor_producto)
Values ('319 Dama Palo de Rosa', 'Blusa Palo de Rosa seda', 94000);
INSERT INTO productos (referencia_producto, nombre_producto,valor_producto)
Values ('318 Dama Verde Manzana', 'Blusa Verde Manzana seda', 92000);
INSERT INTO productos (referencia_producto, nombre_producto,valor_producto)
Values ('457 Dama Petroleo', 'pantalon Azul Petroleo Jean Calsic', 200000);
INSERT INTO productos (referencia_producto, nombre_producto,valor_producto)
Values ('458 Dama Texturizado', 'pantalon Azul Texturizado Jean Calsic', 200000);
INSERT INTO productos (referencia_producto, nombre_producto,valor_producto)
Values ('459 Dama CLaro', 'pantalon Azul Claro Jean Calsic', 200000);
INSERT INTO productos (referencia_producto, nombre_producto,valor_producto)
Values ('137 Caballero Petroleo', 'pantalon Azul Petroleo Jean Calsic', 240000);
INSERT INTO productos (referencia_producto, nombre_producto,valor_producto)
Values ('138 Caballero Texturizado', 'pantalon Azul Texturizado Jean Calsic', 240000);
INSERT INTO productos (referencia_producto, nombre_producto,valor_producto)
Values ('138 Caballero Claro', 'pantalon Azul Texturizado Jean Calsic', 240000);
INSERT INTO productos (referencia_producto, nombre_producto,valor_producto)
Values ('142 caballero Negro', 'Pantalon Negro Dril', 170000);
INSERT INTO productos (referencia_producto, nombre_producto,valor_producto)
Values ('143 caballero Azul', 'Pantalon Azul Dril', 168000);
INSERT INTO productos (referencia_producto, nombre_producto,valor_producto)
Values ('144 caballero Beige', 'Pantalon Beige Dril', 174000);
INSERT INTO productos (referencia_producto, nombre_producto,valor_producto)
Values ('192 caballero Negro', 'camisa negro algodon', 90000);
INSERT INTO productos (referencia_producto, nombre_producto,valor_producto)
Values ('318 caballero Blanco', 'camisa Blanco algodon', 92000);






