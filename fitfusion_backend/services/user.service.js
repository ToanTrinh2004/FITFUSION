const UserModel = require('../model/user.model');
const UserInfoModel = require('../model/userInfo.model'); // Import UserInfoModel
const jwt = require('jsonwebtoken');
const { v4: uuidv4 } = require('uuid');

class userService {
    // Register a new user
    static async registerUser(username, password) {
        try {
            const createUser = new UserModel({ username, password });
            return await createUser.save();
        } catch (err) {
            throw err;
        }
    }

    // Check if a user exists
    static async checkUser(username) {
        try {
            return await UserModel.findOne({ username });
        } catch (err) {
            throw err;
        }
    }

    // Generate JWT Token
    static async generateToken(tokenData, secretKey, jwt_expire) {
        return jwt.sign(tokenData, secretKey, { expiresIn: jwt_expire });
    }

    // Create User Info with UUID
    static async createUserInfo(data) {
        try {
            data.userId = uuidv4(); // Generate UUID for userId
            const newUserInfo = new UserInfoModel(data);
            return await newUserInfo.save();
        } catch (err) {
            throw err;
        }
    }

    // Update User Info
    static async updateUserInfo(userId, updatedData) {
        try {
            return await UserInfoModel.findOneAndUpdate(
                { userId },
                updatedData,
                { new: true } // Returns the updated document
            );
        } catch (err) {
            throw err;
        }
    }
    static async showUserInfo(userId) {
        try {
            return await UserInfoModel.findOne({ userId });
        } catch (error) {
            throw error; // Fix: Throw 'error', not 'err'
        }
    }
    
}

module.exports = userService;
