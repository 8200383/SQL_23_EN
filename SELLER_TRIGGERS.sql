-- TODO DECREASE STOCK WHEN A SALE IS MADE (CREATE)
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
        -- Rollback the transaction if necessary
        RETURN;
    END

    UPDATE ProductLine
    SET StandQuantity = StandQuantity - @quantitySold
    WHERE ProductLineID = @productLineID;
END;
-- TODO INCREASE SALES COUNT FOR A GIVEN SELLER (SAME TRIGGER AS ABOVE)
-- TODO ADD PURCHASES COUNT FOR CUSTOMERS AND A TRIGGER FOR IT
