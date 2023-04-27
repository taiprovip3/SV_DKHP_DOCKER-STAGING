const mysqldump = require('mysqldump');
const fs = require('fs');
const express = require('express');
const employeeFeatureRouter = express.Router();
const app = express();
const cors = require("cors");
const bodyParser = require('body-parser');
const multer = require('multer');
const mysql = require("mysql");
const bcrypt = require("bcrypt");
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
const ejs = require('ejs');
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
const query = util.promisify(con.query).bind(con);
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











employeeFeatureRouter.get("/employee2", async (req, res) => {
    const LIST_STUDENT = await getListStudent();
    return res.render('employee/index');
});
employeeFeatureRouter.get("/employee/getHtml", async (req, res) => {
    const componentName = req.query.componentName;
    res.render(`employee/${componentName}`, function (err, html) {
        if(err){
            console.log(err);
            return res.status(500).send('Internal Server Error');
        } else {
            return res.status(200).send(html);
        }
    });
});
employeeFeatureRouter.get("/employee/student/getStudents", async (req, res) => {
    const LIST_STUDENT = await getListStudent();
    return res.send(LIST_STUDENT);
});
employeeFeatureRouter.post("/employee/student/saveStudent", async (req, res) => {
    const LIST_STUDENT = await getListStudent();
    try {
        const student = {hoTen:req.body.ho_ten, gioiTinh:req.body.gioi_tinh, ngaySinh:req.body.ngay_sinh, noiSinh:req.body.noi_sinh, sdt:req.body.sdt, diaChi:req.body.dia_chi, cccd:req.body.cccd, ngayVaoTruong:req.body.ngay_vao_truong, totNghiep:req.body.tot_nghiep, maLopDanhNghia:req.body.ma_lop_danh_nghia,avatar:req.body.avatar, matKhau:bcrypt.hashSync(req.body.mat_khau, 10), bacDaoTao: req.body.bac_dao_tao, loaiHinhDaoTao: req.body.loaiHinhDaoTao, coSo:req.body.co_so, email:req.body.email};
        const response = await axios.post(javaUrl+"/api/student/add", student, {headers: {"Authorization": req.session.employee_token}});
        return res.render("employee/index", {LIST_STUDENT, signal: "INSERT_SUCCESS"});
    } catch (error) {
        console.error(error);
        return res.render('employee/index', { LIST_STUDENT, signal: 'INTERNAL_SERVER_ERROR' });
    }
});


//----- student routers -----\\
employeeFeatureRouter.get('/employee-crud-student-get', async (req, res) => {
    const LIST_STUDENT = await getListStudent();
    return res.send(LIST_STUDENT);
});
employeeFeatureRouter.get("/employee-crud-student", async (req, res) => {
    if(req.session.employee) {
        const LIST_STUDENT = await getListStudent();
        return res.render("employee-crud-student", {LIST_STUDENT, signal: null});
    } else {
        return res.redirect("/employee");
    }
});
employeeFeatureRouter.post("/employee-crud-add-student", upload.fields([]), async (req,res) => {
    if(req.session.employee) {
        const student = {hoTen:req.body.ho_ten, gioiTinh:req.body.gioi_tinh, ngaySinh:req.body.ngay_sinh, noiSinh:req.body.noi_sinh, sdt:req.body.sdt, diaChi:req.body.dia_chi, cccd:req.body.cccd, ngayVaoTruong:req.body.ngay_vao_truong, totNghiep:req.body.tot_nghiep, maLopDanhNghia:req.body.ma_lop_danh_nghia,avatar:req.body.avatar, matKhau:bcrypt.hashSync(req.body.mat_khau, 10), bacDaoTao: req.body.bac_dao_tao, loaiHinhDaoTao: req.body.loaiHinhDaoTao, coSo:req.body.co_so, email:req.body.email};
        const response = await axios.post(javaUrl+"/api/student/add", student, {headers: {"Authorization": req.session.employee_token}});
        const LIST_STUDENT = await getListStudent();
        if(response.data)
            return res.render("employee-crud-student", {LIST_STUDENT, signal: "INSERT_SUCCESS"});
        return res.render("employee-crud-student", {LIST_STUDENT, signal: "INTERNAL_SERVER_ERROR"});
    }
    return res.redirect("/employee");
});
employeeFeatureRouter.post("/employee-crud-delete-student", upload.fields([]), async (req, res) => {
    if(req.session.employee) {
        const listCheckboxChecked = Object.keys(req.body);
        const response = await axios.post('http://localhost:8080/api/student/remove', listCheckboxChecked, {headers: {"Authorization": req.session.employee_token}});
        const LIST_STUDENT = await getListStudent();
        if(response.data)
            return res.render("employee-crud-student", {LIST_STUDENT, signal: "INSERT_SUCCESS"});
        return res.render("employee-crud-student", {LIST_STUDENT, signal: "INTERNAL_SERVER_ERROR"});
    }
    return res.redirect("/employee");
});
    //----- class routers -----\\
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
    //----- teacher routers -----\\
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
    //----- course routers -----\\
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
    //----- department routers -----\\
employeeFeatureRouter.get("/employee-crud-department", async (req, res) => {
    if(req.session.employee) {
        const LIST_DEPARTMENT = await getListDepartment();
        return res.render("employee-crud-department", {LIST_DEPARTMENT, signal: null});
    }
    return res.redirect("/employee");
});
    //----- majors routers -----\\
employeeFeatureRouter.get("/employee-crud-majors", async (req, res) => {
    if(req.session.employee) {
        const LIST_MAJORS = await getListMajors();
        return res.render("employee-crud-majors", {LIST_MAJORS, signal: null});
    }
    return res.redirect("/employee");
});
    //----- deparment announcement routers -----\\
employeeFeatureRouter.get("/employee-crud-department_announcement", async (req, res) => {
    if(req.session.employee) {
        const LIST_ANNOUNCEMENT = await getListAnnouncement();
        return res.render("employee-crud-department_announcement", {LIST_ANNOUNCEMENT, signal: null});
    }
    return res.redirect("/employee");
});
    //----- pattern routers -----\\
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
    //----- unitclass routers -----\\
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
    //----- timetable routers -----\\
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
    //----- debt routers -----\\
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

    //----- common routers -----\\
employeeFeatureRouter.get("/employee-crud-export", async (req, res) => {
    const entityName = req.query.entityName;
    let data = [];
    switch (entityName) {
        case "student":
            data = await getListStudent();
            break;
        case "class":
            data = await getListClass();
        case "teacher":
            data = await getListTeacher();
        case "course":
            data = await getListCourse();
        case "department":
            data = await getListDepartment();
        case "major":
            data = await getListMajors();
        case "department_announcement":
            data = await getListAnnouncement();
        case "unit_class":
            data = await getListUnitClass();
        case "time_table":
            data = await getListTimeTable();
        case "debt":
            data = await getListDebt();
        case "order_detail":
            data = await getListOrderDetail();
        default:
            break;
    }
    const workbook = new exceljs.Workbook();
    const worksheet = workbook.addWorksheet('Data');
    const keys = Object.keys(data[0]);
    const sheetColumns = [];
    keys.forEach(key => {
        sheetColumns.push({ header: key, key: key, width: 20 });
    });
    worksheet.columns = sheetColumns;
    data.forEach(item => {
      worksheet.addRow(item);
    });
    const fileName = `data-${entityName}.xlsx`;
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
employeeFeatureRouter.post("/employee-crud-import", upload.single("excel_file"), async (req, res, next) => {
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
                const emtityName = req.query.entityName;
                switch (emtityName) {
                    case "class":
                        for(let i=0;i<data.length;i++) {
                            const classData = data[i];
                            const myClass = {tenLop: classData.ten_lop, soLuong: classData.so_luong, maGiaoVien:classData.ma_giao_vien, maKhoaHoc: classData.ma_khoa_hoc, maNganh: classData.ma_nganh};
                            const response = await axios.post(javaUrl+"/api/class/add", myClass, {headers: {"Authorization": req.session.employee_token}});
                            if(!response.data) {
                                throw new Error();
                            }
                        }
                        const LIST_CLASS = await getListClass();
                        return res.render("employee-crud-class", {LIST_CLASS, signal: "INSERT_SUCCESS"});
                        break;
                    case "student":
                        for(let i=0;i<data.length;i++) {
                            const studentData = data[i];
                            const myStudent = {
                                hoTen: studentData.ho_ten,
                                gioiTinh: studentData.gioi_tinh,
                                ngaySinh: studentData.ngay_sinh,
                                sdt: studentData.sdt,
                                diaChi: studentData.dia_chi,
                                cccd: studentData.cccd,
                                ngayVaoTruong: studentData.ngay_vao_truong,
                                totNghiep: studentData.tot_nghiep,
                                maLopDanhNghia: studentData.ma_lop_danh_nghia,
                                avatar: studentData.avatar,
                                matKhau: bcrypt.hashSync(studentData.mat_khau, 10),
                                bacDaoTao: studentData.bac_dao_tao,
                                loaiHinhDaoTao: studentData.loai_hinh_dao_tao,
                                coSo: studentData.co_so,
                                email: studentData.email,
                            };
                            const response = await axios.post(javaUrl+"/api/student/add", myStudent, {headers: {"Authorization": req.session.employee_token}});
                            if(!response.data) {
                                throw new Error();
                            }
                        }
                        const LIST_STUDENT = await getListStudent();
                        return res.render("employee-crud-student", {LIST_STUDENT, signal: "INSERT_SUCCESS"});
                    case "teacher":
                        for(let i=0;i<data.length;i++) {
                            const teacherData = data[i];
                            const salt = bcrypt.genSaltSync(10);
                            const hash = bcrypt.hashSync(teacherData.mat_khau, salt);
                            const myTeacher = {
                                tenGiaoVien:teacherData.ten_giao_vien,
                                diaChi:teacherData.dia_chi,
                                gioiTinh:teacherData.gioi_tinh,
                                loaiGiaoVien:teacherData.loai_giao_vien,
                                ngaySinh:teacherData.ngay_sinh,
                                sdt:teacherData.sdt,
                                password:hash
                            };
                            const response = await axios.post(javaUrl+"/api/teacher/add", myTeacher, {headers: {"Authorization": req.session.employee_token}});
                            if(!response.data) {
                                throw new Error();
                            }
                        }
                        const LIST_TEACHER = await getListTeacher();
                        return res.render("employee-crud-teacher", {LIST_TEACHER, signal: "INSERT_SUCCESS"});
                    case "course":
                        for(let i=0;i<data.length;i++) {
                            const courseData = data[i];
                            const myCourse = {
                                tenKhoaHoc:courseData.ten_khoa_hoc,
                                alias:courseData.ten_khoa_hoc,
                                namBatDau: courseData.nam_bat_dau,
                                namKetThuc: courseData.nam_ket_thuc,
                                maHocKy: courseData.ma_hoc_ky,
                            };
                            const response = await axios.post(javaUrl+"/api/course/add", myCourse, {headers: {"Authorization": req.session.employee_token}});
                            if(!response.data) {
                                throw new Error();
                            }
                        }
                        const LIST_COURSE = await getListCourse();
                        return res.render("employee-crud-course", {LIST_COURSE, signal: "INSERT_SUCCESS"});
                    case "unit_class":
                        for(let i=0;i<data.length;i++) {
                            const unitClassData = data[i];
                            const myUnitClass = {
                                hanNopHocPhi: unitClassData.hanNopHocPhi,
                                ngayBatDau: unitClassData.ngayBatDau,
                                ngayKetThuc: unitClassData.ngayKetThuc,
                                tenLopHocPhan: unitClassData.tenLopHocPhan,
                                loaiHoc: unitClassData.loaiHoc,
                                maGiaoVien: unitClassData.maGiaoVien,
                                maMonHoc: unitClassData.maMonHoc,
                                maKhoaHoc: unitClassData.maKhoaHoc,
                                soLuongMax: unitClassData.soLuongMax,
                                trangThai: unitClassData.trangThai,
                            };
                            const response = await axios.post(javaUrl+"/api/unit_class/add", myUnitClass, {headers: {"Authorization": req.session.employee_token}});
                            if(!response.data) {
                                throw new Error();
                            }
                        }
                        const LIST_UNIT_CLASS = await getListUnitClass();
                        return res.render("employee-crud-unit_class", {LIST_UNIT_CLASS, signal: "INSERT_SUCCESS"});
                    case "time_table":
                        for(let i=0;i<data.length;i++) {
                            const timeTableData = data[i];
                            const myTimeTable = {
                                maLopHocPhan: timeTableData.maLopHocPhan, 
                                tuTietHoc: timeTableData.tuTietHoc,
                                denTietHoc: timeTableData.denTietHoc,
                                phongHoc: timeTableData.phongHoc,
                                thuHoc: timeTableData.thuHoc,
                                thi: timeTableData.thi,
                                ghiChu: timeTableData.ghiChu,
                                loaiBuoiHoc: timeTableData.loaiBuoiHoc,
                                nhomHoc: timeTableData.nhomHoc,
                                chungWithMaThoiKhoaBieu: timeTableData.chungWithMaThoiKhoaBieu,
                                ngayBatDau: timeTableData.ngayBatDau,
                                ngayKetThuc: timeTableData.ngayKetThuc,
                                maGiaoVien: timeTableData.maGiaoVien,
                            };
                            const response = await axios.post(javaUrl+"/api/time_table/add", myTimeTable, {headers: {"Authorization": req.session.employee_token}});
                            if(!response.data) {
                                throw new Error();
                            }
                        }
                        const LIST_TIME_TABLE_LT = await getListTimeTable();
                        const LIST_TIME_TABLE_TH = await getListTimeTableCon();
                        const LIST_TIME_TABLE = LIST_TIME_TABLE_LT.concat(LIST_TIME_TABLE_TH);
                        return res.render("employee-crud-time_table", {LIST_TIME_TABLE, signal: "INSERT_SUCCESS"});
                    default:
                        break;
                }
            }));
        } catch (err) {
            // return res.status(500).json({ success: false, message: err.message });
            console.error(err);
            const LIST_CLASS = await getListClass();
            return res.render("employee-crud-class", {LIST_CLASS, signal: "INTERNAL_SERVER_ERROR"});
        }
    }
    return res.redirect("/employee");
});
employeeFeatureRouter.get('/employee-backup-sql', (req, res) => {
    if(!req.session.employee) {
        return res.redirect("/employee");
    }
    try {
        const options = {
            host: process.env.MYSQL_HOST,
            user: process.env.MYSQL_USER,
            password: process.env.MYSQL_PASSWORD,
            database: process.env.MYSQL_DATABASE,
        };
        mysqldump({
            connection: options,
            dumpToFile: './dump.sql',
        }).then(() => {
            console.log(`Backup complete. File saved as ./dump.sql`);
            const backupFileName = `sv_dkhp_backup_${new Date().toISOString()}.sql`;
            const backupFile = `./dump.sql`;
            const fileContents = fs.readFileSync(backupFile, 'utf8');
            res.setHeader('Content-disposition', `attachment; filename=${backupFileName}`);
            res.setHeader('Content-type', 'application/sql');
            return res.send(fileContents);
        }).catch((err) => {
            console.error('Backup failed:', err);
            return res.status(500).send('Backup failed');
        });
    } catch (error) {
        console.error(error);
    }
});

employeeFeatureRouter.get('/employee-getCourses', async (req, res) => {
    if(!req.session.employee) {
        return res.redirect("/employee");
    }
    try {
        const coursesResponse = await axios.get(javaUrl+"/api/course/getCourses", {headers: {"Authorization": req.session.employee_token}});
        return res.status(200).json(coursesResponse.data);
    } catch (error) {
        console.error(error);
    }
});
employeeFeatureRouter.get('/employee-getCounterStudentsByCourseId/:courseId', async (req, res) => {
    if(!req.session.employee) {
        return res.redirect("/employee");
    }
    try {
        const courseId = req.params.courseId;
        const counterResponse = await axios.get(javaUrl+"/api/course/getCounterStudentsByCourseId/"+courseId, {headers: {"Authorization": req.session.employee_token}});
        return res.status(200).send(counterResponse.data.toString());
    } catch (error) {
        console.error(error);
    }
});
employeeFeatureRouter.get('/employee-getCounterByXepLoai/:xepLoaiString', async (req, res) => {
    if(!req.session.employee) {
        return res.redirect("/employee");
    }
    try {
        const xepLoaiString = req.params.xepLoaiString;
        const counterResponse = await axios.get(javaUrl+"/api/score/getCounterByXepLoai/"+xepLoaiString, {headers: {"Authorization": req.session.employee_token}});
        return res.status(200).send(counterResponse.data.toString());
    } catch (error) {
        console.error(error);
    }
});
async function getDataTable(tableName){// Hàm cho backup excel type
    let LIST_DATA = [];
    try {
        const result = await query(`SELECT * FROM ${tableName}`);
        Object.keys(result).forEach(function(key) {
            var row = result[key];
            LIST_DATA.push(row);
        });
    } catch (error) {
        console.error(error);
    } finally{
        return LIST_DATA;
    }
}
employeeFeatureRouter.get('/employee-getMetaDatasetsInputChart', async(req, res) => {
    try {
        const response = await axios.get(javaUrl+'/api/getMetaDatasetsInputChart', {headers: {"Authorization": req.session.employee_token}});
        return res.send(response.data);
    } catch (error) {
        console.error(error);
        throw new Error();
    }
});
employeeFeatureRouter.get('/employee-backup-excel', (req, res) => {
    // Lấy danh sách tên bảng trong cơ sở dữ liệu
    con.query("SELECT TABLE_NAME FROM information_schema.tables WHERE TABLE_SCHEMA = 'sv_dkhp'", async (error, results, fields) => {
        if (error) throw error;
        // Tạo một workbook mới
        const workbook = new exceljs.Workbook();
        // Lặp qua từng bảng và thêm dữ liệu vào worksheet
        for(const table of results) {
            const tableName = table.TABLE_NAME;
            const data = await getDataTable(tableName);
            const worksheet = workbook.addWorksheet(tableName);
            const keys = Object.keys(data[0]);
            const sheetColumns = [];
            for (const key of keys) {
                sheetColumns.push({ header: key, key: key, width: 20 });
            }
            worksheet.columns = sheetColumns;
            for(const row of data) {
                worksheet.addRow(Object.values(row));
            }
        }
        // Khi đã thêm dữ liệu vào các worksheet, ghi workbook vào file Excel và gửi về client
        const fileName = 'backup.xlsx';
        res.setHeader('Content-Disposition', `attachment; filename=${fileName}`);
        res.setHeader('Content-Type', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
        try {
            await workbook.xlsx.write(res);
            res.status(200).end();
        } catch (err) {
            console.log(err);
            res.status(500).json({
                message: 'Error exporting data',
                error: err
            });
        }
    });
});



module.exports = employeeFeatureRouter;