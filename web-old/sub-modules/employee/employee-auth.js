const express = require('express');
const employeeAuthRouter = express.Router();
const app = express();
const cors = require("cors");
const bodyParser = require('body-parser');
const multer = require('multer');
const mysql = require("mysql");
const axios = require("axios");
const session = require("express-session");
const dotenv = require('dotenv');
dotenv.config();
const javaUrl = ""+process.env.JAVA_API_URL;
const storage = multer.diskStorage({
    destination: function(req, file, cb) {
        cb(null, "uploads")
    },
    filename: function(req, file, cb) {
        cb(null, file.originalname);
    }
});
const upload = multer({ storage: storage });
app.use(cors());
app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());
app.use(express.static(__dirname + '/public'));
app.set('view engine', 'ejs');
app.set('views', './public/templates');
app.use(session({
    secret: "taiprovip3",
    proxy: true,
    resave: true,
    saveUninitialized: true
}));
const path = require('path');
const fileName = path.basename(__filename);
const con = mysql.createConnection({
    host: process.env.MYSQL_HOST,
    port: process.env.MYSQL_PORT,
    user: process.env.MYSQL_USER,
    password: process.env.MYSQL_PASSWORD,
    database: process.env.MYSQL_DATABASE,
});
con.connect(function(err) {
    if (err) {
      console.error('error connecting: ' + err.stack);
      return;
    }
    console.log(fileName + ' connected as id ' + con.threadId);
});








employeeAuthRouter.get('/employee', (req, res) => {
    if(req.session.employee) {
        return res.render("employee", {signal: null});
    }
    return res.render('employee-login', {error: ""});
});
employeeAuthRouter.post('/employee-login', upload.fields([]), async (req, res) => {
    const { username, password } = req.body;
    const response = await axios.post(javaUrl+"/api/login", {username: "nv"+username, password});
    if(response.data) {
        req.session.employee = username;
        req.session.employee_token = response.data;
        return res.redirect('./employee');
    }
    return res.render("employee-login", { error: "wrong_password" }); 
});
employeeAuthRouter.get("/employee-logout", (req, res) => {
    if(req.session.employee) {
        req.session.employee = "";
    }
    return res.redirect("./employee");
});

module.exports = employeeAuthRouter;