INSERT INTO shop.dbo.Collection (Title, Gender, ProductCount) VALUES (N'Inverno', N'Men', 2);
INSERT INTO shop.dbo.Customer (FirstName, LastName, Gender, AddressLine1, AddressLine2, PostalCode, Country, Phone, Email, NIF) VALUES (N'ui', N'jn', N'Men', N'Right', N'Left', N'4610-812', N'PT', N'936291996', N'8200383@estg.ipp.pt', N'214523778');
INSERT INTO shop.dbo.Product (CollectionID, Title, Description, VariantsCount) VALUES (1, N'Saia dome', N'Saia curta dome', 2);
INSERT INTO shop.dbo.ProductLine (ProductID, Color, Size, WarehouseQuantity, DefectQuantity, StandQuantity, Stand, Price) VALUES (1, N'Rosa', N'L', 2, 1, 1, 9, 25.00);
INSERT INTO shop.dbo.Seller (FirstName, LastName, NIF, ShiftStart, ShiftEnd, SalesCount) VALUES (N'Sergio', N'Felix', N'261994905',N'10:30:00',N'16:30:00', 3);
INSERT INTO shop.dbo.Sale (SellerID, CustomerID, CreatedAt) VALUES (1, 1, N'2023-05-17');
INSERT INTO shop.dbo.SaleLine (SaleID, ProductLineID, Quantity) VALUES (1, 1, 1);
INSERT INTO shop.dbo.Defect (ProductLineID, CreatedBy) VALUES (1, 1)