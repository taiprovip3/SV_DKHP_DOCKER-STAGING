import { Box, Button, Center, Divider, HStack, Icon, Image, Input, Modal, NativeBaseProvider, Pressable, ScrollView, Stack, Text } from 'native-base';
import React from 'react';
import { FontAwesome5 } from '@expo/vector-icons';
import { MaterialCommunityIcons } from '@expo/vector-icons';
import { MaterialIcons } from '@expo/vector-icons';
import { AuthContext } from '../Providers/AuthProvider';
import { AntDesign } from '@expo/vector-icons';
import { FontAwesome } from '@expo/vector-icons';
import {
  LineChart,
  BarChart,
  PieChart,
  ProgressChart,
  ContributionGraph,
  StackedBarChart
} from "react-native-chart-kit";
import { useWindowDimensions } from 'react-native';
import { formatNumber } from '../Utilities/formatNumber';
import { LOCAL_JAVA_API_URL } from '@env';
import axios from 'axios';
import publicIP from 'react-native-public-ip';
import AsyncStorage from '@react-native-async-storage/async-storage';
import Toast from 'react-native-toast-message';

const Homepage = ({ navigation }) => {
  const { token, setToken, currentUser, setCurrentUser } = React.useContext(AuthContext);
  const { width, height } = useWindowDimensions();
  const [ currentTinChi, setCurrentTinChi ] = React.useState(10);
  const [ requiredTinChi, setRequiredTinChi ] = React.useState(100);
  const [showPassword, setShowPassword] = React.useState(false);
  const bacDaoTaoShortCut = { DAI_HOC: 'Đại học', CAO_DANG: 'Cao đẳng' };
  const loaiHinhDaoTaoShortCut = { CHAT_LUONG_CAO: 'Chất lượng cao', DAI_TRA: 'Đại trà' };
  const coSoShortCut = { HA_NOI: 'Hà Nội', HO_CHI_MINH: 'Hồ Chí Minh' };

  const chartConfig = {
    backgroundGradientFrom: "white",
    backgroundGradientFromOpacity: 0,
    backgroundGradientTo: "white",
    backgroundGradientToOpacity: 0.1,
    color: (opacity = 1) => `rgba(26, 255, 146, ${opacity})`,
    strokeWidth: 2, // optional, default 3
    barPercentage: 0.5,
    useShadowColorFromDataset: false // optional
  };

  if(!currentUser && !token) {
    navigation.navigate("AuthenicationPage");
  }
  const [modalVisible, setModalVisible] = React.useState(false);
  const [optionModalVisible, setOptionModalVisible] = React.useState(false);
  const [studentInfoVisible, setStudentInfoVisible] = React.useState(false);
  const [currentPassword, setCurrentPassword] = React.useState("");
  const [newPassword, setNewPassword] = React.useState("");
  const [reNewPassword, setReNewPassword] = React.useState("");

  const handleLogOut = () => {
    setModalVisible(false);
    setToken(null);
    setCurrentUser(null);
    AsyncStorage.removeItem('studentToken');
    AsyncStorage.removeItem('maSinhVien');
    navigation.navigate("AuthenticationPage");
  }
  const handleCurrentPasswordChange = React.useCallback((newText) => {
    setCurrentPassword(newText);
  }, []);
  const handleNewPasswordChange = React.useCallback((newText) => {
    setNewPassword(newText);
  }, []);
  const handleReNewPasswordChange = React.useCallback((newText) => {
    setReNewPassword(newText);
  }, []);
  const changePassword = async () => {
    if(currentPassword.length < 8 || currentPassword.length > 255) {
      Toast.show({
        type: 'error',
        text1: 'Mật khẩu hiện tại',
        text2: 'Trường nhập mật khẩu hiện tại không hợp lệ!'
      });
      return;
    }
    if(newPassword.length < 8 || reNewPassword.length <8) {
      Toast.show({
        type: 'error',
        text1: 'Mật khẩu mới',
        text2: 'Trường nhập mật khẩu mới không hợp lệ!'
      });
      return;
    }
    if(newPassword !== reNewPassword) {
      Toast.show({
        type: 'error',
        text1: 'Nhập lại mật khẩu mới',
        text2: 'Nhập lại mật khẩu mới không trùng khớp!'
      });
      return;
    }
    // Handle change password here...
    const ChangePasswordRequestDTO = {
      oldPassword: currentPassword,
      newPassword: reNewPassword,
    }
    try {
      const response = await axios.post(LOCAL_JAVA_API_URL+"/api/change-password", ChangePasswordRequestDTO, {headers: {"Authorization": token}});
      if(response.data) {
        Toast.show({
          type: 'success',
          text1: 'Thay đổi mật khẩu thành công',
          text2: 'Hãy sử dụng mật khẩu mới cho lần đăng nhập kế!'
        });
        setOptionModalVisible(false);
      }
    } catch (error) {
      console.error(error);
      Toast.show({
        type: 'error',
        text1: 'Thay đổi mật khẩu thất bại',
        text2: 'Mật khẩu hiện tại không chính xác!'
      });
    }
  }
  React.useEffect(() => {
    const getInitials = async () => {
      // . Fetch init data
      const javaIp = await publicIP();
      const response2 = await axios.get(LOCAL_JAVA_API_URL+"/api/pattern/getSoTinChiDoneByStudentId/" + currentUser.maSinhVien, {headers: {"Authorization": token}});//Sử lý số tín chỉ đã đạt của sv
      const response3 = await axios.get(LOCAL_JAVA_API_URL+"/api/semester/getTongSoTinChiByMaNganh/" + currentUser.lopHocDanhNghia.nganh.maNganh, {headers: {"Authorization": token}});//Sử lý tổng tín chỉ của sv
      setCurrentTinChi(response2.data);
      setRequiredTinChi(response3.data);
    }
    getInitials();
  },[]);

  function formatDate(date){
      let mydate = new Date(date);
      let d = mydate.getDate();
      let m = mydate.getMonth() + 1;
      let y = mydate.getFullYear();
      return (d <= 9 ? '0' + d : d) + "/" + (m<=9 ? '0' + m : m) + "/" + y;
  }
  function calEndYearStudent(namBatDau, bacDaoTao) {
      if(bacDaoTao == 'DAI_HOC')
          return Number(namBatDau) + 4;
      if(namBatDau == 'CAO_DANG')
          return Number(namBatDau) + 3;
      return namBatDau;
  }
  
  return (
    <NativeBaseProvider>
      <Box zIndex="1"><Toast position='top' /></Box>
      <ScrollView>
        <Box flex="1">
            <HStack alignItems="center" justifyContent="space-between">
              <Box>
                <Text>Trang chủ -</Text>
                <Text bold>Sinh viên</Text>
              </Box>
              <Box>
                <Image source={{ uri: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bf/Logo_IUH.png/320px-Logo_IUH.png" }} alt="iuh-logo" width={"32"} height={"16"} />
              </Box>
              <Box>
                <Pressable onPress={() => setOptionModalVisible(true)}>
                  <Center>
                      <FontAwesome5 name="user-circle" size={24} color="blue" />
                      <Text underline>Tài khoản</Text>
                  </Center>
                </Pressable>
              </Box>
            </HStack>
            <Center>
                <Divider my="2" _light={{
                      bg: "gray.500"
                    }} _dark={{
                      bg: "muted.50"
                    }}
                    w="75%"
                />
            </Center>
            <Box borderColor={'gray.500'} borderWidth="0.5" borderRadius={'sm'} mt="2" mx="2"  py="5" px="2">
                <Text bold>Thông tin sinh viên</Text>
                <Divider my="3"></Divider>
                <Center>
                  <Image
                    size={150}
                    borderRadius={100}
                    source={{uri: currentUser.avatar}}
                    alt="photoUrl"
                  />
                  <Text color="blue.700" underline onPress={() => setStudentInfoVisible(!studentInfoVisible)} py="2">Xem chi tiết</Text>
                </Center>
                <Box>
                  <HStack>
                    <Box w='1/2'>
                      <Text fontSize="xs"><Text bold>MSSV:</Text> <Text color="darkBlue.900">{currentUser.maSinhVien}</Text></Text>
                      <Text fontSize="xs"><Text bold>Họ tên</Text>: <Text color="darkBlue.900">{currentUser.hoTen}</Text></Text>
                      <Text fontSize="xs"><Text bold>Giới tính</Text>: <Text color="darkBlue.900">{currentUser.gioiTinh}</Text></Text>
                      <Text fontSize="xs"><Text bold>Ngày sinh</Text>: <Text color="darkBlue.900">{formatDate(currentUser.ngaySinh)}</Text></Text>
                      <Text fontSize="xs"><Text bold>Nơi sinh</Text>: <Text color="darkBlue.900">{currentUser.noiSinh}</Text></Text>
                    </Box>
                    <Box w='1/2'>
                      <Text fontSize="xs"><Text bold>Lớp học:</Text> <Text color="darkBlue.900">{currentUser.lopHocDanhNghia.tenLop}</Text></Text>
                      <Text fontSize="xs"><Text bold>Khoá học</Text>: <Text color="darkBlue.900">{currentUser.lopHocDanhNghia.khoaHoc.namBatDau}-{calEndYearStudent(currentUser.lopHocDanhNghia.khoaHoc.namBatDau, currentUser.daoTao.bacDaoTao)}</Text></Text>
                      <Text fontSize="xs"><Text bold>Bậc đào tạo</Text>: <Text color="darkBlue.900">{bacDaoTaoShortCut[currentUser.daoTao.bacDaoTao]}</Text></Text>
                      <Box flexDirection={"row"}>
                        <Text fontSize="xs" flex={"1"} flexWrap="wrap"><Text bold>Loại hình đào tạo</Text>: <Text color="darkBlue.900">{loaiHinhDaoTaoShortCut[currentUser.daoTao.loaiHinhDaoTao]}</Text></Text>
                      </Box>
                      <Box flexDirection={"row"}>
                        <Text fontSize="xs" flex={"1"} flexWrap="wrap"><Text bold>Ngành</Text>: <Text color="darkBlue.900">{currentUser.lopHocDanhNghia.nganh.tenNganh}</Text></Text>
                      </Box>
                    </Box>
                  </HStack>
                </Box>
            </Box>

            {/* Chart pie */}
            <Box borderWidth="1" borderColor="coolGray.400" borderRadius="lg" p="2" mt="2" mx="2">
              <Text>Tiến độ học tập:</Text>
              <HStack>
                <Box w="1/2">
                  <ProgressChart
                    data={{labels: ["Số TC", "Tổng"], data: [(currentTinChi / requiredTinChi), 1]}}
                    width={width/2}
                    height={110}
                    strokeWidth={16}
                    radius={32}
                    chartConfig={chartConfig}
                    hideLegend={true}
                  />
                </Box>
                <Box w="1/2">
                    <Text fontSize="xs" flexWrap="wrap"><Text bold>Số tín chỉ hoàn thành</Text>: <Text color="teal.900">{currentTinChi > 10 ? currentTinChi : '0'+currentTinChi}</Text></Text>
                    <Text fontSize="xs" flexWrap="wrap"><Text bold>Tổng tín chỉ cần thiết</Text>: <Text color="teal.900">{requiredTinChi}</Text></Text>
                    <Text fontSize="xs" flexWrap="wrap"><Text bold>Đã hoàn thành</Text>: <Text color="teal.900">{(currentTinChi*100/requiredTinChi).toFixed(1)}%</Text></Text>
                </Box>
              </HStack>
            </Box>

            {/* Số dư ví */}
            <Box borderWidth="1" borderColor="coolGray.400" borderRadius="lg" p="2" mt="2" mx="2">
              <Pressable onPress={() => navigation.navigate("RechargePage")}>
                <Center>
                  <MaterialIcons name="attach-money" size={24} color="orange" />
                  <Text fontSize="xs">Số dư Ví (vnđ)</Text>
                  <Text fontSize="3xl" color="green.600">{formatNumber(currentUser.soDu)}</Text>
                </Center>
              </Pressable>
            </Box>

            <Box borderWidth="1" borderColor="coolGray.400" borderRadius="lg" p="2" mt="2" mx="2" flex="1" alignItems="center" justifyContent="center" display="flex">
              <Text fontSize="xs" bold underline>Feature:</Text>
              <HStack p="3" space="5" justifyContent="space-evenly">
                  <Box borderWidth="0.5" borderColor={'gray.300'} p="3" px="5" display="flex" alignItems="center" justifyContent="center">
                      <MaterialCommunityIcons name="calendar-multiple-check" size={32} color="purple" onPress={() => navigation.navigate("Timetable")} />
                      <Text color="success.700" onPress={() => navigation.navigate("Timetable")}>Xem lịch</Text>
                      <Text color="success.700" onPress={() => navigation.navigate("Timetable")}>trong tuần</Text>
                  </Box>
                  <Box borderWidth="0.5" borderColor={'gray.300'} p="3" px="5" display="flex" alignItems="center" justifyContent="center">
                        <AntDesign name="CodeSandbox" size={32} color="purple" onPress={() => navigation.navigate("DkhpPage")} />
                        <Text color="success.700" onPress={() => navigation.navigate("DkhpPage")}>Đăng ký</Text>
                        <Text color="success.700" onPress={() => navigation.navigate("DkhpPage")}>học phần</Text>
                  </Box>
              </HStack>
              <HStack p="3" space="5" justifyContent="space-evenly">
                  <Box borderWidth="0.5" borderColor={'gray.300'} p="3" px="5" display="flex" alignItems="center" justifyContent="center">
                      <FontAwesome5 name="cc-apple-pay" size={32} color="purple" onPress={() => navigation.navigate("DebtPage")} />
                      <Text color="success.700" onPress={() => navigation.navigate("DebtPage")}>Thanh toán</Text>
                      <Text color="success.700" onPress={() => navigation.navigate("DebtPage")}>học phí</Text>
                  </Box>
                  <Box borderWidth="0.5" borderColor={'gray.300'} p="3" px="5" display="flex" alignItems="center" justifyContent="center">
                      <MaterialCommunityIcons name="hand-coin" size={32} color="purple" onPress={() => navigation.navigate("RechargePage")} />
                      <Text color="success.700" onPress={() => navigation.navigate("RechargePage")}>Nạp tiền</Text>
                      <Text color="success.700" onPress={() => navigation.navigate("RechargePage")}>vào ví</Text>
                  </Box>
              </HStack>
            </Box>
            <Box>
              {" "}
            </Box>
            <Box>
              {" "}
            </Box>
            <Box position="absolute" bottom="0">
                <HStack>
                  <Text fontSize="xs">ErukaLearn (sv.el.com)</Text>
                  <Divider bg="emerald.500" thickness="2" mx="2" orientation="vertical" />
                  <Text fontSize="xs">No.</Text>
                  <MaterialIcons name="copyright" size={15} color="black" />
                  <Text fontSize="xs">opy right 2023</Text>
                  <Divider bg="emerald.500" thickness="2" mx="2" orientation="vertical" />
                  <Text fontSize="xs">Secure <AntDesign name="Safety" size={15} color="blue" /></Text>
                </HStack>
            </Box>
        </Box>
      </ScrollView>
      <Modal isOpen={optionModalVisible} onClose={setOptionModalVisible} size={"lg"}>
        <Modal.Content>
          <Modal.CloseButton />
          <Modal.Header>Tài khoản</Modal.Header>
          <Modal.Body>
            <ScrollView>
              <Box py="2">
                <Text>Mật khẩu hiện tại: <Text color="error.600">*</Text> </Text>
                <Input
                  placeholder='Nhập mật khẩu hiện tại của bạn..'
                  type={showPassword ? "text" : "password"}
                  InputRightElement={
                    <Pressable onPress={() => setShowPassword(!showPassword)}>
                      <Icon
                        as={<MaterialIcons name={showPassword ? "visibility" : "visibility-off"} />}
                        size={5}
                        mr="2"
                        color="muted.400"
                      />
                    </Pressable>
                  }
                  value={currentPassword}
                  onChangeText={handleCurrentPasswordChange}
                />
              </Box>
              <Box py="2">
                <Text>Mật khẩu mới: <Text color="error.600">*</Text> </Text>
                <Input
                  placeholder='Nhập mật khẩu mói muốn thay đổi..'
                  type={showPassword ? "text" : "password"}
                  InputRightElement={
                    <Pressable onPress={() => setShowPassword(!showPassword)}>
                      <Icon
                        as={<MaterialIcons name={showPassword ? "visibility" : "visibility-off"} />}
                        size={5}
                        mr="2"
                        color="muted.400"
                      />
                    </Pressable>
                  }
                  value={newPassword}
                  onChangeText={handleNewPasswordChange}
                />
              </Box>
              <Box py="2">
                <Text>Xác nhận Mật khẩu mới: <Text color="error.600">*</Text> </Text>
                <Input
                  placeholder='Nhập lại mật khẩu mói muốn thay đổi..'
                  type={showPassword ? "text" : "password"}
                  InputRightElement={
                    <Pressable onPress={() => setShowPassword(!showPassword)}>
                      <Icon
                        as={<MaterialIcons name={showPassword ? "visibility" : "visibility-off"} />}
                        size={5}
                        mr="2"
                        color="muted.400"
                      />
                    </Pressable>
                  }
                  value={reNewPassword}
                  onChangeText={handleReNewPasswordChange}
                />
              </Box>
              <Button variant="outline" bg="emerald.400" _text={{ color: 'white' }} onPress={changePassword}>Đổi mật khẩu</Button>
            </ScrollView>
          </Modal.Body>
          <Modal.Footer>
            <Button.Group space={2}>
              <Button variant="ghost" colorScheme="blueGray" onPress={() => {
              setOptionModalVisible(false);
            }}>
                Cancel
              </Button>
              <Button
                onPress={() => {handleLogOut()}}
                bg="emerald.600"
              >
                Logout
              </Button>
            </Button.Group>
          </Modal.Footer>
        </Modal.Content>
      </Modal>
      <Modal isOpen={studentInfoVisible} onClose={setStudentInfoVisible} size={"lg"}>
        <Modal.Content>
          <Modal.CloseButton />
          <Modal.Header>Thông tin sinh viên</Modal.Header>
          <Modal.Body>
            <ScrollView>
              <Box pb="3">
                <HStack>
                  <Box pr="3">
                    <Image source={{ uri:currentUser.avatar }} alt="photoUrl" size={8} borderRadius={100} />
                  </Box>
                  <Box borderLeftColor="gray.500" borderLeftWidth="0.5" pl="3">
                    <Text bold color="emerald.700">THÔNG TIN HỌC VẤN</Text>
                    <Divider></Divider>
                    <Text><Text bold>MSSV</Text>: #{currentUser.maSinhVien}</Text>
                    <Text><Text bold>Họ tên</Text>: {currentUser.hoTen}</Text>
                    <Text><Text bold>Lớp học</Text>: {currentUser.lopHocDanhNghia.tenLop}</Text>
                    <Text><Text bold>Trạng thái</Text>: Đang học</Text>
                    <Text><Text bold>Thuộc khoa</Text>: {currentUser.lopHocDanhNghia.nganh.khoa.tenKhoa}</Text>
                    <Text><Text bold>Chuyên ngành</Text>: {currentUser.lopHocDanhNghia.nganh.tenNganh}</Text>
                    <Text><Text bold>Ngày vào trường</Text>: {formatDate(currentUser.ngayVaoTruong)}</Text>
                    <Text><Text bold>Cơ sở học</Text>: {coSoShortCut[currentUser.daoTao.coSo]}</Text>
                    <Text><Text bold>Loại hình đào tạo</Text>: {loaiHinhDaoTaoShortCut[currentUser.daoTao.loaiHinhDaoTao]}</Text>
                    <Text><Text bold>Khoá học</Text>: {currentUser.lopHocDanhNghia.khoaHoc.namBatDau}-{calEndYearStudent(currentUser.lopHocDanhNghia.khoaHoc.namBatDau, currentUser.daoTao.bacDaoTao)}</Text>
                    <Text><Text bold>Mã hồ sơ</Text>: #{currentUser.taiKhoan.id}</Text>
                  </Box>
                </HStack>
              </Box>
              <Box pb="3">
                <HStack>
                  <Box pr="3">
                    <FontAwesome5 name="info-circle" size={30} color="aqua" />
                  </Box>
                  <Box borderLeftColor="gray.500" borderLeftWidth="0.5" pl="3">
                    <Text bold color="emerald.700">THÔNG TIN CÁ NHÂN</Text>
                    <Divider></Divider>
                    <Text><Text bold>Ngày sinh</Text>: 25/05/2001 (21 tuổi)</Text>
                    <Text><Text bold>Số CMND/CCCD</Text>: 079201030774</Text>
                    <Text><Text bold>Ngày cấp</Text>: 13/08/2018</Text>
                    <Text><Text bold>Nơi cấp</Text>: Cục CSQL Ctr&Dc</Text>
                    <Text><Text bold>Đối tượng</Text>: Con thương binh liệt sĩ</Text>
                    <Text><Text bold>Diện chính sách</Text>: Hộ nghèo miền trung</Text>
                    <Text><Text bold>Ngày vào đoàn</Text>: 01/01/2018</Text>
                    <Text><Text bold>Ngày vào đảng</Text>: 01/01/2018</Text>
                    <Text><Text bold>Dân tộc</Text>: Kinh</Text>
                    <Text><Text bold>Tôn giáo</Text>: Phật giáo</Text>
                    <Text><Text bold>Điện thoại</Text>: (+84) 0338188506</Text>
                    <Text><Text bold>Địa chỉ liên hệ</Text>: 60/122, Tổ 10, Kp 8, P.Tân Chánh Hiệp, Quận 12, Tp.HCM</Text>
                    <Text><Text bold>Hộ khẩu thường trú</Text>: 52/367 Quang Trung, Phường 12, Quận Gò Vấp, Thành phố Hồ Chí Minh</Text>
                    <Text><Text bold>Email</Text>: taito1doraemon@gmail.com</Text>
                    <Text><Text bold>Quốc tịch</Text>: Việt Nam</Text>
                  </Box>
                </HStack>
              </Box>
              <Box pb="3">
                <HStack>
                  <Box pr="3">
                    <FontAwesome name="users" size={30} color="pink" />
                  </Box>
                  <Box borderLeftColor="gray.500" borderLeftWidth="0.5" pl="3">
                    <Text bold color="emerald.700">QUAN HỆ GIA ĐÌNH</Text>
                    <Divider></Divider>
                    <Text><Text bold>Cha/người nuôi dưỡng</Text>: Phan Sơn</Text>
                    <Text><Text bold>Năm sinh</Text>: 1979</Text>
                    <Text><Text bold>Nghề nghiệp</Text>: Buôn bán</Text>
                    <Text><Text bold>Quốc tịch</Text>: VN</Text>
                    <Text><Text bold>Dân tộc</Text>: Kinh</Text>
                    <Text><Text bold>Tôn giáo</Text>: Phật giáo</Text>
                    <Text><Text bold>Cơ quan công tác</Text>: Tại nhà</Text>
                    <Text><Text bold>Chức vụ</Text>: Không</Text>
                    <Text><Text bold>Số điện thoại</Text>: (+84) 0384195098</Text>
                    <Text><Text bold>Hộ khẩu</Text>: Gò Vấp</Text>
                    <Text><Text bold>Chỗ ở hiện nay</Text>: Tại nhà</Text>
                    <Divider></Divider>
                    <Text><Text bold>Mẹ/người nuôi dưỡng</Text>: Trần Thị Hạnh</Text>
                    <Text><Text bold>Năm sinh</Text>: 1973</Text>
                    <Text><Text bold>Nghề nghiệp</Text>: Buôn bán</Text>
                    <Text><Text bold>Quốc tịch</Text>: VN</Text>
                    <Text><Text bold>Dân tộc</Text>: Kinh</Text>
                    <Text><Text bold>Tôn giáo</Text>: Phật giáo</Text>
                    <Text><Text bold>Cơ quan công tác</Text>: Tại nhà</Text>
                    <Text><Text bold>Chức vụ</Text>: Không</Text>
                    <Text><Text bold>Số điện thoại</Text>: (+84) 0329139871</Text>
                    <Text><Text bold>Hộ khẩu</Text>: Gò Vấp</Text>
                    <Text><Text bold>Chỗ ở hiện nay</Text>: Tại nhà</Text>
                  </Box>
                </HStack>
              </Box>
            </ScrollView>
          </Modal.Body>
          <Modal.Footer>
            <Button.Group space={2}>
              <Button variant="ghost" colorScheme="blueGray" onPress={() => {
              setStudentInfoVisible(false);
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

export default Homepage;