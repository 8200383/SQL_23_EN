INSERT INTO shop.dbo.Collection (CollectionID, Title, Gender, ProductCount) VALUES (1, N'Inverno', N'Male', 2);
INSERT INTO shop.dbo.Customer (CustomerID, FirstName, LastName, Gender, AddressLine1, AddressLine2, PostalCode, Country, Phone, Email, NIF) VALUES (1, N'ui', N'jn', N'Male', N'jkh', N'kjh', N'4610-812', N'PT', N'936291996', N'8200383@estg.ipp.pt', N'214523778');
INSERT INTO shop.dbo.Product (ProductID, CollectionID, Title, Description, VariantsCount) VALUES (2, 1, N'Saia dome', N'Saia curta dome', 2);
INSERT INTO shop.dbo.ProductLine (ProductLineID, ProductID, Color, Size, WarehouseCount, FaultyCount, ShopCount, Price) VALUES (1, 2, N'Rosa', N'L', 2, 1, 1, 25.00);
INSERT INTO shop.dbo.Report (ReportID, ProductLineID, SellerID, Quantity, Description) VALUES (1, 1, 1, 1, N'Miguel FDP');
INSERT INTO shop.dbo.Sale (SaleID, SellerID, CustomerID, CreatedAt) VALUES (1, 1, 1, N'2023-05-17');
INSERT INTO shop.dbo.SaleLine (SaleLineID, SaleID, ProductLineID, Quantity) VALUES (1, 1, 1, 1);
INSERT INTO shop.dbo.Seller (SellerID, FirstName, LastName, NIF, SalesCount) VALUES (1, N'Sergio', N'Felix', N'261994905', 3);
