use Shop

CREATE TRIGGER LockAdminInserting ON dbo.users --Нельзя добавлять новых администраторов
	AFTER INSERT, UPDATE
	AS

	IF EXISTS (SELECT *
				FROM inserted 
				WHERE inserted.id_userStatus = 0)
	BEGIN
	PRINT 'adding new administrators is prohibited'
	ROLLBACK TRAN
	END
GO


alter table users
   add constraint PK_USERS_UNIQUE UNIQUE (mail)
go

--done
CREATE PROCEDURE SelectProduct --Выбрать информацию для конкретного товара
	@IdProd INT
	AS
SELECT productCatalog.id_productCatalog, productCatalog.name, productCatalog.description, productCatalog.img, featureName.name, featureValue.value
FROM (featureValue INNER JOIN productCatalog 
ON featureValue.id_productCatalog = productCatalog.id_productCatalog) INNER JOIN featureName 
ON featureName.id_featureName = featureValue.id_featureName
WHERE productCatalog.id_productCatalog = @IdProd

EXEC SelectProduct 0 

--done
CREATE PROCEDURE AddNewOrder --Добавить заказ
	@status INT,
	@user INT,
	@product INT,
	@count int
	AS
INSERT INTO [order]
           ([id_orderStatus]
           ,[id_user]
           ,[id_productCatalog]
           ,[countProducts])
     VALUES (@status,@user,@product,@count)

	

EXEC AddNewOrder 0,0,4,1

--done
CREATE PROCEDURE AddNewUser --Добавить пользователя
	@status INT,
	@fullname varchar(100),
	@mail varchar(100),
	@telephone varchar(20),
	@address varchar(200),
	@password varchar(100)
	AS
INSERT INTO [users]
           ([id_userStatus]
           ,[fullname]
           ,[mail]
           ,[telephone]
           ,[address]
           ,[password])
     VALUES (@status,@fullname,@mail,@telephone,@address,@password)
GO

--done
CREATE PROCEDURE SelectProductList --Все товары для каталога
	AS
	SELECT productCatalog.id_productCatalog, productCatalog.name,productCatalog.description,productCatalog.img,productCatalog.price
	FROM productCatalog
GO

EXEC SelectProductList

CREATE PROCEDURE AddComment --Добавить комментарий
@user INT,
@product INT,
@comment TEXT
AS
INSERT INTO [comment]
           ([id_user]
           ,[id_productCatalog]
           ,[textComment])
     VALUES (@user,@product,@comment)
GO

-- done
CREATE PROCEDURE SelectOrdersForAdmin --Все заказы для таблицы админа
AS
SELECT [users].mail,[users].telephone,[productCatalog].name,[productCatalog].price,[order].countProducts,([productCatalog].price * [order].countProducts) AS 'total cost', [orderStatus].nameOrderStatus
FROM (([order] INNER JOIN [orderStatus] 
ON [order].id_orderStatus = [orderStatus].id_orderStatus) INNER JOIN [users]
ON [users].id_user = [order].id_user) INNER JOIN [productCatalog]
ON [productCatalog].id_productCatalog = [order].id_productCatalog
GO

-- done
CREATE PROCEDURE SelectOrdersForUser --Все заказы пользователя
@user INT
AS
SELECT [productCatalog].name,[productCatalog].price,[order].countProducts,([productCatalog].price * [order].countProducts) AS 'total cost', [orderStatus].nameOrderStatus
FROM ([order] INNER JOIN [orderStatus] 
ON [order].id_orderStatus = [orderStatus].id_orderStatus) INNER JOIN [productCatalog]
ON [productCatalog].id_productCatalog = [order].id_productCatalog
WHERE [order].id_user = @user
GO

EXEC SelectOrdersForUser 2

CREATE PROCEDURE SelectCommentForProduct --Комментарии для конкретного продукта
@idProd INT
AS
SELECT [users].mail,[comment].textComment
FROM [comment] INNER JOIN [users]
ON [comment].id_user = [users].id_user
WHERE [comment].id_productCatalog = @idProd
GO