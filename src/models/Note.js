const mongoose=require('mongoose');

const noteSchema=mongoose.Schema({
    id:{
        type:String,
        unique:true,
        require:true,    
    },
    userId:{
        type:String,
        require:true,    
    },
    title:{
        type:String,
        require:true,    
    },
    content:{
        type:String,
           
    },
    dateAdded:{
        type:Date,
        default:Date.now,    
    }
});

module.exports= mongoose.model("Note",noteSchema);