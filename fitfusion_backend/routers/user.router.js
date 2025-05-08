const router = require('express').Router();
const userController = require('../controller/user.controller');
const { verifyToken } = require('../middleware/auth.middleware');

// Auth Routes
router.post('/registration', userController.register);
router.post('/login', userController.login);

// User Info Routes
router.post('/userinfo/create', verifyToken, userController.createUserInfo);
router.put('/userinfo/update', verifyToken, userController.updateUserInfo);
router.get('/userinfo', verifyToken, userController.getUserInfo);

// User CRUD Routes (Admin or self-management)
router.get('/users', verifyToken, userController.getUsers);         // Get all users
router.get('/user', verifyToken, userController.getUser);           // Get current user
router.put('/user/update', verifyToken, userController.updateUser); // Update current user
router.delete('/user/delete', verifyToken, userController.deleteUser); // Delete current user

module.exports = router;
