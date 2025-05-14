const mongoose = require("mongoose");
const db = require('../config/db'); // Use shared DB connection
const { Schema } = mongoose;

const contractSchema = new Schema({
  customerId: {
    type: String,
    required: true,
  },
  customerName :{
    type: String
  },
  coachId: {
    type: String,
    required: true,
  },
  coachName :{
    type :String
  },
  duration: {
    type: String,
    required: true,
  },
  schedule: {
    type: [
      {
        day: { type: String, required: true },
        time: { type: String, required: true }
      }
    ],
    required: true,
  },
  fee: {
    type: Number,
    required: true,
  },
  signedAt: {
    type: Date,
    default: Date.now,
  },
}, { 
  timestamps: true,
  collection: 'contracts' // Explicitly set collection name
});

 module.exports = db.model('Contract', contractSchema);