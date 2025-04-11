require('dotenv').config();
const mongoose = require('mongoose');

const connection = mongoose.createConnection(process.env.MONGO_URI)
  .on('open', () => {
    console.log("Connected to MongoDB Atlas");
  })
  .on('error', (err) => {
    console.log("Connection error to MongoDB Atlas:", err);
  });

module.exports = connection;
