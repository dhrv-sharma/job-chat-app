const User =require('../models/user');
// need to install crypto-js and jsonwebtoken
const Cryptojs=require('crypto-js');
// jwt is used for loging functionality
const jwt = require('jsonwebtoken');
const admin=require('firebase-admin');


// fucntion to create user 
const createUser = async (req,res) =>{
    const user = req.body;
    try {
        //  check weather same email have account or not 
        await admin.auth().getUserByEmail(user.email);
        return res.status(400).json({
            message:"user already exhist ",
        })
        
    } catch (error) {
        if (error.code === 'auth/user-not-found') {
            try {

                // creating a new user 
                const userResponse= await admin.auth().createUser({
                    email:user.email,
                    password:user.password,
                    emailVerified:false,
                    disabled:false
                })
                // firebase provide a unique id while storing the data
                console.log(userResponse.uid);

                // saving the data in mongo db server as well
                // firebase will create unique id for each user creation 
                const newUser = await new User({
                    uid: userResponse.uid,
                    username : user.username,
                    email: user.email,
                    // encrypting the password 
                    password:Cryptojs.AES.encrypt(user.password,process.env.SECRET).toString(),
                })

                await newUser.save();
                 // If you want to ensure that nothing else is executed after sending the response,
                 res.status(201).json({
                    status : true
                });
                
            } catch (error) {
                 // error occured 
                 res.status(500).json({
                    error:"An error occured while creating account"
                });
                
            }
            
        }
        
    }

}


// login function which will have email and password
const login=async (req,res)=>{
    try {
        // checking wheather user exhist or not 
        // createdAt and updatedAt skills email __v is excluded
        const user= await User.findOne({email : req.body.email},{__v:0,createdAt:0,updatedAt:0,skills:0,email:0});

        
        // user dont exhist 
        if (!user) {
            return res.status(400).json({
                message:"User not found"
            })
            
        }
        
        // user exhist  decrypting the password from the database 
        const decryptPass=Cryptojs.AES.decrypt(user.password,process.env.SECRET);
        const depassword=decryptPass.toString(Cryptojs.enc.Utf8);

        // password checking with suer entered password
        if(depassword  !== req.body.password){
            return res.status(400).json({
                message:'Invalid Password'
            })

        }

        // creating token  with jwt 
        const userToken = jwt.sign({
            id:user._id,
            isAdmin:user.isAdmin,
            isAgent:user.isAgent,
            uid:user.uid // uid is not in the mongoose schema but stored in the database as through firebase uid 
        },process.env.JWT_SEC,{expiresIn:'21d'});

        // exporting the data
        // The password and isAdmin properties are extracted from the user._doc object and stored in variables with the same names.
        // All other properties of the user._doc object are gathered into a new object called others, excluding password and isAdmin.
        const {password,isAdmin,...others} = user._doc;

        // not returning 
        res.status(200).json({
            ...others,userToken
        })


        
    } catch (error) {

        res.status(500).json({
            error:error.message
        });


        
    }

}

// exporting the function 
module.exports={createUser,login};