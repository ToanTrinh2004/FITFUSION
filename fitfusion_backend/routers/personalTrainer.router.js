const express = require("express");
const router = express.Router();
const personalTrainerController = require("../controller/personalTrainer.controller");

router.post("/create", personalTrainerController.createTrainer);
router.get("/getAllTrainer", personalTrainerController.getAllTrainers);
router.get("/getById/:id", personalTrainerController.getTrainerById);
router.put("/update/:id", personalTrainerController.updateTrainer);
router.delete("/delete/:id", personalTrainerController.deleteTrainer);

module.exports = router;
