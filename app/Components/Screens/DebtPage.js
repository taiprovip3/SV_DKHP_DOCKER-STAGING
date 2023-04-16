import React from 'react';
import { Box, Button, Center, CheckIcon, Divider, Flex, HStack, Modal, NativeBaseProvider, Pressable, ScrollView, Select, Text, VStack } from 'native-base';
import { FontAwesome5 } from '@expo/vector-icons';
import Toast from 'react-native-toast-message';
import { AuthContext } from '../Providers/AuthProvider';
import publicIP from 'react-native-public-ip';
import axios from 'axios';
import { AppState } from 'react-native';
import { LOCAL_JAVA_API_URL } from '@env';
import { JAVA_PORT } from '@env';
import { SO_TIEN_1_TIN_CHI } from '@env';
import { MaterialCommunityIcons } from '@expo/vector-icons';
import { FontAwesome } from '@expo/vector-icons';
import { formatCurrency } from '../Utilities/formatCurrency';
import { formatDate } from '../Utilities/formatDate';
import { Foundation } from '@expo/vector-icons';

const DebtPage = ({navigation}) => {

  const JAVA_API_URL = LOCAL_JAVA_API_URL + ":" + JAVA_PORT;
  const appStateSubscriptionRef = React.useRef(null);
  const appStateRef = React.useRef(AppState.currentState);
  const { token, setToken, currentUser, setCurrentUser } = React.useContext(AuthContext);
  const [ debts, setDebts ] = React.useState([]);
  const [ payedDebts, setPayedDebts] = React.useState([]);
  const [ detailPayedDebtModal, setDetailPayedDebtModal] = React.useState(false);
  const [ service, setService ] = React.useState("");
  const [ courseId, setCourseId ] = React.useState("ALL");
  const [ courses, setCourses ] = React.useState([]);
  const [ selectePayedDebt, setSelectedPayedDebt ] = React.useState(null);
  const [dataArray, setDataArray] = React.useState([
    { maCongNo: 1, maLopHocPhan: '1', tenMonHoc: 'Thực tập doanh nghiệp', maMonHoc: 1000081, soTinChi: 5, loaiDangKy: 'Học mới', soTien: '4.250.000', mienGiam: 0, trangThai: 'Chưa nộp'},
    { maCongNo: 2, maLopHocPhan: '2', tenMonHoc: 'Thực tập doanh nghiệp', maMonHoc: 1000081, soTinChi: 5, loaiDangKy: 'Học mới', soTien: '4.250.000', mienGiam: 0, trangThai: 'Chưa nộp'},
    { maCongNo: 3, maLopHocPhan: '3', tenMonHoc: 'Thực tập doanh nghiệp', maMonHoc: 1000081, soTinChi: 5, loaiDangKy: 'Học mới', soTien: '4.250.000', mienGiam: 0, trangThai: 'Chưa nộp'},
    { maCongNo: 4, maLopHocPhan: '3', tenMonHoc: 'Thực tập doanh nghiệp', maMonHoc: 1000081, soTinChi: 5, loaiDangKy: 'Học mới', soTien: '4.250.000', mienGiam: 0, trangThai: 'Chưa nộp'},
    { maCongNo: 5, maLopHocPhan: '3', tenMonHoc: 'Thực tập doanh nghiệp', maMonHoc: 1000081, soTinChi: 5, loaiDangKy: 'Học mới', soTien: '4.250.000', mienGiam: 0, trangThai: 'Chưa nộp'},
    { maCongNo: 6, maLopHocPhan: '3', tenMonHoc: 'Thực tập doanh nghiệp', maMonHoc: 1000081, soTinChi: 5, loaiDangKy: 'Học mới', soTien: '4.250.000', mienGiam: 0, trangThai: 'Chưa nộp'},
  ]);
  const loaiDangKyShortCut = {HOC_MOI: "Học mới", HOC_LAI: "Học lại", HOC_CAI_THIEN: "Học cải thiện"};
  const trangThaiShortCut = {CHUA_NOP: "Chưa nộp", DA_NOP: "Đã nộp"};

  React.useEffect(() => {
    appStateSubscriptionRef.current = AppState.addEventListener('change', handleAppStateChange);

    return () => {
      if (appStateSubscriptionRef.current) {
        appStateSubscriptionRef.current.remove();
      }
    };
  }, []);

  React.useEffect(() => {
    return () => {
      if (appStateSubscriptionRef.current) {
        appStateSubscriptionRef.current.remove();
      }
    };
  }, []);

  React.useEffect(() => {// Get initials data
    const getDebts = async () => {
      try {
        const javaIp = await publicIP();
        const debtsReponsee = await axios.get(JAVA_API_URL+"/api/debt/getUnDebtsByStudentId/"+currentUser.maSinhVien, {headers: {"Authorization": token}});
        if(debtsReponsee.data.length > 0) {// Nếu số công nợ > 0
          const congNos = [];
          for(let i=0;i<debtsReponsee.data.length; i++) {
            const debt = debtsReponsee.data[i];
            const maCongNo = debt.id;
            const maLopHocPhan = debt.lopHocPhan.maLopHocPhan;
            const tenMonHoc = debt.monHoc.tenMonHoc;
            const maMonHoc = debt.monHoc.maMonHoc;
            const soTinChi = debt.monHoc.soTinChi;
            const loaiDangKy = debt.lopHocPhan.loaiHoc;
            const soTien = soTinChi * SO_TIEN_1_TIN_CHI; //Hình như số tiền 1TC đại trà vs CLC khác nhau
            const mienGiam = debt.mienGiam;
            const congNo = soTien;
            const trangThai = debt.trangThai;
            const itemCongNo= { maCongNo, maLopHocPhan, tenMonHoc, maMonHoc, soTinChi, loaiDangKy, soTien, mienGiam, congNo, trangThai};
            congNos.push(itemCongNo);
          }
          setDebts(congNos);
        }
      } catch (error) {
        console.error(error.message);
      }
    }
    const getPayedDebts = async () => {
      const payedDebtsReponse = await axios.get(JAVA_API_URL+"/api/debt/getPayedDebts/"+currentUser.maSinhVien, {headers: {"Authorization": token}});
      if(payedDebtsReponse.data)
        setPayedDebts(payedDebtsReponse.data);
    }
    const getCourses = async () => {
      const coursesResponse = await axios.get(JAVA_API_URL+"/api/course/getCoursesByStudentId/"+currentUser.maSinhVien, {headers: {"Authorization": token}});
      if(coursesResponse.data)
        setCourses(coursesResponse.data);
    }
    getDebts();
    getPayedDebts();
    getCourses();
  },[]);

  const handleAppStateChange = (nextAppState) => {
    appStateRef.current = nextAppState;
    console.log('App State: ', nextAppState);
  };

  const handlePayout = async (item) => {
    if(service === "") {
        Toast.show({
          type: 'error',
          text1: 'Chọn loại thanh toán',
          text2: 'Vui lòng chọn hình thức thanh toán'
        });
    } else {
        // Redirect qua webview
        // item đã đc format phù hợp vs render
        if(service === "PAYPAL") {
          // Implement paypal here...
          const maThanhToanGiaoDichReponse = await axios.get(JAVA_API_URL+"/api/payment/createTransaction/"+currentUser.maSinhVien+"/"+0+"/"+item.maCongNo, {headers: {"Authorization": token}});
          const debtData = {service, maCongNo:item.maCongNo, tenMonHoc:item.tenMonHoc, maSinhVien:currentUser.maSinhVien, maLopHocPhan:item.maLopHocPhan, soTien: item.soTien, loaiThanhToan:service, maThanhToanGiaoDich: maThanhToanGiaoDichReponse.data}
          navigation.navigate("PaymentPage", {debtData: debtData});
        } else {
          if(service === "MOMO") {
            // Implement momo here...
            const maThanhToanGiaoDichReponse = await axios.get(JAVA_API_URL+"/api/payment/createTransaction/"+currentUser.maSinhVien+"/"+0+"/"+item.maCongNo, {headers: {"Authorization": token}});
            const debtData = {service, maCongNo: item.maCongNo, maThanhToanGiaoDich: maThanhToanGiaoDichReponse.data, maSinhVien:currentUser.maSinhVien};
            navigation.navigate("PaymentPage", {debtData: debtData});
          } else {
            if(service === "VNPAY") {
              // implement vnpay here..
              const maThanhToanGiaoDichReponse = await axios.get(JAVA_API_URL+"/api/payment/createTransaction/"+currentUser.maSinhVien+"/"+0+"/"+item.maCongNo, {headers: {"Authorization": token}});
              const debtData = {service, maCongNo: item.maCongNo, maThanhToanGiaoDich: maThanhToanGiaoDichReponse.data, maSinhVien:currentUser.maSinhVien, soTien: item.soTien};
              navigation.navigate("PaymentPage", {debtData: debtData});
            }
            if(service === "STUDENT_WALLET") {
              // implement student_wallet here...
              const maThanhToanGiaoDichReponse = await axios.get(JAVA_API_URL+"/api/payment/createTransaction/"+currentUser.maSinhVien+"/"+0+"/"+item.maCongNo, {headers: {"Authorization": token}});
              const debtData = {service, maCongNo: item.maCongNo, maThanhToanGiaoDich: maThanhToanGiaoDichReponse.data, maSinhVien:currentUser.maSinhVien};
              navigation.navigate("PaymentPage", {debtData: debtData});
            }
          }
        }
    }
  }

  const seeDetailPayedDebt = (item) => {
    setDetailPayedDebtModal(true);
  }

  const onClickPayedDebt = async (payedDebt) => {
    // Tiến hành lấy ttgd từ debtId
    const thanhToanGiaoDichReponse = await axios.get(JAVA_API_URL+"/api/payment/getStudentPayedDebtByDebtId/"+payedDebt.id+"/"+currentUser.maSinhVien, {headers: {"Authorization": token}});
    if(thanhToanGiaoDichReponse.data) {
      const newPayedDebt = {...payedDebt, thanhToanGiaoDich: thanhToanGiaoDichReponse.data}
      setSelectedPayedDebt(newPayedDebt);
      setDetailPayedDebtModal(true);
    }
  }

  const renderItems = () => {
    return debts.map((item, index) => (
      <Pressable key={index} onPress={() => handlePayout(item)} w="1/2">
        <Box borderWidth="0.3" borderColor="black" borderRadius="lg" mt="2" p="3">
          <Box>
            <Text>Mã LHP: <Text bold>{item.maLopHocPhan}</Text></Text>
            <Text>Môn: <Text bold>{item.tenMonHoc}</Text></Text>
            <Text>Mã môn: <Text bold>{item.maMonHoc}</Text></Text>
            <Text>Loại đăng ký: <Text bold>{loaiDangKyShortCut[item.loaiDangKy]}</Text></Text>
            <Text>Số tín chỉ: <Text bold>{item.soTinChi}</Text></Text>
            <Divider></Divider>
            <Text>Số tiền: <Text bold>{formatCurrency(item.soTien)}</Text></Text>
            <Text>Trạng thái: <Text bold>{trangThaiShortCut[item.trangThai]}</Text></Text>
          </Box>
          <HStack justifyContent="center" alignItems="center">
              <FontAwesome5 name="hands-wash" size={24} color="green" />
              <Text underline color="amber.500">Chạm vào thanh toán!</Text>
          </HStack>
        </Box>
      </Pressable>
    ));
  };

  const renderItems2 = () => {
    return payedDebts.map((item, index) => (
      <Pressable key={index} onPress={() => onClickPayedDebt(item)} w="1/2">
        <Box borderWidth="0.3" borderColor="black" borderRadius="lg" mt="2" p="3" bg="success.100">
          <Box>
            <Text>Mã LHP: <Text bold>{item.lopHocPhan.maLopHocPhan}</Text></Text>
            <Text>Môn: <Text bold>{item.monHoc.tenMonHoc}</Text></Text>
            <Text>Mã môn: <Text bold>{item.monHoc.maMonHoc}</Text></Text>
            <Text>Loại đăng ký: <Text bold>{loaiDangKyShortCut[item.lopHocPhan.loaiHoc]}</Text></Text>
            <Text>Số tín chỉ: <Text bold>{item.monHoc.soTinChi}</Text></Text>
            <Divider></Divider>
            <Text>Số tiền: <Text bold>{formatCurrency(item.daNop)}</Text></Text>
            <Text>Trạng thái: <Text bold>{trangThaiShortCut[item.trangThai]}</Text></Text>
          </Box>
          <HStack justifyContent="center" alignItems="center">
              <FontAwesome5 name="hands-wash" size={24} color="gray" />
              <Text underline color="coolGray.700">Nhấp xem chi tiết</Text>
          </HStack>
        </Box>
      </Pressable>
    ));
  };

  return (
    <NativeBaseProvider>
      <Box zIndex="1"><Toast position='top' /></Box>
      <ScrollView p="1">
        <Text fontSize="xs"><FontAwesome5 name="amazon-pay" size={20} color="black" /> Bạn đang có: <Text bold underline color="teal.800">{debts.length > 10 ? debts.length : '0'+debts.length}</Text> công nợ cần giải quyết</Text>
        {/* <FontAwesome5 name="cc-amazon-pay" size={24} color="black" /> */}
        {/* Selection dropdown */}
        <Select
                selectedValue={service} minWidth="200" accessibilityLabel="Choose Service" placeholder="Chọn loại thanh toán" _selectedItem={{
                    bg: "teal.600",
                    endIcon: <CheckIcon size="5" />
                }} mt={1} onValueChange={itemValue => setService(itemValue)}
            >
          <Select.Item label="PAYPAL" value="PAYPAL" />
          <Select.Item label="MOMO" value="MOMO" />
          <Select.Item label="VNPAY" value="VNPAY" />
          <Select.Item label="STUDENT_WALLET" value="STUDENT_WALLET" />
        </Select>
        <Box flex="1" flexDirection="row" flexWrap="wrap" justifyContent="center">
            {
              debts.length > 0
              ? renderItems()
              :
              <Box mt="5"><Text>Không tìm thấy công nợ nào!</Text></Box>
            }
        </Box>
        <Text>{" "}</Text>
        {/* <Center><Divider
          bg="emerald.500"
          thickness="2"
          m="5"
          w="5/6"
        /></Center> */}
        <Text><FontAwesome5 name="cc-paypal" size={22} color="black" /> Công nợ: <Text bold underline color="teal.800">{payedDebts.length > 10 ? payedDebts.length : '0'+payedDebts.length}</Text> đã thanh toán</Text>
        <Select
            selectedValue={courseId} minWidth="200" accessibilityLabel="Choose Service" placeholder="Chọn học kỳ" _selectedItem={{
                bg: "teal.600",
                endIcon: <CheckIcon size="5" />
            }} mt={1} onValueChange={itemValue => setCourseId(itemValue)}
        >
          <Select.Item label="Tất cả" value="ALL" />
          {
            courses.map((course) => {
              return <Select.Item label={`${course.alias} (${course.namBatDau} - ${course.namKetThuc}) `} value={course.maKhoaHoc} key={Math.random()} />
            })
          }
        </Select>
        <Box flex="1" flexDirection="row" flexWrap="wrap" justifyContent="center">
          {
              payedDebts.length > 0
              ? renderItems2()
              :
              <Box mt="5"><Text>Không tìm thấy công nợ nào!</Text></Box>
            }
        </Box>
      </ScrollView>
      <Modal isOpen={detailPayedDebtModal} onClose={() => setDetailPayedDebtModal(false)} size={"xl"}>
        <Modal.Content>
          <Modal.CloseButton />
          <Modal.Header>
            <Text>Chi tiết công nợ:</Text>
            <Text fontSize="xs">(Công nợ đã thanh toán)</Text>
          </Modal.Header>
          <Modal.Body>
            {
              !selectePayedDebt ?
              <Box><Text>Bạn chưa chọn 1 công nợ nào để xem</Text></Box>
              :
              <Box>
                <Text fontSize="xs">Mã công nợ: <Text bold color="teal.600">{selectePayedDebt.id}</Text></Text>
                <Text fontSize="xs">Môn học: <Text bold color="teal.600">{selectePayedDebt.monHoc.tenMonHoc}</Text> - <Text bold color="teal.600">{selectePayedDebt.monHoc.maMonHoc}</Text></Text>
                <Text fontSize="xs">Mã LHP: <Text bold color="teal.600">{selectePayedDebt.lopHocPhan.maLopHocPhan}</Text> - <Text bold color="teal.600">{selectePayedDebt.lopHocPhan.tenLopHocPhan}</Text></Text>
                <Text fontSize="xs">Loại đăng ký: <Text bold color="teal.600">{loaiDangKyShortCut[selectePayedDebt.lopHocPhan.loaiHoc]}</Text></Text>
                <Divider></Divider>
                <Text fontSize="xs">Số tiền: <Text bold color="teal.600">{formatCurrency(selectePayedDebt.daNop)}</Text></Text>
                <Text fontSize="xs">Trạng thái: <Text bold color="teal.600">{trangThaiShortCut[selectePayedDebt.trangThai]}</Text></Text>
                <Text fontSize="xs">Thanh toán vào lúc: <Text bold color="teal.600">{formatDate(selectePayedDebt.thanhToanGiaoDich.expiredTime)}</Text></Text>
                <Divider></Divider>
                <Text fontSize="xs">Mã giao dịch: <Text bold color="teal.600">{selectePayedDebt.thanhToanGiaoDich.maGiaoDich}</Text></Text>
                <Text fontSize="xs">Số tiền thanh toán: <Text bold color="teal.600">{formatCurrency(selectePayedDebt.thanhToanGiaoDich.balance)}</Text></Text>
                <Text fontSize="xs">Số dư thanh toán: <Text bold color="teal.600">{formatCurrency(0)}</Text></Text>
                <Text fontSize="xs">Số dư + vào ví: <Text bold color="teal.600">{formatCurrency(0)}</Text></Text>
                <Text fontSize="xs">Ghi chú: <Text bold color="teal.600">{selectePayedDebt.thanhToanGiaoDich.ghiChu}</Text></Text>
                <Divider bg="emerald.500"></Divider>
                <Text>Hoá đơn điện tử PDF:</Text>
                <MaterialCommunityIcons name="file-pdf-box" size={24} color="black" />
                <Text>Đã gửi qua email: <Text bold color="teal.600" underline>{selectePayedDebt.sinhVien.taiKhoan.email}</Text> <FontAwesome name="check-circle" size={24} color="green" /></Text>
              </Box>
            }
          </Modal.Body>
          <Modal.Footer>
            <Button.Group space={2}>
              <Button variant="ghost" colorScheme="blueGray" onPress={() => {
              setDetailPayedDebtModal(false);
            }}>
                Cancel
              </Button>
            </Button.Group>
          </Modal.Footer>
        </Modal.Content>
      </Modal>
    </NativeBaseProvider>
  )
};

export default DebtPage;