const mongoose = require("mongoose");
const { Schema } = mongoose;
const db = require('../config/db'); // Use shared DB connection
// Note: explicitly set the collection name to match what MongoDB expects
const requestToHireSchema = new Schema({
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
  status: {
    type: String,
    enum: ['pending', 'accepted', 'rejected'],
    default: 'pending',
  },
}, { 
  timestamps: true,
  collection: 'requesttohires' // Explicitly set collection name to match error message
});

// Use the shared connection to create the model
module.exports = db.model('RequestToHire', requestToHireSchema);