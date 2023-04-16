import { Box, Button, Center, Divider, HStack, Image, Modal, NativeBaseProvider, Pressable, ScrollView, Stack, Text } from 'native-base';
import React from 'react';
import { FontAwesome5 } from '@expo/vector-icons';
import { MaterialCommunityIcons } from '@expo/vector-icons';
import { MaterialIcons } from '@expo/vector-icons';
import { AuthContext } from '../Providers/AuthProvider';
import { AntDesign } from '@expo/vector-icons';
import { FontAwesome } from '@expo/vector-icons';
import { AppState } from 'react-native';
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
import { formatCurrency } from '../Utilities/formatCurrency';
import { LOCAL_JAVA_API_URL } from '@env';
import { JAVA_PORT } from '@env';
import axios from 'axios';
import publicIP from 'react-native-public-ip';

const Homepage = ({ navigation }) => {
  const JAVA_API_URL = LOCAL_JAVA_API_URL + ":" + JAVA_PORT;
  const { token, setToken, currentUser, setCurrentUser } = React.useContext(AuthContext);
  const { width, height } = useWindowDimensions();
  const [ currentTinChi, setCurrentTinChi ] = React.useState(10);
  const [ requiredTinChi, setRequiredTinChi ] = React.useState(100);

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
  const data = {
    labels: ["Số TC", "Tổng"], // optional
    data: [0.1, 1],
  };

  if(!currentUser && !token) {
    navigation.navigate("AuthenicationPage");
  }
  const [modalVisible, setModalVisible] = React.useState(false);
  const [studentInfoVisible, setStudentInfoVisible] = React.useState(false);

  const handleLogOut = () => {
    setModalVisible(false);
    setToken(null);
    setCurrentUser(null);
    navigation.navigate("AuthenticationPage");
  }
  React.useEffect(() => {
    const getInitials = async () => {
      const javaIp = await publicIP();
      const response2 = await axios.get(JAVA_API_URL+"/api/pattern/getSoTinChiDoneByStudentId/" + currentUser.maSinhVien, {headers: {"Authorization": token}});//Sử lý số tín chỉ đã đạt của sv
      const response3 = await axios.get(JAVA_API_URL+"/api/semester/getTongSoTinChiByMaNganh/" + currentUser.lopHocDanhNghia.nganh.maNganh, {headers: {"Authorization": token}});//Sử lý tổng tín chỉ của sv
      setCurrentTinChi(response2.data);
      setRequiredTinChi(response3.data);
    }
    getInitials();
  },[]);
  
  return (
    <NativeBaseProvider>
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
                    <Pressable onPress={() => setStudentInfoVisible(true)}>
                        <Center>
                            <FontAwesome5 name="user-circle" size={24} color="blue" />
                            <Text underline onPress={() => setModalVisible(!modalVisible)}>Tài khoản</Text>
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
                    source={{uri: "https://pgddttramtau.edu.vn/wp-content/uploads/2022/12/1671593637_38_Mau-anh-the-dep-XUAT-SAC-nhat-voi-nen-xanh.jpg"}}
                    alt="photoUrl"
                  />
                  <Text color="blue.700" underline onPress={() => setStudentInfoVisible(!studentInfoVisible)} py="2">Xem chi tiết</Text>
                </Center>
                <Box>
                  <HStack>
                    <Box w='1/2'>
                      <Text fontSize="xs"><Text bold>MSSV:</Text> <Text color="darkBlue.900">1</Text></Text>
                      <Text fontSize="xs"><Text bold>Họ tên</Text>: <Text color="darkBlue.900">Phan Tấn Tài</Text></Text>
                      <Text fontSize="xs"><Text bold>Giới tính</Text>: <Text color="darkBlue.900">Nam</Text></Text>
                      <Text fontSize="xs"><Text bold>Ngày sinh</Text>: <Text color="darkBlue.900">25/05/2001</Text></Text>
                      <Text fontSize="xs"><Text bold>Nơi sinh</Text>: <Text color="darkBlue.900">Hóc môn</Text></Text>
                    </Box>
                    <Box w='1/2'>
                      <Text fontSize="xs"><Text bold>Lớp học:</Text> <Text color="darkBlue.900">DHKTPM15CTT</Text></Text>
                      <Text fontSize="xs"><Text bold>Khoá học</Text>: <Text color="darkBlue.900">2019-2023</Text></Text>
                      <Text fontSize="xs"><Text bold>Bậc đào tạo</Text>: <Text color="darkBlue.900">Đại học</Text></Text>
                      <Box flexDirection={"row"}>
                        <Text fontSize="xs" flex={"1"} flexWrap="wrap"><Text bold>Loại hình đào tạo</Text>: <Text color="darkBlue.900">Tiên tiến</Text></Text>
                      </Box>
                      <Box flexDirection={"row"}>
                        <Text fontSize="xs" flex={"1"} flexWrap="wrap"><Text bold>Ngành</Text>: <Text color="darkBlue.900">Kỹ thuật phần mềm</Text></Text>
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
      <Modal isOpen={modalVisible} onClose={setModalVisible} size={"sm"}>
        <Modal.Content maxH="212">
          <Modal.CloseButton />
          <Modal.Header>Đăng xuất tài khoản</Modal.Header>
          <Modal.Body>
            <ScrollView>
              <Text>
                Bạn sẽ đăng xuất tài khoản và không lưu lại session cho lần vào ứng dụng kế tiếp
              </Text>
            </ScrollView>
          </Modal.Body>
          <Modal.Footer>
            <Button.Group space={2}>
              <Button variant="ghost" colorScheme="blueGray" onPress={() => {
              setModalVisible(false);
            }}>
                Cancel
              </Button>
              <Button
                onPress={() => {handleLogOut()}}
                bg="orange.400"
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
                    <Image source={{ uri:"https://pgddttramtau.edu.vn/wp-content/uploads/2022/12/1671593637_38_Mau-anh-the-dep-XUAT-SAC-nhat-voi-nen-xanh.jpg" }} alt="photoUrl" size={8} borderRadius={100} />
                  </Box>
                  <Box borderLeftColor="gray.500" borderLeftWidth="0.5" pl="3">
                    <Text bold color="emerald.700">THÔNG TIN HỌC VẤN</Text>
                    <Divider></Divider>
                    <Text><Text bold>MSSV</Text>: 1</Text>
                    <Text><Text bold>Họ tên</Text>: Phan Tấn Tài</Text>
                    <Text><Text bold>Lớp học</Text>: DKTPM15CTT</Text>
                    <Text><Text bold>Trạng thái</Text>: Đang học</Text>
                    <Text><Text bold>Thuộc khoa</Text>: Khoa Công Nghệ Thông Tin</Text>
                    <Text><Text bold>Chuyên ngành</Text>: Kỹ Thuật Phần Mềm</Text>
                    <Text><Text bold>Ngày vào trường</Text>: 01/01/2019</Text>
                    <Text><Text bold>Cơ sở học</Text>: TP.HCM</Text>
                    <Text><Text bold>Loại hình đào tạo</Text>: CLC</Text>
                    <Text><Text bold>Khoá học</Text>: 2019-2023</Text>
                    <Text><Text bold>Mã hồ sơ</Text>: 1000001</Text>
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