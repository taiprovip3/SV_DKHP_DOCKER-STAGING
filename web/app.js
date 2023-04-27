const express = require('express');
const app = express();
const socket = require('socket.io');
const cors = require("cors");
const bodyParser = require('body-parser');
const multer = require('multer');
const mysql = require("mysql");
const bcrypt = require("bcrypt");
const axios = require("axios");
const util = require("util");
const nodemailer = require("nodemailer");
const easyinvoice = require('easyinvoice');
const https = require('https');
const fs = require('fs');
const paypal = require("paypal-rest-sdk");
const svgCaptcha = require('svg-captcha');
const session = require("express-session");
const XLSX = require("xlsx");
const dotenv = require('dotenv');
dotenv.config();
const javaUrl = ""+process.env.JAVA_API_URL;
const Datastore = require('nedb-promises')
const db = Datastore.create('nosql-database.db');
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
    resave: false,
    saveUninitialized: true,
    cookie: { secure: false }
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
const { admin_firebase_sdk, firebaseDB } = require('./utils/admin-firebase-sdk');
























app.get("/", (req, res) => {
    return res.render("index");
});

//---------⇩⇩⇩⇩⇩_Teacher_⇩⇩⇩⇩⇩---------\\
/*
********************    ****************          ********              **** ****   ****        ****    ****************
        ****            ****                     ****  ****           ****          ****        ****    ****
        ****            ****                    ****    ****        ****            ****        ****    ****
        ****            ****************       **** **** ****       ****            ****************    ****************
        ****            ****                  ****        ****      ****            ****        ****    ****
        ****            ****                 ****          ****       ****          ****        ****    ****
        ****            ****************    ****            ****        **** ****   ****        ****    ****************
*/
const teacherFeatureRouter = require('./sub-modules/teacher/teacher-feature');
const teacherAuthRouter = require('./sub-modules/teacher/teacher-auth');
app.use('/', teacherFeatureRouter);
app.use('/', teacherAuthRouter);
//---------⇧⇧⇧⇧⇧_Teacher_⇧⇧⇧⇧⇧---------\\


//---------⇩⇩⇩⇩⇩_Employee_⇩⇩⇩⇩⇩---------\\
/*
************    ********      ********   ***************    ****                ********        ****    ****
****            ****  **      **  ****   ****       ****    ****            ****        ****    ****    ****
****            ****    **  **    ****   ****       ****    ****            ****        ****    ****    ****
************    ****      **      ****   ***************    ****            ****        ****    ****    ****
****            ****              ****   ****               ****            ****        ****        ****
****            ****              ****   ****               ****            ****        ****        ****
************    ****              ****   ****               ************        ********            ****
*/
const employeeAuthRouter = require('./sub-modules/employee/employee-auth');
const employeeFeatureRouter = require('./sub-modules/employee/employee-feature');
app.use('/', employeeAuthRouter);
app.use('/', employeeFeatureRouter);
//---------⇧⇧⇧⇧⇧_Employee_⇧⇧⇧⇧⇧---------\\

/*
***************    ****             ****    **** **             ****         ********
****               ****             ****    ****  ***           ****      ****
****               ****             ****    ****    ****        ****    ****
***************    ****             ****    ****    ***         ****    ****
****               ****             ****    ****       ***              ****
****               ****             ****    ****        ****    ****    ****
****               ****             ****    ****        ****    ****     ****
****               ****             ****    ****         ****   ****        ****
****               *********************    ****           **** ****          ********
*/
const { formatCurrency } = require('./utils/functional');
const { sendEmailHddt } = require('./utils/functional');
const { getListAnnouncement } = require('./sub-modules/employee/employee-functional');
/*
                                                    ****
    ****            ****    ********************              ****
    ****            ****            ****            ****      ****
    ****            ****            ****            ****      ****
    ****            ****            ****            ****      ****
    ****            ****            ****            ****      ****
    ****            ****            ****            ****      ****
    ********************            ****            ****      ****************
*/
async function updateDocumentFieldAEqualsABC(maLopHocPhan, mathType) {
    try {
      const collectionRef = firebaseDB.collection('lop_hoc_phan');
      const querySnapshot = await collectionRef.where('maLopHocPhan', '==', maLopHocPhan).get();
      querySnapshot.forEach((doc) => {
        const docRef = collectionRef.doc(doc.id);
        if(mathType === 'plus') {
            docRef.update({ soLuong: admin_firebase_sdk.firestore.FieldValue.increment(1) });
        } else {
            docRef.update({ soLuong: admin_firebase_sdk.firestore.FieldValue.increment(-1) });
        }
        console.log(`Document with ID ${doc.id} updated successfully`);
      });
      console.log(`All documents with A=${maLopHocPhan} updated successfully`);
    } catch (error) {
      console.error('Error updating documents:', error);
    }
  }
//---------⇩⇩⇩⇩⇩_Admin_⇩⇩⇩⇩⇩---------\\
/*
        ****            ************        ********    ********    ****    ********    ****
    ****    ****        ****        ****    ****  **    **  ****    ****    ****  ****  ****
****            ****    ****        ****    ****    ****    ****    ****    ****    *** ****
****    ****    ****    ****        ****    ****            ****    ****    ****     ** ****
****            ****    ****        ****    ****            ****    ****    ****        ****
****            ****    ************        ****            ****    ****    ****        ****
*/
const adminRouter = require('./sub-modules/admin/admin-manager');
app.use('/', adminRouter);
//---------⇧⇧⇧⇧⇧_Admin_⇧⇧⇧⇧⇧---------\\


//---------⇩⇩⇩⇩⇩_Student_⇩⇩⇩⇩⇩---------\\
/*
        ******      ********************    ****                ****    ************            ********************
    ****      ***           ****            ****                ****    ****        ****        ****
****                        ****            ****                ****    ****            ****    ****
****                        ****            ****                ****    ****            ****    ****
****                        ****            ****                ****    ****            ****    ****
    ****                    ****            ****                ****    ****            ****    ********************
        *******             ****            ****                ****    ****            ****    ****
              **            ****            ****                ****    ****            ****    ****
              **            ****            ****                ****    ****            ****    ****
            ****            ****            ****                ****    ****            ****    ****
**      ******              ****                ****        ****        ****        ****        ****
   *****                    ****                    ********            ************            ********************
*/
app.get("/captcha", async (req, res) => {
    var captcha = svgCaptcha.create({size:1, color: true, background: 'white'});
    req.session.captcha = captcha.text;
    res.type('svg');
    return res.status(200).send(captcha.data);
});
app.get("/student", async (req,res) => {
    if(req.session.student && req.session.jwt_token) { //Đã session
        const signalParam = req.query.signal;
        renderStudentHomepage(req,res, signalParam);
    } else {
        const LIST_ANNOUNCEMENT = await getListAnnouncement();
        return res.render("student-login", {LIST_ANNOUNCEMENT, error: null});
    }
});
app.get("/student-login", async (req,res) => {
    return res.redirect("/student");
});
app.get("/student-logout", (req, res) => {
    if(req.session.student) {
        req.session.student = "";
    }
    return res.redirect("/student");
});
async function renderStudentHomepage(req,res,signal){
    if(!signal)
        signal = null;
    try {
        const ma_sinh_vien = req.session.student;
        const token = req.session.jwt_token;
        const response1 = await axios.get(javaUrl+"/api/student/getStudentById/" + ma_sinh_vien, {headers: {"Authorization": token}});//Sử lý cookie mã sv
        const response2 = await axios.get(javaUrl+"/api/pattern/getSoTinChiDoneByStudentId/" + ma_sinh_vien, {headers: {"Authorization": token}});//Sử lý số tín chỉ đã đạt của sv
        const response3 = await axios.get(javaUrl+"/api/semester/getTongSoTinChiByMaNganh/" + response1.data.lopHocDanhNghia.nganh.maNganh, {headers: {"Authorization": token}});//Sử lý tổng tín chỉ của sv
        const response4 = await axios.get(javaUrl+"/api/course/getCoursesByStudentId/" + ma_sinh_vien, {headers: {"Authorization": token}});//Lay ds ma KhoaHoc DESC
        var ma_first_khoa_hoc = 0;
        if(response4.data.length > 0)
            ma_first_khoa_hoc = response4.data[0].maKhoaHoc;
        const response5 = await axios.get(javaUrl+"/api/subject/getListSinhVienDangKyHocPhanByMaSinhVienAndMaKhoaHoc/"+ma_sinh_vien+"/"+ma_first_khoa_hoc, {headers: {"Authorization": token}});
        const response6 = await axios.get(javaUrl+"/api/department_announcement/getNotificationsByStudentId/"+ma_sinh_vien, {headers: {"Authorization": token}});
        return res.render("student", { STUDENT_DATA: response1.data, currentTinChi: response2.data, requireTinChi: response3.data, LIST_COURSE: response4.data, LIST_FIRST_UNIT_SUBJECT: response5.data, LIST_NOTIFICATION: response6.data, signal: signal });
    } catch (error) {
        console.error(error);
        const LIST_ANNOUNCEMENT = await getListAnnouncement();
        return res.render("student-login", {LIST_ANNOUNCEMENT, error: "internal_server_error"});
    }
}
app.post("/student-login", upload.fields([]), async (req, res) => {
    if(req.session.student && req.session.jwt_token) { //Đã session
        return res.redirect("./student");
    } else { //First try
        const {ma_sinh_vien, mat_khau, captcha_code} = req.body;
        const LIST_ANNOUNCEMENT = await getListAnnouncement();
        if(captcha_code !== req.session.captcha) {//Sai captcha
            return res.render("student-login", {LIST_ANNOUNCEMENT, error: "wrong_captcha"});
        } else {
            const response = await axios.post(javaUrl+"/api/login", {username: "sv"+ma_sinh_vien, password: mat_khau});
            if(response.data) {
                const token = response.data;
                req.session.jwt_token = token;
                req.session.student = ma_sinh_vien;
                return res.redirect("/student?signal=SUCCESS_LOGON");
            } else {
                return res.render("student-login", {LIST_ANNOUNCEMENT, error: "wrong_password"});
            }
        }
    }
});
app.post("/student/getNotificationById", async (req, res) => {
    if(!req.session.jwt_token) {
        const LIST_ANNOUNCEMENT = await getListAnnouncement();
        return res.render("student-login", {LIST_ANNOUNCEMENT, error: null});
    } else {
        const maThongBao = req.body.maThongBao;
        const response = await axios.get(javaUrl+"/api/department_announcement/getNotificationById/"+maThongBao, {headers: {"Authorization": req.session.jwt_token}});
        if(response.data)
            return res.send(response.data);
        return res.send(null);
    }
});
    //----- student dkhp oriented -----\\
app.get("/student/dkhp", async (req, res) => { //repare for svdkhp
    if(!req.session.jwt_token) {
        const LIST_ANNOUNCEMENT = await getListAnnouncement();
        return res.render("student-login", {LIST_ANNOUNCEMENT, error: null});
    } else {
        try {
            const token = req.session.jwt_token;
            const response = await axios.get(javaUrl+"/api/course/getCourses", {headers: {"Authorization": token}}); //lấy ds khóa học to `student.ejs`
            return res.render("student-dkhp", {LIST_COURSE: response.data, STUDENT_ID: req.session.student});  
        } catch (error) {
            console.error("get /student/dkhp nodejs error!");
        }
    }
});
app.post("/student/dkhp/getUnitClassesStudentRegisterByStudentIdAndMaKhoaHoc", async (req, res) =>{
    if(!req.session.jwt_token) {
        const LIST_ANNOUNCEMENT = await getListAnnouncement();
        return res.render("student-login", {LIST_ANNOUNCEMENT, error: null});
    } else {
        const maKhoaHoc = req.body.maKhoaHoc;
        const response = await axios.get(javaUrl+"/api/unit_class/getUnitClassesStudentRegisterByStudentIdAndMaKhoaHoc/"+req.session.student+"/"+maKhoaHoc, {headers: {"Authorization": req.session.jwt_token}});
        if(response.data)
            return res.send(response.data);
        return res.send([]);
    }
});
app.post("/student/getSubjectByStudentIdAndCourseId", async (req, res) => {//get list subjects to `student.ejs` same to maKhoaHoc selected
    if(!req.session.jwt_token) {
        const LIST_ANNOUNCEMENT = await getListAnnouncement();
        return res.render("student-login", {LIST_ANNOUNCEMENT, error: null});
    } else {
        const response = await axios.get(javaUrl+"/api/subject/getListSinhVienDangKyHocPhanByMaSinhVienAndMaKhoaHoc/"+req.body.maSinhVien+"/"+req.body.maKhoaHoc, {headers: {"Authorization": req.session.jwt_token}});
        if(response.data)
            return res.send(response.data);   
        return res.send([]);
    }
});
app.post("/student/dkhp/getSubjectsByCourseId", async (req, res) => {//get all course by maNganh student to `student-dkhp.ejs` selection
    if(!req.session.jwt_token) {
        const LIST_ANNOUNCEMENT = await getListAnnouncement();
        return res.render("student-login", {LIST_ANNOUNCEMENT, error: null});
    } else {
        const maKhoaHoc = req.body.maKhoaHoc;
        const maSinhVien = req.session.student;
        const response = await axios.get(javaUrl+"/api/subject/getSubjectsByCourseId/" + maKhoaHoc + "/" + maSinhVien, { headers: {"Authorization": req.session.jwt_token}});
        if(response.data)
            return res.send(response.data);
        return res.send([]);
    }
});
app.post("/student/dkhp/getUnitClassesBySubjectIdAndLoaiHocAndMaKhoaHoc", async (req, res) => {//get list LopHocPhan by select radio button from list subject
    if(!req.session.jwt_token) {
        const LIST_ANNOUNCEMENT = await getListAnnouncement();
        return res.render("student-login", {LIST_ANNOUNCEMENT, error: null});
    } else {
        try {
            const maMonHoc = req.body.maMonHoc;
            const loaiHoc = req.body.loaiHoc;
            const maKhoaHoc = req.body.maKhoaHoc;
            const response = await axios.get(javaUrl+"/api/unit_class/getUnitClassesBySubjectIdAndLoaiHocAndMaKhoaHoc/"+maMonHoc+"/"+loaiHoc+"/"+maKhoaHoc, { headers: {"Authorization": req.session.jwt_token} });
            return res.send(response.data);
        } catch (error) {
            console.error("getUnitClassesBySubjectIdAndLoaiHocAndMaKhoaHoc nodejs error...!");
            return res.send([]);
        }
    }
});
app.post("/student/dkhp/getTimeTablesByUnitClassId", async (req, res) => {//get ThoiKhoaBieus by first and select LopHocPhan radio btn
    if(!req.session.jwt_token) {
        const LIST_ANNOUNCEMENT = await getListAnnouncement();
        return res.render("student-login", {LIST_ANNOUNCEMENT, error: null});
    } else {
        const maLopHocPhan = req.body.maLopHocPhan;
        const response = await axios.get(javaUrl+"/api/time_table/getTimeTablesByUnitClassId/"+maLopHocPhan, {headers: {"Authorization": req.session.jwt_token}});
        if(response.data)
            return res.send(response.data);
        return res.send([]);
    }
});
app.post("/student/dkhp/getSvlhpById", async (req, res) => {//get ThoiKhoaBieus by first and select LopHocPhan radio btn
    if(!req.session.jwt_token) {
        const LIST_ANNOUNCEMENT = await getListAnnouncement();
        return res.render("student-login", {LIST_ANNOUNCEMENT, error: null});
    } else {
        const svlhpId = req.body.svlhpId;
        const response = await axios.get(javaUrl+"/api/sv_lhp/getSvlhpById/"+svlhpId, {headers: {"Authorization": req.session.jwt_token}});
        if(response.data)
            return res.send(response.data);
        return res.send(null);
    }
});
app.post("/student/dkhp/sv_lhp", async (req, res) => {
    if(!req.session.jwt_token) {
        const LIST_ANNOUNCEMENT = await getListAnnouncement();
        return res.render("student-login", {LIST_ANNOUNCEMENT, error: null});
    } else {
        const maThoiKhoaBieu = req.body.maThoiKhoaBieu;
        const maThoiKhoaBieuCon = req.body.maThoiKhoaBieuCon;
        const maMonHoc = req.body.maMonHoc;
        const maKhoaHoc = req.body.maKhoaHoc;
        const response = await axios.get(javaUrl+"/api/time_table/getTimeTableById/"+maThoiKhoaBieu, {headers: {"Authorization": req.session.jwt_token}});
        if(response.data) {
            const myDateString = response.data.lopHocPhan.ngayBatDau;
            const myD1 = new Date(myDateString);
            var previous7Day = new Date(myD1);
            previous7Day.setDate(previous7Day.getDate() - 7);
            const myD2 = new Date();
            if(myD2 > previous7Day) {
                const data = {title: "Thất bại", text: "Lớp học phần đã hết hạn đăng ký", icon: "warning", dangerMode: true};
                return res.send(data);
            }
            if(response.data.lopHocPhan.soLuong >= response.data.lopHocPhan.soLuongMax) {
                const data = {title: "Thất bại", text: "Lớp học phần đã đủ số lượng", icon: "warning", dangerMode: true};
                return res.send(data);
            }
            const response2 = await axios.get(javaUrl+"/api/sv_lhp/isStudentRegisThisUnitClass/"+response.data.lopHocPhan.maLopHocPhan+"/"+maMonHoc+"/"+maKhoaHoc+"/"+req.session.student, {headers: {"Authorization": req.session.jwt_token}});
            if(response2.data == true) {
                const data = {title: "Thất bại", text: "Bạn đã đăng ký LHP này rồi!", icon: "warning", dangerMode: true};
                return res.send(data);
            }
            const data = {maThoiKhoaBieu, maThoiKhoaBieuCon, maSinhVien: req.session.student};
            const response3 = await axios.post(javaUrl+"/api/sv_lhp/addAndUpdateSoLuong", data, {headers: {"Authorization": req.session.jwt_token}});
            if(response3.data) {
                await updateDocumentFieldAEqualsABC(response.data.lopHocPhan.maLopHocPhan, 'plus');
                const data = {title: "Thành công", text: "Đăng ký lớp học phần hoàn tất", icon: "success", dangerMode: false, command: "REFRESH_PAGE"};
                return res.send(data);
            }
        }
    }
});
app.delete("/student/dkhp/sv_lhp", async (req, res) => {
    if(!req.session.jwt_token) {
        const LIST_ANNOUNCEMENT = await getListAnnouncement();
        return res.render("student-login", {LIST_ANNOUNCEMENT, error: null});
    } else {
        const maSVLHP = req.body.maSVLHP;
        let maLopHocPhan = 0;
        const response = await axios.get(javaUrl+"/api/sv_lhp/getSvlhpById/"+maSVLHP, {headers: {"Authorization": req.session.jwt_token}});
        if(response.data) {
            maLopHocPhan = response.data.lopHocPhan.maLopHocPhan;
        } else {
            return res.send("ERROR");
        }
        const response2 = await axios.delete(javaUrl+"/api/sv_lhp/deleteById/"+maSVLHP, {headers: {"Authorization": req.session.jwt_token}});
        if(response2.data) {
            await updateDocumentFieldAEqualsABC(maLopHocPhan, 'minus');
            return res.send(response2.data);
        }
        return res.send("ERROR");
    }
});
app.post("/student/dkhp/getListUnitClassStudentRegister", async (req, res) => {
    if(!req.session.jwt_token) {
        const LIST_ANNOUNCEMENT = await getListAnnouncement();
        return res.render("student-login", {LIST_ANNOUNCEMENT, error: null});
    } else {
        const response = await axios.get(javaUrl+"/api/sv_lhp/getListUnitClassStudentRegisterAndMaKhoaHoc/"+req.session.student, {headers: {"Authorization": req.session.jwt_token}});
        if(response.data)
            return res.send(response.data)
        return res.send([]);
    }
});
app.post("/student/dkhp/getTimeTables", async (req, res) => {
    if(!req.session.jwt_token) {
        const LIST_ANNOUNCEMENT = await getListAnnouncement();
        return res.render("student-login", {LIST_ANNOUNCEMENT, error: null});
    } else {
        const maLopHocPhan = req.body.maLopHocPhan;
        const response = await axios.get(javaUrl+"/api/time_table/getTimeTables/"+maLopHocPhan, {headers: {"Authorization": req.session.jwt_token}});
        if(response.data)
            return res.send(response.data)
        return res.send([]);
    }
});
app.post("/student/dkhp/getSVLHPByMaLopHocPhanId", async (req, res) => {
    if(!req.session.jwt_token) {
        const LIST_ANNOUNCEMENT = await getListAnnouncement();
        return res.render("student-login", {LIST_ANNOUNCEMENT, error: null});
    } else {
        const maLopHocPhan = req.body.maLopHocPhan;
        const response = await axios.get(javaUrl+"/api/sv_lhp/getSVLHPByMaLopHocPhanId/"+maLopHocPhan, {headers: {"Authorization": req.session.jwt_token}});
        if(response.data)
            return res.send(response.data)
        return res.send({});
    }
});
app.post("/student/dkhp/getTimeTablesById", async (req, res) => {
    if(!req.session.jwt_token) {
        const LIST_ANNOUNCEMENT = await getListAnnouncement();
        return res.render("student-login", {LIST_ANNOUNCEMENT, error: null});
    } else {
        const maThoiKhoaBieu = req.body.maThoiKhoaBieu;
        const response = await axios.get(javaUrl+"/api/time_table/getTimeTablesById/"+maThoiKhoaBieu, {headers: {"Authorization": req.session.jwt_token}});
        if(response.data)
            return res.send(response.data);
        return res.send([]);
    }
});
app.post("/student/dkhp/getUnitClassesById", async (req, res) => {
    if(!req.session.jwt_token) {
        const LIST_ANNOUNCEMENT = await getListAnnouncement();
        return res.render("student-login", {LIST_ANNOUNCEMENT, error: null});
    } else {
        const maLopHocPhan = req.body.maLopHocPhan;
        const response = await axios.get(javaUrl+"/api/unit_class/getUnitClassesById/"+maLopHocPhan, {headers: {"Authorization": req.session.jwt_token}});
        if(response.data)
            return res.send(response.data);
        return res.send(null);
    }
});
    //----- student details oriented -----\\
app.get("/student/details", async (req,res) => {
    if(req.session.jwt_token) {
        try {
            const response = await axios.get(javaUrl+"/api/student/getStudentById/"+req.session.student, {headers: {"Authorization": req.session.jwt_token}});
            // console.log(response.data);
            return res.render("student-details", {STUDENT_DATA: response.data, signal: null});
        } catch (error) {
            return res.render("student-details", {STUDENT_DATA: null, signal: "INTERNAL_SERVER_ERROR"});   
        }
    }
    return res.redirect("/student");
});
    //----- student time-table oriented -----\\
app.get("/student/timetable", (req, res) => {
    if(req.session.jwt_token) {
        return res.render("student-timetable");
    }
    return res.redirect("/student");
});
app.post("/student/timetable/getTimeTablesBy7Days", async (req, res) => {
    if(!req.session.jwt_token) {
        const LIST_ANNOUNCEMENT = await getListAnnouncement();
        return res.render("student-login", {LIST_ANNOUNCEMENT, error: null});
    } else {
        const token = req.session.jwt_token;
        const studentId = req.session.student;
        const currentDate = req.body.currentDate;
        const datePrev1 = req.body.datePrev1;
        const datePrev2 = req.body.datePrev2;
        const datePrev3 = req.body.datePrev3;
        const datePrev4 = req.body.datePrev4;
        const datePrev5 = req.body.datePrev5;
        const datePrev6 = req.body.datePrev6;
        const filterLoaiLich = req.body.filterLoaiLich;
        const thoiKhoaBieu2DTO = {currentDate, datePrev1, datePrev2, datePrev3, datePrev4, datePrev5, datePrev6, filterLoaiLich, maSinhVien: studentId};
        const response = await axios.post(javaUrl+"/api/time_table/getTimeTablesBy7Days", thoiKhoaBieu2DTO, {headers: {"Authorization": token}});
        if(response.data)
            return res.send(response.data);
        return res.send([]);
    }
});
app.post("/student/timetable/getIdsThoiKhoaBieuCon", async (req, res) => {
    if(!req.session.jwt_token) {
        const LIST_ANNOUNCEMENT = await getListAnnouncement();
        return res.render("student-login", {LIST_ANNOUNCEMENT, error: null});
    } else {
        const token = req.session.jwt_token;
        const studentId = req.session.student;
        const currentDate = req.body.currentDate;
        const datePrev1 = req.body.datePrev1;
        const datePrev2 = req.body.datePrev2;
        const datePrev3 = req.body.datePrev3;
        const datePrev4 = req.body.datePrev4;
        const datePrev5 = req.body.datePrev5;
        const datePrev6 = req.body.datePrev6;
        const filterLoaiLich = req.body.filterLoaiLich;
        const thoiKhoaBieu2DTO = {currentDate, datePrev1, datePrev2, datePrev3, datePrev4, datePrev5, datePrev6, filterLoaiLich, maSinhVien: studentId};
        const response = await axios.post(javaUrl+"/api/time_table/getIdsThoiKhoaBieuCon", thoiKhoaBieu2DTO, {headers: {"Authorization": token}});
        if(response.data)
            return res.send(response.data);
        return res.send([]);
    }
});
    //----- student score oriented -----\\
app.get("/student/score", async (req, res) => {
    if(req.session.jwt_token) {
        const response = await axios.get(javaUrl+"/api/semester/getListSemesterIdByStudentRegister/"+req.session.student, {headers: {"Authorization": req.session.jwt_token}});
        if(response.data) {
            const SEMESTERS = response.data;
            return res.render("student-score", {SEMESTERS, signal: null});
        }
        return res.render("student-score", {SEMESTERS: [], signal: "INTERNAL_SERVER_ERROR"});
    }
    return res.redirect("/student");
});
app.post("/student/score/getStudentScoresBySemesterId", async (req, res) => {
    if(!req.session.jwt_token) {
        const LIST_ANNOUNCEMENT = await getListAnnouncement();
        return res.render("student-login", {LIST_ANNOUNCEMENT, error: null});
    } else {
        const semesterId = req.body.semesterId;
        const response = await axios.get(javaUrl+"/api/score/getStudentScoresBySemesterId/"+req.session.student+"/"+semesterId, {headers: {"Authorization": req.session.jwt_token}});
        if(response.data)
            return res.send(response.data);
        return res.send([]);
    }
});
app.post("/student/score/getScoreByStudentIdAndSubjectId", async (req, res) => {
    if(!req.session.jwt_token) {
        const LIST_ANNOUNCEMENT = await getListAnnouncement();
        return res.render("student-login", {LIST_ANNOUNCEMENT, error: null});
    } else {
        const studentId = req.session.student;
        const subjectId = req.body.subjectId;
        const response = await axios.get(javaUrl+"/api/score/getScoreByStudentIdAndSubjectId/"+studentId+"/"+subjectId, {headers: {"Authorization": req.session.jwt_token}});
        if(response.data)
            return res.send(response.data);
        return res.send(null);
    }
});
    //----- student pattern oriented -----\\
app.get("/student/pattern", async (req, res) => {
    if(req.session.jwt_token) {
        return res.render("student-pattern");
    }
    return res.redirect("/student");
});
app.get("/student/pattern/getSemestersByMajorsId", async (req, res) => {
    if(!req.session.jwt_token) {
        const LIST_ANNOUNCEMENT = await getListAnnouncement();
        return res.render("student-login", {LIST_ANNOUNCEMENT, error: null});
    } else {
        const response = await axios.get(javaUrl+"/api/student/getStudentById/"+req.session.student, {headers: {"Authorization": req.session.jwt_token}});
        const majorsId = response.data.lopHocDanhNghia.nganh.maNganh;
        const response1 = await axios.get(javaUrl+"/api/semester/getSemestersByMajorsId/"+majorsId, {headers: {"Authorization": req.session.jwt_token}});
        if(response1.data) {
            return res.send(response1.data);
        }
        return res.send([]);
    }
});
app.post("/student/pattern/getSubjectsBySemesterIdAndMajorsId", async (req, res) => {
    if(!req.session.jwt_token) {
        const LIST_ANNOUNCEMENT = await getListAnnouncement();
        return res.render("student-login", {LIST_ANNOUNCEMENT, error: null});
    } else {
        const semesterId = req.body.semesterId;
        const majorsId = req.body.majorsId;
        const response = await axios.get(javaUrl+"/api/subject/getSubjectsBySemesterIdAndMajorsId/"+semesterId+"/"+ majorsId, {headers: {"Authorization": req.session.jwt_token}});
        if(response.data) {
            return res.send(response.data);
        }
        return res.send([]);
    }
});
app.post("/student/pattern/getSubjectsPassed", async (req, res) => {
    if(!req.session.jwt_token) {
        const LIST_ANNOUNCEMENT = await getListAnnouncement();
        return res.render("student-login", {LIST_ANNOUNCEMENT, error: null});
    } else {
        const response = await axios.get(javaUrl+"/api/subject/getSubjectsPassed/"+ req.session.student, {headers: {"Authorization": req.session.jwt_token}});
        if(response.data) {
            return res.send(response.data);
        }
        return res.send([]);
    }
});
    //----- student debt oriented -----\\
app.get("/student/debt", async (req, res) => {
    if(req.session.jwt_token) {
        const ma_sinh_vien = req.session.student;
        const token = req.session.jwt_token;
        const response4 = await axios.get(javaUrl+"/api/course/getCoursesByStudentId/" + ma_sinh_vien, {headers: {"Authorization": token}});
        if(response4.data) {
            return res.render("student-debt", {LIST_COURSE: response4.data});
        }
        return res.render("student-debt", {LIST_COURSE: []});
    }
    return res.redirect("/student");
});
app.post("/student/debt/getDebtsByStudentIdAndCourseId", async (req, res) => {
    if(req.session.jwt_token) {
        const maKhoaHoc = req.body.maKhoaHoc;
        const maSinhVien = req.session.student;
        const token = req.session.jwt_token;
        const response = await axios.get(javaUrl+"/api/debt/getDebtsByStudentIdAndCourseId/"+maSinhVien+"/"+maKhoaHoc, {headers: {"Authorization": token}});
        if(response.data)
            return res.send(response.data);
        return res.send([]);
    }
    return res.redirect("/student");
});
app.get("/student/debt/getDebtsByStudentId", async (req, res) => {
    if(req.session.jwt_token) {
        const maSinhVien = req.session.student;
        const token = req.session.jwt_token;
        const response = await axios.get(javaUrl+"/api/debt/getDebtsByStudentId/"+maSinhVien, {headers: {"Authorization": token}});
        if(response.data)
            return res.send(response.data);
        return res.send([]);
    }
    return res.redirect("/student");
});
    //----- student payment oriented -----\\
app.get("/student/payment", async (req, res) => {
    if(req.session.jwt_token) {
        const ma_sinh_vien = req.session.student;
        const token = req.session.jwt_token;
        const response4 = await axios.get(javaUrl+"/api/course/getCoursesByStudentId/" + ma_sinh_vien, {headers: {"Authorization": token}});
        let LIST_COURSE = [];
        if(response4.data)
            LIST_COURSE = response4.data;
        const response = await axios.get(javaUrl+"/api/debt/getUnDebtsByStudentId/" + ma_sinh_vien, {headers: {"Authorization": token}});
        let LIST_DEBT = [];
        if(response.data)
            LIST_DEBT = response.data;
        const response1 = await axios.get(javaUrl+"/api/student/getStudentById/" + ma_sinh_vien, {headers: {"Authorization": token}});
        return res.render("student-payment", {STUDENT_DATA: response1.data, LIST_COURSE, LIST_DEBT});
    }
    return res.redirect("/student");
});
app.post("/student/payment/getUnDebtsByStudentIdAndCourseId", async (req, res) => {
    if(req.session.jwt_token) {
        const studentId = req.session.student;
        const courseId = req.body.courseId;
        const token = req.session.jwt_token;
        const response = await axios.get(javaUrl+"/api/debt/getUnDebtsByStuentIdAndCourseId/"+studentId+"/"+courseId, {headers: {"Authorization": token}});
        if(response.data)
            return res.send(response.data)
        return res.send([]);
    } else {
        return res.redirect("/student");
    }
});
app.get("/student/payment/getUnDebtsByStudentId", async (req, res) => {
    if(req.session.jwt_token) {
        const studentId = req.session.student;
        const token = req.session.jwt_token;
        const response = await axios.get(javaUrl+"/api/debt/getUnDebtsByStudentId/"+studentId, {headers: {"Authorization": token}});
        if(response.data)
            return res.send(response.data);
        return res.send([]);
    } else {
        return res.redirect("/student");
    }
});
app.post("/student/payment/getUnDebtById", async (req, res) => {
    if(req.session.jwt_token) {
        const debtId = req.body.debtId;
        const token = req.session.jwt_token;
        const response = await axios.get(javaUrl+"/api/debt/getUnDebtById/"+debtId, {headers: {"Authorization": token}});
        if(response.data)
            return res.send(response.data)
        return res.send(null);
    } else {
        return res.redirect("/student");
    }
});
app.get("/student/payment/callback", async (req, res) => {
    if(req.session.jwt_token) {
        if(req.query.extraData && req.query.resultCode == 0) {
            const maGiaoDich = req.query.extraData;
            const token = req.session.jwt_token;
            const maSinhVien = req.session.student;
            const response = await axios.get(javaUrl+"/api/payment/getPaymentById/"+maGiaoDich, {headers: {"Authorization": token}});
            if(response.data) {//Nếu có giao dịch hợp lệ
                const paymentObject = response.data;
                //Kiểm tra paymentObject da xu ly hay chua
                if(paymentObject.status == 1) {
                    return res.render("student-callback", {signal: {title: "PAYMENT_CHECKED_OUT", text: "Giao dịch được hoàn tất trước đó. Không thể thanh toán lại!", icon: "warning"}});
                }
                //Kiểm tra maGiaoDich expired hay chưa.
                const expiredTime = new Date (paymentObject.expiredTime);
                const now = new Date();
                if(expiredTime > now) {
                    let soDu = req.query.amount;
                    const stringUnDebtIds = paymentObject.unDebtIds; 
                    let arrayUnDebtIds = stringUnDebtIds.split(",").map(Number);
                    const unDebtCounter = arrayUnDebtIds.length;
                    let payedCounter = 0;
                    let totalPayed = 0;
                    let products = [];
                    for(let i=0; i<unDebtCounter; i++) {
                        const unDebtId = arrayUnDebtIds[i];
                        const debt = await axios.get(javaUrl+"/api/debt/getUnDebtById/"+unDebtId, {headers: {"Authorization": token}});
                        const soTien = debt.data.monHoc.soTinChi * 850000;
                        if(soDu >= soTien) { //nếu còn đủ tiền thanh toán
                            const newUndebt = await axios.get(javaUrl+"/api/debt/updateUnDebtById/"+unDebtId, {headers: {"Authorization": token}});//Giải quyết công nợ here....
                            soDu -= soTien;
                            payedCounter++;
                            totalPayed += soTien;
                            //Update sv_lhp
                            const maLopHocPhan = debt.data.lopHocPhan.maLopHocPhan;
                            const newSvlhp = await axios.get(javaUrl+"/api/sv_lhp/updateStudentRegisSVLHP/"+maSinhVien + "/" + maLopHocPhan, {headers: {"Authorization": token}});
                            //Push các môn đã pay vào list product của hoá đơn
                            const product = {
                                "quantity": 1,
                                "description": newSvlhp.data.lopHocPhan.monHoc.tenMonHoc,
                                "tax-rate": 0,
                                "price": soTien
                            };
                            products.push(product);
                        } else {
                            if(i == 0)
                                return res.render("student-callback", {signal: {title: "PAYMENT_INSUFFICIENT", text: "Thất bại. Số dư ví không đủ, vui lòng nạp thêm tiền!", icon: "warning"}});
                            else break;
                        }
                    }
                    const balanceLeft = await axios.get(javaUrl+"/api/student/updateBalance/"+maSinhVien+"/"+soDu, {headers: {"Authorization": token}});
                    const ghiChu = "Thanh toán thành công: " + payedCounter + "/" + unDebtCounter + " mục. Tổng tiền đã thanh toán: "+ formatCurrency(req.query.amount) +". Số tiến đã thanh toán thành công: "+ formatCurrency(totalPayed) +". Số tiền dư thanh toán còn lại: " + formatCurrency(soDu);
                    //Update ThanhToanGiaoDich thành status pass;
                    const thanhToanGiaoDichDTO = {maGiaoDich: paymentObject.maGiaoDich, ghiChu, balance: req.query.amount};
                    const newPayment = await axios.post(javaUrl+"/api/payment/updatePaymentToPassById", thanhToanGiaoDichDTO, {headers: {"Authorization": token}});
                    //Tạo phieuThu
                    const phieuThu2DTO = {donViThu: req.query.orderType, ghiChu, ngayThu: "", soTien: req.query.amount, trangThai: "DA_XU_LY", maSinhVien, maGiaoDich, loaiPhieuThu: 'OUT'};
                    const order_detail = await axios.post(javaUrl+"/api/order_detail/createOrderDetailBy", phieuThu2DTO, {headers: {"Authorization": token}});
                    //Tạo hddt {hddt chứa nhiều products}
                    const hddtData = {
                        "customize": {
                        },
                        "images": {
                            "logo": "https://inkythuatso.com/uploads/thumbnails/800/2021/11/logo-iuh-inkythuatso-01-08-11-18-25.jpg",
                            "background": "https://public.easyinvoice.cloud/img/watermark-draft.jpg"
                        },
                        "sender": {
                            "company": "Thanh toán học phí - Phương thức: ["+req.query.orderType+"]",
                            "address": "Số 12 Nguyễn Văn Bảo, Phường 4, Quận Gò Vấp, Thành phố Hồ Chí Minh",
                            "zip": "70000 NVB",
                            "city": "Hồ Chí Minh",
                            "country": "Việt Nam"
                        },
                        "client": {
                            "company": order_detail.data.sinhVien.hoTen + " - MSSV: " + maSinhVien,
                            "address": order_detail.data.sinhVien.diaChi,
                            "zip": "70000 HTH",
                            "city": "Hồ Chí Minh",
                            "country": "Việt Nam"
                        },
                        "information": {
                            "number": "2021.0001",
                            "date": new Date().toLocaleTimeString('en-US', { hour: 'numeric', minute: 'numeric', hour12: false }),
                            "due-date": new Date().toLocaleDateString('en-GB'),
                        },
                        "products": products,
                        "bottom-notice": "Đã được toà - Chi cục thế phường - Gò Vấp tỉnh đóng dấu chức thực bảo mật thông tin ✔️.",
                        "settings": {
                            "currency": "VND",
                        },
                        "translate": {
                        },
                    };
                    db.insert({_id: order_detail.data.maPhieuThu, hddtData}, function (err, newDoc) {
                        if(err) {
                            console.error(err.message);
                        } else {
                            console.log('Tạo HDDT thành công: ', newDoc);
                        }
                    });
                    //Gửi mail hddt...
                    const toEmail = order_detail.data.sinhVien.taiKhoan.email;
                    if(toEmail) {
                        //Hàm nhận vào (hddtData, user, products, maSinhVien, orderType, totalPayed, balanceLeft, toEmail)
                        sendEmailHddt(hddtData, order_detail.data.sinhVien.hoTen, products, maSinhVien, req.query.orderType, totalPayed, balanceLeft.data, toEmail);
                    }
                    return res.render("student-callback", {signal: {title: "PAYMENT_SUCCESS", text: ghiChu, icon: "success"}});
                } else {//nếu quá hạn
                    return res.render("student-callback", {signal: {title: "PAYMENT_OUT", text: "Giao dịch đã quá hạn! Bấm xác nhận để quay lại trang chủ.", icon: "warning"}});
                }
            }//Nếu ko thấy giao dịch, do user cố tình bug
            return res.render("student-callback", {signal: {title: "PAYMENT_NOT_FOUND", text: "Không tìm thấy mã giao dịch này! Bấm xác nhận để quay lại trang chủ.", icon: "warning"}});
        } else {
            if(req.query.resultCode == 1006) {
                return res.render("student-callback", {signal: {title: "PAYMENT_FAILED", text: "Thanh toán đã bị huỷ hoặc lỗi phía server. Bấm xác nhận để quay lại trang chủ!", icon: "warning"}});
            }
        }
        return res.send("Hello Error World!");
    } else {
        return res.redirect("/student");
    }
});
app.get("/student/recharge/callback", async (req, res) => {
    if(req.session.jwt_token) {
        if(req.query.extraData && req.query.resultCode == 0) {
            const maGiaoDich = req.query.extraData;
            const token = req.session.jwt_token;
            const maSinhVien = req.session.student;
            const response = await axios.get(javaUrl+"/api/payment/getPaymentById/"+maGiaoDich, {headers: {"Authorization": token}});
            if(response.data) {//Nếu có giao dịch hợp lệ
                const paymentObject = response.data;
                //Kiểm tra paymentObject da xu ly hay chua
                if(paymentObject.status == 1) {
                    return res.render("student-callback", {signal: {title: "PAYMENT_CHECKED_OUT", text: "Giao dịch được hoàn tất trước đó. Không thể thanh toán lại!", icon: "warning"}});
                }
                //Kiểm tra maGiaoDich expired hay chưa.
                const expiredTime = new Date (paymentObject.expiredTime);
                const now = new Date();
                if(expiredTime > now) {//Nếu tg giao dịch hiện tại là trước khi maGiaoDich expired -> hợp lệ
                    let soTienGiaoDich = req.query.amount;//số tiền trong giao dịch
                    //Push số tiền giao dịch vào product của hoá đơn
                    const product = {
                        "quantity": 1,
                        "description": 'NẠP TIỀN VÀO SỐ DƯ VÍ - SINH VIÊN',
                        "tax-rate": 0,
                        "price": soTienGiaoDich
                    };
                    const sinhVienAddBalanceDTO = {maSinhVien, soTienGiaoDich};
                    const balanceLeft = await axios.post(javaUrl+"/api/student/addStudentBalance", sinhVienAddBalanceDTO, {headers: {"Authorization": token}});
                    const ghiChu = "Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: "+ formatCurrency(soTienGiaoDich) +". Số tiến đã thanh toán thành công: "+ formatCurrency(soTienGiaoDich) +". Số tiền dư thanh toán còn lại: " + formatCurrency(balanceLeft.data);
                    //Update ThanhToanGiaoDich thành status pass;
                    const thanhToanGiaoDichDTO = {maGiaoDich: paymentObject.maGiaoDich, ghiChu, balance: soTienGiaoDich};
                    const newPayment = await axios.post(javaUrl+"/api/payment/updatePaymentToPassById", thanhToanGiaoDichDTO, {headers: {"Authorization": token}});
                    //Tạo phieuThu
                    const phieuThu2DTO = {donViThu: req.query.orderType, ghiChu, ngayThu: "", soTien: soTienGiaoDich, trangThai: "DA_XU_LY", maSinhVien, maGiaoDich, loaiPhieuThu: 'IN'};
                    const order_detail = await axios.post(javaUrl+"/api/order_detail/createOrderDetailBy", phieuThu2DTO, {headers: {"Authorization": token}});
                    //Tạo hddt
                    const hddtData = {
                        "customize": {
                        },
                        "images": {
                            "logo": "https://inkythuatso.com/uploads/thumbnails/800/2021/11/logo-iuh-inkythuatso-01-08-11-18-25.jpg",
                            "background": "https://public.easyinvoice.cloud/img/watermark-draft.jpg"
                        },
                        "sender": {
                            "company": "Nạp tiền vào ví - Phương thức: ["+req.query.orderType+"]",
                            "address": "Số 12 Nguyễn Văn Bảo, Phường 4, Quận Gò Vấp, Thành phố Hồ Chí Minh",
                            "zip": "70000 NVB",
                            "city": "Hồ Chí Minh",
                            "country": "Việt Nam"
                        },
                        "client": {
                            "company": order_detail.data.sinhVien.hoTen + " - MSSV: " + maSinhVien,
                            "address": order_detail.data.sinhVien.diaChi,
                            "zip": "70000 HTH",
                            "city": "Hồ Chí Minh",
                            "country": "Việt Nam"
                        },
                        "information": {
                            "number": "2021.0001",
                            "date": new Date().toLocaleTimeString('en-US', { hour: 'numeric', minute: 'numeric', hour12: false }),
                            "due-date": new Date().toLocaleDateString('en-GB'),
                        },
                        "products": [
                            product,
                        ],
                        "bottom-notice": "Đã được toà - Chi cục thế phường - Gò Vấp tỉnh đóng dấu chức thực bảo mật thông tin ✔️.",
                        "settings": {
                            "currency": "VND",
                        },
                        "translate": {
                        },
                    };
                    db.insert({_id: order_detail.data.maPhieuThu, hddtData}, function (err, newDoc) {
                        if(err) {
                            console.error(err.message);
                        } else {
                            console.log('Tạo HDDT thành công: ', newDoc);
                        }
                    });
                    //Gửi mail hddt...
                    const toEmail = order_detail.data.sinhVien.taiKhoan.email;
                    if(toEmail) {
                        //Hàm nhận vào (hddtData, user, products, maSinhVien, orderType, totalPayed, balanceLeft, toEmail)
                        sendEmailHddt(hddtData, order_detail.data.sinhVien.hoTen, [product], maSinhVien, req.query.orderType, soTienGiaoDich, balanceLeft.data, toEmail);
                    }
                    return res.render("student-callback", {signal: {title: "PAYMENT_SUCCESS", text: ghiChu, icon: "success"}});
                } else {//nếu quá hạn
                    return res.render("student-callback", {signal: {title: "PAYMENT_OUT", text: "Giao dịch đã quá hạn! Bấm xác nhận để quay lại trang chủ.", icon: "warning"}});
                }
            }//Nếu ko thấy giao dịch, do user cố tình bug
            return res.render("student-callback", {signal: {title: "PAYMENT_NOT_FOUND", text: "Không tìm thấy mã giao dịch này! Bấm xác nhận để quay lại trang chủ.", icon: "warning"}});
        } else {
            if(req.query.resultCode == 1006) {
                return res.render("student-callback", {signal: {title: "PAYMENT_FAILED", text: "Thanh toán đã bị huỷ hoặc lỗi phía server. Bấm xác nhận để quay lại trang chủ!", icon: "warning"}});
            }
        }
    } else {
        return res.redirect("/student");
    }
});
app.post("/student/payment/resolvePaymentStudentWallet", async (req, res) => {
    if(req.session.jwt_token) {
        try {
            const total_debt = req.body.total_debt;
            const studentId = req.session.student;
            const token = req.session.jwt_token;
            let soDuRespose = await axios.get(javaUrl+"/api/student/getStudentBalance/"+studentId, {headers: {"Authorization": token}});
            let soDu = soDuRespose.data; //SoDu = total_balance của stuent
            const unDebtCounter = total_debt.length;
            let payedCounter = 0;
            let totalPayed = 0;
            let products = [];
            const unDebtIds = total_debt.toString();
            for(let i=0; i<unDebtCounter; i++) {
                const debtId = total_debt[i];
                const debtResponse = await axios.get(javaUrl+"/api/debt/getUnDebtById/"+debtId, {headers: {"Authorization": token}});
                const debt = debtResponse.data;
                const soTien = debt.monHoc.soTinChi * 850000;
                if(soDu >= soTien) {
                    const newUndebt = await axios.get(javaUrl+"/api/debt/updateUnDebtById/"+debtId, {headers: {"Authorization": token}});
                    soDu -= soTien;
                    totalPayed += soTien;
                    payedCounter++;
                    const newSvlhp = await axios.get(javaUrl+"/api/sv_lhp/updateStudentRegisSVLHP/"+studentId + "/" + debt.lopHocPhan.maLopHocPhan, {headers: {"Authorization": token}});
                    //Push các môn đã pay vào list product của hoá đơn
                    const product = {
                        "quantity": 1,
                        "description": newSvlhp.data.lopHocPhan.monHoc.tenMonHoc,
                        "tax-rate": 0,
                        "price": soTien
                    };
                    products.push(product);
                } else {
                    if(i == 0) //Nếu ngay mã 1 ko đủ tiền thì return ko đủ số dư lun
                        return res.send({text: "Thất bại. Số dư ví không đủ, vui lòng nạp thêm tiền!", icon: "warning"});
                    else break;
                }
            }
            const balanceLeft = await axios.get(javaUrl+"/api/student/updateBalance/"+studentId+"/"+soDu, {headers: {"Authorization": token}});
            const ghiChu = "Thanh toán thành công: " + payedCounter + "/" + unDebtCounter + " mục. Tổng tiền đã thanh toán: "+ formatCurrency(soDu + totalPayed) +". Số tiến đã thanh toán thành công: "+ formatCurrency(totalPayed) +". Số tiền thanh toán dư còn lại: " + formatCurrency(soDu);
            //Update ThanhToanGiaoDich thành status pass;
            const thanhToanGiaoDich2DTO = {maSinhVien: studentId, balance: totalPayed, ghiChu, unDebtIds};
            const maGiaoDichResponse = await axios.post(javaUrl+"/api/payment/createTransaction", thanhToanGiaoDich2DTO, {headers: {"Authorization": token}});
            //Tạo phieuThu
            const phieuThu2DTO = {donViThu: "SỐ DƯ VÍ", ghiChu, ngayThu: "", soTien: totalPayed, trangThai: "DA_XU_LY", maSinhVien: studentId, maGiaoDich: maGiaoDichResponse.data};
            const order_detail = await axios.post(javaUrl+"/api/order_detail/createOrderDetailBy", phieuThu2DTO, {headers: {"Authorization": token}});
            const hddtData = {
                "customize": {
                },
                "images": {
                    "logo": "https://inkythuatso.com/uploads/thumbnails/800/2021/11/logo-iuh-inkythuatso-01-08-11-18-25.jpg",
                    "background": "https://public.easyinvoice.cloud/img/watermark-draft.jpg"
                },
                "sender": {
                    "company": "Thanh toán học phí - Phương thức: [SỐ DƯ VÍ]",
                    "address": "Số 12 Nguyễn Văn Bảo, Phường 4, Quận Gò Vấp, Thành phố Hồ Chí Minh",
                    "zip": "70000 NVB",
                    "city": "Hồ Chí Minh",
                    "country": "Việt Nam"
                },
                "client": {
                    "company": order_detail.data.sinhVien.hoTen + " - MSSV: " + studentId,
                    "address": order_detail.data.sinhVien.diaChi,
                    "zip": "70000 HTH",
                    "city": "Hồ Chí Minh",
                    "country": "Việt Nam"
                },
                "information": {
                    "number": "2021.0001",
                    "date": new Date().toLocaleTimeString('en-US', { hour: 'numeric', minute: 'numeric', hour12: false }),
                    "due-date": new Date().toLocaleDateString('en-GB'),
                },
                "products": products,
                "bottom-notice": "Đã được toà - Chi cục thế phường - Gò Vấp tỉnh đóng dấu chức thực bảo mật thông tin ✔️.",
                "settings": {
                    "currency": "VND",
                },
                "translate": {
                },
            };
            db.insert({_id: order_detail.data.maPhieuThu, hddtData}, function (err, newDoc) {
                if(err) {
                    console.error(err.message);
                } else {
                    console.log('Tạo HDDT thành công: ', newDoc);
                }
            });
            const toEmail = order_detail.data.sinhVien.taiKhoan.email;
            if(toEmail) {
                //Hàm nhận vào (hddtData, user, products, maSinhVien, orderType, totalPayed, balanceLeft, toEmail)
                sendEmailHddt(hddtData, order_detail.data.sinhVien.hoTen, products, studentId, 'SỐ DƯ VÍ', totalPayed, balanceLeft.data, toEmail);
            } 
            return res.send({text: ghiChu, icon: "success"});
        } catch (error) {
            console.log("Server catch an error (resolvePaymentStudentWallet): ", error);
            return res.send("Đã xảy ra lỗi không xác định phía server!");
        }
    }
    return res.redirect("/student");
});
   //----- student order-detail oriented -----\\
app.get("/student/order-detail", async (req, res) => {
    if(req.session.jwt_token) {
        const response = await axios.get(javaUrl+"/api/order_detail/getOrderDetailsByStudentId/"+req.session.student, {headers: {"Authorization": req.session.jwt_token}});
        let LIST_ORDER_DETAIL = [];
        if(response.data) {
            LIST_ORDER_DETAIL = response.data;
        }
        return res.render("student-order-detail", {LIST_ORDER_DETAIL});
    }
    return res.redirect("/student");
});
app.post("/student/order-detail/getDebtById", async (req, res) => {
    if(req.session.jwt_token) {
        const unDebtId = req.body.unDebtId;
        const response = await axios.get(javaUrl+"/api/debt/getDebtById/"+unDebtId, {headers: {"Authorization": req.session.jwt_token}});
        if(response.data)
            return res.send(response.data);
        return res.send(null);
    }
    return res.redirect("/student");
});
app.post("/student/order-detail/getHddtById", async (req, res) => {
    if(req.session.jwt_token) {
        const maPhieuThu = req.body.maPhieuThu;
        const hddtData = await db.findOne({ _id: maPhieuThu });
        return res.send(hddtData);
    }
    return res.redirect("/student");
});
   //----- student wallet oriented -----\\
app.get("/student/wallet", async (req, res) => {
    if(req.session.jwt_token) {
        const response1 = await axios.get(javaUrl+"/api/student/getStudentById/" + req.session.student, {headers: {"Authorization": req.session.jwt_token}});//Sử lý cookie mã sv
        return res.render("student-wallet", {STUDENT_DATA: response1.data});
    }
    return res.redirect("/student");
});
app.post("/student/wallet/createTransaction", async (req, res) => {
    if(req.session.jwt_token) {
        const studentId = req.body.studentId;
        const balance = req.body.balance;
        const unDebtIds = 'Array';
        const token = req.session.jwt_token;
        const maGiaoDichResponse = await axios.get(javaUrl+"/api/payment/createTransaction/"+studentId+"/"+balance+"/"+unDebtIds, {headers: {"Authorization": token}});
        if(maGiaoDichResponse.data)
            return res.send(maGiaoDichResponse.data);
        return res.send("");
    }
    return res.redirect("/student");
});
/*
****************            ****            ****            ****    ****************            ****            ****
****        ****        ****    ****        ****            ****    ****        ****        ****    ****        ****
****        ****    ****            ****        ****    ****        ****        ****    ****            ****    ****
****************    ****   ******   ****            ****            ****************    ****   ******   ****    ****
****                ****            ****            ****            ****                ****            ****    ****
****                ****            ****            ****            ****                ****            ****    ****
****                ****            ****            ****            ****                ****            ****    ************
*/
paypal.configure({
    'mode': 'sandbox', //sandbox or live
    'client_id': process.env.PAYPAL_CLIENT_ID,
    'client_secret':  process.env.PAYPAL_SECRET_KEY
});
app.get("/paypal/payment/confirm", async (req, res) => {
    const maThanhToanGiaoDich = req.query.maThanhToanGiaoDich;
    const maCongNo = req.query.maCongNo;
    const maSinhVien = req.query.maSinhVien;
    const soTien = req.query.soTien;
    const tenMonHoc = req.query.tenMonHoc;
    const loaiThanhToan = req.query.loaiThanhToan;
    const maLopHocPhan = req.query.maLopHocPhan;
    const debtData = {maCongNo,soTien,tenMonHoc,loaiThanhToan,maSinhVien,maLopHocPhan,maThanhToanGiaoDich};
    return res.render("student-react-native-paypal-confirm", {debtData});
});
app.post("/paypal/payment", upload.fields([]), async (req, res) => {
    try {
        const maThanhToanGiaoDich = req.body.maThanhToanGiaoDich;
        const maSinhVien = req.body.maSinhVien;
        const maLopHocPhan = req.body.maLopHocPhan;
        const maCongNo = req.body.maCongNo;
        const getTokenByPaymentAndStudentIdReponse = await axios.get(javaUrl+"/api/payment/getTokenByPaymentAndStudentId/"+maThanhToanGiaoDich+"/"+maSinhVien);
        if(getTokenByPaymentAndStudentIdReponse.data) {// Nếu thanh toán gg với mã sinh viên tồn tại trong hệ thống validate
            const token = getTokenByPaymentAndStudentIdReponse.data;
            req.session.jwt_token = token;
            req.session.student = maSinhVien;
            // Lấy ra soTien từ mã môn học
            const congNoResponse = await axios.get(javaUrl+"/api/debt/getUnDebtById/"+maCongNo, {headers: {"Authorization": token}});
            const soTien = congNoResponse.data.monHoc.soTinChi * process.env.SO_TIEN_1_TIN_CHI;
            const price = (soTien / process.env.EXCHANGE_PAYPAL_CURRENCY).toFixed(2);
            const create_payment_json = {
                "intent": "sale",
                "payer": {
                    "payment_method": "paypal"
                },
                "redirect_urls": {
                    "return_url": process.env.EJS_EMULATOR_API_URL+"/paypal/payment/success?maCongNo="+maCongNo+"&maThanhToanGiaoDich="+maThanhToanGiaoDich,
                    "cancel_url": process.env.EJS_EMULATOR_API_URL+"/paypal/payment/cancel"
                },
                "transactions": [{
                    "amount": {
                        "currency": "USD",
                        "total": 1
                    },
                    "description": "This is the payment description."
                }]
            };
    
            paypal.payment.create(create_payment_json, function (error, paymentResponse) {
                if (error) {
                    throw error;
                } else {
                    console.log("Create Payment Response");
                    console.log(paymentResponse);
                    return res.redirect(paymentResponse.links[1].href);
                }
            });
        } else {// Cố tình bug mã thanh toán giao dịch
            return res.redirect("/student");
        }
    } catch (error) {
        console.log("error nè:",error.message);
    }
});
app.get("/paypal/payment/success", async (req, res) => {// Xác thực thanh toán
    if(req.session.jwt_token) {
        const maCongNo = req.query.maCongNo;
        const maGiaoDich = req.query.maThanhToanGiaoDich;
        const paymentId = req.query.paymentId;
        const token = req.session.jwt_token;
        const maSinhVien = req.session.student;
        paypal.payment.get(paymentId, function (error, payment) {
            if (error) {
                console.log(error);
            } else {
                // Lấy giá trị "total"
                const total = payment.transactions[0].amount.total;
                // Tiếp tục xác nhận thanh toán với giá trị "total" này
                // ...
                const PayerID = req.query.PayerID;
                const execute_payment_json = {
                    "payer_id": PayerID,
                    "transactions": [{
                    "amount": {
                        "currency": "USD",
                        "total": total // total ở đây là giá trị bạn đã lấy từ API của PayPal
                    }
                    }]
                };
                paypal.payment.execute(paymentId, execute_payment_json, async function(error, paymentResponse){
                    if(error) {
                        console.error(error.message);
                        throw error;
                    } else {
                        console.log("Look good to verify!");
                        console.log(JSON.stringify(paymentResponse));
                        // Tiến hành thanh toán ở đây....
                        
                        const response = await axios.get(javaUrl+"/api/payment/getPaymentById/"+maGiaoDich, {headers: {"Authorization": token}});
                        if(response.data) {//Nếu có giao dịch hợp lệ
                            const paymentObject = response.data;
                            //Kiểm tra paymentObject da xu ly hay chua
                            if(paymentObject.status == 1) {
                                return res.render("student-callback", {signal: {title: "PAYMENT_CHECKED_OUT", text: "Giao dịch được hoàn tất trước đó. Không thể thanh toán lại!", icon: "warning"}});
                            }
                            //Kiểm tra maGiaoDich expired hay chưa.
                            const expiredTime = new Date (paymentObject.expiredTime);
                            const now = new Date();
                            const products = [];
                            let balanceGiaoDich = parseFloat(total * process.env.EXCHANGE_PAYPAL_CURRENCY);
                            if(expiredTime > now) {
                                const debt = await axios.get(javaUrl+"/api/debt/getUnDebtById/"+maCongNo, {headers: {"Authorization": token}});
                                // Nếu số tiền từ paypal > tiền môn học cần thanh toán
                                const newUndebt = await axios.get(javaUrl+"/api/debt/updateUnDebtById/"+maCongNo, {headers: {"Authorization": token}});// Giải quyết công nợ here....
                                //Update sv_lhp
                                const maLopHocPhan = debt.data.lopHocPhan.maLopHocPhan;
                                const newSvlhp = await axios.get(javaUrl+"/api/sv_lhp/updateStudentRegisSVLHP/"+maSinhVien + "/" + maLopHocPhan, {headers: {"Authorization": token}});
                                //Push các môn đã pay vào list product của hoá đơn
                                const product = {
                                    "quantity": 1,
                                    "description": newSvlhp.data.lopHocPhan.monHoc.tenMonHoc,
                                    "tax-rate": 0,
                                    "price": balanceGiaoDich
                                };
                                products.push(product);
                                const balanceLeft = await axios.get(javaUrl+"/api/student/reduceStudentBalance/"+maSinhVien+"/"+balanceGiaoDich, {headers: {"Authorization": token}});
                                const ghiChu = "Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: "+ formatCurrency(balanceGiaoDich) +". Số tiến đã thanh toán thành công: "+ formatCurrency(balanceGiaoDich) +". Số tiền dư thanh toán còn lại: " + formatCurrency(balanceLeft.data);
                                //Update ThanhToanGiaoDich thành status pass;
                                const thanhToanGiaoDichDTO = {maGiaoDich, ghiChu, balance: balanceGiaoDich};
                                const newPayment = await axios.post(javaUrl+"/api/payment/updatePaymentToPassById", thanhToanGiaoDichDTO, {headers: {"Authorization": token}});
                                //Tạo phieuThu
                                const phieuThu2DTO = {donViThu: req.query.orderType, ghiChu, ngayThu: "", soTien: balanceGiaoDich, trangThai: "DA_XU_LY", maSinhVien, maGiaoDich, loaiPhieuThu: 'OUT'};
                                const order_detail = await axios.post(javaUrl+"/api/order_detail/createOrderDetailBy", phieuThu2DTO, {headers: {"Authorization": token}});
                                //Tạo hddt {hddt chứa nhiều products}
                                const hddtData = {
                                    "customize": {
                                    },
                                    "images": {
                                        "logo": "https://inkythuatso.com/uploads/thumbnails/800/2021/11/logo-iuh-inkythuatso-01-08-11-18-25.jpg",
                                        "background": "https://public.easyinvoice.cloud/img/watermark-draft.jpg"
                                    },
                                    "sender": {
                                        "company": "Thanh toán học phí - Phương thức: [PAYPAL - WALLET]",
                                        "address": "Số 12 Nguyễn Văn Bảo, Phường 4, Quận Gò Vấp, Thành phố Hồ Chí Minh",
                                        "zip": "70000 NVB",
                                        "city": "Hồ Chí Minh",
                                        "country": "Việt Nam"
                                    },
                                    "client": {
                                        "company": order_detail.data.sinhVien.hoTen + " - MSSV: " + maSinhVien,
                                        "address": order_detail.data.sinhVien.diaChi,
                                        "zip": "70000 HTH",
                                        "city": "Hồ Chí Minh",
                                        "country": "Việt Nam"
                                    },
                                    "information": {
                                        "number": "2021.0001",
                                        "date": new Date().toLocaleTimeString('en-US', { hour: 'numeric', minute: 'numeric', hour12: false }),
                                        "due-date": new Date().toLocaleDateString('en-GB'),
                                    },
                                    "products": products,
                                    "bottom-notice": "Đã được toà - Chi cục thế phường - Gò Vấp tỉnh đóng dấu chức thực bảo mật thông tin ✔️.",
                                    "settings": {
                                        "currency": "VND",
                                    },
                                    "translate": {
                                    },
                                };
                                db.insert({_id: order_detail.data.maPhieuThu, hddtData}, function (err, newDoc) {
                                    if(err) {
                                        console.error(err.message);
                                    } else {
                                        console.log('Tạo HDDT thành công: ', newDoc);
                                    }
                                });
                                //Gửi mail hddt...
                                const toEmail = order_detail.data.sinhVien.taiKhoan.email;
                                if(toEmail) {
                                    //Hàm nhận vào (hddtData, user, products, maSinhVien, orderType, totalPayed, balanceLeft, toEmail)
                                    sendEmailHddt(hddtData, order_detail.data.sinhVien.hoTen, products, maSinhVien, 'PAYPAL - WALLET', balanceGiaoDich, balanceLeft.data, toEmail);
                                }
                                return res.render("student-callback", {signal: {title: "PAYMENT_SUCCESS", text: ghiChu, icon: "success"}});
                            } else {//nếu quá hạn
                                return res.render("student-callback", {signal: {title: "PAYMENT_OUT", text: "Giao dịch đã quá hạn! Bấm xác nhận để quay lại trang chủ.", icon: "warning"}});
                            }
                        }//Nếu ko thấy giao dịch, do user cố tình bug
                        return res.render("student-callback", {signal: {title: "PAYMENT_NOT_FOUND", text: "Không tìm thấy mã giao dịch này! Bấm xác nhận để quay lại trang chủ.", icon: "warning"}});
                    }
                });
            }
        });
    } else {
        return res.redirect("/student");
    }
});
app.get("/paypal/payment/cancel", async (req, res) => {
    return res.render("student-react-native-paypal-cancel");
});

// app.get("/paypal/recharge/confirm", async (req, res) => {
//     const maThanhToanGiaoDich = req.query.maThanhToanGiaoDich;
//     const maSinhVien = req.query.maSinhVien;
//     const tenSinhVien = req.query.tenSinhVien;
//     const soTien = req.query.balanceGiaoDich;
//     const loaiThanhToan = req.query.loaiThanhToan;
//     const rechargeData = {maThanhToanGiaoDich, maSinhVien, tenSinhVien, soTien, loaiThanhToan};
//     return res.render("student-react-native-recharge-confirm", {rechargeData});
// });
app.get("/paypal/topup", upload.fields([]), async (req, res) => {
    try {
        const maThanhToanGiaoDich = req.query.maThanhToanGiaoDich;
        const maSinhVien = req.query.maSinhVien;
        const balanceToRecharge = req.query.balanceGiaoDich;
        const getTokenByPaymentAndStudentIdReponse = await axios.get(javaUrl+"/api/payment/getTokenByPaymentAndStudentId/"+maThanhToanGiaoDich+"/"+maSinhVien);
        if(getTokenByPaymentAndStudentIdReponse.data) {// Nếu có token trả về
            const token = getTokenByPaymentAndStudentIdReponse.data;
            const response = await axios.get(javaUrl+"/api/payment/getPaymentById/"+maThanhToanGiaoDich, {headers: {"Authorization": token}});// Lấy thanhToanGiaoDich đẻ check coi còn validate dc k
            if(response.data) {
                const paymentObject = response.data;
                //Kiểm tra paymentObject da xu ly hay chua
                if(paymentObject.status == 1) {
                    return res.render("student-callback", {signal: {title: "PAYMENT_CHECKED_OUT", text: "Giao dịch được hoàn tất trước đó. Không thể thanh toán lại!", icon: "warning"}});
                }
                //Kiểm tra maGiaoDich expired hay chưa.
                const expiredTime = new Date (paymentObject.expiredTime);
                const now = new Date();
                if(expiredTime > now) {// Đúng flow, no bugs
                    req.session.jwt_token = token;
                    req.session.student = maSinhVien;
                    // Render paypal
                    const price = (balanceToRecharge / process.env.EXCHANGE_PAYPAL_CURRENCY).toFixed(2);
                    const create_payment_json = {
                        "intent": "sale",
                        "payer": {
                            "payment_method": "paypal"
                        },
                        "redirect_urls": {
                            "return_url": process.env.EJS_EMULATOR_API_URL+"/paypal/topup/success?maThanhToanGiaoDich="+maThanhToanGiaoDich,
                            "cancel_url": process.env.EJS_EMULATOR_API_URL+"/paypal/topup/cancel"
                        },
                        "transactions": [{
                            "amount": {
                                "currency": "USD",
                                "total": price
                            },
                            "description": "This is the payment description."
                        }]
                    };
                    paypal.payment.create(create_payment_json, function (error, paymentResponse) {
                        if (error) {
                            throw error;
                        } else {
                            console.log("Create Payment Response");
                            console.log(paymentResponse);
                            return res.redirect(paymentResponse.links[1].href);
                        }
                    });
                } else {//nếu quá hạn
                    return res.render("student-callback", {signal: {title: "PAYMENT_OUT", text: "Giao dịch đã quá hạn! Bấm xác nhận để quay lại trang chủ.", icon: "warning"}});
                }
            } else {// thanhToanGiaoDich ko tồn tai
                return res.render("student-callback", {signal: {title: "PAYMENT_NOT_FOUND", text: "Không tìm thấy mã giao dịch này! Bấm xác nhận để quay lại trang chủ.", icon: "warning"}});
            }
        } else {// Bugs ko tìm thấy token xảy ra do cố tình
            return res.render("student-callback", {signal: {title: "PAYMENT_FAILED", text: "Thanh toán đã bị huỷ hoặc lỗi phía server. Bấm xác nhận để quay lại trang chủ!", icon: "warning"}});
        }
    } catch (error) {
        console.log("error nè:",error.message);
    }
});
app.get("/paypal/topup/success", async (req, res) => {// Xác thực thanh toán
    if(req.session.jwt_token) {
        const maGiaoDich = req.query.maThanhToanGiaoDich;
        const paymentId = req.query.paymentId;
        const token = req.session.jwt_token;
        const maSinhVien = req.session.student;
        paypal.payment.get(paymentId, function (error, payment) {
            if (error) {
                console.log(error);
            } else {
                const total = payment.transactions[0].amount.total;
                const PayerID = req.query.PayerID;
                const execute_payment_json = {
                    "payer_id": PayerID,
                    "transactions": [{
                    "amount": {
                        "currency": "USD",
                        "total": total // total ở đây là giá trị bạn đã lấy từ API của PayPal
                    }
                    }]
                };
                paypal.payment.execute(paymentId, execute_payment_json, async function(error, paymentResponse){
                    if(error) {
                        console.error(error.message);
                        throw error;
                    } else {
                        console.log("Look good to verify!");
                        console.log(JSON.stringify(paymentResponse));
                        // Tiến hành thanh toán ở đây....
                        const response = await axios.get(javaUrl+"/api/payment/getPaymentById/"+maGiaoDich, {headers: {"Authorization": token}});
                        if(response.data) {//Nếu có giao dịch hợp lệ
                            const paymentObject = response.data;
                            //Kiểm tra paymentObject da xu ly hay chua
                            if(paymentObject.status == 1) {
                                return res.render("student-callback", {signal: {title: "PAYMENT_CHECKED_OUT", text: "Giao dịch được hoàn tất trước đó. Không thể thanh toán lại!", icon: "warning"}});
                            }
                            //Kiểm tra maGiaoDich expired hay chưa.
                            const expiredTime = new Date (paymentObject.expiredTime);
                            const now = new Date();
                            const products = [];
                            let soTienGiaoDich = parseFloat(total * process.env.EXCHANGE_PAYPAL_CURRENCY);// số tiền trong giao dịch
                            if(expiredTime > now) {//Nếu tg giao dịch hiện tại là trước khi maGiaoDich expired -> hợp lệ
                                //Push số tiền giao dịch vào product của hoá đơn
                                const product = {
                                    "quantity": 1,
                                    "description": 'NẠP TIỀN VÀO SỐ DƯ VÍ - SINH VIÊN',
                                    "tax-rate": 0,
                                    "price": soTienGiaoDich
                                };
                                const sinhVienAddBalanceDTO = {maSinhVien, soTienGiaoDich};
                                const balanceLeft = await axios.post(javaUrl+"/api/student/addStudentBalance", sinhVienAddBalanceDTO, {headers: {"Authorization": token}});
                                const ghiChu = "Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: "+ formatCurrency(soTienGiaoDich) +". Số tiến đã thanh toán thành công: "+ formatCurrency(soTienGiaoDich) +". Số tiền dư thanh toán còn lại: " + formatCurrency(balanceLeft.data);
                                //Update ThanhToanGiaoDich thành status pass;
                                const thanhToanGiaoDichDTO = {maGiaoDich: paymentObject.maGiaoDich, ghiChu, balance: soTienGiaoDich};
                                const newPayment = await axios.post(javaUrl+"/api/payment/updatePaymentToPassById", thanhToanGiaoDichDTO, {headers: {"Authorization": token}});
                                //Tạo phieuThu
                                const phieuThu2DTO = {donViThu: "PAYPAL - WALLET", ghiChu, ngayThu: "", soTien: soTienGiaoDich, trangThai: "DA_XU_LY", maSinhVien, maGiaoDich, loaiPhieuThu: 'IN'};
                                const order_detail = await axios.post(javaUrl+"/api/order_detail/createOrderDetailBy", phieuThu2DTO, {headers: {"Authorization": token}});
                                //Tạo hddt
                                const hddtData = {
                                    "customize": {
                                    },
                                    "images": {
                                        "logo": "https://inkythuatso.com/uploads/thumbnails/800/2021/11/logo-iuh-inkythuatso-01-08-11-18-25.jpg",
                                        "background": "https://public.easyinvoice.cloud/img/watermark-draft.jpg"
                                    },
                                    "sender": {
                                        "company": "Nạp tiền vào ví - Phương thức: [PAYPAL - WALLET]",
                                        "address": "Số 12 Nguyễn Văn Bảo, Phường 4, Quận Gò Vấp, Thành phố Hồ Chí Minh",
                                        "zip": "70000 NVB",
                                        "city": "Hồ Chí Minh",
                                        "country": "Việt Nam"
                                    },
                                    "client": {
                                        "company": order_detail.data.sinhVien.hoTen + " - MSSV: " + maSinhVien,
                                        "address": order_detail.data.sinhVien.diaChi,
                                        "zip": "70000 HTH",
                                        "city": "Hồ Chí Minh",
                                        "country": "Việt Nam"
                                    },
                                    "information": {
                                        "number": "2021.0001",
                                        "date": new Date().toLocaleTimeString('en-US', { hour: 'numeric', minute: 'numeric', hour12: false }),
                                        "due-date": new Date().toLocaleDateString('en-GB'),
                                    },
                                    "products": [
                                        product,
                                    ],
                                    "bottom-notice": "Đã được toà - Chi cục thế phường - Gò Vấp tỉnh đóng dấu chức thực bảo mật thông tin ✔️.",
                                    "settings": {
                                        "currency": "VND",
                                    },
                                    "translate": {
                                    },
                                };
                                db.insert({_id: order_detail.data.maPhieuThu, hddtData}, function (err, newDoc) {
                                    if(err) {
                                        console.error(err.message);
                                    } else {
                                        console.log('Tạo HDDT thành công: ', newDoc);
                                    }
                                });
                                //Gửi mail hddt...
                                const toEmail = order_detail.data.sinhVien.taiKhoan.email;
                                if(toEmail) {
                                    //Hàm nhận vào (hddtData, user, products, maSinhVien, orderType, totalPayed, balanceLeft, toEmail)
                                    sendEmailHddt(hddtData, order_detail.data.sinhVien.hoTen, [product], maSinhVien, "PAYPAL - WALLET", soTienGiaoDich, balanceLeft.data, toEmail);
                                }
                                return res.render("student-callback", {signal: {title: "PAYMENT_SUCCESS", text: ghiChu, icon: "success"}});
                            } else {//nếu quá hạn
                                return res.render("student-callback", {signal: {title: "PAYMENT_OUT", text: "Giao dịch đã quá hạn! Bấm xác nhận để quay lại trang chủ.", icon: "warning"}});
                            }
                        }//Nếu ko thấy giao dịch, do user cố tình bug
                        return res.render("student-callback", {signal: {title: "PAYMENT_NOT_FOUND", text: "Không tìm thấy mã giao dịch này! Bấm xác nhận để quay lại trang chủ.", icon: "warning"}});
                    }
                });
            }
        });
    } else {
        return res.redirect("/student");
    }
});
app.get("/paypal/topup/cancel", async (req, res) => {
    return res.render("student-react-native-paypal-cancel");
});
/**
****                ****        ********        ****            ****            ****************    ********************
****                ****    ****        ****    ****            ****            ****                        ****
****    ********    ****    ****        ****    ****            ****            ****                        ****
****    ********    ****    ****        ****    ****            ****            ****************            ****
****    ********    ****    ****************    ****            ****            ****                        ****
****    ********    ****    ****        ****    ****            ****            ****                        ****
****    ********    ****    ****        ****    ****            ****            ****                        ****
********        ********    ****        ****    ************    ************    ****************            ****
 */
 app.get("/wallet/payment", async (req, res) => {
    try {
        const maThanhToanGiaoDich = req.query.maThanhToanGiaoDich;
        const maSinhVien = req.query.maSinhVien;
        const maCongNo = req.query.maCongNo;
        /*
            Giải thuật:
            1. Xác thực = maGiaoDich
                OK {
                    Tạo token req
                    Kiểm tra expired maGiaoDich
                    Giải quyết công nợ
                } else {
                    ...
                } debt
        */
        const getTokenByPaymentAndStudentIdReponse = await axios.get(javaUrl+"/api/payment/getTokenByPaymentAndStudentId/"+maThanhToanGiaoDich+"/"+maSinhVien);
        if(getTokenByPaymentAndStudentIdReponse.data) {// Nếu có token trả về
            const token = getTokenByPaymentAndStudentIdReponse.data;
            const response = await axios.get(javaUrl+"/api/payment/getPaymentById/"+maThanhToanGiaoDich, {headers: {"Authorization": token}});// Lấy thanhToanGiaoDich đẻ check coi còn validate dc k
            if(response.data) {
                const paymentObject = response.data;
                //Kiểm tra paymentObject da xu ly hay chua
                if(paymentObject.status == 1) {
                    return res.render("student-callback", {signal: {title: "PAYMENT_CHECKED_OUT", text: "Giao dịch được hoàn tất trước đó. Không thể thanh toán lại!", icon: "warning"}});
                }
                //Kiểm tra maGiaoDich expired hay chưa.
                const expiredTime = new Date (paymentObject.expiredTime);
                const now = new Date();
                if(expiredTime > now) {// Đúng flow, no bugs
                    req.session.jwt_token = token;
                    req.session.student = maSinhVien;
                    // 1. Tính tiền từ maCongNo
                    const congNoResponse = await axios.get(javaUrl+"/api/debt/getUnDebtById/"+maCongNo, {headers: {"Authorization": token}});
                    const soTienCongNo = congNoResponse.data.monHoc.soTinChi * process.env.SO_TIEN_1_TIN_CHI;
                    const studentBalanceReponse = await axios.get(javaUrl+"/api/student/getStudentBalance/"+maSinhVien, {headers: {"Authorization": token}});
                    const studentBalance = studentBalanceReponse.data;
                    if(studentBalance < soTienCongNo) {
                        return res.render("student-callback", {signal: {title: "INSUFFICIENT", text: "Giao dịch thất bại! Số dư ví không đủ.", icon: "warning"}});
                    } else {



                        const products = [];
                        const newUndebt = await axios.get(javaUrl+"/api/debt/updateUnDebtById/"+maCongNo, {headers: {"Authorization": token}});// Giải quyết công nợ here....
                        //Update sv_lhp
                        const maLopHocPhan = congNoResponse.data.lopHocPhan.maLopHocPhan;
                        const newSvlhp = await axios.get(javaUrl+"/api/sv_lhp/updateStudentRegisSVLHP/"+maSinhVien + "/" + maLopHocPhan, {headers: {"Authorization": token}});
                        //Push các môn đã pay vào list product của hoá đơn
                        const product = {
                            "quantity": 1,
                            "description": newSvlhp.data.lopHocPhan.monHoc.tenMonHoc,
                            "tax-rate": 0,
                            "price": soTienCongNo
                        };
                        products.push(product);
                        const balanceLeft = await axios.get(javaUrl+"/api/student/reduceStudentBalance/"+maSinhVien+"/"+soTienCongNo, {headers: {"Authorization": token}});
                        const ghiChu = "Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: "+ formatCurrency(soTienCongNo) +". Số tiến đã thanh toán thành công: "+ formatCurrency(soTienCongNo) +". Số tiền dư thanh toán còn lại: " + formatCurrency(balanceLeft.data);
                        //Update ThanhToanGiaoDich thành status pass;
                        const thanhToanGiaoDichDTO = {maGiaoDich: maThanhToanGiaoDich, ghiChu, balance: soTienCongNo};
                        const newPayment = await axios.post(javaUrl+"/api/payment/updatePaymentToPassById", thanhToanGiaoDichDTO, {headers: {"Authorization": token}});
                        //Tạo phieuThu
                        const phieuThu2DTO = {donViThu: "STUDENT - WALLET", ghiChu, ngayThu: "", soTien: soTienCongNo, trangThai: "DA_XU_LY", maSinhVien, maGiaoDich: maThanhToanGiaoDich, loaiPhieuThu: 'OUT'};
                        const order_detail = await axios.post(javaUrl+"/api/order_detail/createOrderDetailBy", phieuThu2DTO, {headers: {"Authorization": token}});
                        //Tạo hddt {hddt chứa nhiều products}
                        const hddtData = {
                            "customize": {
                            },
                            "images": {
                                "logo": "https://inkythuatso.com/uploads/thumbnails/800/2021/11/logo-iuh-inkythuatso-01-08-11-18-25.jpg",
                                "background": "https://public.easyinvoice.cloud/img/watermark-draft.jpg"
                            },
                            "sender": {
                                "company": "Thanh toán học phí - Phương thức: [PAYPAL - WALLET]",
                                "address": "Số 12 Nguyễn Văn Bảo, Phường 4, Quận Gò Vấp, Thành phố Hồ Chí Minh",
                                "zip": "70000 NVB",
                                "city": "Hồ Chí Minh",
                                "country": "Việt Nam"
                            },
                            "client": {
                                "company": order_detail.data.sinhVien.hoTen + " - MSSV: " + maSinhVien,
                                "address": order_detail.data.sinhVien.diaChi,
                                "zip": "70000 HTH",
                                "city": "Hồ Chí Minh",
                                "country": "Việt Nam"
                            },
                            "information": {
                                "number": "2021.0001",
                                "date": new Date().toLocaleTimeString('en-US', { hour: 'numeric', minute: 'numeric', hour12: false }),
                                "due-date": new Date().toLocaleDateString('en-GB'),
                            },
                            "products": products,
                            "bottom-notice": "Đã được toà - Chi cục thế phường - Gò Vấp tỉnh đóng dấu chức thực bảo mật thông tin ✔️.",
                            "settings": {
                                "currency": "VND",
                            },
                            "translate": {
                            },
                        };
                        db.insert({_id: order_detail.data.maPhieuThu, hddtData}, function (err, newDoc) {
                            if(err) {
                                console.error(err.message);
                            } else {
                                console.log('Tạo HDDT thành công: ', newDoc);
                            }
                        });
                        //Gửi mail hddt...
                        const toEmail = order_detail.data.sinhVien.taiKhoan.email;
                        if(toEmail) {
                            //Hàm nhận vào (hddtData, user, products, maSinhVien, orderType, totalPayed, balanceLeft, toEmail)
                            sendEmailHddt(hddtData, order_detail.data.sinhVien.hoTen, products, maSinhVien, 'STUDENT - WALLET', soTienCongNo, balanceLeft.data, toEmail);
                        }
                        return res.render("student-callback", {signal: {title: "PAYMENT_SUCCESS", text: ghiChu, icon: "success"}});








                    }
                } else {//nếu quá hạn
                    return res.render("student-callback", {signal: {title: "PAYMENT_OUT", text: "Giao dịch đã quá hạn! Bấm xác nhận để quay lại trang chủ.", icon: "warning"}});
                }
            } else {// thanhToanGiaoDich ko tồn tai
                return res.render("student-callback", {signal: {title: "PAYMENT_NOT_FOUND", text: "Không tìm thấy mã giao dịch này! Bấm xác nhận để quay lại trang chủ.", icon: "warning"}});
            }
        } else {// Bugs ko tìm thấy token xảy ra do cố tình
            return res.render("student-callback", {signal: {title: "PAYMENT_FAILED", text: "Thanh toán đã bị huỷ hoặc lỗi phía server. Bấm xác nhận để quay lại trang chủ!", icon: "warning"}});
        }
    } catch (error) {
        console.log("error nè:",error);
    }
});
/**
    ********        ****************    ****************                ****    ************
  ****    ****      ****        ****    ****        ****                ****    ****
****        ****    ****        ****    ****        ****                ****    ************
****************    ****************    ****************                ****            ****
****        ****    ****                ****               ****         ****            ****
****        ****    ****                ****               ****     ****        ************
 */
const options = {
    key: fs.readFileSync('./ssl/privkey.pem'),
    cert: fs.readFileSync('./ssl/fullchain.pem'),
};
const server = https.createServer(options, app);
server.listen(4000, () => {
    console.log('Server is running in 4000....');
});
const io = socket(server);
io.on('connection', (socket) => {
    console.log('New client connected');





    firebaseDB.collection('lop_hoc_phan').onSnapshot((snapshot) => {
        snapshot.docChanges().forEach((change) => {
          if (change.type === "added") {
            // console.log("New document added: ", change.doc.data());
            // Render lại HTML tương ứng
          }
          if (change.type === "modified") {
            // console.log("Modified document: ", change.doc.data());
            // Render lại HTML tương ứng
            socket.emit('dataChange', change.doc.data());
          }
          if (change.type === "removed") {
            // console.log("Removed document: ", change.doc.data());
            // Render lại HTML tương ứng
          }
        });
    });








    
    socket.on('disconnect', () => {
      console.log('Client disconnected');
    });
});
