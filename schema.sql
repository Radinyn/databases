-- tables
-- Table: Companies
CREATE TABLE Companies (
    CompanyID int  NOT NULL,
    CompanyName nvarchar(50)  NOT NULL,
    NIP int  NOT NULL,
    Address nvarchar(50)  NOT NULL,
    PostalCode nvarchar(20)  NOT NULL,
    CONSTRAINT Companies_ak_1 UNIQUE (NIP),
    CONSTRAINT Companies_ak_2 UNIQUE (CompanyName),
    CONSTRAINT Companies_pk PRIMARY KEY  (CompanyID)
);

-- Table: Constants
CREATE TABLE Constants (
    WZ int  NOT NULL,
    WK int  NOT NULL,
    Z1 int  NOT NULL,
    K1 int  NOT NULL,
    R1 int  NOT NULL,
    K2 int  NOT NULL,
    D1 int  NOT NULL,
    R2 int  NOT NULL,
    CONSTRAINT check_1 CHECK ((WZ >= 0) AND (WK >= 0) AND (Z1 >= 0) AND (K1 >= 0) AND (R1 >= 0) AND (K2 >= 0) AND (D1 >= 0) AND (R2 >= 0) AND (R1 <= 100) AND (R2 <= 100))
);

-- Table: Customers
CREATE TABLE Customers (
    CustomerID int  NOT NULL,
    isCompany bit  NOT NULL,
    Email nvarchar(50)  NOT NULL,
    Phone nvarchar(20)  NULL,
    Reservations_ReservationID int  NOT NULL,
    CONSTRAINT Customers_ak_1 UNIQUE (Email),
    CONSTRAINT check_1 CHECK (Email LIKE '%_@__%.__%'),
    CONSTRAINT Customers_pk PRIMARY KEY  (CustomerID)
);

-- Table: Dish
CREATE TABLE Dish (
    DishID int  NOT NULL,
    DishName nvarchar(50)  NOT NULL,
    Category nvarchar(20)  NOT NULL,
    UnitsInStock int  NOT NULL,
    Price money  NOT NULL,
    CONSTRAINT Dish_ak_1 UNIQUE (DishName),
    CONSTRAINT check_1 CHECK (Price > 0),
    CONSTRAINT check_2 CHECK (UnitsInStock >= 0),
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
    MenuID int  NOT NULL,
    DishID int  NOT NULL,
    StartDate datetime  NOT NULL DEFAULT getdate(),
    EndDate datetime  NULL,
    Price money  NOT NULL,
    CONSTRAINT check_1 CHECK (Price > 0),
    CONSTRAINT Menu_pk PRIMARY KEY  (MenuID)
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
    MenuID int  NOT NULL,
    Quantity int  NOT NULL,
    UnitPrice money  NOT NULL,
    CONSTRAINT check_1 CHECK (Quantity > 0),
    CONSTRAINT check_2 CHECK (UnitPrice >= 0),
    CONSTRAINT OrderDetails_pk PRIMARY KEY  (OrderID)
);

-- Table: Orders
CREATE TABLE Orders (
    OrderID int  NOT NULL,
    CustomerID int  NULL,
    OrderDate datetime  NOT NULL DEFAULT getdate(),
    DueDate datetime  NULL,
    CompletionDate datetime  NULL,
    FinalPrice money  NOT NULL,
    CONSTRAINT Orders_pk PRIMARY KEY  (OrderID)
);

-- Table: ReservationDetails
CREATE TABLE ReservationDetails (
    ReservationID int  NOT NULL,
    TableID int  NOT NULL,
    CONSTRAINT ReservationDetails_pk PRIMARY KEY  (ReservationID,TableID)
);

-- Table: Reservations
CREATE TABLE Reservations (
    ReservationID int  NOT NULL,
    CustomerID int  NOT NULL,
    StartTime datetime  NOT NULL,
    EndTime datetime  NOT NULL,
    PeopleCount int  NOT NULL,
    isNamed bit  NOT NULL DEFAULT 0,
    CONSTRAINT Reservations_pk PRIMARY KEY  (ReservationID)
);

-- Table: Tables
CREATE TABLE Tables (
    TableID int  NOT NULL,
    Size tinyint  NOT NULL,
    isActive bit  NOT NULL,
    CONSTRAINT check_1 CHECK (Size > 0),
    CONSTRAINT Tables_pk PRIMARY KEY  (TableID)
);

-- Table: TimedDiscounts
CREATE TABLE TimedDiscounts (
    DiscountID int  NOT NULL,
    IndividualID int  NOT NULL,
    StartDate datetime  NOT NULL DEFAULT getdate(),
    EndDate datetime  NOT NULL,
    CONSTRAINT TimedDiscounts_pk PRIMARY KEY  (DiscountID)
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

-- Reference: Customers_Reservations (table: Reservations)
ALTER TABLE Reservations ADD CONSTRAINT Customers_Reservations
    FOREIGN KEY (CustomerID)
    REFERENCES Customers (CustomerID);

-- Reference: Discounts_Customers (table: TimedDiscounts)
ALTER TABLE TimedDiscounts ADD CONSTRAINT Discounts_Customers
    FOREIGN KEY (IndividualID)
    REFERENCES Customers (CustomerID);

-- Reference: Individuals_Discounts (table: TimedDiscounts)
ALTER TABLE TimedDiscounts ADD CONSTRAINT Individuals_Discounts
    FOREIGN KEY (IndividualID)
    REFERENCES Individuals (IndividualID);

-- Reference: Menu_Dish (table: Menu)
ALTER TABLE Menu ADD CONSTRAINT Menu_Dish
    FOREIGN KEY (DishID)
    REFERENCES Dish (DishID);

-- Reference: Menu_OrderDetails (table: OrderDetails)
ALTER TABLE OrderDetails ADD CONSTRAINT Menu_OrderDetails
    FOREIGN KEY (MenuID)
    REFERENCES Menu (MenuID);

-- Reference: OrderDetails_Orders (table: OrderDetails)
ALTER TABLE OrderDetails ADD CONSTRAINT OrderDetails_Orders
    FOREIGN KEY (OrderID)
    REFERENCES Orders (OrderID);

-- Reference: Orders_Customers (table: Orders)
ALTER TABLE Orders ADD CONSTRAINT Orders_Customers
    FOREIGN KEY (CustomerID)
    REFERENCES Customers (CustomerID);

-- Reference: ReservationDetails_Reservations (table: ReservationDetails)
ALTER TABLE ReservationDetails ADD CONSTRAINT ReservationDetails_Reservations
    FOREIGN KEY (ReservationID)
    REFERENCES Reservations (ReservationID);

-- Reference: ReservationDetails_Tables (table: ReservationDetails)
ALTER TABLE ReservationDetails ADD CONSTRAINT ReservationDetails_Tables
    FOREIGN KEY (TableID)
    REFERENCES Tables (TableID);

-- Reference: Reservations_NamedReservations (table: NamedReservations)
ALTER TABLE NamedReservations ADD CONSTRAINT Reservations_NamedReservations
    FOREIGN KEY (ReservationID)
    REFERENCES Reservations (ReservationID);

-- sequences
-- Sequence: Customers_sq
CREATE SEQUENCE Customers_sq
    START WITH 1 
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    NO CYCLE
    NO CACHE;

-- Sequence: Discounts_sq
CREATE SEQUENCE Discounts_sq
    START WITH 1 
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    NO CYCLE
    NO CACHE;

-- Sequence: Dish_sq
CREATE SEQUENCE Dish_sq
    START WITH 1 
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    NO CYCLE
    NO CACHE;

-- Sequence: Menu_sq
CREATE SEQUENCE Menu_sq
    START WITH 1 
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    NO CYCLE
    NO CACHE;

-- Sequence: NamedReservations_sq
CREATE SEQUENCE NamedReservations_sq
    START WITH 1 
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    NO CYCLE
    NO CACHE;

-- Sequence: Orders_sq
CREATE SEQUENCE Orders_sq
    START WITH 1 
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    NO CYCLE
    NO CACHE;

-- Sequence: Reservations_sq
CREATE SEQUENCE Reservations_sq
    START WITH 1 
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    NO CYCLE
    NO CACHE;

-- Sequence: Tables_sq
CREATE SEQUENCE Tables_sq
    START WITH 1 
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    NO CYCLE
    NO CACHE;

-- End of file.
