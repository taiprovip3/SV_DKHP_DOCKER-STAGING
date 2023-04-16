import React from 'react';
import publicIP from 'react-native-public-ip';
import { Box, Button, Center, HStack, Image, NativeBaseProvider, Text } from 'native-base';
import { Entypo } from '@expo/vector-icons';
import { AuthContext } from '../Providers/AuthProvider';

export default function UserInfo({ navigation }) {

    const { setCurrentUser, setToken } = React.useContext(AuthContext);

    React.useEffect(() => {
        const myFunc = async () => {
            const ipMe = await publicIP();
            return ipMe;
        }
    },[]);

    const logout = () => {
        setCurrentUser(null);
        setToken(null);
        navigation.navigate("AuthenticationPage");
    }

  return (
    <NativeBaseProvider>
        <Box flex="1">
            <Box mt="3">
                <Center>
                    <Image source={{
                    uri: "https://daihoctantrao.edu.vn/media/news/1(205).jpg"
                    }} alt="Alternate Text" size="lg" borderRadius={150} />
                    <Text color="blue.900">Ảnh 3x4</Text>
                </Center>
            </Box>
            <Box flex="1">
                <HStack>
                    <Box w="1/2">
                        <Box display="flex" alignItems="center" flexDirection="row">
                            <Entypo name="dot-single" size={24} color="black" />
                            <Text><Text bold>Họ tên:</Text> <Text color="gray.600" fontSize="xs">Lê Tân Trào</Text></Text>
                        </Box>
                        <Box display="flex" alignItems="center" flexDirection="row">
                            <Entypo name="dot-single" size={24} color="black" />
                            <Text><Text bold>Năm sinh:</Text> <Text color="gray.600" fontSize="xs">1972</Text></Text>
                        </Box>
                        <Box display="flex" alignItems="center" flexDirection="row">
                            <Entypo name="dot-single" size={24} color="black" />
                            <Text><Text bold>Giới tính:</Text> <Text color="gray.600" fontSize="xs">Nam</Text></Text>
                        </Box>
                        <Box display="flex" alignItems="center" flexDirection="row">
                            <Entypo name="dot-single" size={24} color="black" />
                            <Text><Text bold>Địa chỉ:</Text> <Text color="gray.600" fontSize="xs">60/122 To 10 KP8 Phuong TCH Q12 TP.HCM</Text></Text>
                        </Box>
                        <Box display="flex" alignItems="center" flexDirection="row">
                            <Entypo name="dot-single" size={24} color="black" />
                            <Text><Text bold>SĐT:</Text> <Text color="gray.600" fontSize="xs">0338188506</Text></Text>
                        </Box>
                        <Box display="flex" alignItems="center" flexDirection="row">
                            <Entypo name="dot-single" size={24} color="black" />
                            <Text><Text bold>Email:</Text> <Text color="gray.600" fontSize="xs">letantrao@gmail.com</Text></Text>
                        </Box>
                    </Box>
                    <Box w="1/2">
                        <Box display="flex" alignItems="center" flexDirection="row">
                            <Entypo name="dot-single" size={24} color="black" />
                            <Text><Text bold>Bậc đào tạo:</Text> <Text color="gray.600" fontSize="xs">Đại học chính quy</Text></Text>
                        </Box>
                        <Box display="flex" alignItems="center" flexDirection="row">
                            <Entypo name="dot-single" size={24} color="black" />
                            <Text><Text bold>Bằng cấp:</Text> <Text color="gray.600" fontSize="xs">Cử nhân</Text></Text>
                        </Box>
                        <Box display="flex" alignItems="center" flexDirection="row">
                            <Entypo name="dot-single" size={24} color="black" />
                            <Text><Text bold>Ngày vào trường:</Text> <Text color="gray.600" fontSize="xs">01/01/2019</Text></Text>
                        </Box>
                        <Box display="flex" alignItems="center" flexDirection="row">
                            <Entypo name="dot-single" size={24} color="black" />
                            <Text><Text bold>Chức vụ:</Text> <Text color="gray.600" fontSize="xs">[giảng viên, giáo vụ, kiểm toán]</Text></Text>
                        </Box>
                        <Box display="flex" alignItems="center" flexDirection="row">
                            <Entypo name="dot-single" size={24} color="black" />
                            <Text><Text bold>Mã giáo viên:</Text> <Text color="gray.600" fontSize="xs">1000082</Text></Text>
                        </Box>
                    </Box>
                </HStack>
            </Box>
            <Box p="4">
                <Button bg="gray.300" variant="outline" onPress={logout}>Đăng xuất</Button>
            </Box>
        </Box>
    </NativeBaseProvider>
  )
}