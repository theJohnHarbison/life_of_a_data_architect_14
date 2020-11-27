CREATE TABLE SALES_ORDER_HEADER_F(
	SALES_ORDER_HEADER_F_ID [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	SRC_ID INT NOT NULL,
	[OrderDate] [datetime] NOT NULL,
	[DueDate] [datetime] NOT NULL,
	[ShipDate] [datetime] NULL,
	[Status] [tinyint] NOT NULL,
	[CustomerID] [int] NOT NULL,
	[SRC_CustomerID] [int] NOT NULL,
)

CREATE TABLE CUSTOMER_D(
	CUSTOMER_D_ID [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	SRC_ID INT NOT NULL,
	[Title] [nvarchar](8) NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[MiddleName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[Suffix] [nvarchar](10) NULL
)

SET IDENTITY_INSERT CUSTOMER_D ON
INSERT INTO CUSTOMER_D(CUSTOMER_D_ID, SRC_ID, FirstName, LastName) VALUES (-888, -888, 'LAZY', 'LOAD')
SET IDENTITY_INSERT CUSTOMER_D OFF