// npm start
// express config
const express = require('express')
const app = express()

// mongoose connect
const mongoose= require('mongoose');
const jobRouter=require('./routes/job_router');
const bodyparser=require('body-parser');
const authRouter=require('./routes/auth_router');
const bookMarkRouter=require('./routes/bookmark_routes');



// middleware to encode and decoding the json

app.use(bodyparser.json());
app.use(bodyparser.urlencoded({extended:true}));

// middleware when /api/job is called 
app.use('/api/job',jobRouter);


//  middleware when /api/auth is  called
app.use('/api/auth',authRouter);
app.use('/api/bookmark',bookMarkRouter);



// default port is 5003 from dot env but not found then local 3000 will be there
const port = 3000

// dot env config 
const otenv = require('dotenv');
const { errorOut } = require('firebase-tools');
otenv.config();

// firebase config
const admin=require('firebase-admin');
const serviceAccount=require('./services-account-key.json');

// intialize firebase 
admin.initializeApp({
    credential:admin.credential.cert(serviceAccount),
});


// route
app.get('/', (req, res) => res.send('Hello World!'))

// server hosting
app.listen(process.env.PORT || port, () => console.log(`App Listening on port ${process.env.PORT || port}!`))


// mongoose db connect 
mongoose.connect(process.env.MONGO_URL)
.then(()=>console.log("Connected to Database Server"))
.catch((err)=>console.log(err));
