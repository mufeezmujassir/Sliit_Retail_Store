--CREATE PROCEDURE FOR THE DimProductCategory table

DROP PROCEDURE IF EXISTS dbo.UpdateDimProductCategory;
GO
CREATE PROCEDURE dbo.UpdateDimProductCategory
@ProductCategoryID INT,
@ProductCategoryName NVARCHAR(50),
@ModifiedDate datetime
As
BEGIN
	if not exists(SELECT ProductCategorySK from dbo.DimProductCategory
				  where AlternateProductCategoryID=@ProductCategoryID)
		BEGIN
			INSERT INTO dbo.DimProductCategory
			(AlternateProductCategoryID,ProductCategoryName,SrcModifiedDate,InsertDate,ModifiedDate)
			VALUES
			(@ProductCategoryID ,@ProductCategoryName,@ModifiedDate,GETDATE(),GETDATE())
		END;

	if exists (SELECT ProductCategorySK from dbo.DimProductCategory
				WHERE AlternateProductCategoryID=@ProductCategoryID)
		BEGIN 
			UPDATE dbo.DimProductCategory
			SET ProductCategoryName=@ProductCategoryName,
				SrcModifiedDate=@ModifiedDate,
				ModifiedDate=GETDATE()
			WHERE AlternateProductCategoryID=@ProductCategoryID
		END;
END;


--CREATE A Procedure for DimProductSubCategory table

DROP PROCEDURE IF EXISTS dbo.UpdateDimProductSubCategory;
GO

CREATE PROCEDURE dbo.UpdateDimProductSubCategory
@ProductSubCategoryID INT,
@ProductCategoryKey INT,
@ProductSubCategoryName NVARCHAR(50),
@ModifiedDate DATETIME
AS
BEGIN
	if not exists(SELECT ProductSubCategorySK FROM 
					dbo.DimProductSubCategory 
					Where alternateProductSubCategoryID=@ProductSubCategoryID)
		BEGIN
			insert into dbo.DimProductSubCategory(AlternateProductSubCategoryID,ProductCategoryKey,ProductSubCategoryName,SrcModifiedDate,InsertDate,ModifiedDate)
			values(@ProductSubCategoryID,@ProductCategoryKey,@ProductSubCategoryName,@ModifiedDate,GETDATE(),GETDATE())
		END;
	if exists(SELECT ProductSubCategorySK FROM dbo.DimProductSubCategory
				where AlternateProductSubCategoryID=@ProductSubCategoryID)
		BEGIN
			UPDATE dbo.DimProductSubCategory
				SET ProductCategoryKey=@ProductCategoryKey,ProductSubCategoryName=@ProductSubCategoryName,SrcModifiedDate=@ModifiedDate,ModifiedDate=GETDATE()
				where AlternateProductSubCategoryID=@ProductSubCategoryID
		END;
END;


--CREATE THE PROCEDURE FOR THE DimProduct table
DROP PROCEDURE IF EXISTS dbo.UpdateDimProduct
GO
CREATE PROCEDURE dbo.UpdateDimProduct
@ProductID INT,
@ProductName NVARCHAR(50),
@ProductNumber NVARCHAR(25),
@MakeFlag bit,
@FinishedGoodsFlag bit,
@Color NVARCHAR(15),
@SafetyStockLevel smallint, 
@ReorderPoint smallint, 
@StandardCost money, 
@ListPrice MONEY,
@Size NVARCHAR(5),
@SizeUnitMeasureCode NVARCHAR(3),
@Weight DECIMAL(8,2),
@WeightUnitMeasureCode NVARCHAR(3),
@ProductSubCategoryKey INT
AS
BEGIN
	if not exists (SELECT ProductSK from dbo.DimProduct where AlternateProductID=@ProductID)
	BEGIN
		INSERT INTO dbo.DimProduct(AlternateProductID, ProductName, ProductNumber, MakeFlag, FinishedGoodsFlag, Color, 
			SafetyStockLevel, ReorderPoint, StandardCost, ListPrice, Size, SizeUnitMeasureCode, [Weight], WeightUnitMeasureCode, 
			ProductSubCategoryKey, InsertDate, ModifiedDate)
		VALUES(@ProductID,@ProductName,@ProductNumber,@MakeFlag,@FinishedGoodsFlag,@Color,@SafetyStockLevel,@ReorderPoint,
				@StandardCost,@ListPrice,@Size,@SizeUnitMeasureCode,@Weight,@WeightUnitMeasureCode,@ProductSubCategoryKey,GETDATE(),GETDATE())
	END;

	if exists( SELECT ProductSK from dbo.DimProduct where AlternateProductID=@ProductID)
	BEGIN
		UPDATE dbo.DimProduct SET
		ProductName=@ProductName, ProductNumber=@ProductNumber, MakeFlag=@MakeFlag, FinishedGoodsFlag=@FinishedGoodsFlag, Color=@Color, 
			SafetyStockLevel=@SafetyStockLevel, ReorderPoint=@ReorderPoint, StandardCost=@StandardCost, ListPrice=@ListPrice, Size=@Size, SizeUnitMeasureCode=@SizeUnitMeasureCode,
			[Weight]=@Weight, WeightUnitMeasureCode=@WeightUnitMeasureCode, 
			ProductSubCategoryKey=@ProductSubCategoryKey, ModifiedDate=GETDATE()
		WHERE AlternateProductID=@ProductID
	END;
END;
