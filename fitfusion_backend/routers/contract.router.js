const express = require("express");
const router = express.Router();
const contractController = require("../controller/contract.controller");

router.post("/accept/:requestId", contractController.acceptRequest);
router.get("/user/:userId", contractController.getContractsByUserId);
router.get("/coach/:coachId", contractController.getContractsByCoachId);
router.get("/requests/coach/:coachId", contractController.getRequestsByCoachId);
router.post('/request', contractController.createHireRequest);
router.delete('/request/:id',contractController.rejectRequest)
module.exports = router;