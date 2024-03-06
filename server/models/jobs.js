const mongoose= require('mongoose');

// time stamps is used in the case when the object is created it actuals store the time of creation as well
const JobSchema= new mongoose.Schema({
    title : {
        type:String,
        required:true
    },
    location : {
        type:String,
        required:true
    },
    description : {
        type:String,
        required:true
    },
    agentName : {
        type:String,
        required:true
    },
    salary : {
        type:String,
        required:true
    },
    period : {
        type:String,
        required:true
    },
    contract : {
        type:String,
        required:true
    },
    hiring : {
        type:Boolean,
        required:true,
        default: true
    },
    requirements : {
        type:Array,
        required:true
    },
    imageUrl : {
        type:String,
        required:true
    },
    agentId : {
        type:String,
        required:true
    },
    

},{timestamps : true});



// will strore as jobs in mongodb
module.exports = mongoose.model('Job',JobSchema);