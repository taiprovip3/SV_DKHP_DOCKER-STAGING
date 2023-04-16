<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
        <meta name="description" content="">
        <meta name="author" content="">
        <title>VNPAY RESPONSE</title>
        <!-- Bootstrap core CSS -->
        <link href="/vnpay_php/assets/bootstrap.min.css" rel="stylesheet"/>
        <!-- Custom styles for this template -->
        <link href="/vnpay_php/assets/jumbotron-narrow.css" rel="stylesheet">         
        <script src="/vnpay_php/assets/jquery-1.11.3.min.js"></script>
    </head>
    <body>
        <?php
        require_once("./config.php");
        $vnp_SecureHash = $_GET['vnp_SecureHash'];
        $inputData = array();
        foreach ($_GET as $key => $value) {
            if (substr($key, 0, 4) == "vnp_") {
                $inputData[$key] = $value;
            }
        }
        
        unset($inputData['vnp_SecureHash']);
        ksort($inputData);
        $i = 0;
        $hashData = "";
        foreach ($inputData as $key => $value) {
            if ($i == 1) {
                $hashData = $hashData . '&' . urlencode($key) . "=" . urlencode($value);
            } else {
                $hashData = $hashData . urlencode($key) . "=" . urlencode($value);
                $i = 1;
            }
        }

        $secureHash = hash_hmac('sha512', $hashData, $vnp_HashSecret);
        ?>
        <!--Begin display -->
        <div class="container">
            <div class="header clearfix">
                <h3 class="text-muted">ErukaLearn.edu.vn</h3>
                <span class="small">Nếu kết quả giao dịch là <strong class="text-danger"><u>thất bại</u></strong> thì có thể đóng trang, nếu <strong class="text-success"><u>thành công</u></strong> thì vui lòng đợi thêm giây lát.</span>
            </div>
            <div class="table-responsive">
                <div class="form-group">
                    <label >Mã đơn hàng:</label>

                    <label><?php echo $_GET['vnp_TxnRef'] ?></label>
                </div>    
                <div class="form-group">

                    <label >Số tiền:</label>
                    <label><?php echo number_format($_GET['vnp_Amount'], 0, '.', ',') . ' VND'; ?></label>
                </div>  
                <div class="form-group">
                    <label >Nội dung thanh toán:</label>
                    <label><?php echo $_GET['vnp_OrderInfo'] ?></label>
                </div> 
                <div class="form-group">
                    <label >Mã phản hồi (vnp_ResponseCode):</label>
                    <label><?php echo $_GET['vnp_ResponseCode'] ?></label>
                </div> 
                <div class="form-group">
                    <label >Mã GD Tại VNPAY:</label>
                    <label><?php echo $_GET['vnp_TransactionNo'] ?></label>
                </div> 
                <div class="form-group">
                    <label >Mã Ngân hàng:</label>
                    <label><?php echo $_GET['vnp_BankCode'] ?></label>
                </div> 
                <div class="form-group">
                    <label >Thời gian thanh toán:</label>
                    <label><?php echo $_GET['vnp_PayDate'] ?></label>
                </div> 
                <div class="form-group">
                    <label >Kết quả:</label>
                    <label>
                        <?php
                        if ($secureHash == $vnp_SecureHash) {
                            if ($_GET['vnp_ResponseCode'] == '00') {
                                $extraData = $_GET['vnp_OrderInfo'];
                                $resultCode = 0;
                                $amount = $_GET['vnp_Amount'];
                                $orderType = "VNPAY - " . $_GET['vnp_BankCode'] . " - " . $_GET['vnp_CardType'];
                                $callBackUrl = "http://localhost:4000/student/payment/callback?extraData=".$extraData."&resultCode=".$resultCode."&amount=".$amount."&orderType=".$orderType;
                                echo '<script>
                                    var myInterval = null;
                                    var myCounter = 4;
                                    var myLoop = () => {
                                        if(myCounter != 0) {
                                            myCounter--;
                                            document.getElementById("countdown").innerText = myCounter;
                                        } else {
                                            clearInterval(myInterval);
                                            window.location.href = "'.$callBackUrl.'";
                                        }
                                    };
                                    myInterval = setInterval(myLoop, 1000);
                                </script>';
                                echo "<span style='color:blue'>GD Thanh cong</span>";
                            } else {
                                $extraData = $_GET['vnp_OrderInfo'];
                                $resultCode = 1006;
                                $amount = $_GET['vnp_Amount'];
                                $orderType = "VNPAY - " . $_GET['vnp_BankCode'] . " - " . $_GET['vnp_CardType'];
                                $callBackUrl = "http://localhost:4000/student/payment/callback?extraData=".$extraData."&resultCode=".$resultCode."&amount=".$amount."&orderType=".$orderType;
                                echo '<script>
                                    var myInterval = null;
                                    var myCounter = 20;
                                    var myLoop = () => {
                                        if(myCounter != 0) {
                                            myCounter--;
                                            document.getElementById("countdown").innerText = myCounter;
                                        } else {
                                            clearInterval(myInterval);
                                            window.location.href = "'.$callBackUrl.'";
                                        }
                                    };
                                    myInterval = setInterval(myLoop, 1000);
                                </script>';
                                echo "<span style='color:red'>GD Khong thanh cong</span>";
                            }
                        } else {
                            echo "<span style='color:red'>Chu ky khong hop le</span>";
                        }
                        ?>

                    </label>
                </div> 
            </div>
            <p>
                &nbsp;
            </p>
            <footer class="footer">
                <p>Vui lòng không tắt trang. Giao dịch đang được xử lý tiếp...<span id="countdown">3</span>s</p>
                <p class="text-info">&copy; VNPAY <?php echo date('Y')?></p>
            </footer>
        </div>
    </body>
</html>
