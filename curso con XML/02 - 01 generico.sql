
-- crear procedimiento que recibe data en xml y saca todo el product data

DECLARE @xml XML

SET @xml =	'<root>
				<Item ProductNumber="CA-5965" SafetyStock ="500" >321231231 </Item> 
				<Item ProductNumber="CB-2903" SafetyStock ="1000" ></Item>
				<Item ProductNumber="BE-2349" SafetyStock ="800" ></Item>
				<Item ProductNumber="AR-5381" SafetyStock ="1000" ></Item>
			</root>'


SELECT	Tab.Col.value('@ProductNumber', 'NVARCHAR(10)') AS ProductNumber,
		Tab.Col.value('@SafetyStock', 'INT') AS SafetyStock
FROM @xml.nodes('root/Item') AS Tab(Col);


--ProductNumber	SafetyStock
--	CA-5965			500
--	CB-2903			1000
--	BE-2349			800
--	AR-5381			1000