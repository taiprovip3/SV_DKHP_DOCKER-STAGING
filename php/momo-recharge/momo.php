<?php
header('Content-type: text/html; charset=utf-8');
if(!isset($_POST['momo_method'])) {
    echo "Internal Server Error.";
    return;
} else {
    $momo_method = $_POST['momo_method'];
    if($momo_method == "") {
        echo "Internal Server Error!";
        return;
    }
}
if(!isset($_POST['total_payment'])) {
    echo "Internal Server Error.";
    return;
} else {
    $total_payment = $_POST['total_payment'];
    if($total_payment <= 0) {
        echo "Internal Server Error!";
        return;
    }
}
if(!isset($_POST['maSinhVien'])) {
    echo "Internal Server Error.";
    return;
} else {
    $maSinhVien = $_POST['maSinhVien'];
    if($maSinhVien <= 0) {
        echo "Internal Server Error!";
        return;
    }
}

$momo_method = $_POST['momo_method'];
$total_payment = $_POST['total_payment'];
$maSinhVien = $_POST['maSinhVien'];

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
                <form action="./momo-implements.php" method="post" target="_blank" enctype="application/x-www-form-urlencoded">
                    <p>Thanh toán học phí trực tuyến</p>
                    <p>Phương thức thanh toán:</p>
                    <p class="fw-bold">MOMO - <?php echo $momo_method ?></p>
                    <p>Tổng thanh toán:</p>
                    <p class="fw-bold fs-3 text-decoration-underline"><?php echo number_format($total_payment).'đ'; ?></p>

                    <?php
                        echo '<input hidden name="maSinhVien" value="'.$maSinhVien.'" />';
                        echo '<input hidden name="total_payment" value="'.$total_payment.'" />';
                        echo '<input hidden name="momo_method" value="'.$momo_method.'" />';

                    ?>
                    <div class="small">
                        <input type="checkbox" name="agree_the_term" id="agree_the_term" value="agree_the_term" checked onclick="return false;" />
                        <label for="agree_the_term" class="fst-italic">I accept and agree to the <span class="text-primary text-decoration-underline">Terms Of Use</span></label>
                    </div>
                    <div class="d-flex align-items-center mt-2">
                        <button type="submit" class="fw-bold text-white btn" style="background: #FF5A00" onclick="closePage();">Xác nhận</button>
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
        }, 200);
    }
</script>
</body>
</html>