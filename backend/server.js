const express = require('express');
const sqlite3 = require('sqlite3').verbose();
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();
const PORT = 3000;

// Middleware
app.use(cors());
app.use(bodyParser.json());

// SQLite DB setup
const db = new sqlite3.Database('farmers.db');

db.serialize(() => {
  db.run(`CREATE TABLE IF NOT EXISTS farmers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    email TEXT,
    phone TEXT,
    location TEXT,
    crops TEXT
  )`);

  // Insert dummy data if not exists
  db.get("SELECT COUNT(*) as count FROM farmers", (err, row) => {
    if (row.count === 0) {
      db.run(`INSERT INTO farmers (name, email, phone, location, crops)
              VALUES (?, ?, ?, ?, ?)`,
        ["Ashreeya Khadka", "ashreeya@example.com", "+977-9812345678", "Kavre", "Wheat, Maize"]);
    }
  });
});

// Get profile
app.get('/profile', (req, res) => {
  db.get("SELECT * FROM farmers LIMIT 1", (err, row) => {
    if (err) return res.status(500).send(err);
    res.json(row);
  });
});

// Update profile
app.post('/profile', (req, res) => {
  const { name, email, phone, location, crops } = req.body;
  db.run(`UPDATE farmers SET name = ?, email = ?, phone = ?, location = ?, crops = ? WHERE id = 1`,
    [name, email, phone, location, crops],
    function (err) {
      if (err) return res.status(500).send(err);
      res.json({ message: "Profile updated successfully" });
    });
});

app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
