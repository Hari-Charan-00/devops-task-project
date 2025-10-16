const express = require('express');
const app = express();
const PORT = 8080;

app.get('/', (req, res) => {
  res.send('Hello, World! The video demo is working!');
});

app.listen(PORT, () => {
  console.log(`Server listening on port ${PORT}`);
});
