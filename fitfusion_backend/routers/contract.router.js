const express = require("express");
const router = express.Router();
const contractController = require("../controller/contract.controller");
const { verifyToken } = require('../middleware/auth.middleware');

router.post("/accept/:requestId", contractController.acceptRequest);
router.get("/user/",verifyToken, contractController.getContractsByUserId);
router.get("/coach/:coachId", contractController.getContractsByCoachId);
router.get("/requests/coach/:coachId", contractController.getRequestsByCoachId);
router.post('/request',verifyToken, contractController.createHireRequest);
router.delete('/request/:id',contractController.rejectRequest)
router.get('/contracts', contractController.getAllContractsHandler);
router.delete('/contracts/:id', contractController.deleteContractHandler);
module.exports = router;