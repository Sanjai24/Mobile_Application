const UserModel = require("../models/userModel");
const jwt = require("jsonwebtoken");    
const moment = require('moment');

const maxAge = 3*24*60*60;

const userController = {
    async home_get(req, res){
        res.render('home');
    },

    async signup_get(req,res){
        res.render('signup');
    },

    async login_get(req,res){
        res.render('login');
    },

    async logout_post(req, res){
        res.cookie('jwt', '', {maxAge : 1});
        
    },

    async signup_post(req,res){
        console.log("Atleast connected");
        try{
            let{
                email,
                password
            } = req.body;

            var UserData = {
                email,
                password
            };
            
            if(UserData){
                let [User] = await UserModel.CreateUser(UserData);   
                res.send({
                    status: true,
                    message: 'Registration Successful',
            });
           
            }
            
            else{
                res.send({
                    status: false,
                    message: 'No Body',
                    });
            }
        }
        catch(err){
            console.log(err);
            res.send({
                status: false,
                message:  "None " + err
            }
                );
        }
        
       
    },

    async login_post(req,res){
        try{
            let{
                email, 
                password
            } = req.body;

            var UserData = {
                email,
                password
            };
            let [getUser] = await UserModel.GetUser(UserData);
            
            if(getUser[0]){
                console.log(getUser[0]);
                console.log(getUser[0].password);
                console.log(UserData.password);
                if(UserData.password == getUser[0].password){
                    let payload = {
                        "user_id" : getUser[0].user_id,
                        "email" : getUser[0].email,
                        "password" : getUser[0].password
                    }
                    let options = {
                        expiresIn : process.env.JWT_EXPIRE_TIME
                    }
                    let secret = process.env.JWT_SECRET;
                    let token = jwt.sign(payload, secret, options)

                    const cookieOptions = {
                        httpOnly: true, 
                        expires: new Date(moment().add(31, 'days')),
                        overwrite: true
                    }

                    res.cookie('x-access-token', token, cookieOptions);
                    console.log('---------->', token);
                    res.send({
                        status: true,
                        message: "Logged In successfully",
                        data: payload,
                        token: token
                    });
                }
                else{
                    res.send({
                        status: false,
                        message: "Wrong password",
                    });
                }
            }
            else{
                res.send({
                    status: false,
                    message: "No such user exist"
                });
            }
            //let [getAllUser] = await UserModel.GetUsers();
        // if(getAllUser){
        //     res.send(getAllUser);
        // }
        // else{
        //     res.send("No Users");
        // }
        //res.send('new login');
        }
        catch(err)
        {
            res.send({
                status: false,
                message:  "Error" + err
            }
                );
        }
    }

}

module.exports = userController;