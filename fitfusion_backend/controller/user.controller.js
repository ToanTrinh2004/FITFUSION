const userService = require('../services/user.service');
const UserInfoModel = require('../model/userInfo.model');

// Register
exports.register = async (req, res, next) => {
    try {
        const { username, password, role } = req.body;

        const existingUser = await userService.checkUser(username);
        if (existingUser) {
            return res.status(400).json({ status: false, error: "Username already exists" });
        }

        const newUser = await userService.registerUser(username, password, role);

        const tokenData = { _id: newUser.userId, username: newUser.username, role: newUser.role };
        const token = await userService.generateToken(tokenData, 'secretKey', '1h');

        res.json({ status: true, message: "User registered successfully", token });
    } catch (error) {
        return res.status(500).json({ status: false, error: error.message });
    }
};

// Login
exports.login = async (req, res, next) => {
    try {
        const { username, password, role } = req.body; // role is sent from client

        const user = await userService.checkUser(username);
        if (!user) {
            return res.status(404).json({ status: false, error: "User doesn't exist" });
        }

        const isMatch = await user.comparePassword(password);
        if (!isMatch) {
            return res.status(401).json({ status: false, error: "Password is incorrect" });
        }

        // ✅ Check the role if provided
        if (role && parseInt(role) !== user.role) {
            return res.status(403).json({ status: false, error: "Unauthorized role" });
        }

        const tokenData = { _id: user.userId, username: user.username, role: user.role };
        const token = await userService.generateToken(tokenData, 'secretKey', '1h');

        return res.status(200).json({ status: true, token });
    } catch (error) {
        return res.status(500).json({ status: false, error: error.message });
    }
};

// Create User Info
exports.createUserInfo = async (req, res, next) => {
    try {
        const userId = req.user._id;
        const data = { ...req.body, userId };
        console.log(userId)

        const newUserInfo = await userService.createUserInfo(data);
        res.status(201).json({ status: true, message: "User info created successfully", data: newUserInfo });
    } catch (error) {
        res.status(500).json({ status: false, error: error.message });
    }
};


// Update User Info
exports.updateUserInfo = async (req, res, next) => {
    try {
        const userId = req.user._id;
        const updatedUser = await userService.updateUserInfo(userId, req.body);

        if (!updatedUser) {
            return res.status(404).json({ status: false, error: "User not found" });
        }

        res.status(200).json({ status: true, message: "User info updated successfully", data: updatedUser });
    } catch (error) {
        res.status(500).json({ status: false, error: error.message });
    }
};

// Get User Info
exports.getUserInfo = async (req, res, next) => {
    try {
        const userId = req.user._id;

        const displayUserInfo = await userService.showUserInfo(userId);
        if (!displayUserInfo) {
            return res.status(404).json({ status: false, error: "User not found" });
        }

        res.status(200).json({ status: true, data: displayUserInfo });
    } catch (error) {
        res.status(500).json({ status: false, error: error.message });
    }
};

// ======= CRUD for UserModel =======

// Get all users (admin use)
exports.getUsers = async (req, res) => {
    try {
        const users = await userService.getAllUsers();
        res.status(200).json({ status: true, data: users });
    } catch (error) {
        res.status(500).json({ status: false, error: error.message });
    }
};

// Get current user
exports.getUser = async (req, res) => {
    try {
        const user = await userService.getUserById(req.user._id);
        if (!user) return res.status(404).json({ status: false, error: "User not found" });
        res.status(200).json({ status: true, data: user });
    } catch (error) {
        res.status(500).json({ status: false, error: error.message });
    }
};

// Update current user
exports.updateUser = async (req, res) => {
    try {
        const updatedUser = await userService.updateUser(req.user._id, req.body);
        if (!updatedUser) return res.status(404).json({ status: false, error: "User not found" });
        res.status(200).json({ status: true, message: "User updated", data: updatedUser });
    } catch (error) {
        res.status(500).json({ status: false, error: error.message });
    }
};

// Delete current user
exports.deleteUser = async (req, res) => {
    try {
        const id = req.body
        const deleted = await userService.deleteUser(id);
        if (!deleted) return res.status(404).json({ status: false, error: "User not found" });
        res.status(200).json({ status: true, message: "User deleted" });
    } catch (error) {
        res.status(500).json({ status: false, error: error.message });
    }
};
