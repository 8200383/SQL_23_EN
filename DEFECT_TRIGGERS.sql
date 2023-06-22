CREATE TRIGGER UPDATE_STOCK_WHEN_INSERT_DEFECT
    ON Defect
    AFTER INSERT
    AS
BEGIN
    UPDATE ProductLine
    SET StandQuantity = StandQuantity - 1,
        DefectQuantity = DefectQuantity + 1
    WHERE ProductLineID IN (SELECT ProductLineID FROM inserted)
END;
