Use OnlineRetailStore
insert into Customers 
Values(1,'Safeia Hamed','123','safeia@gmail.com','Benha','2026-01-01')

Insert into Suppliers
Values(1, 'Ahmed', 'Egypt', 'ahmed@gmail.com', 'Cairo', '123'),
      (2, 'Khaled', 'Egypt', 'khalid@gmail.com', 'Giza', '1234'),
      (3, 'Mona', 'Egypt', 'mona@gmail.com', 'Benha', '12345')

insert into Categories
Values(1,'Food','meat - Rice - Cola',1),
      (2,'Food','meat - Rice - Cola',Null)

insert into Products(ProductID, Name, UnitPrice)
Values (3, 'Chicken', 90.00)

Insert into StockTransactions
Values(1, '2010-05-10', '10', 'Purchase', 'REF001', 1),
      (2, '2020-08-15', '5', 'Purchase', 'REF002', 1),
      (3, '2023-03-20', '-3', 'Sale', 'REF003', 1)

Create Table ArchivedStock
(
    TranId int,
    ProductId int,
    QuantityChange VarChar(50),
    TranDate Date
)
INSERT INTO ArchivedStock (TranId, ProductId, QuantityChange, TranDate)
SELECT TranId, ProductId, QuantityChange, TranDate
FROM StockTransactions
WHERE TranDate < '2023-01-01'

Create Table #CustomerOrders
(
    OrderId Int,
    CustomerId Int,
    TotalAmount Decimal(8,2)
)

Insert Into #CustomerOrders
Select OrderId, CustomerId, TotalAmount
From Orders
Where TotalAmount > 5000

Create Table ##TopRatedProducts
(
    ProductId Int,
    Rating Decimal(8,2)
)

Insert Into ##TopRatedProducts
Select ProductId, Rating
From Reviews
Where Rating >= 4.5

--2 Hotel
Use HotelReservation

Insert Into Guests
Values(1, 'Ahmed Ali', 'Egyptian', '12345', '2024-01-01')

Insert Into Guests
Values(2, 'Mona Ahmed', 'Egyptian', '4567', '2011-11-11'),
      (3, 'Shahd Ahmed', 'Egyptian', '8906', '2020-10-10')

Use OnlineRetailStore
Update Products
Set UnitPrice *= 0.10
Where UnitPrice < 100

Update Orders
Set Status =Case
        When TotalAmount > 5000 Then 'Standard'
        Else 'Premium'
        End

Insert Into Reviews
Values(1, '9', '2026-09-20', 'Very Good', 1, 1),
      (2, '7', '2026-09-21', 'Good', 1, 1)

Delete From Reviews
Where ReviewId = 1

Insert Into Orders
Values(1, 'Cancelled', 200, '2026-09-20', 1),
      (2, 'Completed', 400, '2026-09-21', 1)

Delete From Orders
Where Status = 'Cancelled'

Insert Into OrderItems
Values(1, 8, 400, 1, 2),
      (2, 6, 500, 1, 2)

Delete From OrderItems
Where OrderId = 2


Create Table #ProductsUpdate
(
    ProductId Int,
    Name VarChar(50),
    UnitPrice Decimal(8,2),
    StockQuantity Int
)
Insert Into #ProductsUpdate
Values(1, 'Chicken', 400.00, 10),
      (2, 'Rice', 200.00, 60)

Merge Products As Target
Using #ProductsUpdate As Source
On Target.ProductId = Source.ProductId
When Matched Then
    Update Set Target.UnitPrice = Source.UnitPrice,
               Target.StockQuantity = Source.StockQuantity
When Not Matched By Target Then
    Insert (ProductId, Name, UnitPrice, StockQuantity)
    Values(Source.ProductId, Source.Name, Source.UnitPrice, Source.StockQuantity)
When Not Matched By Source Then
    Delete;

Use HotelReservation
Insert Into Hotels
Values(1, 'Grand Hotel', 'Main Street', 'Cairo', 5, '1234', NULL)

Insert Into Rooms
Values(1, 'Suite', 4, 7000, 'Available', 1),
      (2, 'Suite', 3, 1500, 'Available', 1),
      (3, 'Single', 1, 8000, 'Available', 1),
      (4, 'Double', 2, 1000, 'Occupied', 1)
Update Rooms
Set DailyRate *= 0.15
Where RoomType = 'Suite'

Insert Into Reservation
Values(1, '2026-09-01', '2026-09-05', '2026-09-10', 'Active', 5000, 2, 0),
      (2, '2026-08-01', '2026-08-05', '2026-08-10', 'Active', 4000, 2, 1),
      (3, '2026-09-20', '2026-09-25', '2026-09-30', 'Active', 6000, 3, 1)

Update Reservation
Set ReservationStatus =
    Case
        When CheckOutDate < GETDATE() Then 'Completed'
        When CheckInDate > GETDATE() Then 'Upcoming'
        Else 'Active'
    End


Insert Into Guests
Values(5, 'Ahmed Ali', 'Egyptian', '123', '2002-05-15'),
      (6, 'Omar Hassan', 'Egyptian', '2345', '2001-11-20')

Insert Into ReservationsGuest
Values
    (1, 5),
    (2, 6)

Delete From dbo.ReservationsGuest
Where ReservationId = 1


Create Table #StaffUpdates
(
    StaffId Int,
    FullName VarChar(50),
    Position VarChar(50),
    Salary Decimal(8,2)
)

Insert Into #StaffUpdates
Values
    (1, 'Ahmed Ali', 'Manager', 1000),
    (2, 'Omar Hassan', 'Receptionist', 6000)


Merge Staff As Target
Using #StaffUpdates As Source
On Target.StaffId = Source.StaffId
When Matched Then
    Update Set Target.Position = Source.Position,
               Target.Salary = Source.Salary
When Not Matched By Target Then
    Insert (StaffId, FullName, Position, Salary)
    Values(Source.StaffId, Source.FullName, Source.Position, Source.Salary)
When Not Matched By Source Then
    Delete;


Use OnlineRetailStore
Alter Table Products
Drop Constraint FK_P_Categories

Alter Table Products
Add Constraint FK_P_Categories Foreign Key (CategoryId) References Categories(CategoryId)
On Delete Cascade

Alter Table Products
Drop Constraint FK_P_Categories

Alter Table Products
Add Constraint FK_P_Categories Foreign Key (CategoryId) References Categories(CategoryId)
On Delete No Action

Delete From Categories
Where CategoryId = 1

Alter Table Products
Add Constraint CK_P_UnitPrice Check (UnitPrice >= 0)

Alter Table Reviews
Add Constraint CK_R_Rating Check (Rating >= 1 And Rating <= 5)

Alter Table Shipments
Add Constraint CK_Sh_Dates Check (DeliveryDate >= ShipmentDate)

Select *
From Products

Select *
From Products
Where UnitPrice > 500

Select *
From Products
Order By UnitPrice Desc

Select Top 3 *
From Products
Order By UnitPrice Desc

Select CategoryId, Avg(UnitPrice) As AveragePrice
From Products
Where UnitPrice > 500
Group By CategoryId


Select Upper(FullName) 
From Customers

Select Lower(FullName) 
From Customers

Select Len(FullName) 
From Customers

Select Concat(FullName, ' - ', Email) 
From Customers

Select Substring(Name, 1, 3)
From Products

Select Replace(Name, 'a', 'A') 
From Products

Select Getdate() As CurrentDate

Select Year(RegistrationDate) ,
       Month(RegistrationDate) ,
       Day(RegistrationDate)
From Customers

Select Datediff(Year, RegistrationDate, Getdate())
From Customers;

Select Dateadd(Day, 30, RegistrationDate)
From Customers;

Select Abs(-100)

Select Floor(4.8) 

Select Ceiling(5.4) 

Select Round(125.567, 2) 

Select Count(*) As ProductCount,
       Avg(UnitPrice),
       Sum(UnitPrice),
       Min(UnitPrice),
       Max(UnitPrice)
From Products;