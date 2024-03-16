
const jobs = require('../models/jobs');
const Job=require('../models/jobs');


// creating a new job 
const createJob = async(req,res) =>{

    // body from web request 
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
    
    // here you you giving the data through params 
    const JobId= req.params.id;
    // here you are giving the data through body
    const update=req.body;

    try {
        // job id is identifier 
        // update is the new value to get updated
        // { new: true }: This is an options object specifying that Mongoose should return the modified document rather than the original one.
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
        // it takes first parameter as id which is unique 
        //  second paramter is inclusion and exclusion parameter means params: 0 in myJob you will not get params whose value (exclusion)is zero  and 1 for inclusion
        const myJob=await Job.findById({_id:jobId},{createdAt : 0, updatedAt:0,__v:0});
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
            // .sort({ createdAt: -1 }): This sorts the results based on the createdAt field in descending order (-1 indicates descending order). This means the most recent documents will appear first in the results.
            // .limit(2): This limits the number of documents returned to 2. It ensures that only the two most recent job documents are fetched from the collection.
            jobs=await Job.find({},{createdAt : 0, updatedAt:0,_v:0}).sort({createdAt:-1}).limit(2);
            
        }else{
            // return all jobs 
            jobs=await Job.find({},{createdAt : 0, updatedAt:0,_v:0});
        }
        res.status(200).json(jobs);
        
    } catch (error) {
        res.status(500).json(error);
        
    }
}

// req.body from body 
// req.params from route
// req.query.new from http function { "params":"value"}

// atlas search inbuilt mongo db search
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


// exporting
module.exports ={createJob,updateJob,deleteJob,getjob,getAllJobs,searchjob};