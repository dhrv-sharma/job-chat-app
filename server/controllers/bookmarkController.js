
const bookMark=require('../models/bookmark');
const job=require('../models/jobs');


// multiple job id can be present in multiple user 
// hence user id must be unique 
// creating a bookMark
// we need a user id 
const createBookmark =async (req,res)=> {
    const jobId = req.body.job;
    const userId= req.user.id;

    

    try{
        const myJob= await job.findById(jobId);
        if (!job) {
            return res.status(400).json({
                message:"Job not found"
            });
        }

        const newBookMark= new bookMark({job:jobId,userId:userId});
        const savebookMark=await  newBookMark.save();
        return res.status(200).json({
            status:true,
            bookMarkId :savebookMark._id

        })

    }catch (error){
        res.status(400).json({
            message:error.message
        });

    }

}

// delete bookmark
const deleteBookmark = async (req,res)=>{
    const bookMarkId= req.params.id;
    try {
        await bookMark.findByIdAndDelete(bookMarkId);
        res.status(200).json({
            status:true,
            message:"Bookmark deleted"
        });
        
    } catch (error) {
        res.status(400).json({
            message:error.message
        });
        
    }
}


// getAll marks of user
// we need user id 
const getAllBookmark = async (req,res)=>{
    
    const userId= req.user.id;


    try{
        const bookMarks = await bookMark.find({
            userId:userId
        },{createdAt:0,updatedAt:0,__v:0}).populate({
            path:'job',
            select:"-requirements -description -createdAt -updatedAt -__v" // excluding these property

        });

        res.status(200).json(bookMarks);


    }catch(error){
        res.status(400).json({
            message:error.message
            
        });
    }

}


// getting single bookmark
//need job id and user id 
const getSingleBookmark = async(req,res) =>{
    const jobId=req.params.id;
    const userId=req.user.id;

    try {
        const myBookmark= await bookMark.findOne({userId :userId,job:jobId});
        if (!myBookmark) {
            return res.status(200).json({
                status:false,
                bookMarkId:"none"
            })
        }

        res.status(200).json({
            status:true,
            bookMarkId:myBookmark._id
        })
        
    } catch (error) {
        res.status(400).json({
            message:error.message
            
        });
        
    }

}


module.exports={createBookmark,deleteBookmark,getAllBookmark,getSingleBookmark};

