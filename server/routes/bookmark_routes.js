const router=require('express').Router();

// middlewares
const {verifyToken,verfiyAgent,verifyAndAuth} = require('../middleware/verifyToken');
const BookMarkController= require("../controllers/bookmarkController");

// craete bookmark route
router.post('/create',verifyAndAuth,BookMarkController.createBookmark);

// create delete route
router.delete('/:id',verifyAndAuth,BookMarkController.deleteBookmark);

// get bookmarks routes
router.get('/',verifyAndAuth,BookMarkController.getAllBookmark);

// get single bookmark routes
router.get('/single/:id',verifyAndAuth,BookMarkController.getSingleBookmark);

module.exports=router;