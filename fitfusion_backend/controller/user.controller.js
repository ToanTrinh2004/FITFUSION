const userService = require('../services/user.service');
const UserInfoModel = require('../model/userInfo.model'); // Import missing model

// Register
exports.register = async (req, res, next) => {
    try {
        const { username, password } = req.body;
        const successRes = await userService.registerUser(username, password);
        res.json({ status: true, success: "User registered successfully" });
    } catch (error) {
        return res.status(500).json({ status: false, error: error.message });
    }
};

// Login
exports.login = async (req, res, next) => {
    try {
        const { username, password } = req.body;
        const user = await userService.checkUser(username);

        if (!user) {
            return res.status(404).json({ status: false, error: "User doesn't exist" });
        }

        const isMatch = await user.comparePassword(password);
        if (!isMatch) {
            return res.status(401).json({ status: false, error: "Password is incorrect" });
        }

        let tokenData = { _id: user._id, username: user.username };
        const token = await userService.generateToken(tokenData, 'secretKey', '1h');

        return res.status(200).json({ status: true, token });
    } catch (error) {
        return res.status(500).json({ status: false, error: error.message });
    }
};

// Create User Info
exports.createUserInfo = async (req, res, next) => {
    try {
        const newUserInfo = await userService.createUserInfo(req.body);
        res.status(201).json({ status: true, message: "User info created successfully", data: newUserInfo });
    } catch (error) {
        res.status(500).json({ status: false, error: error.message });
    }
};

// Update User Info
exports.updateUserInfo = async (req, res, next) => {
    try {
        const { userId } = req.params;
        const updatedUser = await userService.updateUserInfo(userId, req.body);

        if (!updatedUser) {
            return res.status(404).json({ status: false, error: "User not found" });
        }

        res.status(200).json({ status: true, message: "User info updated successfully", data: updatedUser });
    } catch (error) {
        res.status(500).json({ status: false, error: error.message });
    }
};
exports.getUserInfo = async (req, res, next) => {
    try {
        const { userId } = req.body; // Lấy userId từ req.body

        console.log("Received userId:", userId); // Debugging log

        if (!userId) {
            return res.status(400).json({ status: false, error: "Missing userId in request body" });
        }

        const displayUserInfo = await userService.showUserInfo(userId);

        if (!displayUserInfo) {
            return res.status(404).json({ status: false, error: "User not found" });
        }

        res.status(200).json({ status: true, data: displayUserInfo });
    } catch (error) {
        res.status(500).json({ status: false, error: error.message });
    }
};

