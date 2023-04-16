const express = require('express');
const teacherFeatureRouter = express.Router();
const app = express();
const cors = require("cors");
const bodyParser = require('body-parser');
const multer = require('multer');
const mysql = require("mysql");
const axios = require("axios");
const util = require("util");
const session = require("express-session");
const XLSX = require("xlsx");
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
const query = util.promisify(con.query).bind(con);
const { getScores } =  require('../employee/employee-functional');












teacherFeatureRouter.get("/teacher/timetable", (req, res) => {
    if(req.session.teacher) {
        return res.render("teacher-timetable");
    }
    return res.redirect("/teacher");
});
teacherFeatureRouter.post("/teacher/timetable/getTimeTablesBy7Days", async (req, res) => {
    if(req.session.teacher_token) {
        const token = req.session.teacher_token;
        const teacherId = req.session.teacher;
        const currentDate = req.body.currentDate;
        const datePrev1 = req.body.datePrev1;
        const datePrev2 = req.body.datePrev2;
        const datePrev3 = req.body.datePrev3;
        const datePrev4 = req.body.datePrev4;
        const datePrev5 = req.body.datePrev5;
        const datePrev6 = req.body.datePrev6;
        const filterLoaiLich = req.body.filterLoaiLich;
        const thoiKhoaBieu2DTO = {currentDate, datePrev1, datePrev2, datePrev3, datePrev4, datePrev5, datePrev6, filterLoaiLich, maGiaoVien: teacherId};
        const response = await axios.post(javaUrl+"/api/time_table/getTimeTablesBy7Days", thoiKhoaBieu2DTO, {headers: {"Authorization": token}});
        if(response.data)
            return res.send(response.data);
        return res.send([]);
    }
    return res.redirect("/teacher");
});
teacherFeatureRouter.get("/teacher/score", async (req, res) => {
    if(req.session.teacher) {
        const SCORES = await getScores(req);
        return res.render("teacher-score", {SCORES, signal: null});
    }
    return res.redirect("/teacher");
});
teacherFeatureRouter.post("/teacher/add-score", upload.fields([]), async (req, res) => {
    if(req.session.teacher) {
        const data = req.body;
        const response = await axios.post(javaUrl+"/api/score/addScore", data, {headers: {"Authorization": req.session.teacher_token}});
        const SCORES = await getScores(req);
        if(response.data) {
            return res.render("teacher-score", {SCORES, signal: "INSERT_SUCCESS"});
        }
        return res.render("teacher-score", {SCORES, signal: "INTERNAL_SERVER_ERROR"});
    }
    return res.redirect("/teacher");
});
teacherFeatureRouter.post("/teacher/add-score-excel", upload.single("excel_file"), async (req, res, next) => {
    if(req.session.teacher) {
        try {
            let path = req.file.path;
            var workbook = XLSX.readFile(path);
            var sheet_name_list = workbook.SheetNames;
            await Promise.all(sheet_name_list.map(async function (y) {
                var worksheet = workbook.Sheets[y];
                var headers = {};
                var data = [];
                for (z in worksheet) {
                if (z[0] === "!") continue;
                var col = z.substring(0, 1);
                var row = parseInt(z.substring(1));
                var value = worksheet[z].v;
                if (row == 1) {
                    headers[col] = value;
                    continue;
                }
                if (!data[row]) data[row] = {};
                data[row][headers[col]] = value;
                }
                data.shift();
                data.shift();
                for(let i=0;i<data.length;i++) {
                    const e = data[i];
                    const myScore = {maLopHocPhan: e.maLopHocPhan, maSinhVien: e.maSinhVien, diemGK: e.diemGK, diemLT1: e.diemLT1, diemLT2: e.diemLT2, diemLT3: e.diemLT3, diemTH1: e.diemTH1, diemTH2: e.diemTH2, diemTH3: e.diemTH3, diemGK: e.diemGK};
                    const response = await axios.post(javaUrl+"/api/score/addScore", myScore, {headers: {"Authorization": req.session.teacher_token}});
                }
            }));
            const SCORES = await getScores(req);
            return res.render("teacher-score", {SCORES, signal: "INSERT_SUCCESS"});
        } catch (err) {
            console.error(err.message);
            const SCORES = await getScores(req);
            return res.render("teacher-score", {SCORES, signal: "INTERNAL_SERVER_ERROR"});
        }
    }
    return res.redirect("/teacher");
});
teacherFeatureRouter.post("/teacher/deleteScoreById", async (req, res) => {
    if(req.session.teacher) {
        const maDiem = req.body.maDiem;
        const response = await axios.delete(javaUrl+"/api/score/deleteScoreById/"+maDiem, {headers: {"Authorization": req.session.teacher_token}});
        if(response.data)
            return res.send(response.data);
        return res.send(null);
    }
    return res.redirect("/teacher");
});

module.exports = teacherFeatureRouter;