use AdventureWorks2016
go

CREATE PROCEDURE GetOrderTrackingForCustomer
    @StoreName varchar(50),
    @TrackingNumber varchar(25) OUTPUT
AS
BEGIN

    --declare variables
    DECLARE @SalesOrderID int;

    --Get Latest Sales Order Header
    SELECT TOP 1 @SalesOrderID = SOH.SalesOrderID
    FROM Sales.SalesOrderHeader SOH
        INNER JOIN Sales.Customer c ON SOH.CustomerID = c.CustomerID
        INNER JOIN Sales.Store s ON c.StoreID = s.BusinessEntityID
    WHERE s.Name = @StoreName
    ORDER BY SOH.OrderDate DESC

    IF @@ROWCOUNT > 0 --------------------------> 1ro se asegura q encuentra algo ***
	BEGIN
        	--Get Tracking Number -- Last Tracking Entry for Sales Order
        	SELECT TOP 1 @TrackingNumber = ISNULL(SOD.CarrierTrackingNumber, 'No Tracking Number for Store.')
        	FROM Sales.SalesOrderDetail SOD
        	WHERE SOD.SalesOrderID = @SalesOrderID
    	END
    ELSE BEGIN
        SET @TrackingNumber = 'Store Not Found.'
    END

END




-- Testing...
-- Test 1
-------------------------------------------
DECLARE @name varchar(25)
DECLARE @trackInfo varchar(50)
-------------------------------------------

set @name = 'Good Toys';
set @trackInfo = null;
exec GetOrderTrackingForCustomer @name, @trackInfo OUTPUT
Select 'Test 1',  @trackInfo


-- Test 2
set @name = 'Broken Toys'
set @trackInfo = null;
exec GetOrderTrackingForCustomer @name, @trackInfo OUTPUT
Select 'Test 2', @trackInfo
