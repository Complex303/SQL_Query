  --PIVOT y UNPIVOT para convertir registros a columnas o viceversa
--PIVOT
--SELECT *FROM
--(
--	SELECT 
--	YEAR(OrderDATE) AS [YEAR]
--	,TotalDue		AS [TOTALSALES]
--FROM
--	[Sales].[SalesOrderHeader] AS [soh]
--) AS [SALES]
--PIVOT(SUM(TOTALSALES)
--FOR [YEAR] IN ([2011],[2012],[2013],[2014]))
--AS PVT
--ESTE PIVOT ME TRAERIA LA SUMA TOTAL DE CADA AÑO, COMO SE PUEDE APRECIAR NO NECESITE UN SUM(TOTALDUE) EN LA COLUMNA, SINO QUE SE HACE CON EL PIVOT, Y ASI TAMBIEN NO LE APLIQUE EL WHERE YA QUE SE HACE CON EL PIVOT DESPUES DEL FOR
----para cumplir con la sintaxis requerida para la cláusula PIVOT, es necesario especificar una función de agregado. Utilizar MAX en este caso no afectará el resultado final.
----------------------
----UNPIVOT
--SELECT
--	[YEAR]
--	,[TOTALSALES]
--FROM
--(
--	SELECT
--	*
--	FROM
--	(
--		SELECT 
--			YEAR(OrderDATE) AS [YEAR]
--			,TotalDue		AS [TOTALSALES]
--		FROM
--			[Sales].[SalesOrderHeader] AS [soh]
--		) AS [SALES]
--		PIVOT(SUM(TOTALSALES)
--		FOR [YEAR] IN ([2011],[2012],[2013],[2014]))
--		AS PVT
--	) AS [T] UNPIVOT([TOTALSALES] FOR [YEAR]
--	IN ([2011],[2012],[2013],[2014])) AS [UPVT]
--la instrucción realiza una operación de pivote para agrupar los valores de TotalDue por año en la tabla [Sales].[SalesOrderHeader]. 
--Luego, se realiza una operación de des-pivote para convertir las columnas del pivote en filas. El resultado mostrará dos columnas: [YEAR] que representa el año y [TOTALSALES] que representa los valores correspondientes a cada año.
--ESTE SELECT DE ABAJO HACE LO MISMO QUE EL DE ARRIBA
--SELECT 
--    YEAR(OrderDate) AS [YEAR],
--    SUM(TotalDue) AS [Total]
--FROM 
--    [Sales].[SalesOrderHeader] AS [soh]
--WHERE 
--    YEAR(OrderDate) IN (2011, 2012, 2013, 2014)
--GROUP BY
--    YEAR(OrderDate) 
--ORDER BY YEAR ASC

----------
--DECLARE @columns AS VARCHAR(MAX)
--DECLARE @startDate AS VARCHAR(MAX) = '20110601' --TUVE QUE PONER LA FECHA DE ESTA FORMA PARA QUE FUNCIONARA, Y NO APARECIERA EL ERROR
--DECLARE @endDate AS VARCHAR(MAX) = '20110630' 


--SELECT @columns = STUFF(
-- (
-- SELECT
--   ',' + QUOTENAME(LTRIM(DAY([OrderDate])))
-- FROM
--   (
--   SELECT DISTINCT [OrderDate]
--    FROM [Sales].[SalesOrderHeader] AS [soh]
--	WHERE [soh].[OrderDate] >= @startDate AND [soh].[OrderDate] <= @endDate
--   ) AS [T]
-- ORDER BY
--	[OrderDate]
-- FOR XML PATH('')
-- ), 1, 1, ''); 

-- SELECT @columns


-- DECLARE @sql nvarchar(MAX)

--SET @sql = N'
--	SELECT * FROM 
--	(
--	SELECT 
--			DAY([soh].[OrderDate]) AS [SalesDaily]
--			,[soh].[TotalDue] AS [TotalSales]
--	 FROM [sales].[SalesOrderHeader] AS [soh]
--	WHERE [soh].[OrderDate] >= '+ CHAR(39) + @startDate + CHAR(39) +' AND [soh].[OrderDate]<= '  + CHAR(39) + @endDate + CHAR(39) + '
--	) AS [Sales]
--		PIVOT (SUM([TotalSales])
--		FOR [SalesDaily] IN (' + @columns + N')
--	)
--	AS [pvt]
--';
-- EXEC sp_executesql @sql;
--Esta instrucción en SQL Server utiliza variables y la función STUFF junto con PIVOT para generar una consulta dinámica que realiza un pivote en función de los días de un rango de fechas.
--PARA MAS INFORMACION LA EXPLICACION ESTA EN EL CHAT GPT, SECCION GROUP BY SIN FUNCIONES


 --ESTO ES LO MISMO QUE LA INSTRUCCION DE ARRIBA, PERO DE FORMA NO DINAMICA Y ADEMAS EL RESULTADO APARECE EN FORMA DE FILA
--DECLARE @columnsS AS VARCHAR(MAX)
--DECLARE @startDateE AS VARCHAR(MAX) = '20110601' --TUVE QUE PONER LA FECHA DE ESTA FORMA PARA QUE FUNCIONARA, Y NO APARECIERA EL ERROR
--DECLARE @endDateE AS VARCHAR(MAX) = '20110630' 



--   SELECT DISTINCT DAY([OrderDate]), SUM(TotalDue)
--    FROM [Sales].[SalesOrderHeader] AS [soh]
--	WHERE [soh].[OrderDate] >= @startDateE AND [soh].[OrderDate] <= @endDateE
--	Group by DAY([OrderDate])
--	ORDER BY DAY([OrderDate]) 


--ESTO SERIA SI DEBO DE PONER LOS DIAS MANUALMENTE
--SELECT * FROM
--	(
--		SELECT 
--			DISTINCT Day(OrderDate) AS DIAS
--			,SUM(TotalDue)				AS VENTA_DIAS
--		FROM 
--			[Sales].[SalesOrderHeader] AS [soh]
--		WHERE 
--			OrderDate BETWEEN '20110601' AND '20110630'
--		GROUP BY Day(OrderDate)
--	) AS SALES
--PIVOT(SUM(VENTA_DIAS)
--FOR [DIAS] IN ([1],[2],[3])) AS PVT
-----------------------------------------------------------------------------------
-- PARTITION BY, es similar al GROUP BY
--En resumen, la cláusula GROUP BY agrupa filas y realiza operaciones de agregación a nivel de grupo, mientras que la cláusula PARTITION BY divide los datos en particiones lógicas y aplica funciones de ventana a nivel de partición para realizar cálculos basados en subconjuntos de filas.

--AQUI ESTA DE MANERA RESUMIDA
--SELECT
--	--([v].[name])
--	[poh].[ShipMethodID]
--	,MIN(poh.TotalDue)		AS MinTotal
--	,MAX(poh.TotalDue)		AS MaxTotal
--	,COUNT(poh.TotalDue)	AS CountTotal
--	,AVG(poh.TotalDue)		AS AVGTotal
--FROM [Purchasing].[PurchaseOrderHeader] AS [poh]
--	INNER JOIN [Purchasing].[Vendor] AS [v]
--		ON [v].[BusinessEntityID] = [poh].[VendorID]
--GROUP BY
--	[poh].[ShipMethodID]
--	--,[v].[name]

----AQUI DE MANERA DETALLADA
--SELECT
--	[poh].[VendorID]
--	,[v].[name]
--	,[poh].[ShipMethodID]
--	,MIN(poh.TotalDue)		OVER(PARTITION BY [ShipMethodID])	AS MinTotal
--	,MAX(poh.TotalDue)		OVER(PARTITION BY [ShipMethodID])	AS MaxTotal
--	,COUNT(poh.TotalDue)	OVER(PARTITION BY [ShipMethodID])	AS CountTotal
--	,AVG(poh.TotalDue)		OVER(PARTITION BY [ShipMethodID])	AS AVGTotal
--FROM [Purchasing].[PurchaseOrderHeader] AS [poh]
--	INNER JOIN [Purchasing].[Vendor] AS [v]
--		ON [v].[BusinessEntityID] = [poh].[VendorID]

--la principal diferencia es que el primer SELECT realiza cálculos de agregación utilizando la cláusula GROUP BY para obtener los valores mínimos, máximos, de conteo y promedio de [TotalDue] para cada combinación de [poh].[ShipMethodID] y [v].[name]. 
--El segundo SELECT utiliza funciones de ventana para calcular los mismos valores, pero dentro de cada partición definida por [ShipMethodID], lo que permite mostrar los resultados de las funciones de ventana para cada fila individual.
----------------------------------------------------
---- Example products

--SELECT 
--	[ProductID]
--	,[LocationID]
--	,[Bin]
--	,SUM([Quantity])		AS [SUMA]
--FROM 
--	[Production].[ProductInventory]
--GROUP BY
--	[LocationID]
--	,[Bin]
--	,[ProductID]
--ORDER BY
--	[LocationID]
--	,[ProductID]

--SELECT 
--	[ProductID]					
--	,[LocationID]
--	,[Bin]
--	,[Quantity]
--	,SUM([Quantity]) OVER(PARTITION BY 	[LocationID], [BIN])	AS [SUMA]
--FROM 
--	[Production].[ProductInventory]

--la diferencia principal es que el primer SELECT realiza una agregación mediante GROUP BY para calcular la suma total de [Quantity] por cada combinación de [LocationID], [Bin] y [ProductID]. 
--El segundo SELECT utiliza una función de ventana para calcular la suma de [Quantity] por cada combinación de [LocationID] y [Bin], y muestra el valor de [Quantity] para cada registro individual, junto con la suma en la columna [SUMA].
--FUNCION DE VENTANA
-------------------------------------------------------------------------------------------------------------------------
--ROW_NUMBER, RANK, DENSE_RANK Y NTILE 
--SELECT
--	[SOH].[SalesOrderID]
--	,[SOH].[CustomerID]
--	,[SOH].[TaxAmt]
--	,ROW_NUMBER() OVER(ORDER BY TaxAmt ASC)		AS [ROWNUMBER] --ROWNUMBER: Es una función que asigna un número único a cada fila en un conjunto de resultados, en función del orden especificado en la cláusula ORDER BY. No se repiten los números y no hay saltos en la secuencia.
--	,RANK() OVER(ORDER BY TaxAmt ASC)			AS [RANK] -- RANK: Es una función que asigna un rango a cada fila en un conjunto de resultados, en función del orden especificado en la cláusula ORDER BY. Si varias filas tienen el mismo valor, se les asigna el mismo rango y el siguiente número se omite. Por ejemplo, si dos filas tienen un rango 2, la siguiente fila recibirá el rango 4.
--	,DENSE_RANK() OVER (ORDER BY TaxAmt ASC)	AS [DENSERANK] -- DENSE_RANK: Es similar a la función RANK, pero no omite números en caso de empates. Si varias filas tienen el mismo valor, se les asigna el mismo rango y el siguiente número no se omite
--	,NTILE(2) OVER(ORDER BY TaxAmt ASC)			AS [NTILE] -- NTILE: Es una función que divide el conjunto de resultados en grupos o baldes específicos en función del número especificado en la función. Por ejemplo, NTILE(2) dividirá el conjunto de resultados en dos grupos más o menos iguales.
--FROM
--	[Sales].[SalesOrderHeader] [SOH]
--WHERE
--	[SOH].[CustomerID] = 29869;
--para utilizar estas funciones es necesario especificar una cláusula ORDER BY. La cláusula ORDER BY determina el orden en el que se asignarán los números de fila.
-------------------------
 -- SELECT
	--	[BusinessEntityID]
	--	,[LoginID]
	--	,[Gender]
	--	,[VacationHours]
	--	,NTILE(2)	OVER(ORDER BY [VacationHours] )	AS [ntile]
 -- FROM 
	--[HumanResources].[Employee]
-------------------------------------------------------------------------------------
--WITH CTE_VACATIONS
--AS
--(
--SELECT
--			BusinessEntityID
--			,LoginID
--			,JobTitle
--			,OrganizationLevel
--			,VacationHours
--			,DENSE_RANK() OVER (ORDER BY OrganizationLevel ASC)	AS [GROUP]
--			,DENSE_RANK() OVER (PARTITION BY OrganizationLevel ORDER BY VacationHours DESC) AS [POSITION]
			
--		FROM 
--			[HumanResources].[Employee]
--	WHERE
--		Gender = 'M' AND VacationHours > 0
--)
--SELECT *FROM CTE_VACATIONS
--ESTE CTE En resumen, selecciona ciertas columnas de la tabla Employee en el esquema HumanResources. 
--Filtra los resultados para mostrar solo los empleados de género masculino con más de cero horas de vacaciones acumuladas. Además, 
--utiliza las funciones DENSE_RANK() y PARTITION BY para asignar un número de grupo a cada registro basado en el nivel de organización y determinar la posición de cada empleado dentro de su grupo en función de las horas de vacaciones acumuladas.
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--LAG, LEAD, FIRST VALUE, LAST VALUED 

--SELECT [ProductID]
--      ,[LocationID]
--      ,[Shelf]
--      ,[Bin]
--      ,[Quantity]
--	  ,LAG(Quantity) OVER (PARTITION BY [ProductID] ORDER BY [ProductID])			AS [BeforeQTY] -- La función LAG se utiliza para acceder a una fila anterior en un conjunto de resultados. Puedes utilizarla para obtener el valor de una columna en la fila anterior a la actual.
--	  ,LEAD(Quantity) OVER (PARTITION BY [ProductID] ORDER BY [ProductID])			AS [NextQTY] --La función LEAD es similar a LAG, pero en lugar de acceder a la fila anterior, te permite acceder a la siguiente fila en un conjunto de resultados. Puedes obtener el valor de una columna en la fila siguiente a la actual utilizando esta función.
--	  ,FIRST_VALUE(Quantity) OVER (PARTITION BY [ProductID] ORDER BY [ProductID])	AS [FirstValue] --La función FIRST VALUE se utiliza para obtener el primer valor de una columna en un conjunto de resultados. Es útil cuando deseas obtener el valor inicial de una columna en un conjunto de datos.
--	  ,LAST_VALUE(Quantity) OVER (PARTITION BY [ProductID] ORDER BY [ProductID])	AS [LastValue] -- La función LAST VALUE se utiliza para obtener el último valor de una columna en un conjunto de resultados. Puedes utilizarla para obtener el valor más reciente de una columna en un conjunto de datos.

--  FROM [Production].[ProductInventory] 
-------------------------------
--SELECT 
--	[v].[CreditRating]
--	,MIN([potv].[Total]) AS [MinTotal]
--	,MAX([potv].[Total]) AS [MaxTotal]
--	,AVG([potv].[Total]) AS [AVGTotal]
--FROM
--	[Purchasing].[PuchaseOrderTotalByVendorUpdate] AS [potv]
--	INNER JOIN [Purchasing].[Vendor] AS [v]
--		ON [potv].[VendorID] = [v].[BusinessEntityID]
--GROUP BY
--	[v].[CreditRating]
----------------------------------------------------
--SELECT 
--	[potv].[VendorID]
--	,[v].[CreditRating]
--	,[potv].[Total]
--	,FIRST_VALUE([potv].[Total]) OVER (PARTITION BY [v].[CreditRating] ORDER BY [v].[CreditRating], [potv].[Total] ASC) [MinTotal]
--	,LAST_VALUE([potv].[Total]) OVER (PARTITION BY [v].[CreditRating] ORDER BY [v].[CreditRating] ASC) AS [MaxTotal]
--FROM
--	[Purchasing].[PuchaseOrderTotalByVendorUpdate] AS [potv]
--	INNER JOIN [Purchasing].[Vendor] AS [v]
--		ON [potv].[VendorID] = [v].[BusinessEntityID]
--ORDER BY
--	[v].[CreditRating]
--En resumen, el query proporciona un resumen de las compras de proveedores, incluyendo su ID, calificación crediticia, el total de las órdenes de compra y los valores mínimo y máximo de esas órdenes para cada calificación crediticia. 
--Esto puede ayudar a analizar y comparar el desempeño de los proveedores en función de su calificación crediticia y el volumen de compras realizado
-----------------------------------------------------------------------------------------------------
--XMLS PARA COMPARTIR INFO CON OTROS SISTEMAS


--SELECT
--	[poh].VendorID																			AS [VENDORID]
--	,[V].[Name]																				AS [VENDOR]
--	,FORMAT([poh].[PurchaseOrderID], '000000')												AS [PONUMBER]
--	,[sm].[Name]																			AS [SHIPPINGMETHOD]
--	,[poh].TotalDue																			AS [TOTAL]
--	,ROW_NUMBER() OVER(PARTITION BY [poh].PurchaseOrderID ORDER BY [poh].PurchaseOrderID)	AS [ITEM]
--	,[p].[Name]																				AS [PRODUCT]
--	,[pod].[OrderQty]																		AS [Qty]
--	,[pod].[UnitPrice]																		AS [Price]
--	,[pod].[LineTotal]																		AS [Amount]
--FROM 
--	[Purchasing].[PurchaseOrderHeader] AS [poh]
--INNER JOIN
--	[Purchasing].[Vendor] AS [v]
--ON	[poh].[VendorID] = [v].[BusinessEntityID]
--INNER JOIN
--	[Purchasing].[ShipMethod] AS [sm]
--ON	[poh].ShipMethodID = [sm].ShipMethodID
--INNER JOIN
--	[Purchasing].[PurchaseOrderDetail] AS [pod]
--ON	[poh].PurchaseOrderID = [pod].PurchaseOrderID
--INNER JOIN [Production].[Product] AS [p]
--ON	[pod].ProductID = [p].ProductID
--WHERE
--	[sm].ShipMethodID = 3
--FOR XML RAW -- SI YO EJECUTO TODO EL SELECT DESDE AQUI ME CREA UN XML, AL HACER CLICK ME APERECE EN UNA NUEVA QUERY LA INFORMACION EN FORMATO EN XML
--SON IMPORTANTE LOS ALIAS, PORQUE SE CONVERTIRA COMO TAL, EN EL ARCHIVO XML
--FOR XML AUTO, ELEMENTS, ROOT ('PurchaseOrders'); --ESTE SERIA OTRO FORMATO, MEJOR ESTRUCTURADO, LO QUE ESTA ENTRE PARENTESIS ES INDIFERENTE, SOLO SE PUSO POR CABEZERA, SINO LO PONGO, DE CABEZERA APARECERA LA PALABRA <root> DE CABEZERA.

--SELECT
--	[poh].VendorID																			AS [VENDORID]
--	,[V].[Name]																				AS [VENDOR]
--	,FORMAT([poh].[PurchaseOrderID], '000000')												AS [PONUMBER]
--	,[sm].[Name]																			AS [SHIPPINGMETHOD]
--	,[poh].TotalDue																			AS [TOTAL]
--	,ROW_NUMBER() OVER(PARTITION BY [poh].PurchaseOrderID ORDER BY [poh].PurchaseOrderID)	AS [ITEM]
--	,[p].[Name]																				AS [PRODUCT]
--	,[pod].[OrderQty]																		AS [Qty]
--	,[pod].[UnitPrice]																		AS [Price]
--	,[pod].[LineTotal]																		AS [Amount]
--FROM 
--	[Purchasing].[PurchaseOrderHeader] AS [poh]
--INNER JOIN
--	[Purchasing].[Vendor] AS [v]
--ON	[poh].[VendorID] = [v].[BusinessEntityID]
--INNER JOIN
--	[Purchasing].[ShipMethod] AS [sm]
--ON	[poh].ShipMethodID = [sm].ShipMethodID
--INNER JOIN
--	[Purchasing].[PurchaseOrderDetail] AS [pod]
--ON	[poh].PurchaseOrderID = [pod].PurchaseOrderID
--INNER JOIN [Production].[Product] AS [p]
--ON	[pod].ProductID = [p].ProductID
--WHERE
--	[poh].PurchaseOrderID = 7
--FOR XML PATH ('PurchaseOrder'), TYPE; --ESTE FORMATO DE XML ES EL MAS UTILIZADO EN LA UNDUSTRIA, O EL MAS NORMAL DE VER
--EL ES MISMO SELECT DE ARRIBA SOLO CAMBIAND EL WHERE
--AUNQUE CUANDO SE CREA EL XML, HAY ALGUNA COSAS QUE SE REPITEN, EN ESTE CASO, QUE ES EL VENDORID, EL NAME, EL TOTAL, ETC. PARA ARREGLAR ESTO HAGO LO SIGUIENTE: 


--SELECT
--	[poh].VendorID																			AS [VENDORID]
--	,[V].[Name]																				AS [VENDOR]
--	,FORMAT([poh].[PurchaseOrderID], '000000')												AS [PONUMBER]
--	,[sm].[Name]																			AS [SHIPPINGMETHOD]
--	,[poh].TotalDue																			AS [TOTAL]
--	,(
--		SELECT 
--			ROW_NUMBER() OVER(PARTITION BY [poh].PurchaseOrderID ORDER BY [poh].PurchaseOrderID)	AS [ITEM]
--			,[p].[Name]																				AS [PRODUCT]
--			,[pod].[OrderQty]																		AS [Qty]
--			,[pod].[UnitPrice]																		AS [Price]
--			,[pod].[LineTotal]																		AS [Amount]
--		FROM
--			[Purchasing].[PurchaseOrderDetail] AS [pod]
--			INNER JOIN [Production].[Product] AS [p]
--			ON	[pod].ProductID = [p].ProductID
--		WHERE
--			[poh].PurchaseOrderID = [pod].PurchaseOrderID
--		FOR XML PATH ('Details'), TYPE
--	)

--FROM 
--	[Purchasing].[PurchaseOrderHeader] AS [poh]
--INNER JOIN
--	[Purchasing].[Vendor] AS [v]
--ON	[poh].[VendorID] = [v].[BusinessEntityID]
--INNER JOIN
--	[Purchasing].[ShipMethod] AS [sm]
--ON	[poh].ShipMethodID = [sm].ShipMethodID
----WHERE
----	[poh].PurchaseOrderID = 7
--FOR XML PATH ('PurchaseOrder'), TYPE; --DE ESTA FORMA, YA NO HABRIA DATOS REPETIDO, Y ESTARIA MAS ORGANIZADO
----SI YO EN LOS ALIAS PONGO @, POR EJEMPLO @ITEM, @PRODUCT, PUES APARECERA EN LA CABEZERA, Y PARECIERA QUE ESTA COMPRIMIDO, OSEA EN LA PARTE DE LOS ALIAS DE LA CONSULTA, SI PONGO @ A 3 DE ESOS ALIAS, PUES ME APARECERA TODO EN UNA LINEA, EN LA MISMA LINEA DE LA CABEZERA ITEM.
----EJEMPLO: <Item ITEM="1" PRODUCT="LL Crankarm" Qty="550">. SE SUELEN PEDIR ALGUNAS VECES DE ESTA FORMA.

--SELECT
--	[poh].VendorID																			AS [VENDORID]
--	,[V].[Name]																				AS [VENDOR]
--	,FORMAT([poh].[PurchaseOrderID], '000000')												AS [PONUMBER]
--	,[sm].[Name]																			AS [SHIPPINGMETHOD]
--	,[poh].TotalDue																			AS [TOTAL]
--	,(
--		SELECT 
--			ROW_NUMBER() OVER(PARTITION BY [poh].PurchaseOrderID ORDER BY [poh].PurchaseOrderID)	AS [Item/ITEM]
--			,[p].[Name]																				AS [Item/PRODUCT]
--			,[pod].[OrderQty]																		AS [Item/Qty]
--			,[pod].[UnitPrice]																		AS [Item/Price]
--			,[pod].[LineTotal]																		AS [Item/Amount]
--		FROM
--			[Purchasing].[PurchaseOrderDetail] AS [pod]
--			INNER JOIN [Production].[Product] AS [p]
--			ON	[pod].ProductID = [p].ProductID
--		WHERE
--			[poh].PurchaseOrderID = [pod].PurchaseOrderID
--		FOR XML PATH ('Detalils'), TYPE
--	)

--FROM 
--	[Purchasing].[PurchaseOrderHeader] AS [poh]
--INNER JOIN
--	[Purchasing].[Vendor] AS [v]
--ON	[poh].[VendorID] = [v].[BusinessEntityID]
--INNER JOIN
--	[Purchasing].[ShipMethod] AS [sm]
--ON	[poh].ShipMethodID = [sm].ShipMethodID
--WHERE
--	[poh].PurchaseOrderID = 7
--FOR XML PATH ('PurchaseOrder'), TYPE; --ESTE FORMATO ES EL MAS UTILIZADO, O QUE SE USAN MAS
--SI QUIERO PONER OTRA CABEZERA, FOR XML PATH ('PurchaseOrder'), ROOT ('ALLPurchaseOrder')
--ES BIEN IMPORTANTE QUE CUANDO SE REPITE INFORMACION, HACER UN SELECT SOBRE UN SELECT COMO EL QUE ESTA ARRIBA.



--SELECT * FROM [Purchasing].[PurchaseOrderHeader]
--SELECT * FROM [Purchasing].[Vendor] AS [v]
--SELECT * FROM [Purchasing].[ShipMethod]
--SELECT * FROM [Purchasing].[PurchaseOrderDetail] AS [pod]
--SELECT * FROM [Production].[Product] AS [p]
--------------------------------------------------------------------------------------
--Scalar-valued function: una función escalar con valor es una función definida por el usuario que devuelve un solo valor.
--PARA ESTO NECESITO CREAR UNA FUNCION; LA FUNCION FUE DEL QUERY ANTEPASADO...
--SELECT [dbo].[ufnGetPurchaseOrderXML](7); -- Y CON ESTO OBTENEMEOS LA FUNCION XML, EN ESTE CASO EL PARATRO QUE LE PEDI FUE EL 7

--DECLARE @MYXML AS XML
--SET @MYXML = [dbo].[ufnGetPurchaseOrderXML](8)
--SELECT @MYXML AS [PurchaseOrder] --ESTE SERIA OTRO FORMA DE HACER EL SELECT DE ARRIBA
------------------------------------------------------------------------------------------------------
--OPEN XML -- ESTO ES PARA LEER XML QUE SE DIFICULTAN LEERLO

--DECLARE @XML NVARCHAR(MAX)
--DECLARE @ID INT
--SET @XML = N' 
--<Youtube>
--  <Channel>Mundo Binario</Channel>
--  <Creator>Axel Romero</Creator>
--  <Course>SQL Server desde cero</Course>
--</Youtube>'
----LO QUE ESTA EN ROJO ES DE TIPO XML, Y LO QUE ESTOY HACIENDO AQUI ES CONVIRTIENDOLO EN UN NVARCHAR(MAX). LE PONGO N PARA QUE DETECTE TODO LOS CARECTERES, 
----SELECT @XML
--EXEC sp_xml_preparedocument @ID OUTPUT, @XML
--SELECT * FROM OPENXML (@ID, '/Youtube', 2) WITH
--(
--	Channel VARCHAR(100)
--	,Creator VARCHAR(100)
--	,Course	VARCHAR(100)
--)
--EXEC sp_xml_removedocument @id
----En resumen, este código SQL se utiliza para extraer datos específicos de un fragmento de XML y mostrarlos en forma de columnas en un resultado de consulta. Es especialmente útil cuando se necesita procesar datos XML en una base de datos SQL Server.

--DECLARE @INPUT XML = N'
--<Youtube>
--  <Channel>Mundo Binario</Channel>
--  <Creator>Axel Romero</Creator>
--  <Course>SQL Server desde cero</Course>
--  <Sub>5000</Sub>
--</Youtube>'

--;WITH XMLNAMESPACES('Youtube' as xsi)
--SELECT
--FieldName  = T.C.value('local-name(.)', 'varchar(50)'),
--FieldValue  = T.C.value('(.)[1]', 'varchar(50)')
--FROM
--@INPUT.nodes('/Youtube/*') AS T(C)
--este código SQL descompone un fragmento de XML en una tabla que contiene dos columnas: FieldName (nombre del campo o elemento) y FieldValue (valor del campo o elemento). Esto facilita la extracción y presentación de los datos del XML en una estructura tabular.

--DECLARE @MYXML AS XML = [dbo].[ufnGetPurchaseOrderXML](7)
--SELECT @MYXML.query ('PurchaseOrder/SHIPPINGMETHOD') --para obtener un tag en especifico


--DECLARE @MYXML AS NVARCHAR(MAX)
--		,@IDXML AS INTEGER
--SET @MYXML = '<PurchaseOrder>
--  <VENDORID>1678</VENDORID>
--  <VENDOR>Proseware, Inc.</VENDOR>
--  <PONUMBER>000007</PONUMBER>
--  <SHIPPINGMETHOD>OVERSEAS - DELUXE</SHIPPINGMETHOD>
--  <TOTAL>64847.5328</TOTAL>
--  <Details>
--    <ITEM>1</ITEM>
--    <PRODUCT>LL Crankarm</PRODUCT>
--    <Qty>550</Qty>
--    <Price>27.0585</Price>
--    <Amount>14882.1750</Amount>
--  </Details>
--  <Details>
--    <ITEM>2</ITEM>
--    <PRODUCT>ML Crankarm</PRODUCT>
--    <Qty>550</Qty>
--    <Price>33.5790</Price>
--    <Amount>18468.4500</Amount>
--  </Details>
--  <Details>
--    <ITEM>3</ITEM>
--    <PRODUCT>HL Crankarm</PRODUCT>
--    <Qty>550</Qty>
--    <Price>46.0635</Price>
--    <Amount>25334.9250</Amount>
--  </Details>
--</PurchaseOrder>'

--CREATE TABLE #PurchaseOrder
--(
--	PONUMBER VARCHAR(6),
--	ShippingMethod	VARCHAR(100),
--	TOTAL DECIMAL(18,4)
	
--)

--EXEC sp_xml_preparedocument @IDXML OUTPUT, @MYXML
--INSERT INTO #PurchaseOrder
--(
--	PONUMBER
--	,ShippingMethod
--	,TOTAL
--)
--SELECT 
--	[XML].PONUMBER
--	,[XML].SHIPPINGMETHOD
--	,[XML].TOTAL
--FROM OPENXML(@IDXML, 'PurchaseOrder', 2) WITH
--(
--	PONUMBER VARCHAR(6)
--	,SHIPPINGMETHOD VARCHAR(100)
--	,TOTAL DECIMAL(18,4)

--) AS [XML]

--EXEC sp_xml_removedocument @IDXML

--SELECT * FROM #PurchaseOrder
--DROP TABLE #PurchaseOrder
---------------------------------------------------------------------------------
--JSON --es un formato de datos textuales popular que se utiliza para intercambiar datos en aplicaciones web y móviles modernas.

--SELECT 
--	[V].AccountNumber
--	,[V].[Name]
--	,[OrdenDeCompra].PurchaseOrderID
--	,[OrdenDeCompra].ShipMethodID
--FROM 
--	[Purchasing].[Vendor] AS [V]
--INNER JOIN 
--	[Purchasing].[PurchaseOrderHeader] AS [OrdenDeCompra]
--ON	[V].BusinessEntityID = [OrdenDeCompra].VendorID
--WHERE
--	[V].ActiveFlag = 0 AND CAST([OrdenDeCompra].[OrderDate] AS DATE) <= '2012-12-31'
--FOR JSON AUTO; --Este es un tipo de formato JSON, EN ESTE LOS QUE TIENE EL ALIAS ORDEN DE COMPRA APARECERA ENTRE LLAVES, OSEA AGRUPANDOLO POR ORDERN DE COMPRA, EJEMPLO:
--[
--  {
--    "AccountNumber": "ADVANCED0001",
--    "Name": "Advanced Bicycles",
--    "OrdenDeCompra": [{ "PurchaseOrderID": 2, "ShipMethodID": 5 }]
--  },
--FOR JSON PATH; --ESTE ES OTRA FORMATO, Y AQUI NO ME ESTA HACIENDO ESE AGRUPADO, POR EJEMPLO:
--[
--  {
--    "AccountNumber": "ADVANCED0001",
--    "Name": "Advanced Bicycles",
--    "PurchaseOrderID": 2,
--    "ShipMethodID": 5
--  },


--AL QUERY QUE CONVERTIMOS EN XML, AHORA LO VAMOS A CONVERTIR EN JSON, OSEA ESTE:

--SELECT
--	[poh].VendorID																			AS [VENDORID]
--	,[V].[Name]																				AS [VENDOR]
--	,FORMAT([poh].[PurchaseOrderID], '000000')												AS [PONUMBER]
--	,[sm].[Name]																			AS [SHIPPINGMETHOD]
--	,[poh].TotalDue																			AS [TOTAL]
--	,(
--		SELECT 
--			ROW_NUMBER() OVER(PARTITION BY [poh].PurchaseOrderID ORDER BY [poh].PurchaseOrderID)	AS [ITEM]
--			,[p].[Name]																				AS [PRODUCT]
--			,[pod].[OrderQty]																		AS [Qty]
--			,[pod].[UnitPrice]																		AS [Price]
--			,[pod].[LineTotal]																		AS [Amount]
--		FROM
--			[Purchasing].[PurchaseOrderDetail] AS [pod]
--			INNER JOIN [Production].[Product] AS [p]
--			ON	[pod].ProductID = [p].ProductID
--		WHERE
--			[poh].PurchaseOrderID = [pod].PurchaseOrderID
--		--FOR JSON PATH
--	) AS [DETAILS]

--FROM 
--	[Purchasing].[PurchaseOrderHeader] AS [poh]
--INNER JOIN
--	[Purchasing].[Vendor] AS [v]
--ON	[poh].[VendorID] = [v].[BusinessEntityID]
--INNER JOIN
--	[Purchasing].[ShipMethod] AS [sm]
--ON	[poh].ShipMethodID = [sm].ShipMethodID
--WHERE
--	[poh].PurchaseOrderID = 7
--FOR JSON PATH
--AQUI DESPUES DEL PRIMERO JSON DEBEMOS DE COLOCARLE UN ALIAS, A DIFERENCIA DEL XML, QUE NO HABIA QUE HACERLO
--ESTE SERIA EL RESULTADO: 
--[
--  {
--    "VENDORID": 1678,
--    "VENDOR": "Proseware, Inc.",
--    "PONUMBER": "000007",
--    "SHIPPINGMETHOD": "OVERSEAS - DELUXE",
--    "TOTAL": 64847.5328,
--    "DETAILS": [
--      {
--        "ITEM": 1,
--        "PRODUCT": "LL Crankarm",
--        "Qty": 550,
--        "Price": 27.0585,
--        "Amount": 14882.175
--      },
--      {
--        "ITEM": 2,
--        "PRODUCT": "ML Crankarm",
--        "Qty": 550,
--        "Price": 33.579,
--        "Amount": 18468.45
--      },
--      {
--        "ITEM": 3,
--        "PRODUCT": "HL Crankarm",
--        "Qty": 550,
--        "Price": 46.0635,
--        "Amount": 25334.925
--      }
--    ]
--  }
--]

--SELECT
--	1			AS	[ID]
--	,NULL		AS	[NOMBRE]
--	,'ROMERO'	AS	[APELLIDO]
--FOR JSON PATH, INCLUDE_NULL_VALUES -- CUANDO HAGO ESTO, NO ME TOMA EN CUENTA LOS VALORES NULOS, SOLO MUESTRA EL ID Y EL APELLIDO, ESTO PUEDE GRAVE PORQUE SI LO REQUIEREN EN OTRO SISTEMA, PUES MARCARA ERROR. PARA SOLUCCIONAR ESTO PONGO: FOR JSON PATH, INCLUDE_NULL_VALUES
----CON ESTO ME INCLUIRA LOS VALORES NULOS

--SELECT TOP (10)
--	[P].FirstName,
--	[P].MiddleName,
--	[P].LastName
--FROM 
--	[Person].[Person] AS [P]
--WHERE 
--	[P].MiddleName IS NULL
--FOR JSON PATH, INCLUDE_NULL_VALUES --ESTO ES UN EJEMPLO DEL INCLUDE_NULL_VALUES

--Al Json de este select: Lo voy a poner en una variable
--SELECT 
--	[V].AccountNumber
--	,[V].[Name]
--	,[OrdenDeCompra].PurchaseOrderID
--	,[OrdenDeCompra].ShipMethodID
--FROM 
--	[Purchasing].[Vendor] AS [V]
--INNER JOIN 
--	[Purchasing].[PurchaseOrderHeader] AS [OrdenDeCompra]
--ON	[V].BusinessEntityID = [OrdenDeCompra].VendorID
--WHERE
--	[V].ActiveFlag = 0 AND CAST([OrdenDeCompra].[OrderDate] AS DATE) <= '2012-12-3'

--DECLARE @JSONRESUL AS NVARCHAR(MAX)
--SET @JSONRESUL = '[{"AccountNumber":"ADVANCED0001","Name":"Advanced Bicycles","PurchaseOrderID":2,"ShipMethodID":5},{"AccountNumber":"PROSE0001","Name":"Proseware, Inc.","PurchaseOrderID":7,"ShipMethodID":3},{"AccountNumber":"CIRCUIT0001","Name":"Circuit Cycles","PurchaseOrderID":21,"ShipMethodID":1},{"AccountNumber":"GARDNER0001","Name":"Gardner Touring Cycles","PurchaseOrderID":37,"ShipMethodID":1},{"AccountNumber":"MORGANB0001","Name":"Morgan Bike Accessories","PurchaseOrderID":55,"ShipMethodID":1},{"AccountNumber":"RELIANCE0001","Name":"Reliance Fitness, Inc.","PurchaseOrderID":64,"ShipMethodID":5},{"AccountNumber":"ADVANCED0001","Name":"Advanced Bicycles","PurchaseOrderID":81,"ShipMethodID":5},{"AccountNumber":"PROSE0001","Name":"Proseware, Inc.","PurchaseOrderID":86,"ShipMethodID":3},{"AccountNumber":"CIRCUIT0001","Name":"Circuit Cycles","PurchaseOrderID":100,"ShipMethodID":1},{"AccountNumber":"GARDNER0001","Name":"Gardner Touring Cycles","PurchaseOrderID":116,"ShipMethodID":1},{"AccountNumber":"MORGANB0001","Name":"Morgan Bike Accessories","PurchaseOrderID":134,"ShipMethodID":1},{"AccountNumber":"RELIANCE0001","Name":"Reliance Fitness, Inc.","PurchaseOrderID":143,"ShipMethodID":5},{"AccountNumber":"ADVANCED0001","Name":"Advanced Bicycles","PurchaseOrderID":160,"ShipMethodID":4},{"AccountNumber":"PROSE0001","Name":"Proseware, Inc.","PurchaseOrderID":165,"ShipMethodID":3},{"AccountNumber":"CIRCUIT0001","Name":"Circuit Cycles","PurchaseOrderID":179,"ShipMethodID":1},{"AccountNumber":"GARDNER0001","Name":"Gardner Touring Cycles","PurchaseOrderID":195,"ShipMethodID":1},{"AccountNumber":"MORGANB0001","Name":"Morgan Bike Accessories","PurchaseOrderID":213,"ShipMethodID":1},{"AccountNumber":"RELIANCE0001","Name":"Reliance Fitness, Inc.","PurchaseOrderID":222,"ShipMethodID":5},{"AccountNumber":"ADVANCED0001","Name":"Advanced Bicycles","PurchaseOrderID":239,"ShipMethodID":4},{"AccountNumber":"PROSE0001","Name":"Proseware, Inc.","PurchaseOrderID":244,"ShipMethodID":3},{"AccountNumber":"CIRCUIT0001","Name":"Circuit Cycles","PurchaseOrderID":258,"ShipMethodID":1},{"AccountNumber":"GARDNER0001","Name":"Gardner Touring Cycles","PurchaseOrderID":274,"ShipMethodID":1}]'
--;WITH CTE_JSON
--AS
--(
--	SELECT 
--		[AN]
--		,[NAME]
--	FROM 
--		OPENJSON(@JSONRESUL)
--		WITH
--		(
--		[AN]	NVARCHAR(15)	'$.AccountNumber' --Lo que esta entre el signo de dolar, es el nombre real como esta en el Json, y el [AN] es como lo quiero poner, aqui se pone de esa forma
--		,[NAME]	NVARCHAR(50)	'$.Name' --igual que con este

--		)
--)
 --CON ESTE SELECT ESTOY CONVIERTIENDO EL JSON QUE ESTA EN LA VARIABLE, A UNA TABLA VIRTUAL, Y SOLO EL CAMPO AccountNumber y Campo Name, en este caso
 --Y ESTO LO CREO EN UN CTE, PARA HACER LA SIGUENTE UNION, ENTRE EL JSON (QUE AHORA ES UNA TABLA VIRTUAL) Y CON UNA TABLA DE MI BASE DE DATOS
--SELECT 
--	[JS].[AN]
--	,[JS].[NAME]
--	,[V].PurchasingWebServiceURL
--FROM 
--	CTE_JSON AS [JS]
--INNER JOIN 
--	[Purchasing].[Vendor] AS [V] ON [JS].[AN] = [V].AccountNumber
--WHERE
--	[V].PurchasingWebServiceURL IS NOT NULL
--EN GENERAL, CONVERTI JSON EN UNA TABLA VIRTUAL, CON CAMPOS EN ESPECIFICO (NO TODOS LOS CAMPOS), Y LO HICE UN INNER JOIN ENTRE JOIN(QUE ES UNA TABLA VIRTUAL Y QUE ESTA METIDA EN UN CTE) CON UNA TABLA LLAMADA VENDOR.
----------------------------------------------------------------------------------------------------------------------------------------------------------
--STORED PROCEDURE
--ESTE SELECT LO INTRODUCIMOS A UN STORED PROCEDURE
--SELECT 
--	[CardType]
--	,[CardNumber]
--	,[ExpMonth]
--	,[ExpYear]
--FROM [Sales].[CreditCard] AS [CC]
--WHERE 
--	[CC].ExpYear = YEAR(GETDATE())
--	AND [ExpMonth] = 4
--	AND [CardType] = 'SuperiorCard'

----EJECUTAMOS EL STORED PROCEDURE
--EXEC [Sales].[upsGetCreditCardExpiredApril];

----CREAMOS UNA TABLA
----CREATE TABLE [Sales].[CreditCardNotifications]
----(
----	[BusinessEntityID]	INT	IDENTITY(1,1) PRIMARY KEY
----	,[CardNumber] VARCHAR(25)
----	,[NotificationType]	INT
----)
----CREAMOS UN STORE PROCEDURE NUEVO Y LE PONGO LA SIGUIENTE INSTUCCION. EN EL VIDEO EL HIZO TODO, EN EL MISMO STORED PROCEDURE
--INSERT INTO [Sales].[CreditCardNotifications]
--SELECT 
--	[CC].[CardNumber]
--	,1
--FROM
--	[Sales].[CreditCard] AS [CC]
--WHERE
--	[CC].ExpYear = YEAR(GETDATE())
--	AND [ExpMonth] = 4
--	AND [CardType] = 'SuperiorCard'

----EJECUTO EL NUEVO STORED PROCEDURE, CADA VES QUE YO EJECUTE, SE INSERTARAN DATOS EN LA TABLA [Sales].[CreditCardNotifications]
--EXEC [Sales].[upsGetCreditCardExpiredApril_P2]

--SELECT * 
--FROM 
--	[Sales].[CreditCardNotifications]
-----------------------------------------------------------------------------------------------
--STORED PROCEDURE CON PARAMETROS
--CREAMOS UN STORED PROCEDURE LLAMADO [Sales].[upsGetCreditCardExpiredByMonth], ESTE PROCEDURE VA HACER IGUAL QUE EL ANTERIOR (EL DE INSERT INTO SELECT), Y VA TENER COMO PARAMETRO EL MES, ASI QUE AHORA PUEDO PONER CUALQUIER MES.
--EJECUTAMOS EL STORED PROCEDURE, COMO PARAMETRO EL MONTH, Y EN ESTE CASO LE PIDO QUE SEAN LOS DEL MES 1
--EXEC [Sales].[upsGetCreditCardExpiredByMonth] @I_MONTH = 1;
----VERICAMOS QUE SE INSERTARON LOS DATOS EN ESTA TABLA
--SELECT * 
--FROM 
--	[Sales].[CreditCardNotifications]

----LUEGO SI TENGO PARAMETROS DE SALIDA, TENGO QUE HACER LO SIGUIENTE
--DECLARE @COUNT	AS INT  --DECLARO VARIABLE DE TIPO ENTERO
--DECLARE @MESSAGE AS VARCHAR(100) --DECLARO UNA VARIABLE DE TIPO VARCHAR
------EJECUTO EL STORE PROCEDURE CON EL PARAMETRO DE ENTRA = 2 (FEBRERO), Y EL @CARDTYPE = 'SuperiorCard'. Y PARAMETRO DE SALIDA SE LO ASIGNO A LA VARIABLE QUE CREA ARRIBA, PERO AQUI SE ASIGNA DE FORMA CONTRARIA A LO NORMAL, OSEA @COUNT = @O_COUNT Y SE DEBE DE PONER EL OUTPUT AL FINAL
--EXEC [Sales].[upsGetCreditCardExpiredByMonth] 
--	@I_MONTH = 2
--	,@I_CARDTYPE = 'SuperiorCard'
--	,@O_COUNT = @COUNT OUTPUT
--	,@O_MESSEGE = @MESSAGE OUTPUT
------SELECCIONO EL @COUNT, QUE TIENE EL VALOR DE DE LA VARIABLE @O_COUNT, Y EL @MESSAGE QUE TIENE EL VALOR EN EN ESTE EL MENSAJE DE LA VARIABLE @O_MESSEGE
--SELECT @COUNT AS [REGISTRO_AFECTADOS], @MESSAGE AS [MENSAJE]
--------------------------------------------------------------------------------------------------
--TRY CATCH --PARA Manejo de errores y excepciones 
--SELECT * FROM [Purchasing].[ShipMethod]

----VAMOS A INVOCAR UN ERROR, INSERTANDO DATO NULL EN LA COLUMNA ShipBase, SABIENDO QUE ESA COLUMNA NO ADMITE VALORES NULOS, ESTO NOS DA UN MENSAJE DE ERROR
--INSERT INTO [Purchasing].[ShipMethod]
--	([Name],[ShipBase],[ShipRate],[rowguid],[ModifiedDate])
--	VALUES 
--	('OVERSEAS EXPRESS', NULL, 3.20, NEWID(),GETDATE())

----SI QUEREMOS PONERLE ALGO CADA VES QUE SE INSERTE UN REGISTRO, O QUE CUANDO NO SE INSERTE ME IMPRIMA UN MENSAJE, ESTA ES LA FORMA:
--BEGIN TRY
--	INSERT INTO [Purchasing].[ShipMethod]
--	([Name],[ShipBase],[ShipRate],[rowguid],[ModifiedDate])
--	VALUES 
--	('OVERSEAS EXPRESS',NULL , 3.20, NEWID(),GETDATE())

--PRINT 'EL REGISTRO SE INSERTO CORRECTAMENTE.'

--END TRY
--BEGIN CATCH 

--	PRINT 'EL REGISTRO NO SE INSERTO.'

--END CATCH
----EL TRY CATCH ES MAS COMUN VERLO EN STORED PROCEDURE EN TRIGGER, ETC..
----AHORA VAMOS A CREAR UN STORED PROCEDURE CON LO DE ARRIBA
----DECLARO 2 VARIABLES PARA ASIGANERLE VALORES AL ROWGUID Y AL MODIFIDATE
--DECLARE	@GUID	AS UNIQUEIDENTIFIER
--DECLARE @DATE	AS DATETIME
--SET @GUID = NEWID();
--SET @DATE = GETDATE();
--EXEC [dbo].[uspGetInsertShipMethod] 'OVERSEAS EXPRESS3',5 ,NULL, @GUID, @DATE
-----------------------------------
--Funciones de error
--* ERROR_NUMBER() devuelve el número del error.
--* ERROR_SEVERITY() devuelve la gravedad.
--* ERROR_STATE() devuelve el número de estado del error.
--* ERROR_PROCEDURE() devuelve el nombre del procedimiento almacenado o desencadenador donde se produjo el error.
--* ERROR_LINE() devuelve el número de línea de la rutina que provocó el error.
--* ERROR_MESSAGE() devuelve el texto completo del mensaje de error. El texto incluye los valores proporcionados para los parámetros sustituibles, como las longitudes, nombres de objeto o tiempos

--SI YO EJECUTO ESTE STORED PROCEDURE ME DARIA ERROR PORQUE HAY UN VALOR NULO, PERO SE ACTUALIZARIA LA FECHA COMO YA LO DEFINE EN EL STORED PROCEDURE, PARA ESO COMENTO LA PARTE DEL UPDATE
--DECLARE @GUID	AS	UNIQUEIDENTIFIER
--DECLARE @DATE	AS	DATETIME
--SELECT @GUID = NEWID(), @DATE = GETDATE()
--EXEC [dbo].[uspGetInsertShipMethod] 'OVERSEAS EXPRESS3',4.2 ,2.3, @GUID, @DATE
--PARA MAS INFORMACION IR AL PROCEDURE [dbo].[uspGetInsertShipMethod], DONDE EXPLICO MAS DETALLES CADA COSA.

--A continuación se muestra una descripción general de los niveles de gravedad más comunes y sus significados:, el error anterior es 16

--Nivel de gravedad 0: Éxito (no es un error).
--Nivel de gravedad 1-10: Información y mensajes de advertencia.
--Nivel de gravedad 11-16: Errores generados por el usuario que no interrumpen la ejecución de la transacción.
--Nivel de gravedad 17-19: Errores graves que pueden causar problemas en la ejecución de la transacción actual, pero no requieren una desconexión del servidor.
--Nivel de gravedad 20-25: Errores críticos que generalmente requieren que la conexión se cierre y que pueden afectar la integridad de los datos.
---------------------------------------------------------------------------------------------------------------------------------
--Transacciones. son secuencias de operaciones SQL que se ejecutan de manera atómica, lo que significa que se completan todas juntas o ninguna. Se utilizan para mantener la integridad de los datos en bases de datos.

--SELECT
--*
--FROM
--	[Purchasing].[ShipMethod]

----INSERTAMOS DATOS EN LA TABLA SHIPMETHOD
--INSERT INTO [Purchasing].[ShipMethod]
--([Name],[ShipBase],[ShipRate],[rowguid],[ModifiedDate])
--VALUES 
--('OVERSEAS EXPRESS4',5.20 , 3.20, NEWID(),GETDATE())

----CON ESTO ESTOY INDICANDO QUE ESTOY INICIANDO UNA NUEVA TRANSACCION. PUEDO PONER TAMBIEN BEGIN TRAN
--BEGIN TRANSACTION
--INSERT INTO [Purchasing].[ShipMethod]
--([Name],[ShipBase],[ShipRate],[rowguid],[ModifiedDate])
--VALUES 
--('OVERSEAS EXPRESS5',10 , 3.20, NEWID(),GETDATE())
----SI YO EJECUTO ESTO PUES ME INSERTARA EL REGISTRO, PERO A LA HORA DE CONSULTAR LA TABLA, PUES NO ME APARECERA EL QUERY, APARECERA EXECUTING QUERY EN LA PARTE INFERIOR IZQUIERDA.
----CON EL ROLLBACK NO SE HACE LA INSERCION, Y YA ME APARECE EL QUERY
--ROLLBACK TRAN
----CON EL COMMIT ESTOY CONFIRMANDO LA TRANSACION
--COMMIT TRAN

----inserto esto registro
--BEGIN TRANSACTION
--INSERT INTO [Purchasing].[ShipMethod]
--([Name],[ShipBase],[ShipRate],[rowguid],[ModifiedDate])
--VALUES 
--('OVERSEAS EXPRESS6',10 , 3.20, NEWID(),GETDATE())

--INSERT INTO [Purchasing].[ShipMethod]
--([Name],[ShipBase],[ShipRate],[rowguid],[ModifiedDate])
--VALUES 
--('OVERSEAS EXPRESS57',10 , 3.20, NEWID(),GETDATE())
--SELECT @@TRANCOUNT AS TransaccionesAbierta --esto es para saber si hay transacciones abierta. hay 1 transaccion abierta que es la de arriba.
--ROLLBACK TRAN --SI HAGO ESTO, Y DESPUES EJECUTO EL SELECT DE TRANSACCIONES ABIERTA PUES ME APERECERA O TRANSACCIONES.


--Usando el storedProcedure anterior ([dbo].[uspGetInsertShipMethod]), pues recordando que en ese stored procedure si daba error el sp, pues me iba actualizar la columna modified date de todas formas, y la forma de soluccionarlo hasta ahora era comentadolo, o bien quitandolo.
--Ahora en el sp vamos a ser que si los registros se insertan correctamente pues que se actualizen los datos en la columna modified date, si da error, pues que no se actulizen, para eso vamos hacer uso de transacciones.
--LUEGO DE HABERLO ARREGLADO EN EL SP, PUES EJECUTO EL SP
--DECLARE @GUID	AS	UNIQUEIDENTIFIER
--DECLARE @DATE	AS	DATETIME
--SELECT @GUID = NEWID(), @DATE = GETDATE()
--EXEC [dbo].[uspGetInsertShipMethod] 'OVERSEAS EXPRESS3',NULL ,2.3, @GUID, @DATE
-----------------------------------------------------------------------------------------------
--Nombrar trasacciones y SAVE TRAN
--SELECT
--	[P].ProductID
--	,[P].[Name]
--	,[P].ProductNumber
--	,[P].ModifiedDate
--FROM
--	[Production].[Product] AS [P]
--WHERE
--	ProductID IN (1,2,3,4)

---- BEGIN TRAN: Inicio transacción
---- COMMIT TRAN: Aplica cambios
---- ROLLBACK TRAN: Revierto cambios

----ESTO ES UNA TRANSACCION EN QUE LE ASIGNO UN NOMBRE, SI YO EJECUTO ESTO TAL COMO ESTA NO SE GUARDAN LOS CAMBIOS PORQUE ESTOY HACIENDO UN ROLLBACK
--BEGIN TRANSACTION ActualizarProductos

--UPDATE [Production].[Product] 
--SET ModifiedDate = GETDATE()
--WHERE ProductID = 1

--UPDATE [Production].[Product] 
--SET  ModifiedDate = GETDATE()
--WHERE ProductID = 2

--UPDATE [Production].[Product] 
--SET ModifiedDate = GETDATE()
--WHERE ProductID = 2

--ROLLBACK TRANSACTION ActualizarProductos

----ESTO ES COMO EL DE ARRIBA PERO AQUI SI SE ACTULIZAN PORQUE LE ESTOY DANDO UN COMMIT
--BEGIN TRAN ActualizarID4

--UPDATE [Production].[Product]
--SET ModifiedDate = GETDATE()
--WHERE [ProductID] = 4

--COMMIT TRAN ActualizarID4


------ Save transactions

----este código se utiliza para realizar actualizaciones en una tabla de productos, pero utiliza transacciones y puntos de guardado para controlar cuáles de esas actualizaciones se confirman y cuáles se deshacen en caso de un problema. En este caso, la actualización del tercer producto se deshizo debido a un ROLLBACK específico.
--BEGIN TRAN Actualizacion2

--UPDATE [Production].[Product]
--SET [Name] = 'Adjustable Race PRO', ModifiedDate = GETDATE()
--WHERE [ProductID] = 1
--SAVE TRAN PRODUCTO1 -- Esta línea guarda un punto de guardado (SAVEPOINT) en la transacción actual. Esto significa que, en el futuro, puedes hacer referencia a este punto de guardado para realizar un ROLLBACK solo hasta este punto, en lugar de deshacer toda la transacción. En este caso, el punto de guardado se llama 'PRODUCTO1'.

--UPDATE [Production].[Product]
--SET [Name] = 'Bearing Ball Premium', ModifiedDate = GETDATE()
--WHERE [ProductID] = 2
--SAVE TRAN PRODUCTO2

--UPDATE [Production].[Product]
--SET [Name] = 'BB Ball Bearing Mini', ModifiedDate = GETDATE()
--WHERE [ProductID] = 3
--SAVE TRAN PRODUCTO3

--ROLLBACK TRAN PRODUCTO2 --SE VAN APLICAR LOS CAMBIOS HASTA EL PRODUCTO 2, OSEA QUE EL 1 Y 2 SE ACTULIZAN Y EL 3 NO SE ACTULIZA

--COMMIT TRAN Actualizacion2 
--ES RARO APLICAR ESTE TIPO DE TRANSACCIONES, OSEA QUE LLEVEN SAVE TRAN
---------------------------------------------------------------------------------
--THROW y RAISERROR -- son dos formas de generar errores y excepciones en SQL Server

--BEGIN TRY

--	DECLARE @RESULT INT
--	--GENERAR ERROR AL DIVIDIR UN NUMERO ENTRE 0
--	SET @RESULT = 10/0

--END TRY

--BEGIN CATCH
--	DECLARE 
--			@ErMessage NVARCHAR(2048),
--			@ErSeverity INT,
--			@ErState INT
--	SELECT
--		@ErMessage = ERROR_MESSAGE(),
--		@ErSeverity = ERROR_SEVERITY(),
--		@ErState = ERROR_STATE();

--RAISERROR 
--	(@ErMessage, @ErSeverity, @ErState)
--END CATCH

--BEGIN TRY

--	DECLARE @RESULTDIV INT
--	--GENEREAR ERROR AL DIVIDIR UN NUMERO ENTRE 0
--	SET @RESULTDIV = 100/0
--END TRY
--BEGIN CATCH
--	THROW
--END CATCH

--EL RAISSERROR DA ERROR 50000 Y EL THROW 8134, 

--DIFERENCIA ENTRE AMBOS

--EL RAISSERROR DESPUES DEL ERROR: RAISERROR('RAISERROR TEST',16,1) SI CONTINUA CON LA EJECUCION, OSEA IMPRIME AFTER RAISERROR
--BEGIN
-- PRINT 'BEFORE RAISERROR'
-- RAISERROR('RAISERROR TEST',16,1)
-- PRINT 'AFTER RAISERROR'
--END

----EL THROW NO CONTINUA CON EL ERROR, DESPUES THROW 50000,'THROW TEST',1 OSEA QUE NO IMPRIME AFTER THROW
--BEGIN
--    PRINT 'BEFORE THROW';
--    THROW 50000,'THROW TEST',1
--    PRINT 'AFTER THROW'
--END

--SELECT * FROM master.dbo.sysmessages --La consulta devuelve una lista de todos los mensajes de error y advertencia definidos en la base de datos "master", incluyendo información como el número de error, la severidad, el texto del mensaje y otros detalles relacionados con el mensaje. lo intente hacer con adventureworks y funciono.

---- agregar mensaje personalizado

--EXEC sys.sp_addmessage --se utViliza el procedimiento almacenado del sistema sys.sp_addmessage para crear un nuevo mensaje de error personalizado
--		@msgnum = 50001 --Este número es un identificador único para el mensaje.
--		,@severity = 11 --Se establece la severidad del mensaje en 11. 
--		,@msgtext = 'TEST binario' --Se establece el texto del mensaje como 'TEST binario'.
--SET LANGUAGE 'ENGLISH' --PARA PODER EJECUTAR EL CODIGO DE ARRIBA TUVE QUE CAMBIAR EL SQL A ENGLISH
--RAISERROR(50001,11,1) --ESTO ES PARA QUE ME MUESTRE EL ERROR QUE ACABO DE CREAR

--EXEC sys.sp_dropmessage --BORRAR EL ERROR
--	@msgnum = 50001

--EJEMPLO UTIZANDO THROW Y RAISERROR EN UN SP
-- este procedimiento almacenado intenta realizar una división y calcular el residuo, y si se produce un error durante la operación, captura la excepción, muestra un mensaje de error personalizado y propaga la excepción para su posterior manejo. Si no se produce ningún error, se calcula la división y el residuo y se muestran como resultados.
--CREATE OR ALTER PROCEDURE dbo.Divide
--(
--	@dividend	AS INT
--	,@divisor	AS INT
--)
--AS
--	SET NOCOUNT ON; --Esta línea desactiva la contabilización de filas afectadas por las operaciones dentro del procedimiento almacenado. Esto es útil cuando no deseas que se muestre el número de filas afectadas en la salida del procedimiento almacenado. osea si inserta o actualiza un registro en la consola aparecera (1 row affected), pero con esto no aparece nada de eso 

--BEGIN TRY

--	SELECT @dividend / @divisor AS division, @dividend % @divisor AS residuo;

--END TRY

--BEGIN CATCH

--	PRINT 'Error occurred when trying to compute the division ' 
--	+ CAST(@dividend AS VARCHAR(11)) + '/' + CAST(@divisor AS VARCHAR(11)) + '.';
--	--THROW 
--	EXEC [RaiseCustomError] -- CREE UN SP DEL RAISERROR, YA QUE ES UN POCO AMPLIO Y DECI ENCAPSULARLO

--	PRINT 'This does not execute.'; --Esta línea imprime un mensaje que nunca se ejecutará, ya que THROW finaliza la ejecución del procedimiento almacenado cuando se lanza una excepción.
--									--EN CAMBIO CON EL RAISERRRO SI APARECERA EL This does not execute.' EL RAISERROR ESTA EN EL SP [RaiseCustomError]
--END CATCH
--GO
----EJECUTAMOS EL STORE PROCEDURE CON EL PRIMERO HACE LA DIVISION NORMAL Y CON EL SEGUNDO SALTA EL ERROR
--EXEC dbo.Divide @dividend = 11, @divisor = 2
--EXEC dbo.Divide @dividend = 11, @divisor = 0
------------------------------------------------------------------------
--Tipos de datos (DATATYPE)
--EN LA SECCION DE PROGRAMMABILTY > TYPE > USER-DEFINED DATA TYPES > PODEMOS DEFINIR NUESTRO PROPIO TIPO DE DATO, OSEA PERSONALIZARLO..
--CREATE TYPE [dbo].[OrderNumber] FROM [nvarchar](25) NULL. CON ESTO CREO UN TIPO DE DATO LLAMADO ORDERNUMBER (SERA EL NOMBRE DE LA COLUMNA) DE TIPO NVARCHAR(25) Y QUE SEA NULO

--AQUI DECLARO DOS VARIABLES, UNO VARCHAR Y OTRO NVARCHAR Y LE DOY COMO VALOR LETRAS CHINAS, EN VARCHAR CUANDO HAGO EL SELECT ME APARECERA: ???, MIENTRA QUE CON EL NVARCHAR ME APARECERA EL VALOR CHINO, OJO SE DEBER DE PONER LA N ANTES DEL VALOR CHINO EN EL NVARCHAR, SINO NO FUNCIONA.
--DECLARE	@VARCHAR	AS VARCHAR(100) = '二進制'
--DECLARE @NVARCHAR	AS NVARCHAR(100) = N'二進制'

--SELECT @VARCHAR	AS [VARCHAR], @NVARCHAR AS [NVARCHAR]

----EL DATALENGTH ES PARA SABER LA LONGITUD, EN ESTE CASO DEL VARCHAR Y NVARCHAR, Y EL VARCHAR TIENE 3 Y NVARCHAR CONSUME 6 CARACTERES, POR LO QUE EL NVARCHAR CONSUME MAS ESPACIO EN LA BD
--SELECT DATALENGTH(@VARCHAR) AS [LONGITUDVARCHAR], DATALENGTH(@NVARCHAR) AS [LONGITUDNVARCHAR]

----AQUI AUNQUE SE ACERQUE MAS AL 6 QUE AL 5, ME APARCERA 5. POR LO QUE EL TIPO DE DATO CORRECTO PARA ESTE CASO ES EL DECIMAL.
--DECLARE @NUMERO INT = 5.89
--SELECT (@NUMERO)

----CON EL DATETIME ME APARECE LA FECHA Y HORA, EN CAMBIO CON EL DATE SOLO LA FECHA, CON EL TIPO DE DATO TIME SOLO ME TRAE LA HORA
--DECLARE @FECHA TIME = GETDATE()
--SELECT @FECHA

----EL VALOR QUE LE ESTOY DANDO A LA VARIABLE TIENE 7 DECIMALES, Y LA VARIABLE SOLO PUEDE TENER 6 DECIMALES, POR LO QUE CUANDO HAGO EL SELECT ME VA REDONDEAR, OSEA ME APARECERAN 6 DECIMALES Y EL ULTIME SE REDONDEA TAL QUE ASI: 12.425658
----SI YO PONGO EN EL VALOR 4 DECIMALES, PUES ME VA RELLENAR CON 0 HASTA QUE OCUPE 6 DECIMALES
--DECLARE @DECIMAL DECIMAL(18,6) = 12.4256
--SELECT @DECIMAL
----LO NORMAL ES VER DECIMAL(18,2)
---------------------------------------------------------------------------------------
--Llave primaria (PRIMARY KEY)

--CREAMOS UNA TABLA CON PRMARY KEY Y IDENTITY
--CREATE TABLE Products_Identity
--(
--	ProductId INT	PRIMARY KEY IDENTITY(1,1)
--	,ProductName VARCHAR(100) NOT NULL
--)
----AQUI NO HACE FALTA INDICIAR EL PRODUCT ID PORQUE SE INSERTARA AUTOMATICAMENTE CON EL IDENTITY, OSEA MIENTRA VAYA INSERTANDO REGISTRO EL PRODUCT ID VA IR DE 1 EN 1.
--INSERT INTO Products_Identity
--VALUES ('Laptop DELL')
----SI YO TENGO 2 REGISTROS, Y INSERTO UN NULO ME DARIA UN ERROR, Y DESPUES LO ARREGLO Y LE PONGO OTRO VALOR, EL PRODUCTID SERA 4, EL ERROR ES PORQUE EL PRODUCTNAME NO ACEPTA VALORES NULOS.


--DBCC CHECKIDENT('Products_Identity', NORESEED); --ESTO PARA SABER EL VALOR DE LA CLAVE PRIMARIA ACTUAL, EN ESTE CASO ES 4
--DBCC CHECKIDENT('Products_Identity', RESEED, 2); --ESTO Esto hará que el próximo valor generado por la columna IDENTITY sea 4, SI LO EJECUTO DARIA ERROR, PORQUE YA HAY UN 4, PARAO TENDRIA QUE BORRAR EL ID 4, Y LUEGO HACER EL RESETEO, Y EN VES DE 3 PONGO 2.

--DELETE FROM Products_Identity WHERE ProductId = 4


----The sequence object --este es como el identity pero diferente, NO LE IDENTICO QUE SEA IDENTITY A LA PRIMARY KEY, SINO QUE CREO UNA SECUENCIA, QUE COMIENZE EN 2 Y VAYA DE 2 EN 2
--CREATE TABLE [Products_Sequence]
--(
--	[ProductID]		INT PRIMARY KEY 
--	,[ProductName]	VARCHAR(100) NOT NULL
--)
----EN PROGRAMMABILITY > SEQUENCES > Y AHI ESTA. TAMBIEN PODEMOS EDITARLA
--CREATE SEQUENCE [AutoIncremet]
--AS INT
--START WITH 2
--INCREMENT BY 2

----INSERTAR REGISTRO EN TABLA QUE CREE USANDO LA SEQUENCIA DE ARRIBA, NEXT VALUE FOR AUTOINCREMENT QUE ESTE ULTIMO ES EL NOMBRE DE LA SECUENCIA QUE CREE Y SE LE INSERTARA AL PRODUCTID, COMO UN VALOR DE 2 PORQUE ASI LO INDICAMOS, EL SIGUIENTE REGISTRO QUE SE INSERTE SERA 4 Y ASI SUCESIVAMENTE.
--INSERT INTO [Products_Sequence]
--VALUES
--(
--	NEXT VALUE FOR [AutoIncremet], 'LAPTOP HPP'
--)
--SELECT NEXT VALUE FOR [AutoIncremet] -- SI YO INSERTE UN REGISTRO CON VALOR 6. Y HAGO ESTE SELECT ME APARECERA 8, Y SI HAGO OTRO INSERT ME APERECERA 10. ES MUY RARO UTILIZAR LA SECUENCIA PARA ESTOS CASOS ES MEJOR UTILIZAR EL IDENTITY.


--Nonsequential GUIDs 
--ESTO YA LO VIMOS ANTES: EL NEWID() QUE ESTE NOS TRAE UN VALOR DE 16 BITS QUE NO SE REPITE, ESTE DEBE SIEMPRE DE SER UNIQUEIDENTIFIER
--CREATE TABLE [Products_Nonsequential]
--(
--	[ProductID]		UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID()
--	,[ProductName]	VARCHAR(100) NOT NULL
--)



--INSERT INTO [Products_Nonsequential]
--VALUES
--(
--	DEFAULT
--	,'Laptop DELL'
--)

----Sequential GUIDs
----ESTE ES PARECIDO AL NEW ID, PERO EN ESTE LOS DATOS DEL NEWID(), EN ESTE CASO NEWSENQUETIALID() SE PARECEN UNO LOS OTROS F28D7F67-1A5B-EE11-B9CE-94E70BBB5C8C Y F38D7F67-1A5B-EE11-B9CE-94E70BBB5C8C. AQUI UNO ES F2... Y EL OTRO F3...
--CREATE TABLE [Products_Sequential]
--(
--	[ProductID]		UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWSEQUENTIALID()
--	,[ProductName]	VARCHAR(100) NOT NULL
--)


--INSERT INTO [Products_Sequential]
--VALUES
--(
--	DEFAULT
--	,'Laptop HP PRO MAX1'
--)

--SELECT [ProductID], [ProductName] FROM [Products_Nonsequential] -- ESTO CUANDO USAMOS NEWID() QUE EN ESTE CASO LOS ID SON MUY DIFERENTES
--SELECT [ProductID], [ProductName] FROM [Products_Sequential] -- ESTO CUANDO USAMOS NEWSEQUENTUALID() QUE EN ESTE CASO LOS ID SE PARECEN


----Custom solutions --ESTE NO ES RECOMENDABLE
--CREATE TABLE [Products_Custom]
--(
--	[ProductID]		INT PRIMARY KEY 
--	,[ProductName]	VARCHAR(100) NOT NULL
--)

--DECLARE @consecutive AS INT

--SELECT @consecutive = ISNULL(MAX([ProductID]),0) + 1 FROM [Products_Custom] --esto podria ser una funcion, para mas facilidad

--SELECT @consecutive

--INSERT INTO [Products_Custom]
--VALUES
--(
--	@consecutive
--	,'Laptop ASUS'
--)

-- creo una variable llamada consecutive. Se realiza una consulta para calcular el valor que se asignará a la variable @consecutive. La consulta busca el valor máximo actual en la columna ProductID de la tabla Products_Custom y luego le suma 1. Esto se hace para asegurarse de que cada nuevo producto tenga un ProductID único y consecutivo. Si no hay registros en la tabla todavía, se establece @consecutive en 1.

--EL MAS RECOMENDABLE DE USAR EL EL IDENTITY
------------------------------------------------------------------
--CAST, CONVERT y PARSE
--CAST La función CAST se utiliza para convertir un valor de un tipo de dato a otro.
--CONVERT es similar a CAST y se usa para cambiar el tipo de datos de una expresión. Sin embargo, CONVERT ofrece una mayor flexibilidad al permitir especificar un formato de salida para la conversión, lo que es útil en situaciones como la conversión de fechas y horas.
--PARSE se utiliza principalmente para convertir una cadena que contiene una fecha o una hora en un tipo de dato datetime.

--AMBAS CONSULTA DAN ERROR PORQUE NO SE PUEDE CONVERTIR UN VARCHAR EN UN ENTERO, EN CAMBIO SI PONGA LA PALABRA TRY_CAST O TRY_CONVERT ME DEVOLVERA NULO
--SELECT TRY_CAST('ABC' AS INT) AS [CAST]
--SELECT TRY_CONVERT(INT, 'ABC') AS [CONVERT]

----ESTO SI ME CONVIERTE EL VALOR EN UN ENTERO, AL ESTAR EL 10 ENTRE COMILLAS PUES SQL INTERPRETA QUE ES UNA CADENA, PERO EN ESTE CASO EL 10 EN SI ES UN NUMERO, POR LO QUE SE PUEDE REALIZAR LA CONVERSION. ES BUENO UTILIZAR EL TRY_ PARA CUANDO NO QUIERES QUE TE MARQUE ERROR
--SELECT CAST('10' AS INT) AS [CASTVALUE]
--SELECT CONVERT(INT, '10') AS [CONVERTVALUE]

--SELECT CAST('1020' AS INT); --ESTE ME LO CONVIERTE A ENTERO
--SELECT 
--	CAST(10.999 AS NUMERIC(18,0)) AS [NUMERICO] --AQUI COMO LE INDICO QUE NO TENGA NUMERO DESPUES DEL PUNTO, PUES ME REDONDEA A 11, NOTA: EL NUMERIC Y DECIMAL SON IGUALES
--	,CAST(10.999 AS INT) AS [ENTERO] --AQUI COMO LE INDICO QUE ES ENTERO PUES ME TRAE EL VALOR 10, OSEA QUE NO REDONDEA.


--DECLARE @s AS CHAR(21) = '20170212 23:59:59.999',
--		@dt2 AS DATETIME2 = '20170212 23:59:59.999999'; -- La principal diferencia entre DATETIME y DATETIME2 radica en el rango de valores que pueden representar. DATETIME puede representar fechas y horas desde el 1 de enero de 1753 hasta el 31 de diciembre de 9999, con una precisión de hasta 3.33 milisegundos. En cambio, DATETIME2 tiene un rango de valores más amplio, que va desde el 1 de enero del año 1 hasta el 31 de diciembre de 9999, y admite una precisión de hasta 100 nanosegundos. Esto significa que DATETIME2 es más adecuado para aplicaciones que requieren una mayor precisión temporal o que necesitan manejar fechas en un rango más amplio.
	
--SELECT CAST(@s AS DATETIME) AS [CASTS]
--SELECT CAST(@dt2 AS DATETIME) AS [CASTDT2]
--SI YO SELECCIONO TODO ME LOS CONVIERTE, PERO En VES DE DIA 12 ME APERECE EL DIA 13. ESO SUCEDE POR EL DATETIME QUE REDONDEA ESTO 23:59:59.999, CON EL EL DATETIME2 NO REDONDEA, Y ME APARECE DIA 12
--CON EL DATETIME: 2017-02-13 00:00:00.000, CON EL DATETIME2: 2017-02-12 23:59:59.9990000

--ANTES QUE NADA ACTUALIZE A LA FECHA DE AHORA LOS StoreID QUE SEA = 1000. ENTONCES AQUI QUIERO FILTRARLOS DE ESTA MANERA: '2023-09-25' (QUE ES LA FECHA DE HOY), PERO A LA HORA DE HACER EL SELECT NO ME APERECE NADA. Y ESO ES PORQUE EL DATO ES UN DATETIME, POR LO QUE SI QUIERO FILTRARLO DEBO DE PONER LA FECHA, HORA, SEGUNDO, ETC.. ESTO RESULTARIA MUY COMPLICADO, POR LO QUE LO MEJOR SERIA HACER UN CAST EN EL WHERE DEL MODIFIED DATE, Y PONERLO COMO DATE PARA QUE TRAIGA EL RESULTADO
--SELECT
--	[CustomerID]
--	,[PersonID]
--	,[StoreID]
--	,[TerritoryID]
--	,[AccountNumber]
--	,[ModifiedDate]
--FROM
--	[Sales].[Customer]
----WHERE CAST(ModifiedDate AS DATE) = '2023-09-25'
----WHERE CAST(ModifiedDate AS DATE) = CAST(GETDATE() AS DATE) --ESTE TAMBIEN FUNCIONARIA, PERO SI LO HAGO UN DIAS DESPUES, YA NO FUNCIONA
----WHERE CONVERT(DATE, ModifiedDate) =  '2023-09-25' --con el convert igual funciona.
--WHERE CONVERT(DATE, ModifiedDate) = CONVERT(DATE, GETDATE());


--AQUI CONFORME VOY CAMBIANDO EL NUMERO 1,2,3,4.. 104, 105,100... ME TRAERA UN FORMATO DIFERENTE DE FECHA
--DECLARE @DATE DATETIME
--SELECT @DATE = GETDATE() --ESTO PRODIA SER UN SET TAMBIEN
--SELECT CONVERT(VARCHAR(20), @DATE, 105) AS [CONVERTVALUE]
----AQUI ESTAN TODO LOS FORMATOS: --https://www.sqlshack.com/sql-convert-date-functions-and-formats/

--SELECT CONVERT(Varchar(2), MONTH(GETDATE())) --SACAR EL MES DE LA FECHA ACTUAL, DE TIPO VARCHAR


----TIPO PARSE

----AQUI  CONVIERTO UNA FECHA, EN UN DATETIME
--SELECT TRY_PARSE('Nov 11, 2022' AS DATETIME) AS [CurrentDate] --TRY_PARSE es una función que intenta convertir una cadena en un tipo de dato específico y devuelve NULL si la conversión no es posible en lugar de generar un error.
----CONVIERTE LA CADENA EN TIPO DE DATO MONEY, OBVIANDO EL SIGNO DE DOLAR
--SELECT PARSE('$150.50' AS MONEY USING 'es-MX') AS Result;
----ESTE NO SE UTLIZA TANTO
-------------------------------------------------------------------------------------
--NULL y COALESCE
--NULL es un valor que representa la falta de información o la ausencia de valor en una columna o variable.
--COALESCE --es una función que se usa para seleccionar el primer valor no nulo de una lista de expresiones. Si todas las expresiones son nulas, COALESCE devolverá nulo.

--TRAER TODO DE PURCHASING VENDOR CUANDO LA WEBSERVICEURL  NO ES NULO
--SELECT 
--	[V].BusinessEntityID
--	,[V].AccountNumber
--	,[V].[Name]
--	,[V].CreditRating
--	,[V].PreferredVendorStatus
--	,[V].ActiveFlag
--	,[V].PurchasingWebServiceURL
--	,[V].ModifiedDate
--FROM 
--	[Purchasing].[Vendor] AS [V]
--WHERE PurchasingWebServiceURL IS NOT NULL

----ESTO ME MUESTA LA DEFINICION EN COLUMNA DE LA TABLA VENDOR ESQUEMA PURCHASING
----UNA VES ME DEVULEVE A COLUMNA, PUEDO COPIAR TODAS LAS COLUMNAS Y PEGAR EN EL SELECT EN VES DE PONER EL ASTERICO, Y TODO ES MAS SENCILLO QUE IR PONIENDO CADA COLUMNA. EL SELECT DE ARRIBA LO HICE ASI.
--SELECT COLUMN_NAME
--FROM
--	INFORMATION_SCHEMA.COLUMNS
--WHERE
--	TABLE_SCHEMA = 'Purchasing' AND
--	TABLE_NAME = 'Vendor' --DESDE AHORA EN ADELANTE HACER ESTO CADA VES QUE HAIGA MUCHAS COLUMNAS QUE PONER EN EL SELECT. TAMBIEN PUEDO HACER UN SELECT TOP 1000 ROWS Y COPIAR LAS COLUMNAS.

----ESTE CONSULTA TRAE EL ID DEL VENDEDOR O EMPRESA QUE MAS SE LE COMPRA
--SELECT 
--	TOP 10 [VENDORID], SUM(TOTALDUE) AS TOTAL
--FROM 
--	[Purchasing].[PurchaseOrderHeader]
--GROUP BY 
--	VENDORID
--ORDER BY
--	2 DESC

----ESTE SELECT EN LA COLUMNA PurchasingWebServiceURL CUANDO HAIGA VALORES NULOS PUES ME LA CAMBIARA POR: 'MISSING TO IMPLEMENT WS'
--SELECT 
--	TOP 10 
--	[POH].[VENDORID], 
--	[V].[Name], 
--	SUM([POH].TOTALDUE) AS TOTAL, 
--	ISNULL([V].PurchasingWebServiceURL, 'MISSING TO IMPLEMENT WS')
--FROM 
--	[Purchasing].[PurchaseOrderHeader] AS [POH]
--	INNER JOIN [Purchasing].[Vendor] AS [V]
--		ON [V].BusinessEntityID = [POH].VendorID
--		AND	[V].PurchasingWebServiceURL IS NULL --ESTO ES COMO SI FUERA UN WHERE, PERO SE LO PUSE AQUI, ES LO MISMO
--GROUP BY 
--	VENDORID, [NAME], [PurchasingWebServiceURL]
--ORDER BY
--	 SUM([POH].TOTALDUE) DESC

----EN ESTA CONSULTA EL COALESCE LO QUE VA HACER ES SI LA COLUMNA CLASS ES NULA, PUES QUE TRAIGA EL SIGUIENTE VALOR QUE ES STYLE, Y SI ESTE ES NULO PUES QUE TRAIGA EL SIGUIENTE VALOR QUE ES COLOR, SI TAMBIEN ES NULO QUE PONGA: NADA ENCONTRADO
--SELECT 
--	ProductID
--	,[NAME]
--	,[ProductNumber]
--	,[class]
--	,[style]
--	,[color]
--	,COALESCE(class, style, color, 'NADA ENCONTRADO') AS [COALESCE_VALUE]
--FROM
--	[Production].[Product]
--WHERE
--	PRODUCTID IN (941, 945, 948, 952)
--EL COALESCE UN BUEN EJEMPLO SERIA UTLIZARLOS CON TELEFONOS.
-- la principal diferencia radica en la versatilidad de COALESCE, que puede manejar múltiples valores y devolver el primero que no sea nulo. ISNULL, por otro lado, es más limitado y se usa principalmente cuando se desea reemplazar un solo valor nulo. Si estás escribiendo consultas que deben ser compatibles con varios sistemas de gestión de bases de datos, es preferible usar COALESCE.
---------------------------------------------------------------------------------------------
--NORTHWIND ESTO ES UNA BASE DE DATO DE EJEMPLO DE MICROSOFT
--PARA DESCARGALO FUE AL GITHUB DE MUNDO BINARIO, LO DESCARGE LO PUSE EL ESCRITORIO, ABRI EL EXPLORADOR DE ARCHIVOS, Y EN SQL ABRI UNA NUEVA QUERY, ARRASTRE EL ARCHIVO DE DESCARGA AL NEW QUERY, Y AHI ME APERICO EL SCRIP PARA CREAR LA BASE DE DATOS CON TODOS SUS COMPONENTES
--esto es para mostrar los stored procedure de la base de dato actual
--SELECT name
--FROM sys.procedures;

----PARA MOSTRAR TODAS LOS STORED PROCEDURE DEL SISTEMA QUE TENGAN COMO INICIAL 'sp_'
--EXEC sp_stored_procedures @sp_name = 'sp_%', @fUsePattern = 1;
-------------------------------------------------------------------------------------
--Diagrama de base de datos. ES IMPORTANTE SABER ESTO PORQUE ES LA MANERA MAS ILUSTRATIVA PARA CONOCER COMO ESTA CONFORMADA NUESTRA BD 
--CONTROL y  Caps Lock y - para alegar el diagrama y + para hacer zoom
--HACIENDO CLICK DERECHO SOBRE EL DIAGRAMA Y DANDOLE A COPY DIAGRAM TO CLIPBOARD SE COPIARA EL DIAGRAMA Y PODEMOS PEGARLO EN POWER POINT POR EJEMPLO.
--EN EL DIAGRAMA SE PUEDEN CREAR TABLAS, PERO NO ES LO RECOMENDABLE.
--SI EN A LA HORA DE HACER UN NUEVO DIAGRAMA O AGREGAR UNA NUEVA TABLA EN DIAGRAMA NOS SALE ESTE ERROR: index was outside the bounds of the array SOLO DEBEMOS REINICIAR EL SQL SERVER.
-----------------------------------------------------------------------------------------------------------------------------
--Esquemas:  Los esquemas en SQL Server se utilizan para organizar o agrupar los conjuntos de objetos con un mismo interés 

--Select * FROM sys.schemas --Ver todos lo esquemas que existen en esta base de datos. En security > Schemas > podemos verlo tambien.

--CREATE SCHEMA HumanResources --Crear un esquema

--CREATE TABLE [HumanResources].[Employees]
--(
--	[EmployeeID] [int] IDENTITY(1,1) NOT NULL,
--	[LastName] [nvarchar](20) NOT NULL,
--	[FirstName] [nvarchar](10) NOT NULL,
--	[Title] [nvarchar](30) NULL,
--	[TitleOfCourtesy] [nvarchar](25) NULL,
--	[BirthDate] [datetime] NULL,
--	[HireDate] [datetime] NULL,
--	[Address] [nvarchar](60) NULL,
--	[City] [nvarchar](15) NULL,
--	[Region] [nvarchar](15) NULL,
--	[PostalCode] [nvarchar](10) NULL,
--	[Country] [nvarchar](15) NULL,
--	[HomePhone] [nvarchar](24) NULL,
--	[Extension] [nvarchar](4) NULL,
--	[Photo] [image] NULL,
--	[Notes] [nvarchar](max) NULL,
--	[ReportsTo] [int] NULL,
--	[PhotoPath] [nvarchar](255) NULL
--)
----Aqui yo cree una tabla con el mismo nombre de una ya existente en la BD, Pero esta tiene como esquema HumanResources, y la dbo, por lo que no va dar error si la creo.

--DROP SCHEMA HumanResources --BORRAR UN ESQUEMA, SI LO INTENTO BORRAR ME DARA ERROR, PORQUE HAY UNA TABLA QUE HACE REFERENCIA A ESE ESQUEMA. PARA ESO NECESITO BORRAR LAS TABLA A LA QUE TENGA COMO REFERENCIA ESE ESQUEMA.
--DROP TABLE [HumanResources].[Employees]

----TRANFERIR DE UN ESQUEMA A OTRO
--CREATE SCHEMA HumanResources --CREO EL ESQUEMA
--ALTER SCHEMA HumanResources TRANSFER [dbo].[Employees] --CAMBIO EL [DBO].[EMPLOYEES] POR [HumanResources].[Employees]
--ALTER SCHEMA dbo TRANSFER HumanResources.Employees --CAMBIARLO A COMO ESTABA
----------------------------------------------------------------------------------------------------------------------------
--Columnas Calculadas en SQL Server 
--SELECT
--	CONCAT(FirstName, ', ',LastName)
-- FROM 
--	[Employees]

---- Concatenar nombre con apellido en una columna calculada
----CREO UNA NUEVA COLUMNA CON EL NOMBRE Y APELLIDO. EL TIPO ES COLUMNA CALCULADA NVARCHAR(32) NOT NULL
--ALTER TABLE [dbo].[Employees]
--ADD FullName AS CONCAT(FirstName, ', ',LastName) 

---- Obtener años entre dos fechas. OBTENER LA CANTIDAD DE DIAS QUE HAN PASADO ENTRE ESAS FECHAS
--SELECT DATEDIFF(DAY, '2010-12-30', GETDATE());


----OBTENER EL AÑO ENTRE DOS FECHAS
--SELECT DATEDIFF(YEAR, '2010-12-30', GETDATE());

----AGREGAMOS UNA COLUMNA LLAMADA EDAD (AGE), Y CON EL DATEDIFF Calculamos la edad con base a la fecha de nacimiento y fecha del servidor. 
--ALTER TABLE [dbo].[Employees]
--ADD AGE AS DATEDIFF(YEAR, BirthDate, GETDATE());


---- Insertar orden 
--INSERT INTO [dbo].[Orders]
--([CustomerID],[EmployeeID],[OrderDate], [RequiredDate],[ShippedDate],[ShipVia],[Freight],[ShipName],[ShipAddress],[ShipCity],[ShipRegion],[ShipPostalCode],[ShipCountry])
--VALUES
--('LILAS',1,GETDATE(), (CONVERT(datetime, '2023-10-24', 120)), NULL,1, 10.50, 'LILAS CDMX', 'Av. Constitución 15', 'CDMX', 'CDMX', '93000', 'México')


---- Calcular días restantes para fecha requerida por parte del cliente (V1). EN ESTE CASO ME APARECERA EN NEGATIVO, POR EJEMPLO EN LA INSERCION ANTERIOR APARECERA -8, QUE SON LOS DIAS QUE FALTAN
--ALTER TABLE [dbo].[Orders]
--ADD RemainingDays AS DATEDIFF(DAY,[RequiredDate], GETDATE());

----Es lo mismo que el anterior pero cuando la fecha de requiereddate sea mayor a la fecha actual pues va poner 0, de lo contrario calculara los dias que faltan
--ALTER TABLE [dbo].[Orders]
--ADD RemainingDays2 AS
--	CASE WHEN [RequiredDate] < GETDATE() THEN 0
--	ELSE 
--	DATEDIFF(DAY,[RequiredDate], GETDATE()) END


----Esto seria con el case, pero para que me salga el numero positivo
--ALTER TABLE [dbo].[Orders]
--ADD RemainingDays4 AS
--CASE WHEN [RequiredDate] < GETDATE() THEN 0
--ELSE 
--(DATEDIFF(DAY,[RequiredDate], GETDATE())) *-1 END --ESTA ES LA MAS RECOMENDABLE


----Este seria con el iff pero numero -8, estaria positivo
--ALTER TABLE [dbo].[Orders]
--ADD RemainingDays3 AS
--IIF([RequiredDate] < GETDATE(), 0, DATEDIFF(DAY, GETDATE(), [RequiredDate]));
-------------------------------------------------------------------------------------
--Enmascarar datos (DATA MASKING)

 --1. DEFAULT Takes the default mask of the data type (not of the DEFAULT constraint of the column, but the data type).
 --2. EMAIL Masks the email so you only see a few meaningful characters.
 --3. RANDOM Masks any of the numeric data types (int, smallint, decimal, etc) with a random value within a range.
 --4. PARTIAL Allows you to take values from the front and back of a value, replacing the center with a fixed string value

 --default --Para mostrar todo los datos asi: xxxx
-- ALTER TABLE [dbo].[Employees]
-- ALTER COLUMN FirstName Nvarchar(10) MASKED WITH (FUNCTION = 'default()') --aplicando una máscara de datos que utiliza la función "default()" para ocultar parte de su contenido. La máscara de datos ocultará el valor real de la columna cuando se acceda a ella, y solo mostrará una representación enmascarada a usuarios no autorizados.

-- --CREAMOS UN USUARIO, DONDE SOLO PUEDA HACER SELECT EN LA TABLA EMPLEADOS.
-- CREATE USER AHERNANDEZ WITHOUT LOGIN; --"WITHOUT LOGIN" significa que este usuario no tiene acceso directo a SQL Server como un inicio de sesión de autenticación de Windows o SQL Server. Esto se utiliza a menudo cuando deseas crear un usuario para aplicaciones o servicios que no necesitan iniciar sesión directamente en el servidor de base de datos.
-- GRANT SELECT ON [dbo].[Employees] To AHERNANDEZ
-- --EN SECURITY > USER, PODEMOS VER EL USUARIO CREADO

-- --AQUI NOS PASAMOS AL USUARIO AHERNANDEZ (QUE SOLO TIENE PERMISO HACER SELECT A ALA TABLA EMPLEADO), Y AL HACER SELECT EL FIRSTNAME APARECERA CON xxxx, y esto es porque esta enmascarado y no puede verlo con este usuario
--EXECUTE AS USER = 'AHERNANDEZ'
--SELECT * FROM [dbo].[Employees]
--REVERT --esto es para volver con el usuario de admin

----email: para los emil, muestra la primera letra, el @ y el .com
----CREAMOS UNA NUEVA COLUMNA, Y LE PONEMOS DATOS
--ALTER TABLE [dbo].[Employees]
--ADD Email NVARCHAR(100) NULL

----AQUI ENMASCARAMOS LA COLUMNA EMAIL, PERO AHORA CON LA FUNCION email, al ser select con un usuario que no sea admin, o que no tenga los permisos para ver los registro enmascarado, le aprecera asi: DXXX@XXXX.com, solo parece el inicial, el @ y el .com, despues todo aparece con x
--ALTER TABLE [dbo].[Employees]
--ALTER COLUMN EMAIL NVARCHAR(100) MASKED WITH (FUNCTION = 'email()')

--EXECUTE AS USER = 'AHERNANDEZ'
--SELECT * FROM [dbo].[Employees]
--REVERT

----Random Para numeros
----CAMBIAMOS EL TIPO DE DATOS A LA COLUMNA
--ALTER TABLE [dbo].[Employees]
--ALTER COLUMN [Extension] INT NULL

----AQUI PONEMOS EL ENMASCARAMIENTO A LA COLUMNA EXTENSION, ESTO LO QUE HACE ES EN VES 256 QUE ME APARECIA CON EL USUARIO ADMIN, CON OTRO USUARIO QUE NO PERMISOS PUES APARECERA UN NUMERO RANDOM ENTRE 1 Y 5, CADA VES QUE HACEMOS SELECT VA CAMBIAR ESE NUMERO. NOTA: PODEMOS ESPECIFICAR CUALQUIER OTRO NUMERO
--ALTER TABLE [dbo].[Employees]
--ALTER COLUMN [Extension] INT MASKED WITH (FUNCTION = 'random(1,5)')

--EXECUTE AS USER = 'AHERNANDEZ'
--SELECT * FROM [dbo].[Employees]
--REVERT

----El partial muestra lo que especificamos, ya sea *,x, etc,
--ALTER TABLE [Employees]
--ALTER COLUMN [Address] NVARCHAR(60) MASKED WITH (FUNCTION = 'partial(1,"***",1)')

--EXECUTE AS USER = 'AHERNANDEZ'
--SELECT * FROM [dbo].[Employees]
--REVERT

----DATETIME PARA EMNASCARAR EL DIA, EL AÑO O MES, ESTO SOLO FUNCIONA PARA LA VERSION DE 2022 EN ADELANTE
--ALTER TABLE [dbo].[Employees]
--ALTER COLUMN [BirthDate] DATETIME MASKED WITH (FUNCTION = 'datetime("Y")')

--EXECUTE AS USER = 'AHERNANDEZ'
--SELECT * FROM [dbo].[Employees]
--REVERT


--GRANT UNMASK TO AHERNANDEZ; --CON ESTO LE DOY PERMISO AL USARIO AHERNANDEZ QUE PUEDA VER LOS DATOS ENMASCARADOS
--REVOKE UNMASK TO AHERNANDEZ;  --CON ESTO LE QUITOS LO PERMISOS, Y VUELVE A ESTAR ENMASCARADOS LO DATOS CON ESTE USUARIO.

--SELECT CURRENT_USER; --SABER EL USUARIO ACTUAL
--SELECT @@VERSION --SELECCIONAR LA VERSION ACTUAL
---------------------------------------------------------------------------------------------------------------
--Crear índices (CREATE INDEX)

-- Crear tabla sin llave primaria
--CREATE TABLE [dbo].[Countries]
--(
--	[CountryID]			VARCHAR(2)		NOT NULL
--	,[CountryName]		VARCHAR(100)	NOT NULL
--	,[CountryStatus]	BIT				NOT NULL
--)

---- Insertar datos a la tabla
----	ISO 3166-1 alpha2: codes are two-letter country codes defined in ISO 3166-1

--INSERT INTO [dbo].[Countries] ([CountryID], [CountryName], [CountryStatus]) VALUES ('MX', 'México', 1)
--INSERT INTO [dbo].[Countries] ([CountryID], [CountryName], [CountryStatus]) VALUES ('CO', 'Colombia', 1)
--INSERT INTO [dbo].[Countries] ([CountryID], [CountryName], [CountryStatus]) VALUES ('AR', 'Argentina', 1)
--INSERT INTO [dbo].[Countries] ([CountryID], [CountryName], [CountryStatus]) VALUES ('PE', 'Perú', 1)
--INSERT INTO [dbo].[Countries] ([CountryID], [CountryName], [CountryStatus]) VALUES ('VE', 'Venezuela', 1)
--INSERT INTO [dbo].[Countries] ([CountryID], [CountryName], [CountryStatus]) VALUES ('MT', 'Malta', 0)
--INSERT INTO [dbo].[Countries] ([CountryID], [CountryName], [CountryStatus]) VALUES ('YT', 'Mayotte', 0)
--INSERT INTO [dbo].[Countries] ([CountryID], [CountryName], [CountryStatus]) VALUES ('UY', 'Uruguay', 1)
--INSERT INTO [dbo].[Countries] ([CountryID], [CountryName], [CountryStatus]) VALUES ('ES', 'España', 1)
--INSERT INTO [dbo].[Countries] ([CountryID], [CountryName], [CountryStatus]) VALUES ('EG', 'Egipto', 0)
--INSERT INTO [dbo].[Countries] ([CountryID], [CountryName], [CountryStatus]) VALUES ('EC', 'Ecuador', 1)
--INSERT INTO [dbo].[Countries] ([CountryID], [CountryName], [CountryStatus]) VALUES ('MA', 'Marruecos', 0)

----SELECCIONAR TODOS LOS DATOS DE LA TABLA
--SELECT
--	[COUNTRYID]
--	,[COUNTRYNAME]
--	,[COUNTRYSTATUS]

--FROM
--	[dbo].Countries

--EXECUTE sp_helpindex 'Countries' --PARA SABER SI HAY INDICE EN LA TABLA

---- Crear INDICE ORDENADO SOBRE EL CAMPO COUNTRYNAME, AL EJECUTAR EL CODIGO DE ARRIBA, YA ME APARECE EL NOMBRE DEL INDICE
--CREATE CLUSTERED INDEX IDX_Countries_CountryName
--ON [dbo].[Countries] ([CountryName])

----AL HACER ESTO Y HACER UN SELECT A LA TABLA, ME ORGANIZARA LAS FILAS POR ORDEN ALFABETICO, OSEA LO ORDENARA POR COUNTRYNAME QUE FUE DONDE SE CREO EL INDICE
----ADEMAS LA CONSULTA SERA MAS RAPIDO PORQUE YA TIENE UN INDICE

----INDICE NO AGRUPADO
--CREATE NONCLUSTERED INDEX IDX_Contries_CountryID 
--ON Countries (CountryID)
--AHORA TENDRE DOS INDICE EN LA TABLA, SILECCIONO TODO LOS DATOS ME LO VA ORDENAR POR EL COUNTRYNAME, PERO SI YO SOLO SELECIONO EL COUNTRYID Y EL COUNTRYNAME PUES ME LO ORDENARA POR EL ID
--SI VAMOS A LA TABLA DONDE CREAMOS EL INDICE, AHI UN APARTADO DONDE APARECEN LOS INDICE QUE TIENE LA TABLA
---------------------------------------------------------------------------------------------------------------------------
--CHECK CONSTRAINTS en SQL Server
--restricciones de verificación para garantizar que los datos que se almacenaran en la base de datos cumplan con las condiciones adecuadas

--CREATE TABLE [dbo].[Countries]
--(
--	[CountryID]				VARCHAR(2)		NOT NULL
--	,[CountryName]			VARCHAR(100)	NOT NULL
--	,[CountryStatus]		BIT				NOT NULL
--	,[CountryPopulation]	INT				NOT NULL CHECK (CountryPopulation > 0)
--)

--INSERT INTO 
--[dbo].[Countries] ([CountryID], [CountryName], [CountryStatus], [CountryPopulation])
--VALUES
--('MX', 'México', 1, 126000)

----CON ESTE ME DARA ERROR, PORQUE EL CAMPO COUNTRY POPULATION NO PUEDE HACER VALORES MENORE O IGUALES A 0
--INSERT INTO 
--[dbo].[Countries] ([CountryID], [CountryName], [CountryStatus], [CountryPopulation])
--VALUES ('CO', 'Colombia', 1, 0) 


----VER LAS RESTRICCIONES ACTIVAS DE LA TABLA
--SELECT
--	name
--	,is_disabled
--	,is_not_trusted
--	,definition
--	,OBJECT_NAME(parent_object_id) AS TABLENAME
--	FROM
--		sys.check_constraints
--	WHERE OBJECT_NAME(parent_object_id) = 'Countries'

----DESHABILITAR UNA RESTRINCCION
--ALTER TABLE COUNTRIES
--NOCHECK CONSTRAINT [CK__Countries__Count__29221CFB] --AHORA PODEMOS INSERTAR EL REGISTRO QUE TENIA 0, EN EL SELECT DE ARRIBA EN EL CAMPO IS_DISABLE Y IS_NOT_TRUSTED APARECERA COMO 1, CUANDO ESTA HABILITADA APARECERA COMO 0

----HABILITAR UNA RESTRINCCION
--ALTER TABLE COUNTRIES
--CHECK CONSTRAINT [CK__Countries__Count__29221CFB]


--SELECT * FROM [dbo].[Employees]

----AGREGAR UNA CHECK CONSTRAINT A UNA TABLA EXISTENTE
----LO QUE HACE ES, SI INTENTO INSERTAR UN REGISTRO EN EL QUE LA FECHA ACTUAL Y LOS AÑOS QUE HAN PASADO DESDE SU CUMPLEAÑO SEA MENOR A 18, PUES GENERARA UN ERROR
--ALTER TABLE [dbo].[Employees]
--ADD CONSTRAINT [BirthDate] CHECK(DATEDIFF(YEAR,BirthDate, GETDATE()) > 18)

--SI INTENTO INSERTAR ESTE REGISTRO DARIA ERROR, PORQUE EL BIRTDATE FUE EN EL 2013, OSEA TIENE 10 AÑOS, POR LO QUE NO SE PUEDE INSERTAR EL REGISTRO PORQUE NO CUMPLE CON LA VALIDACION
--INSERT INTO [dbo].[Employees]
--([LastName],[FirstName],[Title],[TitleOfCourtesy],[BirthDate],[HireDate],[Address],[City],[Region],[PostalCode]
--,[Country],[HomePhone],[Extension],[Photo],[Notes],[ReportsTo],[PhotoPath]) 
--VALUES
--('Davolio','Nancy','Sales Representative','Ms.','01/01/2013','05/01/1992','507 - 20th Ave. E.
--Apt. 2A','Seattle','WA','98122','USA','(206) 555-9857','5467',NULL,'Education includes a BA in psychology from Colorado State University in 1970.  She also completed "The Art of the Cold Call."  Nancy is a member of Toastmasters International.',2,'http://accweb/emmployees/davolio.bmp')
---------------------------------------------------------------------------------------------
--User Defined Data Types (UDDT)
--permite a los usuarios crear sus propios tipos de datos personalizados basados en los tipos de datos existentes en SQL Server. Esto puede ser útil para encapsular la lógica del negocio y mejorar la legibilidad y mantenimiento del código.

--CREATE TYPE TypeMoney FROM MONEY; --CREAR UN TIPO DE DATO QUE SERA DE TIPO MONEY, OSEA LO QUE CAMBIA ES EL NOMBRE PERO SIGUE SIENDO DE TIPO MONEY, OSEA ES COMO UN ALIAS
----EN LA BASE DE DATOS > PROGRAMMABILITY > TYPES > USER DEFINED DATA TYPES > PODEMOS VER LOS TIPOS DE DATOS DEFINIDO POR EL USUARIO

----CREAR UNA TABLA USANDO EL TIPO DE DATO QUE CREE
--CREATE TABLE [dbo].[Sales] (
--    [SaleID] INT PRIMARY KEY,
--    [SaleDate] DATETIME,
--    [SaleTotal] TypeMoney
--);

--CREATE TYPE PhoneNumber FROM NVARCHAR(20) NOT NULL --CREAMOS UN TIPO DE DATO LLAMADO PhoneNomber de tipo NVARCHAR Y QUE NO ACEPATA NULO

----CREAR UNA TABLA USANDO EL TIPO DE DATO PhoneNumber
--CREATE TABLE Customers2 (
--    CustomerID INT PRIMARY KEY,
--    CustomerName VARCHAR(100),
--    Phone PhoneNumber NULL
--);
--EN LA TABLA YO PUSE QUE ACEPTARA VALORES NULOS Y EL TIPO DE DATO DICE QUE NO ACEPTA VALORES NULOS, PERO AQUI VA HACER CASO A LO QUE SE ESPECIFICA EN LA TABLA, POR LO QUE ACEPTARA VALORES NULO
------------------------------------------------------------------------------------------------------------------
--User Defined Tables Types (UDTT)
--es un tipo de dato definido por el usuario que representa una estructura de tabla. A diferencia de los User Defined Data Types (UDDT), que son tipos de datos escalares, los UDTT se utilizan para definir tipos de tablas.
 
--CREATE TYPE Bibliography AS TABLE
--(
--	[Title] NVARCHAR(100) NOT NULL,
--    [Author] NVARCHAR(100) NOT NULL,
--    [PublicationYear] INT NOT NULL
--);

--CREATE PROCEDURE GETBibliography
--@TABLA Bibliography READONLY
--AS
--BEGIN
--	SELECT * FROM @TABLA
--END
--GO

--DECLARE @MYTABLA Bibliography

--INSERT INTO @MYTABLA
--VALUES
--('Una visita inesperada', 'Agatha Christie', '1956')
--,('Diez negritos', 'Agatha Christie', '1939')

--EXEC GETBibliography @MYTABLA
--, este código demuestra cómo utilizar un tipo de tabla definido por el usuario para representar y manipular conjuntos de datos tabulares, en este caso, datos bibliográficos.
-- no es muy comun hacer esto
-----------------------------------------------------------------------------------------------------------------------
--TRIGGER
--Un trigger en SQL Server es un objeto de base de datos que se ejecuta automáticamente en respuesta a un evento específico, como una inserción, actualización o eliminación de datos en una tabla.

--SELECT * FROM [dbo].[Customers]

--ALTER TABLE [dbo].[Customers]
--ADD LastOrderDate DATETIME;
  
----crear trigger
--CREATE TRIGGER UpdateLastOrder
--ON [dbo].[Orders] --la tabla donde se creara el trigger. No es la tabla donde ocurrira la insercion o evento, sino la tabla en donde si se inserta una orden, el evento ocurrira en la tabla especificada abajo
--AFTER INSERT 
--AS
--BEGIN
--UPDATE [C]
--SET LastOrderDate = GETDATE()
--FROM [dbo].[Customers] as [C]
--INNER JOIN inserted AS [i] on [C].CustomerID = [i].CustomerID --Inserted es una tabla virtual.  es una tabla especial que se utiliza en triggers para acceder a las filas afectadas por la operación que activó el trigger.
--END
----este trigger asegura que la columna "LastOrderDate" en la tabla "Customers" se actualice automáticamente con la fecha y hora actuales cada vez que se inserta una nueva fila en la tabla "Orders"

----INSERTAMOS UN REGISTRO EN ORDERS
--INSERT INTO [dbo].[Orders]
--([CustomerID]) VALUES ('ANTON') --AQUI SE INSERTO EL REGISTRO EN LA TABLA DE ORDENES Y SE ACTUALIZO LA FECHA EN LA TABLA CLIENTE, OSEA EL CLIENTE ANTON DE LA TABLA CUSTOMER YA APARECERA CON LA ULTIMA ORDEN, OSEA ESTA QUE HICE


--DISABLE TRIGGER UpdateLastOrder ON [dbo].[Orders]; --DESHABILITAR TRIGGER. Si yo inserto otro pedido pues no ocurrira la insercion en la tabla customer 
--ENABLE TRIGGER UpdateLastOrder ON [dbo].[Orders] --HABILITAR TRIGGER
-------------------------------------------------------------------------------------------------------------------------------------
--TRIGGER de trazabilidad Estos tipos de datos permiten a los usuarios definir una estructura de tabla personalizada con columnas y tipos de datos específicos
--ESTO ES TABLA DE MONITORIO A TRAVES DE TRIGGER
--CREATE TABLE Monitoring
--(
--	MonitorID	INT	IDENTITY(1,1) PRIMARY KEY
--	,[TableName]		VARCHAR(100)	NOT NULL
--   ,[Transaction]	VARCHAR(50)		NOT NULL
--   ,[Reference]		VARCHAR(250)	NOT NULL
--   ,[CreatedAt]		DATETIME DEFAULT GETDATE()
--)
--creamos eun trigger
--CREATE TRIGGER [dbo].[CustomerMonitoring]
--ON  [dbo].[Customers]
--AFTER INSERT, DELETE, UPDATE
--AS 
--BEGIN

--	INSERT INTO [dbo].[Monitoring]
--	([TableName], [Transaction], [Reference])
--	VALUES
--	('Customers', 'INSERT', 'Se ha insertado el cliente');

--END

 -- SI INSERTO ESTE REGISTRO, SE ACTIVA EL EVENTO DEL TRIGGER Y SE INSERTARA ESTO ('Customers', 'INSERT', 'Se ha insertado el cliente'); EN LA TABLA MONITORING
--INSERT INTO [dbo].[Customers]
--([CustomerID],[CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax], [LastOrderDate])
--VALUES
--('MB', 'Mundo Binario', 'Axel Romero', 'Tech content creador', '0101010101', 'Puebla', NULL, '22000', 'Mexico', NULL, NULL, NULL)


--DELETE FROM [dbo].[Customers] WHERE CustomerID = 'MB' --SI HAGO TAMBIEN SE INSERTARA ESTO: ('Customers', 'INSERT', 'Se ha insertado el cliente'); LO CUAL NO ES LO ADECUADO, PORQUE ESTOY BORRANDO UN REGISTO, NO INSERTANDOLO

--UPDATE Customers SET  City = 'GUAD WHERE CustomerID = 'MB';
--PARA ESO MODIFICO EL TRIGGER DE ARRIBA
--ALTER TRIGGER [dbo].[CustomerMonitoring]
--ON  [dbo].[Customers]
--AFTER INSERT, DELETE, UPDATE
--AS 
--BEGIN

--	DECLARE @CustomerID nchar(5)

--	IF(SELECT COUNT(deleted.[CustomerID]) FROM deleted) > 0 --Esto verifica si hay al menos una fila afectada por la operación de eliminación. deleted es una pseudo-tabla (tabla virtual) que contiene los registros que fueron eliminados durante la operación de eliminación.
--	BEGIN
--		SELECT @CustomerID = deleted.[CustomerID] From deleted --Esto asigna el valor de la columna [CustomerID] de la fila eliminada al variable @CustomerID. En el caso de operaciones de eliminación, generalmente se asume que solo hay una fila afectada, por lo que esta asignación funciona correctamente.

--		INSERT INTO [dbo].[Monitoring]
--		([TableName], [Transaction], [Reference])
--		VALUES
--		('Customers', 'DELETE', 'Se ha borrado el cliente ' + @CustomerID)

--	END

--	IF(SELECT COUNT(Inserted.[CustomerID]) FROM inserted) > 0
--	BEGIN
--		SELECT @CustomerID = inserted.[CustomerID] FROM inserted

--		INSERT INTO [dbo].[Monitoring]
--		([TableName], [Transaction], [Reference])
--		VALUES
--		('Customers', 'INSERT', 'Se ha insertado el cliente ' + @CustomerID)
--	END
--END
--Con esto aparecera si inserto un registro en la tabla customer, aparecera esto, ('Customers', 'INSERT', 'Se ha insertado el cliente ' + @CustomerID), si se ha borrado aparecera esto: 'Customers', 'DELETE', 'Se ha borrado el cliente ' + @CustomerID)
--------------------------------------------------------------------------------------------------------------------------------------------------------
--JOB:  Un job o tarea programada, es un conjunto de operaciones que se ejecutan de manera automática en un horario específico o en respuesta a ciertos eventos.

--Crear un job “manualmente” creando archivos batch y archivos de script SQL, y ejecutándolos a través del Programador de tareas de Windows. Por ejemplo, puedes hacer una copia de seguridad de tu base de datos con dos archivos como estos:
--backup.bat:

--sqlcmd -i backup.sql
--backup.sql:
--backup database TeamCity to disk = ‘c:\backups\MyBackup.bak’

--Solo tienes que poner ambos archivos en la misma carpeta y ejecutar el archivo batch a través del Programador de tareas de Windows. El primer archivo es solo un archivo batch de Windows que llama a la utilidad sqlcmd y pasa un archivo de script SQL. El archivo de script SQL contiene T-SQL. En mi ejemplo, solo es una línea para hacer una copia de seguridad de una base de datos, pero puedes poner cualquier T-SQL dentro.

--USE Nortwind
--BACKUP DATABASE Northwind
--TO DISK = N'C:\BackupConCodigo\Northwind.bak'
--WITH CHECKSUM;
--este comando es para hacer un backup a la base de datos Northwind de manera manual, con el job lo podemos hacer de manera automatica, pero la express edition, no se puede activar el sql agent

--AL FINAL DESCARGE EL SQL DEVELOPER Y PUDE HACERLO
-----------------------------------------------------------------------------------------------------------

--NOTA: DESCARGE EL SQL DEVELOPER 2022, ENTONCES QUIERA PASAR LA BASE DE DATOS NORTWIND QUE ESTABA EN EL SQL 2019 AL NUEVO, PARA HACERLO HICE LO SIGUIENTE:
--1. HICE BACKUP A LA BASE DATO NORTWIND (SQL 2019)
--2. CREA UNA BASE DE DATO LLAMADA NORTWIND (SQL 2022)
--3. HICE RESTORE EN LA BASE DE DATO NORTWIND (SQL 2022)
--4. PARA QUE NO DIERA ERROR, EN LA PARTE DE FILES TUVE QUE MARCAR LA CASILLA: RELOCATE ALL FILE TO FOLDER Y EN LA CASILLA DE OPCION LA DE WITH REPLACE

--ESTO LO PUEDE HACER TAMBIEN GENERANDO UN SCRIPT DE LA BD PERO Y PEGANDOLO EN LA NUEVA, PERO CREO QUE NO ES LO CORRECTO.

--CUANDO LO QUIZE HACER CON LA BD DE ADVENTUREWORKS2019 TUVE QUE CREAR UNA BASE DE DATOS (EN SQL 2022) CON UN NOMBRE DISTINTO AL QUE TENIA (EN SQL 2019). SI QUIERO QUE SEA ADVENTUREWORKS2019 SOLO TENGO QUE RENOMBRARLA CON ALT + CLICK
--NO ME PASO CON LA DE NORTWIND POR QUE (EN SQL 2019) SE LLAMA NORTHIWIND, Y (EN EL SQL 2022) LO CREO COMO NORTWIND.

--INTENTE HACER UN SCRIP DE ADVENTUREWORKS Y FUE MUY LENTO EN COMPARACION CON EL BACKUP, ENCIMA NO PUDE EJECUTAR EL SCRIPT PORQUE NO HABIA SUFICIENTE MEMORIA, ASI QUE PARA BASE DE DATOS COMPLEJAS ES MEJOR USAR EL BACKUP
--TAMBIEN PENSE EN EXPORTAR LA BASE DE DATOS, PERO VIENE SIENDO LO MISMO QUE GENERAR UN SCRIP
--------------------------------------------------------

--Con esto pude crear backup que se vaya acumulando con nombres diferentes, osea que si tengo una job que se ejecute cada dia, uno se llama Nortwind_231228, EL del dia 29 se llamara Nortwind_231229, ETC. LO DEJARE EJECUTANDO POR 5 DIAS. POR SI ACASO LE QUITE LOS COMENTARIOS.

--DECLARE @name VARCHAR(50) -- nombre de la base de datos
--DECLARE @path VARCHAR(256) -- ruta del archivo de backup
--DECLARE @fileName VARCHAR(256) -- nombre del archivo de backup
--DECLARE @fileDate VARCHAR(20) -- fecha actual

---- especificar el nombre de la base de datos
--SET @name = 'Nortwind'

---- especificar la ruta del archivo de backup
--SET @path = 'C:\BackupConCodigo\'

---- obtener la fecha actual con el formato YYYYMMDD
--SELECT @fileDate = REPLACE(CONVERT(VARCHAR(10), GETDATE(), 111), '/', '')

---- generar el nombre del archivo de backup con el formato PruebaBackupYYYYMMDD.bak
--SET @fileName = @path + 'Nortwind_' + @fileDate + '.bak'

---- hacer el backup de la base de datos con el nombre generado
--BACKUP DATABASE @name TO DISK = @fileName






--este es el mismo de arriba pero haciendo yo mismo. Nota convert es mas util para manejar tipo de datos estilo fechas, osea es mejor usarlo para estos caso que el el cast  
--DECLARE @name varchar(20)
--DECLARE @path varchar(100)
--DECLARE @FileName varchar(200);
--Declare @DateFile varchar(20);

--SET @name = 'Nortwind'

--SET @path = N'C:\BackupConCodigo\'

--SET @DateFile = REPLACE(CONVERT(Varchar(10), GETDATE(), 111), '/', '')

--SET @FileName = @path + 'Nortwind_' + @DateFile + '.bak'

--BACKUP DATABASE @name
--TO DISK = @FileName
--WITH CHECKSUM

--SELECT * FROM [dbo].[Employees]
--SELECT FORMAT(EmployeeID, '00000') --PARA QUE APAREZCA EL ID EN FORMA 00001, 00002, ETC.
--	  ,[LastName]
--      ,[FirstName]
--      ,[Title]
--      ,[Email]
--  FROM [Nortwind].[dbo].[Employees]

--NOTA: N' antes de una cadena de caracteres indica que la cadena es de tipo nvarchar en lugar de varchar