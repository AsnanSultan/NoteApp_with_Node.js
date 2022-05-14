const express = require('express');
const Note=require('./../models/Note');
const router=express.Router();

router.post("/list",async function(req,res){
        
    var notes=await Note.find({userId:req.body.userId,});
    res.json(notes);
});
router.post("/add",async function(req,res){
    
   await Note.deleteOne({id:req.body.id,});
    const newNote=Note({
        id:req.body.id,
        userId:req.body.userId,
        title:req.body.title,
        content:req.body.content,
    });
    await newNote.save();
    var response={massage: "New Note is Saved"+ ` id: ${req.body.id}`};
    res.json(response);
});

router.post('/delete',async function(req,res){
    await Note.deleteOne({id:req.body.id,});
    var response={massage: "Note is deleted"+ ` id: ${req.body.id}`};
    res.json(response);
});

module.exports=router;