const express = require('express');
const mysql = require('mysql');
const cors = require('cors');

const app = express();
app.use(cors()); 
const port = 3000; // You can change the port if needed

// Database connection configuration
const connection = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database: "hookah" // Your database name
});

// Connect to the database
connection.connect((err) => {
  if (err) {
    console.error('Error connecting to the database:', err.stack);
    return;
  }
  console.log('Connected to the database as ID', connection.threadId);
});

// API endpoint to get products
app.get('/api/products', (req, res) => {
  const sql = 'SELECT * FROM products';

  connection.query(sql, (error, results) => {
    if (error) {
      console.error('Error querying products:', error.stack);
      return res.status(500).json({ error: 'Database query failed' });
    }

    // Return the results as JSON
    res.json(results);
  });
});

// Start the server
app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
