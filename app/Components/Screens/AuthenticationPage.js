import axios from 'axios';
import { Box, NativeBaseProvider, Text, Image, Center, Input, Button, Modal, useColorMode, Switch, HStack } from 'native-base';
import React from 'react';
import { AuthContext } from '../Providers/AuthProvider';
import Toast from 'react-native-toast-message';
import publicIP from 'react-native-public-ip';
import AsyncStorage from '@react-native-async-storage/async-storage';
import { LOCAL_JAVA_API_URL } from '@env';
import NetInfo from "@react-native-community/netinfo";
import { FontAwesome, Ionicons, MaterialCommunityIcons } from '@expo/vector-icons';

const AuthenticationPage = ({ navigation }) => {

  const { setToken, currentUser, setCurrentUser } = React.useContext(AuthContext);
  const [showModal, setShowModal] = React.useState(false);
  const [maSinhVien, setmaSinhVien] = React.useState("19524791");
  const [password, setPassword] = React.useState("123123az");
  const [isButtonDisabled, setIsButtonDisabled] = React.useState(false);
  const [switchValue, setSwitchValue] = React.useState(true);
  const [network, setNetwork] = React.useState(true);

  const checkInternetConnection = async () => {
    const netInfo = await NetInfo.fetch();
    return netInfo.isConnected;
  };

  const toggleSwitch = (val) => {
    setSwitchValue(val);
  };

  const initSkeleton = async () => {
    const isConnected = await checkInternetConnection();
    if(!isConnected) {
      setNetwork(false);
      return;
    }
    try {
      setIsButtonDisabled(true);
      const studentToken = await AsyncStorage.getItem('studentToken');
      const maSinhVien = await AsyncStorage.getItem('maSinhVien');
      if (studentToken, maSinhVien) {
        const javaIp = await publicIP();
        const response = await axios.get(LOCAL_JAVA_API_URL+"/api/student/getStudentById/"+maSinhVien, {headers: {"Authorization": studentToken}});
        if(response.data) {//Nếu có dataStudent trả về là token còn dùng dcs
          setToken(studentToken);
          setCurrentUser(response.data);
          Toast.show({
            type: 'success',
            text1: 'Tự động đăng nhập',
            text2: 'We"ll redirect you soon.. Please wait!'
          });
          setTimeout(() => {
            navigation.navigate("Homepage");
          }, 100);
        }
      } else {
        setIsButtonDisabled(false);
      }
    } catch (error) {
      console.log({ error });
      setIsButtonDisabled(false);
    }
  }

  React.useEffect(() => {
    const unsubscribe = navigation.addListener('focus', () => {
      // Do something here to re-render PageOne, for example:
      console.log("PageOne is focused");
      initSkeleton();
    });
    return unsubscribe;
  }, [navigation]);

  React.useEffect(() => {
    if(!currentUser) {
      initSkeleton();
    }
  },[currentUser]);

  const handleLogin = async () => {
    if(!network) {
      Toast.show({
        type: 'error',
        text1: 'Network connection',
        text2: 'Không có kết nối internet!'
      });
      return;
    }
    try {
      if(maSinhVien == "") {
        Toast.show({
          type: 'error',
          text1: 'Mã sinh viên',
          text2: 'Vui lòng nhập vào mã sinh viên!'
        });
        return;
      }
      if(password == "") {
        Toast.show({
          type: 'error',
          text1: 'Mật khẩu',
          text2: 'Vui lòng nhập vào mật khẩu!'
        });
        return;
      }
      setIsButtonDisabled(true);
      const userDTO = {username: "sv"+maSinhVien, password};
      const javaIp = await publicIP();
      const response = await axios.post(LOCAL_JAVA_API_URL+"/api/login", userDTO);
      if(response.data) {
          setToken(response.data);
          const response2 = await axios.get(LOCAL_JAVA_API_URL+"/api/student/getStudentById/"+maSinhVien, {headers: {"Authorization": response.data}});
          
          setCurrentUser(response2.data);
          Toast.show({
            type: 'success',
            text1: 'Login successfully',
            text2: 'We"ll redirect you soon.. Please wait!'
          });
          if(switchValue) {
            AsyncStorage.setItem('studentToken', response.data);
            AsyncStorage.setItem('maSinhVien', maSinhVien);
          }
          setTimeout(() => {
            navigation.navigate("Homepage");
          }, 500);
      } else {
        Toast.show({
          type: 'error',
          text1: 'Sai mã sinh viên hoặc mật khẩu',
          text2: 'Vui lòng thử đăng nhập lại!'
        });
        setIsButtonDisabled(false);
      }
    } catch (error) {
      console.log({ error });
      setIsButtonDisabled(false);
    }
  }

  return (
    <NativeBaseProvider>
    <Box zIndex="1"><Toast position='top' /></Box>
      {
        !network &&
        <Box position="absolute" width="100%" top="0">
          <Center>
            <Text><FontAwesome name="close" size={15} color="red" /> Kết nối internet không khả dụng <MaterialCommunityIcons name="wifi-alert" size={15} color="red" />. Tuy nhiên bạn vẫn có thể xem lịch học đồng bộ trước đó.</Text>
            <Text fontSize="lg" underline>Xem lịch học</Text>
          </Center>
      </Box>
      }
      <Box flex="1" p="5">
          <Box margin="auto" w="100%">
              <Box>
                  <Image source={ require(`../../images/student-logo-authen.png`) } alt="el-logo-gv" />
              </Box>
              <Box borderWidth="1" borderColor="light.400" padding="5" borderRadius="2xl" mt={'1'}>
                  <Text>Mã sinh viên:</Text>
                  <Input placeholder='Mã xác định giáo viên được cấp' onChangeText={(e) => setmaSinhVien(e)} value={maSinhVien} />
                  <Text>Mật khẩu:</Text>
                  <Input placeholder='Vui lòng nhập vào mật khẩu...' type='password' onChangeText={(e) => setPassword(e)} value={password} />
                  <Button disabled={isButtonDisabled} onPress={() => handleLogin()} bg="warning.500">Đăng nhập tài khoản</Button>
                  {/* <Center><Text color="info.700" onPress={() => setShowModal(true)}>Quên mật khẩu?</Text></Center> */}
                  {" "}
                  <Box>
                    <HStack justifyContent="space-between">
                      <HStack alignItems="center">
                        <Switch
                          size="sm"
                          colorScheme="emerald"
                          onToggle={(val) => toggleSwitch(val)}
                          isChecked={switchValue}
                        />
                        <Text> Lưu mật khẩu</Text>
                      </HStack>
                      <Box>
                        <Text color="info.700" onPress={() => setShowModal(true)}>Quên mật khẩu?</Text>
                      </Box>
                    </HStack>
                  </Box>
                  <Modal isOpen={showModal} onClose={() => setShowModal(false)}>
                      <Modal.Content maxWidth="400px">
                        <Modal.CloseButton />
                        <Modal.Header><Text fontWeight="bold">Trợ giúp `Quên mật khẩu`</Text></Modal.Header>
                        <Modal.Body>
                            <Text><Text fontWeight="bold">1.</Text> Tài khoản không thể lấy lại mật khẩu theo các thông thường tương tác với hệ thống.</Text>
                            <Text><Text fontWeight="bold">2.</Text> Vui lòng gặp trức tiếp giáo vụ khoa bạn trực thuộc hoặc giáo vụ tại phòng đào tạo hoặc giáo viên chu nhiệm để được hỗ trợ lấy lấy mật khẩu sớm nhất.</Text>
                            <Text><Text fontWeight="bold">3.</Text> Liên hệ SĐT: (+84) 0338188506 <Text fontStyle={'italic'}>(Giáo vụ PĐT)</Text> để được hỗ trợ.</Text>
                        </Modal.Body>
                        <Modal.Footer>
                          <Button.Group space={2}>
                            <Button variant="ghost" colorScheme="blueGray" onPress={() => {
                              setShowModal(false);
                            }}>
                              Đóng lại
                            </Button>
                          </Button.Group>
                        </Modal.Footer>
                      </Modal.Content>
                  </Modal>
              </Box>
          </Box>
      </Box>
    </NativeBaseProvider>
    
  )
};

export default AuthenticationPage;