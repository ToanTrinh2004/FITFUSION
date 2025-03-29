const router = require('express').Router();
const userController = require('../controller/user.controller');

// User Authentication
router.post('/registration', userController.register);
router.post('/login', userController.login);

// User Info Routes
router.post('/userInfo/create', userController.createUserInfo);
router.put('/userInfo/update/:userId', userController.updateUserInfo); // Fixed missing '/'
router.get('/userInfo/getUserInfo', userController.getUserInfo);


module.exports = router;
