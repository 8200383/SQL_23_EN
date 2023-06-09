CREATE TRIGGER DECREASE_STOCK_WHEN_SALE_MADE
ON SaleLine
AFTER INSERT
AS
BEGIN
    DECLARE @quantitySold INT;
    DECLARE @productLineID INT;
    DECLARE @availableQuantity INT;

    SELECT TOP 1 @quantitySold = Quantity, @productLineID = ProductLineID FROM inserted;

    SELECT @availableQuantity = StandQuantity FROM ProductLine WHERE ProductLineID = @productLineID;

    IF (@quantitySold > @availableQuantity)
    BEGIN
        -- Raise an error or handle the restriction as per your requirements
        RAISERROR ('Quantity to be sold exceeds available quantity.', 16, 1);
        RETURN;
    END

    UPDATE ProductLine
    SET StandQuantity = StandQuantity - @quantitySold
    WHERE ProductLineID = @productLineID;
END;

CREATE TRIGGER INCREASE_PURCHASES_COUNT_WHEN_SALE_MADE
ON Sale
AFTER INSERT
AS
BEGIN
    UPDATE Customer
    SET PurchasesCount = PurchasesCount + 1
    WHERE Customer.CustomerID IN (
        SELECT DISTINCT Orders.CustomerID
        FROM Orders
        INNER JOIN inserted ON Orders.OrderID = inserted.OrderID
    );
END;

-- TODO INCREASE SALES COUNT FOR A GIVEN SELLER (SAME TRIGGER AS ABOVE)
