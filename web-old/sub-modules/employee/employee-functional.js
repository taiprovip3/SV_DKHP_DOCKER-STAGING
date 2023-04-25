const axios = require("axios");
const javaUrl = ""+process.env.JAVA_API_URL;
const mysql = require("mysql");
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
const util = require("util");
const query = util.promisify(con.query).bind(con);
const { firebaseDB } = require('../../utils/admin-firebase-sdk');










async function getScores(req) {
    const response = await axios.get(javaUrl+"/api/score/getScores", {headers: {"Authorization": req.session.teacher_token}});
    if(response.data)
        return response.data;
    return [];
}
async function getListTimeTable(){
    let LIST_TIME_TABLE = [];
    try {
        const result = await query("SELECT * FROM thoi_khoa_bieu ORDER BY ma_thoi_khoa_bieu DESC");
        Object.keys(result).forEach(function(key) {
            var row = result[key];
            LIST_TIME_TABLE.push(row);
        });
    } catch (error) {
        console.error(error);
    } finally{
        return LIST_TIME_TABLE;
    }
}
async function getListTimeTableCon(){
    let LIST_TIME_TABLE = [];
    try {
        const result = await query("SELECT * FROM thoi_khoa_bieu_con ORDER BY ma_thoi_khoa_bieu_con DESC");
        Object.keys(result).forEach(function(key) {
            var row = result[key];
            LIST_TIME_TABLE.push(row);
        });
    } catch (error) {
        console.error(error);
    } finally{
        return LIST_TIME_TABLE;
    }
}
async function getListUnitClass() {
    let LIST_UNIT_CLASS = [];
    try {
        const result = await query("SELECT * FROM lop_hoc_phan ORDER BY ma_lop_hoc_phan DESC");
        Object.keys(result).forEach(function(key) {
            var row = result[key];
            LIST_UNIT_CLASS.push(row);
        });
    } catch (error) {
        console.error(error);
    } finally{
        return LIST_UNIT_CLASS;
    }
}
async function getListStudent(limit = 9999999){
    let LIST_STUDENT_METADATA = null;
    try {
        const LIST_STUDENT = [];
        const result = await query("SELECT * FROM sinh_vien ORDER BY ma_sinh_vien DESC LIMIT ?", [limit]);
        Object.keys(result).forEach(function(key) {
            var row = result[key];
            LIST_STUDENT.push(row);
        });
        const count = await query("SELECT COUNT(*) AS total_records FROM sinh_vien");
        const totalRecords = count[0].total_records;
        LIST_STUDENT_METADATA = {
            data: LIST_STUDENT,
            pagination: {
              pageNumber: 1,
              pageSize: limit,
              totalRecords: totalRecords,
              totalPages: Math.ceil(totalRecords / limit),
            }
        };
    } catch (error) {
        console.error(error);
    } finally{
        return LIST_STUDENT_METADATA;
    }
}
async function getListClass() {
    let LIST_CLASS = [];
    try {
        const result = await query("SELECT * FROM lop_hoc_danh_nghia ORDER BY ma_lop DESC");
        Object.keys(result).forEach(function (key) {
            var row = result[key];
            LIST_CLASS.push(row);
        });
    } catch (error) {
        console.error(error);
    } finally{
        return LIST_CLASS;
    }
}
async function getListTeacher() {
    let LIST_TEACHER = [];
    try {
        const result = await query("SELECT * FROM giao_vien ORDER BY ma_giao_vien DESC");
        Object.keys(result).forEach(function (key) {
            var row = result[key];
            LIST_TEACHER.push(row);
        });
    } catch (error) {
        console.error(error);
    } finally{
        return LIST_TEACHER;
    }
}
async function getListCourse() {
    let LIST_COURSE = [];
    try {
        const result = await query("SELECT * FROM khoa_hoc ORDER BY ma_khoa_hoc DESC");
        Object.keys(result).forEach(function (key) {
            var row = result[key];
            LIST_COURSE.push(row);
        });
    } catch (error) {
        console.error(error);
    } finally{
        return LIST_COURSE;
    }
}
async function getListDepartment() {
    let LIST_DEPARTMENT = [];
    try {
        const result = await query("SELECT * FROM khoa");
        Object.keys(result).forEach(function (key) {
            var row = result[key];
            LIST_DEPARTMENT.push(row);
        });
    } catch (error) {
        console.error(error);
    } finally{
        return LIST_DEPARTMENT;
    }
}
async function getListMajors() {
    let LIST_MAJORS = [];
    try {
        const result = await query("SELECT * FROM nganh");
        Object.keys(result).forEach(function (key) {
            var row = result[key];
            LIST_MAJORS.push(row);
        });
    } catch (error) {
        console.error(error);
    } finally{
        return LIST_MAJORS;
    }
}
async function getListDebt() {
    let LIST_DEBT = [];
    try {
        const result = await query("SELECT * FROM cong_no ORDER BY id DESC");
        Object.keys(result).forEach(function (key) {
            var row = result[key];
            LIST_DEBT.push(row);
        });
    } catch (error) {
        console.error(error);
    } finally{
        return LIST_DEBT;
    }
}
async function getListOrderDetail() {
    let LIST_ORDER_DETAIL = [];
    try {
        const result = await query("SELECT * FROM phieu_thu ORDER BY ma_phieu_thu DESC");
        Object.keys(result).forEach(function (key) {
            var row = result[key];
            LIST_ORDER_DETAIL.push(row);
        });
    } catch (error) {
        console.error(error);
    } finally{
        return LIST_ORDER_DETAIL;
    }
}
async function getListAnnouncement() {
    let LIST_ANNOUNCEMENT = [];
    try {
        const result = await query("SELECT * FROM thong_bao_khoa ORDER BY ma_thong_bao DESC");
        Object.keys(result).forEach(function (key) {
            var row = result[key];
            LIST_ANNOUNCEMENT.push(row);
        });
    } catch (error) {
        console.error(error);
    } finally{
        return LIST_ANNOUNCEMENT;
    }
}
async function addLopHocPhan(newRecord) {
    try {
      const lop_hoc_phan_collection = firebaseDB.collection('lop_hoc_phan');
      const docRef = await lop_hoc_phan_collection.add(newRecord);
      console.log('Thêm bản ghi mới thành công, ID của bản ghi:', docRef.id);
    } catch (error) {
      console.error('Lỗi khi thêm bản ghi mới:', error);
    }
}

module.exports = { getScores, getListTimeTable, getListTimeTableCon, getListUnitClass, getListStudent, getListClass, getListTeacher, getListCourse, getListDepartment, getListMajors, getListDebt, getListOrderDetail, addLopHocPhan, getListAnnouncement };
