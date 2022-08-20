const express = require('express');
const cookieParser = require('cookie-parser');
const app = express();
const userRoutes = require('./routes/userRoutes.js');
const requireAuth = require('./middleware/auth_middleware');
const cors = require('cors');
const bodyparser = require('body-parser');

app.use(express.json());
//app.use(bodyparser);
app.use(cookieParser());
app.use(cors());
//app.get('/home',  requireAuth, (req, res) => res.render('home') );
app.use('/', userRoutes);
require("dotenv").config();
app.listen(6500, () => {
    console.log("The server is currently running in the port 6500");
});