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
if(!isset($_POST['total_debt_length'])) {
    echo "Internal Server Error.";
    return;
} else {
    $total_debt_length = $_POST['total_debt_length'];
    if($total_debt_length <= 0) {
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
function execGetDebtBalanceById($debtId) {
    $content = file_get_contents("http://java:8080/api/debt/getSoTienByDebtId/".$debtId);
    $result  = json_decode($content);
    return (int) $result;
}
$total_debt = array();
$method_payment = $_POST['method_payment'];
$total_payment = $_POST['total_payment'];
$total_debt_length = $_POST['total_debt_length'];
$maSinhVien = $_POST['maSinhVien'];
for($i = 0; $i<$total_debt_length ; $i++) {
    array_push($total_debt, $_POST['debt'.$i]);
}
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
<script src="https://www.paypal.com/sdk/js?client-id=AThjeK9VFs45Lz8HCDlTQOD23Xq_oloQEY9a9YYmT_ElevonYELsMtiZ7ewWmSyg00mBoAll_ZSCUeIP&currency=USD&debug=true&commit=false"></script>
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
        <?php
            $totalBalance = 0;
            foreach ($total_debt as $key => $value) {
                $totalBalance += execGetDebtBalanceById($value);
            }
            $unDebtIdsString = implode(",", $total_debt);//tạo ra string mảng
            $curl = curl_init();
            curl_setopt($curl, CURLOPT_URL, "http://java:8080/api/payment/createTransaction/".$maSinhVien."/".$totalBalance."/".$unDebtIdsString."");
            curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
            $maGiaoDich = curl_exec($curl);
            curl_close($curl);    
        ?>
        return actions.order.create({
            purchase_units: [{
                amount: {
                    value: parseFloat(<?php echo $totalBalance/23450; ?>).toFixed(2) // Can also reference a variable or function
                }
            }]
        });
    },
    onApprove: (data, actions) => {
        return actions.order.capture().then(function(orderData) {
            console.log('Capture result', orderData, JSON.stringify(orderData, null, 2));
            const transaction = orderData.purchase_units[0].payments.captures[0];
            console.log("transaction: ", transaction);
            // alert(`Transaction ${transaction.status}: ${transaction.id}\n\nSee console for all available details`);
            // When ready to go live, remove the alert and show a success message within this page. For example:
            // const element = document.getElementById('paypal-button-container');
            // element.innerHTML = '<h3>Thank you for your payment!</h3>';
            // Or go to another URL:  actions.redirect('thank_you.html');
            const callBackUrl = "http://web:4000/student/payment/callback?extraData=<?php echo $maGiaoDich; ?>&resultCode=0&amount=<?php echo $totalBalance; ?>&orderType=<?php echo "PAYPAL - WALLET"; ?>";
            window.location.href = callBackUrl;
        });
    },
    onCancel: function(data) {
        window.location.href = "http://web:4000/student/payment/callback?resultCode=1006";
    }
}).render('#paypal-button-container');
</script>
</body>
</html>