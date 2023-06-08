CREATE TRIGGER UPDATE_PRODUCT_COUNT_ON_COLLECTION_WHEN_INSERT_PRODUCT
ON Product
AFTER INSERT
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
    );
END;

CREATE TRIGGER UPDATE_PRODUCT_COUNT_ON_COLLECTION_WHEN_DELETE_PRODUCT
ON Product
AFTER DELETE
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
        FROM deleted
    );
END;

CREATE TRIGGER UPDATE_PRODUCT_COUNT_ON_COLLECTION_WHEN_UPDATE
ON Product
AFTER UPDATE
AS
BEGIN
    -- Update product count for source collection
    UPDATE Collection
    SET ProductCount = (
        SELECT COUNT(*)
        FROM Product
        WHERE CollectionID = Collection.CollectionID
    )
    FROM Collection
    INNER JOIN deleted ON deleted.CollectionID = Collection.CollectionID;

    -- Update product count for destination collection
    UPDATE Collection
    SET ProductCount = (
        SELECT COUNT(*)
        FROM Product
        WHERE CollectionID = Collection.CollectionID
    )
    FROM Collection
    INNER JOIN inserted ON inserted.CollectionID = Collection.CollectionID;
END;