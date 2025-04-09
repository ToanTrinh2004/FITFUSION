const express = require('express');
const router = express.Router();
const chatbotController = require('../controller/chatbot.controller');

// Định nghĩa route và gọi controller
router.post('/meals', chatbotController.generateMealPlan);
router.post('/caloriesCalculate',chatbotController.calculateCalories);

module.exports = router;
