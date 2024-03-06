const express = require('express');
const router=express.Router();
const jobController = require('../controllers/jobController');


// checked all
router.post("/",jobController.createJob);
router.get("/",jobController.getAllJobs);

// id is passed as an argument 
router.get("/:id",jobController.getjob);
router.put("/:id",jobController.updateJob);
router.delete("/:id",jobController.deleteJob);

router.get("/search/:key",jobController.searchjob);






module.exports = router;