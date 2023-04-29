const express = require('express');
const teacherAuthRouter = express.Router();
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












teacherAuthRouter.get("/teacher", async (req, res) => {
    if(req.session.teacher) {
        const token = req.session.teacher_token;
        const maGiaoVien = req.session.teacher;
        const response = await axios.get(javaUrl+"/api/teacher/getTeacherById/"+maGiaoVien, {headers: {"Authorization": token}});
        const signalParam = req.query.signal;
        return res.render("teacher", {signal: signalParam, TEACHER_DATA: response.data});
    }
    return res.render("teacher-login", {error: ""});
});
teacherAuthRouter.post('/teacher-login', upload.fields([]), async (req, res) => {
    const { maGiaoVien, matKhau, captcha } = req.body;
    if(captcha !== req.session.captcha) {//Sai captcha
        return res.render("teacher-login", { error: "wrong_captcha" }); 
    } else {
        const response = await axios.post(javaUrl+"/api/login", {username: "gv"+maGiaoVien, password: matKhau});
        if(response.data) {
            const token = response.data;
            req.session.teacher = maGiaoVien;
            req.session.teacher_token = token;
            return res.redirect("/teacher?signal=SUCCESS_LOGON");
        }
        return res.render("teacher-login", { error: "wrong_password" }); 
    }
});
teacherAuthRouter.get("/teacher-logout", (req, res) => {
    if(req.session.teacher) {
        req.session.teacher = "";
    }
    return res.redirect("/teacher");
});
teacherAuthRouter.post("/teacher-changepassword", async (req, res) => {
    if(!req.session.teacher || !req.session.teacher_token) {
        return res.redirect("/teacher");
    }
    const oldPassword = req.body.oldPassword;
    const newPassword = req.body.newPassword;
    const changePasswordRequestDTO = {
        oldPassword,
        newPassword,
    }
    try {
        const response = await axios.post(javaUrl+"/api/change-password", changePasswordRequestDTO, {headers: {"Authorization": req.session.teacher_token}});
        return res.send(response.data);
    } catch (error) {
        const status = error.response.status;   
        return res.status(status).send(error.message);
    }
});

module.exports = teacherAuthRouter;