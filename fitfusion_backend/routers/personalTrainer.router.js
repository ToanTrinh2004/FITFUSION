const express = require("express");
const router = express.Router();
const personalTrainerController = require("../controller/personalTrainer.controller");

router.post("/", personalTrainerController.createTrainer);
router.get("/", personalTrainerController.getAllTrainers);
router.get("/:id", personalTrainerController.getTrainerById);
router.put("/:id", personalTrainerController.updateTrainer);
router.delete("/:id", personalTrainerController.deleteTrainer);

module.exports = router;
