CREATE TRIGGER UPDATE_PRODUCT_COUNT_ON_COLLECTION_WHEN_INSERT_PRODUCT
ON Product
AFTER INSERT, DELETE
AS
BEGIN
    UPDATE Collection
    SET ProductCount = (
        SELECT COUNT(*)
        FROM Product
        WHERE CollectionID = Collection.CollectionID
    )
    WHERE CollectionID IN (
        SELECT CollectionID
        FROM inserted
        UNION
        SELECT CollectionID
        FROM deleted
    );
END;
