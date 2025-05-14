const express = require("express");
const router = express.Router();
const personalTrainerController = require("../controller/personalTrainer.controller");
const { verifyToken } = require('../middleware/auth.middleware');

router.post("/create",verifyToken, personalTrainerController.createTrainer);
router.get("/getAllTrainer", personalTrainerController.getAllTrainers);
router.get("/getById",verifyToken, personalTrainerController.getTrainerById);
router.put("/update/:id", personalTrainerController.updateTrainer);
router.delete("/delete/:id", personalTrainerController.deleteTrainer);

module.exports = router;
