const UserModel = require('../model/user.model');
const jwt = require('jsonwebtoken');
class userService {
    static async registerUser(username,password){
        try{
            const createUser  = new UserModel({username,password});
            return await createUser.save();
        }catch(err){
            throw err;
        }
    }
    static async checkUser(username){
        try{
           return await UserModel.findOne({username})
        }catch(err){
            throw err;
        }
    }
    static async generateToken(tokenData,secretKey,jwt_expire){
        return jwt.sign(tokenData,secretKey,{expiresIn:jwt_expire});
    }
}
module.exports = userService;