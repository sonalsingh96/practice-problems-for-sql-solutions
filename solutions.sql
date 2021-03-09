--ques1--
select * from Shippers

----ques2--
select CategoryName,Description from Categories

--ques3--
select FirstName,LastName,HireDate from Employees
where Title = 'Sales Representative'

--ques4--
select FirstName,LastName,HireDate from Employees
where Title = 'Sales Representative' and Country = 'USA'

--ques5--
select OrderID,OrderDate from Orders
where EmployeeID =5

--ques6--
select SupplierID,ContactName,ContactTitle from Suppliers 
where ContactTitle  ! = 'Marketing Manager'

--ques7--
Select ProductID,ProductName from Products
where ProductName like '%queso%'

--ques8--
Select OrderID,CustomerID,ShipCountry from Orders
where ShipCountry='Belgium' or ShipCountry ='France'

--ques9--
Select OrderID,CustomerID,ShipCountry from Orders
where ShipCountry in ('Brazil','Mexico','Argentina','Venezuela','Belgium','France')

--ques10--
Select FirstName,LastName,BirthDate,Title from Employees
order by BirthDate asc



--ques11--
Select FirstName,LastName,cast(BirthDate as date)as Birthdate,Title from Employees
order by BirthDate asc

---ques 12---
Select FirstName,LastName, FirstName+ ' ' +LastName from Employees

--quest13--
Select OrderID,ProductID,UnitPrice,Quantity,UnitPrice*Quantity as TotalPrice  from OrderDetails
order by OrderId,ProductID 

---ques14--
select COUNT(distinct CustomerID)  from Customers

---ques15--
select top(1)  OrderID,OrderDate from Orders
order by OrderDate asc 

--ques 16---
select distinct Country from Customers

--ques17--
select ContactTitle, Count(ContactTitle) as CountofeachContact from Customers
group by ContactTitle

--Ques18--
select ProductID,ProductName,Suppliers.CompanyName as Supplier from 
Products
left join Suppliers on Products.SupplierID = .Suppliers.SupplierID
order by ProductID 

--Ques19--
select OrderID,Cast(OrderDate as date)as Date,CompanyName from Orders
left join Shippers on Orders.ShipVia = Shippers.ShipperID
where OrderID < 10300
order by OrderID

---Ques20---
select Products.CategoryID,CategoryName,   count(ProductID) as totalproducts from Products
left join Categories on Products.CategoryID = Categories.CategoryID
group by Products.CategoryID,CategoryName
order by totalproducts desc

---Ques 21 --
select Country,City,COUNT(CustomerID) as total_customers from Customers
group by Country,City
order by total_customers desc

---Ques 22--
select ProductID, ProductName, UnitsInStock,ReorderLevel from Products
WHERE UnitsInStock<ReorderLevel
ORDER BY ProductID

--Ques 23--
select ProductID, ProductName, UnitsInStock, UnitsOnOrder,ReorderLevel,Discontinued  from Products
WHERE (UnitsInStock + UnitsOnOrder) <=ReorderLevel  and Discontinued = '0'
ORDER BY ProductID

--Ques24--
 select CustomerID,Region,CompanyName from Customers
 group by Region,CompanyName,CustomerID
 order by case when Region is null then 1 else 0 end, Region,CustomerID asc

 ---Ques 25---
 select  top(3) ShipCountry, avg(Freight) as Freight_charges from Orders
 group by ShipCountry
 order by Freight_charges desc 

 ---ques 26---
 select  top(3) ShipCountry, avg(Freight) as Freight_charges from Orders
 where DATEPART(YEAR,OrderDate) = 2015
 group by ShipCountry
 order by Freight_charges desc

 ---ques28---
select  top(3) ShipCountry, avg(Freight) as Freight_charges from Orders
WHERE OrderDate >=dateadd(yy,-1,(Select max(OrderDate) from Orders))
group by ShipCountry
order by Freight_charges desc

--ques29--
select Orders.EmployeeID,Employees.LastName,Products.ProductID,orders.OrderID,sum(OrderDetails.Quantity)as Quantity from Orders 
left join Employees on Orders.EmployeeID = Employees.EmployeeID
left join OrderDetails on Orders.OrderID = OrderDetails.OrderID
left join Products on OrderDetails.ProductID = Products.ProductID
group by Orders.EmployeeID,Employees.LastName,Orders.OrderID,Products.ProductID
order by Orders.OrderID,Products.ProductID 

---ques 30---
select Customers.CustomerID from Orders
full outer join Customers on Orders.CustomerID = Customers.CustomerID
where Orders.OrderID is null


---ques31--

select distinct Orders.CustomerID, Customers.CustomerID,Orders.EmployeeID from Customers 
left join Orders on
Customers.CustomerID = Orders.CustomerID
and Orders.EmployeeID =4
where Orders.CustomerID is null

---ques32---

select Orders.OrderID,Orders.CustomerID, sum(UnitPrice*Quantity) as order_value from Orders 
left join Customers on Orders.CustomerID = Customers.CustomerID
left join OrderDetails on OrderDetails.OrderID = Orders.OrderID
where DATEPART(year,Orders.OrderDate) = 2016
group by Orders.OrderID,Orders.CustomerID
having sum(UnitPrice*Quantity) >= 10000

---ques 33---
select Orders.CustomerID, sum(UnitPrice*Quantity) as order_value from Orders 
left join Customers on Orders.CustomerID = Customers.CustomerID
left join OrderDetails on OrderDetails.OrderID = Orders.OrderID
where DATEPART(year,Orders.OrderDate) = 2016
group by Orders.CustomerID
having sum(UnitPrice*Quantity) >= 15000
 

 --Ques 34 ---
select Orders.CustomerID, sum(UnitPrice*Quantity *(1-Discount)) as order_value from Orders 
left join Customers on Orders.CustomerID = Customers.CustomerID
left join OrderDetails on OrderDetails.OrderID = Orders.OrderID
where DATEPART(year,Orders.OrderDate) = 2016
group by Orders.OrderDate
having sum(UnitPrice*Quantity *(1-Discount))>= 10000
order by order_value

--ques35---
select OrderID, OrderDate , EmployeeID from Orders 
where OrderDate= EOMONTH(OrderDate)
order by EmployeeID,OrderID

 ---ques36---
select OrderId,count(orderID) as lineitems from OrderDetails
group by OrderID
order by lineitems desc

--ques37--
select top 2 percent * from Orders 

---ques38--
select Orders.OrderID ,count(*)
from Orders left join OrderDetails on OrderDetails.OrderID =Orders.OrderID
left join Employees on Orders.EmployeeID =Employees.EmployeeID
where Quantity >=60
group by Orders.OrderID, Quantity
having count(*) >1

--ques 39--

select OrderDetails.OrderID,OrderDetails.ProductID,OrderDetails.UnitPrice,OrderDetails.Quantity
from OrderDetails
where OrderDetails.OrderID IN (
select Orders.OrderID 
from Orders left join OrderDetails on OrderDetails.OrderID =Orders.OrderID
left join Employees on Orders.EmployeeID =Employees.EmployeeID
where Quantity >=60
group by Orders.OrderID, Quantity
having count(*) >1)

--ques41--
select OrderID,OrderDate,EmployeeID from Orders
where ShippedDate >= RequiredDate

--ques42----
select EmployeeID, count(EmployeeID) as total_late_orders from Orders
where ShippedDate >= RequiredDate
group by EmployeeID 
order by total_late_orders desc

--ques 43--
select sq.EmployeeID,sum(sq.total_late_orders) as total_late_orders,sum(total_tbl.total_orders) from  (
select EmployeeID, count(EmployeeID) as total_late_orders from Orders
where ShippedDate >= RequiredDate
group by EmployeeID 
)sq
left join (select EmployeeID, count(EmployeeID) as total_orders from Orders
group by EmployeeID 
)total_tbl ON sq.EmployeeID = total_tbl.EmployeeID
group by sq.EmployeeID 

--ques 44--
select sq.EmployeeID,sum(sq.total_late_orders) as total_late_orders,sum(total_tbl.total_orders) from  (
select Orders.EmployeeID, count(EmployeeID) as total_late_orders from Orders
where ShippedDate >= RequiredDate
group by EmployeeID 
)sq
right outer join (select EmployeeID, count(EmployeeID) as total_orders from Orders
group by EmployeeID 
)total_tbl ON sq.EmployeeID = total_tbl.EmployeeID
group by sq.EmployeeID 

--ques45---
select sq.EmployeeID,ISNULL(sum(sq.total_late_orders),0) as total_late_orders,sum(total_tbl.total_orders) from  (
select Orders.EmployeeID, count(EmployeeID) as total_late_orders from Orders
where ShippedDate >= RequiredDate
group by EmployeeID 
)sq
right outer join (select EmployeeID, count(EmployeeID) as total_orders from Orders
group by EmployeeID 
)total_tbl ON sq.EmployeeID = total_tbl.EmployeeID
group by sq.EmployeeID 

--ques 46 -47---
select sq.EmployeeID,
ISNULL(sum(sq.total_late_orders),0) as total_late_orders,
sum(total_tbl.total_orders)as total_orders,
rOUND(( CAST(SUM(sq.total_late_orders) AS float) / CAST(SUM(total_tbl.total_orders) AS float) *100),2) as percnt from  (
select Orders.EmployeeID, count(EmployeeID) as total_late_orders from Orders
where ShippedDate >= RequiredDate
group by EmployeeID 
)sq
right outer join (select EmployeeID, count(EmployeeID) as total_orders from Orders
group by EmployeeID 
)total_tbl ON sq.EmployeeID = total_tbl.EmployeeID
group by sq.EmployeeID 

---Ques 48--
select Orders.OrderID,Orders.CustomerID, sum(UnitPrice*Quantity) as order_value,case 
when sum(UnitPrice*Quantity) >0  and sum(UnitPrice*Quantity)<1000 then 'A'
when sum(UnitPrice*Quantity) >=1000 and sum(UnitPrice*Quantity)<5000 then 'B'
end as qty_category
from Orders 
left join Customers on Orders.CustomerID = Customers.CustomerID
left join OrderDetails on OrderDetails.OrderID = Orders.OrderID
where DATEPART(year,Orders.OrderDate) = 2016
group by Orders.OrderID,Orders.CustomerID 

--ques 49
select Orders.OrderID,Orders.CustomerID, sum(UnitPrice*Quantity) as order_value,case 
when sum(UnitPrice*Quantity) >0  and sum(UnitPrice*Quantity)<1000 then 'A'
when sum(UnitPrice*Quantity) >=1000 and sum(UnitPrice*Quantity)<5000 then 'B'
end as qty_category
 from Orders 
left join Customers on Orders.CustomerID = Customers.CustomerID
left join OrderDetails on OrderDetails.OrderID = Orders.OrderID
where DATEPART(year,Orders.OrderDate) = 2016
group by Orders.OrderID,Orders.CustomerID 
 

---Ques 50--
select qty_category,sum_category,sum_category/(select cast(count(Orders.OrderID) as float) from Orders)
from
(
select base_table.qty_category,sum(base_table.count_orderid) as sum_category
FROM
(select Orders.OrderID,Orders.CustomerID, sum(UnitPrice*Quantity) as order_value,case 
when sum(UnitPrice*Quantity) >=0  and sum(UnitPrice*Quantity)<1000 then 'Low'
when sum(UnitPrice*Quantity) >=1000 and sum(UnitPrice*Quantity)<5000 then 'Medium'
when sum(UnitPrice*Quantity) >=5000 and sum(UnitPrice*Quantity)<10000 then 'High'
when sum(UnitPrice*Quantity) >=10000  then 'Very High'
end as qty_category, count(orders.orderID) as count_orderid 
from Orders 
left join Customers on Orders.CustomerID = Customers.CustomerID
left join OrderDetails on OrderDetails.OrderID = Orders.OrderID
where DATEPART(year,Orders.OrderDate) =2016
group by Orders.OrderID,Orders.CustomerID )base_table
group by base_table.qty_category)intermediate_table

--ques51--  
select * from(
select Orders.OrderID,Orders.CustomerID, sum(UnitPrice*Quantity) as order_value
from Orders 
left join Customers on Orders.CustomerID = Customers.CustomerID
left join OrderDetails on OrderDetails.OrderID = Orders.OrderID
where DATEPART(year,Orders.OrderDate) =2016
group by Orders.OrderID,Orders.CustomerID)base_tbl
join CustomerGroupThresholds on base_tbl.order_value between CustomerGroupThresholds.RangeBottom and CustomerGroupThresholds.RangeTop

--- ques 52--
select Country from Suppliers
union 
select Country from Customers

--- ques 53--
select Suppliers.Country, CustTable.Country from Suppliers
full join (select Customers.Country  from Customers)CustTable on Suppliers.Country = CustTable.Country

--ques 54--
group by country and count of total suppliers and count of customers

---ques55---
SELECT
   t.ShipCountry,t.CustomerID,t.OrderId,t.OrderDate
FROM 
    (SELECT
        ROW_NUMBER() OVER (PARTITION BY ShipCountry ORDER BY OrderDate asc) AS RowNumber,
     CustomerID,OrderId,OrderDate,ShipCountry from Orders)t
WHERE t.RowNumber = 1

---ques56---
select InitialOrders.CustomerID as InitialOrders_CustomerID ,
InitialOrders.OrderID as InitialOrders_OrderID,
InitialOrders.OrderDate as InitialOrders_OrderDate,
NextOrder.CustomerID as NextOrder_CustomerID,
NextOrder.OrderID as NextOrder_OrderID,
NextOrder.OrderDate as NextOrder_OrderDate,
DATEDIFF(day,InitialOrders.OrderDate,NextOrder.OrderDate) as date_diff
from Orders InitialOrders 
join Orders NextOrder on InitialOrders.CustomerID = NextOrder.CustomerID
where InitialOrders.OrderID < NextOrder.OrderID and DATEDIFF(day,InitialOrders.OrderDate,NextOrder.OrderDate) <= 5
order by InitialOrders_CustomerID,InitialOrders.OrderID

---ques57---


























