CREATE TRIGGER UPDATE_PRODUCT_COUNT_ON_COLLECTION_WHEN_INSERT_PRODUCT
ON Product
AFTER INSERT
AS
BEGIN
    UPDATE Collection
    SET Collection.ProductCount = Collection.ProductCount + 1
    FROM Collection
    INNER JOIN inserted ON Collection.CollectionID = inserted.CollectionID;
END;
