import axios from 'axios';
import { Box, NativeBaseProvider, Text, Image, Center, Input, Button, Modal } from 'native-base';
import React from 'react';
import { AuthContext } from '../Providers/AuthProvider';
import Toast from 'react-native-toast-message';
import publicIP from 'react-native-public-ip';
import AsyncStorage from '@react-native-async-storage/async-storage';
import { LOCAL_JAVA_API_URL } from '@env';
import { JAVA_PORT } from '@env';
const AuthenticationPage = ({ navigation }) => {

  const { setToken, currentUser, setCurrentUser } = React.useContext(AuthContext);
  const [showModal, setShowModal] = React.useState(false);
  const [maSinhVien, setmaSinhVien] = React.useState("1");
  const [password, setPassword] = React.useState("123123az");
  const [isButtonDisabled, setIsButtonDisabled] = React.useState(false);
  const JAVA_API_URL = LOCAL_JAVA_API_URL + ":" + JAVA_PORT;
  const getAsyncStorage = async () => {
    try {
      setIsButtonDisabled(true);
      const studentToken = await AsyncStorage.getItem('studentToken');
      const maSinhVien = await AsyncStorage.getItem('maSinhVien');
      if (studentToken, maSinhVien) {
        const javaIp = await publicIP();
        const response = await axios.get(JAVA_API_URL+"/api/student/getStudentById/"+maSinhVien, {headers: {"Authorization": studentToken}});
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
      getAsyncStorage();
    });
    return unsubscribe;
  }, [navigation]);

  React.useEffect(() => {
    if(!currentUser) {
      getAsyncStorage();
    }
  },[currentUser]);

  const handleLogin = async () => {
    try {
      setIsButtonDisabled(true);
      if(maSinhVien != "" && password !== "") {
        const userDTO = {username: "sv"+maSinhVien, password};
        const javaIp = await publicIP();
        const response = await axios.post(JAVA_API_URL+"/api/login", userDTO);
        if(response.data) {
            setToken(response.data);
            const response2 = await axios.get(JAVA_API_URL+"/api/student/getStudentById/"+maSinhVien, {headers: {"Authorization": response.data}});
            setCurrentUser(response2.data);
            Toast.show({
                type: 'success',
                text1: 'Login successfully',
                text2: 'We"ll redirect you soon.. Please wait!'
            });
            AsyncStorage.setItem('studentToken', response.data);
            AsyncStorage.setItem('maSinhVien', maSinhVien);
            setTimeout(() => {
              navigation.navigate("Homepage");
            }, 500);
        }
      }
    } catch (error) {
      console.log({ error });
      setIsButtonDisabled(false);
    }
  }

  return (
    <NativeBaseProvider>
    <Box zIndex="1"><Toast position='top' /></Box>
        <Box flex="1" p="5">
            <Box margin="auto" w="100%">
                <Box>
                    <Image source={{ uri: "https://images.cooltext.com/5648011.png" }} alt="el-logo-gv" width={'100%'} height={'16'} />
                </Box>
                <Box borderWidth="1" borderColor="light.400" padding="5" borderRadius="2xl" mt={'1'}>
                    <Text>Mã sinh viên:</Text>
                    <Input placeholder='Mã xác định giáo viên được cấp' onChangeText={(e) => setmaSinhVien(e)} value={maSinhVien} />
                    <Text>Mật khẩu:</Text>
                    <Input placeholder='Vui lòng nhập vào mật khẩu...' type='password' onChangeText={(e) => setPassword(e)} value={password} />
                    <Button disabled={isButtonDisabled} onPress={() => handleLogin()} bg="warning.500">Đăng nhập tài khoản</Button>
                    <Center><Text color="info.700" onPress={() => setShowModal(true)}>Quên mật khẩu?</Text></Center>
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