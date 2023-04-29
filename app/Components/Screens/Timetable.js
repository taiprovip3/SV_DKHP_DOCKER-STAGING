import { Box, Center, Divider, HStack, NativeBaseProvider, Pressable, ScrollView, Text } from 'native-base';
import React from 'react';
import {  FontAwesome5 } from '@expo/vector-icons';
import { MaterialIcons } from '@expo/vector-icons';
import { Ionicons } from '@expo/vector-icons';
import { MaterialCommunityIcons } from '@expo/vector-icons';
import { AntDesign } from '@expo/vector-icons';
import { Entypo } from '@expo/vector-icons';
import axios from 'axios';
import { AuthContext } from '../Providers/AuthProvider';
import publicIP from 'react-native-public-ip';
import { LOCAL_JAVA_API_URL } from '@env';
import NetInfo from "@react-native-community/netinfo";
import * as SQLite from 'expo-sqlite';
import * as Progress from 'react-native-progress';

const Timetable = ({ navigation }) => {

    const db = SQLite.openDatabase('sv_dkhp.db');
    const { token, currentUser } = React.useContext(AuthContext);
    const [now, setNow] = React.useState(new Date());
    const [copyNow, setCopyNow] = React.useState(new Date()); //copyNow = defaultNow
    const [selectedNow, setSelectedNow] = React.useState(copyNow);
    const [tkbs, setTKBs] = React.useState([]);
    const [tKBsInSelected, setTKBsInSelected] = React.useState([]);
    const [progress, setProgress] = React.useState(0);
    const belongOfMorning = ["T1", "T2", "T3", "T4", "T5"];
    const belongOfAfternoon = ["T6", "T7", "T8", "T9", "T10", "T11", "T12"];
    const belongOfNight = ["T13", "T14", "T15", "T16", "T17", "T18", "T19"];
    let DATE_PREV0 = null;
    let DATE_PREV1 = null;
    let DATE_PREV2 = null;
    let DATE_PREV3 = null;
    let DATE_PREV4 = null;
    let DATE_PREV5 = null;
    let DATE_PREV6 = null;
    
    React.useEffect(() => {//useEffect vô dụng vì time_table trong mobile chỉ show 1 ngày, code chơi cho vui
        const getTKBs = async () => {
            const thoiKhoaBieu2DTO = {currentDate: formatDate(DATE_PREV0), datePrev1: formatDate(DATE_PREV1), datePrev2: formatDate(DATE_PREV2), datePrev3: formatDate(DATE_PREV3), datePrev4: formatDate(DATE_PREV4), datePrev5: formatDate(DATE_PREV5), datePrev6: formatDate(DATE_PREV6), maSinhVien: currentUser.maSinhVien, filterLoaiLich: ""};
            const javaIp = await publicIP();
            const tkbsResponse = await axios.post(LOCAL_JAVA_API_URL+"/api/time_table/getTimeTablesBy7Days", thoiKhoaBieu2DTO, {headers: {"Authorization": token}});
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
        const getStudentTimeTableByDay = async () => {// Hàm lấy data online từ server
            const isConnected = checkInternetConnection();
            if(isConnected) {
                const javaIp = await publicIP();
                const response = await axios.get(LOCAL_JAVA_API_URL+"/api/time_table/getStudentTimeTableByDay/"+ currentUser.maSinhVien + "/" + formatDate(selectedNow), {headers: {"Authorization": token}});
                if(response.data) {
                    setTKBsInSelected(response.data);
                }
            } else {// Hàm lấy data offline từ SQLite
                readDataFromSQLite(selectedNow);
            }
        }
        getStudentTimeTableByDay();
    },[selectedNow]);
    React.useEffect(() => {// Init skeleton
        const initSkeleton = async (theInputDate) => {
            if(!theInputDate)
                theInputDate = new Date();
            let current_date = new Date();
            let datePrev1 = new Date(theInputDate);
            let datePrev2 = new Date(theInputDate);
            let datePrev3 = new Date(theInputDate);
            let datePrev4 = new Date(theInputDate);
            let datePrev5 = new Date(theInputDate);
            let datePrev6 = new Date(theInputDate);
            const thuNow = theInputDate.getDay();
            switch (thuNow) {
                case 0:
                    datePrev1.setDate(datePrev1.getDate() - 1);
                    datePrev2.setDate(datePrev2.getDate() - 2);
                    datePrev3.setDate(datePrev3.getDate() - 3);
                    datePrev4.setDate(datePrev4.getDate() - 4);
                    datePrev5.setDate(datePrev5.getDate() - 5);
                    datePrev6.setDate(datePrev6.getDate() - 6);
                    break;
                case 1:
                    datePrev1.setDate(datePrev1.getDate() + 1);
                    datePrev2.setDate(datePrev2.getDate() + 2);
                    datePrev3.setDate(datePrev3.getDate() + 3);
                    datePrev4.setDate(datePrev4.getDate() + 4);
                    datePrev5.setDate(datePrev5.getDate() + 5);
                    datePrev6.setDate(datePrev6.getDate() + 6);
                    break;
                case 2:
                    datePrev1.setDate(datePrev1.getDate() - 1);
                    datePrev2.setDate(datePrev2.getDate() + 1);
                    datePrev3.setDate(datePrev3.getDate() + 2);
                    datePrev4.setDate(datePrev4.getDate() + 3);
                    datePrev5.setDate(datePrev5.getDate() + 4);
                    datePrev6.setDate(datePrev6.getDate() + 5);
                    break;
                case 3:
                    datePrev1.setDate(datePrev1.getDate() - 2);
                    datePrev2.setDate(datePrev2.getDate() - 1);
                    datePrev3.setDate(datePrev3.getDate() + 1);
                    datePrev4.setDate(datePrev4.getDate() + 2);
                    datePrev5.setDate(datePrev5.getDate() + 3);
                    datePrev6.setDate(datePrev6.getDate() + 4);
                    break;
                case 4:
                    datePrev1.setDate(datePrev1.getDate() - 3);
                    datePrev2.setDate(datePrev2.getDate() - 2);
                    datePrev3.setDate(datePrev3.getDate() - 1);
                    datePrev4.setDate(datePrev4.getDate() + 1);
                    datePrev5.setDate(datePrev5.getDate() + 2);
                    datePrev6.setDate(datePrev6.getDate() + 3);
                    break;
                case 5:
                    datePrev1.setDate(datePrev1.getDate() - 4);
                    datePrev2.setDate(datePrev2.getDate() - 3);
                    datePrev3.setDate(datePrev3.getDate() - 2);
                    datePrev4.setDate(datePrev4.getDate() - 1);
                    datePrev5.setDate(datePrev5.getDate() + 1);
                    datePrev6.setDate(datePrev6.getDate() + 2);
                    break;
                case 6:
                    datePrev1.setDate(datePrev1.getDate() - 5);
                    datePrev2.setDate(datePrev2.getDate() - 4);
                    datePrev3.setDate(datePrev3.getDate() - 3);
                    datePrev4.setDate(datePrev4.getDate() - 2);
                    datePrev5.setDate(datePrev5.getDate() - 1);
                    datePrev6.setDate(datePrev6.getDate() + 1);
                    break;
                default:
                    break;
            }


            let currentDateMonth = current_date.getMonth()+1;
            if(currentDateMonth < 10) currentDateMonth = "0"+currentDateMonth;
            let currentDateDate = current_date.getDate();
            if(currentDateDate < 10) currentDateDate = "0"+currentDateDate;
            const cDate = current_date.getFullYear() + "-" + currentDateMonth + '-' + currentDateDate;
        
            let d1Month = datePrev1.getMonth()+1;
            if(d1Month < 10) d1Month = "0"+d1Month;
            let d1Date = datePrev1.getDate();
            if(d1Date < 10) d1Date = "0"+d1Date;
            const d1 = datePrev1.getFullYear() + "-" + d1Month + '-' + d1Date;
        
            let d2Month = datePrev2.getMonth()+1;
            if(d2Month < 10) d2Month = "0"+d2Month;
            let d2Date = datePrev2.getDate();
            if(d2Date < 10) d2Date = "0"+d2Date;
            const d2 = datePrev2.getFullYear() + "-" + d2Month + '-' + d2Date;
        
            let d3Month = datePrev3.getMonth()+1;
            if(d3Month < 10) d3Month = "0"+d3Month;
            let d3Date = datePrev3.getDate();
            if(d3Date < 10) d3Date = "0"+d3Date;
            const d3 = datePrev3.getFullYear() + "-" + d3Month + '-' + d3Date;
            
            let d4Month = datePrev4.getMonth()+1;
            if(d4Month < 10) d4Month = "0"+d4Month;
            let d4Date = datePrev4.getDate();
            if(d4Date < 10) d4Date = "0"+d4Date;
            const d4 = datePrev4.getFullYear() + "-" + d4Month + '-' + d4Date;
        
            let d5Month = datePrev5.getMonth()+1;
            if(d5Month < 10) d5Month = "0"+d5Month;
            let d5Date = datePrev5.getDate();
            if(d5Date < 10) d5Date = "0"+d5Date;
            const d5 = datePrev5.getFullYear() + "-" + d5Month + '-' + d5Date;
        
            let d6Month = datePrev6.getMonth()+1;
            if(d6Month < 10) d6Month = "0"+d6Month;
            let d6Date = datePrev6.getDate();
            if(d6Date < 10) d6Date = "0"+d6Date;
            const d6 = datePrev6.getFullYear() + "-" + d6Month + '-' + d6Date;
            

            const thoiKhoaBieu2DTO = {currentDate: cDate, datePrev1: d1, datePrev2: d2, datePrev3: d3, datePrev4: d4, datePrev5: d5, datePrev6: d6, filterLoaiLich: 'lich_all', maSinhVien: currentUser.maSinhVien};
            const response = await axios.post(LOCAL_JAVA_API_URL+"/api/time_table/getTimeTablesBy7Days", thoiKhoaBieu2DTO, {headers: {"Authorization": token}});
            if(response.data) {
                insertDataSQLite(response.data);
            }
        }
        rebootTable();
        initSkeleton();
    },[]);
    React.useEffect(() => {
        // Cập nhật giá trị progress mỗi 500ms
        const interval = setInterval(() => {
            setProgress((prevProgress) => {
            if (prevProgress >= 1) {
                clearInterval(interval);
                return 1;
            }
            return prevProgress + 0.05;
            });
        }, 50);
        return () => clearInterval(interval);
    }, []);
    const rebootTable = () => {
        db.transaction((tx) => {
            tx.executeSql('DELETE FROM TimeTable', [], (tx, results) => {
                console.log('Truncate table ThoiKhoaBieu successfully!');
            });
        });
        db.transaction((tx) => {
            tx.executeSql(
                `CREATE TABLE IF NOT EXISTS TimeTable (id INTEGER PRIMARY KEY AUTOINCREMENT, denTietHoc TEXT, ghiChu TEXT, giaoVien TEXT, loaiBuoiHoc TEXT, lopHocPhan TEXT, maThoiKhoaBieu INTEGER, ngayBatDau TEXT, ngayKetThuc TEXT, nhomHoc INTEGER, phongHoc TEXT, soLuongDaDangKy INTEGER, thi BOOLEAN, thoiKhoaBieuCons TEXT, thuHoc TEXT, tuTietHoc TEXT);`,
                [],
                () => console.log('Table created successfully.'),
                (error) => console.log(`Error creating table: ${error}`)
            );
        });
    }
    const insertDataSQLite = (dataArray) => {
        db.transaction((tx) => {
          // Vòng lặp duyệt qua từng phần tử trong mảng dataArray
          dataArray.forEach((data) => {
            const { denTietHoc, ghiChu, giaoVien, loaiBuoiHoc, lopHocPhan, maThoiKhoaBieu, ngayBatDau, ngayKetThuc, nhomHoc, phongHoc, soLuongDaDangKy, thi, thoiKhoaBieuCons, thuHoc, tuTietHoc } = data;
      
            // Sử dụng câu lệnh INSERT để thêm từng phần tử vào database
            tx.executeSql(
              'INSERT INTO TimeTable (denTietHoc, ghiChu, giaoVien, loaiBuoiHoc, lopHocPhan, maThoiKhoaBieu, ngayBatDau, ngayKetThuc, nhomHoc, phongHoc, soLuongDaDangKy, thi, thoiKhoaBieuCons, thuHoc, tuTietHoc) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
              [denTietHoc, ghiChu, JSON.stringify(giaoVien), loaiBuoiHoc, JSON.stringify(lopHocPhan), maThoiKhoaBieu, ngayBatDau, ngayKetThuc, nhomHoc, phongHoc, soLuongDaDangKy, thi, JSON.stringify(thoiKhoaBieuCons), thuHoc, tuTietHoc],
              (_, result) => {
                console.log('Insert success: ', result.rowsAffected);
              },
              (_, error) => {
                console.log('Insert error: ', error);
              }
            );
          });
        });
    };
    const readDataFromSQLite = (theDate) => {// Hàm được gọi khi chọn ngày lịch & offline
        const daysOfWeek = ["CN", "T2", "T3", "T4", "T5", "T6", "T7"];
        const dayOfWeek = daysOfWeek[theDate.getDay()];
        db.transaction((tx) => {
            tx.executeSql(
            'SELECT * FROM TimeTable WHERE thuHoc = ? AND (? BETWEEN ngayBatDau AND ngayKetThuc)',
            [dayOfWeek, formatDate(theDate)],
            (_, result) => {
                console.log('Number of rows:', result.rows.length);
                const TKBs = [];
                for (let i = 0; i < result.rows.length; i++) {
                    const row = result.rows.item(i);
                    const parsedRow = parseRow(row);
                    TKBs.push(parsedRow);
                }
                setTKBsInSelected(TKBs);
            },
            (_, error) => {
                console.log('Read error:', error);
            }
            );
        });
    };
    function parseRow(row) {
        for (let key in row) {
            if (typeof row[key] === 'string') {
            try {
                row[key] = JSON.parse(row[key]);
            } catch (error) {
                // Không phải định dạng JSON, giữ nguyên giá trị
            }
            }
        }
        return row;
    }
    const checkInternetConnection = async () => {
        const netInfo = await NetInfo.fetch();
        return netInfo.isConnected;
    };
      
      

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
                                <Box position="relative">
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
                                    <Box position="absolute" right="0" top="1/3" pr="3">
                                        {
                                            tkb.loaiBuoiHoc === 'LT' ?
                                            <FontAwesome5 name="book" size={24} color="black" />
                                            : <Entypo name="laptop" size={24} color="black" />
                                        }
                                    </Box>
                                </Box>;
                                <Center><Divider bg="gray.300" thickness="1" my="2" w="90%" /></Center>
                            </Box>
                        })
                    }
                </ScrollView>
            }
            {
                progress < 1 &&
                <Box>
                    <Center><Text fontSize="xs">Đang sao lưu lịch xuống local..</Text></Center>
                    <Progress.Bar progress={progress} width={null} />
                </Box>
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