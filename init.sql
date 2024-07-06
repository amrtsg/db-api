-- Create tables
CREATE TABLE Users (
    UserID SERIAL PRIMARY KEY,
    UserName VARCHAR(255) NOT NULL
);

CREATE TABLE Vehicles (
    VehicleID SERIAL PRIMARY KEY,
    UserID INTEGER REFERENCES Users(UserID),
    Model VARCHAR(255) NOT NULL,
    Make VARCHAR(255) NOT NULL
);

-- Insert initial data
-- Users
INSERT INTO Users (UserName) VALUES ('Alice'), ('Bob'), ('Charlie');

-- Vehicles
-- Ensure UserID values match existing UserIDs in the Users table
INSERT INTO Vehicles (UserID, Model, Make) VALUES
    (1, 'Model S', 'Tesla'),
    (1, 'Camry', 'Toyota'),
    (2, 'Accord', 'Honda'),
    (2, 'Mustang', 'Ford');

