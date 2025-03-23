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
exports.login = async (req, res, next) => {
    try {
        const { username, password } = req.body;
        const user = await userService.checkUser(username);
        
        if (!user) {
            return res.status(404).json({ status: false, error: "User doesn't exist" });
        }

        const isMatch = await user.comparePassword(password);
        if (!isMatch) {
            return res.status(401).json({ status: false, error: "Password is incorrect" });
        }

        let tokenData = { _id: user._id, username: user.username };
        const token = await userService.generateToken(tokenData, 'secretKey', '1h');

        return res.status(200).json({ status: true, token: token });
    } catch (error) {
        return res.status(500).json({ status: false, error: error.message });
    }
};
