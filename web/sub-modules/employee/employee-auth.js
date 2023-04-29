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








employeeAuthRouter.get('/employee', async(req, res) => {
    if(req.session.employee) {
        const username = req.session.employee;
        const token = req.session.employee_token;
        const response = await axios.get(javaUrl+"/api/nhanvien/getEmployeeById/" + username, {headers: {"Authorization": token}});
        if(response.data) {
            return res.render("employee", {
                EMPLOYEE_DATA: response.data,
                error: null
            });
        }
        return res.render("employee", {
            EMPLOYEE_DATA: null,
            error: "internal_server_error"
        });
    }
    return res.render('employee-login', {error: "INVALID_SESSION"});
});
employeeAuthRouter.post('/employee-login', upload.fields([]), async (req, res) => {
    try {
        const { username, password } = req.body;
        const response1 = await axios.post(javaUrl+"/api/login", {username: "nv"+username, password});
        if(response1.data) {
            req.session.employee = username;
            req.session.employee_token = response1.data;
        } else {
            throw new Error('No token found!');
        }
        const response2 = await axios.get(javaUrl+"/api/nhanvien/getEmployeeById/" + username, {headers: {"Authorization": req.session.employee_token}});
        if(response2.data) {
            return res.render("employee", {
                EMPLOYEE_DATA: response2.data,
                error: null
            });
        } else {
            throw new Error('No data employee found!'); 
        }
    } catch (error) {
        console.log('error=',error);
        return res.render("employee-login", { error: "WRONG_PASSWORD" });
    }
});
employeeAuthRouter.get("/employee-logout", (req, res) => {
    if(req.session.employee) {
        req.session.employee = "";
    }
    return res.redirect("/employee");
});
employeeAuthRouter.post("/employee-changepassword", async (req, res) => {
    if(!req.session.employee || !req.session.employee_token) {
        return res.redirect("/employee");
    }
    const oldPassword = req.body.oldPassword;
    const newPassword = req.body.newPassword;
    const changePasswordRequestDTO = {
        oldPassword,
        newPassword,
    }
    try {
        const response = await axios.post(javaUrl+"/api/change-password", changePasswordRequestDTO, {headers: {"Authorization": req.session.employee_token}});
        return res.send(response.data);
    } catch (error) {
        const status = error.response.status;   
        return res.status(status).send(error.message);
    }
});

module.exports = employeeAuthRouter;