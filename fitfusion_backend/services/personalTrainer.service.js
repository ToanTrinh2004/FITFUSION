const PersonalTrainer = require("../model/PersonalTrainer");

class PersonalTrainerService {
  async createTrainer(data) {
    return await PersonalTrainer.create(data);
  }

  async getAllTrainers() {
    return await PersonalTrainer.find();
  }

  async getTrainerById(id) {
    return await PersonalTrainer.findById(id);
  }

  async updateTrainer(id, data) {
    return await PersonalTrainer.findByIdAndUpdate(id, data, { new: true });
  }

  async deleteTrainer(id) {
    return await PersonalTrainer.findByIdAndDelete(id);
  }
}

module.exports = new PersonalTrainerService();
