CREATE VIEW dbo.Invoicing
AS
SELECT DATEPART(YEAR, CreatedAt)  AS year,
       DATEPART(MONTH, CreatedAt) AS month,
       SUM(Quantity)              AS Quantity,
       SUM(Quantity * Price)      as AmountMade
FROM Sale
         INNER JOIN SaleLine AS Line on Sale.SaleID = Line.SaleID
         INNER JOIN ProductLine AS P on P.ProductLineID = Line.ProductLineID
GROUP BY DATEPART(YEAR, CreatedAt), DATEPART(MONTH, CreatedAt)

CREATE VIEW InvoicingByDay
AS
SELECT DATEPART(YEAR, CreatedAt)  AS year,
       DATEPART(MONTH, CreatedAt) AS month,
       DATEPART(DAY, CreatedAt)   AS day,
       SUM(Quantity)              AS Quantity,
       SUM(Quantity * Price)      as AmountMade
FROM Sale
         INNER JOIN SaleLine AS Line on Sale.SaleID = Line.SaleID
         INNER JOIN ProductLine AS P on P.ProductLineID = Line.ProductLineID
GROUP BY DATEPART(YEAR, CreatedAt), DATEPART(MONTH, CreatedAt), DATEPART(DAY, CreatedAt)

CREATE VIEW InvoicingByWeek
AS
SELECT DATEPART(YEAR, CreatedAt) AS year,
       DATEPART(WEEK, CreatedAt) AS week,
       SUM(Quantity)             AS Quantity,
       SUM(Quantity * Price)     as AmountMade
FROM Sale
         INNER JOIN SaleLine AS Line on Sale.SaleID = Line.SaleID
         INNER JOIN ProductLine AS P on P.ProductLineID = Line.ProductLineID
GROUP BY DATEPART(YEAR, CreatedAt), DATEPART(WEEK, CreatedAt)

CREATE VIEW SalesByDay
AS
SELECT Product.Title,
       ProductLine.Color,
       ProductLine.Size,
       Sale.CreatedAt,
       SUM(SaleLine.Quantity) as Quantity
FROM Sale
         INNER JOIN SaleLine on Sale.SaleID = SaleLine.SaleID
         INNER JOIN ProductLine on ProductLine.ProductLineID = SaleLine.ProductLineID
         INNER JOIN Product on Product.ProductID = ProductLine.ProductID
GROUP BY Sale.CreatedAt, ProductLine.Size, ProductLine.Color, Product.Title

CREATE VIEW RevenueBySeller
AS
SELECT Seller.SellerID,
       CONCAT(Seller.FirstName, ' ', Seller.LastName) AS SellerName,
       MONTH(Sale.CreatedAt)                          as Month,
       YEAR(Sale.CreatedAt)                           as Year,
       SUM(SaleLine.Quantity)                         AS Quantity,
       SUM(SaleLine.Quantity * ProductLine.Price)     as Revenue
FROM Seller
         INNER JOIN Sale on Sale.SellerID = Seller.SellerID
         INNER JOIN SaleLine on Sale.SaleID = SaleLine.SaleID
         INNER JOIN ProductLine on ProductLine.ProductLineID = SaleLine.ProductLineID
GROUP BY Seller.SellerID, Sale.CreatedAt, Seller.FirstName, Seller.LastName
ORDER BY Sale.CreatedAt, Revenue DESC
OFFSET 0 ROWS

CREATE VIEW TopProducts
AS
SELECT ProductLine.ProductID,
       Product.Title,
       ProductLine.Size,
       ProductLine.Color,
       ProductLine.Price,
       SUM(SL.Quantity) AS Quantity
FROM ProductLine
         INNER JOIN Product on Product.ProductID = ProductLine.ProductID
         INNER JOIN SaleLine SL on ProductLine.ProductLineID = SL.ProductLineID
GROUP BY ProductLine.ProductID, ProductLine.Price, ProductLine.Color, ProductLine.Size, Product.Title
ORDER BY Quantity DESC
OFFSET 0 ROWS

CREATE VIEW DefectView
AS
SELECT DATEPART(YEAR, Defect.CreatedAt)                    AS Year,
       DATEPART(WEEK, Defect.CreatedAt)                    AS Week,
       Product.Title,
       Product.Description,
       SUM(ProductLine.DefectQuantity) AS Quantity,
       SUM(ProductLine.DefectQuantity * ProductLine.Price) AS Amount
FROM Defect
         INNER JOIN ProductLine ON ProductLine.ProductLineID = Defect.ProductLineID
         INNER JOIN Product ON Product.ProductID = ProductLine.ProductID
GROUP BY DATEPART(YEAR, Defect.CreatedAt) ,DATEPART(WEEK, Defect.CreatedAt), Product.Title, Product.Description;

CREATE VIEW Invoice
AS
SELECT Customer.NIF,
       Sale.SaleID,
       Product.Title,
       ProductLine.Color,
       ProductLine.Size,
       SUM(SaleLine.Quantity)                    as Quantity,
       SUM(SaleLine.Quantity * ProductLine.Price) as Amount
FROM Customer
         INNER JOIN Sale ON Sale.CustomerID = Customer.CustomerID
         INNER JOIN SaleLine ON SaleLine.SaleID = Sale.SaleID
         INNER JOIN ProductLine ON ProductLine.ProductLineID = SaleLine.ProductLineID
         INNER JOIN Product ON Product.ProductID = ProductLine.ProductID
GROUP by Customer.NIF, Sale.SaleID, Product.Title, ProductLine.Color, ProductLine.Size
