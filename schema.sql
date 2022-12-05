-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2022-12-05 09:49:34.896

-- tables
-- Table: Companies
CREATE TABLE Companies (
    CompanyID int  NOT NULL,
    CompanyName nvarchar(50)  NOT NULL,
    NIP int  NOT NULL,
    CONSTRAINT Companies_pk PRIMARY KEY  (CompanyID)
);

-- Table: Customers
CREATE TABLE Customers (
    CustomerID int  NOT NULL,
    isCompany bit  NOT NULL,
    Email nvarchar(50)  NOT NULL,
    Phone nvarchar(20)  NULL,
    Address nvarchar(50)  NOT NULL,
    PostalCode nvarchar(20)  NOT NULL,
    CONSTRAINT Customers_pk PRIMARY KEY  (CustomerID)
);

-- Table: Discounts
CREATE TABLE Discounts (
    DiscountID int  NOT NULL,
    IndividualID int  NOT NULL,
    StartDate datetime  NOT NULL,
    EndDate datetime  NULL,
    Multiplier decimal(3,2)  NOT NULL,
    CONSTRAINT Discounts_pk PRIMARY KEY  (DiscountID)
);

-- Table: Dish
CREATE TABLE Dish (
    DishID int  NOT NULL,
    DishName nvarchar(50)  NOT NULL,
    isSeafood bit  NOT NULL,
    isAvailable bit  NOT NULL,
    Price money  NOT NULL,
    CONSTRAINT Dish_pk PRIMARY KEY  (DishID)
);

-- Table: Individuals
CREATE TABLE Individuals (
    IndividualID int  NOT NULL,
    FirstName nvarchar(50)  NOT NULL,
    LastName nvarchar(50)  NOT NULL,
    CONSTRAINT Individuals_pk PRIMARY KEY  (IndividualID)
);

-- Table: Menu
CREATE TABLE Menu (
    DishID int  NOT NULL,
    AddDate datetime  NOT NULL,
    isActive bit  NOT NULL,
    CONSTRAINT Menu_pk PRIMARY KEY  (DishID)
);

-- Table: NamedReservations
CREATE TABLE NamedReservations (
    NamedReservationID int  NOT NULL,
    ReservationID int  NOT NULL,
    FirstName nvarchar(50)  NOT NULL,
    LastName nvarchar(50)  NOT NULL,
    CONSTRAINT NamedReservations_pk PRIMARY KEY  (NamedReservationID)
);

-- Table: OrderDetails
CREATE TABLE OrderDetails (
    OrderID int  NOT NULL,
    DishID int  NOT NULL,
    Quantity int  NOT NULL,
    UnitPrice money  NOT NULL,
    CONSTRAINT OrderDetails_pk PRIMARY KEY  (DishID,OrderID)
);

-- Table: Orders
CREATE TABLE Orders (
    OrderID int  NOT NULL,
    CustomerID int  NOT NULL,
    OrderDate datetime  NOT NULL,
    DueDate datetime  NULL,
    CompletionDate datetime  NULL,
    FinalPrice money  NOT NULL,
    CONSTRAINT Orders_pk PRIMARY KEY  (OrderID)
);

-- Table: Reservations
CREATE TABLE Reservations (
    ReservationID int  NOT NULL,
    OrderID int  NOT NULL,
    TableID int  NOT NULL,
    StartTime datetime  NOT NULL,
    EndTime datetime  NOT NULL,
    isNamed bit  NOT NULL,
    CONSTRAINT Reservations_pk PRIMARY KEY  (ReservationID)
);

-- Table: Tables
CREATE TABLE Tables (
    TableID int  NOT NULL,
    Size tinyint  NOT NULL,
    isActive bit  NOT NULL,
    CONSTRAINT Tables_pk PRIMARY KEY  (TableID)
);

-- foreign keys
-- Reference: Customers_Companies (table: Companies)
ALTER TABLE Companies ADD CONSTRAINT Customers_Companies
    FOREIGN KEY (CompanyID)
    REFERENCES Customers (CustomerID);

-- Reference: Customers_Individuals (table: Individuals)
ALTER TABLE Individuals ADD CONSTRAINT Customers_Individuals
    FOREIGN KEY (IndividualID)
    REFERENCES Customers (CustomerID);

-- Reference: Discounts_Customers (table: Discounts)
ALTER TABLE Discounts ADD CONSTRAINT Discounts_Customers
    FOREIGN KEY (IndividualID)
    REFERENCES Customers (CustomerID);

-- Reference: Dish_OrderDetails (table: OrderDetails)
ALTER TABLE OrderDetails ADD CONSTRAINT Dish_OrderDetails
    FOREIGN KEY (DishID)
    REFERENCES Dish (DishID);

-- Reference: Individuals_Discounts (table: Discounts)
ALTER TABLE Discounts ADD CONSTRAINT Individuals_Discounts
    FOREIGN KEY (IndividualID)
    REFERENCES Individuals (IndividualID);

-- Reference: Menu_Dish (table: Menu)
ALTER TABLE Menu ADD CONSTRAINT Menu_Dish
    FOREIGN KEY (DishID)
    REFERENCES Dish (DishID);

-- Reference: Menu_OrderDetails (table: OrderDetails)
ALTER TABLE OrderDetails ADD CONSTRAINT Menu_OrderDetails
    FOREIGN KEY (DishID)
    REFERENCES Menu (DishID);

-- Reference: OrderDetails_Orders (table: OrderDetails)
ALTER TABLE OrderDetails ADD CONSTRAINT OrderDetails_Orders
    FOREIGN KEY (OrderID)
    REFERENCES Orders (OrderID);

-- Reference: Orders_Customers (table: Orders)
ALTER TABLE Orders ADD CONSTRAINT Orders_Customers
    FOREIGN KEY (CustomerID)
    REFERENCES Customers (CustomerID);

-- Reference: Reservations_NamedReservations (table: NamedReservations)
ALTER TABLE NamedReservations ADD CONSTRAINT Reservations_NamedReservations
    FOREIGN KEY (ReservationID)
    REFERENCES Reservations (ReservationID);

-- Reference: Reservations_Orders (table: Reservations)
ALTER TABLE Reservations ADD CONSTRAINT Reservations_Orders
    FOREIGN KEY (OrderID)
    REFERENCES Orders (OrderID);

-- Reference: Reservations_Tables (table: Reservations)
ALTER TABLE Reservations ADD CONSTRAINT Reservations_Tables
    FOREIGN KEY (TableID)
    REFERENCES Tables (TableID);

-- End of file.

