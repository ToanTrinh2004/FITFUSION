const personalTrainerService = require("../services/personalTrainer.service");

class PersonalTrainerController {
  async createTrainer(req, res) {
    try {
      const coachId= req.user._id;
      req.body.coachId = coachId
      const trainer = await personalTrainerService.createTrainer(req.body);
      res.status(201).json({ success: true, data: trainer });
    } catch (error) {
      res.status(400).json({ success: false, error: error.message });
    }
  }

  async getAllTrainers(req, res) {
    try {
      const trainers = await personalTrainerService.getAllTrainers();
      res.status(200).json({ success: true, data: trainers });
    } catch (error) {
      res.status(500).json({ success: false, error: error.message });
    }
  }

  async getTrainerById(req, res) {
    try {
      const coachId = req.user._id;
      const trainer = await personalTrainerService.getTrainerById(coachId);
      if (!trainer) {
        return res.status(404).json({ success: false, error: "Trainer not found" });
      }
      res.status(200).json({ success: true, data: trainer });
    } catch (error) {
      res.status(500).json({ success: false, error: error.message });
    }
  }

  async updateTrainer(req, res) {
    try {
      const trainer = await personalTrainerService.updateTrainer(req.params.id, req.body);
      if (!trainer) {
        return res.status(404).json({ success: false, error: "Trainer not found" });
      }
      res.status(200).json({ success: true, data: trainer });
    } catch (error) {
      res.status(400).json({ success: false, error: error.message });
    }
  }

  async deleteTrainer(req, res) {
    try {
      const trainer = await personalTrainerService.deleteTrainer(req.params.id);
      if (!trainer) {
        return res.status(404).json({ success: false, error: "Trainer not found" });
      }
      res.status(200).json({ success: true, message: "Trainer deleted successfully" });
    } catch (error) {
      res.status(500).json({ success: false, error: error.message });
    }
  }
}

module.exports = new PersonalTrainerController();
