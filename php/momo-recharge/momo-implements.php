<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <!-- Import thư viện jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Import thư viện toastr -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
</head>
<body>
<?php
    ob_start();
    header('Content-type: text/html; charset=utf-8');
    function execPostRequest($url, $data) {
        $ch = curl_init($url);
        curl_setopt($ch, CURLOPT_CUSTOMREQUEST, "POST");
        curl_setopt($ch, CURLOPT_POSTFIELDS, $data);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch, CURLOPT_HTTPHEADER, array(
                'Content-Type: application/json',
                'Content-Length: ' . strlen($data))
        );
        curl_setopt($ch, CURLOPT_TIMEOUT, 5);
        curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 5);
        //execute post
        $result = curl_exec($ch);
        //close connection
        curl_close($ch);
        return $result;
    }
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
        echo "Internal Server Error!";
        return;
    } else {
        $total_payment = $_POST['total_payment'];
        if($total_payment <= 0 ) {
            echo "Internal Server Error!";
            return;
        }
    }
    if(!isset($_POST['maSinhVien'])) {
        echo "Internal Server Error!";
        return;
    } else {
        $maSinhVien = $_POST['maSinhVien'];
        if($maSinhVien <= 0) {
            echo "Internal Server Error!";
            return;
        }
    }

    $maSinhVien = $_POST['maSinhVien'];
    //Bắt đầu tạo QR code để call API...
    $total = $_POST['total_payment'];
    $unDebtIds = "Array";

    $curl = curl_init();
    curl_setopt($curl, CURLOPT_URL, "http://java:8080/api/payment/createTransaction/".$maSinhVien."/".$total."/".$unDebtIds."");
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
    $output = curl_exec($curl);
    curl_close($curl);

    $endpoint = "https://test-payment.momo.vn/v2/gateway/api/create";
    $partnerCode = 'MOMOBKUN20180529';
    $accessKey = 'klm05TvNBzhg7h7j';
    $secretKey = 'at67qH6mk8w5Y1nAyMoYKMWACiEi2bsa';

    $orderInfo = "Thanh toán qua MoMo QR (Quét mã app momo)";
    $amount = $total;
    $orderId = time() ."";
    $redirectUrl = "https://erukalearn.ddns.net:4000/student/payment/callback";
    $ipnUrl = "http://php:80/momo/momo-ipn.php";
    $extraData = $output;

    $requestId = time() . "";
    $requestType = ($momo_method == "MOMO_QR") ? "captureWallet" : "payWithATM";
    $rawHash = "accessKey=" . $accessKey . "&amount=" . $amount . "&extraData=" . $extraData . "&ipnUrl=" . $ipnUrl . "&orderId=" . $orderId . "&orderInfo=" . $orderInfo . "&partnerCode=" . $partnerCode . "&redirectUrl=" . $redirectUrl . "&requestId=" . $requestId . "&requestType=" . $requestType;
    $signature = hash_hmac("sha256", $rawHash, $secretKey);
    $data = array('partnerCode' => $partnerCode,
        'partnerName' => "Test",
        "storeId" => "MomoTestStore",
        'requestId' => $requestId,
        'amount' => $amount,
        'orderId' => $orderId,
        'orderInfo' => $orderInfo,
        'redirectUrl' => $redirectUrl,
        'ipnUrl' => $ipnUrl,
        'lang' => 'vi',
        'extraData' => $extraData,
        'requestType' => $requestType,
        'signature' => $signature);
    $result = execPostRequest($endpoint, json_encode($data));
    $jsonResult = json_decode($result, true);  // decode json
    if($jsonResult['resultCode'] == 22) {
        echo '<script>
            toastr.error("Đã xảy ra lỗi khi xử lý.", "Giao dịch thất bại!");
        </script>';
        echo "Giao dịch thất bại. \\\<br>".$jsonResult['message'];
    } else {
        header('Location: ' . $jsonResult['payUrl']);
        ob_end_flush();
    }
?>
</body>
</html>