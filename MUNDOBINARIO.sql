--CREATE DATABASE MUNDOBINARIO;
--USE MUNDOBINARIO;
--ALTER DATABASE MUNDOBINARIO MODIFY NAME = BN;
--CREATE TABLE [dbo].[Orders]
--(
--order_id				INT 			 	NOT NULL 	IDENTITY(1,1) PRIMARY KEY
--,order_number			INT                 NOT NULL
--,order_date			DATETIME			NOT NULL
--,order_status			INT                 NOT NULL
--)

--CREATE TABLE [dbo].[Products]
--(
--product_id			INT             NOT NULL	IDENTITY(1,1) PRIMARY KEY
--,product_code			VARCHAR(10)		NOT NULL
--,product_description	VARCHAR(100)	NOT NULL
--)	

--CREATE TABLE Measures(
--measure_id int not null Identity (1,1) PRIMARY KEY,
--measure_code varchar(10) not null,
--measure_descripcion varchar(50) not null);


--CREATE TABLE [dbo].[OrderDetails]
--(
--orderDetail_id		INT 			NOT NULL 	IDENTITY(1,1) PRIMARY KEY
--,order_id            	INT 			NOT NULL
--,orderDetail_number	INT             NOT NULL	
--,product_id           INT             NOT NULL
--,orderDetail_quantity	DECIMAL(18,2)	NOT NULL
--,orderDetail_price	DECIMAL(18,2)	NOT NULL 
--,measure_id           INT 			NOT NULL
--,notes				VARCHAR(MAX)	NULL    
--,CONSTRAINT fk_Orders FOREIGN KEY (order_id) REFERENCES Orders (order_id)
--,CONSTRAINT fk_Products FOREIGN KEY (product_id) REFERENCES Products (product_id)
--,CONSTRAINT fk_Measures FOREIGN KEY (measure_id) REFERENCES Measures (measure_id)
--);

--drop table [dbo].[Measures];

--create table test(
--id int,
--nombre varchar(10));

--EXEC SP_RENAME 'test', 'test2'; --cambiar nombre a la tabla
--sp_help test2; --mostrar informacion de la tabla

--alter table test2 add [STATUS] INT;
--ALTER TABLE [dbo].[test2] DROP COLUMN [STATUS];
--DROP TABLE [dbo].[test2];


--------------------------------------------------------------------------------------------------------------------------------------------------
--insertar registros

--INSERT INTO [dbo].[Measures] 
--([measure_code], [measure_descripcion]) 
--VALUES ('KG', 'KILOGRAMO'),('LT', 'LITRO');
--SELECT *FROM [dbo].[Measures];

--INSERT INTO [dbo].[Products] 
--([product_code],[product_description]) VALUES 
--('LPP', 'LAPIZ PROFESIONAL DE PUNTILLA'),
--('HBC', 'HOJA BLANCA TAMAÑO CARTA'),
--('GM', 'GOMA BICOLOR AZUL-ROJO');
--SELECT *FROM [dbo].[Products];

--INSERT INTO [dbo].[Orders]
--([order_number],[order_date],[order_status])
--VALUES (1000, GETDATE(),1);
--SELECT *FROM [dbo].[Orders];

--INSERT INTO [dbo].[Orders]
--([order_number],[order_date],[order_status]) OUTPUT INSERTED.order_id --el output aqui me va devolver el id de la fila afectada
--VALUES (1006, GETDATE(), 3)




--INSERT INTO [dbo].[OrderDetails]
--([order_id],[orderDetail_number],[product_id],[orderDetail_quantity],[orderDetail_price],[measure_id])
--VALUES (1,1,1,10,40,1), (1,2,3,10,10,1),(1,3,4,10,25,1),(1,4,5,10,1,1)
--SELECT *FROM [dbo].[OrderDetails];

--INSERT INTO [dbo].[OrderDetails]
--([order_id],[orderDetail_number],[product_id],[orderDetail_quantity],[orderDetail_price],[measure_id])
--VALUES (2,1,2,5,40,1), (2,2,3,2,10,1);
----------------------------------------------------------------------------------------------------------------------------------------
--select

--select *from [dbo].[Orders]
--where order_number = 1002; 

--select O.order_number, O.order_date, Od.orderDetail_number, Od.orderDetail_quantity, Od.orderDetail_price, P.product_description, M.measure_descripcion
--from [dbo].[Orders] as o
--Inner join OrderDetails as Od
--on o.order_id = od.order_id
--inner join Products as p
--on P.product_id = Od.product_id
--inner join [dbo].[Measures] as M
--on M.measure_id = od.measure_id
--where od.order_id = 1;
------------------------------------------------------------------------------------------------------------------------ 
--update

--update Products set product_description = 'LAPIZ DE PUNTILLA FINA' where product_id = 4;
--update OrderDetails set orderDetail_price = 5;
--update Orders set order_date = getdate() where order_id =2;
---------------------------------------------------------------------------------------------------------------------
--delete

--delete from [dbo].[Measures] where measure_id = 5
--delete from Orders where order_id =2;
--delete from OrderDetails where order_id = 2;
-----------------------------------
--inner join, left join, etc..

--CREATE TABLE [dbo].[Employees](
--employees_id		int				not null	identity(1,1)	primary key,
--employees_name	varchar(100)	null,
--department_id		int				null);

--CREATE TABLE [dbo].[Departments](
--	[department_id] INT NOT NULL IDENTITY(1,1) PRIMARY KEY
--	,[department_name] VARCHAR(100) NULL);

--INSERT INTO [dbo].[Employees]
--([employees_name],[department_id])
--VALUES
--('Axel Romero', 1), ('Roberto Mujica', 1),('Alondra Rosas', 2),('Rodrigo Lara', 3),('Monica Galindo', 4), ('Rosario Galicia', NULL),('Fernando Roa', 6),
--('Paola Leon', NULL);

--INSERT INTO [dbo].[Departments]
--([department_name])
--VALUES 
--('Sistemas'),('Recursos Humanos'),('Produccion'),('Venta'),('Compras');

--select e.employee_name, d.department_name 
--from Employees as e
--LEFT OUTER join Departments d
--on e.department_id = d.department_id
--where d.department_id is null;
---------------------------------------------------------------------------------------------------------------------------
--order by
--CREATE TABLE [dbo].[Employees]
--(
-- [employee_id]			INT				NOT NULL IDENTITY(1,1) PRIMARY KEY
--,[employee_name]			VARCHAR(100)	NOT NULL
--,[employee_lastnamee]		VARCHAR(108)	NOT NULL
--,[employee_birthday]		DATE			NULL
--,[employee_gender]		BIT				NULL
--,[employee_salary]		DECIMAL(18,2)	NOT NULL
--,[employee_positionName]	VARCHAR(100)	NOT NULL
--,[employee_createdDate]	DATE			NOT NULL DEFAULT GETDATE()
--,[department_id]			INT				NOT NULL
--);

--INSERT INTO Employees([employee_name],[employee_lastnamee],[employee_birthday],[employee_gender],[employee_salary],
--[employee_positionName],[employee_createdDate],[department_id])
--values


--('Axel', 'Romero', '1990-03-22', 1, 550.20, 'Programador sr.', '2020-10-01', 1),
--('Roberto', 'Mujica', '1995-03-22',1, 250, 'Analista', '2019-05-05', 1),
--('Alondra', 'Rosas', '1985-05-20', 0, 400, 'Generalista', '2018-11-01', 2),
--('Rodrigo', 'Lara', '1985-05-20', 1, 355, 'Supervisor', '2020-01-01', 3),
--('Monica', 'Galindo', '1996-02-05', 0, 211, 'Ventas Mayoreo', '2020-03-03', 4),
--('Rosario', 'Galicia', '1994-01-21', 0, 650, 'Ventas Autoservicio', '2020-03-03', 4),
--('Fernando', 'Roa', '1988-01-29', 1, 750, 'Gerente de compras', '2017-06-18', 5),
--('Paola', 'Leon', '1993-09-12', 0, 750, 'Ventas Menudeo', '2018-06-08', 4),
--('Diego', 'Zavaleta', '1991-11-12', 1, 433.5, 'Ventas Menudeo', '2021-01-12', 4),
--('Marisol', 'Paez', '1992-12-07', 0, 558.30, 'Gerente RRHH', '2018-03-17', 2)


--select employee_name, employee_salary from Employees where employee_salary =  (select max(employee_salary) from Employees); --me selecciona el nombre y salario del o los que tenga salario mas alto
--select top(3) employee_name, employee_salary from Employees order by employee_salary desc; -- me selecciona los 3 salarios mas altos
 
--select e.employee_name,e.employee_lastnamee, e.employee_salary, e.employee_createdDate, d.department_name
--from Employees as e
--inner join [dbo].[Departments] as d
--on d.department_id = e.department_id
--order by e.employee_salary desc, e.employee_createdDate 
----------------------------------------------------------------------------------------------------------------
--concat
--select concat(employee_name, ' ',employee_lastnamee, ' / ',employee_salary ) as 'nombre y apellido', employee_salary from Employees;
--select employee_name +' '+employee_lastnamee+' / '+ CAST([employee_salary] AS VARCHAR)  as 'nombre y apellido', employee_salary 
--from Employees order by 'nombre y apellido'
----------------------------------------------------------------------------------------------------------------
--top
--SELECT 
--	 distinct employee_gender
--FROM 
--	[dbo].[Employees];

--distinc
--SELECT 
--DISTINCT[d].[department_name]
--FROM
--[dbo].[Employees] as [e]
--inner join [dbo].[Departments] as [d]
--	on [e].[department_id] = [d].[department_id];
------------------------------------------------------------------------------------------------------------------------
--OPERADORES DE COMPARACION
--SELECT 
--	*
--FROM 
--	[dbo].[Employees]
--WHERE [employee_salary] <> 355
--ORDER BY 6;
------------------------------------------------------------------------------------------------------------------
--Operadores Lógicos (AND, OR, NOT, IN)
--SELECT *FROM [dbo].[Employees]
--where City = 'London' and TitleOfCourtesy = 'Mr.' and Title = 'Sales Representative';

--SELECT *FROM [dbo].[Employees]
--where City = 'Seattle' or TitleOfCourtesy = 'Dr.' or Title = 'Sales Manager';

--SELECT *FROM [dbo].[Employees]
--where EmployeeID  NOT IN (2,4,6,8);

--SELECT *FROM [dbo].[Employees]
--where (City = 'London' and TitleOfCourtesy = 'Mr.') OR Day(BirthDate) >= 23;

--SELECT *FROM [dbo].[Employees]
--where (City = 'London' and TitleOfCourtesy = 'Mr.') OR BirthDate >= '1960-01-01';
-------------------------------------------------------------------------------------------

--Operadores Lógicos (BETWEEN, LIKE, EXISTS)
--select *from Employees
--select *from Departments;
--SELECT UPPER(SUBSTRING(employee_name,1,1)) + LOWER(SUBSTRING(employee_name,2,LEN(employee_name))) as nombre from Employees; --convertir la primera letra en mayuscula
--SELECT *FROM Employees where employee_salary between 300 and 500;
--SELECT *FROM Employees where employee_birthday between '1990-01-01' and convert(date,getdate());
--SELECT *FROM Employees where employee_name like 'A%';
--SELECT *FROM Employees where employee_lastnamee like '%ro';
--SELECT *FROM Employees where employee_name like '%d%';
--SELECT *FROM Employees where employee_name not like '%A%';
--SELECT *FROM Employees where employee_name like '%_e_t%';
--SELECT *FROM Employees where employee_name like '[RM]%';
--SELECT *FROM Employees where employee_name like '%[XA]%';
--SELECT *FROM Employees where employee_name like '%[A-M]';
--SELECT *FROM Employees where employee_name like '%[A-B]%';
--SELECT *FROM Employees where employee_id like '%[1-4]%';
--SELECT *FROM Employees where employee_name like '[RM]ODRIGO';
--SELECT *FROM Employees where employee_name like '[^ARKLG]%';
--SELECT *FROM Employees where employee_id in (select department_id from Departments where department_name like '%as');
--SELECT *FROM OrderDetails where order_id = any (select order_id from orders); --ANY Y EXISTS ES LO MISMO BASICAMENTE
---------------------------------------------------------------------------------------------------
--union all
--select lastname, Firstname, title,city, country, 'query1' as 'source' from Employees where title like '%Sales Representative%'
--union 
--select lastname, Firstname, title,city, country, 'query2' as 'source' from Employees where city = 'London';
----union
--select lastname, Firstname, title,city, country from Employees where title like '%Sales Representative%'
--union 
--select lastname, Firstname, title,city, country from Employees where city = 'London';

----practicando el case, con el union 
--select lastname, Firstname, title,city, country, case when title = 'Sales Manager' then 'jefe' when title = 'Sales Representative' then 'representante' else 'soporte' end as 'Puesto' from Employees where title like '%Sales Representative%'
--union 
--select lastname,Firstname, title,city, country, case when title = 'Sales Manager' then 'jefe' when title = 'Sales Representative' then 'representante' else 'soporte' end as 'Puesto' from Employees where city = 'London';
----intersect
--select lastname, Firstname, title,city, country  from Employees where title like '%Sales Representative%'  
--intersect
--select lastname, Firstname, title,city, country from Employees where city = 'London';
----except
--select lastname, Firstname, title,city, country  from Employees where title like '%Sales Representative%'  
--EXCEPT
--select lastname, Firstname, title,city, country from Employees where city = 'London';
--------------------------------------------------------------------------------------------------------------------------------------------------
--FUNCIONES DE FECHA

--HIGHER
--SELECT SYSDATETIME();
--SELECT SYSDATETIMEOFFSET();
--SELECT SYSUTCDATETIME();

----LOWER
--SELECT GETDATE(); --SE SUELE UTILIZAR EN SQL SERVER
--SELECT CURRENT_TIMESTAMP; --SE UTILIZA EN DIFERENTES GESTORES DE BD
--SELECT GETUTCDATE();

----GET PART OF DATE

--SELECT MONTH(GETDATE()); --OBTENER EL MES DE LA FECHA ACTUAL
--SELECT YEAR(GETDATE()); -- OBTENER EL ANO
--SELECT DAY(GETDATE()); --OBTENER EL DIA
--SELECT DATEPART(YEAR,[employee_createdDate]) FROM [dbo].[Employees] --OTRA FORMA DE OBTENER EL ANO
--SELECT MONTH('2010-05-28'); --OBTENER EL MES DE UNA FECHA QUE LE ESPECIFICAMOS
--SELECT UPPER(DATENAME(MONTH,'2010-05-28')); --OBTENER EL NOMBRE DEL MES DE UNA FECHA QUE LE ESPECIFICAMOS, ADEMAS DE QUE APAREZCA EN MAYUSCULA
--SELECT DATENAME(MONTH,[employee_createdDate]) FROM [dbo].[Employees] --OTRO EJEMPLO DEL SELECT DE ARRIBA
--SELECT DATENAME(WEEK,[employee_createdDate]) FROM [dbo].[Employees] -- OBTNER LA NUMERO DE SEMANA
--SELECT DATENAME(WEEKDAY,[employee_createdDate]) FROM [dbo].[Employees] --OBTENER EL NOMBRE DEL DIA
--SELECT DATENAME(WEEKDAY, GETDATE()); --OTRO EJEMPLO DEL DE ARRIBA

----GET DIFFERENCES VALUES FROM
--SELECT DATEDIFF(DAY, '2001-02-16', '2023-04-06'); --PARA SABER LOS DIAS QUE HAN PASADO ENTRE FECHAS
--SELECT DATEDIFF(MONTH, '2001-02-16', '2023-04-06'); --PARA SABER LOS MESES QUE HAN PASADO ENTRE FECHAS
--SELECT DATEDIFF(YEAR, '2001-02-16', GETDATE()); --PARA SABER LOS ANOS QUE HAN PASADO ENTRE FECHA
--SELECT [employee_name]+' '+[employee_lastnamee] + ' '+CAST(DATEDIFF(YEAR,[employee_birthday], GETDATE()) AS VARCHAR) FROM Employees; --AQUI CONCATENO EL NOMBRE Y EL APELLIDO Y CONSIGO LA EDAD A TRAVES DE LA FUNCION DATEDIFF (TUVE QUE CONVERTIR LA FECHA EN VARCHAR POQUE ME DABA UN ERROR)
--SELECT CONCAT([employee_name], ' ',[employee_lastnamee], ' ( ',DATEDIFF(YEAR,[employee_birthday], GETDATE()), ' Años )') as 'Nombre y edad del empleado' FROM Employees; --LO MISMO QUE EL SELECT DE ARRIBA PERO USANDO LA FUNCION CONCAT
--SELECT *FROM [dbo].[Employees];

----MODIFY DATA
--SELECT GETDATE() - 5; --EL DIA ACTUAL MENOS 5 DIAS
--SELECT DATEADD(HOUR,5, GETDATE()) -- LO MISMO QUE EL SELECT DE ARRIBA, PERO PODEMOS PONER DIAS, MESES, HORAS,ETC..
--SELECT EOMONTH(GETDATE()); --OBTNER EL ULTIMA DIA DEL MES
--SELECT EOMONTH([employee_birthday]) FROM [dbo].[Employees]; -- EL MISMO QUE EL DE ARRIBA PERO APLICANDOLO A UN CAMPO DE UNA TABLA

----VALIDATION
--SELECT ISDATE('ASJASH') AS 'VALIDACION' --PARA SABER SI ES UNA FECHA, si es 1 es true, y 0 falso

--SET LANGUAGE 'SPANISH'; --PONER EL SQL MANAGEMENT STUDIO EN ESPANOL
--SELECT @@LANGUAGE; --para consultar el lenguage del SQL MANAGEMENT STUDIO
----------------------------------------------------------------------------------------------------------------------------------------------------
----SELECT SUBSTRING(employee_positionName, 1,3) FROM [dbo].[Employees]; --SACAR DE LA POSICION UNA, 3 CARACTERES.
--SELECT *FROM Employees;
--SELECT RIGHT(employee_birthday,2) FROM Employees; --OBTENER EL DIA EN QUE NACIERON, TAMBIEN EXISTE EL LEFT, OSEA LOS DOS ULTIMO DIGITOS DEL FORMATO FECHA INDICAN EL DIA
--SELECT LEN('ASADWFSFADS'); --MEDIR LA CANTIDAD DE CARACTERES QUE TENEMOS
--SELECT REPLICATE('EUH ',3); --PARA REPLICAR EUH 3 VECES;
--SELECT CHARINDEX('@','MUNDOBINARIO@GMAIOLLL.COM'); --me dice donde esta el @ en la cadena de texto, en este caso en la posicion 13
--SELECT STUFF('MUNDOBINARIO@GMAIL.COM',1,12, 'CONFIDENCIAL'); --AQUI CAMBIO MUNDO BINARIO QUE TIENE UNA 12 CARACTERES POR CONFIDENCIAL;
----LOWER LETRA MINUSCULA
----UPPER LETRA MAYUSCULA
--SELECT LTRIM('   EDDY'); --ME QUITA LOS ESPACIO DE LAS IZQUIERDA
--SELECT RTRIM('EDDY   '); -- ME QUITA LOS ESPACIO DE LA DERECHA
--SELECT TRIM('   EDDY   '); --ME QUITA TODOS LOS ESPACIOS
--SELECT '*' + REPLACE(TRIM('  EDDY HERNANDEZ'), ' ', '') + '*';
--SELECT FORMAT([employee_id], 'D5') FROM [dbo].[Employees]; --ESTO PARA QUE ME RELLENE CON CERO DELANTE DEL ID, EN ESTE CASO ME RELLENA CON 4 CEROS Y EL ID
--SELECT VALUE FROM STRING_SPLIT('PINA,MANZANA,UVA,PERA,NARANJA', ',')--AQUI VA COGER LA CADENA QUE ESTA ENTRE COMILLA, Y ME VA SEPARAR POR COMAS, OSEA EN LA CONSULTA VA APARECER 1-PINA, ABAJO MANZANA, DESPUES UVA, ETC... LO MAS HABITUAL ES QUE EL SEPARADOR SEA UNA COMA
--SI QUIERO INSERTARLO EN UNA TABLA UTLIZO EL INSERT INTO SELECT
--SELECT COMPATIBILITY_LEVEL FROM sys.databases where name = 'MUNDOBINARIO';--se utiliza para obtener el nivel de compatibilidad actual de una base de datos en particular, en este caso, la base de datos llamada 'MUNDOBINARIO'. El nivel de compatibilidad de una base de datos en SQL Server indica la versión del motor de la base de datos para la cual se diseñó originalmente la base de datos. Esto puede ser importante porque diferentes versiones del motor de la base de datos pueden tener diferentes comportamientos, funciones y características.
--ALTER DATABASE MUNDOBINARIO
--SET COMPATIBILITY_LEVEL = 130;
--GO --ESTO ES PARA CAMBIAR LA COMPATIBILIDAD DE NUESTRA BASE DE DATOS
--------------------------------------------------------------------------------------------------------------------
--CASE
--SELECT
--	CASE 
--		WHEN (1=2) 
--	THEN 'VERDADERO'
--	ELSE 'FALSO'
--END AS 'CASE'

--SELECT 
--		[POD].ProductID
--		,[POD].UnitPrice
--		,CASE WHEN [POD].UnitPrice <=25 THEN 'LOWER' 
--		WHEN [POD].UnitPrice >25 AND [POD].UnitPrice <=40 THEN 'MEDIUM'
--		ELSE 'HIGH'
--		END AS 'STATUS'
--FROM [Purchasing].[PurchaseOrderDetail] AS [POD];

--IS NULL(ES EL NVL DE ORACLE)
--SELECT
--		[V].AccountNumber
--		,[V].[Name]
--		,ISNULL([V].PurchasingWebServiceURL, 'Www.MundoBinario@gmail.com')

--FROM [Purchasing].[Vendor] AS [V];

--COALESCE (SON PARECIDO EL ISNULL Y COALESCE)

--SELECT 
--		[P].[NAME]
--		,[P].[ProductNumber]
--		,COALESCE(P.Size,P.Color, CAST(P.SellStartDate AS VARCHAR), 'EMPTY') AS 'SIZE/COLOR'
--FROM [Production].[Product] AS [P];


--SELECT 
--		[P].[NAME]
--		,[P].[ProductNumber]
--		,P.Size
--		,P.SizeUnitMeasureCode
----		,P.WeightUnitMeasureCode
--		,P.[Weight]
--		,COALESCE(P.Size, P.SizeUnitMeasureCode, P.WeightUnitMeasureCode, CAST(P.[Weight] AS VARCHAR), 'EMPTY') AS 'SIZE'

--FROM [Production].[Product] AS [P];
---------------------------------------------------------------------------------------------------------------------------------
--IIF
--SELECT IIF(1=2, 'VERDADERO', 'FALSO') AS CONDICION;
--SELECT IIF(2=2, IIF(2=3, 'VERDADERO','FALSO2'), 'FALSO1');
--SELECT IIF(LEN('SQL SERVER DESDE CERO') = 21, 'OK', 'NOT OK'); --SIN LA CADENA TIENE 21 CARACTERES VA PONER OK, SINO TIENE 21 PONDRA NOT OK

--SELECT 
--	REPLACE([E].[LoginID], 'adventure-works\', '')
--	,[E].[JobTitle]
--	,IIF([E].[Gender] = 'M', 'MALE', 'FEMALE') AS GENDER
--FROM [HumanResources].[Employee] AS [E]

--SELECT 
--	[POD].[ProductID]
--	,[POD].[UnitPrice]
--	,[POD].[StockedQty]
--	,IIF([UnitPrice] <=25 AND [StockedQty] <=5, 'YES', 'NO') AS REQUEST
--FROM [Purchasing].[PurchaseOrderDetail] AS [POD];

--CHOOSE
--SELECT ISNULL(CHOOSE(2,'SQL SERVER', 'ORACLE', 'MARIADB', 'MYSQL', 'POSGRESQL'), 'NO EMPTY'); --aqui va elegir la posicion 2 que esta en la cadena de caracteres y que separada por coma, en este caso elige la de oracle

--SELECT LOWER(CHOOSE(DATEPART(MONTH,GETDATE()), 'ENERO', 'FEBRERO', 'MARZO', 'ABRIL', 'MAYO','JUNIO','JULIO','AGOSTO')) ;
--------------------------------------------------------------------------------------------------------------------------------------
--ROWCOUNT
--AQUI LO QUE ESTA HACIENDO ES QUE SI EL SELECT DE ARRIBA TIENE MAS 4 REGISTRO (EN ESTE CASO SI) PUES QUE ME TRAIGA LA CONSULTA DE ABAJO Y ADEMAS UN SELECT @@ROWCOUNT DE LA ULTIMA CONSULTA (OSEA EL ROWCOUNT TRAE EL NUMERO DE REGISTRO DE LA ULTMA CONSULTA), (EL ROWCOUNT SE DEBE DE EJECUTAR DESPUES DE UNA INSTRUCCION DML)
--SELECT
--*
--FROM 
--	[Production].[Product]
--WHERE
--	NAME LIKE '%cha%'
--SELECT @@ROWCOUNT


--if @@ROWCOUNT >=6
--BEGIN
--SELECT
--*
--FROM 
--	[Production].[Product]
--WHERE
--	NAME LIKE '%cha%' AND COLOR = 'Silver'

--	SELECT @@ROWCOUNT
--END;
--ELSE
--BEGIN 
--	SELECT 'NO DATA'
--END;


--SELECT *FROM 
--[Production].[Location];

--UPDATE [Production].[Location] SET Availability = 0 WHERE LocationID IN (1,2);
--SELECT @@ROWCOUNT
-------------------------------------------------
----FUNCIONES DE COMPRESION
--SELECT COMPRESS('SQL SERVER'); --COMPRIMIENDO ESTA CADENA 
--SELECT CAST(DECOMPRESS(0x1F8B08000000000004000B0EF45108760D0A730D0200E55D587E0A000000) AS VARCHAR(MAX));  --DECOMPRIMIMOS LA CADENA DE ARRIBA
-------------------------------------------------------------------------------------------------------------------------------------------------
----Session Context
--EXEC sp_set_session_context 'BusinessEntityID',10 --ESTO ES COMO UNA VARIABLE AQUI LE ASIGNAMOS EL BUSINESSENTITYID EL VALOR DE 10,
--SELECT SESSION_CONTEXT(N'BusinessEntityID') AS CustomerID; --LE PONEMOS N POR QUE LA SESIONES DE CONTEXTO REQUIEREN QUE SEA NVARCHAR, DE LO CONTRARIO SALDRIA UN ERROR
--DATO: SI ABRO UN NEW QUERY Y HAGO EL SELECT NO VA FUNCIONAR EN ESE NUEVO QUERY
--SELECT 
--	*
--FROM 
--	[Person].[Person]
--WHERE
--	BusinessEntityID = SESSION_CONTEXT(N'BusinessEntityID');

--ESTE ES OTRA FORMA DE HACER EL EJEMPLO DE ARRIBA
--DECLARE @BusinessEntityID AS INT = 10

--SELECT 
--	*
--FROM 
--	[Person].[Person]
--WHERE
--	BusinessEntityID = @BusinessEntityID;
---------------------------------------------------------------------------------------------------------------------------------------------------------
--GUID
--SELECT NEWID() AS MYGUIDL; --SIEMPRE QUE EJECUTO ESTO ME DEVOLVERA UN NUMERO DIFERENTE(ES UN ID DE MUCHOS DIGITOS) COMO SE MUESTRA EN LOS EJEMPLOS DE ABAJO
--E90904E5-8121-4E09-A4B4-EFCA0D37A66E
--9D810D82-4C5B-40C2-A849-4F982EB6D8D3

--AQUI DECLARAMOS UNA VARIABLE DEL TIPO UNIQUEIDENTIFIER Y LE ASIGNAMOS A ESA VARIABLE UN NEWID(), Y CUANDO ALGO EL SELECT ME DEVOLVERA UN ID DIFERENTE OJO TENGO QUE EJECUTAR TODO EL CODIGO PARA QUE ME APAREZCA
--DECLARE @IDENTIFIER UNIQUEIDENTIFIER
--SET @IDENTIFIER = NEWID();

--SELECT @IDENTIFIER;
-----------------------------
--CREATE TABLE Courses
--(
--	CourseID UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
--	CourseName Varchar(50)
--)
--Go

--INSERT INTO Courses Values (default, 'SQL SERVER')
--INSERT INTO Courses Values (Default, 'App Sheet');
--INSERT INTO Courses Values (Default,'ARDUINO'); --al insertar estos datos en la base de dato no aparece de forma ordernada(segun lo estado insertando)
--Select *from Courses;
------------------------------------------------------------------------------
--CREATE TABLE Courses2
--(
--	CourseID UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID(),
--	CourseName Varchar(50)
--)
--Go

--INSERT INTO Courses2 Values (default, 'SQL SERVER')
--INSERT INTO Courses2 ([CourseName]) Values ('App Sheet');
--SELECT *FROM Courses2;
--El newID() los datos son aleatorio, en cambio con newsquentialid los datos tiene la misma estructura (lo que cambia es algun numero o letra, o alguna parte como se muestra abajo
--A8829BB6-27DF-ED11-B914-94E70BBB5C8C
--A9829BB6-27DF-ED11-B914-94E70BBB5C8C
--La función integrada newsequentialid() solo puede utilizarse en una expresión DEFAULT para una columna de tipo 'uniqueidentifier' en una instrucción CREATE TABLE o ALTER TABLE.
-------------------------------------------
--SELECT 
--*
--FROM Measures;
--INSERT INTO Measures VALUES ('T','TEST');
--SELECT SCOPE_IDENTITY(); CON ESTO ME DELVOLVERA EL ID DEL REGISTRO QUE ACABO DE INSERTAR EN ESTE CASO 6, SI INSERTOS 2 O MAS, ME DEVOLVERA EL ULTIMO ID QUE INSERTED

--INSERT INTO Measures VALUES ('T','TEST2');
--SELECT @@IDENTITY HACE LOS MISMO QUE EL DE ARRIBA. PERO EL SCOPE_IDENTITY ES EL MAS RECOMENDABLE
----------------------------------------------------------------------------------------------------------------------------------------------------
--OPERADORES ARIMETICOS
--SELECT 9+9+3 AS SUMA
--SELECT 9*3 AS MULTIPLICACION

--SELECT CAST(9 AS DECIMAL(9,4)) / CAST(2 AS DECIMAL(9,4))  AS 'DIVISION' --SI TRATAMOS DE HACER LA DIVISION NUEVE ENTRE DOS NOS DARIA EL RESULTADO EN INT POR ESO LO CONVIERTO EN DECIMAL

--DECLARE @NUMBER INT = 0
--SELECT 10/IIF(@NUMBER = 0, 1,@NUMBER) AS 'DIVISION' --COMO NOS MARCARIA UN ERROR SI DIVIDIMOS ENTRE 0, ENTOCES DECLARO UNA VARIBALE = 0 Y SI LA VARIABLE ES = O, ENTONCES QUE LO CAMBIE POR 1

--SELECT 
--	[POD].PurchaseOrderDetailID
--	,[POD].[ProductID]
--	,[POD].[OrderQty]
--	,[POD].[UnitPrice]
--	,[POD].[OrderQty] * [POD].[UnitPrice] AS 'Total'
--	,CASE
--		WHEN [POD].[OrderQty] * [POD].[UnitPrice] >= 25000 THEN
--		'25%'
--		WHEN [POD].[OrderQty] * [POD].[UnitPrice] >= 20000 THEN
--		'20%'
--		WHEN [POD].[OrderQty] * [POD].[UnitPrice] >= 15000 THEN
--		'15%'
--		WHEN [POD].[OrderQty] * [POD].[UnitPrice] >= 10000 THEN
--		'10%'
--		WHEN [POD].[OrderQty] * [POD].[UnitPrice] >= 5000 THEN
--		'5%'
--		ELSE 
--			'0%'
--	END									AS 'DESCUENTO'
	
--	,CAST(ROUND(CASE
--		WHEN [POD].[OrderQty] * [POD].[UnitPrice] >= 25000 THEN
--		([POD].[OrderQty] * [POD].[UnitPrice]) - ([POD].[OrderQty] * [POD].[UnitPrice]) *0.25
--		WHEN [POD].[OrderQty] * [POD].[UnitPrice] >= 20000 THEN
--		([POD].[OrderQty] * [POD].[UnitPrice]) - ([POD].[OrderQty] * [POD].[UnitPrice]) *0.20
--		WHEN [POD].[OrderQty] * [POD].[UnitPrice] >= 15000 THEN
--		([POD].[OrderQty] * [POD].[UnitPrice]) - ([POD].[OrderQty] * [POD].[UnitPrice]) *0.15
--		WHEN [POD].[OrderQty] * [POD].[UnitPrice] >= 10000 THEN
--		([POD].[OrderQty] * [POD].[UnitPrice]) - ([POD].[OrderQty] * [POD].[UnitPrice]) *0.10
--		WHEN [POD].[OrderQty] * [POD].[UnitPrice] >= 5000 THEN
--		[POD].[OrderQty] * [POD].[UnitPrice] - ([POD].[OrderQty] * [POD].[UnitPrice]) *0.05
--		ELSE 
--			0
--		END,2) AS DECIMAL (9,2))		 AS 'TOTALCONDESCUENTO'

--FROM [Purchasing].[PurchaseOrderDetail] AS [POD];
--EN ESTE CONSULTA CON LA INSTRUCCION CASE PRIMERO LE DIGO QUE ME DIGA CUAL ES PORCENTAJE DE DESCUENTO DEPENDIENDO DEL PRECIO
--LUEGO EN EL OTRO CASE, DEPENDIENDO DEL PRECIO ME VA MULTIPLICAR EL TOTAL Y LUEGO ME LO VA RESTAR CON EL TOTAL NUEVAMENTE PERO ESTA VES EL SEGUNDO TOTAL LO MULTIPLICARA POR EL PORCENTAJE
--USO EL CAST PARA CONVERTIRLO DECIMAL Y ASI QUITAR NUMEROS DECIMALES, PORQUE HABIAN MUCHO SINO SE LO PONIA Y LUEGO EL ROUND PARA QUE ME REDONDE YA QUE EL TERCER DECIMAL EN ALGUNAS OCASIONES ERA MAYOR A 5
----------------------------------------------------------------------------------------------------------------------------------------------------------------
--FUNCION SUM
--SELECT 
--	[POD].[PurchaseOrderID]
--	,SUM([POD].[OrderQty] * UnitPrice)

--FROM Purchasing.PurchaseOrderDetail AS [POD]
--GROUP BY [POD].[PurchaseOrderID]
-------------------------------------------------
--FUNCION COUNT
--SELECT 
--	COUNT(*) AS 'TOTALROWS'
--FROM 
--	[Sales].[SalesPerson];

--SELECT 
--COUNT(DISTINCT CommissionPct)
--FROM 
--	[Sales].[SalesPerson];
--NOTA: SI EL COUNT LO HAGO POR UNA COLUMNA COLUMNA QUE TIENE DATOS NULOS, PUES NO LO VA CONTAR
---------------------------------------------------
--MIN Y --MAX
--SELECT
--	MIN(UnitPrice)
--FROM 
--	Purchasing.PurchaseOrderDetail AS [POD];
-------------------------------------------
--SELECT
--	[POD].[PurchaseOrderID]
--	,COUNT(*)		AS 'TOTAL DE LINEAS'
--	,MAX(UnitPrice) AS 'PRECIO MAXIMO'
--	,MIN(UnitPrice) AS 'PRECIO MINIMO'
--FROM 
--	Purchasing.PurchaseOrderDetail AS [POD]
--GROUP BY 
--	[POD].[PurchaseOrderID];
-----------------------------------------------------
----FUNCION AVG
--SELECT
--	[POD].[PurchaseOrderID]
--	,AVG([POD].[UnitPrice] * 1.0 ) AS 'PROMEDIO'
--FROM 
--	Purchasing.PurchaseOrderDetail AS [POD]
--WHERE 
--	[POD].[PurchaseOrderID] = 515
--GROUP BY 
--	[POD].[PurchaseOrderID];
--NOTA SI EN CASO DE DARMELO EL PROMEDIO COMO ENTERO Y RESULTADO VERDADERO TIENE DECIMALES, ENTOCES PODEMOS HACER ESTO: AVG([POD].[UnitPrice] * 1.0 ) AS 'PROMEDIO'
--------------------------------------------------------
--MODULUS
--SELECT 38/5 AS 'RESULTADO', 38 % 5 AS 'REMAINDER' --AQUI EL PRIMER RESULTADO ME VA DE DECIR QUE ES 7, Y PARA EL SEGUNDO ME TRAER EL RESULTANTE DE 38/5, Y LA RESULTANTE EN ESTE CASO ES 3
--------
--SELECT 
--	ProductID
--	,SUM(OrderQty)			AS 'QTY'
--	,SUM(OrderQty) / 4		AS 'BOX A RECIBIR'
--	,SUM(OrderQty) % 4		AS 'PIEZAS SOBRANTES'

--FROM 
--	[Purchasing].[PurchaseOrderDetail]
--GROUP BY
--	ProductID
--ORDER BY 
--	ProductID;
-- AQUI SE PODRIA DECIR (1	154	38	2) QUE DEL PRODUCTO 1 TENGO 154 PIEZAS, PERO SOLO PUEDO SURTIR 38 CAJAS DE 4 (PORQUE ES LO QUE ACEPTA EL CARRITO) Y PIEZAS SOBRANTES SON DOS
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--CLAUSULA WHERE
--SELECT
--*
--FROM [Sales].[Store]
--WHERE YEAR(ModifiedDate) = 2014;
---------------
--UPDATE SIEMPRE CON WHERE
--SELECT
--	PRODUCTID
--	,[NAME]
--	,[PRODUCTNUMBER]
--	,LISTPRICE + (ListPrice * 0.10) AS 'NEW PRICE'
--	,LISTPRICE AS 'OLD PRICE'
--	FROM [Production].[Product]
--	WHERE [PRODUCTNUMBER] LIKE 'BK-%';

--UPDATE [Production].[Product]
--SET LISTPRICE = LISTPRICE + (ListPrice * 0.10)
--WHERE [PRODUCTNUMBER] LIKE 'BK-%';
--------------------------------------------------
--DELETE SIEMPRE CON WHERE
--SELECT *FROM [dbo].[Courses]
--WHERE CourseName = 'SQL SERVER';

--DELETE FROM [dbo].[Courses]
--WHERE CourseName = 'SQL SERVER';


--INVESTIGAR ATAJOS EN SQL SERVER(PONER UNA LETRA Y A AL DARLE AL TAB, APARECE UNA PALABRA RESERVADA, O EL NOMBRE DE UNA TABLA, COLUMNA, ETC..)


