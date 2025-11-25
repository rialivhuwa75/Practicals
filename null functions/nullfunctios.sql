SELECT * FROM practical3.dataset.shopping LIMIT 10;

-----------------------------------------------------------------------------------------------------------------------------------------------------

--1. Find all records where Size is missing and the purchase_amount is greater than 50.
--Expected Columns: Customer ID, Size, purchase_amount, Item Purchased

SELECT Customer_ID,
       Size,
       purchase_amount,
       Item_Purchased
FROM practical3.dataset.shopping
WHERE Size IS NULL  AND purchase_amount > 50;

-----------------------------------------------------------------------------------------------------------------------------------------------------
--2. List the total number of purchases grouped by Season, treating NULL values as 'Unknown Season'.
--Expected Columns: Season, Total Purchases

SELECT COALESCE(Season, 'Unknown Season') AS Season,
       COUNT(*) AS Total_Purchases
FROM practical3.dataset.shopping
GROUP BY COALESCE(Season, 'Unknown Season');

-----------------------------------------------------------------------------------------------------------------------------------------------------
--3. Count how many customers used each Payment Method, treating NULLs as 'Not Provided'.
--Expected Columns: Payment Method, Customer Count
SELECT 
    COALESCE(Payment_Method, 'Not Provided') AS Payment_Method,
    COUNT(DISTINCT Customer_ID) AS Customer_Count
FROM practical3.dataset.shopping
GROUP BY COALESCE(Payment_Method, 'Not Provided');

-----------------------------------------------------------------------------------------------------------------------------------------------------
--4. Show customers where Promo Code Used is NULL and Review Rating is below 3.0.
--Expected Columns: Customer ID, Promo Code Used, Review Rating, Item Purchased
SELECT 
    Customer_ID,
    Promo_Code_Used,
    Review_Rating,
    Item_Purchased
FROM practical3.dataset.shopping
WHERE Promo_Code_Used IS NULL AND Review_Rating < 3.0;

-----------------------------------------------------------------------------------------------------------------------------------------------------
--5. Group customers by Shipping 
--Type, and return the average purchase_amount, treating missing values as 0.
--Expected Columns: Shipping Type, Average purchase_amount
SELECT 
    Shipping_Type,
    AVG(COALESCE(purchase_amount, 0)) AS Average_purchase_amount
FROM practical3.dataset.shopping
GROUP BY Shipping_Type;

-----------------------------------------------------------------------------------------------------------------------------------------------------
--6. Display the number of purchases per Location only for those with more than 5 purchases and no NULL Payment Method.
--Expected Columns: Location, Total Purchases
SELECT 
    Location,
    COUNT(*) AS Total_Purchases
FROM practical3.dataset.shopping
WHERE Payment_Method IS NOT NULL
GROUP BY Location
HAVING COUNT(*) > 5;

-----------------------------------------------------------------------------------------------------------------------------------------------------
--7. Create a column Spender Category that classifies customers using CASE:'High' if amount > 80, 'Medium' if BETWEEN 50 AND 80, 
--'Low' otherwise. Replace NULLs in purchase_amount with 0.
--Expected Columns: Customer ID, purchase_amount, Spender Category
SELECT 
    Customer_ID,
    COALESCE(purchase_amount, 0) AS purchase_amount,
    CASE
        WHEN COALESCE(purchase_amount, 0) > 80 THEN 'High'
        WHEN COALESCE(purchase_amount, 0) BETWEEN 50 AND 80 THEN 'Medium'
        ELSE 'Low'
    END AS Spender_Category
FROM practical3.dataset.shopping;

-----------------------------------------------------------------------------------------------------------------------------------------------------
--8. Find customers who have no Previous Purchases value but whose Color is not NULL.
--Expected Columns: Customer ID, Color, Previous Purchases
SELECT 
    Customer_ID,
    Color,
    Previous_Purchases
FROM practical3.dataset.shopping
WHERE Previous_Purchases IS NULL
  AND Color IS NOT NULL;

-----------------------------------------------------------------------------------------------------------------------------------------------------
--9. Group records by Frequency of Purchases and show the total amount spent per group, treating NULL frequenc
--ies as 'Unknown'.
--Expected Columns: Frequency of Purchases, Total purchase_amount
SELECT 
    COALESCE(Frequency_of_Purchases, 'Unknown') AS Frequency_of_Purchases,
    SUM(purchase_amount) AS Total_purchase_amount
FROM practical3.dataset.shopping
GROUP BY COALESCE(Frequency_of_Purchases, 'Unknown');

-----------------------------------------------------------------------------------------------------------------------------------------------------
--10.Display a list of all Category values with the number of times each was purchased, excluding rows where Categoryis NULL.
--Expected Columns: Category, Total Purchases
SELECT 
    Category,
    COUNT(*) AS Total_Purchases
FROM practical3.dataset.shopping
WHERE Category IS NOT NULL
GROUP BY Category;

-----------------------------------------------------------------------------------------------------------------------------------------------------
--11.Return the top 5 Locations with the highest total purchase_amount, replacing NULLs in amount
--with 0.
--Expected Columns: Location, Total purchase_amount
SELECT 
    Location,
    SUM(COALESCE(purchase_amount, 0)) AS Total_purchase_amount
FROM practical3.dataset.shopping
GROUP BY Location
ORDER BY Total_purchase_amount DESC
LIMIT 5;

-----------------------------------------------------------------------------------------------------------------------------------------------------
--12.Group customers by Gender and Size, and count how many entries have a NULL Color.
--Expected Columns: Gender, Size, Null Color Count
SELECT 
    Gender,
    Size,
    COUNT(*) AS Null_Color_Count
FROM practical3.dataset.shopping
WHERE Color IS NULL
GROUP BY Gender, Size;

-----------------------------------------------------------------------------------------------------------------------------------------------------
--13.Identify all Item Purchased where more than 3 purchases had NULL Shipping Type.
--Expected Columns: Item Purchased, NULL Shipping Type Count
SELECT 
    Item_Purchased,
    COUNT(*) AS NULL_Shipping_Type_Count
FROM practical3.dataset.shopping
WHERE Shipping_Type IS NULL
GROUP BY Item_Purchased
HAVING COUNT(*) > 3;

-----------------------------------------------------------------------------------------------------------------------------------------------------
--14.Show a count of how many customers per Payment Method have NULL Review Rating.
--Expected Columns: Payment Method, Missing Review Rating Count
SELECT 
    Payment_Method,
    COUNT(*) AS Missing_ReviewRating_Count
FROM practical3.dataset.shopping
WHERE Review_Rating IS NULL
GROUP BY Payment_Method;

-----------------------------------------------------------------------------------------------------------------------------------------------------
--15.Group by Category and return the average Review Rating, replacing NULLs with 0, and filter only where average is greater than 3.5.
--Expected Columns: Category, Average Review Rating
SELECT 
    Category,
    AVG(COALESCE(Review_Rating, 0)) AS Average_Review_Rating
FROM practical3.dataset.shopping
GROUP BY Category
HAVING AVG(COALESCE(Review_Rating, 0)) > 3.5;


-----------------------------------------------------------------------------------------------------------------------------------------------------
--16. List all Colors that are missing (NULL) in at least 2 rows and the average Age of customers for those rows.
--Expected Columns: Color, Average Age
SELECT 
    Color,
    AVG(Age) AS Average_Age
FROM practical3.dataset.shopping
WHERE Color IS NULL
GROUP BY Color
HAVING COUNT(*) >= 2;

-----------------------------------------------------------------------------------------------------------------------------------------------------
--17.Use CASE to create a column Delivery Speed: 'Fast' if Shipping Type is 'Express' or 
--'Next Day Air', 'Slow' if 'Standard', 
--'Other' for all else including NULL. Then count how many customers fall intoeach category.
--Expected Columns: Delivery Speed, Customer Count
SELECT 
    CASE
        WHEN Shipping_Type IN ('Express', 'Next Day Air') THEN 'Fast'
        WHEN Shipping_Type = 'Standard' THEN 'Slow'
        ELSE 'Other'
    END AS Delivery_Speed,
    COUNT(DISTINCT Customer_ID) AS Customer_Count
FROM practical3.dataset.shopping
GROUP BY 
    CASE
        WHEN Shipping_Type IN ('Express', 'Next Day Air') THEN 'Fast'
        WHEN Shipping_Type = 'Standard' THEN 'Slow'
        ELSE 'Other'
    END;

-----------------------------------------------------------------------------------------------------------------------------------------------------
--18.Find customers whose purchase_amount is NULL and whose Promo Code Used is 'Yes'.
--Expected Columns: Customer ID, purchase_amount, Promo Code Used
SELECT 
    Customer_ID,
    purchase_amount,
    Promo_Code_Used
FROM practical3.dataset.shopping
WHERE purchase_amount IS NULL
  AND Promo_Code_Used = 'Yes';

-----------------------------------------------------------------------------------------------------------------------------------------------------
--19.Group by Location and show the maximum Previous Purchases, replacing NULLs with 0, only where the average rating is above 4.0.
--Expected Columns: Location, Max Previous Purchases, Average Review Rating
SELECT 
    Location,
    MAX(COALESCE(Previous_Purchases, 0)) AS Max_Previous_Purchases,
    AVG(Review_Rating) AS Average_Review_Rating
FROM practical3.dataset.shopping
GROUP BY Location
HAVING AVG(Review_Rating) > 4.0;

-----------------------------------------------------------------------------------------------------------------------------------------------------
--20.Show customers who have a NULL Shipping Type but made a purchase in the range of 30 to 70 USD.
--Expected Columns: Customer ID, Shipping Type, purchase_amount, Item Purchased
SELECT 
    Customer_ID,
    Shipping_Type,
    purchase_amount,
    Item_Purchased
FROM practical3.dataset.shopping
WHERE Shipping_Type IS NULL
  AND purchase_amount BETWEEN 30 AND 70;

-----------------------------------------------------------------------------------------------------------------------------------------------------

