CREATE TABLE Customers (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(200) NOT NULL,
    Phone NVARCHAR(15) NOT NULL,
    Email NVARCHAR(200) NULL,
    Address NVARCHAR(300) NULL
);

CREATE TABLE Movies (
    MovieID INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(200) NOT NULL,
    MinimumPrice DECIMAL(10,2) NOT NULL, -- מחיר מינימום
    DefaultPricePerViewer DECIMAL(10,2) NOT NULL -- מחיר לצופה
);

CREATE TABLE Centers (
    CenterID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(200) NOT NULL,
    Location NVARCHAR(300) NOT NULL
);

CREATE TABLE Operators (
    OperatorID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(200) NOT NULL,
    Phone NVARCHAR(15) NOT NULL,
    Email NVARCHAR(200) NULL
);

CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT NOT NULL, -- הפניה ללקוח
    OperatorID INT NULL, -- הפניה למקרינה
    MovieID INT NOT NULL, -- הפניה לסרט
    OrderDate DATETIME DEFAULT GETDATE(),
    ScheduledDate DATETIME NOT NULL, -- תאריך הקרנה מתוכנן
    NumberOfViewers INT NOT NULL, -- כמות צופות
    Price DECIMAL(10,2) NOT NULL, -- המחיר הסופי
    IsPaid BIT DEFAULT 0, -- סטטוס תשלום: 0 - לא שולם, 1 - שולם
    Notes NVARCHAR(500) NULL, -- הערות נוספות
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (OperatorID) REFERENCES Operators(OperatorID),
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID)
);

CREATE TABLE USBKeys (
    USBKeyID INT IDENTITY(1,1) PRIMARY KEY,
    MovieID INT NOT NULL, -- הפניה לסרט שעל האונקי
    CenterID INT NOT NULL, -- מוקד אחסון
    CurrentLocation NVARCHAR(200) NOT NULL DEFAULT 'Center', -- מיקום נוכחי
    Status NVARCHAR(50) NOT NULL DEFAULT 'Available', -- סטטוס (זמין/בהשאלה)
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID),
    FOREIGN KEY (CenterID) REFERENCES Centers(CenterID)
);

CREATE TABLE USBKeysHistory (
    HistoryID INT IDENTITY(1,1) PRIMARY KEY,
    USBKeyID INT NOT NULL, -- הפניה לאונקי
    PreviousLocation NVARCHAR(200) NOT NULL, -- מיקום קודם
    NewLocation NVARCHAR(200) NOT NULL, -- מיקום חדש
    ChangeDate DATETIME DEFAULT GETDATE(), -- תאריך שינוי
    Notes NVARCHAR(500) NULL, -- הערות נוספות
    FOREIGN KEY (USBKeyID) REFERENCES USBKeys(USBKeyID)
);

CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(100) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(500) NOT NULL, -- סיסמה מוצפנת
    Role NVARCHAR(50) NOT NULL CHECK (Role IN ('Admin', 'Secretary')), -- סוג משתמש
    FullName NVARCHAR(200) NOT NULL
);
