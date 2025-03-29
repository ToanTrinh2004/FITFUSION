const mongoose =  require('mongoose');
const db = require('../config/db');
const bcrypt = require('bcrypt');
const { Schema } = mongoose;
const { v4: uuidv4 } = require('uuid');

const useSchema = new mongoose.Schema({
    userId: { type: String, default: uuidv4 }, 
    username: { type: String, required: true, unique: true },
    password: { type: String, required: true },
});
useSchema.pre('save', async function (next) {
    try {
        if (!this.isModified("password")) return next();
        
        const salt = await bcrypt.genSalt(10);
        this.password = await bcrypt.hash(this.password, salt);
        
        next();
    } catch (error) {
        next(error);
    }
});

useSchema.methods.comparePassword = async function (userPassword) {
    try {
        return await bcrypt.compare(userPassword, this.password);
    } catch (error) {
        throw error;
    }
};

const UserModel = db.model('user',useSchema);

module.exports = UserModel;
