-- Load inital set of customers as if nightly full cycle
-- We are skipping a subset to replicate a partial load during the day

INSERT INTO CUSTOMER_D
(
	SRC_ID,
	Title,
	FirstName,
	MiddleName,
	LastName,
	Suffix
)
SELECT
	a.CustomerID,
	b.Title,
	b.FirstName,
	b.MiddleName,
	b.LastName,
	b.Suffix
FROM
	AdventureWorks2019.Sales.Customer a
	INNER JOIN AdventureWorks2019.Person.Person b ON
		a.PersonID = b.BusinessEntityID
WHERE
	b.FirstName NOT LIKE 'K%'
	
-- Load Sales Headers as if during day

INSERT INTO SALES_ORDER_HEADER_F
(
	SRC_ID,
	OrderDate,
	DueDate,
	ShipDate,
	[Status],
	CustomerID,
	SRC_CustomerID
)
SELECT
	a.SalesOrderID,
	a.OrderDate,
	a.DueDate,
	a.ShipDate,
	a.[Status],
	COALESCE(b.CUSTOMER_D_ID, -888),
	a.CustomerID
FROM
	AdventureWorks2019.Sales.SalesOrderHeader a
	LEFT JOIN CUSTOMER_D b ON
		a.CustomerID = b.SRC_ID
		
-- Test

select * from SALES_ORDER_HEADER_F where CustomerID = -888

-- Load missing customers
	
INSERT INTO CUSTOMER_D
(
	SRC_ID,
	Title,
	FirstName,
	MiddleName,
	LastName,
	Suffix
)
SELECT
	a.CustomerID,
	b.Title,
	b.FirstName,
	b.MiddleName,
	b.LastName,
	b.Suffix
FROM
	AdventureWorks2019.Sales.Customer a
	INNER JOIN AdventureWorks2019.Person.Person b ON
		a.PersonID = b.BusinessEntityID
WHERE
	b.FirstName LIKE 'K%'
	
-- Heal Sales Header Data

UPDATE a
SET a.CustomerID = b.CUSTOMER_D_ID
FROM
	SALES_ORDER_HEADER_F a
INNER JOIN CUSTOMER_D b ON
	a.SRC_CustomerID = b.SRC_ID
WHERE
	a.CustomerID = -888
	
-- Test

select * from SALES_ORDER_HEADER_F where CustomerID = -888