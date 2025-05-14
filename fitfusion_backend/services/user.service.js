const UserModel = require('../model/user.model');
const UserInfoModel = require('../model/userInfo.model'); // Import UserInfoModel
const jwt = require('jsonwebtoken');
const { v4: uuidv4 } = require('uuid');

class userService {
    // Register a new user
    static async registerUser(username, password, role = 1) {
        try {
            const createUser = new UserModel({ username, password, role });
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

    static async getAllUsers() {
        try {
            return await UserModel.find({}, { password: 0 }); // exclude password for security
        } catch (err) {
            throw err;
        }
    }

    // Get one user by ID
    static async getUserById(userId) {
        try {
            return await UserModel.findById(userId, { password: 0 }); // exclude password
        } catch (err) {
            throw err;
        }
    }

    // Update user (username, role — not password here)
    static async updateUser(userId, updateData) {
        try {
            // Don't allow password update through this method
            delete updateData.password;

            return await UserModel.findByIdAndUpdate(
                userId,
                updateData,
                { new: true, select: '-password' } // Return updated doc without password
            );
        } catch (err) {
            throw err;
        }
    }

    // Delete user
    static async deleteUser(userId) {
        try {
            // Use findOneAndDelete to find and delete by custom userId field
            return await UserModel.findOneAndDelete({ userId });
        } catch (err) {
            throw err;
        }
    }

}

module.exports = userService;
