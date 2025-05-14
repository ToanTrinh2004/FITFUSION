const PersonalTrainer = require("../model/personalTrainer.model");

class PersonalTrainerService {
  async createTrainer(data) {
    try {
      const createPT = new PersonalTrainer(data); // 
      return await createPT.save();
    } catch (error) {
      throw error; // 
    }
    
  }

  async getAllTrainers() {
    return await PersonalTrainer.find();
  }

  async getTrainerById(coachId) {
    return await PersonalTrainer.findOne({ coachId }); 
  }

  async updateTrainer(id, data) {
    return await PersonalTrainer.findByIdAndUpdate(id, data, { new: true });
  }

  async deleteTrainer(id) {
    return await PersonalTrainer.findByIdAndDelete(id);
  }
}

module.exports = new PersonalTrainerService();
