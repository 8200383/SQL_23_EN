CREATE TRIGGER UPDATE_VARIANTS_COUNT_ON_PRODUCT_LINE
ON ProductLine
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    UPDATE Product
    SET VariantsCount = (
        SELECT COUNT(*)
        FROM ProductLine
        WHERE ProductID = Product.ProductID
    )
    FROM Product
    INNER JOIN deleted on deleted.ProductID = Product.ProductID;

    UPDATE Product
    SET VariantsCount = (
        SELECT COUNT(*)
        FROM ProductLine
        WHERE ProductID = Product.ProductID
    )
    FROM Product
    INNER JOIN inserted ON inserted.ProductID = Product.ProductID;
END;