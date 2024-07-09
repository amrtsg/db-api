
const express = require('express');
const pool = require('./db');

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware to parse JSON requests
app.use(express.json());

// Route to get all users
app.get('/users', async (req, res) => {
    try {
        const { rows } = await pool.query('SELECT * FROM users');
        res.json(rows);
    } catch (err) {
        console.error('Error executing query', err);
        res.status(500).json({ message: 'Internal server error' });
    }
});

// Route to get all vehicles
app.get('/vehicles', async (req, res) => {
    try {
        const { rows } = await pool.query('SELECT * FROM vehicles');
        res.json(rows);
    } catch (err) {
        console.error('Error executing query', err);
        res.status(500).json({ message: 'Internal server error' });
    }
});

// Route to add a new vehicle with parameters in the URL path
app.post('/addvehicle/:userID/:model/:make', async (req, res) => {
    const { userID, model, make } = req.params;

    try {
        const { rows } = await pool.query(
            'INSERT INTO vehicles (UserID, Model, Make) VALUES ($1, $2, $3) RETURNING *',
            [userID, model, make]
        );
        res.status(201).json(rows[0]);
    } catch (err) {
        console.error('Error executing query', err);
        res.status(500).json({ message: 'Internal server error' });
    }
});

// Route to remove a vehicle
app.delete('/removevehicle/:vehicleID', async (req, res) => {
    const { vehicleID } = req.params;

    try {
        const { rowCount } = await pool.query(
            'DELETE FROM vehicles WHERE VehicleID = $1',
            [vehicleID]
        );

        if (rowCount === 0) {
            return res.status(404).json({ message: 'Vehicle not found' });
        }

        res.status(200).json({ message: 'Vehicle removed successfully' });
    } catch (err) {
        console.error('Error executing query', err);
        res.status(500).json({ message: 'Internal server error' });
    }
});

// Route to get the primary vehicle ID for a user
app.get('/getprimary/:userID', async (req, res) => {
    const { userID } = req.params;

    try {
        const { rows } = await pool.query(
            'SELECT PrimaryVehicle FROM users WHERE UserID = $1',
            [userID]
        );
        
        if (rows.length === 0) {
            return res.status(404).json({ message: 'User not found' });
        }
        
        res.json({ primaryVehicleID: rows[0].primaryvehicle });
    } catch (err) {
        console.error('Error executing query', err);
        res.status(500).json({ message: 'Internal server error' });
    }
});

// Route to set the primary vehicle for a user
app.put('/setprimary/:userID/:vehicleID', async (req, res) => {
    const { userID, vehicleID } = req.params;

    try {
        const { rowCount } = await pool.query(
            'UPDATE users SET PrimaryVehicle = $1 WHERE UserID = $2',
            [vehicleID, userID]
        );

        if (rowCount === 0) {
            return res.status(404).json({ message: 'User not found' });
        }

        res.status(200).json({ message: 'Primary vehicle updated successfully' });
    } catch (err) {
        console.error('Error executing query', err);
        res.status(500).json({ message: 'Internal server error' });
    }
});

// Start server
app.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);
});
