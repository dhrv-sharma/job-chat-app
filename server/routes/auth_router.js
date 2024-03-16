const router = require('express').Router();
const authController = require('../controllers/authController');



// https:serverAdd/auth/createUser
router.post('/register',authController.createUser);
router.post('/login',authController.login);


module.exports=router;
