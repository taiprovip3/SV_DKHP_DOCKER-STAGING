import React from 'react';
import { Box, Button, Center, Divider, HStack, Icon, Input, Modal, NativeBaseProvider, Pressable, Radio, ScrollView, Text } from 'native-base';
import { FontAwesome, FontAwesome5, MaterialCommunityIcons, MaterialIcons } from '@expo/vector-icons';
import { formatNumber } from '../Utilities/formatNumber';
import { AuthContext } from '../Providers/AuthProvider';
import { AntDesign } from '@expo/vector-icons';
import Toast from 'react-native-toast-message';
import { VND_TRANSACTION_LIMIT } from '@env';
import axios from 'axios';
import { LOCAL_JAVA_API_URL } from '@env';
import { Alert } from 'react-native';
import { formatCurrency } from '../Utilities/formatCurrency';

const RechargePage = ({ navigation }) => {
    
  const { token, currentUser } = React.useContext(AuthContext);
  const [ balanceToRecharge, setBalanceToRecharge] = React.useState('0');
  const [ service, setService ] = React.useState("");
  const [ momoMethodModalVisible, setMomoMethodModalVisible ] = React.useState(false);
  const [ momoMethod, setMomoMethod] = React.useState('MOMO_QR');
  const inputRef = React.useRef(null);
  
  const handleBalanceToRechargeChange = (text) => {
    setBalanceToRecharge(text.nativeEvent.text);
  }

  const confirmTransaction = () => {
    if(!service) {
      Toast.show({
        type: 'error',
        text1: 'Loại thanh toán',
        text2: 'Vui lòng chọn 1 trong các phương thức thanh toán!'
      });
      return;
    }
    if(balanceToRecharge < 50000 || !balanceToRecharge) {
      if(balanceToRecharge == 0) {
        Toast.show({
          type: 'error',
          text1: 'Số tiền nạp',
          text2: 'Vui lòng chọn nhập số tiền muốn nạp ví!'
        });
        return;
      }
      Toast.show({
        type: 'error',
        text1: 'Số tiền nạp',
        text2: 'Tối thiểu phải là ' + formatCurrency(50000)
      });
      return;
    }
    if(isNaN(+balanceToRecharge)) {
      Toast.show({
        type: 'error',
        text1: 'Sai định dạng',
        text2: 'Vui lòng chọn nhập số tiền muốn nạp ví!'
      });
      return;
    }
    if(+balanceToRecharge > VND_TRANSACTION_LIMIT) {
      Toast.show({
        type: 'error',
        text1: 'Số tiền giao dịch vượt Hạn mức',
        text2: 'Vui lòng chọn nhập số tiền <= ' + VND_TRANSACTION_LIMIT + '!'
      });
      return;
    }
    if(service === "MOMO - WALLET") {
      setMomoMethodModalVisible(true);
    } else {
      handlePayout();
    }
  }
  
  const handlePayout = async () => {
    const balanceGiaoDich = +balanceToRecharge;
    Alert.alert(
      'Xác nhận',
      'Đồng ý thanh toán với số tiền là: ' + formatCurrency(balanceGiaoDich) + '?',
      [
        {
          text: 'Không',
          onPress: () => console.log('Cancel Pressed'),
          style: 'cancel'
        },
        { 
          text: 'Có', 
          onPress: async () => {
            console.log('OK Pressed');
            const maSinhVien = currentUser.maSinhVien;
            const maThanhToanGiaoDichReponse = await axios.get(LOCAL_JAVA_API_URL+"/api/payment/createTransaction/"+currentUser.maSinhVien+"/"+0+"/Array", {headers: {"Authorization": token}});
            const maThanhToanGiaoDich = maThanhToanGiaoDichReponse.data;
            // const maThanhToanGiaoDich = "0tYr3oi3";
            const rechargeData = {service,momoMethod,balanceGiaoDich,maSinhVien,maThanhToanGiaoDich};
            navigation.navigate("TopupPage", { rechargeData });
          },
        }
      ]
    );
  }
  return (
    <NativeBaseProvider>
      <Box zIndex="1"><Toast position='top' /></Box>
      <ScrollView>
        <Box borderWidth="1" borderColor="coolGray.400" borderRadius="lg" p="2" mt="2" mx="2">
            <Center>
                <MaterialIcons name="attach-money" size={24} color="orange" />
                <Text fontSize="xs">Số dư Ví (vnđ)</Text>
                <Text fontSize="3xl" color="green.600">{formatNumber(currentUser.soDu)}</Text>
            </Center>
        </Box>
        <HStack flexWrap="wrap" mt="2">
            <Box w="1/2" borderWidth="0.3" borderColor="coolGray.400" p="5" bg={service === 'PAYPAL - WALLET' ? "teal.500" : "white"}>
                <Pressable onPress={() => setService('PAYPAL - WALLET')}>
                    <Center>
                        <FontAwesome5 name="cc-paypal" size={32} color="orange" />
                        <Text color="success.600" underline>Thanh toán</Text>
                        <Text color="success.600" underline>PAYPAL</Text>
                    </Center>
                </Pressable>
            </Box>
            <Box w="1/2" borderWidth="0.3" borderColor="coolGray.400" p="5" bg={service === 'MOMO - WALLET' ? "teal.500" : "white"}>
                <Pressable onPress={() => setService('MOMO - WALLET')}>
                    <Center>
                        <AntDesign name="medium-monogram" size={32} color="red" />
                        <Text color="success.600" underline>Thanh toán</Text>
                        <Text color="success.600" underline>MOMO</Text>
                    </Center>
                </Pressable>
            </Box>
            <Box w="1/2" borderWidth="0.3" borderColor="coolGray.400" p="5" bg={service === 'VNPAY - WALLET' ? "teal.500" : "white"}>
                <Pressable onPress={() => setService('VNPAY - WALLET')}>
                    <Center>
                        <FontAwesome name="vimeo-square" size={32} color="blue" />
                        <Text color="success.600" underline>Thanh toán</Text>
                        <Text color="success.600" underline>VNPAY</Text>
                    </Center>
                </Pressable>
            </Box>
        </HStack>
        <Divider></Divider>
        <HStack p="2" mt="2" mx="2" flexWrap="wrap">
            <Button w="1/3" variant="outline" onPress={() => setBalanceToRecharge('50000')} bg={balanceToRecharge != 50000 ? "white" : "teal.300"}>50.000đ</Button>
            <Button w="1/3" variant="outline" onPress={() => setBalanceToRecharge('100000')} bg={balanceToRecharge != 100000 ? "white" : "teal.300"}>100.000đ</Button>
            <Button w="1/3" variant="outline" onPress={() => setBalanceToRecharge('200000')} bg={balanceToRecharge != 200000 ? "white" : "teal.300"}>200.000đ</Button>
            <Button w="1/3" variant="outline" onPress={() => setBalanceToRecharge('500000')} bg={balanceToRecharge != 500000 ? "white" : "teal.300"}>500.000đ</Button>
            <Button w="1/3" variant="outline" onPress={() => setBalanceToRecharge('1000000')} bg={balanceToRecharge != 1000000 ? "white" : "teal.300"}>1.000.000đ</Button>
            <Button w="1/3" variant="outline" onPress={() => setBalanceToRecharge('2000000')} bg={balanceToRecharge != 2000000 ? "white" : "teal.300"}>2.000.000đ</Button>
        </HStack>
        <Divider></Divider>
        <Box>
          <Input
            size="2xl"
            variant="filled"
            keyboardType="numeric"
            ref={inputRef}
            value={balanceToRecharge}
            onChange={handleBalanceToRechargeChange}
            InputLeftElement={
              <Icon
                as={<MaterialIcons name="attach-money" size={24} color="black" />}
                size={8}
                ml="2"
                color={"success.500"}
              />
            }
            InputRightElement={
            <Pressable onPress={() => {
              if (inputRef && inputRef.current) {
                inputRef.current.focus();
              }
            }}>
              <Icon
                as={<MaterialCommunityIcons name="cursor-default-click" size={24} color="black" />}
                size={8}
                mr="5"
                color="gold"
              />
            </Pressable>
            }
          />
        </Box>
        <Button
          variant="subtle"
          bg="teal.400"
          mx="5"
          py="5"
          onPress={() => confirmTransaction()}
        ><Text color="white" fontSize="lg">Nạp ví <FontAwesome5 name="hand-sparkles" size={20} color="gold" /></Text></Button>
      </ScrollView>

      <Modal isOpen={momoMethodModalVisible} onClose={setMomoMethodModalVisible} size={"xl"}>
        <Modal.Content maxH="212">
          <Modal.CloseButton />
          <Modal.Header>Chọn loại thanh toán MOMO</Modal.Header>
          <Modal.Body>
            <Radio.Group
              name="myRadioGroup"
              value={momoMethod}
              onChange={(nextValue) => {
                setMomoMethod(nextValue);
              }}
            >
              <Radio value="MOMO_QR" my="1">
                MOMO QR (Thanh toán quét mã QR)
              </Radio>
              <Radio value="MOMO_ATM" my="1">
                MOMO ATM (Thanh toán với thẻ ATM)
              </Radio>
            </Radio.Group>
          </Modal.Body>
          <Modal.Footer>
            <Button.Group space={2}>
              <Button variant="ghost" colorScheme="blueGray" onPress={() => {
                setMomoMethodModalVisible(false);
                setMomoMethod("MOMO_QR");
            }}>
                Hủy bỏ
              </Button>
              <Button
                onPress={() => {handlePayout()}}
                bg="orange.400"
              >
                Xác nhận
              </Button>
            </Button.Group>
          </Modal.Footer>
        </Modal.Content>
      </Modal>
    </NativeBaseProvider>
  );
};

export default RechargePage;