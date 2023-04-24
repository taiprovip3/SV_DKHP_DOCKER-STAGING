const express = require('express');
const employeeFeatureRouter = express.Router();
const app = express();
const cors = require("cors");
const bodyParser = require('body-parser');
const multer = require('multer');
const mysql = require("mysql");
const bcrypt = require("bcrypt");
const axios = require("axios");
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
const exceljs = require('exceljs');
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
const { getListStudent } = require('./employee-functional');
const { getListClass } = require('./employee-functional');
const { getListTeacher } = require('./employee-functional');
const { getListCourse } = require('./employee-functional');
const { getListDepartment } = require('./employee-functional');
const { getListMajors } = require('./employee-functional');
const { getListAnnouncement } = require('./employee-functional');
const { getListUnitClass } = require('./employee-functional');
const { getListTimeTable } = require('./employee-functional');
const { getListTimeTableCon } = require('./employee-functional');
const { getListDebt } = require('./employee-functional');
const { getListOrderDetail } = require('./employee-functional');
const { addLopHocPhan } = require('./employee-functional');











//----- CRUD Student Oriented -----\\
employeeFeatureRouter.get("/employee-crud-student", async (req, res) => {
    if(req.session.employee) {
        const limit = Number(req.query.limit) || 10;
        const LIST_STUDENT_METADATA = await getListStudent(limit);
        return res.render("employee-crud-student", {LIST_STUDENT_METADATA, signal: null});
    } else {
        return res.redirect("/employee");
    }
});
employeeFeatureRouter.post("/employee-crud-add-student", upload.fields([]), async (req,res) => {
    if(req.session.employee) {
        const student = {hoTen:req.body.ho_ten, gioiTinh:req.body.gioi_tinh, ngaySinh:req.body.ngay_sinh, noiSinh:req.body.noi_sinh, sdt:req.body.sdt, diaChi:req.body.dia_chi, cccd:req.body.cccd, ngayVaoTruong:req.body.ngay_vao_truong, totNghiep:req.body.tot_nghiep, maLopDanhNghia:req.body.ma_lop_danh_nghia,avatar:req.body.avatar, matKhau:bcrypt.hashSync(req.body.mat_khau, 10), bacDaoTao: req.body.bac_dao_tao, loaiHinhDaoTao: req.body.loaiHinhDaoTao, coSo:req.body.co_so, email:req.body.email};
        const response = await axios.post(javaUrl+"/api/student/add", student, {headers: {"Authorization": req.session.employee_token}});
        const LIST_STUDENT_METADATA = await getListStudent();
        if(response.data)
            return res.render("employee-crud-student", {LIST_STUDENT_METADATA, signal: "INSERT_SUCCESS"});
        return res.render("employee-crud-student", {LIST_STUDENT_METADATA, signal: "INTERNAL_SERVER_ERROR"});
    }
    return res.redirect("/employee");
});
employeeFeatureRouter.post("/employee-crud-delete-student", upload.fields([]), async (req, res) => {
    if(req.session.employee) {
        const listCheckboxChecked = Object.keys(req.body);
        const response = await axios.post(javaUrl+'/api/student/remove', listCheckboxChecked, {headers: {"Authorization": req.session.employee_token}});
        const LIST_STUDENT_METADATA = await getListStudent();
        if(response.data)
            return res.render("employee-crud-student", {LIST_STUDENT_METADATA, signal: "INSERT_SUCCESS"});
        return res.render("employee-crud-student", {LIST_STUDENT_METADATA, signal: "INTERNAL_SERVER_ERROR"});
    }
    return res.redirect("/employee");
});
    //----- CRUD Class Oriented -----\\
employeeFeatureRouter.get("/employee-crud-class", async (req, res) => {
    if(req.session.employee) {
        const LIST_CLASS = await getListClass();
        return res.render("employee-crud-class", {LIST_CLASS, signal: null});
    }
    return res.redirect("/employee");
});
employeeFeatureRouter.post("/employee-crud-add-class", upload.fields([]), async (req, res) => {
    if(req.session.employee) {
        const myClass = {tenLop: req.body.ten_lop, soLuong: req.body.so_luong, maGiaoVien: req.body.ma_giao_vien, maKhoaHoc: req.body.ma_khoa_hoc, maNganh: req.body.ma_nganh};
        const response = await axios.post(javaUrl+"/api/class/add", myClass, {headers: {"Authorization": req.session.employee_token}});
        const LIST_CLASS = await getListClass();
        if(response.data)
            return res.render("employee-crud-class", {LIST_CLASS, signal: "INSERT_SUCCESS"});
        return res.render("employee-crud-class", {LIST_CLASS, signal: "INTERNAL_SERVER_ERROR"});
    }
    return res.redirect("/employee");
});
employeeFeatureRouter.post("/employee-crud-class-excel-import", upload.single("excel_file"), async (req, res, next) => {
    if(req.session.employee) {
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
                    const myClass = {tenLop: e.ten_lop, soLuong: e.so_luong, maGiaoVien:e.ma_giao_vien, maKhoaHoc: e.ma_khoa_hoc, maNganh: e.ma_nganh};
                    const response = await axios.post(javaUrl+"/api/class/add", myClass, {headers: {"Authorization": req.session.employee_token}});
                }
            }));
            const LIST_CLASS = await getListClass();
            return res.render("employee-crud-class", {LIST_CLASS, signal: "INSERT_SUCCESS"});
        } catch (err) {
            // return res.status(500).json({ success: false, message: err.message });
            console.error(err.message);
            const LIST_CLASS = await getListClass();
            return res.render("employee-crud-class", {LIST_CLASS, signal: "INTERNAL_SERVER_ERROR"});
        }
    }
    return res.redirect("/employee");
});
    //----- CRUD Teacher Oriented -----\\
employeeFeatureRouter.get("/employee-crud-teacher", async (req, res) => {
    if(req.session.employee) {
        const LIST_TEACHER = await getListTeacher();
        return res.render("employee-crud-teacher", {LIST_TEACHER, signal: null});

    }
    return res.redirect("/employee");
});
employeeFeatureRouter.post("/employee-crud-add-teacher", upload.fields([]), async (req, res) => {
    if(req.session.employee) {
        const salt = bcrypt.genSaltSync(10);
        const hash = bcrypt.hashSync(req.body.mat_khau, salt);
        const teacher = {tenGiaoVien:req.body.ten_giao_vien, diaChi:req.body.dia_chi, gioiTinh:req.body.gioi_tinh,loaiGiaoVien:req.body.loai_giao_vien, ngaySinh:req.body.ngay_sinh, sdt:req.body.sdt, password:hash};
        const response = await axios.post(javaUrl+"/api/teacher/add", teacher, {headers: {"Authorization": req.session.employee_token}});
        const LIST_TEACHER = await getListTeacher();
        if(response.data)
            return res.render("employee-crud-teacher", {LIST_TEACHER, signal: "INSERT_SUCCESS"});
        return res.render("employee-crud-teacher", {LIST_TEACHER, signal: "INTERNAL_SERVER_ERROR"});
    }
    return res.redirect("/employee");
});
    //----- CRUD Course Oriented -----\\
employeeFeatureRouter.get("/employee-crud-course", async (req, res) => {
    if(req.session.employee) {
        const LIST_COURSE = await getListCourse();
        return res.render("employee-crud-course", {LIST_COURSE, signal: null});
    }
    return res.redirect("/employee");
});
employeeFeatureRouter.post("/employee-crud-add-course", upload.fields([]), async (req, res) => {
    if(req.session.employee) {
        const data = req.body;
        const course = {tenKhoaHoc:data.ten_khoa_hoc, alias:data.ten_khoa_hoc, namBatDau: data.nam_bat_dau, namKetThuc: data.nam_ket_thuc, maHocKy: data.ma_hoc_ky};
        const response = await axios.post(javaUrl+"/api/course/add", course, {headers: {"Authorization": req.session.employee_token}});
        const LIST_COURSE = await getListCourse();
        if(response.data)
            return res.render("employee-crud-course", {LIST_COURSE, signal: "INSERT_SUCCESS"});
        return res.render("employee-crud-course", {LIST_COURSE, signal: "INTERNAL_SERVER_ERROR"});
    }
    return res.redirect("/employee");
});
    //----- CRUD Department Oriented -----\\
employeeFeatureRouter.get("/employee-crud-department", async (req, res) => {
    if(req.session.employee) {
        const LIST_DEPARTMENT = await getListDepartment();
        return res.render("employee-crud-department", {LIST_DEPARTMENT, signal: null});
    }
    return res.redirect("/employee");
});
    //----- CRUD Majors Oriented -----\\
employeeFeatureRouter.get("/employee-crud-majors", async (req, res) => {
    if(req.session.employee) {
        const LIST_MAJORS = await getListMajors();
        return res.render("employee-crud-majors", {LIST_MAJORS, signal: null});
    }
    return res.redirect("/employee");
});
    //----- CRUD Deparment Announcement Oriented -----\\
employeeFeatureRouter.get("/employee-crud-department_announcement", async (req, res) => {
    if(req.session.employee) {
        const LIST_ANNOUNCEMENT = await getListAnnouncement();
        return res.render("employee-crud-department_announcement", {LIST_ANNOUNCEMENT, signal: null});
    }
    return res.redirect("/employee");
});
    //----- CRUD Pattern Oriented -----\\
employeeFeatureRouter.get("/employee-crud-pattern", (req, res) => {
    return res.render("employee-crud-pattern", {signal: null});
});
employeeFeatureRouter.post("/employee-crud-add-pattern", upload.fields([]), async (req, res) => {
    if(req.session.employee) {
        const data = req.body;
        const  response = await axios.post(javaUrl+"/api/pattern/add", data, {headers: {"Authorization": req.session.employee_token}});
        if(response.data)
            return res.render("employee-crud-pattern", {signal: "INSERT_SUCCESS"});
        return res.render("employee-crud-pattern", {signal: "INTERNAL_SERVER_ERROR"});
    }
    return res.redirect("/employee");
});
    //----- CRUD Unit_Class Oriented -----\\
employeeFeatureRouter.get("/employee-crud-unit_class", async (req, res) => {
    if(req.session.employee) {
        const LIST_UNIT_CLASS = await getListUnitClass();
        return res.render("employee-crud-unit_class", {LIST_UNIT_CLASS, signal: null});
    }
    return res.redirect("/employee");
});
employeeFeatureRouter.post("/employee-crud-add-unit_class", upload.fields([]), async (req, res) => {
    if(req.session.employee) {
        const unit_classDTO = req.body;
        const response = await axios.post(javaUrl+"/api/unit_class/add", unit_classDTO, {headers: {"Authorization": req.session.employee_token}});
        const LIST_UNIT_CLASS = await getListUnitClass();
        if(response.data) {
            addLopHocPhan(response.data);
            return res.render("employee-crud-unit_class", {LIST_UNIT_CLASS, signal: "INSERT_SUCCESS"});
        }
        return res.render("employee-crud-unit_class", {LIST_UNIT_CLASS, signal: "INTERNAL_SERVER_ERROR"});
    }
    return res.redirect("/employee");
});
    //----- CRUD TimeTable Oriented -----\\
employeeFeatureRouter.get("/employee-crud-time_table", async (req, res) => {
    if(req.session.employee) {
        const LIST_TIME_TABLE_LT = await getListTimeTable();
        const LIST_TIME_TABLE_TH = await getListTimeTableCon();
        const LIST_TIME_TABLE = LIST_TIME_TABLE_LT.concat(LIST_TIME_TABLE_TH);
        return res.render("employee-crud-time_table", {LIST_TIME_TABLE, signal: null});
    }
    return res.redirect("/employee");
});
employeeFeatureRouter.post("/employee-crud-add-time_table", upload.fields([]), async (req, res) => {
    if(req.session.employee) {
        const data = req.body;
        const response = await axios.post(javaUrl+"/api/time_table/add", data, {headers: {"Authorization": req.session.employee_token}});
        const LIST_TIME_TABLE_LT = await getListTimeTable();
        const LIST_TIME_TABLE_TH = await getListTimeTableCon();
        const LIST_TIME_TABLE = LIST_TIME_TABLE_LT.concat(LIST_TIME_TABLE_TH);
        if(response.data)
            return res.render("employee-crud-time_table", {LIST_TIME_TABLE, signal: "INSERT_SUCCESS"});
            return res.render("employee-crud-time_table", {LIST_TIME_TABLE, signal: "INTERNAL_SERVER_ERROR"});
    }
    return res.redirect("/employee");
});
    //----- CRUD Debt Oriented -----\\
employeeFeatureRouter.get("/employee-crud-debt", async (req, res) => {
    if(req.session.employee) {
        const LIST_DEBT = await getListDebt();
        const LIST_ORDER_DETAIL = await getListOrderDetail();
        return res.render("employee-crud-debt", {LIST_DEBT, LIST_ORDER_DETAIL, signal: null});
    } else {
        return res.redirect("/employee");
    }
});
employeeFeatureRouter.post("/employee/debt/getDebtsByStudentId", async (req, res) => {
    if(req.session.employee) {
        const maSinhVien = req.body.maSinhVien;
        const response = await axios.get(javaUrl+"/api/debt/getDebtsByStudentId/"+maSinhVien, {headers: {"Authorization": req.session.employee_token}});
        if(response.data)
            return res.send(response.data);
        return res.send([]);
    } else {
        return res.redirect("/employee");
    }
});
employeeFeatureRouter.post("/employee-crud-update-order-detail", upload.fields([]), async (req, res) => {
    if(req.session.employee) {
        const data = req.body;
        const response = await axios.post(javaUrl+"/api/order_detail/resolveOderDetail", data, {headers: {"Authorization": req.session.employee_token}});
        if(response.data)
            return res.redirect("/employee-crud-debt")
        return res.redirect("/employee-crud-debt") //render thêm signal error
    } else {
        return res.redirect("/employee");
    }
});
employeeFeatureRouter.get("/employee-crud-export-student", async (req, res) => {
    const LIST_STUDENT_METADATA = await getListStudent();
    const workbook = new exceljs.Workbook();
    const worksheet = workbook.addWorksheet('Data');
    worksheet.columns = [
        { header: "Mã sinh viên", key: "ma_sinh_vien", width: 20 },
        { header: "Avatar", key: "avatar", width: 20 },
        { header: "CCCD", key: "cccd", width: 20 },
        { header: "Bậc đào tạo", key: "bac_dao_tao", width: 20 },
        { header: "Cơ sở", key: "co_so", width: 20 },
        { header: "Loại hình đào tạo", key: "loai_hinh_dao_tao", width: 20 },
        { header: "Địa chỉ", key: "dia_chi", width: 20 },
        { header: "Giới tính", key: "gioi_tinh", width: 20 },
        { header: "Họ tên", key: "ho_ten", width: 20 },
        { header: "Ngày sinh", key: "ngay_sinh", width: 20 },
        { header: "Ngày vào trường", key: "ngay_vao_truong", width: 20 },
        { header: "Nơi sinh", key: "noi_sinh", width: 20 },
        { header: "Số điện thoại", key: "sdt", width: 20 },
        { header: "Số dư", key: "so_du", width: 20 },
        { header: "Tốt nghiệp", key: "tot_nghiep", width: 20 },
        { header: "Mã lớp danh nghĩa", key: "ma_lop_danh_nghia", width: 20 },
        { header: "Mã tài khoản", key: "ma_tai_khoan", width: 20 },
    ];
    LIST_STUDENT_METADATA.data.forEach(item => {
        worksheet.addRow(item);
    });
    const fileName = 'danh-sach-sinh-vien.xlsx';
    res.setHeader('Content-Disposition', `attachment; filename=${fileName}`);
    res.setHeader('Content-Type', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
    return workbook.xlsx.write(res)
        .then(() => {
            res.status(200).end();
        })
        .catch((err) => {
            console.log(err);
            res.status(500).json({
                message: 'Error exporting data',
                error: err
            });
        });
});

module.exports = employeeFeatureRouter;