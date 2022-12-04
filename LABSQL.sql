--create database LAB78910

--use CNPM_final_project

create table Account (
	accountID varchar(255) not null,
	accountPassword varchar(255) not null,
	accountFirstName nvarchar(255) not null,
	accountLastName nvarchar(255) not null,
	accountEmail varchar(255) not null,
	accountPhone varchar(255) not null,
	accountAddress nvarchar (255) not null,
	constraint PK_accountID primary key(accountID)
)

insert into Account values ('ACCT1', '123','Nguyễn', 'Toàn', 'nguyenvantoan@gmail.com','111-222-333','123 Nguyễn Văn Cừ, F.1, Q.1, TPHCM')
insert into Account values ('ACCT2', '123','Nguyễn', 'Hoàng', 'nguyenhuyhoang@gmail.com','444-555-777','123 Nguyễn Khuyến, F.2, Q.2, HN')
insert into Account values ('STRMNGR1', '123','Hồ', 'Toàn', 'hovantoan@gmail.com','222-222-333','123 Nguyễn Bỉnh Khiêm, F.3, Q.3, TPHCM')
insert into Account values ('STRMNGR2', '123','Hồ', 'Huy', 'hovanhuy@gmail.com','333-222-333','123 Nguyễn Văn Cừ, F.4, Q.4, Đà Năng')
insert into Account values ('admin', 'admin','admin','admin','admin','admin','TPHCM')
select * from Account

create table Product (
	productID varchar(255) not null,
	productName nvarchar(255) not null,
	productPrice int not null,
	productQuantity int not null,
	productOrigin nvarchar(255) not null,
	constraint PK_productID primary key(productID)
)

insert into Product values ('PROD1','Workout Powder',30,1000,'USA')
insert into Product values ('PROD2','Workout Energy Bar',10,1500,'Germany')
insert into Product values ('PROD3','Static Energy Drink',20,1000,'Vietnam')
insert into Product values ('PROD4','Chicken Salad',40,1000,'China')
insert into Product values ('PROD5','Chicken Tortia',40,1000,'Mexico')
select * from Product

drop table Store
create table Store (
	storeID varchar(255) not null,
	storeName nvarchar(255) not null,
	storeLocation nvarchar(255) not null,
	taxValue int, 
	constraint PK_storeId primary key (storeID)
)
delete from Store
insert into Store values ('ST1', 'CITYGYM L1', '1 Ngo Quyen, F.1, Q.1, TPHCM', 10)
insert into Store values ('ST2', 'YOGA FITNESS', '2 Hoang Hoa Tham, F.1, Q.1, TPHCM', 15)
insert into Store values ('ST3', 'HOME GYM', '2 Nguyen Hue, F.1, Q.1, TPHCM', 5)
insert into Store values ('ST4', 'CITYGYM L2', '1 Pasteur, F.1, Q.1, TPHCM', 11)
insert into Store values ('ST5', 'CITYGYM L2', '1 Pasteur, F.1, Q.1, TPHCM', 8)
select * from Store

--import, bill, export (bill and export hòa làm 1)
drop table Import
create table Import (
	importID nvarchar(255) not null,
	constraint PK_importID primary key(importID),
	importTotalProduct int,
	importTotalPrice int,
	importCreated date,
	accountID varchar(255) not null,
	constraint FK_Import_Account_accountID foreign key(accountID) references Account(accountID)
)
--insert into Import values ('1', '1', '1', GETDATE(), 'admin')
--select * from Import
--delete from Import where importID = '1'
insert into Import values ('001', 10, 10, GETDATE(), 'ACCT1')
insert into Import values ('002', 10, 10, GETDATE(), 'ACCT1')

drop table ImportDetail
create table ImportDetail(
	importID nvarchar(255) not null,
	productID varchar(255) not null,

	--không cần thiết vì mình cũng sẽ phải add product trước r mới chạy được cái này
	productName nvarchar(255) not null,
	productPrice int not null,
	productQuantity int not null,
	productOrigin nvarchar(255) not null,
	primary key(importID, productID),

	constraint FK_ImportDetail_Import_importID foreign key(importID) references Import(importID),
	constraint FK_ImportDetail_Product_productID foreign key(productID) references Product(productID)
)
insert into ImportDetail values ('001', 'PROD1', 'A', 10, 10, 'USA')
insert into ImportDetail values ('001', 'PROD2', 'A', 10, 10, 'USA')
insert into ImportDetail values ('002', 'PROD2', 'A', 10, 10, 'USA')


delete from ImportDetail
delete from Import
select * from Import
select * from ImportDetail
select * from Product
delete from Product where productID = 'TSALAD-20'


create table PaymentMethod(
	paymentID varchar(255) not null,
	constraint PK_paymentID primary key(paymentID),
	paymentName char(255) not null,
)
insert into PaymentMethod values ('BNK', 'Banking')
insert into PaymentMethod values ('CSH', 'Cash')

create table Export (
	exportID nvarchar(255) not null,
	exportTotalProduct int,
	exportTotalPrice nvarchar(255), --nhớ có chiết khấu
	exportCreated date,
	exportStatus int,
	accountID varchar(255) not null,
	paymentID varchar(255) not null,
	storeID varchar(255) not null,

	constraint PK_exportID primary key(exportID),
	constraint FK_Export_Account_accountID foreign key(accountID) references Account(accountID),
	constraint FK_Export_PaymentMethod_paymentID foreign key (paymentID) references PaymentMethod(paymentID),
	constraint FK_Export_Store_storeID foreign key (storeID) references Store(storeID),
)
create table ExportDetail(
	exportID nvarchar(255) not null,
	productID varchar(255) not null,

	--không cần thiết vì mình cũng sẽ phải add product trước r mới chạy được cái này
	productName nvarchar(255) not null,
	productPrice int not null,
	productQuantity int not null,
	productOrigin nvarchar(255) not null,
	primary key(exportID, productID),
	constraint FK_ExportDetail_Export_exportID foreign key(exportID) references Export(exportID),
	constraint FK_ExportDetail_Product_productID foreign key(productID) references Product(productID)
)
drop table ExportDetail	
drop table Export
select * from PaymentMethod
select * from Export
select * from ExportDetail
