const mongoose= require('mongoose');

// time stamps is used in the case when the object is created it actuals store the time of creation as well
// here comapny name is not getting stored
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
    
    // In this example, when you save a document using YourModel, Mongoose automatically adds the createdAt and updatedAt fields to the document, which will be updated accordingly.

},{timestamps : true});



// will strore as jobs in mongodb
module.exports = mongoose.model('Job',JobSchema);