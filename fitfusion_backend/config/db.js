const mongoose =  require('mongoose')
const connection = mongoose.createConnection('mongodb://localhost:27017/FITFUSION').on('open',()=>{
    console.log("db connected");
    
}).on('error',()=>{
    console.log("db not connected");
    
});
module.exports = connection;
