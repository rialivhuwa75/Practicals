--------------------------------------------------------------------------------------------------------------------------
--viewing my data from all three tables

SELECT * FROM practical2.dataset.customers LIMIT 10;
SELECT * FROM practical2.dataset.products LIMIT 10;
SELECT * FROM practical2.dataset.orders LIMIT 10;
--------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------
--1. INNER JOIN: Orders with Customer name and Product Names
--Which customers have placed at least one order?
--Expected Output Columns:OrderID, OrderDate, CustomerName, ProductName, Quantity

SELECT A.orderid,
       A.orderdate,
       B.customername,
       C.productname,
       A.quantity
FROM practical2.dataset.orders AS A
INNER JOIN practical2.dataset.customers AS B ON A.customerid = B.customerid
INNER JOIN practical2.dataset.products AS C ON A.productid = A.productid;

--------------------------------------------------------------------------------------------------------------------------
--2. INNER JOIN: Customers Who Placed Orders
--Which customers have placed at least one order?
--Expected Output Columns:CustomerID, CustomerName, Country, OrderID, OrderDate
SELECT A.orderid,
       A.orderdate,
       B.customername,
       C.productname,
       A.quantity
FROM practical2.dataset.orders AS A
INNER JOIN practical2.dataset.customers AS B ON A.customerid = B.customerid
INNER JOIN practical2.dataset.products AS C ON A.productid = A.productid
WHERE quantity>1;

--------------------------------------------------------------------------------------------------------------------------
--3. LEFT JOIN: All Customers and Their Orders
--List all customers and any orders they might have placed. Include customers who have not placed any orders.
--Expected Output Columns:CustomerID, CustomerName, Country, OrderID, OrderDate, ProductID, Quantity
SELECT A.customerid,
       A.customername,
       A.country,

       B.orderid,
       B.orderdate,
       B.productid,
       B.quantity
FROM practical2.dataset.customers AS A
LEFT JOIN practical2.dataset.orders AS B ON A.customerid = B.customerid;


--------------------------------------------------------------------------------------------------------------------------
--4. LEFT JOIN: Product Order Count
--List all products and how many times each was ordered (if any)
--Expected Output Columns:ProductID, ProductName, TotalOrders
--(TotalOrders is the count of how many times the product appears in orders)
SELECT A.productid,
       A.productname,
       COUNT(B.orderid) AS total_orders 
   
FROM practical2.dataset.products AS A
LEFT JOIN practical2.dataset.orders AS B ON A.productid = B.productid
GROUP BY A.productid, A.productname;


--------------------------------------------------------------------------------------------------------------------------
--5. RIGHT JOIN: Orders with Product Info (Include Products Not Ordered)
--Find all orders along with product details, including any products that might not have been ordered.
--Expected Output Columns:OrderID, OrderDate, ProductID, ProductName, Price, Quantity

SELECT A.orderid,
       A.orderdate,
       A.productid,
       B.productname,
       B.price,
       A.quantity 
FROM practical2.dataset.orders AS A
RIGHT JOIN practical2.dataset.products AS B ON A.productid = B.productid;

--------------------------------------------------------------------------------------------------------------------------
--6. RIGHT JOIN: Customer Info with Orders (Include All Customers)
--Which customers have made orders, and include customers even if they have never placed an order.
--Expected Output Columns:CustomerID, CustomerName, Country, OrderID, OrderDate, ProductID, Quantity

SELECT A.customerid,
       A.customername,
       A.country,

       B.orderid,
       B.orderdate,
       B.productid,
       B.quantity
FROM practical2.dataset.customers AS A
RIGHT JOIN practical2.dataset.orders AS B ON A.customerid = B.customerid;

--------------------------------------------------------------------------------------------------------------------------
--7. FULL OUTER JOIN: All Customers and All Orders
--List all customers and orders, showing NULLs where customers have not ordered or where orders have no customer info.
--Expected Output Columns:CustomerID, CustomerName, Country, OrderID, OrderDate, ProductID, Quantity

SELECT A.customerid,
       A.customername,
       A.country,

       B.orderid,
       B.orderdate,
       B.productid,
       B.quantity
FROM practical2.dataset.customers AS A
FULL OUTER JOIN practical2.dataset.orders AS B ON A.customerid = B.customerid;

--------------------------------------------------------------------------------------------------------------------------
--8. FULL OUTER JOIN: All Products and Orders
--List all products and orders, showing NULLs where products were never ordered or orders are missing product info.
--Expected Output Columns:ProductID, ProductName, Price, OrderID, OrderDate, CustomerID, Quantity

SELECT A.productid,
       A.productname,
       A.price,

       B.orderid,
       B.orderdate,
       B.customerid,
       B.quantity
FROM practical2.dataset.products AS A
FULL OUTER JOIN practical2.dataset.orders AS B ON A.productid = B.productid;

--------------------------------------------------------------------------------------------------------------------------
-- 

--------------------------------------------------------------------------------------------------------------------------
