const { response } = require('express');
const express=require('express');
const app=express();
const mongoose=require('mongoose');

const Note=require('./models/Note');

const bodyParser=require('body-parser');

app.use(bodyParser.urlencoded({extended:false,}));
app.use(bodyParser.json());


mongoose.connect('mongodb+srv://AsnanSultan:asnan385@cluster0.xpnub.mongodb.net/notesdb').then(function(){
    app.get("/", function(req,res){
        const response={massage:'Api  Works!'};
        res.json(response);
    });
    
  const noteRouter=require('./routes/Note');
  app.use('/notes',noteRouter);

});

const PORT=process.env.PORT || 5000;
app.listen(PORT,function(){
    console.log('Server Started at port: '+`${PORT}`);
});