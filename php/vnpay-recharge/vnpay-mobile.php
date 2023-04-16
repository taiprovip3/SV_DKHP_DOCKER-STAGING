<?php
header('Content-type: text/html; charset=utf-8');
if(!isset($_GET['maSinhVien'])) {
    echo "Internal Server Error.";
    return;
} else {
    $maSinhVien = $_GET['maSinhVien'];
    if($maSinhVien == "") {
        echo "Internal Server Error!";
        return;
    }
}
if(!isset($_GET['maThanhToanGiaoDich'])) {
    echo "Internal Server Error.";
    return;
} else {
    $maThanhToanGiaoDich = $_GET['maThanhToanGiaoDich'];
    if($maThanhToanGiaoDich == "") {
        echo "Internal Server Error!";
        return;
    }
}
if(!isset($_GET['balanceGiaoDich'])) {
    echo "Internal Server Error.";
    return;
} else {
    $balanceGiaoDich = $_GET['balanceGiaoDich'];
    if($balanceGiaoDich <= 0) {
        echo "Internal Server Error!";
        return;
    }
}
$maSinhVien = $_GET['maSinhVien'];
$maThanhToanGiaoDich = $_GET['maThanhToanGiaoDich'];
$balanceGiaoDich = $_GET['balanceGiaoDich'];
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>ErukaLearn</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <script src="https://kit.fontawesome.com/ad778f42b3.js" crossorigin="anonymous"></script>
    <link href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css" rel="stylesheet" />
    <script src="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <div class="col-12">
                <form action="./vnpay-mobile-implements.php" method="post" id="frmCreateOrder">
                    <p>Thanh toán học phí trực tuyến</p>
                    <p>Phương thức thanh toán:</p>
                    <p class="fw-bold">VNPAY</p>
                    


                    <div class="form-group d-none">
                        <label for="amount">Số tiền</label>
                        <input class="form-control" data-val="true" data-val-number="The field Amount must be a number." data-val-required="The Amount field is required." id="amount" max="100000000" min="1" name="amount" type="number" value="<?php echo $balanceGiaoDich; ?>" />
                    </div>
                    <p>Chọn phương thức thanh toán</p>
                    <div class="form-group">
                        <h5>Cách 1: Chuyển hướng sang Cổng VNPAY chọn phương thức thanh toán</h5>
                        <div class="form-check">
                            <input type="radio" Checked="True" id="method1_gateway" name="bankCode" value="" class="form-check-input" onclick="audio.play();" />
                            <label for="method1_gateway" class="form-check-label">Cổng thanh toán VNPAYQR</label>
                        </div>
                        <h5>Cách 2: Tách phương thức tại site của đơn vị kết nối</h5>
                        <div class="form-check">
                            <input type="radio" id="method2_AppPay" name="bankCode" value="VNPAYQR" class="form-check-input" onclick="audio.play();" />
                            <label for="method2_AppPay" class="form-check-label">Thanh toán bằng ứng dụng hỗ trợ VNPAYQR</label>
                        </div>
                        <div class="form-check">
                            <input type="radio" id="method2_AtmPay" name="bankCode" value="VNBANK" class="form-check-input" onclick="audio.play();" />
                            <label for="method2_AtmPay" class="form-check-label">Thanh toán qua thẻ ATM/Tài khoản nội địa</label>
                        </div>
                        <div class="form-check">
                            <input type="radio" id="method2_CreditPay" name="bankCode" value="INTCARD" class="form-check-input" onclick="audio.play();" />
                            <label for="method2_CreditPay" class="form-check-label">Thanh toán qua thẻ quốc tế</label>
                        </div>
                        </div>
                    <div class="form-group">
                        <h5>Chọn ngôn ngữ giao diện thanh toán:</h5>
                        <div class="d-flex">
                            <div class="form-check">
                                <input type="radio" id="vi-VN" Checked="True" name="language" value="vn" class="form-check-input" onclick="audio.play();" />
                                <label for="vi-VN" class="form-check-label">Tiếng Việt</label>
                            </div>
                            &emsp;
                            <div class="form-check">
                                <input type="radio" id="en-US" name="language" value="en" class="form-check-input" onclick="audio.play();" />
                                <label for="en-US" class="form-check-label">Tiếng Anh</label>
                            </div>
                        </div>
                    </div>




                    <p>Tổng thanh toán:</p>
                    <p class="fw-bold fs-3 text-decoration-underline"><?php echo number_format($balanceGiaoDich).'đ'; ?></p>

                    <?php
                        echo '<input hidden name="maThanhToanGiaoDich" value="'.$maThanhToanGiaoDich.'" />';
                        echo '<input hidden name="maSinhVien" value="'.$maSinhVien.'" />';
                    ?>
                    <div class="small">
                        <input type="checkbox" name="agree_the_term" id="agree_the_term" value="agree_the_term" checked onclick="return false;" />
                        <label for="agree_the_term" class="fst-italic">I accept and agree to the <span class="text-primary text-decoration-underline">Terms Of Use</span></label>
                    </div>
                    <div class="d-flex align-items-center mt-2">
                        <button type="submit" class="fw-bold text-white btn" style="background: #FF5A00" href onclick="audio.play();">Xác nhận</button>
                        &emsp;
                        <button type="button" class="btn btn-outline-secondary" onclick="closePage();">Hủy bỏ</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
<script>
    const audio = new Audio();
    audio.src = "../audio/click.mp3";
    function closePage() {
        audio.play();
        setTimeout(() => {
            window.close();
        }, 100);
    }
</script>
</body>
</html>