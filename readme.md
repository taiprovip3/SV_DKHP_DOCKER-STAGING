# Hệ Thống Hỗ Trợ Học Vụ Cho Sinh Viên Trường Đại Học Công Nghiệp TP.HCM
(A STUDENT SUPPORT SYSTEM FOR STUDENTS OF INDUSTRIAL UNIVERSITY OF HO CHI MINH CITY)

Ứng dụng hỗ trợ học vụ cho sinh viên, giáo viên, và giáo vụ khoa tại Trường Đại học Công nghiệp TP.HCM. Mỗi loại người dùng có các chức năng riêng biệt để quản lý, giảng dạy và theo dõi thông tin học tập.

## Diagram Structure
![Architecture Diagram](https://res.cloudinary.com/dopzctbyo/image/upload/v1724387569/sv_dkhp/dakicaw4xk6dlj0om8a0.png)

## Features
###### Sinh Viên
- Quản lý thông tin cá nhân
- Xem thời khóa biểu
- Đăng ký học phần
- Theo dõi kết quả học tập
- Đóng học phí online
- ..

###### Giáo Viên
- Xem lịch dạy
- Cập nhật điểm số
- ..

###### Giáo Vụ Khoa
- Quản lý và duyệt đăng ký học phần
- Quản lý thông tin giảng viên và sinh viên
- Thống kê, báo cáo kết quả học tập

## Technologies
- **[Node.js](https://nodejs.org/)**: Xử lý backend và API.
- **[MySQL](https://www.mysql.com/)**: Quản lý cơ sở dữ liệu.
- **[Docker](https://www.docker.com/)**: Container hóa ứng dụng.
- **[Nginx](https://www.nginx.com/)**: Reverse proxy và load balancing.
- **[AWS](https://aws.amazon.com/)**: Triển khai hạ tầng đám mây.
- **[Spring Boot](https://spring.io/projects/spring-boot)**: Xây dựng ứng dụng Java.
- **[JWT](https://jwt.io/)**: Xác thực người dùng.
- **[HTML](https://developer.mozilla.org/en-US/docs/Web/HTML)**: Xây dựng giao diện người dùng.
- **[CSS](https://developer.mozilla.org/en-US/docs/Web/CSS)**: Tạo kiểu cho giao diện người dùng.
- **[JavaScript](https://developer.mozilla.org/en-US/docs/Web/JavaScript)**: Xử lý tương tác frontend.
- **[React Native](https://reactnative.dev/)**: Phát triển ứng dụng di động.
- **[SQLite](https://www.w3schools.com/sql/)**: Database SQLite cho ios & android.

## Getting Started
Để bắt đầu, cần setup môi trường cần thiết để chạy docker. Cài đặt docker-desktop hoặc docker cho linux:
- **Docker**: Download [tại đây](https://docs.docker.com/get-started/get-docker/)

1. **Clone repository**:
   ```bash
   git clone https://github.com/taiprovip3/SV_DKHP_DOCKER-STAGING.git
2. **CD vào thư mục**:
   ```bash
   cd SV_DKHP_DOCKER-STAGING
3. **Chạy docker-compose**:
   ```bash
   docker-compose up -d