const express = require('express');
const app = express();
const cors = require("cors");
const bodyParser = require('body-parser');
const mysql = require("mysql");
const nodemailer = require("nodemailer");
const easyinvoice = require('easyinvoice');
const fs = require('fs');
const session = require("express-session");
const dotenv = require('dotenv');
dotenv.config();
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
















function formatCurrency(number){
    return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(number);
}
async function sendEmailHddt(hddtData, user, products, maSinhVien, orderType, totalPayed, balanceLeft, toEmail) {//: void function
    //1. Tạo hddt và lưu xuống folder uploads
    const invoicePdf = await easyinvoice.createInvoice(hddtData);
    const pdfPath = './uploads/iuh-erukalearn-hoa-don-dien-tu.pdf';
    fs.writeFileSync(pdfPath, invoicePdf.pdf, 'base64');
    let myTabular = [];
    for(let i=0;i<products.length;i++) {
        const product = products[i];
        myTabular += 
        '<tr>'+
            `<td>${product.description}</td>`+
            `<td>${product.quantity}</td>`+
            `<td>${formatCurrency(product.price)}</td>`+
            `<td>${formatCurrency(0)}</td>`+
        '</tr>';
    }
    const message = `<h1>Xin chào bạn  , ${user},</h1>`+
    '<p>Bạn vừa thực hiện một thanh toán giao dịch điện tử tại sv.iuh.edu.vn - Trang</p>'+
    '<p>hỗ trợ Sinh Viên trực tuyến ErukaLearn Education!</p>'+
    '<p>Chi tiết giao dịch:</p>'+
    '<table border="1">'+
        '<tr>'+
            '<th>Nội dung</th>'+
            '<th>Số lượng</th>'+
            '<th>Thu phí</th>'+
            '<th>Thuế (khấu trừ)</th>'+
        '</tr>'+
        myTabular+
    '</table>'+
    '<hr>'+
    '<ul>'+
        `<li>MSSV: ${maSinhVien}</li>`+
        `<li>Loại thanh toán: ${orderType}</li>`+
        `<li>Tổng thanh toán: ${formatCurrency(totalPayed)} (vnđ)</li>`+
        `<li>Số dư tài khoản: ${formatCurrency(balanceLeft)} (vnđ)</li>`+
    '</ul>'+
    '<hr></hr>'+
    '<p>Cám ơn vì đã tin tưởng sử dụng dịch vụ thanh toán tại ErukaLearn Education!</p>'+
    '<p>-------------------------------------</p>'+
    '<p>Trang hỗ trợ sinh viên ErukaLearn for Education: <a href="https://sv.iuh.edu.vn/">sv.iuh.edu.vn</a></p>';
    const transporter = nodemailer.createTransport({
        service: 'gmail',
        host: 'smtp.gmail.com',
        port: 465,
        secure: true,
        auth: {
            user: process.env.MAIL_USER_AUTH,
            pass: process.env.MAIL_PASSWORD_AUTH,
        },
    });
    const mailOptions = {
        from: process.env.MAIL_USER_AUTH,
        to: toEmail,
        subject: `Giao dịch điện tử, ${user}`,
        html: message,
        attachments: [
            {
                filename: 'iuh-erukalearn-hoa-don-dien-tu.pdf',
                path: pdfPath,
                contentType: 'application/pdf'
            }
        ]
    };
    transporter.sendMail(mailOptions, (error, info) => {
        if(error) {
            console.error(error.message);
        } else {
            console.log('Email sent: ' + info.response);
        }
    }); 
}
module.exports = { formatCurrency, sendEmailHddt };
