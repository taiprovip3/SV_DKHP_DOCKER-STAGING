<?php
header('Content-type: text/html; charset=utf-8');
if(!isset($_POST['method_payment'])) {
    echo "Internal Server Error.";
    return;
} else {
    $method_payment = $_POST['method_payment'];
    if($method_payment == "") {
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
            $method_payment = $_POST['method_payment'];
            $total_payment = $_POST['total_payment'];
            $maSinhVien = $_POST['maSinhVien'];
            $unDebtIds = [];
            $url = "http://java:8080/api/payment/createTransaction/".$maSinhVien."/".$total_payment."/".$unDebtIds."";
            $maGiaoDich = file_get_contents($url);
            $orderType = 'PAYPAL - WALLET';
            $callBackUrl = 'http://web:4000/student/payment/callback?extraData='.$maGiaoDich.'&resultCode=0&amount='.$total_payment.'&orderType='.$orderType.'';    
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
    <script src="https://www.paypal.com/sdk/js?client-id=AWr1ugFyX8drd_9M8C2nCzIevgvclI5sdU5izC9lamGeKwW9FC0exjrfxgNzvqtsP5R16QMMTNjJ03kc&currency=USD&commit=false"></script>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <div class="col-12">
                <p>Thanh toán học phí trực tuyến</p>
                <p>Phương thức thanh toán:</p>
                <p class="fw-bold"><?php echo $method_payment ?></p>
                <p>Tổng thanh toán:</p>
                <p class="fw-bold fs-3"><?php echo number_format($total_payment).'đ'; ?> ~ <?php echo round($total_payment/23450, 2) .'$'; ?></p>
                <div class="small">
                    <input type="checkbox" name="agree_the_term" id="agree_the_term" value="agree_the_term" checked onclick="return false;" />
                    <label for="agree_the_term" class="fst-italic">I accept and agree to the <span class="text-primary text-decoration-underline">Terms Of Use</span></label>
                </div>
                <div id="paypal-button-container"></div>
                <div class="position-fixed top-0 end-0 text-center m-2" onclick="closePage();">
                    <button type="button" class="btn-close"></button>
                    <br>
                    <span class="text-decoration-underline">Huỷ bỏ</span>
                </div>
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
paypal.Buttons({
    style: {
        layout: 'vertical',
        color:  'gold',
        shape:  'pill',
        label:  'checkout'
    },
    createOrder: (data, actions) => {
        const amountValue = parseFloat(<?php echo $total_payment/23450; ?>).toFixed(2);
        return actions.order.create({
            purchase_units: [{
                amount: {
                    value: amountValue
                }
            }]
        });
    },
    onApprove: (data, actions) => {
        let callbackUrl = "http://web:4000/student/payment/callback?resultCode=1006";
        callbackUrl = '<?php echo $callBackUrl ?>';
        return actions.redirect();
    },
    onCancel: function(data) {
        window.location.href = "http://web:4000/student/payment/callback?resultCode=1006";
    }
}).render('#paypal-button-container');
</script>
</body>
</html>