/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2008                    */
/* Created on:     16.04.2018 16:19:38                          */
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
   featureName          varchar(1
   00)         null
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
   featureValue         varchar(100)         null
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
   countProducts        int                  null
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
   nameOrderStatus      varchar(100)         null
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
   productName          varchar(100)         null,
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
   productStatus        varchar(100)         null
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
   nameTypeOfGoods      varchar(100)         null
)
go

alter table typeOfGoods
   add constraint PK_TYPEOFGOODS primary key nonclustered (id_typeOfGoods)
go

/*==============================================================*/
/* Table: userStatus                                            */
/*==============================================================*/
create table userStatus (
   id_userStatus        int                  not null,
   nameUserStatus       varchar(100)         null
)
go

alter table userStatus
   add constraint PK_USERSTATUS primary key nonclustered (id_userStatus)
go

use ShopTest

/*==============================================================*/
/* Table: users                                                 */
/*==============================================================*/
create table users (
   id_user              int                  not null,
   id_userStatus        int                  null,
   FullName             varchar(100)         null,
   mail                 varchar(100)         null,
   telephone            int                  null,
   adress               varchar(200)         null,
   password             varchar(100)         null
)
go

alter table users
   add constraint PK_USERS primary key nonclustered (id_user)
go

