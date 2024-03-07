CREATE TABLE Employees (
EmployeeID INT,
FirstName VARCHAR(255),
LastName VARCHAR(255),
Department VARCHAR(255)
);
ALTER TABLE Employees
ADD Salary INT;
DROP TABLE Employees;

INSERT INTO Employees (EmployeeID, FirstName, LastName, Department)
VALUES (1, 'John', 'Smith', 'IT');
UPDATE Employees
SET Salary = 50000
WHERE EmployeeID = 1;
SELECT * FROM Employees;
DELETE FROM Employees
WHERE EmployeeID = 1;