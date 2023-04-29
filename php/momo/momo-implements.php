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
function execGetDebtBalanceById($debtId) {
    $content = file_get_contents("http://java:8080/api/debt/getSoTienByDebtId/".$debtId);
    $result  = json_decode($content);
    return (int) $result;

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
if(!isset($_POST['lengthDebt'])) {
    echo "Internal Server Error!";
    return;
} else {
    $lengthDebt = $_POST['lengthDebt'];
    if($lengthDebt <= 0) {
        echo "Internal Server Error!";
        return;
    }
}

    $maSinhVien = $_POST['maSinhVien'];
    $lengthDebt = $_POST['lengthDebt'];
    $total_debt = array();
    for($i = 0; $i<$lengthDebt ; $i++) {
        array_push($total_debt, $_POST['debt'.$i]);
    }
    //Bắt đầu tạo QR code để call API...
    $total = 0;
    foreach ($total_debt as $key => $value) {
        $total += execGetDebtBalanceById($value);
    }
    $unDebtIds = implode(",", $total_debt);

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
    header('Location: ' . $jsonResult['payUrl']);
    ob_end_flush();
?>