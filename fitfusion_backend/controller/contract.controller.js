const contractService = require("../services/contract.service");
// Modify this function in your controller
exports.createHireRequest = async (req, res) => {
  try {
    console.log("Received hire request:", req.body);
    
    // Data validation
    const { customerId, coachId, duration, schedule, fee } = req.body;
    
    if (!customerId || !coachId || !duration || !schedule || !fee) {
      return res.status(400).json({ 
        success: false, 
        error: "Missing required fields" 
      });
    }
    
    // Proceed with service call
    const request = await contractService.createHireRequest(req.body);
    
    return res.status(201).json({ success: true, data: request });
  } catch (error) {
    console.error("Controller error:", error);
    return res.status(500).json({ 
      success: false, 
      error: error.message,
      stack: process.env.NODE_ENV === 'development' ? error.stack : undefined
    });
  }
};

exports.acceptRequest = async (req, res) => {
  try {
    const contract = await contractService.acceptRequestAndCreateContract(req.params.requestId);
    res.status(201).json({ success: true, contract });
  } catch (error) {
    res.status(400).json({ success: false, message: error.message });
  }
};

exports.getContractsByUserId = async (req, res) => {
  try {
    const contracts = await contractService.getContractsByCustomerId(req.params.userId);
    res.status(200).json({ success: true, contracts });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

exports.getContractsByCoachId = async (req, res) => {
  try {
    const contracts = await contractService.getContractsByCoachId(req.params.coachId);
    res.status(200).json({ success: true, contracts });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

exports.getRequestsByCoachId = async (req, res) => {
  try {
    const requests = await contractService.getRequestsByCoachId(req.params.coachId);
    res.status(200).json({ success: true, requests });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};
exports.rejectRequest = async (req,res) =>{
  try {
       const request = await contractService.rejectedRequest(req.params.id);
       if (!request) {
         return res.status(404).json({ success: false, error: "request not found" });
       }
       res.status(200).json({ success: true, message: "request deleted successfully" });
     } catch (error) {
       res.status(500).json({ success: false, error: error.message });
     }
}