<?php
    ob_start();
    error_reporting(E_ALL & ~E_NOTICE & ~E_DEPRECATED);
    date_default_timezone_set('Asia/Ho_Chi_Minh');
    /**
     * 
     *
     * @author CTT VNPAY
     */
    require_once("./config.php");
    function isExpired($datetimeStr) {
        $expiredTime = DateTime::createFromFormat('Y-m-d\TH:i:s.uO', $datetimeStr);
        $currentTime = new DateTime();
        $interval = $expiredTime->diff($currentTime);
        return $interval->invert == 0; // return true nếu thời gian chưa hết hạn, false nếu đã hết hạn
    }
    $maThanhToanGiaoDich = $_POST['maThanhToanGiaoDich'];
    $maSinhVien = $_POST['maSinhVien'];
    $maCongNo = $_POST['maCongNo'];
    $url = "http://localhost:8080/api/payment/getTokenByPaymentAndStudentId/".$maThanhToanGiaoDich."/".$maSinhVien;
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
        $url = "http://localhost:8080/api/payment/getPaymentById/".$maThanhToanGiaoDich;
        $context = stream_context_create($options);
        $response = file_get_contents($url, false, $context);
        $response_parse = json_decode($response);
        if($response_parse->status === false) {// Nếu giao dịch chưa đc thanh toán đúng flow
            $expiredTime = $response_parse->expiredTime;
            if (isExpired($expiredTime)) {
                echo "Giao dịch đã quá hạn. Vui lòng thử lại!";
            } else {
                $url = "http://localhost:8080/api/debt/getUnDebtById/".$maCongNo;
                $response = file_get_contents($url, false, $context);
                $response_parse = json_decode($response);
                $soTienCongNo = $response_parse->monHoc->soTinChi * 850000;


                $vnp_TxnRef = rand(1,10000); //Mã giao dịch thanh toán tham chiếu của merchant
                $vnp_Amount = $soTienCongNo * 100; // Số tiền thanh toán
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
                    "vnp_OrderInfo" => $maThanhToanGiaoDich,
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
            }
        } else {// Mã giao dịch đã sử dụng
            echo "Giao dịch này đã được hoàn tất trước đó!";
        }
    }
?>