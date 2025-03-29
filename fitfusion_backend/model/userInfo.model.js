const mongoose = require('mongoose');
const db = require('../config/db');
const { v4: uuidv4 } = require('uuid');

const userSchema = new mongoose.Schema({
    userId: { type: String, required: true, unique: true, default: uuidv4 },
    fullname: { type: String },
    gender: { type: String, enum: ["Male", "Female", "Other"] },
    weight: { type: Number },
    height: { type: Number },
    age: { type: Number },
    status: { type: String },
    finishDate: { type: Date },
    startDate: { type: Date, default: Date.now },
    aimWeight: { type: Number },
    phone: { type: String }
});

const UserInfoModel = db.model('userInfo', userSchema);

module.exports = UserInfoModel;
