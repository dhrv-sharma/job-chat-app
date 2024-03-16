const mongoose=require('mongoose');



// here uId from  firebase is not getting stored
const userSchema=new mongoose.Schema({
    username:{
        type:String,
        required: true,
        unique:true
    },
    email:{
        type: String,
        required: true,
        unique : true
    },
    password :{
        type:String,
        required: true
    },
    location :{
        type:String,
        required: false
    },
    phone :{
        type:String,
        required: false
    },
    updated :{
        type:Boolean,
        default:false// default value is false 
    },
    isAdmin :{
        type:Boolean,
        default:false// default value is false 
    },
    isAgent :{
        type:Boolean,
        default:false// default value is false 
    },
    skills:{
        type:Array,
        required:false // changed 
    },
    uid:{
        type:String,
        required :false,
    },
    profile:{
        type:String,
        required :false,
        default:"https://res.cloudinary.com/dap69mong/image/upload/v1710218011/dvrgmdivmrehe4czlzcq.jpg" // changed 
    }

    // In this example, when you save a document using YourModel, Mongoose automatically adds the createdAt and updatedAt fields to the document, which will be updated accordingly.
},{timestamps :true});

module.exports=mongoose.model('User',userSchema);