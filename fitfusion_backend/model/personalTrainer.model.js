const mongoose = require("mongoose");
const db = require('../config/db'); // Use shared DB connection


const { Schema } = mongoose;

const PersonalTrainerSchema = new Schema({
  coachId: { type: String, requrie :true }, 
  fullName: { type: String, required: true },
  age: { type: Number, required: true, min: 18 },
  gender: { type: String, enum: ["Male", "Female", "Other"], required: true },
  major: { type: String, required: true },
  tuitionFees: { type: Number, required: true, min: 0 },
  introduction: { type: String, required: true },
});

const PersonalTrainer = db.model("PersonalTrainer", PersonalTrainerSchema);

module.exports = PersonalTrainer;
