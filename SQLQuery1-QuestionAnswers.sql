--create database Group_Project_1;

--Questions:1,5,9,13,17

--1) Within the PRODUCT schema, show all records from the Product.Category table.
SELECT *
  FROM  Group_Project_1v2..PRODUCT_CATEGORY; 


--5) Within the Orders schema, display shipment method records where Estimated date shipped is the same as the actual date shipped.


SELECT OS.ShipmentMethodID,ShipmentMode ,ShipmentClass,ShipmentTime,FreightCost,OS.DateModified
  FROM  Group_Project_1v2..ORDER_SHIPMENTMETHOD as OS JOIN  Group_Project_1v2..ORDER_CUSTOMERORDER as OC
  ON  OS.ShipmentMethodID = OC.ShipmentMethodID 
  WHERE EstDateShipped = ActualDateShipped

  /*
  
SELECT *
  FROM  Group_Project_1v2..ORDER_SHIPMENTMETHOD as OS JOIN  Group_Project_1v2..ORDER_CUSTOMERORDER as OC
  ON  OS.ShipmentMethodID = OC.ShipmentMethodID 
  WHERE EstDateShipped = ActualDateShipped
  */
--9) Within the PRODUCT and Orders schema, list all product details for products that have are not included on any order
SELECT *
--PP.ProductID      ,ProductCategoryID      ,Descriptions      ,WeightQty      ,Package      ,WeightUnits      ,Price  
FROM   Group_Project_1v2..PRODUCT_PRODUCT 
WHERE  ProductID not in(SELECT PP.ProductID       
FROM Group_Project_1v2..ORDER_PRODUCTSELECTION as OPS JOIN  Group_Project_1v2..PRODUCT_PRODUCT as PP
ON  OPS.ProductID=PP.ProductID)

SELECT * 
FROM   Group_Project_1v2..PRODUCT_PRODUCT 
WHERE  ProductID not in (SELECT DISTINCT(ProductID) FROM Group_Project_1v2..ORDER_PRODUCTSELECTION)

/*SELECT *
--PP.ProductID      ,ProductCategoryID      ,Descriptions      ,WeightQty      ,Package      ,WeightUnits      ,Price  
FROM Group_Project_1v2..ORDER_PRODUCTSELECTION as OPS JOIN  Group_Project_1v2..PRODUCT_PRODUCT as PP
ON  OPS.ProductID=PP.ProductID---products included in order*/

--13) Within the PRODUCT schema, list the item with the greatest (highest) price.
SELECT ProductID as 'Item/Product',Price as 'Maximum Price' 
FROM   Group_Project_1v2..PRODUCT_PRODUCT 
WHERE  Price IN (SELECT MAX(Price)  FROM   Group_Project_1v2..PRODUCT_PRODUCT  )


--17) Within the PRODUCT schema, show the product information for any product that has a review rating between 3 and 5 with a product category name of either Perishable or Miscellaneous.
--- You must utilize one, or more, subqueries for your response
--- You cannot use a JOIN anywhere within your query
--(Between 3 and 5 in question means including end point 3 and 5?)

SELECT * 
FROM   Group_Project_1v2..PRODUCT_PRODUCT 
WHERE  ProductCategoryID IN (SELECT ProductCategoryID  FROM   Group_Project_1v2..PRODUCT_CATEGORY  WHERE CategoryName IN ('Perishable','Miscellaneous'))
AND ProductID IN (SELECT ProductID  FROM   Group_Project_1v2..PRODUCT_REVIEW WHERE Rating BETWEEN 3 AND 5)

/*
SELECT *
  FROM  Group_Project_1v2..PRODUCT_PRODUCT as PP JOIN  Group_Project_1v2..PRODUCT_CATEGORY as PC 
  ON  PP.ProductCategoryID = PC.ProductCategoryID  JOIN Group_Project_1v2..PRODUCT_REVIEW as PR  ON  PP.ProductID = PR.ProductID
  WHERE (Rating >=3 and Rating <=5 ) AND  (CategoryName IN ('Perishable','Miscellaneous'))*/


