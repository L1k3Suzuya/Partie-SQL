---------------------------------------------------------------------Eval NorthWind SQL-----------------------------------------------------------------------

------Question 1------(Liste des clients français)

SELECT CompanyName AS Société, ContactName AS Contact, ContactTitle AS Fonction, Phone AS Téléphone
FROM customers
WHERE Country = "France"


------Question 2------(Liste des produits vendus par le fournisseur "Exotic Liquids" )

SELECT ProductName AS Produit, UnitPrice AS Prix
FROM products
NATURAL JOIN suppliers
WHERE CompanyName = "Exotic Liquids"


------Question 3------(Nombre de produits mis à disposition par les fournisseurs français (tri par nombre de produits décroissant))

SELECT CompanyName AS Fournisseur, COUNT(products.SupplierID) AS 'Nbre produits' FROM suppliers
NATURAL JOIN products
WHERE Country="France"
GROUP BY CompanyName
ORDER BY COUNT(products.SupplierID) DESC


------Question 4------(Liste des clients français ayant passé plus de 10 commandes)

SELECT CompanyName AS "Client", COUNT(orders.CustomerID) AS "Nbre commandes" FROM customers
NATURAL JOIN orders
WHERE Country="France"
GROUP BY CompanyName
HAVING COUNT(orders.CustomerID) > 10


------Question 5------(Liste des clients français ayant passé plus de 10 commandes)

SELECT customers.`CompanyName` AS Clients,
sum(`order details`.`Quantity` * `order details`.`UnitPrice`) AS CA,
customers.`Country`
FROM customers
JOIN orders ON orders.`CustomerID` = customers.`CustomerID`
JOIN `order details` ON `order details`.`OrderID` = orders.`OrderID`
GROUP BY customers.`CustomerID` 
	HAVING CA > 30000
ORDER BY CA DESC;


------Question 6------(Liste des pays dans lesquels des produits fournis par "Exotic Liquids" ont été livrés)

SELECT DISTINCT orders.`ShipCountry` AS Pays
FROM orders
JOIN `order details` ON `order details`.`OrderID` = orders.`OrderID`
JOIN products ON products.`ProductID` = `order details`.`ProductID`
JOIN suppliers ON suppliers.`SupplierID` = products.`SupplierID`
WHERE `suppliers`.`CompanyName` = 'Exotic Liquids'
ORDER BY orders.`ShipCountry`;

------Question 7------(Chiffre d'affaires global sur les ventes de 1997)

SELECT sum(`order details`.`UnitPrice` * `order details`.`Quantity`) AS 'CA 1997'
FROM `order details`
JOIN `orders` ON orders.`OrderID` = `order details`.`OrderID`
WHERE orders.`OrderDate` LIKE '1997%';

------Question 8------(Chiffre d'affaires détaillé par mois, sur les ventes de 1997)

SELECT MONTH(orders.`OrderDate`) AS Mois,
sum(`order details`.`UnitPrice` * `order details`.`Quantity`) AS CA
FROM `order details`
JOIN `orders` ON orders.`OrderID` = `order details`.`OrderID`
WHERE orders.`OrderDate` LIKE '1997%'
GROUP BY Mois;

------Question 9------(A quand remonte la dernière commande du client nommé "Du monde entier ?)

SELECT orders.`OrderDate` AS 'Date Dernière Commande'
FROM orders 
JOIN customers ON customers.`CustomerID` = orders.`CustomerID`
WHERE customers.`CustomerID` = 'DUMON'
ORDER BY orders.`OrderDate` DESC
LIMIT 1;


------Question 10------(Quel est le délai moyen de livraison en jours ?)

SELECT 
(AVG(DATEDIFF(orders.`ShippedDate`, orders.`OrderDate`)) - AVG(DATEDIFF(orders.`ShippedDate`, orders.`OrderDate`)) % 1) AS 'Delais Moyen'
FROM orders;