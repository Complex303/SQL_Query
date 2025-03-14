--SELECT TOP 5 * FROM [dbo].[Employees] --ME TRAE LOS PRIMEROS 5 REGISTROS
--SELECT TOP 25 PERCENT * FROM [dbo].[Employees] --ME TRAE UN 25% PORCIENTO DE LOS REGISTROS
--SELECT * FROM [dbo].[Employees] WHERE REGION IS NULL --ME TRAE LOS REGISTROS DONDE LA REGION SEA NULO
--SELECT * FROM [dbo].[Employees] WHERE REGION IS NOT NULL --ME TRAE LOS REGISTROS DONDE LA REGION NO SEA NULO
--UPDATE [dbo].[Employees] SET REGION = null WHERE EmployeeID = 5
--UPDATE [dbo].[clientes] SET DIRECCION = 'No tiene' WHERE direccion is null
--DELETE FROM [dbo].[clientes] WHERE nombre is null
--SELECT * FROM [dbo].[clientes]
--SELECT Coalesce(Nombre, apellido) as 'nombre/apellido', direccion from [dbo].[clientes]

--CREATE TABLE PERSONAS
--(
--	id_personas int,
--	nombre varchar(10) not null,
--	apellido varchar(20) not null,
--	edad int not null
--	constraint PK_enlace_personas PRIMARY KEY (id_personas)
--); --esta es la forma recomendable de crear primary key

--alter table PERSONAS
--ADD CONSTRAINT PK_enlace_personas PRIMARY KEY (id_personas) --esto para cuando ya hemos creado la tabla, y queramos agregar una primary key. recalcar que el campo que vamos a poner como primary key debe de estar como not null, sino no podremos ponerlo como primary key
--ALTER TABLE PERSONAS DROP CONSTRAINT PK_enlace_personas BORRAR UNA PRIMARY KEY
--constraint UQ_Nombre Unique (id_personas) --esto es para que el id_personas sea unico, esto en caso de que id_personas no sea primary key
--a diferencia de los primary key, esto se lo podemos poner a mas de un solo campo, osea que mas de un cambio puede esta definido como unico
--ademas el unique no permite valores repetidos, pero si valores nulos, algo que no paso con el primary key. osea para tener un unique que no permite nulo, solo debemos de indicarlos con el not null

--SELECT * FROM [dbo].[clientes]

--SELECT * FROM [dbo].[PERSONAS]
--ALTER TABLE PERSONAS
--ADD CONSTRAINT CK_Edad CHECK (edad >= 18);

--INSERT INTO PERSONAS VALUES (3, DEFAULT, 'CRUZ', 18);
--ALTER TABLE PERSONAS
--DROP CONSTRAINT CK_Edad



--ALTER TABLE PERSONAS
--ADD CONSTRAINT DF_NOMBRE DEFAULT 'ANONIMO' FOR Nombre;

--USE infomati;
--CREATE TABLE CLIENTE(
--id_cliente INT,
--nombre VARCHAR(15),
--apellido VARCHAR(40),
--edad int,
--CONSTRAINT PK_CLIENTE PRIMARY KEY (id_cliente)

--);

--CREATE TABLE ORDENES
--(
--	id_ordenes INT,
--	articulo varchar(50) NOT NULL,
--	id_cliente INT,
--	CONSTRAINT PK_ORDENES PRIMARY KEY (id_ordenes),
--	CONSTRAINT FK_CLIENTE FOREIGN KEY (id_cliente) REFERENCES CLIENTE (id_cliente)
--	ON DELETE CASCADE --Permite borrar registro relecionado entre ambas tablas o cualquier tabla a la que este enlazando la llave foranea
--);

--ALTER TABLE ORDENES 
--ALTER COLUMN id_cliente INT;

--INSERT INTO CLIENTE VALUES (1,'Jose', 'Perez', 19);
--INSERT INTO CLIENTE VALUES (2,'Carlos', 'Cruz', 24);
--INSERT INTO ORDENES VALUES (1,'laptop', 1)
--INSERT INTO ORDENES VALUES (2, 'PC', 1);
--INSERT INTO ORDENES VALUES (3, 'TECLADO',NULL);
--INSERT INTO ORDENES VALUES (4, 'MOUSE',2), (5, 'Monitor',2)

--SELECT * FROM CLIENTE;
--SELECT * FROM ORDENES;
--DROP TABLE ORDENES;
--DROP TABLE CLIENTE;
--DELETE FROM CLIENTE WHERE id_cliente = 2

--ALTER TABLE ORDENES DROP CONSTRAINT FK_CLIENTE;
----------------------------------------------------
--Indice se utiliza para mejorar el rendimiento de nuestra consultas.
--Tipos:
--Clustered: Definen el orden de los datos.
--Nonclustered: no Definen dicho orden.
--Cuando creo una primary key y no le espeficio si es clustered o nonclustered, se creara como clustered
--cuando creo un unique y no le especifico el tipo se creara como nonclustered

--CREATE INDEX idx_Cliente_Fecha ON Transacciones(IdCliente, FechaTransaccion); -- con esto se crea un indice, SE CREA DE TIPO NONCLUSTED
--CREATE INDEX CLUSTERED idx_Cliente_Fecha ON Transacciones(IdCliente, FechaTransaccion); -- con esto se crea un indice de tipo clustered.
--CREATE INDEX NONCLUSTERED idx_Cliente_Fecha ON Transacciones(IdCliente, FechaTransaccion); --CON ESTO SE CREA DE TIPO NONCLUSTRED, 
--EXEC sp_rename 'Transacciones.idx_Cliente_Fecha', 'idx_CF', 'INDEX';
--Los indices son muy recomendable para tablas que son muy consultadas.

----------------------------------------------------------
--LE pregunte esto al chat gpt y esto me respondio: si en una tabla que creo quiero almacenar dos claves primarias de otras tablas, que seria lo mas conveniente, tener dos claves primarias compuesta, tener una clave primaria y un clave foranea, o tener una clave primaria y que las claves primarias de las otras tablas sean foreaneas?

--Una clave primaria y dos claves foráneas: Osea este seria la mejor opcion


--CREATE TABLE TablaIntermedia (
--    Id INT PRIMARY KEY,
--    IdTabla1 INT FOREIGN KEY REFERENCES OtraTabla1(Id),
--    IdTabla2 INT FOREIGN KEY REFERENCES OtraTabla2(Id),
--    OtrosCampos VARCHAR(50)
--);
--Ventajas: Estructura más clara y fácil de entender. Facilita consultas y mantenimiento.

--Desventajas: Puede haber un ligero costo de rendimiento al realizar operaciones de inserción o actualización debido a las verificaciones de integridad referencial.
--------------------------------------------------------
--SELECT
--	CONCAT(FirstName, ' ', LastName, ' (', AGE, ')') AS "NOMBRE COMPLETO" --CONCATENACION DE REGISTRO. NOTA: PUEDE CONCATENAR CUALQUIER TIPO DE DATOS
--	,City + ' ' + Region + ' '+Country AS 'LUGAR' --CONCATENACION DE OTRA FORMA. NOTA: PUEDES CONCATENAR TIPOS DE DATOS IGUALES, SI QUIERO CONCATENAR ENTRE TIPO DE DATOS DISTINTOS SOLO TENGO QUE APLICAR UN CAST, OSEA UNA CONVERSION.
--    ,[Title]
--    ,[TitleOfCourtesy]
--    ,[BirthDate]
--    ,[HireDate]
--FROM
--	[dbo].[Employees]
--------------------------------------------------------
--SELECT * FROM articulos;

----esto es para aumentar a un 10%, si fuera descuento seria -
--SELECT 
--	codigo
--	,nombre
--	,descripcion
--	,precio + (precio * 0.1) as precio --o precio = (precio * 0.10) + precio
--	,cantidad
--	,vendidos
--FROM articulos;

--SELECT 
--	codigo
--	,nombre
--	,descripcion
--	,precio
--	,cantidad
--	,vendidos
--	,precio * cantidad AS Total --saber el total
--	,cantidad - vendidos AS Existencia --saber el inventario
--	,precio * vendidos AS "Ganancias en venta" --Saber las ganancias
--FROM articulos;
---------------- --------------------------
--CREAR ESQUEMAS ES DE BUENA PRACTICA
--DENTRO DE UNA BD EL SISTEMA LE ASIGNA A LA TABLA AUTOMATICAMENTE EL ESQUEMA DBO
--CREATE SCHEMA VENTA CREAR UN ESQUEMA
--CON ESTO CREA UNA TABLA LLAMADA CLIENTE, PERO PARA EL ESQUEMA VENTA. NOTA: EN ESTA BD TENIA UNA TABLA LLAMADA CLIENTE PERO ERA PARA EL ESQUEMA DBO, MIENTRA QUE ESTA ES PARA VENTAS. OSEA TIENE NOMBRES IGUALES PERO ESQUEMAS DIFERENTES.
--CREATE TABLE VENTA.CLIENTE(
--ID INT,
--NOMBRE VARCHAR(40),
--DIRECCION VARCHAR(50));

--AMBOS SELECTE HACEN CONSULTA A TABLAS DIFERENTES. LA 1RA A LA TABLA CLIENTE ESQUEMA DBO. Y LA 2DA A LA TABLA CLIENTE ESQUEMA VENTA.
--SELECT * FROM CLIENTE;
--SELECT * FROM VENTA.CLIENTE;

--SELECT
--	REPLACE(LoginID, 'adventure-works\', '')
--	,Gender
--FROM
--	[HumanResources].[Employee]

--SELECT * FROM [dbo].[articulos]

----ESTO LO QUE VA CALCULAR EL PROMEDIO DE VALORES DISTINTOS, OSEA SI HAY TRES REGISTRO CON VALOR DE 5000, SOLO VA TOMAR 1 EN CUENTA
----SELECT 
----	AVG(DISTINCT precio) 
----FROM
----	[dbo].[articulos]
 
--SELECT * FROM [dbo].[articulos] Where nombre not like 'Monitor%'

--SELECT * FROM [dbo].[articulos] WHERE nombre BETWEEN 'Laptop' AND 'Mouse'; --este me va traer los nombre entre laptop y mouse, osea me traer todos los producto que esten L y M en el abecedario
-------------------------------------------------

--SELECT * FROM clientes;
--SELECT * FROM ordenes;

--SELECT 
--	[C].nombre
--	,[C].apellido
--	,[C].direccion
--	,[C].ciudad
--	,[C].telefono
--	,[O].fecha_orden
--FROM
--	[dbo].[clientes] AS [C]
--INNER JOIN
--	[dbo].[ordenes] AS [O]
--ON 
--	[C].idcliente = [O].idcliente
--ORDER BY 6

--SELECT 
--	[C].nombre
--	,[C].apellido
--	,[C].direccion
--	,[C].ciudad
--	,[C].telefono
--	,[O].fecha_orden
--FROM
--	[dbo].[clientes] AS [C]
--LEFT JOIN
--	[dbo].[ordenes] AS [O]
--ON 
--	[C].idcliente = [O].idcliente
--ORDER BY 6


----ESTO ME TRAER LOS CLIENTES que no estan en la tabla de ordenes
--SELECT 
--	[C].nombre
--	,[C].idcliente
--	,[C].apellido
--	,[C].direccion
--	,[C].ciudad
--	,[C].telefono
--	,[O].fecha_orden
--FROM
--	[dbo].[clientes] AS [C]
--LEFT JOIN
--	[dbo].[ordenes] AS [O]
--ON 
--	[C].idcliente = [O].idcliente
--WHERE [O].idcliente IS NULL

----ESTO ME TRAER LOS id de cliente que no estan en la tabla de ordenes. IGUAL QUE EL DE ARRIBA PERO USANDO SUBCONSULTA, Y SOLO TRAERA EL IDCLIENTE
--SELECT 
--	idcliente 
--FROM
--	clientes AS [C] WHERE idcliente NOT IN ( 
	
--		SELECT 
--			idcliente 
--		FROM
--			ordenes AS [O]
--		WHERE [C].idcliente = [O].idcliente)



--SELECT 
--	[C].nombre
--	,[C].apellido
--	,[C].direccion
--	,[C].ciudad
--	,[C].telefono
--	,[O].fecha_orden
--FROM
--	[dbo].[clientes] AS [C]
--FULL OUTER JOIN
--	[dbo].[ordenes] AS [O]
--ON 
--	[C].idcliente = [O].idcliente
--ORDER BY 6



--SELECT 'cliente' as tipo, nombre, apellido, ciudad, pais FROM clientes
--union all
--SELECT 'suplidores' as tipo ,nombre, apellido, ciudad, pais FROM suplidores
-----------------------------------------------------------------------------------------------------------------------------
--SELECT * FROM [Purchasing].[PurchaseOrderDetail]
--SELECT * FROM [Production].[Product]

	
--SELECT 
--	LEFT([P].ProductNumber,2) AS "PRODUCTO"
--	,AVG([PO].OrderQty) AS "CANTIDAD"
--	,SUM([PO].UnitPrice) AS "Precio Unico"
--	,SUM([PO].LineTotal) AS "Promedio Total"
--FROM 
--	[Production].[Product] AS [P]
--INNER JOIN
--	[Purchasing].[PurchaseOrderDetail] AS [PO]
--ON
--	[P].ProductID = [PO]. ProductID
--GROUP BY
--	LEFT([P].ProductNumber,2)
--HAVING 
--	AVG([PO].OrderQty) > 2 AND SUM([PO].UnitPrice) <=10000
--------------------------------------------------------------------------
--En la subconsulta solo se debe espeficicar solo una columna o expresion. Usar con in, any, all y exists. No pueden contener una clausula BETWEEN,LIKE, ORDER BY. No usar con delete y update
--En una subconsulta, la subconsulta se elabora primero que la consulta principal. la consulta principal puede traer varios campos, pero la subconsulta solo puede traer 1 columna
--set dateformat ymd; --ESTO ES PARA CAMBIAR EL FORMATO DE FECHA YEAR-MES-DIAS
--SELECT * FROM [dbo].[articulos]
--SELECT * FROM [dbo].[clientes]

----esto es para saber que articulos custan mas o igual que el promedio
--select nombre, precio from [dbo].[articulos] where precio >= (select avg(precio) from articulos)

----Buscar todos los nombres de cliente con idcliente de mexico
--SELECT * FROM [dbo].[clientes] WHERE idcliente IN (SELECT idcliente from [dbo].[clientes] where pais = 'México')
--SELECT * FROM [dbo].[clientes] WHERE pais = 'México';

--SELECT 
--	numerofactura
--	,ROW_NUMBER() OVER (PARTITION BY numerofactura order by (SELECT NULL)) AS numeroItem
--	,articulo
--	,precio
--	,cantidad
--FROM
--	[dbo].[detalles]

--SELECT * FROM [dbo].[facturas]
--SELECT * FROM [dbo].[detalles]

----Cuales clientes han comprado lapices

--select * from facturas where numero = any (select numerofactura from detalles where articulo = 'Lápiz') --esto seria con el any. para saber lo que no compraron lapiz se utiliza not in
--select * from facturas as f where exists (select * from detalles as d where f.numero = d.numerofactura and articulo = 'Lápiz') --esto seria con el exists. nota aqui la subconsulta puede traer mas de un campo. para saber lo que no comprearon lapiz se utiliza not exists


--Select * from [dbo].[productos];

--SELECT nombre, precio_unidad, existencia, ISNULL(CAST(vendidos AS VARCHAR(13)) , 'NO VENDIDO') AS VENDIDO FROM [dbo].[productos] --PONER TODAS LAS COLUMNAS QUE SEAN NULAS COMO NO VENDIDO, SOLO AL CAMPO VENDIDOS. TUVE QUE PONER LA COLUMNA COMO VARCHAR PARA PONER UN TEXTO, SINO SOLO PODIA PONER NUMEROS.


--SELECT 
--	nombre
--	,precio_unidad
--	,existencia
--	,ISNULL(vendidos, 0)								AS VENDIDO  
--	,precio_unidad * ISNULL(vendidos, 0)				AS Venta_solo_Vendido
--	,precio_unidad * ISNULL(existencia, 0)				AS Venta_solo_existencia
--	,precio_unidad * (existencia + ISNULL(vendidos, 0)) AS VentalTotal 
--FROM 
--	[dbo].[productos]

--Select * from [dbo].[articulos]

--1. ver articulos de mi inventario con existencia normal.
--2. ver articulos que necesitan ser pedidos.
--3. ver articulos menos vendidos.

--SELECT 
--	nombre
--	,cantidad
--	,CASE	
--		WHEN cantidad >= 30 THEN 'Menos Vendidos' 
--		WHEN cantidad <=10 THEN 'Hacer Pedido'
--		ELSE 'Existencia Normal'
--	END AS Estado
	
--FROM
--	[dbo].[articulos]
	


--SELECT * FROM clientes;

----Generar un reporte con nombre, pais y ciudad de los clientes 
----organizar el reporte por ciudad, en caso de que el cliente no tenga ciudad organizar por pais

--SELECT 
--	nombre
--	,pais
--	,ciudad
--FROM 
--	clientes
--ORDER BY ( CASE 
--	WHEN ciudad is null THEN pais --EN CASO DE QUE EL CIUDAD ES NULO ORDENALO POR PAIS
--	ELSE ciudad  --DE LO CONTRARIO ORDENALO POR CIUDAD
--END);
----ESTE CASE SE HIZO EN UN ORDER BY 
-------------------------
--FUNCIONES MATEMATICA

--SELECT pi() --OBTENER EL VALOR DE PI
----FUNCION DE REDONDEO DE ENTERO
--SELECT CEILING(432.28) AS REDONDEO --PERO NO REDONDEA DEL TODO BIEN, ES PRERIBLE UTILIZAR ROUND, OSEA REDONDEA AL NUMERO SIGUIENTE Y QUITA LOS DECIMALES. EN CASO DE NUMEROS NEGATIVOS ELIMINA LOS DECIMALES OSE TI PONGO -123.29 APARECERA COMO -123
----FUNCION PARA REDONDEO DE DECIMALES
--SELECT ROUND(432.28,1) AS REDONDEO --AQUI ME REDONDEA AL LOS DECIMALES, OSEA DICE 432.28 ENTONCES APARECERA COMO 432.30
----FUNCION PARA ELIMINAR DECIMALES
--SELECT FLOOR(123.63) AS REDONDEO --EN ESTE ME TRAE 123, OSEA NO REDONDEA SOLO QUITA LOS DECIMALES, CON NUMERO NEGATIVO SI LOS REDONDEA

----FUNCION DE POTENCIA
--SELECT POWER(4,2) POTENCIA; -- 4^2 = 16
----FUNCION PARA SACAR UN NUMERO RANDO ENTRE 100 Y 1, SI LO PONGO ASI: (1-100) SALDRA NEGATIVO. LOS trae con decimales, pero lo puse floor para que me saque sin decimales.
--SELECT FLOOR(RAND()*(100-1)) AS NUMERO_RANDO
----FUNCION PARA CALCULAR EL SENO Y COSENO DE UN ANGULO
--SELECT SIN(45) AS "SENO";
--SELECT ROUND(COS(270),2) AS "COSENO";
----FUNCION PARA SACAR LA RAIZ CUADRADA
--SELECT SQRT(64) AS RAIZ;
-----------------------------------------
--FUNCIONES STRING
--Char() se utiliza para convertir un valor entero en su correspondiente carácter ASCII.
--SELECT nombre + char(45) from [dbo].[clientes] --char(45) traera un signo (-) pues en esta consulta traera todos los nombre y que al final se le agrege -

--SELECT len(nombre) as cantidad_letra from [dbo].[clientes] --me va contar la cantidad de letras de mis campos nombre. nota cuenta los espacios tambien
--SELECT LOWER(nombre) as minuscula from [dbo].[clientes] -- ME CONVIERTE A MINUSCULA
--SELECT UPPER(nombre) as mayuscula from [dbo].[clientes] -- ME CONVIERTE A MAYUSCULA
--SELECT UPPER(LEFT(nombre,1)) + LOWER(RIGHT(nombre, LEN(nombre) -1)) AS PrimeraLetraMayuscula from [dbo].[clientes] --Poner la primera letra mayuscula y las demas demas minusculas
--SELECT UPPER(SUBSTRING(nombre,1,1)) + LOWER(SUBSTRING(nombre,2,LEN(nombre))) as nombre from [dbo].[clientes]; --ESTO SERIA DE OTRA FORMA

--SELECT 
--    UPPER(LEFT(nombre, 1)) + LOWER(SUBSTRING(nombre, 2, CHARINDEX(' ', nombre + ' ') - 1)) +
--    ' ' + UPPER(LEFT(SUBSTRING(nombre, CHARINDEX(' ', nombre + ' ') + 1, LEN(nombre)), 1)) +
--    LOWER(SUBSTRING(nombre, CHARINDEX(' ', nombre + ' ') + 2, LEN(nombre) - CHARINDEX(' ', nombre + ' '))) AS NombreCompleto
--FROM [dbo].[clientes]; --ESTO SERIA PARA PONER LA PRIMERA LETRA MAYUSCULA DEL NOMBRE Y LA PRIMERA LETRA DEL APELLIDO MAYUSCULA TAMBIEN.
 
-- SELECT REPLACE('EL COCOBONGO','O','A') --EN ESTE TEXTO, CON EL REPLACE CAMBIO LA O POR LA A
-- SELECT TRANSLATE('EL REPIBONGO', 'BONGO', 'TAMBO') --AQUI LE DIGO, QUE ME CAMBIE BONGO POR TAMBO. NOTA: DEBE CONTENER LA MISMA CANTIDAD DE LETRA. A DIFERENCIA DEL REPLACE ESTE PUEDE HACER UNO O VARIOS
-- SELECT TRANSLATE('[123.4,72.23]', '[,]', '( )') --AQUI CAMBIO LOS CORCHETES POR PARENTESIS ADEMAS, LE QUITA LA COMA POR UN PARENTESIS
-- SELECT REPLICATE('EUH ',3); --PARA REPLICAR EUH 3 VECES;
-- SELECT FORMAT(idcliente, 'D6') FROM [dbo].[clientes] --EL ID VA TENER 6 DIGITOS POR LO QUE RELLENARA CON 0 DELANTE DEL ID
-- SELECT REVERSE(nombre) FROM [dbo].[clientes] --ESTO ME TRAERA EL NOMBRE ALREVES
-- SELECT REVERSE(123456) --ME TRAE LAS CIFRAS AL REVES: 654321
------------------------------------------------------------
--FUNCIONES DE FECHA
--SELECT DATEADD(DAY, 20, GETDATE()); --AGREGAR 20 DIAS A LA FECHA ACTUAL, SI LO PONGO NEGATIVO LE QUITARIA 20 DIAS A LA FECHA ACTUAL. A ESTE DATEADD LE PUEDO MES, YEAR, HORAS, ETC.
--SELECT GETDATE() -20; --ESTO QUITA 20 DIAS A LA FECHA ACTUAL.

--SELECT * FROM [dbo].[facturas]

--SELECT * FROM [dbo].[facturas] WHERE fecha between '2018-01-01' AND '2019-01-01'
--SELECT * FROM [dbo].[facturas] WHERE fecha between '2018-01-01' AND DATEADD(YEAR, 1, '2018-01-01') --ES EL MISMO QUE EL DE ARRIBA. Y ES MEJOR PORQUE NO EVITARIA HACER EL CALCULO

--SELECT 'Este mes es: ',DATENAME(MONTH, GETDATE()); --ME TRAE EL NOMBRE DEL MES ACTUAL;
--SELECT DATEPART(MONTH, GETDATE()); --ME TRAE EL NUMERO DEL MES
--SELECT DATENAME(WEEKDAY, GETDATE()); --ME TRAER EL NOMBRE DEL DAY


--SELECT cliente, fecha, DATENAME(MONTH, fecha) AS MES
--FROM [dbo].[facturas]
--WHERE DATENAME(MONTH, fecha) = DATENAME(MONTH, CURRENT_TIMESTAMP);
----------------------------------------------------------------
--SELECT * FROM [dbo].[e_mails]
--SELECT LEFT(email,2) from [dbo].[e_mails]; --me va traer las dos primeras letras del email. si es right las ultimas dos letras que seria: om
--SELECT STUFF('HOLA MUNDO', 6,5, 'A TODOS') --aqui estoy indicando que desde la posicion 6, me quite 5 caracteres y me lo remplace por a todos.
--SELECT REPLACE(REPLACE(email, '@hotmail', '@gmail'), '@yahoo', '@gmail') from [dbo].[e_mails] --aqui cambio tanto lo que digan hotmail como yahoo por gmail.
--------------------------------------------------------
--BULK INSERT
--PARA SER EL BULK INSERT NECESITO CREAR UNA TABLA CON LOS MISMO CAMPOS QUE ESTAN EN EL ARCHIVO EN ESTE CASO EXCEL: QUE SON MARCA, MODELO, TIPO Y COLOR. LA TABLA QUE CREE SE LLAMA AUTOS
--SELECT * FROM [dbo].[autos]
--BULK INSERT 
--autos --tabla destino
--FROM 'C:\Users\eddy\OneDrive\Escritorio\bulk_Insert_Infomaticonfig.txt'--CUANDO ME DAN EL ARCHIVO DE EXCEL YO LO TENGO QUE PASAR A TXT, OSEA GUARDARLO COMO TXT, YO LO HICE COMO TEXTO CON FORMATO DELIMITADO POR TABULACIONES,
--WITH (FIRSTROW =2); --CON ESTO LE INDICAMOS QUE VA HACER LA INSERCION DESDE LA FILA 2. AQUEI SE PUEDE PONER VARIAS OPCIONES COMO FIELDTERMINATOR = ' '); QUE LO usamos en otras pruebas.

--SELECT * FROM auto
--INSERT INTO auto (marca, modelo, tipo, color)
--SELECT marca, modelo, tipo, color FROM auto;
--COMO EL ARCHIVO NO TENIA PRIMARY KEY (UN ID) PUES CREE UNA TABLA CON LOS MISMO CAMPO Y EL ID PRIMARY KEY Y IDENTITY. Y HICE UN INSERTO INTO SELECT A LA TABLA DONDE ESTA EL ID, PARA QUE ASI TUVIERA UNO


--ESTO ES UNA PRUEBA DE UN BULK INSERT CON UN ARHIVO QUE TENGO
--CREATE TABLE EMP_BULK(
--ID_EMP INT,
--NOMBRE VARCHAR(20),
--APELLIDO VARCHAR(20),
--ID_MANAGER INT,
--FECHA_NACIMIENTO DATE,
--SALARIO DECIMAL(10,2),
--COMMISION DECIMAL (10,2),
--ID_DEPARTAMENTO INT,
--CONSTRAINT Pk_id_emp PRIMARY KEY(ID_EMP),
--CONSTRAINT Fk_id_manager FOREIGN KEY(ID_MANAGER) REFERENCES EMP_BULK(ID_EMP)
--);
--ALTER TABLE EMP_BULK NOCHECK CONSTRAINT ALL; --DESACTIVO LAS RETRICCIONES DE CLAVE FORANEA PARA HACER EL BULK INSERT. SE DESACTIVAN TODAS LAS RESTRICCIONES

--BULK INSERT
--EMP_BULK
--FROM 'C:\Users\eddy\bcp\tbl_EMP.txt'
--WITH (FIELDTERMINATOR = ' ');
--SELECT * FROM EMP_BULK;
--ALTER TABLE EMP_BULK WITH CHECK CHECK CONSTRAINT ALL; --ACTIVAS LAS LLAVES FORANEAS DE NUEVO

--EL PRIMER BULK INSERT EL TEXTO ESTABA DELIMITADO POR TABULACIONES Y EN EL SEGUNDO POR ESPACIOS

--En el caso de archivos delimitados por tabulaciones, SQL Server a menudo puede reconocer automáticamente que las tabulaciones se utilizan como delimitadores.
--------------------
--SELECT * FROM ventas;


--SELECT	TOP(1) idvendedor, 
--		MAX(ven_ult_anio) AS 'ven_ult_anio'  
--FROM ventas 
--GROUP BY idvendedor 
--ORDER BY 2 DESC; --ESTO ME TRAER EL IDVENDEDOR Y LAS VENTA DEL MAXIMO VENDEDOR DE NUESTRA TABLA

--SELECT V.idvendedor, V.ven_ult_anio FROM (
--			SELECT ROW_NUMBER() OVER(ORDER BY ven_ult_anio DESC) AS CONTADOR, 
--			idvendedor, ven_ult_anio FROM ventas ) AS V
--WHERE CONTADOR = 1 --ESTO TRAE EL MISMO SELECT DE ARRIBA


--SELECT * FROM ventas WHERE idvendedor = (
--	SELECT DISTINCT FIRST_VALUE(idvendedor) OVER(ORDER BY ven_ult_anio DESC) AS CONTADOR FROM ventas); --ESTO ME TRAE EL MISMO SELECT DE ARRIBA PERO AHORA TODOS LOS CAMPOS. ESTE ES MEJOR QUE EL ROW_NUMBER() O MAS RECOMENDABLE
-------------------------------------------------------------
--SELECT * FROM [dbo].[articulos]

----ESTO ES PARA HACERLO MAS PROFESIONAL
--IF EXISTS (SELECT * FROM [dbo].[articulos] WHERE cantidad = 0) --con esto estoy diciendo si se cumple esta sentencia, osea si el select trae resultado
--(SELECT nombre, precio, cantidad FROM [dbo].[articulos] WHERE cantidad = 0) --entonces me va traer este resultado
--ELSE
--PRINT 'NO HAY ARTICULOS EN 0' --si no se cumple me trae este mensaje

--select * from prueba;
--select * from sys.objects where name = 'prueba'; --me muestra informacion sobre mi tabla

----esto hace Si existe una tabla llamada 'prueba', entonces elimínala
--IF object_id('prueba') is not null
--drop table prueba;


--SELECT * FROM [dbo].[Cartelera];
--DECLARE 
--	@PELI  AS VARCHAR(20) = 'Fast & Furious 10';
--BEGIN
--	IF EXISTS (SELECT * FROM [dbo].[Cartelera] WHERE pelicula = 'Fast & Furious 10')
--		PRINT 'La pelicula ' +@PELI+ ' Comenzara a las 4:15'
--	ELSE
--		PRINT 'Pelicula' +@PELI+ 'No disponible'
--END


--VER ASIENTOS DISPONIBLES EN CADA SALA, EN CASO DE NO HABER ASIENTOS DESPLEGAR MENSAJE DE ENTRADAS AGOTADAS
--IF EXISTS (SELECT * FROM [dbo].[Cartelera] WHERE capacidad > entradas)
--SELECT sala, pelicula, hora, capacidad - entradas AS 'disponible(s)'
--FROM [dbo].[Cartelera] WHERE capacidad > entradas
--ELSE
--PRINT 'ENTRADAS NO DISPONIBLES!!'
------------------------------------------------------------------
--DECLARAR UNA VARIABLE DE ESTA FORMA, ES IGUAL
--DECLARE @miVariable AS INT
--DECLARE @miVariable INT
--EL TIPO DE DE BIT si pongo que es 'true' entonces sera 1, si es 'false' sera 0; --ES IMPORTANTE PONERLO ENTRE COMILLAS
--SELECT * FROM [dbo].[articulos];


--DECLARE
	
--	@PRECIO AS DECIMAL(10,2);

--BEGIN
--	SET @PRECIO = (SELECT MAX(precio) from [dbo].[articulos]) -- o SELECT @PRECIO = MAX(precio) from [dbo].[articulos]
--	SELECT * FROM [dbo].[articulos] WHERE precio = @PRECIO;

--END

--SELECT TOP 1 * FROM [dbo].[articulos]  ORDER BY precio desc --lo mismo que arriba
-------------------------------------
--LAS VARIABLES DE TIPO TABLA NO SE ALMACENAN EN NUESTRA BD, ES COMO UNA TABLA TEMPORAL. AQUI SE DECLARA UNA VARIABLE DE TIPO TABLA
--DECLARE
--@TABLA1 AS TABLE (
--ID INT,
--NOMBRE VARCHAR(30),
--TELEFONO NUMERIC(10)
--)
--BEGIN
--INSERT INTO @TABLA1 VALUES (1, 'JUAN',12293801)
--SELECT * FROM @TABLA1
--END;
--------------------------------------------------------------------
--STORED PROCEDURE
--sp_ (master) 
--locales (usuario) --solo estan disponibles para la sesion de un solo usuario
--temporales (#) 
--globales (##) --quedan disponibles para todas las sesiones de usuarios.


--ESTE SP SENCILLO LO CREE YO. ES CON PARAMETRO
--ALTER PROCEDURE [dbo].[Prueba]
--@CODIGO AS INT
--AS
--BEGIN
--	SELECT * FROM [dbo].[articulos] WHERE codigo = @CODIGO
	
--END
--SELECT * FROM [dbo].[articulos];
--EXEC Prueba 5

--ESTE SP ME TRAER TODOS LOS ARTICULOS DONDE LA CANTIDAD SEA MENOR A 20. NO TIENE PARAMETRO
--CREATE PROCEDURE p_existencia
--AS
--BEGIN
--SELECT * FROM [dbo].[articulos] WHERE cantidad <=20
--END

--EXEC p_existencia;

----SP QUE ACTUALIZA LA CANTIDAD A 10 CUANDO LA CANTIDAD ES IGUAL A 0
--CREATE PROCEDURE ACTUALIZA_CANTIDAD
--AS
--BEGIN
--	IF EXISTS (SELECT * FROM [dbo].[articulos] 
--			   WHERE cantidad = 0)
--	UPDATE [dbo].[articulos] SET cantidad = 10 
--			   WHERE cantidad = 0
--	ELSE
--	PRINT 'NO HAY ARTICULOS EN 0'
--END
--GO
--EXEC ACTUALIZA_CANTIDAD

--SELECT *FROM [dbo].[EMP_BULK]

--SP QUE CUANDO EL DEPARTAMENTO SEA IGUAL A 30 PUES, VA HACE UN INCREMENTO DE UN 20%
--RECALCAR, AL  ejecutar dos instrucciones (UPDATE y PRINT) dentro del bloque IF sin usar BEGIN y END GENERARA UN ERROR. En SQL Server, cuando un bloque IF o cualquier otra estructura de control de flujo (como ELSE, WHILE, etc.) contiene más de una instrucción, se requiere el uso de BEGIN y END para agrupar esas instrucciones.
--OSEA PUEDO USAR UNA, PERO NO DOS O MAS SIN EL BEGIN Y END
--ALTER PROCEDURE SP_BONIFICACION
--AS
--BEGIN
--	IF EXISTS(SELECT * FROM [dbo].[EMP_BULK] 
--				  WHERE ID_DEPARTAMENTO = 30)
--		BEGIN
--			UPDATE [dbo].[EMP_BULK] SET SALARIO = SALARIO + (SALARIO * 0.20)
--					  WHERE ID_DEPARTAMENTO = 30;
--			PRINT 'SE HA APLICADO LA BONIFICACION'
--		END
--	ELSE
--		BEGIN

--		PRINT 'NO SE HA APLICADO LA BONIFICACION'
		
--		END
--END
--GO
--EXEC SP_BONIFICACION
--------------------------------------------
--ESTOY HACIENDO AQUI LO MISMO QUE EL SP DE ARRIBA, PERO ESTOY CREANDO UNA TABLA TEMPORAL PARA PODER VER EL SALARIO ANTES DE ACTUALIZAR Y EL SALARIO DESPUES DE ACTUALIZAR
--CREATE TABLE #TempTable
--(
--    Old_Salary DECIMAL(10, 2),
--    New_Salary DECIMAL(10, 2)
--);

---- Realizar la actualización y almacenar los valores antes y después en la tabla temporal
--UPDATE [dbo].[EMP_BULK]
--SET SALARIO = SALARIO + (SALARIO * 0.20)
--OUTPUT DELETED.SALARIO AS Old_Salary, INSERTED.SALARIO AS New_Salary
----INTO #TempTable
--WHERE ID_DEPARTAMENTO = 10;

---- Seleccionar los valores almacenados en la tabla temporal
--SELECT Old_Salary, New_Salary FROM #TempTable;
--SELECT * FROM [dbo].[EMP_BULK];
---- Eliminar la tabla temporal cuando hayas terminado
--DROP TABLE #TempTable

--LO HICE SIN CREAR UNA TABLA TEMPORAL Y FUNCIONO OSEA UPDATE [dbo].[EMP_BULK] SET SALARIO = SALARIO + (SALARIO * 0.20) OUTPUT DELETED.SALARIO AS Old_Salary, INSERTED.SALARIO AS New_Salary WHERE ID_DEPARTAMENTO = 20; Y ME TRAJO EL SALARIO VIEJO Y NUEVO
----------------------------------------------------------------------------------
--PROCEDURE CON MAS PARAMETROS
--CREATE OR ALTER PROCEDURE SP_BUSCA
--	@NOMBRE AS VARCHAR(30),
--	@SALARIO AS DECIMAL(10,2),
--	@ID_DEPARTAMENTO AS INTd
--AS
--BEGIN
--	SELECT * FROM [dbo].[EMP_BULK] WHERE NOMBRE = @NOMBRE AND SALARIO = @SALARIO AND ID_DEPARTAMENTO = @ID_DEPARTAMENTO
--END
--GO

--EXEC [dbo].[SP_BUSCA_EMP] 'ALLEN', 2764.80, 30;
-------------------------------------------------------
--ESTE ES UN SP QUE SIRVE PARA CREAR EL PROMEDIO CON PARAMETROS DE SALIDA
--CREATE OR ALTER PROCEDURE SP_PROMEDIO_PARAMETROSALIDA
--@VALOR1 NUMERIC(6,2),
--@VALOR2 NUMERIC(6,2),
--@RESULTADO NUMERIC(6,2) OUTPUT
--AS
--BEGIN
--	SET @RESULTADO = (@VALOR1 + @VALOR2) / 2
--END
--GO

--DECLARE --PARA EJECUTAR UN SP CON PARAMETRO DE SALIDA DEBO PRIMERO DECLARAR UNA VARIABLE DEL MISMO TIPO DE MI VARIABLE DE SALIDA DECLARADA EN EL SP
--@PROMEDIO NUMERIC(6,2) --A ESTA VARIABLE LA PUEDO LLAMAR @RESULTADO Y DA ERROR
--EXEC SP_PROMEDIO_PARAMETROSALIDA 10, 20, @PROMEDIO OUTPUT
--SELECT @PROMEDIO AS PROMEDIO --SE HACE UN SELECT PARA MOSTRAR EL RESULTADO, AUNQUE HAYA UN SELECT DENTRO DEL SP, OSEA PUEDO CAMBIAR EL SET POR EL SELECT Y COMO QUIERA TENGO QUE PONERLO
----ESTE SP SE PUEDE CREAR IGUAL SIN PAREMTROS DE SALIDA

--SP QUE CALCULE EL SALARIO PROMEDIO DE UN DEPARTAMENTO EN ESPECIFICO
--ME TRAERA TODOS LO CAMPO DE LA TABLA EMPLEADO CUANDO EL DEPARTAMENTO ID = 20, ADEMAS ME TREAERA UN REGISTRO, DE LA SUMATORIO Y DEL PROMEDIO CUANDO EL DEPARTAMENTO SEA = 20
--CREATE OR ALTER PROCEDURE SP_CALCULE_SALARIO_PROMEDIO
--	@ID_DEPARTAMENTO AS INT,
--	@SUMATORIA AS NUMERIC(10,2) OUTPUT,
--	@PROMEDIO AS NUMERIC(10,2) OUTPUT
--AS
--BEGIN
--	SELECT * FROM [dbo].[EMP_BULK] WHERE ID_DEPARTAMENTO = @ID_DEPARTAMENTO
--	SELECT @SUMATORIA = SUM(SALARIO) FROM [dbo].[EMP_BULK] WHERE ID_DEPARTAMENTO = @ID_DEPARTAMENTO
--	SET @PROMEDIO =  (SELECT AVG(SALARIO) FROM [dbo].[EMP_BULK] WHERE ID_DEPARTAMENTO = @ID_DEPARTAMENTO)
--END
--GO

--DECLARE
--@SUMATORIA NUMERIC(10,2),
--@PROMEDIO NUMERIC(10,2)
--EXEC SP_CALCULE_SALARIO_PROMEDIO 20, @SUMATORIA OUTPUT, @PROMEDIO OUTPUT --DEBO PONER EL ORDEN DE LA VARIABLE DE LA MISMA FORMA DE COMO LAS CREE
--SELECT @SUMATORIA AS TOTAL, @PROMEDIO AS PROMEDIO, '2O' AS DEPARTAMENTO
---------------------------------------------------------------------------------------
--SELECT * FROM sysobjects --para ver todos los objetos
--EXEC sp_helptext SP_CALCULE_SALARIO_PROMEDIO --CON ESTO ME TRAE TODO LO QUE HACE MI PROCEDIMIENTO, OSEA LA ESTRUCTURA
----CON ESTO PODEMOS ENCRIPTAR NUESTRO SP, OSEA OCULTARLO A OTROS USUARIO. NOTA PODEMOS OCUALTAR CUALQUIER OBJETO
----OSEA COJEMOS LA ESTRUCTURA Y LE AGREGAMOS EL WITH ENCRIPTION
--CREATE OR ALTER PROCEDURE SP_CALCULE_SALARIO_PROMEDIO  
-- @ID_DEPARTAMENTO AS INT,  
-- @SUMATORIA AS NUMERIC(10,2) OUTPUT,  
-- @PROMEDIO AS NUMERIC(10,2) OUTPUT  
----WITH ENCRYPTION --CON ESTO ENCRIPTAMOS NUESTRO SP
--AS  
--BEGIN  
-- SELECT * FROM [dbo].[EMP_BULK] WHERE ID_DEPARTAMENTO = @ID_DEPARTAMENTO  
-- SELECT @SUMATORIA = SUM(SALARIO) FROM [dbo].[EMP_BULK] WHERE ID_DEPARTAMENTO = @ID_DEPARTAMENTO  
-- SET @PROMEDIO =  (SELECT AVG(SALARIO) FROM [dbo].[EMP_BULK] WHERE ID_DEPARTAMENTO = @ID_DEPARTAMENTO)  
--END  

--EXEC sp_helptext SP_CALCULE_SALARIO_PROMEDIO --SI EJECUTAMOS ESTO QUE ERA PARA QUE MUESTRA LA ESTRUCTURA DE MI SP. NOS SALDRA QUE EL OBJETO ESTA ENCRIPTADO
----UNA VES ASI, SI VAMOS PROGRAMMABILTY YA NO LO PODEMOS MODIFICAR, POR QUE ES LO RECOMENDABLE TENER EL SCRIPT GUARDADO EN OTRO LUGAR EXTERNO
----PARA QUITAR LA ENCRIPTACION SOLO DEBEMOS DE QUITAR WITH ENCRYPTION
---------------------------------------------------------------------------------------
--LAS TABLAS TEMPORALES SON ELEMENTOS VISIBLE SOLAMENTE EN UNA SESION DE USUARIO
--SI YO CREO UNA TABLA TEMPORAL EN MI BD INFOMATI, Y DESPUES ME PASO A ADVENTUREWORKS2019, SI HAGO SELECT A LA TABLA TEMPORAR ME VA A TRAER LOS RESULTADO AUNQUE YO ALLA CAMBIABDO DE BD
--EN CAMBIO SI DESCONECTO MI SESION Y ME VUELVO A CONECTAR YA NO APARECERA LA TABLA

----SP EN EL QUE USA TABLA TEMPORALES;
----AQUI CREAMOS UN SP QUE ME TRAIGA LA SUMATORIA Y EL PROMEDIO AGRUPADO POR ID_DEPARTAMENTO. USANDO TABLA TEMPORAL
--CREATE OR ALTER PROCEDURE SP_VARIABLE_TABLA
--AS
--BEGIN
--		CREATE TABLE #TABLA1 (
--		ID_DEPARTAMENTOS INT,
--		SUMATORIA DECIMAL(10,2),
--		PROMEDIO DECIMAL(10,2)
--		);

	
--	INSERT INTO #TABLA1 (ID_DEPARTAMENTOS, SUMATORIA, PROMEDIO) 
--	SELECT ID_DEPARTAMENTO, SUM(SALARIO) AS SUMATORIO, AVG(SALARIO) AS SALARIO FROM [dbo].[EMP_BULK] GROUP BY ID_DEPARTAMENTO
--	SELECT * FROM #TABLA1
--END
--GO

--EXEC SP_VARIABLE_TABLA
----------------------------------------------------------------------------------------------------------------------
--FUNCIONES
--returns: para definir el tipo de dato que va a retornar tu funcion

--return: la parte de tu funcion que va a retornar el dato
--A DIFERENCIA DE LOS SP, LAS FUNCIONES NO USAN PARAMETROS DE SALIDA
--LAS VARIABLES EN LAS FUNCIONES SE CREAEN ENTRE PARENTESIS.
--EL RETURNS ES OBLIGATORIO EN LAS FUNCIONES EN COMPARACION CON LOS SP, QUE SE UTILIZAN EN CASOS ESPECIFICOS.

--CREAR UNA FUNCION QUE SUME DOS NUMERO
--CREATE FUNCTION F_SUMA
--(	
--	 @VALOR AS INT,
--	 @VALOR2 AS INT
--)
--RETURNS INT
--AS
--BEGIN
--	DECLARE 
--	@RESULTADO AS INT
--	SET @RESULTADO = @VALOR + @VALOR2
--	RETURN @RESULTADO

--END

--SELECT [dbo].[F_SUMA] (30,50) AS SUMA --EJECUTAR LA FUNCION
--ESTA FUNCION YO LA PODRIA HABER CREADO EN UN SP, PONIENDO LA VARIABLE @RESULTADO COMO OUTPUT, EN ESTE CASO LA VARIABLE DE SALIDA SE DECLARA EN LA EJECUCION DE UN PROGRAMA OSEA EL BEGIN Y END

-----------------------------------------------------------------------
--SELECT * FROM [dbo].[facturas]
----EN ESE SELECT EL OBTENGO EL NOMBRE DEL MES, SI QUIERO PONERLO EN UN IDIOMA EN ESPECIFICO PUEDO CREAR UNA FUNCION
--SELECT
--	numero,
--	DATENAME(MONTH,fecha) AS MES,
--	cliente
--FROM
--	[dbo].[facturas]

--FUNCION QUE ME CONVIERTA EL NOMBRE DEL MES (QUE ESTA EN INGLES) A ESPAÑOL

--CREATE OR ALTER FUNCTION F_MESES
--(
--	@FECHA AS DATE --ESTO SERA IGUAL AL CAMPO FECHA DE MI TABLA FACTURA, OSEA A LA FECHA EN ESTE FORMATO 2018-04-20
--)
--RETURNS VARCHAR(15) --ESTO RETORNARA UN VARCHAR PORQUE EL NOMBRE DEL MES SERA UNA CADENA DE CARACTERES POR EJEMPLO ENERO
--AS
--BEGIN
--	DECLARE @NOMBRE VARCHAR(15) --el tipo de retorno de la función debe coincidir con el tipo de la variable que se devuelve. En este caso, como la variable @NOMBRE es de tipo varchar(15), la función también debe tener ese tipo de retorno. Si la variable fuera de otro tipo, por ejemplo, int o date, la función tendría que convertir el valor a varchar antes de devolverlo, usando la función CAST o CONVERT .
--	SET @NOMBRE = CASE DATENAME(MONTH, @FECHA)
--	WHEN 'January' THEN 'Enero'
--	WHEN 'February' THEN 'Febrero'
--	WHEN 'March' THEN 'Marzo'
--	WHEN 'April' THEN 'Abril'
--	WHEN 'May' THEN 'Mayo'
--	WHEN 'June' THEN 'Junio'
--	WHEN 'July' THEN 'Julio'
--	WHEN 'August' THEN 'Agosto'
--	WHEN 'September' THEN 'Septiembre'
--	WHEN 'October' THEN 'Octubre'
--	WHEN 'November' THEN 'Noviembre'
--	WHEN 'Dicember' THEN 'Diciembre'
--END --CASE
--	RETURN @NOMBRE -- La función RETURN devuelve el valor de la variable @NOMBRE al final.
--END
--GO

--SELECT cliente, [dbo].[F_MESES](fecha) AS FECHA FROM [dbo].[facturas] --USAMOS NUESTRA FUNCION
------------------------------------------------
--FUNCIONES DE TIPO TABLA
--ESTA A DIFERENCIA DE LA FUNCIONES ESCALARES (VISTA ANTERIORMENTE) NO TIENEN BLOQUES DE BEGIN Y END
--ADEMAS PARA EJECUTARLOS ESTOS DEBEN IR EN EL FROM, OSEA COMO TABLA COMO EL EJEMPLO DE ABAJO. A DIFERENCIA DE LAS FUNCIONES ESCALARES QUE ERAN EN COLUMNAS, NO SE SI LOS ESCARLES PUEDEN IR DESPUES DEL WHERE
--SELECT *  FROM [dbo].[libros]

--FUNCION QUE ME DEVUELVA TODOS LOS REGISTRO SEGUN EL AUTOR QUE SE LE ESPECIFIQUE
--CREATE OR ALTER FUNCTION F_AUTOR_
--(	
--	@AUTOR AS VARCHAR(30)
--)
--RETURNS TABLE 
----WITH ENCRIPTYON --AL IGUAL QUE LOS SP, PODEMOS ENCRIPTARLO
--AS
--RETURN 
--(
--	SELECT *
--	FROM [dbo].[libros] 
--	WHERE autor LIKE '%'+@AUTOR+'%' 
--)
--GO

--SELECT * FROM [dbo].[F_AUTOR] ('Pa') --ME TRAE TODOS LOS AUTORES QUE TENGAN 'Pa' En cualquier lugar
------------------
--ESTO ES UNA FUNCION ME TRAER EL AUTOR Y LA CANTIDAD DE TITULO QUE TIENE EN LA TABLA
--CREATE FUNCTION F_Cantidad_Autor 
--(	
--	@AUTOR VARCHAR(40)
--)
--RETURNS TABLE 
--AS
--RETURN 
--(
--	SELECT autor, COUNT(titulo) AS TITULO
--	FROM [dbo].[libros] 
--	WHERE autor = @AUTOR GROUP BY autor
--)
--GO

--SELECT * FROM [dbo].[F_Cantidad_Autor]('J.R.R. Tolkien') --

--DIFERENCIA ENTRE FUNCIONES Y SP
--Una función debe devolver un valor, pero en un SP es opcional.
--Una función solo puede tener parámetros de entrada, mientras que un SP puede tener parámetros de entrada o salida.
--Una función se puede usar en una consulta o expresión SQL, mientras que un SP se debe ejecutar con una instrucción EXEC o CALL.
--Una función no puede modificar los datos de la base de datos, mientras que un SP sí puede.
--Una función no puede usar ciertas sentencias SQL como PRINT, RAISERROR, TRY-CATCH, etc., mientras que un SP sí puede.

--SET LANGUAGE 'English' --PONER LA SESION ACTUAL EN INGLES
--SET LANGUAGE 'Spanish' --PONER LA SESION ACTUAL EN ESPAÑOL
--SELECT @@LANGUAGE; --SABER EL LENGUAJE ACTUAL DE LA SESION
-------------------------------------------
--ESTO ES UN SP QUE HACE LA MISMA FUNCION, QUE LA FUNCION QUE HEMOS CREADO ARRIBA DE CONVERTIR LOS MESES DE INGLES A ESPAÑOL, 
--CREATE OR ALTER PROCEDURE PRUEBA_SP_FUNCION
--AS	
--BEGIN
	
--	SELECT numero,
--	CASE DATENAME(MONTH, fecha)
--	WHEN 'January' THEN 'Enero'
--	WHEN 'February' THEN 'Febrero'
--	WHEN 'March' THEN 'Marzo'
--	WHEN 'April' THEN 'Abril'
--	WHEN 'May' THEN 'Mayo'
--	WHEN 'June' THEN 'Junio'
--	WHEN 'July' THEN 'Julio'
--	WHEN 'August' THEN 'Agosto'
--	WHEN 'September' THEN 'Septiembre'
--	WHEN 'October' THEN 'Octubre'
--	WHEN 'November' THEN 'Noviembre'
--	WHEN 'December' THEN 'Diciembre'
--END AS FECHA, cliente FROM [dbo].[facturas]

--    END
--GO
--EXEC [dbo].[PRUEBA_SP_FUNCION]
------------------------------------------------------------------------------------
--TRIGGER o disparadores en sql server para controlar todos los eventos dml en una tabla 
--TIPOS DE TRIGGER EN SQL SERVER
--AFTER INSERT --AFTER UPDATE --AFTER DELETE --INSTEAD OF(EN LUGAR DE) ESTE ULTIMO ES COMO EL BEFORE DE ORACLE. AFTER Y FOR ES LO MISMO.
--NOTA: LOS TRIGGER HAY QUE PROGRAMARLOS CON PRECAUCION, PORQUE PUEDE AFECTAR EL RENDIMIENTO Y LA COMPLEJIDAD DE LAS OPERACIONES EN NUESTRA BD

--PARA CREAR UN TRIGGER PRIMERO CREAMOS UNA TABLA, LLAMADA PRUEBA Y OTRA LLAMADA CONTROL
--SELECT * FROM prueba;
--SELECT * FROM [control];

----ESTE TRIGGER VA A CONTROLAR LA INSERCION QUE SE REALIZA EN LA TABLA PRUEBA, SI SE INSERTA UN REGISTRO EN LA TABLA PRUEBA, SE INSERTARA EN LA TABLA CONTROL: NOMBRE DEL USUARIO QUE HIZO LA INSERCION, LA FECHA EN LA QUE LO HIZO, Y LA ACCION, QUE EN ESTE CASO FUE UN INSERT.
--CREATE OR ALTER TRIGGER T_INSERTA
--   ON  prueba
--   AFTER INSERT --CON ESTO VA MONITORIAR CUALQUIER INSERT QUE SE HAGA EN ESTA TABLA
--AS --DESPUES DEL AS SE PONE EL BEGIN TANTO EN LAS FUNCIONES (ALGUNOS CASOS), SP Y TRIGGERS
--BEGIN
--	DECLARE
--	@USUARIO VARCHAR(30); 
--	SELECT @USUARIO = SUSER_NAME(); --asigna el nombre de inicio de sesión del contexto de seguridad actual a la variable @USUARIO
--	INSERT INTO control VALUES (@USUARIO, GETDATE(), 'INSERT')
--END
--GO

--INSERT INTO prueba VALUES (2, 'CARLOS', GETDATE(), 1.50)

----PARA MONITORIAR LAS ACTUALIZACIONES SOLO DEBEMOS DE PONER ALFTER UPDATE Y CAMBIAR LA ACCION, OSEA EN VES DE  'INSERT' PONER 'UPDATE'.
--CREATE OR ALTER TRIGGER T_UPDATE
--   ON  prueba
--   AFTER UPDATE --CON ESTO VA MONITORIAR CUALQUIER UPDATE QUE SE HAGA EN ESTA TABLA
--AS 
--BEGIN
--	DECLARE
--	@USUARIO VARCHAR(30); 
--	SELECT @USUARIO = SUSER_NAME(); --asigna el nombre de inicio de sesión del contexto de seguridad actual a la variable @USUARIO
--	INSERT INTO control VALUES (@USUARIO, GETDATE(), 'UPDATE')
--END
--GO

--UPDATE prueba SET id = 3 where id = 2
--SELECT * FROM [dbo].[prueba]
--SELECT * FROM [dbo].[control]

----PARA EL DELETE BASICAMENTO LOS MISMO
--CREATE OR ALTER TRIGGER T_DELETE
--   ON  prueba
--   AFTER DELETE --CON ESTO VA MONITORIAR CUALQUIER DELETE QUE SE HAGA EN ESTA TABLA
--AS 
--BEGIN
--	DECLARE
--	@USUARIO VARCHAR(30); 
--	SELECT @USUARIO = SUSER_NAME(); --asigna el nombre de inicio de sesión del contexto de seguridad actual a la variable @USUARIO
--	INSERT INTO control VALUES (@USUARIO, GETDATE(), 'DELETE')
--END
--GO

--DELETE FROM prueba WHERE id = 1
--SELECT * FROM [dbo].[prueba]
--SELECT * FROM [dbo].[control]
------------------------------------------------------------------------------------------
 --AHORA VAMOS HACER UN TRIGGER EN EL QUE ESTEN LOS 3 TRIGGER DE ARRIBA (INSERT, UPDATE, DELETED) EN UNO SOLO. 
 --NOTA: ESTOS TIPOS DE TRIGGER ES IMPORTANTE PARA TABLAS QUE SE INSERTAN, BORRAN Y ACTULIZAN DATOS, OSEA QUE SE APLIQUEN ESAS ACCIONES, PORQUE HAY TABLAS QUE SOLO ES NECESARIO INSERTAR DATOS Y NO HAY NECESIDAD DE CREAR TRIGGERS DE ACTUALIZACION O BORRADO. POR LO QUE HAY TABLAS QUE REALIZAN TODAS LAS ACTIVIDADES DE MANIPULACION Y ES RECOMENDABLE TENERLO TODO EN UNO.
 --NOTA: a cláusula "FOR EACH ROW" no es necesaria en SQL Server ya que se asume que un trigger trabaja en el nivel de fila de manera predeterminada. ESTO SE PONIA EN ORACLE, PERO EN SQL SERVER NO ES NECESARIO


--CREATE OR ALTER TRIGGER T_CONTROL_EMP
--   ON  [dbo].[EMP_BULK]
--   FOR INSERT,DELETE,UPDATE --EN VES DE AFTER, PONGO FOR. Los disparadores FOR se ejecutan durante la operación en la tabla, antes de que se realicen los cambios. SI PONGO AFTER IGUAL HUBIERA FUNCIONADO
--AS 
--BEGIN
--	DECLARE
--	@HORA VARCHAR(20) = RIGHT(GETDATE(), 7), --ESTO ES PARA ASIGNARLE LA HORA ACTUAL A MI VARIABLE
--	@USUARIO VARCHAR(40) = SUSER_NAME(); --PARA ASIGNARLE EL NOMBRE DE USUARIO ACTUAL A MI VARIABLE
--	IF EXISTS (SELECT 0 FROM INSERTED) ---- Verificar si hay filas en la tabla virtual inserted, que contiene las filas insertadas o actualizadas

--BEGIN
--	IF EXISTS (SELECT 0 FROM DELETED) ---- Verificar si hay filas en la tabla virtual deleted, que contiene las filas eliminadas o actualizadas. OSEA VERIFICA SI HAY INSERTED Y UN DELETED
--BEGIN 
--	INSERT INTO [dbo].[CONTROL_EMP] VALUES
--	(@USUARIO, GETDATE(), @HORA, 'ACTUALIZO EN LA TABLA EMPLEADO'); ---- Insertar una fila en la tabla de control con los datos del usuario, la fecha, la hora y la acción de actualizar
--END
--	ELSE ---- Iniciar el bloque de código si no hay  filas en deleted
--BEGIN 
--	INSERT INTO [dbo].[CONTROL_EMP] VALUES
--	(@USUARIO, GETDATE(), @HORA, 'INSERTO EN LA TABLA EMPLEADO'); ---- Insertar una fila en la tabla de control con los datos del usuario, la fecha, la hora y la acción de insertar
--END -- Terminar el bloque de código si no hay filas en deleted
--END -- Terminar el bloque de código si hay filas en inserted
--	ELSE -- Iniciar el bloque de código si no hay filas en inserted
--BEGIN
--	INSERT INTO [dbo].[CONTROL_EMP] VALUES
--	(@USUARIO, GETDATE(), @HORA, 'BORRO EN LA TABLA EMPLEADO'); ---- Insertar una fila en la tabla de control con los datos del usuario, la fecha, la hora y la acción de borrar
--END -- Terminar el bloque de código si no hay filas en inserted
--END -- Terminar el bloque de código del disparador
--GO
--SI DELETED Y INSERTED TIENE REGISTROS ENTONCES ES UNA |ACTUALIZACION|
--SI DELETED NO TIENE REGISTRO ENTONCES ES UNA			|INSERCION|
--SI INSERTED NO TIENE REGISTRO ENTONCES ES UN			|BORRADO|



 --SELECT * FROM [dbo].[EMP_BULK]
 --SELECT * FROM CONTROL_EMP;
 --INSERT INTO [dbo].[EMP_BULK] VALUES(7889, 'LEBRON', 'JAMES', 7839, '1983-12-30', 5600.00, NULL, 10)
 --UPDATE [dbo].[EMP_BULK] SET SALARIO = 6000.00 WHERE ID_EMP = 7889;
 --DELETE FROM [dbo].[EMP_BULK] WHERE ID_EMP = 7889;
 ----------------------------------------------------------------------------
 --TRIGGER INSTEAD OF O BEFORE DE ORACLE, ESTOS  TRIGGERS SIRVEN para bloquear acciones en nuestras tablas O SEAN SIRVEN PARA PREVENIR ALTERACIONES EN NUESTRA TABLAS.
 --IMPIDEN INSERTAR DATOS, ACTULIZAR DATOS O ELIMINAR DATOS, SIRVEN DE GUARDIANES
 --SI QUIERO CREAR UNA TABLA APARTIR DE OTRO LO MAS FACIL ES GENERAR UN SCRIP DE ESA TABLA Y CAMBIARLE EL NOMBRE, ASI SE HACE DE MANERA RAPIDA. O HACER UN CREATE TABLE NUEVATABLA AS SELECT * FROM VIEJATABLA
 --EN EL TRIGGER ANTERIOR INFORMABA DE LAS ACCIONES QUE SE HACIAN EN LA TABLA EMPLEADO, NO PREVENIA

 --ESTO ES UN TRIGGER QUE APARTE DE INFORMAR (INSERTAR LOS DATOS DE QUIEN LO HIZO, FECHA, ETC) EN LA TABLA DE CONTROL_PRODUCTO TAMBIEN BLOQUEA LA ACCION, OSEA NO HACE LA INSERCION EN LA TABLA DE PRODUCTO, SOLO EN LA DE CONTROL
--CREATE OR ALTER TRIGGER T_BLOCKINSERT_PRODUCTOS
--   ON  [dbo].[productos]
--   INSTEAD OF INSERT --ESTO SE VA ASEGURAR DE BLOQUEAR LA INSERCION DE DATO EN ESTA TABLA
--AS 
--BEGIN
--	SET NOCOUNT ON --BLOQUEAR EL MENSAJE DE CONSOLA. OSEA PARA QUE NO APAREZCA EL NUMERO DE FILAS AFECTADAS EN LA CONSOLA
--	INSERT INTO [dbo].[CONTROL_PRODUCTO] VALUES
--	(SUSER_NAME(), GETDATE(), RIGHT(GETDATE(),7), 'INTENTO DE INSERCCION')
--	PRINT 'NO ES POSIBLE HACER LA INSERCCION EN ESA TABLA'
--END
----SI YO LE PONGO INSTEAD OF AL TRIGGER ANTERIOR EN VES DE AFTER O FOR, A LA HORA DE INSERTAR, BORRAR, O ACTULIZAR REGISTRO EN LA TABLA EMPLEADO NO SE HARA LA INSERCION, BORRADO O ACTUALIZACION, SIMPLENTE SE INSERTARAN LOS REGISTRO EN LA TABLA DE CONTROL.
----PARA LA ACTULIZACION Y BORRADO ES LO MISMO, SOLO DEBO CAMBIAR EL NOMBRE DEL TRIGGER, LA ACCION Y PONER INSTEAD OF UPDATE O INSTEAD OF DELETE

-- SELECT * FROM [dbo].[productos]
-- --NINGUNA DE ESTAS ACCIONES NO SE PODRAN HACER DEBIDO A LOS TRIGGERS CREADO, SOLO SE INSERTARA LOS REGISTRO EN LA TABLA DE CONTROL. CON SUS RESPECTIVAS ACCIONES REALIZADAS.
--INSERT INTO [dbo].[productos] VALUES (41, 'MARTILLO DE ORO', 150.00, 15, 5)
--UPDATE [dbo].[productos] SET vendidos = 10 WHERE idproducto = 8;
--DELETE FROM [dbo].[productos] WHERE idproducto = 39;

--SELECT * FROM [dbo].[CONTROL_PRODUCTO]

--ESTE TRIGGER HACE LOS TRES EN UNO LA DE INSERCCION, ACTUALIZACIO Y BORRADO
--CREATE OR ALTER TRIGGER T_PRVENIR_IDU
--ON [dbo].[productos]
--INSTEAD OF INSERT, UPDATE, DELETE
--AS
--BEGIN
--	IF EXISTS (SELECT 0 FROM INSERTED)
--	  
--	IF EXISTS (SELECT 0 FROM DELETED)
--	BEGIN
--		SET NOCOUNT ON
--		INSERT INTO [dbo].[CONTROL_PRODUCTO] VALUES
--		(SUSER_NAME(), GETDATE(), RIGHT(GETDATE(),7), 'INTENTO DE ACTULIZACION')
--		PRINT 'NO ES POSIBLE HACER LA ACTUALIZACION'
--	END
--	ELSE
--	BEGIN
--		SET NOCOUNT ON
--		INSERT INTO [dbo].[CONTROL_PRODUCTO] VALUES
--		(SUSER_NAME(), GETDATE(), RIGHT(GETDATE(),7), 'INTENTO DE INSERCCION')
--		PRINT 'NO ES POSIBLE HACER LA INSERCCION'
--	END
--	END --ESTE ES EL END DEL BEGIN DE ARRIBA, POR LO QUE LO PUEDO SI QUIERO LO PUEDO QUITAR
--	ELSE
--	BEGIN
--		SET NOCOUNT ON
--		INSERT INTO [dbo].[CONTROL_PRODUCTO] VALUES
--		(SUSER_NAME(), GETDATE(), RIGHT(GETDATE(),7), 'INTENTO DE BORRADO')
--		PRINT 'NO ES POSIBLE HACER EL BORRADO'
--	END
--END

--ALTER TABLE [dbo].[productos] DISABLE TRIGGER [T_PRVENIR_IDU] --DESHABILITAR UN TRIGGER
--ALTER TABLE [dbo].[productos] ENABLE TRIGGER [T_PRVENIR_IDU] --HABILITAR UN TRIGGER

--EXEC sp_rename '[dbo].EMP_BULK.APELLIDO','JOB', 'COLUMN' --CAMBIAR EL NOMBRE A UNA COLUMNA
-----------------------------------------------------------------------------------------
--triggers de tipo raiserror para control de eventos a nivel de sistema
--RAISERROR SE UTLIZA PARA MANDARNOS UN MENSAJE PERSONALIZADO, NOS PERMITE CONOCER ERRORES MAS DESCRIPTIVOS Y ESPECIFICOS

--ESTE ES UN TRIGGER QUE SI SE BORRAN MAS DE 2 EMPLEADOS DE LA TABLA EMP ENTONCES SALDRA UN ERROR PERSONALIZADO, Y HARA UN ROLLBACK, OSEA QUE NO SE EFECTURARA LA ELIMINACION
--CREATE OR ALTER TRIGGER TR_BORRA_EMP
--   ON  [dbo].[EMP_BULK]
--   AFTER DELETE
--AS 
--BEGIN
--	IF (SELECT COUNT(*) FROM DELETED) >=2
--BEGIN
--	RAISERROR('NO SE PUEDE ELIMINAR MAS DE DOS EMPLEADOS',16,1) --EL 16,1 ES UN CODIGO DE ERROR, YO PUEDO PONER OTROS CODIGO, PERO SI NO PONGO NADA ME DARIA ERROR AL CREAR EL TRIGGER PORQUE EL RAISERROR TIENE ESOS ARGUMENTOS DE PONER DOS CODIGO. EL 16 ES UN LEVEL, EL 1 UN ESTADO
--	ROLLBACK TRANSACTION
--END
--END

--ESTE SERIA DE OTRA FORMA, CON EL @@ROWCOUNT
--CREATE OR ALTER TRIGGER TR_BORRA_EMP
--   ON  [dbo].[EMP_BULK]
--   AFTER DELETE
--AS 
--BEGIN
--	DECLARE 
--	@FILA AS INT = @@ROWCOUNT
--	IF @FILA >= 2
--BEGIN
--	RAISERROR('NO SE PUEDE ELIMINAR MAS DE DOS EMPLEADOS',16,1)
--	ROLLBACK TRANSACTION
--END
--END
--SI YO QUIERO QUE SI SE INTENTA BORRAR UN REGISTRO EN LA TABLA PUES ME DE ERROR, SOLO TENGO DEJAR EL RAISERROR Y EL ROLLBACK
--SI INTENTO BORRAR ESTO, ME SALDRA EL ERROR QUE ESPECIFIQUE, Y NO SE BORRRAN LOS DATOS, PORQUE A PESAR DE QUE EL TRIGGER ES FOR/AFTER SI HIZO UN ROLLBACK EN EL TRIGGER
--DELETE FROM [dbo].[EMP_BULK] WHERE ID_EMP IN (7389,7391) 
--SELECT * FROM [dbo].[EMP_BULK]





--ESTO SERIA PARA ACTUALIZAR, SI HAGO ALGUNA ACTUALIZACION EN LA TABLA EMP, PUES ME SALDRA UN ERROR Y HACE EL ROLLBACK
--CREATE OR ALTER TRIGGER TR_UPDATE_EMP
--   ON  [dbo].[EMP_BULK]
--   AFTER UPDATE
--AS 
--BEGIN
---- IF UPDATE(SALARIO) --ESTO SERIA PARA APLICARLO A UN CAMPO EN ESPECIFICO. SI QUIERO QUE SEA CUALQUIER REGISTRO SOLO TENGO QUE QUITAR ESTO
--BEGIN
--	RAISERROR('NO SE PUEDE ACTUALIZAR ESTA TABLA',16,1) 
--	ROLLBACK TRANSACTION
--END
--END 
--UPDATE [dbo].[EMP_BULK] SET SALARIO = 4500.00 WHERE ID_EMP = 7391;

--TRIGGER QUE SI INSERTO UN PUESTO DE TRABAJO(JOB) QUE SEA IGUAL A PRESIDENTE ME SALTE ESTE ERROR, Y HACE EL ROLLBACK
--CREATE OR ALTER TRIGGER TR_UPDATE_EMP
--   ON  [dbo].[EMP_BULK]
--   AFTER INSERT
--AS 
--BEGIN
--	IF (SELECT JOB FROM INSERTED) = 'PRESIDENT' --ESTE ES EL QUE ESTAMOS USANDO. SI QUIER QUE ME DE EL ERROR, CUANDO INSERTO CUALQUIER REGISTRO SOLO TENGO QUE QUITAR ESTA PARTE
--BEGIN
--	RAISERROR('NO SE PUEDE INSERTAR UN REGISTRO',16,1) 
--	ROLLBACK TRANSACTION
--END
--END

-- INSERT INTO [dbo].[EMP_BULK] VALUES (1111, 'LEBRON','PRESIDENT', NULL, '1970-12-11', 7000.00, NULL, 10)  --SI INSERTO ESTO ME DARIA UN ERROR, PORQUE ESTOY INSERTANDO UN JOB = 'PRESIDENT'
 
-- SELECT * FROM [dbo].[EMP_BULK];
-- INSERT INTO [dbo].[EMP_BULK] (ID_EMP) VALUES (1201)
---------------------------------------------------------------------------------------------------------

----TRIGGER QUE PROTEGE A LA TABLA DE INSERT, UPDATE O DELETE, ADEMAS DE QUE CUALQUIER ACCION QUE SE HAGA LO INSERTARA EN LA TABLA CONTROL. ESTOS DE PRUEBA ESTE ES CON ALTER Y CON ROLLBACK CLARAMENTE

--CREATE OR ALTER TRIGGER T_GUARDIAN_CONTROL_ALTER
-- ON [dbo].[EMP_BULK]
-- AFTER UPDATE, DELETE, INSERT
-- AS
--	IF EXISTS (SELECT 0 FROM INSERTED)
--	IF EXISTS (SELECT 0 FROM DELETED)
--BEGIN
--	 RAISERROR('NO SE PUEDEN ACTUALIZAR REGISTROS EN ESTA TABLA',16,1)
--	 ROLLBACK TRANSACTION
--	 SET NOCOUNT ON
--	 INSERT INTO [dbo].[CONTROL_EMP] VALUES
--	 (SUSER_NAME(), GETDATE(), RIGHT(GETDATE(),7), 'INTENTO DE ACTUALIZACION DE REGISTRO')
--END
--	ELSE
--BEGIN
--	 RAISERROR('NO SE PUEDE INSERTAR REGISTROS EN ESTA TABLA',16,1)
--	 ROLLBACK TRANSACTION
--	 SET NOCOUNT ON
--	 INSERT INTO [dbo].[CONTROL_EMP] VALUES
--	 (SUSER_NAME(), GETDATE(), RIGHT(GETDATE(),7), 'INTENTO DE INSERCCION DE REGISTRO')
--END
--	ELSE
--BEGIN 
--	 RAISERROR('NO SE PUEDE BORRAR REGISTROS EN ESTA TABLA',16,1)
--	 ROLLBACK TRANSACTION
--	 SET NOCOUNT ON
--	 INSERT INTO [dbo].[CONTROL_EMP] VALUES
--	 (SUSER_NAME(), GETDATE(), RIGHT(GETDATE(),7), 'INTENTO DE ELIMINACION DE REGISTRO')
--END


--ESTE HACE LO MISMO PERO USANDO INSTEAD OF EN VES DE ALTER, ADEMAS NO ES NECESARIO APLICARLE ROLLBACK
--CREATE OR ALTER TRIGGER T_GUARDIAN_CONTROL_ALTER
--ON [dbo].[EMP_BULK]
--AFTER UPDATE, DELETE, INSERT
--AS
--BEGIN
--	DECLARE 
--	@USUARIO AS VARCHAR(40),
--	@HORA	 AS VARCHAR(20);
--	SET @USUARIO = SUSER_NAME(); 
--	SET @HORA = RIGHT(GETDATE(),7)
--	SET NOCOUNT ON
--	IF EXISTS (SELECT 1 FROM INSERTED) AND NOT EXISTS (SELECT 1 FROM DELETED)
--BEGIN
--	 RAISERROR('NO SE PUEDEN INSERTAR REGISTROS EN ESTA TABLA',16,1)
--	 ROLLBACK TRANSACTION
--	 INSERT INTO [dbo].[CONTROL_EMP] VALUES
--	 (@USUARIO, GETDATE(), @HORA, 'INTENTO DE INSERCCION DE REGISTRO')
--END
--	ELSE IF EXISTS (SELECT 1 FROM DELETED) AND NOT EXISTS (SELECT 1 FROM INSERTED)
--BEGIN
--	RAISERROR('NO SE PUEDEN BORRAR REGISTRO EN LA TABLA',16,1)
--	ROLLBACK TRANSACTION
--	INSERT INTO [dbo].[CONTROL_EMP] VALUES
--	(@USUARIO, GETDATE(), @HORA, 'INTENTO DE ELIMINACION DE REGISTRO')
--END
--	ELSE IF EXISTS (SELECT 1 FROM INSERTED) AND EXISTS (SELECT 1 FROM DELETED)
--BEGIN
--	RAISERROR('NO SE PUEDEN ACTULIZAR REGISTRO EN LA TABLA',16,1)
--	ROLLBACK TRANSACTION
--	INSERT INTO [dbo].[CONTROL_EMP] VALUES
--	(@USUARIO, GETDATE(), @HORA, 'INTENTO DE ACTUALIZACION DE REGISTRO')
--END
--	ELSE IF NOT EXISTS (SELECT 1 FROM INSERTED) AND NOT EXISTS (SELECT 1 FROM DELETED)
--BEGIN
--	RAISERROR('NO SE PUEDEN ACTULIZAR REGISTRO EN LA TABLA',16,1)
--	ROLLBACK TRANSACTION
--	INSERT INTO [dbo].[CONTROL_EMP] VALUES
--	(@USUARIO, GETDATE(), @HORA, 'INTENTO DE ACTUALIZACION DE REGISTRO')
--END
--END



--SELECT * FROM [dbo].[EMP_BULK]
--SELECT * FROM [dbo].[CONTROL_EMP]
--DELETE FROM [dbo].[CONTROL_EMP]
--INSERT INTO [dbo].[EMP_BULK] VALUES(7889, 'LEBRON', 'JAMES', 7839, '1983-12-30', 5600.00, NULL, 10)
--UPDATE [dbo].[EMP_BULK] SET SALARIO = 4000 WHERE ID_EMP = 111
--DELETE FROM [dbo].[EMP_BULK] WHERE ID_EMP = 7389

--NOTA: ALGO A DESTACAR DE TODOS ESTOS TRIGGERS QUE HEMOS HECHO ES SI SE INTENTA ACTUALIZAR UN REGISTRO QUE NO EXISTE VA APARECER EL MENSAJE DE QUE NO SE PUEDE BORRAR REGISTRO, EN VES DE QUE NO SE PUEDE ACTULIZAR, OSEA VA A IR AL ELSE DE QUE NO SE PUEDE BORRAR.
--EL TRIGGER DE ARRIBA Y ABAJO YA ESTAN ACTULIZADO

--PARA ARREGLAR ESTO HE ARREGLADO LA MANERA DE HACER ESTOS TRIGGER Y ES DE ESTA FORMA. AHORA EL PROBLEMA DE ARRIBA ESTA SOLUCCIONADO.
--USAR ESTA FORMA PARA CREAR TRIGGER, OSEA E ELSE IF

--CREATE OR ALTER TRIGGER T_GUARDIAN_CONTROL_INSTEADOF
-- ON [dbo].[EMP_BULK]
-- INSTEAD OF UPDATE, DELETE, INSERT
-- AS
--	SET NOCOUNT ON
--	IF EXISTS (SELECT 0 FROM INSERTED) AND EXISTS (SELECT 0 FROM DELETED)
--BEGIN
--	RAISERROR('NO SE PUEDEN ACTUALIZAR REGISTROS EN ESTA TABLA',16,1)
--	INSERT INTO [dbo].[CONTROL_EMP] VALUES
--	(SUSER_NAME(), GETDATE(), RIGHT(GETDATE(),7), 'INTENTO DE ACTUALIZACION DE REGISTRO')
--END
--	ELSE IF EXISTS (SELECT 0 FROM INSERTED) AND NOT EXISTS (SELECT 0 FROM DELETED)
--BEGIN
--	RAISERROR('NO SE PUEDEN INSERTAR REGISTROS EN ESTA TABLA',16,1)
--	INSERT INTO [dbo].[CONTROL_EMP] VALUES
--	(SUSER_NAME(), GETDATE(), RIGHT(GETDATE(),7), 'INTENTO DE INSERCCION DE REGISTRO')
--END
--	ELSE IF EXISTS (SELECT 0 FROM DELETED) AND NOT EXISTS (SELECT 0 FROM INSERTED)
--BEGIN
--	 RAISERROR('NO SE PUEDEN BORRAR REGISTROS EN ESTA TABLA',16,1)
--	 INSERT INTO [dbo].[CONTROL_EMP] VALUES
--	 (SUSER_NAME(), GETDATE(), RIGHT(GETDATE(),7), 'INTENTO DE ELIMINACION DE REGISTRO')
--END
--	ELSE IF NOT EXISTS (SELECT 0 FROM DELETED) AND NOT EXISTS (SELECT 0 FROM INSERTED)
--BEGIN
--	 RAISERROR('NO SE PUEDEN ACTUALIZAR REGISTROS EN ESTA TABLA',16,1)
--	 INSERT INTO [dbo].[CONTROL_EMP] VALUES
--	 (SUSER_NAME(), GETDATE(), RIGHT(GETDATE(),7), 'INTENTO DE ACTUALIZACION DE REGISTRO')
--END

--ESTA ES LA FORMA DEFINITIVA. EL TRIGGER CON EL ALTER YA ESTA ACTULIZADO TAMBIEN. OSEA QUE SI INTENTA ACTULIZAR UN REGISTRO NO EXISTENTE, PUES QUE APERZA EL MENSAJE QUE NO SE PUEDE ACTULIZAR REGISTRO EN VES DEL MENSAJE DE QUE NO SE PUEDA ELIMINAR
--LOS DOS HACEN LO MISMO PERO CREO QUE EL MAS RECOMENDABLE PARA ESTAS SITUACIONES ES EL DEL INSTEAD OF
--TANTO EL ALFER/FOR COMO EL INSTEAD OF, SI CREO UN TRIGGER PARA CADA ACCION NO TENGO QUE PONER IF O ELSE, OSEA SI CREO UN TRIGGER DE UN AFTER INSERT, YO SOLO TENGO QUE PONER PONER LA INSTRUCCION DE INSERTAR EN LA TABLA DE CONTROL Y EL MENSAJE, SI QUIERO BLOQUEAR, USO ROLLBACK, Y SI USO INSTEAD OF SOLO TENGO QUE PONER EL INSERT EN LA TABLA DE CONTROL Y EL MENSAJE, PORQUE INSTEAD OF YA BLOQUEA OSEA NO SE NECESITA PONER ROLLBACK. SIGUE ABAJO
-- SOLO VOY PONER IF CUANDO QUIERO QUE CUMPLA CIERTA CONDICIONES COMO POR EJEMPLO IF (SELECT COUNT(*) FROM DELETED) >=2, OSEA QUE SALTE EL TRIGGER SI EL SE BORRAN MAS DE DOS REGISTRO. IF UPDATE(SUELDO) QUE SALTE EL TRIGGER CUANDO SE ACTULIZA EL CAMPO SALARIO, IF (SELECT JOB FROM INSERTED) = 'PRESIDENT', OSEA QUE SALTE EL TRIGGER CUANDO EL JOB QUE SE INSERTE SEA 'PRESINDE'.
---------------------------------------------------------------------------------------------------
--BULK INSERT DINAMICO PARA Carga masiva de datos desde archivos
--PARA ESTA PRACTICA, COMO LO HICIMOS LA OTRA VES DEBEMOS DE CREAR UNA TABLA, EN ESTE CASO SERA UNA TABLA TEMPORAL
--SELECT * FROM tempdb.sys.tables --para ver mis tablas temporales

--IF EXISTS (SELECT name FROM tempdb.sys.tables WHERE name LIKE '%#BASEPEDIDOS%') --CON ESTO ESTOY DICIENDO QUE SI EXISTE UNA TABLA TEMPORAL DE MI TABLA DE SISTEMA QUE TENGA UNA COINCIDENCIA CON ESTO '%#BASEPEDIDOS%', PUES QUE ME CREE ME BORRE UNA TABLA Y CREALA 
--DROP TABLE #BASEPEDIDOS;

--CREATE TABLE #BASEPEDIDOS(
--	CodigoPedido		VARCHAR(100) NOT NULL,
--	DocumentoCliente	VARCHAR(100) NOT NULL,
--	CodigoCiudad		INT NULL,
--	CodigoProducto		VARCHAR(100) NOT NULL,
--	CantidadProducto	INT,
--	FechaPedido			DATE,
--	HoraPedido			TIME
--);
----LO QUE VA HACER AQUI ES QUE VA VER SI HAY UNA TABLA TEMPORAL QUE COINCIDA CON LOS QUE ESTA EN EL LIKE, SI ESO PASA BORRARA LA TABLA Y LUEGO LA CREARA NUEVAMENTE

--BULK INSERT #BASEPEDIDOS --TABLA DONDE SE HARA EL BULK INSERT
--FROM 'C:\Users\eddy\OneDrive\Documentos\basepedidos.txt' --UBICACION DEL ARCHIVO
----WITH (FIELDTERMINATOR = '	',  FIRSTROW = 2) --Y QUE TOME COMO PRIMERA FILA LA 2 este es para el xlsx (txt)
--WITH (FIRSTROW = 2) --ESTE ES EL QUE VINO COMO TXT
----ERAN DOS ARCHIVO PARA REALIZAR ESTA PRUEBA, xlsx Y txt, pero como me ponia 0 filas afectadas con el xlsx tuve que pasarlo a txt delimitado por tabulaciones, asi fue que pude

--SELECT * FROM #BASEPEDIDOS

--WAITFOR DELAY '00:00:01'; --ESTO PARA PONER DELAY ENTRE INTRUCCION. OSEA Este código espera 1 segundo después de eliminar la tabla antes de intentar crearla nuevamente.

--INTENTE HACER UN SP DE ESTO PERO NO VALIA LA PENA PORQUE En la sintaxis de BULK INSERT, no se puede usar variables para especificar el nombre de la tabla o el archivo.
--ASI QUE LO MEJOR SERIA HACERLO DE ESTA MANERA.
----------------------------------------------------------------------------------
--VARIABLES DE SISTEMAS
--las "variables de sistema" generalmente se refieren a las variables globales predefinidas que se utilizan para configurar el comportamiento y las opciones de funcionamiento del servidor de base de datos. Estas variables afectan aspectos como el rendimiento, la seguridad, la administración de recursos y otras configuraciones de SQL Server.

--LAS VARIABLES SE CARACTERIZAN POR TENER DOBLE ARROBA (@@)
--NOTA: PRINT NO TRAE TIPO DE DATOS ENTEROS, SOLO STRING
--PRINT 'VERSION: ' + @@VERSION --DEVUELE VERSION COMPLETA E INFORMACION DE NIVEL DE SERVICIO
--PRINT 'LENGUAJE: ' + @@LANGUAGE --SABER EL LENGUAJE O IDIOMA EN LA QUE ESTA MI BASE DE DATOS. RECORDA QUE EL LENGUAJE SE PUEDE CAMBIAR
--PRINT 'SERVIDOR: ' + @@SERVERNAME  --DEVUELVE EL NOMBRE DE MI SERVIDOR
--PRINT 'CONEXIONES USUARIO: ' + STR(@@CONNECTIONS); --ESTO SIGNIFICA QUE HAY APLICACIONES QUE ESTAN UTILIZANDO SESIONES DE USUARIO PARA REALIZAR PROCESOS DENTRO DE NUESTRA BD, PROGRAMAS INTERNOS DE LA BD. NO USUARIOS FISICOS QUE ESTAN CONECTADOS A LA BD --AQUI TUVE QUE CONVERTIRLO A STRING PORQUE PRINT NO TRAE TIPO DE DATOS ENTEROS.
--PRINT 'CONEXIONES MAXIMA: ' + STR(@@MAX_CONNECTIONS); --DEVUELVE MAXIMA CONEXIONES PERMITIDA A MI BD
--PRINT 'TIEMPO EN PROCESO: ' + STR(@@CPU_BUSY) + ' SEGUNDOS' ; --EL TIEMPO QUE HA ESTADO EN ABIERO MI BD. ESTA EN SEGUNDOS.
--PRINT 'TIEMPO DE INACTIVIDAD' + STR(@@IDLE) + ' SEGUNDOS' --DEVUELVE TIEMPO QUE HA ESTADO INACTIVA MI BD
--PRINT 'TRANSACCIONES ACTIVAS: ' + STR(@@TRANCOUNT) --DEVUELVE LAS TRANSACCIONES ACTIVAS.
--PRINT 'ULTIMA FILAS AFECTADAS: ' +STR(@@ROWCOUNT) -- ME TREA LAS FILAS AFECTADAS
--PRINT 'ULTIMO FECTH DE UN CURSOR: ' +STR(@@FETCH_STATUS) --DEVUELVE LA ULTIMA OPERACION FETCH EN UN CURSOR
--PRINT 'ERROR ULTIMA OPERACION: ' +STR(@@ERROR); --DEVUELVE EL CODIGO ERROR DE LA ULTIMA OPERACION
--PRINT 'ULTIMO IDENTITY: ' +STR(@@IDENTITY); --DEVUELVE EL ULTIMO VALOR IDENTITY INGRESADO DE LA TABLA MAS RECIENTE
--PRINT 'EL PRIMER DIA DE LA SEMANA: ' +STR(@@DATEFIRST) --DEVUELVE EL PRIMER DIA DE LA SEMANA.
--PRINT 'BLOQUEO EN MILISEGUNDO: ' +STR(@@LOCK_TIMEOUT); --DEVUELVE EL TIEMPO DE BLOQUEO DE SESION (ESTO ES CASO DE ESTA ACTIVADO, YO LO TENGO DESACTIVADO, ME SALE (-1)

--SI YO SELECCIONO ESTO TENDRE UN REPORTE DE COMO ESTA MI BD
------------------------------------------------------------------------
----LOOPS
---- los "loops" se refieren a un tipo de estructura de control que permite ejecutar un bloque de código repetidamente mientras se cumpla una determinada condición. Los loops en SQL Server se utilizan generalmente para realizar operaciones repetitivas en conjuntos de datos, como recorrer filas en una tabla y realizar acciones específicas en cada fila.
----EL BUCLE WHILE SE USA MAS QUE EL BUCLE FOR, . La flexibilidad del bucle WHILE y su capacidad para manejar condiciones más complejas hacen que sea más comúnmente utilizado en entornos de SQL Server.

----ESTO UN BUCLE QUE VA IMPRIMIR LOS NUMEROS DEL 0 HASTA EL 10, OSEA MIENTRAS QUE LA VARIABLE SEA MENOR O IGUAL A 10, ME VAS IMPRIMIR LA VARIABLE CONTEO Y EN CADA ITERACION SE LE SUMA 1
--PRINT 'LOS NUMEROS SON: '
--PRINT ''
--DECLARE
--	@CONTEO INT = 0
--WHILE @CONTEO <= 10
--BEGIN
--	PRINT ('Vuelta Numero: ' +CONVERT(VARCHAR,@CONTEO)) --AQUI PUEDO PONER CAST, O TAMBIEN PONERLO EN SELECT
--	--SET @CONTEO += 1; --SE UTLIZA EL += PARA SUMAR, Y EL -= PARA RESTAR
--	SET @CONTEO = @CONTEO + 1 --TAMBIEN SE PUEDE UTLIZAR DE ESTA FORMA. PERO CREO QUE LA OTRA FORMA ES MEJOR
--END

----TABLA DE MULTIPLICAR, ESTA LA HICE YO
--DECLARE 
--@NUMERO AS INT = 8,
--@MULTIPLICA AS INT = 1,
--@RESULTADO AS INT

--WHILE @MULTIPLICA <=12
--BEGIN
--	SET @RESULTADO = @MULTIPLICA * @NUMERO
--	PRINT CONVERT(VARCHAR, @MULTIPLICA) + ' X ' + CAST(@NUMERO AS VARCHAR) + ' = ' + CONVERT(VARCHAR, @RESULTADO)
--	SET @MULTIPLICA +=1;
--END

----ESTA ES LA FORMA COMO LO HIZO EL PROFESOR
--DECLARE
--	@CONTEO AS INT = 1,
--	@TABLA AS INT = 6;
--WHILE (@CONTEO <=12)
--BEGIN
--	PRINT STR(@CONTEO)+ ' X ' + STR(@TABLA)+ ' = ' + STR(@CONTEO*@TABLA)
--	SET @CONTEO +=1;
--END
--------------------------------------------------------------------
--SQLServerManager16.msc --ENTRAR AL ADMINISTRADOR DE CONFIGURACION EN SQL SERVER 2022. SI ES DEL 2019 ES 15 EN VES DE 16.

--BREAK
--el comando BREAK se utiliza en bucles para romper el ciclo dentro de un codigo y ejecutar una instruccion programada previamente.
--SI YO QUIERO REALIZAR UNA ACCION CUANDO MI BUCLE VAYA POR EL NUMERO 7,UTILIZO EL BREAK. EL BREAK ROMPE EL BUCLE EN EL PUNTO QUE LE DIGAMOS QUE EN ESTE CASO ES CUANDO SEA IGUAL A 7
--DECLARE
--@CONTEO AS INT = 1 --EL BUCLE COMIENZA EN 1
--WHILE @CONTEO <=12 --EL BUCLE FINALIZA CUANDO LLEGE A 12
--BEGIN
--	PRINT 'CONTANDO...'
--	SET @CONTEO +=1 --VA IR SUMANDO DE A 1
--	IF @CONTEO = 7 BREAK --ESTO VERIFICA EL SI EL VALOR DE MI VARIABLE ES 7, SI ES ASI SAL DE BUCLE.
--END
--	PRINT 'EL VALOR YA ES: ' + STR(@CONTEO)
-- LO QUE HACE ESTE BUCLE ES QUE A PESAR DE QUE EL BUCLE VA REPETIR EL PRINT HASTA QUE SEA MENOR O IGUAL A 12, CUANDO SEA IGUAL A 7 SE DETIENE, Y LUEGO MOSTRARA EL VALOR ACTUAL QUE EN ESTE CASO ES 7
--------------------------------------------------------------
--CONTINUE
--La instrucción CONTINUE se utiliza en T-SQL (Transact-SQL) para saltar a la siguiente iteración del bucle sin romper el bucle en la iteración actual.
--hacer que un bucle me genere una informacion especifica en un punto de su proceso
--con el break interrumpia el proceso en cambio con el continue, con esto hare un proceso en especifico sin que se interrumpa

--este codigo hace lo mismo que el ejemplo del break, pero en ves de salir del bucle, continua. osea despues de que sea el imprima el mensaje de que el valor ya es 7, sigue con el mensaje de contando..;.
--DECLARE
--	@VALOR AS INT = 1
--WHILE @VALOR <=12
--BEGIN
--	PRINT 'CONTANDO...'
--	SET @VALOR +=1
--	IF @VALOR =4
--		PRINT 'EL VALOR YA ES: ' + STR(@VALOR)
--		----CONTINUE --SI YO PONGO ESTE CONTINUE AQUI NO VA PASAR AL IF DE ABAJO SINO QUE A SALTAR A LA SIGUIENTE ITERACION, OSEA NO VA IMPRIMIR: EL VALOR YA ES: 7
--	IF @VALOR =7
--		PRINT 'EL VALOR YA ES: ' + STR(@VALOR)
--		CONTINUE
--END;
--	PRINT 'EL VALOR YA ES: ' + STR(@VALOR)
--una cosa a recalcar es que a pesar de que bucle llega hasta a <=12, el ultimo valor lo imprime con valor a 13. tenia esa duda, pero lo imprime es 12 contando.... y tres imprime de EL VALOR YA ES:, que en este caso son 4, 7 que son lo que estan en el if, y el 13 que el ultimo, este ultimo se agrega como 13 porque esta fuera del bucle.
--otra cosa es que quite la palabra continue y siguio funcionando. si pongo dos continue al codigo, debo de hacerlo en el begin y end, cada uno
-------------------------------------------------------------------------------------------------------------------------------------------
--BUCLES ANIDADOS
--los bucles anidados se refieren a la ejecución de instrucciones de bucle dentro de otros bucles dentro del contexto de un procedimiento almacenado, una función definida por el usuario o un bloque de código Transact-SQL (T-SQL).
--Los bucles anidados en SQL Server generalmente se implementan utilizando estructuras de control como las sentencias WHILE, FOR, y CURSOR. Estos bucles permiten repetir un conjunto de instrucciones o consultas SQL en función de una condición o un número específico de iteraciones.

--El código T-SQL tiene dos bucles WHILE anidados. El externo cuenta hasta 3 y muestra un mensaje. Dentro de cada iteración externa, el bucle interno cuenta hasta 5 y muestra otro mensaje.
--DECLARE 
--@VALOR AS INT = 1,
--@VALOR2 AS INT = 1
--WHILE @VALOR <=3
--BEGIN
--	PRINT 'BLOQUE ANIDADO EXTERNO: ' +STR(@VALOR)
--	SET @VALOR2 = 1  -- Restablecer el valor de @VALOR2 a 1 antes del bucle interno

--	WHILE @VALOR2 <=5
--BEGIN
--		PRINT 'BLOQUE ANIDADO INTERO: ' +STR(@VALOR2)
--		SET @VALOR2 +=1
--END
--	SET @VALOR +=1
	
--END
--LO QUE HACE ESTE LOOP ANIDADO ES QUE IMPRIME PRIMERO EL PRIMER VALOR DEL BLOQUE EXTERNO, Y LUEGO VA IMPRIMIR HASTA EL 5 LOS BLOQUES INTERNOS, DESPUES IMPRIMIRA EL BLOQUE EXTERNO +1 Y LUEGO NUEVAMENTE VA IMPRIMIR HASTA EL 5, ASI SUCESIVAMENTE HASTA EL VALOR QUE SE REQUIRIO
-------------------------------------------------------------------------
--ESTE ES UN BUCLE QUE VA HACER LA MULTIPLICAR DE LAS TABLAS DEL 5,6 Y 7 USANDO BUCLES ANIDADOS

--DECLARE
--	@TABLA AS INT = 5,
--	@VALOR AS INT = 1
--WHILE @TABLA <=7
--BEGIN
--	PRINT 'TABLA DE MULTIPLICAR DEL: '+ CAST(@TABLA AS VARCHAR)
--	SET @VALOR = 1

--WHILE @VALOR <=12
--BEGIN
--	PRINT CAST(@VALOR AS VARCHAR) + ' X ' + CONVERT(VARCHAR, @TABLA) + ' = ' + CAST(@VALOR*@TABLA AS VARCHAR)
--	SET @VALOR +=1
--END
--	SET @TABLA +=1
	
--	PRINT ' '
--END
-----------------------------------------------------------
----administrar nuestros registros usando la clausula While
--SELECT * FROM [dbo].[productos]

----LO QUE HACE ESTE SP ES QUE VA TRAER TODOS LOS REGISTROS DE MI TABLA PRODUCTO USANDO UN BUCLE WHILE
--CREATE OR ALTER PROCEDURE PR_VER_PRODUCTOS
--AS
--DECLARE
--	@CONTEO AS INT = (SELECT MAX(idproducto) FROM [dbo].[productos])
--WHILE @CONTEO > 0
--BEGIN
--	IF EXISTS ( SELECT * FROM [dbo].[productos] WHERE idproducto = @CONTEO) 
--	SELECT * FROM [dbo].[productos] WHERE idproducto = @CONTEO;
--	SET @CONTEO -=1;
--END

--EXEC [dbo].[PR_VER_PRODUCTOS]
----SE DECLARA UNA VARIABLE LLAMADA CONTEO QUE SERA IGUAL AL ID MAXIMO DE MI TABLA PRODUCTO Y QUE MIENTRA MI VARIABLE SEA MAYOR A 0 ENTONCES ME VA HACER UN SELECT DE MI TABLA PRODUCTO CUANDO EL IDPRODUCTO SEA IGUAL A LA DE MI VARIBALE CONTEO, Y MI VARIABLE CONTEO EN CADA ITERACION SE LA VA RESTAR 1, HASTA QUE FINALMENTE LLEGE A 0


----SP QUE QUE APLIQUE UN DESCUENTO DE UN 10% A TODOS AQUELLOS PRODUCTOS QUE NO SE HAN VENDIDO, USANDO BUCLE WHILE
--CREATE OR ALTER PROCEDURE SP_ACT_PRODUCTO
--AS
--DECLARE
--	@ID AS INT = (SELECT MAX(idproducto) FROM [dbo].[productos])
--WHILE @ID >0 --Mientras que @ID sea mayor que cero, hacer lo siguiente:
--BEGIN
	
--	IF EXISTS (SELECT idproducto from [dbo].[productos] WHERE idproducto = @ID AND vendidos IS NULL) ---- Si existe un registro en la tabla [dbo].[productos] que tenga el mismo valor de @ID en la columna idproducto y que tenga la columna vendidos vacía, entonces:
--	UPDATE [dbo].[productos] SET precio_unidad =  precio_unidad * 0.9 --DESCUENTO DE UN 10%
--	OUTPUT DELETED.idproducto as id, DELETED.precio_unidad as viejo, INSERTED.precio_unidad as nuevo ---- Mostrar el valor antiguo y el nuevo de la columna precio_unidad, junto con el valor de la columna idproducto
--	WHERE idproducto = @ID AND vendidos IS NULL
	
--	SELECT @ID = MAX(idproducto) FROM [dbo].[productos] ---- Asignar a la variable @ID el valor máximo de la columna idproducto de la tabla [dbo].[productos]
--	WHERE idproducto < @ID AND vendidos is null ---- Solo considerando los registros que tienen un valor menor que el actual de @ID y que tienen la columna vendidos vacía
--	--SI PONGO SET @ID -=1 EN VES DE LO QUE ESTA ARRIBA, TAMBIEN FUNCIONARIA
--END

--EXEC SP_ACT_PRODUCTO 
--SELECT * FROM [dbo].[productos]
--ALTER TABLE [dbo].[productos] DISABLE TRIGGER [T_PRVENIR_IDU];

--ESTE SERIA EL SP DE ARRIBA, SIN USAR EL WHILE
--UPDATE [dbo].[productos] SET precio_unidad = precio_unidad * 0.9
--OUTPUT 
--	INSERTED.idproducto		as id, 
--	INSERTED.precio_unidad	as nuevo_precio, 
--	DELETED.precio_unidad	as viejo_precio
--WHERE vendidos IS NULL 
-----------------------------------------------------------------------------
--CURSORES
--Los cursores son objetos que permiten a los desarrolladores y administradores de bases de datos recorrer filas de resultados de consultas de manera secuencial. 
--Los cursores proporcionan una forma de procesar registros uno a uno en un conjunto de resultados, lo que puede ser útil en situaciones donde se necesita un control detallado sobre el procesamiento de datos.

--CURSOR DE SOLO LECTURA

--CURSOR PARA RECORRER TABLAS, AUNQUE NO SE UTILIZAN PARA ESTO
--SELECT * FROM [dbo].[productos];
----CURSOR QUE ME DEVUELVA LOS PRECIOS DE MI TABLA PRODUCTO

--DECLARE
--	@DESCRIPCION AS NUMERIC(6,2); --ESTE DEBE DE SER DEL MISMO TIPO DE DATO QUE CAMPO PRECIO_UNIDAD.
--DECLARE
--	PROD_INFO CURSOR FOR -- Declarar un cursor llamado PROD_INFO que recorre el resultado de la siguiente consulta
--SELECT precio_unidad FROM [dbo].[productos] -- Seleccionar la columna precio_unidad de la tabla [dbo].[productos]
--OPEN PROD_INFO -- -- Abrir el cursor
--FETCH NEXT FROM PROD_INFO INTO @DESCRIPCION --- Obtener el primer valor de la columna precio_unidad y guardarlo en la variable @DESCRIPCION
--WHILE @@FETCH_STATUS = 0 --ESTO QUIERE DECIR, QUE MIENTRAS ENCUENTRA DATOS EN EL FECTH DE ARRIBA, ESTO VA A HACER 0 (SE PONE 0 SE PARA VERIFICAR SI TODO ESTA BIEN) Y VA HACER EL BUCLE . -- Mientras que no haya errores en la obtención del valor, hacer lo siguiente:
--BEGIN
--	PRINT @DESCRIPCION  -- Imprimir el valor de la variable @DESCRIPCION
--	FETCH NEXT FROM PROD_INFO INTO @DESCRIPCION ---- Obtener el siguiente valor de la columna precio_unidad y guardarlo en la variable @DESCRIPCION
--END ---- Fin del bucle while
--CLOSE PROD_INFO --CERRAR UN CURSOR. ABRIR UN CURSOR ES ABRIR UN PROCESO, Y LOS PROCESOS NO PUEDE QUEDARSE ABIERTO EN SQL
--DEALLOCATE PROD_INFO -- Liberar el cursor
--LOS CURSORES NO SE SE SUELEN UTLIZAR PARA TRAER DATOS EN SALIDA DE DATOS POR CONSOLAS. SE CREA PARA QUE UNA APLICACION GENERE UN RESULTADO EN UNA INTERFAZ DE USUARIO, VENTANA, ETC.

--CURSOR HECHO POR MI
--PRINT 'FECHA NACIMIENTO'
--PRINT ''
--DECLARE
--	@NACIMIENTO AS DATE;
--DECLARE NACIMIENTO_EMP CURSOR FOR
--SELECT [FECHA_NACIMIENTO] FROM [dbo].[EMP_BULK]
--OPEN NACIMIENTO_EMP
--FETCH NEXT FROM NACIMIENTO_EMP INTO @NACIMIENTO

--WHILE @@FETCH_STATUS = 0
--BEGIN
--	PRINT @NACIMIENTO
--	FETCH NEXT FROM NACIMIENTO_EMP INTO @NACIMIENTO
--END
--CLOSE NACIMIENTO_EMP
--DEALLOCATE NACIMIENTO_EMP 

 --Es importante mencionar que el uso de cursores debe ser evitado en la medida de lo posible, ya que las operaciones basadas en conjuntos o instrucciones SET son generalmente más eficientes. Solo utiliza cursores cuando no haya otra opción o cuando sea absolutamente necesario.
------------------------------------------------
 --CURSOR A NIVEL DE VARIOS CAMPOS DE TABLAS
 --ESTE ES UN CURSOR QUE ME VA TRAER LOS TODOS LOS VALORES DE MI TABLA PRODUCTO, UNO POR UNO
--DECLARE ---- Declarar las siguientes variables para guardar los valores de las columnas de la tabla [dbo].[productos]
--	@ID AS INT,
--	@NOMBRE AS VARCHAR(100),
--	@PRECIO AS NUMERIC(6,2),
--	@EXISTENCIA AS INT,
--	@VENDIDOS AS INT;
--DECLARE -- Declarar un cursor llamado CU_PROD con las siguientes características:
--CU_PROD CURSOR LOCAL STATIC READ_ONLY FOR ---- El cursor es local (solo visible en la sesion actual), estático (almacenar los datos en el momento de abril cursor) y de solo lectura (no permite modificaciones)
--SELECT -- Seleccionar las siguientes columnas de la tabla [dbo].[productos]
--	[idproducto],
--	[nombre],
--	[precio_unidad],
--	[existencia],
--	ISNULL([vendidos],0) -- La cantidad de vendidos del producto, o cero si es nulo. ya que si habia cualquier columna con un valor nulo, pues no iba a mostrar la fila completa, solo por tener 1 nulo, este campo tenia muchos valores nulos, y los otros campos no tenian valores nulos.
--FROM [dbo].[productos];
--OPEN CU_PROD -- Abrir el cursor
--FETCH NEXT FROM CU_PROD INTO @ID, @NOMBRE, @PRECIO, @EXISTENCIA, @VENDIDOS -- Obtener el primer registro del cursor y guardar sus valores en las variables correspondientes.
--WHILE @@FETCH_STATUS = 0 ---- Mientras que no haya errores en la obtención del registro, hacer lo siguiente:
--BEGIN
	
--	PRINT CAST(@ID AS VARCHAR)+ ' ' + @NOMBRE + ' ' + CAST(@PRECIO AS VARCHAR) + ' ' + CAST(@EXISTENCIA AS VARCHAR) +' '+ CAST(@VENDIDOS AS VARCHAR) -- Imprimir las variables separadas por espacios, convirtiendo los valores numéricos a cadenas. recordar que los valores enteros no funcionan en un print por eso la conversion
--	FETCH NEXT FROM CU_PROD INTO @ID, @NOMBRE, @PRECIO, @EXISTENCIA, @VENDIDOS -- Obtener el siguiente registro del cursor y guardar sus valores en las variables correspondientes
--END --fin del bucle while
--CLOSE CU_PROD --cerrar cursor
--DEALLOCATE CU_PROD --liberar cursor
--------------------------------------------
-- cursores para actualizar datos en nuestras tablas.
--SELECT idempleado, puesto, salario FROM [dbo].[empleados] WHERE puesto = 'Secretaria'

----CURSOR DE ACTULIZAR EL SALARIO A UN 10% CUANDO EL PUESTO SEA SECRETARIA
--DECLARE  ---- Declarar las siguientes variables para guardar los valores de las columnas de la tabla [dbo].[empleados]
--	@IDEMPLEADO AS INT,
--	@SALARIO AS DECIMAL(10,2);
--DECLARE -- Declarar un cursor llamado CU_EMPLEADO_SALARIO que recorre el resultado de la siguiente consulta.
--	CU_EMPLEADO_SALARIO CURSOR FOR
--	SELECT idempleado, salario FROM [dbo].[empleados] --ESTOS SON LOS VALORES A ALMACENAR EN MIS VARIABLES. - Seleccionar el id y el salario de los empleados que tienen el puesto de secretaria
--	WHERE puesto = 'Secretaria' 
--OPEN CU_EMPLEADO_SALARIO --abrir el cursor
--FETCH NEXT FROM CU_EMPLEADO_SALARIO INTO @IDEMPLEADO, @SALARIO --VOY A EXTRAER LA PRIMERA FILA DEL SELECT DE ARRIBA (QUE TIENEN DOS CAMPOS) Y LOS ALMACENAR EN ESTA DOS VARIABLES (LOS CAMPOS DEL SELECT DEBE COINCIDIR CO EL NUMERO DE VARIABLES). -- Obtener el primer registro del cursor y guardar sus valores en las variables correspondientes
--WHILE @@FETCH_STATUS = 0 -- Mientras que no haya errores en la obtención del registro, hacer lo siguiente:
--BEGIN
--	SET @SALARIO = @SALARIO * 1.10; -- Aumentar el salario en un 10% multiplicándolo por 1.10 y guardarlo en la misma variable,
--	UPDATE [dbo].[empleados] SET salario = @SALARIO --- Actualizar el valor de la columna salario de la tabla [dbo].[empleados] con el nuevo valor de la variable
--	OUTPUT DELETED.salario AS VIEJO_SALARIO, INSERTED.salario AS NUEVO_SALARIO --PARA QUE AL EJECUTAR ME TRAIGA EL VIEJO SALARIO Y EL NUEVO
--	WHERE CURRENT OF CU_EMPLEADO_SALARIO -- Solo para el registro actual del cursor. SI PONGO idempleado = @IDEMPLEADO TAMBIEN VA A FUNCIONAR
--	FETCH NEXT FROM CU_EMPLEADO_SALARIO INTO @IDEMPLEADO, @SALARIO -- Obtener el siguiente registro del cursor y guardar sus valores en las variables correspondientes
--END -- Fin del bucle while
--CLOSE CU_EMPLEADO_SALARIO --CERRAR EL CURSOR
--DEALLOCATE CU_EMPLEADO_SALARIO --LIBERAR EL CURSOR.
-----------------------------------------------------------------
--PARA PRACTICAR: 
--CREATE TABLE PRUEBA_HORA
--(
--ID INT,
--FECHA DATE,
--HORA TIME,
--HORA2 VARCHAR(10)
--);
--SELECT * FROM PRUEBA_HORA
--INSERT INTO PRUEBA_HORA VALUES (1, GETDATE(), GETDATE(), RIGHT(GETDATE(),7)) --AQUI ALMACENARA EL ID, LA FECHA TIPO DATE (SIN HORA), LA HORA TIPO TIME USANDO GETDATE() (TAMBIEN SE PUEDE UTILIZAR CURRENT_TIMESTAMP), Y OTRA HORA TIPO VARCHAR CON QUE TAMBIEN ALMACENARA LA HORA, USANDO EL RIGHT. ESTO LO HICE PARA PRACTICAS LOS TIPOS DE DATOS DE TIEMPO
-------------------------------------------------------------------
----USUSARIOS - MODO GRAFICO
----un usuario es una entidad que se utiliza para controlar el acceso y los permisos en la base de datos. Un usuario en SQL Server está asociado a un inicio de sesión (login), que es una credencial utilizada para autenticar y acceder al servidor en sí.
----EN EL NOMBRE DEL SERVIDOR DAMO CLICK DERECHO > PRPIEDADES > SEGURIDAD > Y ACTIVAMOS (YA LO TENIA ASI) SQL SERVER AND WINDOWS AUTHENTICATION MODE. ESTO ES PARA QUE PERIMITA LA CONFIGURACION DE USUARIOS CON NUESTRAS CONTRASEÑAS Y TAMTBIEN NOS PERMITA LA OPCION DE WINDOWS AUTHENTICATION MODE

--SELECT * FROM sys.schemas; --para ver los esquemas de mi bd

--CREATE SCHEMA prueba2; --CREAMOS UN ESQUEMA PARA ASIGNARSELO AL USUARIO QUE VAMOS A CREAR
----CREACION DE USUARIO POR MEDIO DE MANAGMENT STUDIO
----VAMOS A DATABASES > SEGURIDAD > LOGIN > CLICK DERECHO NEW LOGIN > MARCAMOS LA OPCION DE SQL SERVER AUTHENTICATION. Y PONEMOS EL NOMBRE DE USUARIO QUE VAYAMOS A CREAR, LA CONTRASEÑA Y MAS. --EL WINDOWS AUTHENTICATION ES PARA CUANDO ESTEMOS EN UNA RED Y EL USUARIO YA ESTE CREADO
----LUEGO VAMOS A SERVER ROLES. Y MAS.... VER EL VIDEO PARA ENTEDER.


--SELECT SUSER_NAME(); --ME APARECERA EL USUARIO Hernadez
--CON ESTE USUARIO NO PODRE ENTRAR A LAS DEMAS BD SOLO A INFOMATI QUE FUE LO QUE PEDI, ADEMAS NO PODRE CREAR NINGUNA BD.
--DEPUES PUEDO CREAR TABLAS, HACER SELECT, INSERT, ETC.. EN MI BD INFOMATI YA QUE TIENE EL DABATABSE ROLE DB_OWNER PARA MI BD INFOMATI
--RECALCAR TAMBIEN EN YO PUEDO TENER MULTIPLES CONEXIONES, OSEA YO PUEDO IR AL SIMBOLO DE ENFUCHE Y CONECTAR OTRO USUARIO.
--SI INTENTO CREAR UN TABLA, NO ME HA DEJAR, PARA ESTO QUE IR CON EL OTRO USUARIO Y QUITAR TACHADO DE DENY CREATE DB O ALTER DB, LUEGO VUELVO A MI USURIO HERNANDEZ Y PUEDO CREAR LA TABLA
--CREATE TABLE PRUEBA4 
--(CAMPO1 INT NOT NULL) --ESTE ADEMAS APARECERA CON EL ESQUEMA PRUEBA2 QUE FUE EL QUE LE PUSE POR DEFECTO AL CREAR EL USUARIO
--CREATE DATABASE PRUEBA55 --SI TACHO LA OPCION DE CREATE ANY DATABASE EN LA PARTE DE 'GRANT' CON UN USUARIO QUE TENGA PERMISOS, ENTONCES Y ME LOGEO DE NUEVO CON EL USUARIO HERNANDEZ, YA PODRE CREAR DB CON EL USUARIO HERNANDEZ


-------------------------------------------------------
--Creación y configuración de usuarios en modo script
--ALTER LOGIN Hernandez_TSQL WITH PASSWORD = 'Euh010216', --CREAMOS LA SESION Y LE PONEMOS UNA CONSTRASEÑA. SI PONE ES PORQUE LA TUVE QUE MODIFICAR
--CHECK_EXPIRATION = ON, --ESTO PARA QUE CUANDO SE LOGEE POR PRIMERA VES EL USUARIO DE LA SESION PUEDA CAMBIAR LA CONSTRASEÑA
--CHECK_POLICY = ON; -- ESTO ES PARA QUE SE APLIQUE LA POLITICA DE CONSTRASEÑA, COMO LA CANTIDAD DE CARACTERES, PARA QUE ESTO HAGA EFECTO HAY QUE IR A LA DIRECTIVA DE SEGURIDAD LOCAL > DIRECTIVA DE CUENTA > DIRECTIVA DE CONSTRASEÑA > Y EDITAR LA LONGITUD MINIMA, Y ADEMAS ACTIVAR LA DE "LA CONTRASEÑA DEBE CUMPLIR LOS REQUESITOS DE COMPLEJIDAD". CON ESTO YA HARIA EL EFECTO LA INSTRUCCION

--CREATE USER Hernandez_TSQL FOR LOGIN Hernandez_TSQL --CREAMOS EL USUARIO (CON EL MISMO NOMBRE DE LA SESSION) Y LO ASOCIAMOS AL LOGIN O SESSION QUE HEMOS CREADO ARRIBA
--WITH DEFAULT_SCHEMA = prueba2 --CON EL ESQUEMA prueba2 COMO PREDETERMINADO, AL PONER ESTO PUEDO SOLO USAR LA BD INFOMATI PORQUE ES LA TIENE EL ESQUEMA prueba2, PERO NO PUEDO NI CREAR TABLAS, NI VER LAS TABLA, HACER SELECT, INSERT, ETC. PORQUE NO SE LE ASIGNADO ROLES NI PERMISOS

--GRANT SELECT ON SCHEMA::dbo to Hernandez_TSQL --CON ESTO ESTOY DANDO PERMISOS DE HACER SELECT EN EL ESQUEMA DBO A USUARIO Hernandez_TSQL. CON ESTO ADEMAS PUEDO VER LAS TABLAS QUE TENGA SCHEMA dbo y hacer select obviamente
----SI ENTENTO CREAR UNA TABLA EN LA SESION MI USUARIO Hernandez_TSQ NO ME VA DEJAR AUNQUE TENGA EL ESQUEMA prueba2 (que es que le puse de default) para eso debo darle permisos

--GRANT CREATE TABLE TO Hernandez_TSQL AS dbo --PARA PODER CREAR TABLA CON EL ESQUEMA dbo EN MI SECCION Hernandez_TSQ. EN ESTE CASO SE ESJECUTA SASTIFACTORIAMENTE PERO CUANDO INTENTO CREAR UNA TABLA EN MI SECCION HERNANDEZ_TSQL NO PUEDO, Y ESTO LES PASO A MAS GENTE DEL VIDEO. SI INTENTO CREAR UNA TABLA >CREATE TABLE dbo.Rojo (id int)< NO ME DEJARA YA QUE ME DIRA QUE NO TENGO PERMISO, ESO CREO QUE ES UN BUG. NOTA SI EL ESQUEMA DONDE QUIERO DARLE EL PERMISO ES EL PREDETERMINADO, NO HAY QUE PONER EL AS, EN CASO CONTRARIO DEBO DE ESPECIFICAR EL ESQUEMA
--GRANT ALTER ON SCHEMA::prueba2 TO HERNANDEZ16; --ESTO ES PARA SOLUCIONAR EL BUG DE ARRIBA, TENGO QUE EJECUTAR ESTE COMANDO ANTES DE DAR EL PERMISO DE CREAR TABLAS
--GRANT INSERT, UPDATE, DELETE ON prueba2.EJEMPLO TO HERNADEZ_016 --DAR PERMISO DE INSERCCION, ACTUALIZACION Y BORRADO EN LA TABLA EJEMPLO ESQUEMA prueba2, AUNQUE SEA EL ESQUEMA PREDETERMINADO TENGO QUE ESPECIFiCARLO AL USUARIO HERNADEZ_016, TODO EN UNO.
--REVOKE UPDATE, DELETE ON dbo.EJEMPLO TO HERNADEZ_016 --PARA QUITARLE EL PERMISO DE ACTUALIZACION Y BORRADO EN EL ESQUEMA DBO TABLA EJMEPLO AL USUARIO HERNANDEZ_016
--GRANT ALTER ON SCHEMA::prueba2 TO HERNADEZ_016 --ESTE TAMBIEN ES PARA PODER BORRAR TABLAS EN SQL SERVER DE ESQUEMAS ESPECIFICOS. Esto significa que el usuario puede crear, modificar o eliminar objetos dentro de ese esquema

--IMPORTANTE SI UN USUARIO TIENE EL ROL DDLADMIN EN ESTOS SE INCLUYE LOS PERMISOS DE ALTER, CREATE, DROP, ETC... YO NO PUEDO QUITAR EL PERMISO DE ALTER A ESE USUARIO, PARA ESO TENGO QUE QUITARLE EL ROL. UNA ALTERNATIVA A ESTO ES CREAR UN ROL  personalizado con permisos específicos para el usuario y no incluir el permiso ALTER.
--NOTA: SI QUIERO OTORGAR EL PERMISO DE CREAR UNA BASE DE DATOS A UN USUARIO, NECESITO HACERLO DE LA BD MASTER
--SELECT HAS_PERMS_BY_NAME('Hernandez_TSQL', 'DATABASE', 'CREATE TABLE'); --PARA VER SI TIENE PERMISOS DE CREAR TABLAS


--DROP USER Hernandez_TSQL --BORRAR EL USUARIO, EN LA INTERFAZ GRAFICA SE BORRA LA SESION
--SELECT name FROM sys.sysusers WHERE islogin = 1; --ME MUESTRA TODOS MIS USUARIOS DE MI BD
-------------------------------------------------------------------------
--Un job en sql server es un objeto que representa una tarea automatizada o un conjunto de tareas que se ejecutan en un horario específico o en respuesta a ciertos eventos. Los jobs son parte de SQL Server Agent, que es un componente de SQL Server diseñado para automatizar y programar diversas tareas administrativas y de mantenimiento en la base de datos.
--Los jobs en SQL Server se crean y gestionan a través de SQL Server Management Studio (SSMS) o mediante scripts Transact-SQL. Algunos ejemplos de tareas que se pueden automatizar mediante jobs son:

--Copias de seguridad regulares de la base de datos.
--Recopilación de estadísticas y mantenimiento de índices.
--Ejecución de procedimientos almacenados o scripts en horarios específicos.
--Envío de notificaciones por correo electrónico cuando ciertos eventos ocurren en la base de datos.
--Ejecución de tareas de limpieza, como eliminar registros antiguos o archivos no necesarios.

--SELECT * FROM [dbo].[control]
--GRANT INSERT ON dbo.control TO Hernadez_016 --le otorgamos el permiso de insertar a usuario Hernandez_016
--DEPUES VAMOS SQL SERVER AGENT > JOBS > NEW JOBS > LE PONEMOS EL NOMBRE Y QUE EL DUEÑO SEA EL USUARIO Hernadez_016
--EN STEPS PONEMOS EL NOMBRE DEL PASO, LA BASE DE DATO EN QUE VA REALIZAR EL JOB, Y EN COMMANDO PONEMOS ESTO INSERT INTO dbo.control VALUES (SUSER_NAME(), GETDATE(), 'INSERTAR')
--EN SCHEDULES PONEMOS LA HORA, LAS VECES QUE VA OCURRIR LA INSERCION, ETC... LA CONFIGURACION ES DIARIO, CADA MINUTO DE 1:36 PM HASTA LAS 2:PM DEL 5 AL 6 DE FEBRERO
--Y EL JOB VA HACER LA INSERCION EN LA TABLA DE CONTROL
-----------------------------------------------------------------------------------------------------
--BACKUPS
--Aprendamos a realizar copias de seguridad o backups de nuestra base de datos para respaldar nuestra informacion.
--PARA HACER UN BACKUP DE UNA BASE DE DATOS EN MODO GRAFICO, SELECCIONAMOS LA BD > CLICK DERECHO > TASK > BACKUP. VER EL VIDEO PARA ENTEDERLO MEJOR
--NOTA: NUNCA SE DEBE SOBREESCRIBIR UN BACKUP

--CON CODIGO
--BACKUP DATABASE [AdventureWorks2019]
--TO DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSSQLSERVER_DEV\MSSQL\Backup\AdventureWorks.bak'
--WITH CHECKSUM


--ESTO ES CON UN JOB DE UN BACKUP CON FECHA Y HORA
--USE infomati
--DECLARE 
--@name AS VARCHAR(30),
--@path AS VARCHAR(150),
--@filename AS VARCHAR(20),
--@filefull AS VARCHAR(150),
--@fecha AS VARCHAR(20),
--@hora AS VARCHAR(15)

--SET @name = 'infomati'
--SET @path = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSSQLSERVER_DEV\MSSQL\Backup\'
--SET @filename = 'infomati_'
--SELECT @fecha = REPLACE(CONVERT(VARCHAR(15), GETDATE(), 111), '/', '')
--SELECT @hora =  REPLACE(RIGHT(GETDATE(),7), ':', '')



--SET @filefull = @path+@filename+@fecha+'_'+@hora+'.bak'

--BACKUP DATABASE @name
--TO DISK = @filefull WITH CHECKSUM
-----------------------------------------------------------------------------------------
 --Over
 --la clasula over() que determina las particiones y el orden de un conjunto de filas antes de que se aplique la función de agrupacion
 --Se usa  para calcular valores basados en un conjunto de filas definido dentro de una ventana específica, como por ejemplo, calcular sumas, promedios, o rangos sobre particiones definidas por el usuario.

--SELECT * FROM ordenes;

--SELECT 
--	id_orden,
--	fecha_orden,
--	monto_total,
--	id_cliente,
--	sum(monto_total) OVER() AS Total_Ventas --me va traer la suma total, 
--FROM 
--	ordenes
---------------------------------------------
--Partition by
--Partition by se usa para dividir el conjunto de resultados en particiones según los valores de una o más columnas. Esto permite realizar cálculos independientes dentro de cada partición. Por ejemplo, al utilizar ROW_NUMBER() con PARTITION BY, puedes enumerar filas dentro de cada partición, reiniciando la cuenta para cada nueva partición.
--AL USAR EL PARTITION BY EN UNA FUNCION DE AGRUPAMIENTO NO HAY USAR EL GROUP BY

--SELECT * FROM empleados;

--SELECT 
--	idEmpleado, 
--	nombre, 
--	puesto, 
--	idDepartamento, 
--	salario,
--	avg(salario) OVER(PARTITION BY idDepartamento) as "Salario Prom Dep." --me traera el promedio pero particionado por departamento
--From empleados

--SELECT 
--	idEmpleado, 
--	nombre, 
--	puesto, 
--	idDepartamento, 
--	salario,
--	sum(salario) OVER(PARTITION BY puesto) as "Salario total por posicion." --me traera el salario total pero por posicion
--From empleados

----este seria otra forma de hacer el de arriba
--SELECT 
--    e.idEmpleado, 
--    e.nombre, 
--    e.puesto, 
--    e.idDepartamento, 
--    e.salario,
--    (Select sum(salario) from empleados where puesto = e.puesto) as "salario total por puesto"
--FROM 
--    empleados e
--order by puesto


--WITH CTE_SUMA_PORCENTAJE AS
--(SELECT 
--	idEmpleado
--	,CAST(salario / (SELECT sum(salario) from empleados ) * 100 AS DECIMAL(6,2)) AS "PORCENTAJE_DE_SALARIO"
--FROM 
--	empleados
--)

--SELECT 
--	e.idEmpleado, 
--	e.nombre, 
--	e.puesto, 
--	e.idDepartamento, 
--	e.salario,
--	CAST(round(100 * salario / sum(salario)  OVER(PARTITION BY idDepartamento), 2) AS DECIMAL(7,2)) AS "PORCENTAJE DE SALARIO TOTAL POR DEPARTAMENTO" --ESTO ME TRAE EL PORCENTAJE DE SALARIO DE CADA INDIVIDUO SOBRE LOS SALARIO TOTALES EN SU DEPARTAMENTO
--	,cte.PORCENTAJE_DE_SALARIO --AQUI USO EL EL CTE PARA MOSTRAR EL PORCENTAJE
--	,SUM(cte.PORCENTAJE_DE_SALARIO) OVER() AS SUMA_PORCENTAJE --SUMO LOS PORCENTAJE Y USO OVER PARA QUE ME TRAIGA LA SUMA TOTAL DE PORCENTAJE EN TODAS LAS FILAS
--	FROM empleados as e
--	inner join CTE_SUMA_PORCENTAJE as cte
--	on e.idEmpleado = cte.idEmpleado
--------------------------------------------------------------------------
--RANK()
--RANK() --es una función de ventana que asigna un rango a cada fila de un conjunto de resultados ordenado según una expresión específica. Si dos filas tienen el mismo valor en la expresión de ordenación, se les asignará el mismo rango, y el siguiente rango se saltará

--select 
--	idEmpleado,
--	nombre,
--	puesto,
--	idDepartamento
--	,salario,
--	RANK() OVER(ORDER BY salario DESC)  as Rango --con el dense_rank no omite el siguiente valor si hay salario iguales
--from empleados
-----------------------------------------------------
--with
--clausula With para configurar tablas temporales ne nuestras consultas.

	
--WITH CTE_RANKIN_EMPLEADO AS
--(
--	SELECT 5idEmpleado, nombre, puesto, salario,
--	RANK() OVER(ORDER By salario DESC) AS RANGO
--	from empleados
--)
--SELECT * FROM CTE_RANKIN_EMPLEADO  WHERE RANGO <= 5
-------------------------------------------------------------
--CONSULTA CRUZADA
--consuLtar todas las posibles combinaciones entre dos o mas tablas

--SELECT * FROM productos;
--SELECT * FROM Empaques;

--esta consulta me muestra todas las combinaciones que hay entre dos tablas.
--SELECT  p.nombre, 
--		e.descripcion,
--		p.precio * e.peso AS PRECIO
--from productos as p
--cross join Empaques as e
--ORDER BY p.nombre
----------------------------------------------------------
--BEGIN TRANSACTION, COMMIT - ROLLBACK

--ROLLABACK: DESHACE TODAS LAS OPERACIONES REALIZADAS DENTRO DE UNA TRANSACCION
--COMMIT: CONFIRMA Y GUARDA PERMANENTEMENTE LOS CAMBIOS QUE SE REALIZEN EN UNA TRANSACCION

--SELECT * FROM empleados;

----ESTA CONSULTARA ACTUALIZARA LOS CAMPOS SOLO SI EL PROMEDIO ES MENOR A 10000, PRIMERO HACE LA ACTULIZACION Y DEPENDIENDO DEL PROMEDIO HARA UN ROLLBACK O UN COMMIT
--BEGIN TRANSACTION EMPLEADOS

--UPDATE empleados set salario = salario * 1.5;
--if (select avg(salario) from empleados) >= 10000
--begin
--	ROLLBACK TRANSACTION  EMPLEADOS;
--	PRINT 'EJECUCION REVERTIDA, PROMEDIO DE SALARIO NO CUMPLE REQUERIMIENTO!!'
--END;
--ELSE
--BEGIN
--	COMMIT TRANSACTION EMPLEADOS
--	PRINT 'SALARIOS ACTUALIZADOS CORRECTAMENTE'
END;

