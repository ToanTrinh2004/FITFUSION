const mongoose =  require('mongoose');
const db = require('../config/db');
const bcrypt = require('bcrypt');
const { Schema } = mongoose;


const useSchema = new mongoose.Schema({
    username: { type: String, required: true, unique: true },
    password: { type: String, required: true },
    fullname: { type: String,  },
    gender: { type: String, enum: ["Male", "Female", "Other"],  },
    weight: { type: Number,  },
    height: { type: Number,  },
    age: { type: Number,},
    status: { type: String },
    finishDate: { type: Date },
    startDate: { type: Date, default: Date.now },
    aimweight: { type: Number },
    phone: { type: String, }
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
