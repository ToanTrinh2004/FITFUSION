const RequestToHire = require("../model/requestToHire.model");
const Contract = require("../model/contract.model");
const PersonalTrainer = require("../model/personalTrainer.model");
const UserInfoModel = require('../model/userInfo.model'); // Import UserInfoModel
const db = require('../config/db'); // Ensure database connection is established

// Function to create a new hire request
exports.createHireRequest = async (data) => {
    try {
      // Ensure database connection is established
      if (db.readyState !== 1) {
        await new Promise(resolve => setTimeout(resolve, 1000));
        if (db.readyState !== 1) {
          throw new Error("Database connection not established");
        }
      }
  
      // Get customer and coach names by their custom IDs
      const customer = await UserInfoModel.findOne({ userId: data.customerId });
      const coach = await PersonalTrainer.findOne({ coachId: data.coachId });
  
      // Add customerName and coachName to the request data
      data.customerName = customer ? customer.fullname : "Unknown Customer";
      data.coachName = coach ? coach.fullName : "Unknown Coach";
  
      const request = new RequestToHire(data);
      return await request.save();
    } catch (error) {
      console.error("Error in createHireRequest:", error);
      throw error;
    }
  };
  
  exports.acceptRequestAndCreateContract = async (requestId) => {
    try {
      // Find the request by its ID
      const request = await RequestToHire.findById(requestId);
      if (!request) throw new Error("Request not found");
      if (request.status !== "pending") throw new Error("Request already processed");
  
      // Get customer and coach names by their custom IDs
      const customer = await UserInfoModel.findOne({ userId: request.customerId });
      const coach = await PersonalTrainer.findOne({ coachId: request.coachId });
  
      // Create a new contract with the customerName and coachName
      const contract = new Contract({
        customerId: request.customerId,
        customerName: customer ? customer.fullname : "Unknown Customer",
        coachId: request.coachId,
        coachName: coach ? coach.fullName : "Unknown Coach",
        duration: request.duration,
        schedule: request.schedule,
        fee: request.fee,
      });
      await contract.save();
  
      // Delete the request after the contract is created
      await RequestToHire.findByIdAndDelete(requestId);
  
      return contract;
    } catch (error) {
      console.error("Error in acceptRequestAndCreateContract:", error);
      throw error;
    }
  };

// Function to delete a request
exports.rejectedRequest = async (id) => {
  return await RequestToHire.findByIdAndDelete(id);
};

// Function to get contracts by customer ID
exports.getContractsByCustomerId = async (customerId) => {
  try {
    return await Contract.find({ customerId });
  } catch (error) {
    console.error("Error in getContractsByCustomerId:", error);
    throw error;
  }
};

// Function to get contracts by coach ID
exports.getContractsByCoachId = async (coachId) => {
  try {
    return await Contract.find({ coachId });
  } catch (error) {
    console.error("Error in getContractsByCoachId:", error);
    throw error;
  }
};

// Function to get requests by coach ID
exports.getRequestsByCoachId = async (coachId) => {
  try {
    return await RequestToHire.find({ coachId });
  } catch (error) {
    console.error("Error in getRequestsByCoachId:", error);
    throw error;
  }
};