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
    function isExpired($datetimeStr) {
        $expiredTime = DateTime::createFromFormat('Y-m-d\TH:i:s.uO', $datetimeStr);
        $currentTime = new DateTime();
        $interval = $expiredTime->diff($currentTime);
        return $interval->invert == 0; // return true nếu thời gian chưa hết hạn, false nếu đã hết hạn
    }
    function validateBalanceGiaoDich() {
        if (isset($_GET['balanceGiaoDich'])) {
            $balanceGiaoDich = $_GET['balanceGiaoDich'];
            if (!is_numeric($balanceGiaoDich) || $balanceGiaoDich < 0) {
                // Bắt lỗi nếu giá trị không phải là số hoặc số âm
                return "Giá trị balanceGiaoDich không hợp lệ";
            }
        } else {
            // Bắt lỗi nếu biến không tồn tại
            return "Không tìm thấy biến balanceGiaoDich";
        }
        return "";
    }
    $error = validateBalanceGiaoDich();
    if ($error !== "") {
        echo $error;
        exit;
    }
    $maThanhToanGiaoDich = $_GET["maThanhToanGiaoDich"];
    $maSinhVien = $_GET["maSinhVien"];
    $balanceGiaoDich = $_GET["balanceGiaoDich"];
    $momo_method = $_GET["momoMethod"];

    $url = "http://java:8080/api/payment/getTokenByPaymentAndStudentId/".$maThanhToanGiaoDich."/".$maSinhVien;
    $response = file_get_contents($url);
    if ($response === false) {
        // xảy ra lỗi kết nối đến API
        echo "[SYSTEM] > Không thể kết nối đến API";
    } else if (empty($response)) {
        // trả về dữ liệu rỗng hoặc không tìm thấy tài nguyên
        echo "[SYSTEM] > Không tìm thấy tài nguyên hoặc API trả về dữ liệu rỗng";
    } else {
        // xử lý dữ liệu trả về từ API
        $token = $response;
        $options = array(
            'http' => array(
                'header' => "Authorization: $token\r\n"
            )
        );
        $url = "http://java:8080/api/payment/getPaymentById/".$maThanhToanGiaoDich;
        $context = stream_context_create($options);
        $response = file_get_contents($url, false, $context);
        $response_parse = json_decode($response);
        if($response_parse->status === false) {// Nếu giao dich chưa duoc thuc hien
            $expiredTime = $response_parse->expiredTime;
            if (isExpired($expiredTime)) {
                echo "Giao dịch đã quá hạn. Vui lòng thử lại!";
            } else {
                $endpoint = "https://test-payment.momo.vn/v2/gateway/api/create";
                $partnerCode = 'MOMOBKUN20180529';
                $accessKey = 'klm05TvNBzhg7h7j';
                $secretKey = 'at67qH6mk8w5Y1nAyMoYKMWACiEi2bsa';

                $orderInfo = "Thanh toán qua MoMo QR (Quét mã app momo)";
                $amount = $balanceGiaoDich;
                $orderId = time() ."";
                $redirectUrl = "https://erukalearn.ddns.net/student/payment/callback";
                $ipnUrl = "http://php:80/momo/momo-ipn.php";
                $extraData = $maThanhToanGiaoDich;

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
            }
        } else {// Mã giao dịch đã được sử dụng
            echo "Giao dịch thanh toán đã hoàn tất trước đó";
        }
    }
?>
</body>
</html>