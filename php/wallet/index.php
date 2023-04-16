<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ErukaLearn</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <script src="https://kit.fontawesome.com/ad778f42b3.js" crossorigin="anonymous"></script>
    <link href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css" rel="stylesheet" />
    <script src="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
    <link rel="stylesheet" href="./css/index.css" type="text/css" />
</head>
<body>
    <div class="container-fluid">
        <div class="row position-relative">

            <div class="position-absolute top-0 start-0 text-start mt-2 fs-3 w-50">
                <i class="fas fa-bars crs dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false" onclick="audio.play();"></i>
                <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton2">
                    <li><a class="dropdown-item" href="/student"><i class="fab fa-fort-awesome-alt"></i> Trang chủ</a></li>
                    <li><a class="dropdown-item disabled"><i class="fas fa-journal-whills"></i> Học tập</a></li>
                    <li>
                        <div>
                            <a class="crs text-decoration-none d-block" href="/student/timetable">&emsp;&emsp;<i class="fas fa-calendar-check"></i> Lịch học theo tuần</a>
                            <a class="crs text-decoration-none d-block" href="/student/score">&emsp;&emsp;<i class="fas fa-chart-bar"></i> Kết quả học tập</a>
                            <a class="crs text-decoration-none d-block" href="/student/dkhp">&emsp;&emsp;<i class="fab fa-xbox"></i> Đăng ký học phần</a>
                            <a class="crs text-decoration-none d-block" href="/student/pattern">&emsp;&emsp;<i class="fab fa-windows"></i> Chương trình khung</a>
                        </div>
                    </li>
                    <li><a class="dropdown-item disabled"><i class="fas fa-journal-whills"></i> Học phí</a></li>
                    <li>
                        <div>
                            <a class="crs text-decoration-none d-block" href="/student/debt">&emsp;&emsp;<i class="fas fa-sack-dollar"></i> Tra cứu công nợ</a>
                            <a class="crs text-decoration-none d-block" href="/student/order-detail">&emsp;&emsp;<i class="fas fa-file-invoice-dollar"></i> Biên lai tổng hợp</a>
                            <a class="crs text-decoration-none d-block" href="/student/payment">&emsp;&emsp;<i class="fab fa-cc-apple-pay"></i> Thanh toán học phí</a>
                            <!-- <a class="crs text-decoration-none d-block" href="#">&emsp;&emsp;<i class="fas fa-donate"></i> Nạp tiền vào ví</a> -->
                        </div>
                    </li>
                    <li><hr class="dropdown-divider"></li>
                    <li onclick="audio.play();"><a class="dropdown-item disabled">#Nạp tiền vào ví</a></li>
                </ul>
            </div>
            <div class="position-absolute top-0 end-0 text-end mt-2 fs-3 w-50">
                <a href="/student"><i class="fas fa-door-open text-secondary crs" onclick="audio.play();"></i></a>
            </div>
            
            <div class="col-lg-12 py-2 px-5" style="background: #ededed;">
                <div class="bg-white p-3">
                    <p class="fs-3 text-secondary fw-bold">Nạp tiền vào ví</p>
                    <hr>
                    <div class="d-flex">

                        <div id="left">
                            <div>
                                <p>Các phương thức thanh toán, loại giao dịch chấp nhận hiện tại <i class="fas fa-question-circle text-primary" data-bs-toggle="tooltip" title="Thanh toán trực tuyến là bạn có thể đóng tiền học phí mà không cần phải gặp mặt các nhân viên phòng tài chính kế toán, tránh mất thời gian đi lại, chậm trễ. Thực hiện đúng theo chỉ dẫn đóng tiền đảm bảo tin cậy 100%. Hỗ trợ sinh viên nếu xảy ra chậm trễ trong việc nhận tiền thanh toán."></i></p>
                                <div class="d-flex small">
                                    <div class="text-center mx-1 px-2 py-1 crs border" onclick="onchangeMethodPayment('MOMO');" id="MOMO_DIV">
                                        <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTxX_8dNwRvpgw6AjfpNrRF3ehsWpjEjmP2kV9T9HtgrA&s" alt="momo" width="32px" height="32px">
                                        <span class="d-block">Momo</span>
                                    </div>
                                    <div class="text-center mx-1 px-2 py-1 crs border" onclick="onchangeMethodPayment('VNPAY');" id="VNPAY_DIV">
                                        <img src="https://cdn.haitrieu.com/wp-content/uploads/2022/10/Icon-VNPAY-QR.png" alt="vnpay" width="32px" height="32px">
                                        <span class="d-block">VNPay</span>
                                    </div>
                                    <div class="text-center mx-1 px-2 py-1 crs border" onclick="onchangeMethodPayment('PAYPAL');" id="PAYPAL_DIV">
                                        <img src="https://img.freepik.com/free-icon/paypal_318-566100.jpg?w=2000" alt="paypal" width="32px" height="32px">
                                        <span class="d-block">Paypal</span>
                                    </div>
                                    <div class="text-center mx-1 px-2 py-1 crs border" onclick="onchangeMethodPayment('WALLET');" id="WALLET_DIV">
                                        <img src="https://i.pinimg.com/600x315/14/0f/b9/140fb9e777f973da51472ea9b3e936cf.jpg" alt="card" width="32px" height="32px">
                                        <span class="d-block">Thẻ cào</span>
                                    </div>
                                </div>
                            </div>
                            <div>
                                <p>Tổng số tiền thanh toán: <span class="fw-bold text-decoration-underline fs-3" id="total_payment">0</span>đ</p>
                                <p>Phương thức thanh toán: <span class="fw-bold fs-3" id="method_payment">Chưa chọn</span></p>
                                <div class="d-none mb-2" id="MOMO_OPTION">
                                    <input type="radio" name="SELECT_MOMO" id="MOMO_ATM" value="MOMO_ATM" class="form-check-input" checked onclick="audio.play();" />
                                    <label for="MOMO_ATM" class="form-check-label">Momo ATM</label>
                                    &emsp;
                                    <input type="radio" name="SELECT_MOMO" id="MOMO_QR" value="MOMO_QR" class="form-check-input" onclick="audio.play();" />
                                    <label for="MOMO_QR" class="form-check-label">Quét mã QR momo</label>
                                </div>
                                <div class="d-none" id="WALLET_OPTION">
                                    <p><i class="fas fa-dollar-sign text-success bg-info"></i> Số dư trong ví còn: <span class="text-warning fw-bold text-decoration-underline fs-3"><%= new Intl.NumberFormat().format(STUDENT_DATA.soDu); %></span><span class="text-warning">đ</span></p>
                                </div>
                                <button class="btn btn-lg text-white fw-bold" style="background: #FF5A00;" onclick="pay();">Thanh toán</button>
                            </div>
                        </div>
                        <div id="right" class="flex-fill p-5">
                            <div class="border-start ps-3">
                                <p>Vui lòng chọn hạn mức nạp:</p>
                                <div>
                                    <input type="radio" name="wannaWallet" id="wanna50000" checked>
                                    <label for="wanna50000">50.000đ</label>
                                </div>
                                <div>
                                    <input type="radio" name="wannaWallet" id="wanna100000">
                                    <label for="wanna100000">100.000đ</label>
                                </div>
                                <div>
                                    <input type="radio" name="wannaWallet" id="wanna200000">
                                    <label for="wanna200000">200.000đ</label>
                                </div>
                                <div>
                                    <input type="radio" name="wannaWallet" id="wanna500000">
                                    <label for="wanna500000">500.000đ</label>
                                </div>
                                <div class="d-flex align-items-start">
                                    <input type="radio" name="wannaWallet" id="wanna500000">
                                    <!-- <label for="wanna500000">500.000đ</label> -->
                                    &ensp;
                                    <input type="number" name="balance" id="balanced" placeholder="Số tiền muốn nạp tuỳ ý..." class="form-control form-control-lg">
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    const audio = new Audio();
    audio.src = "../audio/click.mp3";
    var pathNodejs = window.location.protocol + '//' + window.location.host;
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl){
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });
    function formatNumber(number) {
        return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(number);
    }
</script>
</body>
</html>