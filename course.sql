use "ShopTest";

/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2008                    */
/* Created on:     09.04.2018 19:59:08                          */
/*==============================================================*/


/*==============================================================*/
/* Table: comment                                               */
/*==============================================================*/
create table comment (
   id_comment           int                  not null,
   id_user              int                  null,
   id_productCatalog    int                  null,
   textComment          text                 null
)
go

alter table comment
   add constraint PK_COMMENT primary key nonclustered (id_comment)
go

/*==============================================================*/
/* Table: featureName                                           */
/*==============================================================*/
create table featureName (
   id_featureName       int                  not null,
   id_typeOfGoods       int                  not null,
   featureName          text                 null
)
go

alter table featureName
   add constraint PK_FEATURENAME primary key nonclustered (id_featureName)
go

/*==============================================================*/
/* Table: featureValue                                          */
/*==============================================================*/
create table featureValue (
   id_featureValue      int                  not null,
   id_featureName       int                  not null,
   id_productCatalog    int                  not null,
   featureValue         text                 null
)
go

alter table featureValue
   add constraint PK_FEATUREVALUE primary key nonclustered (id_featureValue)
go

/*==============================================================*/
/* Table: "order"                                               */
/*==============================================================*/
create table "order" (
   id_order             int                  not null,
   id_orderStatus       int                  null,
   id_user              int                  null,
   id_productCatalog    int                  null,
   count                int                  null
)
go

alter table "order"
   add constraint PK_ORDER primary key nonclustered (id_order)
go

/*==============================================================*/
/* Table: orderStatus                                           */
/*==============================================================*/
create table orderStatus (
   id_orderStatus       int                  not null,
   nameOrderStatus      text                 null
)
go

alter table orderStatus
   add constraint PK_ORDERSTATUS primary key nonclustered (id_orderStatus)
go

/*==============================================================*/
/* Table: productCatalog                                        */
/*==============================================================*/
create table productCatalog (
   id_productCatalog    int                  not null,
   id_typeOfGoods       int                  not null,
   id_productStatus     int                  null,
   productName          text                 null,
   productDescription   text                 null,
   price                int                  null
)
go

alter table productCatalog
   add constraint PK_PRODUCTCATALOG primary key nonclustered (id_productCatalog)
go

/*==============================================================*/
/* Table: productStatus                                         */
/*==============================================================*/
create table productStatus (
   id_productStatus     int                  not null,
   productStatus        text                 null
)
go

alter table productStatus
   add constraint PK_PRODUCTSTATUS primary key nonclustered (id_productStatus)
go

/*==============================================================*/
/* Table: typeOfGoods                                           */
/*==============================================================*/
create table typeOfGoods (
   id_typeOfGoods       int                  not null,
   nameTypeOfGoods      text                 null
)
go

alter table typeOfGoods
   add constraint PK_TYPEOFGOODS primary key nonclustered (id_typeOfGoods)
go

/*==============================================================*/
/* Table: "user"                                                */
/*==============================================================*/
create table usersTest (
   id_user              int                  not null,
   id_userStatus        int                  null,
   FIO                  text                 null,
   mail                 text                 null,
   telephone            int                  null,
   adress               text                 null
)
go

alter table usersTest
   add constraint PK_USER primary key nonclustered (id_user)
go

/*==============================================================*/
/* Table: userStatus                                            */
/*==============================================================*/
create table userStatus (
   id_userStatus        int                  not null,
   nameUserStatus       text                 null
)
go

alter table userStatus
   add constraint PK_USERSTATUS primary key nonclustered (id_userStatus)
go

use ShopTest

INSERT INTO usersTest 
	SET = 5, `id_userStatus` = 5, `FIO` = 'testFio', `mail` = 'testmanual@test.com', `telephone` = 123, `adress` = 'testaddress'

INSERT INTO usersTest VALUES (5, 5, 'testfio', 'test@mail.ru', 123, 'testaddress')

INSERT INTO usersTest VALUES (12, 9, 'node', 'test@mail.ru', 123, 'testaddress')
INSERT INTO usersTest VALUES (100, 9, 'node', 'test@mail.ru', 123, 'testaddress')