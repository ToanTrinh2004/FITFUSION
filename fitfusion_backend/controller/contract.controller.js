const contractService = require("../services/contract.service");
// Modify this function in your controller
exports.createHireRequest = async (req, res) => {
  try {
    // Take customerId from the token (overriding body)
    const customerId = req.user._id;

    // Extract the rest from req.body
    const { coachId, duration, schedule, fee } = req.body;

    console.log("Customer ID from token:", customerId);
    console.log("Received hire request:", req.body);

    // Validate required fields
    if (!customerId || !coachId || !duration || !schedule || !fee) {
      return res.status(400).json({ 
        success: false, 
        error: "Missing required fields" 
      });
    }

    // Build request payload with token's customerId
    const hireRequestData = {
      customerId,
      coachId,
      duration,
      schedule,
      fee
    };

    // Call the service
    const request = await contractService.createHireRequest(hireRequestData);

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
    const contracts = await contractService.getContractsByCustomerId(req.user._id);
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
exports.getAllContractsHandler = async (req, res) => {
  try {
    const contracts = await contractService.getAllContracts();
    res.status(200).json({ success: true, contracts });
  } catch (error) {
    res.status(500).json({ success: false, message: "Failed to fetch contracts", error: error.message });
  }
};
exports.deleteContractHandler = async (req, res) => {
  const { id } = req.params;

  try {
    const deletedContract = await contractService.deleteContractById(id);
    res.status(200).json({ success: true, message: "Contract deleted successfully", contract: deletedContract });
  } catch (error) {
    res.status(500).json({ success: false, message: "Failed to delete contract", error: error.message });
  }
};