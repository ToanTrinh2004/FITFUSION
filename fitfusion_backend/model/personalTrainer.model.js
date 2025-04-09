const mongoose = require("mongoose");

const personalTrainerSchema = new mongoose.Schema({
  fullName: { type: String, required: true },
  age: { type: Number, required: true, min: 18 },
  gender: { type: String, enum: ["Male", "Female", "Other"], required: true },
  major: { type: String, required: true },
  tuitionFees: { type: Number, required: true, min: 0 },
  introduction: { type: String, required: true },
});

const personalTrainer = mongoose.model("PersonalTrainer", personalTrainerSchema);
