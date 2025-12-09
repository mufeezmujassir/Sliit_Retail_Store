---DDL Command

--CREATE THE DimProductCategory table

IF OBJECT_ID('dbo.DimProductCategory','U') IS NOT NULL
	DROP TABLE dbo.DimProductCategory
CREATE TABLE dbo.DimProductCategory
(
    ProductCategorySK INT IDENTITY(1,1) PRIMARY KEY,
    AlternateProductCategoryID INT,
    ProductCategoryName NVARCHAR(50),
    SrcModifiedDate DATETIME,
    InsertDate DATETIME,
    ModifiedDate DATETIME
);

--CREATE THE DimProductSubCategory 
if OBJECT_ID('dbo.DimProductSubCategory','U') IS NOT NULL
	DROP TABLE dbo.DimProductSubCategory

CREATE TABLE dbo.DimProductSubCategory
(
	ProductSubCategorySK INT IDENTITY(1,1) PRIMARY KEY,
	AlternateProductSubCategoryID INT NOT NULL,
	ProductCategoryKey INT,
	ProductSubCategoryName NVARCHAR(50),
	SrcModifiedDate DATETIME,
	InsertDate DATETIME,
	ModifiedDate DATETIME,

	CONSTRAINT fk_productCategory FOREIGN KEY (ProductCategoryKey)
		REFERENCES dbo.DimProductCategory(ProductCategorySK)
)

---CREATE THE DimProductTable

IF OBJECT_ID('dbo.DimProduct','U') IS NOT NULL
	DROP TABLE dbo.DimProduct


CREATE TABLE dbo.DimProduct(
	ProductSK INT IDENTITY(1,1) PRIMARY KEY,
	AlternateProductID INT,
	ProductName NVARCHAR(50),
	ProductNumber NVARCHAR(25),
	MakeFlag bit,
	FinishedGoodsFlag bit,
	Color NVARCHAR(15),
	SafetyStockLevel smallint, 
	ReorderPoint smallint, 
	StandardCost money, 
	ListPrice MONEY,
	Size NVARCHAR(5),
	SizeUnitMeasureCode NVARCHAR(3),
	Weight DECIMAL(8,2),
	WeightUnitMeasureCode NVARCHAR(3),
	ProductSubCategoryKey INT,
	InsertDate DATETIME, 
	ModifiedDate DATETIME

	CONSTRAINT FK_Product_subcategory FOREIGN KEY(ProductSubCategoryKey)
		REFERENCES dbo.DimProductSubCategory(ProductSubCategorySK)
    
)
--CREATE THE DimCustomerTable


IF OBJECT_ID('dbo.DimCustomer','U') IS NOT NULL
	DROP TABLE dbo.DimCustomer
create table DimCustomer(
	CustomerSK int identity(1,1) primary key,
	AlternateCustomerID int,
	Title	nvarchar(8),
	FirstName	nvarchar(50),
	MiddleName 	nvarchar(50),
	LastName	nvarchar(50),
	Gender	nvarchar(1),
	PhoneNumber	nvarchar(25),
	PhoneNumberType	nvarchar(50),
	EmailAddress	nvarchar(50),
	EmailPromotion	int,
	AddressType	nvarchar(50),
	AddressLine1	nvarchar(60),
	AddressLine2	nvarchar(60),
	City	nvarchar(30),
	StateProvinceName	nvarchar(50),
	PostalCode	nvarchar(15),
	CountryRegionGroup	nvarchar(50),
	StartDate	datetime,
	EndDate		datetime,
	InsertDate datetime, 
	ModifiedDate datetime
)

--CREATE THE DimSalesTerritory

IF OBJECT_ID('dbo.DimSalesTerritory','U') IS NOT NULL
	DROP TABLE dbo.DimSalesTerritory


CREATE TABLE dbo.DimSalesTerritory(
	TerritoryKey INT IDENTITY(1,1) PRIMARY KEY,
	TerritoryID INT NOT NULL,
	TerritoryName NVARCHAR(50),
	CountryRegionCode NVARCHAR(3),
	RegionGroup NVARCHAR(50),
	CreatedDate DATETIME DEFAULT GETDATE(),
	ModifiedDate DATETIME DEFAULT GETDATE()
)

--CREATE THE DimSalesPerson

IF OBJECT_ID('dbo.DimSalesPerson','U') IS NOT NULL
	DROP TABLE dbo.DimSalesPerson


CREATE TABLE dbo.DimSalesPerson(
	SalesPersonKey INT IDENTITY(1,1) PRIMARY KEY,
	BusinessEntityID INT NOT NULL,
	TerritoryKey INT NOT NULL, --Foreign key of the DimSalesTerritory
	CreatedDate DATETIME DEFAULT GETDATE(),
	ModifiedDate DATETIME DEFAULT GETDATE(),
	CONSTRAINT DMSalesTerritoy FOREIGN KEY(TerritoryKey)
		REFERENCES dbo.DimSalesTerritory(TerritoryKey)

)


--Create the Fact table



--CREATE FactSalesOrder
drop table if exists FactSales;
create table FactSales(
	SalesOrderID	int,

	OrderDateKey int foreign key references DimDate(DateKey),
	DueDateKey	int foreign key references DimDate(DateKey),
	ShipDateKey	int foreign key references DimDate(DateKey),

	SalesOrderNumber	nvarchar(25),
	PurchaseOrderNumber	nvarchar(25),
    CustomerKey	int foreign key references DimCustomer(CustomerSK),
    SalesOrderDetailID int,
    ProductKey 	int foreign key references DimProduct(ProductSK),
	CarrierTrackingNumber nvarchar(25),
    AccountNumber	nvarchar(15),
    SubTotal	money,
	TaxAmt	money,
	Freight	money,
	TotalDue	money,
	OrderQty	int,
	UnitPrice	money,
	UnitPriceDiscount money,
	LineTotal numeric(38,6),
    RemainingPayment AS (TotalDue - SubTotal) PERSISTED,
    TotalCostPerItem AS ((UnitPrice * OrderQty) - (UnitPriceDiscount * OrderQty)) PERSISTED,
    TotalUnitCostWithTaxFreight AS ((UnitPrice * OrderQty) + TaxAmt + Freight) PERSISTED,
    TotalUnitCostBeforeTaxFreight AS (UnitPrice * OrderQty) PERSISTED,
	SrcHeaderModifiedDate datetime,
	SrcDetailModifiedDate datetime,
	InsertDate datetime,
	ModifiedDate datetime
)
--Drop the column in foreign key constraint

ALTER TABLE dbo.FactSalesOrderDetail
DROP CONSTRAINT FK_Product;

ALTER TABLE dbo.FactSalesOrderDetail drop column ProductKey
ALTER TABLE dbo.FactSalesOrderHeader drop Constraint FK_CustomerKey
ALTER TABLE dbo.FactSalesOrderHeader drop column [CustomerKey]
ALTER TABLE dbo.DimProductSubCategory DROP CONSTRAINT fk_productCategory;
ALTER TABLE dbo.DimProduct drop CONSTRAINT FK_Product_subcategory
