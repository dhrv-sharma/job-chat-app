
const jobs = require('../models/jobs');
const Job=require('../models/jobs');


// creating a new job 
const createJob = async(req,res) =>{
    const newJob=new Job(req.body);
    try {
        // saving the data to the mongo db 
        await newJob.save();

        // on success returining this 
        res.status(201).json({status:true,message:'Job Created Succesfully'});
        
    } catch (error) {
        res.status(500).json(error);
        
    }
}


// updating a existing job 
const updateJob= async(req,res)=>{

    const JobId= req.params.id;
    const update=req.body;

    try {
        const updateJob= await Job.findByIdAndUpdate(JobId,update,{new : true});
        if(!updateJob){
            return res.status(404).json({status: false , message : 'Job not Found'});
        }

        res.status(200).json({status : true,message : 'Job updated Succesfully '})
        
    } catch (error) {
        res.status(500).json(error);
        
    }

}


// delete job function
const deleteJob = async(req,res)=>{
    const jobId=req.params.id;

    try {
        await Job.findByIdAndDelete(jobId);
        res.status(200).json({status : true,message : 'Job deleted successfully. '});
        
    } catch (error) {
        res.status(500).json(error);
        
    }
}



// getJob
const getjob = async(req,res)=>{
    const jobId = req.params.id;
    try {
        const myJob=await Job.findById({_id:jobId},{createdAt : 0, updatedAt:0,_v:0});
        res.status(200).json(myJob);
        
    } catch (error) {
        res.status(500).json(error);
        
    }
}



// get all job
const getAllJobs= async(req,res)=>{
    const recent= req.query.new;

    try {
        let jobs;
        if (recent) {
            jobs=await Job.find({},{createdAt : 0, updatedAt:0,_v:0}).sort({createdAt:-1}).limit(2);
            
        }else{
            jobs=await Job.find({},{createdAt : 0, updatedAt:0,_v:0});
        }
        res.status(200).json(jobs);
        
    } catch (error) {
        res.status(500).json(error);
        
    }
}


// atlas search
const searchjob=async(req,res)=>{
    try {
        const results=await Job.aggregate([
            [
                {
                  $search: {
                    index: "jobsearch",
                    text: {
                      query: req.params.key,
                      path: {
                        wildcard: "*"
                      }
                    }
                  }
                }
              ]
        ])
        res.status(200).json(results);

    } catch (error) {
        res.status(500).json(error);
        
    }
}



module.exports ={createJob,updateJob,deleteJob,getjob,getAllJobs,searchjob};