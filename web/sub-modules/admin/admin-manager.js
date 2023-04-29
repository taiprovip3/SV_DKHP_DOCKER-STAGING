const express = require('express');
const adminRouter = express.Router();
const app = express();
const cors = require("cors");
const bodyParser = require('body-parser');
const multer = require('multer');
const mysql = require("mysql");
const axios = require("axios");
const util = require("util");
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
    secret: process.env.APP_SECRET_KEY,
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
const query = util.promisify(con.query).bind(con);








adminRouter.get('/admin', (req, res) => {
    if(req.session.admin) {
        getListEmployee()
            .then(data => {
                return res.render("admin", { LIST_EMPLOYEE: data, signal: "AUTO_LOGON" });
            });
    } else return res.render('admin-login', {error: ""});
});
adminRouter.post('/admin-login', upload.fields([]), async (req, res) => {
    const { username, password } = req.body;
    const response = await axios.post(javaUrl+"/api/login", {username, password});
    if(response.data) {
        req.session.admin = username;
        req.session.admin_token = response.data;
        let LIST_EMPLOYEE = await getListEmployee();
        return res.render("admin", {LIST_EMPLOYEE, signal: null});
    }
    return res.render("admin-login", {error: "wrong_password"});
});
adminRouter.get("/admin-logout", (req, res) => {
    if(req.session.admin) {
        req.session.admin = "";
        req.session.admin_token = "";
    }
    return res.redirect("/admin");
});
adminRouter.post("/admin-crud-add-employee", upload.fields([]), async (req, res) => {
    if(req.session.admin_token) {
        const data = req.body;
        const nhanVien = {tenNhanVien: data.ten_nhan_vien, sdt: data.sdt, diaChi: data.dia_chi, chucVu: data.chuc_vu, matKhau: data.mat_khau};
        const response = await axios.post('http://java:8080/api/nhanvien/add', nhanVien, {headers: {"Authorization": req.session.admin_token}});
        const LIST_EMPLOYEE = await getListEmployee();
        if(response.data)
            return res.render("admin", {LIST_EMPLOYEE, signal: "INSERT_SUCCESS"});
        return res.render("admin", {LIST_EMPLOYEE: result, signal: "INTERNAL_SERVER_ERROR"});
    }
    return res.redirect("/admin");
});
adminRouter.post("/admin-crud-delete-employee", upload.fields([]), async (req, res) => {
    if(req.session.admin_token) {
        const listCheckboxChecked = Object.keys(req.body);
        const response = await axios.post('http://java:8080/api/nhanvien/remove', listCheckboxChecked, {headers: {"Authorization": req.session.admin_token}});
        const LIST_EMPLOYEE = await getListEmployee();
        if(response.data)
            return res.render("admin", {LIST_EMPLOYEE, signal: "INSERT_SUCCESS"});
        return res.render("admin", {LIST_EMPLOYEE, signal: "INTERNAL_SERVER_ERROR"});
    }
    return res.redirect("/admin");
});
adminRouter.post("/admin-crud-update-employee", upload.fields([]), async (req, res) => {
    if(req.session.admin_token) {
        const data = req.body;
        const nhanVien = {maNhanVien: data.ma_nhan_vien2, tenNhanVien: data.ten_nhan_vien2, sdt: data.sdt2, diaChi: data.dia_chi2, chucVu: data.chuc_vu2};
        const response = await axios.post('http://java:8080/api/nhanvien/update', nhanVien, {headers: {"Authorization": req.session.admin_token}});
        const LIST_EMPLOYEE = await getListEmployee();
        if(response.data)
            return res.render("admin", {LIST_EMPLOYEE, signal: "INSERT_SUCCESS"});
        return res.render("admin", {LIST_EMPLOYEE, signal: "INTERNAL_SERVER_ERROR"});
    }
    return res.redirect("/admin");
});
async function getListEmployee() {
    let LIST_EMPLOYEE = [];
    try {
        const result = await query("SELECT * FROM nhan_vien");
        Object.keys(result).forEach(function (key) {
            var row = result[key];
            LIST_EMPLOYEE.push(row);
        });
    } catch (error) {
        console.error(error);
    } finally{
        return LIST_EMPLOYEE;
    }
}

module.exports = adminRouter;