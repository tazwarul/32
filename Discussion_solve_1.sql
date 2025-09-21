--Knowing the names of all the tables in a database. 
SELECT * FROM SYSOBJECTS
select name from sysobjects where xtype='U';
select name from sysobjects where xtype='S';

--Show all/specific records with all/ specific fields from a table . 
select *from authors; 
select au_lname , city from authors;

select *from authors where State='CA';
select *from authors where State='CA' and au_lname='white';

SELECT name AS TableName
FROM sys.tables
ORDER BY name;

--task-1-2--
select *from titles;
select title from titles where ytd_sales>=8000;
select title from titles where royalty <24 and royalty >12

--Showing ordered list 
select *from titles order by price;
select *from titles order by price desc;

-- Showing aggregate values within groups
SELECT MAX(PRICE) from TITLES
SELECT AVG(PRICE) from TITLES
SELECT  COUNT(PRICE) from TITLES; 
select min(price) from titles;

--Showing aggregate values within groups having some condition
select type,avg(price) from titles  group by type;
select type,max(price) from titles  group by type;

select type ,avg(price)  from titles group by type having avg(price)>15;

--task-3
SELECT TYPE, AVG(PRICE),SUM(YTD_SALES) FROM TITLES GROUP BY TYPE;

--Showing formatted string with customized header.
select "Name"=substring(au_fname,1,1)+ '.'+ au_lname,phone from authors;


---------------------------------------------------------
-----------------------Discussion-2----------------------
---------------------------------------------------------

------Joining Tables (Inner join] 
select * from authors;
select *from titles;
select *from titleauthor;
select *from publishers;
use pubs;
select au_lname,title_id from authors join titleauthor on authors.au_id=titleauthor.au_id;

----Task-1
select au_fname,title  from authors 
join titleauthor on authors.au_id=titleauthor.au_id
join titles on titleauthor.title_id=titles.title_id;

SELECT  title , au_fname  + ' '+ au_lname AS Author_Name FROM titles 
JOIN  titleauthor  ON titles.title_id = titleauthor.title_id 
JOIN authors  ON titleauthor.au_id = authors.au_id;

--task--2
select au_fname,title,pub_name from authors 
join titleauthor on authors.au_id=titleauthor.au_id
join titles on titleauthor.title_id=titles.title_id
join publishers on titles.pub_id=publishers.pub_id;

--Agger solve
select title ,au_fname + ' ' + au_lname as author_name,pub_name
from titles
join titleauthor on titles.title_id=titleauthor.title_id
join authors on titleauthor.au_id=authors.au_id
join publishers on titles.pub_id=publishers.pub_id;


----------------The Cartesian product -----------------
select au_lname,pub_name from authors,publishers;

-------Task-2--------
select au_fname,pub_name,publishers.city from authors  join publishers on authors.city=publishers.city;
--OR
select au_fname,pub_name,publishers.city from authors,publishers 
where authors.city=publishers.city;

------ Nested query-----
select *from titles where royalty=(select avg(royalty) from titles);

select title from titles where royalty=(select max(royalty))

-----------------Task-3-------------
------------------------------------
--IN use kore JUst Author name
SELECT au_fname, au_lname FROM authors
WHERE au_id IN (SELECT au_id FROM titleauthor 
WHERE title_id IN ( SELECT title_id FROM titles
WHERE royalty = (SELECT MAX(royalty) FROM titles)));
    ----IN chara JUST author name-----
SELECT au_fname FROM authors
JOIN titleauthor ON authors.au_id = titleauthor.au_id
JOIN titles ON titleauthor.title_id = titles.title_id
WHERE titles.royalty = (SELECT MAX(royalty) FROM titles);
--IN chara suthor name+book title
SELECT au_fname,title FROM authors
JOIN titleauthor ON authors.au_id = titleauthor.au_id
JOIN titles ON titleauthor.title_id = titles.title_id
WHERE titles.royalty = (SELECT MAX(royalty) FROM titles);


--------------------CREATING TABLE-------------------------

Create table customerandsupplier
(
cusl_id char(6) primary key check(cusl_id like '[cs][0-9][0-9][0-9][0-9][0-9]'),
cusl_fname char(15) NOT NULL,
cusl_lname char(15),
cusl_address text,
cusl_telno char(12) check(cusl_telno like '[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
cusl_city char(12) default 'Rajshahi',
sales_amnt money check (sales_amnt>=0),
proc_amnt money check (proc_amnt>=0)
)
select *from customerandsupplier;
--------INSERT VALUE-------
INSERT customerandsupplier 
(cusl_id,cusl_fname,cusl_lname,cusl_address,cusl_telno,cusl_city,sales_amnt,proc_amnt) 
VALUES ('C00001','Iqbal','Hossain','221/B Dhanmondi','017-00000000','Dhaka',0,0),
       ('S00002','Sohel','Ahamed','Pabna','018-70055653','babaria',1,3)


create table sitem
(
   item_id char(6) primary key check (item_id like '[P][0-9][0-9][0-9][0-9][0-9]'),
   item_name char(12),
   item_category char(10),
   item_price float(12) check (item_price>=0),
   item_qoh int check (item_qoh>=0),
   item_last_sold date default current_timestamp
)
insert into sitem(item_id ,item_name,item_category,item_price ,item_qoh ,item_last_sold)
values('P00009','tofail','phone',57.8,23,'3-2-15')


insert sitem(item_id ,item_name,item_category,item_price ,item_qoh )
values('P00002','tofail ah','laptop',56.8,23)

insert sitem(item_id ,item_name,item_category,item_price ,item_qoh )
values('P00003','uzzal','car',100.8,24)

insert sitem(item_id ,item_name,item_category,item_price ,item_qoh )
values('P00004','noamn','bus',200.8,25)

insert sitem(item_id ,item_name,item_category,item_price ,item_qoh )
values('P00005','mahim','track',300.8,27)

select * from sitem;

------delete operation
delete from sitem where item_id='P00005';
------update operation
update sitem set item_name='sohel' where item_id='P00003';


create table Transactions  
(   
    tran_id char(10) primary key check(tran_id like '[T][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	item_id char(6) foreign key references sitem(item_id),
	cusl_id char(6) foreign key references customerandsupplier(cusl_id),
	tran_type char(1),
	tran_quantity INT CHECK (tran_quantity >= 0),
	tran_date date default current_timestamp
)
drop table Transactions;
select * from Transactions;
select * from sitem;

select * from customerandsupplier;
INSERT INTO Transactions (tran_id, item_id, cusl_id, tran_type,tran_quantity)
VALUES ('T000000001', 'P00009', 'C00001', 'S', 100);



--==================DISCUSSION_3=====================--
-------------------------------------------------------
--=============Stored Procedure==============--
  create proc sp_showTitleAndAuthor
  as
  begin
  select "Authors Last Name"=au_lname from authors
  Where au_id in (select au_id from titleauthor where title_id='BU1032')
  end
  drop proc sp_showTitleAndAuthor
  sp_showTitleAndAuthor
  
  -------MOdify-------
  alter proc sp_showtitleauthor
  @titled char(16)
  as
  begin 
  select au_lname from authors where au_id in (select au_id from titleauthor where title_id=@titled)
  end
   sp_showtitleauthor 'BU1032'
   select *from authors;
   select *from titles;

   ---decision making and looping---
   create proc sp_updateprice
   @titled char(15)
   as 
   begin
   declare @prc money
   select @prc=price from titles where @titled=title_id
   set @prc=@prc+@prc*0.1
   if @prc<=20
   update titles set price=@prc  where title_id=@titled
   end
   drop proc sp_updateprice
   sp_updateprice 'BU1111'

   alter proc sp_updateprice
   @titled char(15)
   as 
   begin
   declare @prc money
   select @prc=price from titles where title_id=@titled
   set @prc=@prc+@prc*0.1
   if @prc<=20
   begin
   update titles set price=@prc  where title_id=@titled
   update titles set messag='Update' where title_id=@titled
   end
   else
   begin
   update titles set messag='NOT UPDATE' where title_id=@titled
   end
  end
   sp_updateprice 'BU2075'


   select * from titles
   alter table titles add messag text

   -------==========TASK-1==========------
   ---------------------------------------
   alter proc sp_showTitleAndAuthor
   as 
   begin 
   select 'Category'=item_category,
   'Total number of item'=sum(item_qoh),
   'Average price'=avg(item_price) 
   from sitem group by item_category
   end
   sp_showTitleAndAuthor
   -------==========TASK-2==========------
   ---------------------------------------
   alter proc sp_showTitleAndAuthor 
   @category_name char (15),
   @price_value money
   as 
   begin
   select *from sitem 
   where item_category=@category_name and @price_value<item_price
   end
   sp_showTitleAndAuthor 'laptop' ,54

   -------==========TASK-3==========------
   ---------------------------------------
   alter proc sp_showitem
   @category_name char(15),@desired_val money
   as
   begin
   declare @price money
   select @price=avg(item_price) from sitem where item_category=@category_name
   while @price<@desired_val
       begin
	      update sitem set item_price=item_price+item_price*.1 where item_category=@category_name
		  select  @price=avg(item_price) from sitem where  item_category = @category_name
		  end
   end
   sp_showitem 'bus',240
   select avg(item_price) from sitem where item_category='bus'
   select * from sitem

--==================DISCUSSION_4=====================--
-------------------------------------------------------
---------------------TRIGGER---------------------------

create trigger test_on on Transactions for insert
as 
begin 
   print 'Data inserted in Transactions table'
end

INSERT INTO Transactions (tran_id, item_id, cusl_id, tran_type,tran_quantity)
VALUES ('T000000002', 'P00004', 'S00002', 'S', 100);
select * from Transactions


create trigger tr_update_tran on Transactions for insert
as
begin
declare
   @item_id char(6),
   @tran_quan int,
   @tran_type char(1)

   select @item_id=item_id,@tran_quan=tran_quantity,  @tran_type=tran_type from inserted
   if (@tran_type='s')
       update sitem set item_qoh=item_qoh-@tran_quan where @item_id=item_id;

   else
      update sitem set item_qoh=item_qoh+@tran_quan where @item_id=item_id;
end

INSERT INTO Transactions (tran_id, item_id, cusl_id, tran_type,tran_quantity)
values ('T000000004', 'P00009', 'C00001', 'S', 3);
select* from sitem
select* from Transactions


------============Assignment=========-------
 ---Task 1: Write a trigger on Transaction that automatically updates the sold_amnt or proc_amnt field of
 --- CustomersAndSuppliers table whenever a transaction happens

CREATE TRIGGER UpdateCustomerAndSupplierAmounts
ON Transactions
AFTER INSERT
AS
BEGIN
    -- Declare variables to hold the calculated amounts
    DECLARE @Amount MONEY;
    DECLARE @TranType CHAR(1);
    DECLARE @CustomerID CHAR(6);
    DECLARE @ItemID CHAR(6);
    DECLARE @ItemPrice MONEY;

    -- Get the transaction details from the inserted row
    SELECT @TranType = tran_type,
           @CustomerID = cusl_id,
           @ItemID = item_id,
           @ItemPrice = item_price,
           @Amount = item_price * tran_quantity
    FROM inserted i
    JOIN sitem it ON i.item_id = it.item_id;

    -- Update the corresponding customer or supplier field based on the transaction type
    IF @TranType = 'c'  -- Customer transaction (Sales)
    BEGIN
        -- Update the sales amount for customers
        UPDATE customerandsupplier
        SET sales_amnt = sales_amnt + @Amount
        WHERE cusl_id = @CustomerID;
    END
    ELSE IF @TranType = 's'  -- Supplier transaction (Purchase)
    BEGIN
        -- Update the procurement amount for suppliers
        UPDATE customerandsupplier
        SET proc_amnt = proc_amnt + @Amount
        WHERE cusl_id = @CustomerID;
    END
END;

INSERT INTO Transactions (tran_id, item_id, cusl_id, tran_type, tran_quantity)
VALUES ('T000000004', 'P0002', 'C00002', 's', 10);

SELECT * FROM CustomerAndSupplier;




--===================================================--
------------13-Batch Question solve--------------------
--===================================================--
            --question-1(a)--
			
  select *from titles
   select *from authors
   select *from titleauthor
   select *from publishers
   select *from sales
   -- a. Show book title, author name (first initial + last name), publisher name
   select substring(au_fname,1,1)+'.'+au_lname,title,pub_name from authors 
   join titleauthor on authors.au_id=titleauthor.au_id
   join titles on titleauthor.title_id=titles.title_id
   join publishers on titles.pub_id=publishers.pub_id;

   -- b. Titles with total quantity sold > 40, sorted ascending
select title, sum(qty)  from titles join sales on titles.title_id = sales.title_id 
group by title having sum(qty) >40 
order by sum(qty) asc

    -- c. Stored Procedure to increase price until desired average
	create proc sp_updateitm 
	@category_nm char(10),
	@des_avg_val money
	as
	begin
	declare @price money
	select @price=avg(item_price) from sitem where item_category=@category_nm
	while @price<@des_avg_val
	  begin
	  update sitem set item_price=item_price*1.1 where  item_category=@category_nm
	  select @price=avg(item_price) from sitem where  item_category=@category_nm
	  end
    end
	select* from sitem;
	sp_updateitm 'phone',550

	--============SOLVE-2=============--
	------------------------------------
	create database GoldenBasket
	use GoldenBasket;

	create table Customers
	(
	  Customer_ID char(6) primary key check(Customer_ID like '[C][U][0-9][0-9][0-9][0-9]'),
	  Namee varchar(20) ,
	  Phone_Number varchar(15) check(Phone_Number like '[0][1][0-9]-[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	  Gender char(1)
	)
	insert into Customers
	values('CU0001','SOHEL','018-70055653','M');
	insert into Customers
	values('CU0002','AHAMED','019-70055652','M'),
	('CU0003','BIJOY','017-79358088','M');
	select *from Customers

	update Customers set Phone_Number='016-13057999' where Customer_ID='CU0003';

	create table Products
	(
	  Product_ID char(10) primary key check(Product_ID like '[P][R][0-9][0-9][0-9][0-9]'),
	  Product_Name varchar(20) ,
	  Price float(15),
	  Quantity_available int
	)
	insert into Products
	values('PR0001','Laptop','65000',25),
	('PR0002','Mobile','50000',20),
	('PR0003','Car','75000',30);
	select *from Products

	create table Purchases
	(
	 Purchases_ID int primary key,
	 Customer_ID char(6) foreign key references Customers(Customer_ID),
	 Product_ID char(10) foreign key references Products(Product_ID),
	 Enrollment_date date default getdate()
	 )
	 select *from Purchases
	 insert into Purchases(Purchases_ID,Customer_ID,Product_ID)
	 values (1001,'CU0001','PR0001'),
	 (1002,'CU0002','PR0002'),
	 (1003,'CU0003','PR0003');

	 ----(iii)-Apply trigger to update the Quantity_Available field of the table Products whenever a product is purchased.
	 create trigger sp_updatepurches on Purchases After insert
	 as
	 begin
	     update Products set Quantity_available=Quantity_available-1
	     where  Product_ID= (select Product_ID from inserted);
	 end

	INSERT INTO Purchases (Purchases_ID, Customer_ID, Product_ID)
    VALUES (1005, 'CU0003', 'PR0002');
	select *from Purchases
	select *from Products

