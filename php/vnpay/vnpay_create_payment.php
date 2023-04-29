<?php
ob_start();
error_reporting(E_ALL & ~E_NOTICE & ~E_DEPRECATED);
date_default_timezone_set('Asia/Ho_Chi_Minh');

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

function execGetDebtBalanceById($debtId) {
    $content = file_get_contents("http://localhost:8080/api/debt/getSoTienByDebtId/".$debtId);
    $result  = json_decode($content);
    return (int) $result;
}

/**
 * 
 *
 * @author CTT VNPAY
 */
require_once("./config.php");

$maSinhVien = $_POST['maSinhVien'];
$lengthDebt = $_POST['lengthDebt'];
$total_debt = array();
for($i = 0; $i<$lengthDebt ; $i++) {
    array_push($total_debt, $_POST['debt'.$i]);
}
$totalBalance = 0;
foreach ($total_debt as $key => $value) {
    $totalBalance += execGetDebtBalanceById($value);
}
$unDebtIdsString = implode(",", $total_debt);

$curl = curl_init();
curl_setopt($curl, CURLOPT_URL, "http://localhost:8080/api/payment/createTransaction/".$maSinhVien."/".$totalBalance."/".$unDebtIdsString."");
curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
$maGiaoDich = curl_exec($curl);
curl_close($curl);

$vnp_TxnRef = rand(1,10000); //Mã giao dịch thanh toán tham chiếu của merchant
$vnp_Amount = $totalBalance * 100; // Số tiền thanh toán
$vnp_Locale = $_POST['language']; //Ngôn ngữ chuyển hướng thanh toán
$vnp_BankCode = $_POST['bankCode']; //Mã phương thức thanh toán
$vnp_IpAddr = $_SERVER['REMOTE_ADDR']; //IP Khách hàng thanh toán

$inputData = array(
    "vnp_Version" => "2.1.0",
    "vnp_TmnCode" => $vnp_TmnCode,
    "vnp_Amount" => $vnp_Amount,
    "vnp_Command" => "pay",
    "vnp_CreateDate" => date('YmdHis'),
    "vnp_CurrCode" => "VND",
    "vnp_IpAddr" => $vnp_IpAddr,
    "vnp_Locale" => $vnp_Locale,
    // "vnp_OrderInfo" => "Thanh toan GD:" . $vnp_TxnRef,
    "vnp_OrderInfo" => $maGiaoDich,
    "vnp_OrderType" => "other",
    "vnp_ReturnUrl" => $vnp_Returnurl,
    "vnp_TxnRef" => $vnp_TxnRef,
    "vnp_ExpireDate"=>$expire
);

if (isset($vnp_BankCode) && $vnp_BankCode != "") {
    $inputData['vnp_BankCode'] = $vnp_BankCode;
}

ksort($inputData);
$query = "";
$i = 0;
$hashdata = "";
foreach ($inputData as $key => $value) {
    if ($i == 1) {
        $hashdata .= '&' . urlencode($key) . "=" . urlencode($value);
    } else {
        $hashdata .= urlencode($key) . "=" . urlencode($value);
        $i = 1;
    }
    $query .= urlencode($key) . "=" . urlencode($value) . '&';
}

$vnp_Url = $vnp_Url . "?" . $query;
if (isset($vnp_HashSecret)) {
    $vnpSecureHash =   hash_hmac('sha512', $hashdata, $vnp_HashSecret);//  
    $vnp_Url .= 'vnp_SecureHash=' . $vnpSecureHash;
}
header('Location: ' . $vnp_Url);
die();
ob_end_flush();

