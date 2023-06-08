CREATE TRIGGER UPDATE_PRODUCT_COUNT_ON_COLLECTION
ON Product
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    UPDATE Collection
    SET ProductCount = (
        SELECT COUNT(*)
        FROM Product
        WHERE CollectionID = Collection.CollectionID
    )
    FROM Collection
    INNER JOIN deleted ON deleted.CollectionID = Collection.CollectionID;

    UPDATE Collection
    SET ProductCount = (
        SELECT COUNT(*)
        FROM Product
        WHERE CollectionID = Collection.CollectionID
    )
    FROM Collection
    INNER JOIN inserted ON inserted.CollectionID = Collection.CollectionID;
END;