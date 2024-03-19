const mongoose =require('mongoose');

const bookMarkScehma=new mongoose.Schema({
    job:{
        type:mongoose.Schema.Types.ObjectId,
        ref:'Job'
    },
    userId : {
        type:String ,
        required : true
    }

},{timestamps:true});



module.exports=mongoose.model('Bookmark',bookMarkScehma);
