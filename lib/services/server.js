const express = require('express');
const fs = require('fs');
const path = require('path');
const bodyParser = require('body-parser');

const app = express();
const port = 5000;

app.use(bodyParser.json());

// Path ke file db.json
const dbPath = path.join(__dirname, 'db.json');

// Membaca file db.json
const readDb = () => {
  const data = fs.readFileSync(dbPath);
  return JSON.parse(data);
};

// Endpoint untuk login
app.post('/login', (req, res) => {
  const { username, password } = req.body;
  const db = readDb();

  const user = db.users.find(u => u.username === username && u.password === password);

  if (user) {
    res.json({ success: true, message: 'Login successful' });
  } else {
    res.json({ success: false, message: 'Invalid username or password' });
  }
});

// Endpoint untuk mengambil resep
app.get('/recipes', (req, res) => {
  const db = readDb();
  res.json(db.recipes);
});

// Mulai server
app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});

