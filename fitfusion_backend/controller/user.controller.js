const userService = require('../services/user.service');

// Register
exports.register = async(req,res,next)=>{
    try {
        const {username,password} = req.body;
        const successRes = await userService.registerUser(username,password);
        res.json({status:true,success:"User Register Successfully"})
    } catch (error) {
        
    }
}
//Login
exports.login = async(req,res,next)=>{
    try {
        const {username,password} = req.body;
        const user = await userService.checkUser(username);
        if(!user){
            throw new error("User doesn't exist")
        }
        const isMatch = await user.comparePassword(password);
        if(isMatch===false){
            throw new error("password is incorrect");
            
        }
        let tokenData = {_id:user._id,username:user.username};
        const token = await userService.generateToken(tokenData,'secretKey','1h');
        res.status(200).json({status:true,token:token})
    } catch (error) {
        
    }
}