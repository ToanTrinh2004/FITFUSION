const app = require('./app');
const db = require('./config/db');
const port = 3000;
const UserModel = require('./model/user.model');

app.listen(port,()=>{
    console.log(`Sever listening in port : ${port}`);
});