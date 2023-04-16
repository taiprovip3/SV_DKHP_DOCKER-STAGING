import { Box, Center, Divider, HStack, NativeBaseProvider, Pressable, ScrollView, Text } from 'native-base';
import React from 'react';
import { FontAwesome, Octicons } from '@expo/vector-icons';
import { MaterialIcons } from '@expo/vector-icons';
import { Ionicons } from '@expo/vector-icons';
import { Feather } from '@expo/vector-icons';
import { MaterialCommunityIcons } from '@expo/vector-icons';
import { AntDesign } from '@expo/vector-icons';
import { Entypo } from '@expo/vector-icons';
import axios from 'axios';
import { AuthContext } from '../Providers/AuthProvider';
import publicIP from 'react-native-public-ip';
import { LOCAL_JAVA_API_URL } from '@env';
import { JAVA_PORT } from '@env';

const Timetable = ({ navigation }) => {

    const JAVA_API_URL = LOCAL_JAVA_API_URL + ":" + JAVA_PORT;
    const { token, currentUser } = React.useContext(AuthContext);
    const [now, setNow] = React.useState(new Date());
    const [copyNow, setCopyNow] = React.useState(new Date()); //copyNow = defaultNow
    const [selectedNow, setSelectedNow] = React.useState(copyNow);
    const [tkbs, setTKBs] = React.useState([]);
    const [tKBsInSelected, setTKBsInSelected] = React.useState([]);
    React.useEffect(() => {//useEffect vô dụng vì time_table trong mobile chỉ show 1 ngày, code chơi cho vui
        const getTKBs = async () => {
            const thoiKhoaBieu2DTO = {currentDate: formatDate(DATE_PREV0), datePrev1: formatDate(DATE_PREV1), datePrev2: formatDate(DATE_PREV2), datePrev3: formatDate(DATE_PREV3), datePrev4: formatDate(DATE_PREV4), datePrev5: formatDate(DATE_PREV5), datePrev6: formatDate(DATE_PREV6), maSinhVien: currentUser.maSinhVien, filterLoaiLich: ""};
            const javaIp = await publicIP();
            const tkbsResponse = await axios.post(JAVA_API_URL+"/api/time_table/getTimeTablesBy7Days", thoiKhoaBieu2DTO, {headers: {"Authorization": token}});
            if(tkbsResponse.data) {
                setTKBs(tkbsResponse.data);
            }
        }
        getTKBs();
    },[now]);
    React.useEffect(() => {
        if(now.getDay() == 0) {//Nếu h.nay = CN
            set_DATE_PREV(0, -6, -5, -4, -3, -2, -1);
        }
        if(now.getDay() == 1) {//Nếu h.nay = T2
            set_DATE_PREV(6, 0, 1, 2, 3, 4, 5);
        }
        if(now.getDay() == 2) {//Nếu h.nay = T3
            set_DATE_PREV(5, -1, 0, 1, 2, 3, 4);
        }
        if(now.getDay() == 3) {//Nếu h.nay = T4
            set_DATE_PREV(4, -2, -1, 0, 1, 2, 3);
        }
        if(now.getDay() == 4) {//Nếu h.nay = T5
            set_DATE_PREV(3, -3, -2, -1, 0, 1, 2);
        }
        if(now.getDay() == 5) {//Nếu h.nay = T6
            set_DATE_PREV(2, -4, -3, -2, -1, 0, 1);
        }
        if(now.getDay() == 6) {//Nếu h.nay = T7
            set_DATE_PREV(1, -5, -4, -3, -2, -1, 0);
        }
    },[now]);
    React.useEffect(() => {
        const getStudentTimeTableByDay = async () => {
            const javaIp = await publicIP();
            const response = await axios.get(JAVA_API_URL+"/api/time_table/getStudentTimeTableByDay/"+ currentUser.maSinhVien + "/" + formatDate(selectedNow), {headers: {"Authorization": token}});
            if(response.data) {
                setTKBsInSelected(response.data);
            }
        }
        getStudentTimeTableByDay();
    },[selectedNow]);

    let DATE_PREV0 = null;
    let DATE_PREV1 = null;
    let DATE_PREV2 = null;
    let DATE_PREV3 = null;
    let DATE_PREV4 = null;
    let DATE_PREV5 = null;
    let DATE_PREV6 = null;

    if(now.getDay() == 0) {//Nếu h.nay = CN
        set_DATE_PREV(0, -6, -5, -4, -3, -2, -1);
    }
    if(now.getDay() == 1) {//Nếu h.nay = T2
        set_DATE_PREV(6, 0, 1, 2, 3, 4, 5);
    }
    if(now.getDay() == 2) {//Nếu h.nay = T3
        set_DATE_PREV(5, -1, 0, 1, 2, 3, 4);
    }
    if(now.getDay() == 3) {//Nếu h.nay = T4
        set_DATE_PREV(4, -2, -1, 0, 1, 2, 3);
    }
    if(now.getDay() == 4) {//Nếu h.nay = T5
        set_DATE_PREV(3, -3, -2, -1, 0, 1, 2);
    }
    if(now.getDay() == 5) {//Nếu h.nay = T6
        set_DATE_PREV(2, -4, -3, -2, -1, 0, 1);
    }
    if(now.getDay() == 6) {//Nếu h.nay = T7
        set_DATE_PREV(1, -5, -4, -3, -2, -1, 0);
    }
    const belongOfMorning = ["T1", "T2", "T3", "T4", "T5"];
    const belongOfAfternoon = ["T6", "T7", "T8", "T9", "T10", "T11", "T12"];
    const belongOfNight = ["T13", "T14", "T15", "T16", "T17", "T18", "T19"];
    function compreTwoDate(date1, date2) {
        const d1Date = date1.getDate();
        const d1Month = date1.getMonth();
        const d1Year = date1.getFullYear();

        const d2Date = date2.getDate();
        const d2Month = date2.getMonth();
        const d2Year = date2.getFullYear();
        if(d1Date == d2Date && d1Month == d2Month && d1Year == d2Year)
            return true;
        return false;
    }
    function set_DATE_PREV(params0, params1, params2, params3, params4, params5, params6) {
        DATE_PREV0 = new Date(now);
        DATE_PREV1 = new Date(now);
        DATE_PREV2 = new Date(now);
        DATE_PREV3 = new Date(now);
        DATE_PREV4 = new Date(now);
        DATE_PREV5 = new Date(now);
        DATE_PREV6 = new Date(now);
        DATE_PREV0.setDate(DATE_PREV0.getDate() + params0);
        DATE_PREV1.setDate(DATE_PREV1.getDate() + params1);
        DATE_PREV2.setDate(DATE_PREV2.getDate() + params2);
        DATE_PREV3.setDate(DATE_PREV3.getDate() + params3);
        DATE_PREV4.setDate(DATE_PREV4.getDate() + params4);
        DATE_PREV5.setDate(DATE_PREV5.getDate() + params5);
        DATE_PREV6.setDate(DATE_PREV6.getDate() + params6);
    }
    function getTodayString() {
        const month_names_short = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
        const date_names_short = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
        let date = new Date();
        const day = date_names_short[date.getDay()];
        const ddate = date.getDate();
        const month = month_names_short[date.getMonth()];
        const year = date.getFullYear();
        return day + ", " + ddate + ", " + month + ", " + year;
    }
    function formatDate(date) {
        let dateMonth = date.getMonth()+1;
        if(dateMonth < 10) dateMonth = "0"+dateMonth;
        let dateDate = date.getDate();
        if(dateDate < 10) dateDate = "0"+dateDate;
        return date.getFullYear() + "-" + dateMonth + '-' + dateDate; 
    }
    function onNextWeek() {
        let temp = new Date(DATE_PREV0);
        temp.setDate(temp.getDate() + 1);
        setNow(temp);
    }
    function onPrevWeek() {
        let temp = new Date(DATE_PREV1);
        temp.setDate(temp.getDate() - 1);
        setNow(temp);
    }
    function onCurrentWeek() {
        setNow(new Date());
        setSelectedNow(copyNow);
    }

  return (
    <NativeBaseProvider>
        <Box flex="1" borderColor="gray.400" borderWidth="0.5">
            <Box bg="info.500">
                <Box>
                    <HStack justifyContent="space-evenly">
                        <Box>
                            <Pressable onPress={() => setSelectedNow(DATE_PREV1)}>
                                <Center>
                                    <Text color="white" fontWeight="light" fontSize="xs">MON</Text>
                                    {
                                        compreTwoDate(DATE_PREV1, selectedNow) ? 
                                        <Text color="info.500" bg="white" px="2" py="1" fontWeight="extrabold">{DATE_PREV1.getDate()}</Text>  
                                        : 
                                        <Text color="white" px="2" py="1" fontWeight="extrabold">{DATE_PREV1.getDate()}</Text>
                                    }
                                </Center>
                            </Pressable>
                        </Box>
                        <Box>
                            <Pressable onPress={() => setSelectedNow(DATE_PREV2)}>
                                <Center>
                                    <Text color="white" fontWeight="light" fontSize="xs">TUE</Text>
                                    {
                                        compreTwoDate(DATE_PREV2, selectedNow) ? 
                                        <Text color="info.500" bg="white" px="2" py="1" fontWeight="extrabold">{DATE_PREV2.getDate()}</Text>  
                                        : 
                                        <Text color="white" px="2" py="1" fontWeight="extrabold">{DATE_PREV2.getDate()}</Text>
                                    }
                                </Center>
                            </Pressable>
                        </Box>
                        <Box>
                            <Pressable onPress={() => setSelectedNow(DATE_PREV3)}>
                                <Center>
                                    <Text color="white" fontWeight="light" fontSize="xs">WED</Text>
                                    {
                                        compreTwoDate(DATE_PREV3, selectedNow) ? 
                                        <Text color="info.500" bg="white" px="2" py="1" fontWeight="extrabold">{DATE_PREV3.getDate()}</Text>  
                                        : 
                                        <Text color="white" px="2" py="1" fontWeight="extrabold">{DATE_PREV3.getDate()}</Text>
                                    }
                                </Center>
                            </Pressable>
                        </Box>
                        <Box>
                            <Pressable onPress={() => setSelectedNow(DATE_PREV4)}>
                                <Center>
                                    <Text color="white" fontWeight="light" fontSize="xs">THU</Text>
                                    {
                                        compreTwoDate(DATE_PREV4, selectedNow) ? 
                                        <Text color="info.500" bg="white" px="2" py="1" fontWeight="extrabold">{DATE_PREV4.getDate()}</Text>  
                                        : 
                                        <Text color="white" px="2" py="1" fontWeight="extrabold">{DATE_PREV4.getDate()}</Text>
                                    }
                                </Center>
                            </Pressable>
                        </Box>
                        <Box>
                            <Pressable onPress={() => setSelectedNow(DATE_PREV5)}>
                                <Center>
                                    <Text color="white" fontWeight="light" fontSize="xs">FRI</Text>
                                    {
                                        compreTwoDate(DATE_PREV5, selectedNow) ? 
                                        <Text color="info.500" bg="white" px="2" py="1" fontWeight="extrabold">{DATE_PREV5.getDate()}</Text>  
                                        : 
                                        <Text color="white" px="2" py="1" fontWeight="extrabold">{DATE_PREV5.getDate()}</Text>
                                    }
                                </Center>
                            </Pressable>
                        </Box>
                        <Box>
                            <Pressable onPress={() => setSelectedNow(DATE_PREV6)}>
                                <Center>
                                    <Text color="white" fontWeight="light" fontSize="xs">SAT</Text>
                                    {
                                        compreTwoDate(DATE_PREV6, selectedNow) ? 
                                        <Text color="info.500" bg="white" px="2" py="1" fontWeight="extrabold">{DATE_PREV6.getDate()}</Text>  
                                        : 
                                        <Text color="white" px="2" py="1" fontWeight="extrabold">{DATE_PREV6.getDate()}</Text>
                                    }
                                </Center>
                            </Pressable>
                        </Box>
                        <Box>
                            <Pressable onPress={() => setSelectedNow(DATE_PREV0)}>
                                <Center>
                                    <Text color="white" fontWeight="light" fontSize="xs">SUN</Text>
                                    {
                                        compreTwoDate(DATE_PREV0, selectedNow) ? 
                                        <Text color="info.500" bg="white" px="2" py="1" fontWeight="extrabold">{DATE_PREV0.getDate()}</Text>  
                                        : 
                                        <Text color="white" px="2" py="1" fontWeight="extrabold">{DATE_PREV0.getDate()}</Text>
                                    }
                                </Center>
                            </Pressable>
                        </Box>
                    </HStack>
                </Box>
            </Box>
            <Box pb="5" pl="2" pt="1">
                <Center>
                    <Box mt="2">
                        <HStack alignItems="center">
                            <MaterialCommunityIcons name="calendar-text" size={24} color="green" />
                            <Text> Hôm nay: {getTodayString()}</Text>
                        </HStack>
                    </Box>
                </Center>
                <Center><Divider bg="gray.300" thickness="1" my="2" w="90%" /></Center>
            </Box>
            {
                tKBsInSelected.length <= 0 ?
                <Box flex="1" display="flex" flexDirection="row" alignItems="center" justifyContent="center">
                    <Text>Không có lịch học ngày chọn</Text>
                </Box>
                :
                <ScrollView>
                    {
                        tKBsInSelected.map(tkb => {
                            return <Box key={tkb.maThoiKhoaBieu}>
                                <Box>
                                    <HStack>
                                        <Box px="10" borderRightColor="gray.400" borderRightWidth="1">
                                            <Center margin="auto">
                                                <Text>Tiết</Text>
                                                <Text color="muted.600">({tkb.tuTietHoc.substring(1,3)}-{tkb.denTietHoc.substring(1,3)})</Text>
                                                {
                                                    belongOfMorning.includes(tkb.tuTietHoc) ?
                                                    <Ionicons name="sunny" size={24} color="aqua" />
                                                    : belongOfAfternoon.includes(tkb.tuTietHoc) ?
                                                    <Ionicons name="md-partly-sunny" size={24} color="orange" />
                                                    : belongOfNight.includes(tkb.tuTietHoc) ?
                                                    <MaterialIcons name="nights-stay" size={24} color="dark" />
                                                    : null
                                                }
                                            </Center>
                                        </Box>
                                        <Box pl="3">
                                            <Text fontWeight="bold">{tkb.lopHocPhan.monHoc.tenMonHoc} -</Text>
                                            <Text color="muted.600">({tkb.lopHocPhan.tenLopHocPhan})</Text>
                                            <Text color="muted.600">Phòng {tkb.phongHoc}</Text>
                                            <Text color="muted.600">Ghi chú: {tkb.ghiChu == "" ? "Không" : tkb.ghiChu}</Text>
                                        </Box>
                                    </HStack>
                                </Box>;
                                <Center><Divider bg="gray.300" thickness="1" my="2" w="90%" /></Center>
                            </Box>
                        })
                    }
                </ScrollView>
        }

            <Box borderRightColor="gray.400" borderRightWidth="1" bg="gray.200" p="2" w="100%">
                <HStack justifyContent="space-between">
                    <Box borderWidth="1" borderColor="gray.300" py="2" w="1/4" bg="gray.400">
                        <Pressable onPress={onPrevWeek}>
                            <Center>
                                <HStack>
                                    <AntDesign name="caretleft" size={15} color="white" />
                                    <Text fontSize="xs">Previous</Text>
                                </HStack>
                            </Center>
                        </Pressable>
                    </Box>
                    <Box borderWidth="1" borderColor="gray.300" py="2" w="1/4" bg="white">
                        <Pressable onPress={onCurrentWeek}>
                            <Center>
                                <HStack>
                                    <Entypo name="back-in-time" size={15} color="black" />
                                    <Text fontSize="xs">Today</Text>
                                </HStack>
                            </Center>
                        </Pressable>
                    </Box>
                    <Box borderWidth="1" borderColor="gray.300" py="2" w="1/4" bg="emerald.500">
                        <Pressable onPress={onNextWeek}>
                            <Center>
                                <HStack>
                                    <Text fontSize="xs">Next</Text>
                                    <AntDesign name="caretright" size={15} color="white" />
                                </HStack>
                            </Center>
                        </Pressable>
                    </Box>
                </HStack>
            </Box>
        </Box>
    </NativeBaseProvider>
  )
};

export default Timetable;