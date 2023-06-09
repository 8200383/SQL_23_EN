DROP TABLE IF EXISTS [dbo].[Defect]
DROP TABLE IF EXISTS [dbo].[SaleLine]
DROP TABLE IF EXISTS [dbo].[Sale]
DROP TABLE IF EXISTS [dbo].[ProductLine]
DROP TABLE IF EXISTS [dbo].[Product]
DROP TABLE IF EXISTS [dbo].[Collection]
DROP TABLE IF EXISTS [dbo].[Customer]
DROP TABLE IF EXISTS [dbo].[Seller]

CREATE TABLE [dbo].[Customer]
(
    CustomerID   INT IDENTITY (1,1) NOT NULL,
    FirstName    VARCHAR(25)        NOT NULL,
    LastName     VARCHAR(25)        NOT NULL,
    Gender       VARCHAR(10)        NOT NULL,
    AddressLine1 VARCHAR(100)       NOT NULL,
    AddressLine2 VARCHAR(100)       NOT NULL,
    PostalCode   VARCHAR(10)        NOT NULL,
    Country      VARCHAR(2)         NOT NULL,
    Phone        VARCHAR(9)         NOT NULL,
    Email        VARCHAR(50)        NOT NULL,
    NIF          VARCHAR(9)         NOT NULL,
    CONSTRAINT PK_Customers_CustomerID PRIMARY KEY CLUSTERED (CustomerID),
    CONSTRAINT CK_Customers_Gender CHECK (Gender IN ('Men', 'Woman', 'Other')),
    CONSTRAINT CK_Customers_Email CHECK (Email LIKE '%@%.%'),
    CONSTRAINT AK_Customers_Email UNIQUE (Email)
)

CREATE TABLE [dbo].[Collection]
(
    CollectionID INT IDENTITY (1,1) NOT NULL,
    Title        VARCHAR(25)        NOT NULL,
    Gender       VARCHAR(10)        NOT NULL,
    ProductCount INT,
    CONSTRAINT PK_Collections_CollectionID PRIMARY KEY CLUSTERED (CollectionID),
    CONSTRAINT CK_Collections_Gender CHECK (Gender IN ('Men', 'Woman', 'Child'))
)

CREATE TABLE [dbo].[Product]
(
    ProductID     INT IDENTITY (1,1) NOT NULL,
    CollectionID  INT                NOT NULL,
    Title         VARCHAR(25)        NOT NULL,
    Description   VARCHAR(100)       NULL,
    VariantsCount INT                NOT NULL DEFAULT 0,
    CONSTRAINT PK_Products_ProductID PRIMARY KEY CLUSTERED (ProductID),
    CONSTRAINT FK_Products_CollectionID FOREIGN KEY (CollectionID)
        REFERENCES Collection (CollectionID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
)

CREATE TABLE [dbo].[ProductLine]
(
    ProductLineID     INT IDENTITY (1,1) NOT NULL,
    ProductID         INT                NOT NULL,
    Color             VARCHAR(15)        NOT NULL,
    Size              VARCHAR(2)         NOT NULL,
    WarehouseQuantity INT                NOT NULL DEFAULT 0,
    DefectQuantity    INT                NOT NULL DEFAULT 0,
    StandQuantity     INT                NOT NULL DEFAULT 0,
    Stand             INT                NOT NULL,
    Price             DECIMAL(10, 2)     NOT NULL DEFAULT 0,
    CONSTRAINT CK_Stand CHECK (Stand BETWEEN 1 AND 10),
    CONSTRAINT CK_ProductLines_Size CHECK (Size IN ('XS', 'S', 'M', 'L', 'XL')),
    CONSTRAINT PK_ProductLines_ProductLineID PRIMARY KEY CLUSTERED (ProductLineID),
    CONSTRAINT FK_ProductLines_ProductID FOREIGN KEY (ProductID)
        REFERENCES Product (ProductID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
)

CREATE TABLE [dbo].[Seller]
(
    SellerID   INT IDENTITY (1,1) NOT NULL,
    FirstName  VARCHAR(25)        NOT NULL,
    LastName   VARCHAR(25)        NOT NULL,
    NIF        VARCHAR(9)         NOT NULL UNIQUE,
    SalesCount INT                NOT NULL,
    ShiftStart TIME(0)            NOT NULL DEFAULT '10:00:00',
    ShiftEnd   TIME(0)            NOT NULL DEFAULT '22:00:00',
    CONSTRAINT PK_Sellers_SellerID PRIMARY KEY CLUSTERED (SellerID),
    CONSTRAINT CK_Shift_Shop CHECK (DATEPART(HOUR, ShiftStart) >= 10 AND DATEPART(HOUR, ShiftEnd) <= 22),
    CONSTRAINT CK_Shift_Duration CHECK (DATEDIFF(HOUR, ShiftStart, ShiftEnd) >= 6)
)

CREATE TABLE [dbo].[Sale]
(
    SaleID     INT IDENTITY (1,1) NOT NULL,
    SellerID   INT                NOT NULL,
    CustomerID INT                NOT NULL,
    CreatedAt  DATE               NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_Sales_SaleID PRIMARY KEY CLUSTERED (SaleID),
    CONSTRAINT FK_Sales_SellerID FOREIGN KEY (SellerID)
        REFERENCES Seller (SellerID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT FK_Sales_CustomerID FOREIGN KEY (CustomerID)
        REFERENCES Customer (CustomerID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
)

CREATE TABLE [dbo].[SaleLine]
(
    SaleLineID    INT IDENTITY (1,1) NOT NULL,
    SaleID        INT                NOT NULL,
    ProductLineID INT                NOT NULL,
    Quantity      INT                NOT NULL,
    CONSTRAINT PK_SaleLines_SaleLineID PRIMARY KEY CLUSTERED (SaleLineID),
    CONSTRAINT FK_SaleLines_SaleID FOREIGN KEY (SaleID)
        REFERENCES Sale (SaleId)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT FK_SaleLines_ProductLineID FOREIGN KEY (ProductLineID)
        REFERENCES ProductLine (ProductLineID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
)

CREATE TABLE [dbo].[Defect]
(
    DefectID      INT IDENTITY (1,1) NOT NULL,
    ProductLineID INT                NOT NULL,
    CreatedAt     DATETIME           NOT NULL DEFAULT GETDATE(),
    CreatedBy     INT                NOT NULL,
    CONSTRAINT PK_Defects_SaleLineID PRIMARY KEY CLUSTERED (DefectID),
    CONSTRAINT FK_Defects_ProductLineID FOREIGN KEY (ProductLineID)
        REFERENCES ProductLine (ProductLineID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT FK_Defects_CreatedBy FOREIGN KEY (CreatedBy)
        REFERENCES Seller (SellerID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
)