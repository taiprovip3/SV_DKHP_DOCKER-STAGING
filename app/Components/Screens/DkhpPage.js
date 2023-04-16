import React, { useCallback } from 'react'
import { NativeBaseProvider, Select, ScrollView, Box, CheckIcon, Radio, HStack, Text, Center, Divider, Modal, Button, Pressable, Checkbox, useToast } from 'native-base';
import { Toast } from 'react-native-toast-message/lib/src/Toast';
import { Entypo } from '@expo/vector-icons';
import { FontAwesome5 } from '@expo/vector-icons';
import { FontAwesome } from '@expo/vector-icons';
import { AuthContext } from '../Providers/AuthProvider';
import { MaterialCommunityIcons } from '@expo/vector-icons';
import { Ionicons } from '@expo/vector-icons';
import { MaterialIcons } from '@expo/vector-icons';
import publicIP from 'react-native-public-ip';
import axios from 'axios';
import { Alert } from 'react-native';
import { LOCAL_JAVA_API_URL } from '@env';
import { JAVA_PORT } from '@env';

const DkhpPage = () => {

  const JAVA_API_URL = LOCAL_JAVA_API_URL + ":" + JAVA_PORT;
  const { token, currentUser } = React.useContext(AuthContext);
  const [hocKySelected, setHocKySelected] = React.useState(0); //maKhoaHoc nè
  const [monHocSelected, setMonHocSelected] = React.useState(0);
  const [modalUnitClassesVisible, setModalUnitClassesVisible] = React.useState(false);
  const [modalTimetablesVisible, setModalTimetablesVisible] = React.useState(false);
  const [modalSameTimetablesVisible, setModalSameTimetablesVisible] = React.useState(false);
  const [modalLHPRegisteredVisible, setModalLHPRegisteredVisible] = React.useState(false);
  const [courses, setCourses] = React.useState([]);
  const [subjects, setSubjects] = React.useState([]);
  const [unitClasses, setUnitClasses] = React.useState([]);
  const [unitClassesRegistered, setUnitClassesRegistered] = React.useState([]);
  const [tkbs, setTkbs] = React.useState([]);//render cho modal show TKBs
  const [mySameTkbs, setMySameTkbs] = React.useState([]);//render cho modal show Same TKBs
  
  const [lhpSelected, setLHPSelected] = React.useState(null);
  const latestCourseId = React.useRef(0);
  const isFilterSame = React.useRef(false);
  const isFilterLock = React.useRef(false);
  const [loaiHoc, setLoaiHoc] = React.useState("HOC_MOI");
  const loaiHocShortcut = {HOC_MOI: 'HỌC MỚI', HOC_LAI: 'HỌC LẠI', HOC_CAI_THIEN: 'HỌC CẢI THIỆN'};
  const selectedLHPRegistered = React.useRef(null);

  /*
    Khi selectBox thay đổi -> Gọi api getSubjects
  */
  const onChangeHocKySelected = async (maKhoaHoc) => {
    try {
      if(latestCourseId.current != maKhoaHoc) {
        Toast.show({
          type: 'success',
          text1: 'Học kỳ vừa chọn đã quá hạn',
          text2: 'Sẽ ko còn mở lớp, hãy chọn những khoá học có ✔️ xanh.'
        });
      }
      const javaIp = await publicIP();
      const response = await axios.get("http://"+javaIp+":8080/api/subject/getSubjectsByCourseId/" + maKhoaHoc + "/" + currentUser.maSinhVien, {headers: {"Authorization": token}});
      const response2 = await axios.get("http://"+javaIp+":8080/api/unit_class/getUnitClassesStudentRegisterByStudentIdAndMaKhoaHoc/"+currentUser.maSinhVien+"/"+maKhoaHoc, {headers: {"Authorization": token}});
      setSubjects(response.data);
      setUnitClassesRegistered(response2.data);
      setHocKySelected(maKhoaHoc);
    } catch (error) {
      console.error("onChangeHocKySelected: ", error);
    }
  }
  /*
    Render tất cả lhp khi chọn subject
  */
  const renderLHP = (lhp) => {
    let trangThaiBeLike = <Text color="teal.900">Đang chờ sinh viên đăng ký</Text>;
    const myDateString = lhp.ngayBatDau;
    const myD1 = new Date(myDateString);
    let previous7Day = new Date(myD1);
    previous7Day.setDate(previous7Day.getDate() - 7);
    const myD2 = new Date();
    if(myD2 > previous7Day) {
        const diffD = Math.abs(myD2 - previous7Day);
        const one_day=1000*60*60*24;
        const myResult = Math.round(diffD/one_day);
        trangThaiBeLike = <Text color="error.700">Đã hết hạn đăng ký {myResult} ngày trước</Text>;
    }
    return <Pressable key={Math.random()} onPress={() => seeTimetableClass(lhp)}>
      <Box bg="coolGray.200" my="1" p="1">
        <HStack>
          <Box w="2/3">
            <Text fontSize="xs"><Text bold>Mã LHP</Text>: <Text color="teal.900">{lhp.maLopHocPhan}</Text></Text>
            <Text fontSize="xs"><Text bold>Tên lớp</Text>: <Text color="teal.900">{lhp.tenLopHocPhan}</Text></Text>
            <Text fontSize="xs"><Text bold>Trạng thái</Text>: {trangThaiBeLike}</Text>
          </Box>
          <Box w="1/3">
            <Center>
              <Text bold fontSize="xs">{lhp.monHoc.tenMonHoc}</Text>
              <Text fontSize="xs">Đã đăng ký</Text>
              <Text>{lhp.soLuong}/{lhp.soLuongMax} <FontAwesome name="user-circle" size={16} color="black" /></Text>
            </Center>
          </Box>
        </HStack>
    </Box>
  </Pressable>
  }
  function formatDate(dateString) {
    const date = new Date(dateString);
    const day = date.getDate().toString().padStart(2, '0');
    const month = (date.getMonth() + 1).toString().padStart(2, '0');
    const year = date.getFullYear().toString();
    return `${day}/${month}/${year}`;
  }
  const renderTKBItem = (tkb) => {//Hàm nhận vào từng tkb rồi sử lý
    // [{tkb: objectTKB, tkbCons:[{obj1}, {obj2}]}, {tkb: objectTKB, tkbCons:[]}]
    let timeLeft = 'Đã khóa';
    const myDateString = tkb.tkb.lopHocPhan.ngayBatDau;
    const myD1 = new Date(myDateString);
    let previous7Day = new Date(myD1);
    previous7Day.setDate(previous7Day.getDate() - 7);
    const myD2 = new Date();
    if(myD2 <= previous7Day) {
        const diffD = Math.abs(myD2 - previous7Day);
        const one_day=1000*60*60*24;
        const myResult = Math.round(diffD/one_day);
        timeLeft = 'Khóa sau: ' + (myResult <10 ? "0"+myResult : myResult) + ' ngày nữa';
    }
    if(tkb.tkbCons.length <= 0) {
      return <Pressable key={Math.random()} onPress={() => register(tkb.maThoiKhoaBieu, 0)}>
        <Box bg="coolGray.200" my="1" p="1" borderRadius="md">
          <HStack>
            <Box w="1/2">
              <Text fontSize="xs">Trạng thái: <Text color="teal.800" bold>{timeLeft}</Text></Text>
            </Box>
            <Box w="1/2">
              <Text fontSize="xs">Nhóm học: <Text color="teal.800" bold>{(tkb.tkb.nhomHoc) == 0 ? "Không phân nhóm" : tkb.tkb.nhomHoc}</Text></Text>
            </Box>
          </HStack>
          <Divider bg="black"></Divider>
          <HStack>
            <Box w="2/3" borderRightWidth="0.5" borderRightColor="black">
              <Text fontSize="xs">Lịch học: <Text color="teal.800" bold>LT - {tkb.tkb.thuHoc} (Tiết {tkb.tkb.tuTietHoc} -> {tkb.tkb.denTietHoc} )</Text></Text>
              <Text fontSize="xs">Dãy nhà: <Text color="teal.800" bold>{tkb.tkb.phongHoc.substring(0,1)}</Text></Text>
              <Text fontSize="xs">Phòng học: <Text color="teal.800" bold>{tkb.tkb.phongHoc}</Text></Text>
            </Box>
            <Box w="1/3">
              <Center>
                <Text bold fontSize="xs">GV: TS/Th.s {tkb.tkb.lopHocPhan.giaoVien.tenGiaoVien}</Text>
                <Text fontSize="xs">Bắt đầu học: {formatDate(tkb.tkb.lopHocPhan.ngayBatDau)} - {formatDate(tkb.tkb.lopHocPhan.ngayKetThuc)}</Text>
                <Text fontSize="xs">Đã đăng ký: {tkb.tkb.soLuongDaDangKy}/{tkb.tkb.lopHocPhan.soLuongMax} <FontAwesome5 name="user-check" size={12} color="'rgba(5, 148, 78, 0.8)'" /></Text>
              </Center>
            </Box>
          </HStack>
        </Box>
      </Pressable>;
    } else {
      return <>
        {
          tkb.tkbCons.map((item) => {
            return <Pressable key={Math.random()} onPress={() => register(tkb.tkb.maThoiKhoaBieu, item.maThoiKhoaBieuCon)}>
              <Box>
                <Box bg="coolGray.200" my="1" p="1" borderRadius="md">
                  <Text fontSize="xs">Trạng thái: <Text color="teal.800">{timeLeft}</Text></Text>
                  <Divider bg="coolGray.400"></Divider>
                  <HStack>
                    <Box w="2/3" borderRightWidth="0.5" borderRightColor="coolGray.400">
                      <Text fontSize="xs">Lịch học: <Text color="teal.800" bold>LT - {tkb.tkb.thuHoc} (Tiết {tkb.tkb.tuTietHoc} -> {tkb.tkb.denTietHoc} )</Text></Text>
                      <Text fontSize="xs">Dãy nhà: <Text color="teal.800" bold>{tkb.tkb.phongHoc.substring(0,1)}</Text></Text>
                      <Text fontSize="xs">Phòng học: <Text color="teal.800" bold>{tkb.tkb.phongHoc}</Text></Text>
                      <Text fontSize="xs">Nhóm học: <Text color="teal.800" bold>{tkb.tkb.nhomHoc}</Text></Text>
                      <Divider bg="coolGray.400"></Divider>
                      <Text fontSize="xs">Lịch học: <Text color="teal.800" bold>TH - {item.thuHoc} (Tiết {item.tuTietHoc} -> {item.denTietHoc} )</Text></Text>
                      <Text fontSize="xs">Dãy nhà: <Text color="teal.800" bold>{item.phongHoc.substring(0,1)}</Text></Text>
                      <Text fontSize="xs">Phòng học: <Text color="teal.800" bold>{item.phongHoc}</Text></Text>
                      <Text fontSize="xs">Nhóm học: <Text color="teal.800" bold>{item.nhomHoc}</Text></Text>
                    </Box>
                    <Box w="1/3" display="flex" justifyContent="center">
                      <Box pl="3">
                        <Text bold fontSize="xs">GV: TS/Th.s {tkb.tkb.lopHocPhan.giaoVien.tenGiaoVien}</Text>
                        <Text fontSize="xs">Bắt đầu học: {formatDate(tkb.tkb.lopHocPhan.ngayBatDau)} - {formatDate(tkb.tkb.lopHocPhan.ngayKetThuc)}</Text>
                        <Text fontSize="xs">Đã đăng ký: {tkb.tkb.soLuongDaDangKy}/{tkb.tkb.lopHocPhan.soLuongMax} <FontAwesome5 name="user-check" size={12} color="'rgba(5, 148, 78, 0.8)'" /></Text>
                      </Box>
                    </Box>
                  </HStack>
                </Box>
              </Box>
          </Pressable>;
          })
        }
      </>;
    }
  }
  const renderSameTKBItem = (tkb) => {//Hàm nhận vào từng tkb rồi sử lý
    // {tkb: objectTKB, tkbCons:[{obj1}, {obj2}]}
    return <Box bg="coolGray.200" my="1" p="1" borderRadius="md" key={Math.random()}>
      <Text fontSize="xs">Môn: <Text bold>{lhpSelected.monHoc.tenMonHoc}</Text></Text>
      <Divider bg="black"></Divider>
      <HStack>
        <Box w="2/3" borderRightWidth="0.5" borderRightColor="black">
          <Text fontSize="xs">Lịch học: <Text color="teal.800" bold>LT - {tkb.thuHoc} (Tiết {tkb.tuTietHoc} -> {tkb.denTietHoc} )</Text></Text>
          <Text fontSize="xs">Dãy nhà: <Text color="teal.800" bold>{tkb.phongHoc.substring(0,1)}</Text></Text>
          <Text fontSize="xs">Phòng học: <Text color="teal.800" bold>{tkb.phongHoc}</Text></Text>
          <Text fontSize="xs">Nhóm học: <Text color="teal.800" bold>{tkb.nhomHoc}</Text></Text>
        </Box>
        <Box w="1/3">
          <Center>
            <Text bold fontSize="xs">GV: TS/Th.s {lhpSelected.giaoVien.tenGiaoVien}</Text>
            <Text fontSize="xs">Bắt đầu học: {formatDate(lhpSelected.ngayBatDau)} - {formatDate(lhpSelected.ngayKetThuc)}</Text>
          </Center>
        </Box>
      </HStack>
    </Box>;
  }
  const renderLHPRegistered = (lhpRegistered) => {
    let isRequired = <MaterialCommunityIcons name="progress-close" size={16} color="red" />;
    if(lhpRegistered.monHoc.loaiMon === "BAT_BUOC")
      isRequired = <FontAwesome name="check-square-o" size={16} color="green" />;
    return <Pressable key={Math.random()} onPress={() => seeLHPRegistered(lhpRegistered)}>
      <Box bg="teal.400">
        <HStack>
          <Box w="3/6" display="flex" alignItems="center" justifyContent="center">
            <Center>
              <Text bold fontSize="xs">{lhpRegistered.maLopHocPhan} -</Text>
              <Text fontSize="xs">{lhpRegistered.monHoc.tenMonHoc}</Text>
            </Center>
          </Box>
          <Box w="2/6">
            <Text fontSize="xs">Số tín chỉ: {lhpRegistered.monHoc.soTinChi}</Text>
            <Text fontSize="xs">Bắt buộc: {isRequired}</Text>
            <Text fontSize="xs">Cần học: {lhpRegistered.monHoc.maMonYeuCau}</Text>
          </Box>
          <Box w="1/6" display="flex" alignItems="center" justifyContent="center">
            <Center>
              <FontAwesome5 name="hand-sparkles" size={16} color="white" />
              <Text fontSize="xs">Chọn</Text>
            </Center>
          </Box>
        </HStack>
      </Box>
      <Divider bg="black"></Divider>
    </Pressable>;
  }
  const seeLHPRegistered = (lhpRegistered) => {
    selectedLHPRegistered.current = lhpRegistered;
    setModalLHPRegisteredVisible(true);
  }
  /*
    Giải thuật:
    1. render Section LHP selected trước
    2. Output mong mốn:
    [{tkb: objectTKB, tkbCons:[{obj1}, {obj2}]}, {tkb: objectTKB, tkbCons:[]}]
  */
  const seeTimetableClass = async (lhp) => {
    try {
      const javaIp = await publicIP();
      const response = await axios.get("http://"+javaIp+":8080/api/time_table/getTimeTablesByUnitClassId/" + lhp.maLopHocPhan, {headers: {"Authorization": token}});
      setLHPSelected(lhp);
      const tkbs = response.data;
      if(tkbs.length > 0) {
        let multiesTimeTable = [];
        //1. Sử lý output mong muốn
        for(let i=0; i<tkbs.length; i++) {
          const tkb = tkbs[i];
          let tkbCons = [];
          if(tkb.thoiKhoaBieuCons.length > 0) {
            for(let j=0; j<tkb.thoiKhoaBieuCons.length;j++) {
              const tkbCon = tkb.thoiKhoaBieuCons[j];
              tkbCons.push(tkbCon);
            }
          }
          multiesTimeTable.push({tkb: tkb, tkbCons: tkbCons});
        }
        setTkbs(multiesTimeTable);
        setModalTimetablesVisible(true); 
      } else //TH này xảy ra khi click vào LHP mà ko có TKB nào trả về -> sẽ đóng các modal
      setModalUnitClassesVisible(false);
        Toast.show({
            type: 'error',
            text1: 'Không tìm thấy thời khoá biểu nào',
            text2: 'Cho lớp học phần vừa chọn!'
        });
    } catch (error) {
      console.error("seeTimetableClass: ", error.message);
    }
  }
  /*
    Render 1 Section lhp selected trên MODAL TKBS (lhp được chọn)
  */
  const renderLHPSelected = () => {
    if(lhpSelected) {
      let trangThaiBeLike = <Text color="teal.900">Đang chờ sinh viên đăng ký</Text>;
      const myDateString = lhpSelected.ngayBatDau;
      const myD1 = new Date(myDateString);
      let previous7Day = new Date(myD1);
      previous7Day.setDate(previous7Day.getDate() - 7);
      const myD2 = new Date();
      if(myD2 > previous7Day) {
          const diffD = Math.abs(myD2 - previous7Day);
          const one_day=1000*60*60*24;
          const myResult = Math.round(diffD/one_day);
          trangThaiBeLike = <Text color="error.500">Đã hết hạn đăng ký {myResult} ngày trước</Text>;
      }
      return <Box bg="teal.300" borderRadius="md" my="1" p="1">
        <HStack>
          <Box w="2/3">
            <Text fontSize="xs">Mã LHP: <Text color="teal.900">{lhpSelected.maLopHocPhan} - {lhpSelected.tenLopHocPhan}</Text></Text>
            <Text fontSize="xs">Trạng thái: <Text color="error.500">{trangThaiBeLike}</Text></Text>
          </Box>
          <Box w="1/3">
            <Center>
              <Text bold fontSize="xs">{lhpSelected.monHoc.tenMonHoc}</Text>
              <Text fontSize="xs">Đã đăng ký</Text>
              <Text>{lhpSelected.soLuong}/{lhpSelected.soLuongMax} <FontAwesome name="user-circle" size={16} color="black" /></Text>
            </Center>
          </Box>
        </HStack>
      </Box>
    }
    return <Text>Chưa chọn LHP cần xem `Thời Khoá Biểu`!</Text>;
  }
  const renderTKBSelected = () => { //dùng cho renderTKB trùng. TKB này là tkb từ LHP chọn. Chuẩn output: {tkb: objectTKB, tkbCons:[{obj1}, {obj2}]}
    if(lhpSelected && modalSameTimetablesVisible) {
      let legacyStandards = [];
      for(let i=0;i<lhpSelected.thoiKhoaBieus.length;i++) {
        const tkb = lhpSelected.thoiKhoaBieus[i];
        legacyStandards.push(tkb);
        if(tkb.thoiKhoaBieuCons.length > 0) {
          for(let j=0;j<tkb.thoiKhoaBieuCons.length;j++) {
            const tkbCon = tkb.thoiKhoaBieuCons[j];
            legacyStandards.push(tkbCon);
          }
        }
      }
      if(legacyStandards.length <= 0)
        return <Box><Text>Không có thời khoá biểu LHP vừa chọn!</Text></Box>;
      else {
        for(let i=0;i<legacyStandards.length;i++) {
          const legacyStandard = legacyStandards[i];
          return renderSameTKBItem(legacyStandard);
        }
      }
    } else return <Box><Text>Hmm...</Text></Box>
  }
  const renderLHPRegisteredBody = () => {
    if(selectedLHPRegistered.current) {
      const tkbs = selectedLHPRegistered.current.thoiKhoaBieus;
      let tkbCons = [];
      for(let i=0;i<tkbs.length;i++) {
        const tkb = tkbs[i];
        if(tkb.thoiKhoaBieuCons.length > 0 ) {
          for(let j=0;j<tkb.thoiKhoaBieuCons.length;j++) {
            const tkbCon = tkb.thoiKhoaBieuCons[j];
            tkbCons.push(tkbCon);
          }
          
        }
      }
      return <Box>
        <MaterialCommunityIcons name="alert-octagram" size={24} color="black" />
        <Text fontSize="xs">Mã LHP: <Text bold>{selectedLHPRegistered.current.maLopHocPhan}</Text></Text>
        <Text fontSize="xs">Tên lớp đại điện: <Text bold>{selectedLHPRegistered.current.tenLopHocPhan}</Text></Text>
        <Text fontSize="xs">Loại lớp học: <Text bold>{selectedLHPRegistered.current.loaiHoc}</Text></Text>
        <Text fontSize="xs">Tổng đăng ký: <Text bold>{selectedLHPRegistered.current.soLuong}/{selectedLHPRegistered.current.soLuongMax}</Text></Text>
        <Text fontSize="xs">Trạng thái: <Text bold>{selectedLHPRegistered.current.loaiHoc}</Text></Text>
        <Divider bg="black"></Divider>
        <Text fontSize="xs">Th.S / T.S GV: <Text bold>{selectedLHPRegistered.current.tenGiaoVien}</Text></Text>
        <Text fontSize="xs">Thời gian học: <Text bold>{selectedLHPRegistered.current.ngayBatDau} - {selectedLHPRegistered.current.ngayKetThuc}</Text></Text>
        <Text>{'\n'}</Text>
        <MaterialIcons name="menu-book" size={24} color="black" />
        {
          tkbs.map((tkb) => {
            return <Box>
              <Text fontSize="xs">Lịch học LT: <Text bold>Thứ {tkb.thuHoc} ({tkb.tuTietHoc} -> {tkb.denTietHoc})</Text></Text>
              <Text fontSize="xs">Nhóm: <Text bold>{tkb.nhomHoc}</Text></Text>
              <Text fontSize="xs">Dãy nhà: <Text bold>{tkb.phongHoc.substring(0,1)}</Text></Text>
              <Text fontSize="xs">Phòng học: <Text bold>{tkb.phongHoc}</Text></Text>
            </Box>
          })
        }
        {
          (tkbCons.length > 0) &&
          <Box>
              <Text>{'\n'}</Text>
              <MaterialCommunityIcons name="database-cog" size={24} color="black" />
            </Box>
        }
        {
          (tkbCons.length > 0) &&
            tkbCons.map((tkbCon) => {
              return <Box key={Math.random()}>
                <Text fontSize="xs">Lịch học TH: <Text bold>Thứ {tkbCon.thuHoc} ({tkbCon.tuTietHoc} -> {tkbCon.denTietHoc})</Text></Text>
                <Text fontSize="xs">Nhóm: <Text bold>{tkbCon.nhomHoc}</Text></Text>
                <Text fontSize="xs">Dãy nhà: <Text bold>{tkbCon.phongHoc.substring(0,1)}</Text></Text>
                <Text fontSize="xs">Phòng học: <Text bold>{tkbCon.phongHoc}</Text></Text>
                <Text>{'\n'}</Text>
              </Box>
            })
        }
      </Box>;
    } else return <Text>Hmm...</Text>;
  }
  /*
    Hàm lấy data UnitClassess từ db đổ về, khi có data tự render lại do hàm renderLHP() xử lý render
  */
  const seeClassesBySubject = async (maMonHoc) => {
    try {
      const javaIp = await publicIP();
      const response = await axios.get("http://"+javaIp+":8080/api/unit_class/getUnitClassesBySubjectIdAndLoaiHocAndMaKhoaHoc/"+maMonHoc+"/"+loaiHoc+"/"+hocKySelected, {headers: {"Authorization": token}});
      setMonHocSelected(maMonHoc);
      setUnitClasses(response.data);
      setModalUnitClassesVisible(true);
    } catch (error) {
      console.error("seeClassesBySubject: ", error.message);
    }
  }
  function createScale(min, max) {
    return {
      min: min,
      max: max,
      range: max - min
    };
  }
  function compareWithScale(number, scale) {
    if (number < scale.min) { //Điều kiện ảo tưởng và có vẽ ko bao h rơi vào vì T1,T2,T3 truyền vào là fixed
      return -1;
    } else if (number > scale.max) {
      return 1; //1 là ko nằm trong scale
    } else {
      return 0; //Trả về 0 là trùng lịch -> blacklist ngay
    }
  }
  /*
    Siêu giải thuật:
    1. Lấy danh sách lhps từ môn chọn
    2. Lấy danh sách lhps từ sv_lhp (là những lhps sv đã đăng ký). (Premium: Để tránh lãng phí tài nguyên query. Lấy lhps từ svlhp mà theo mã khoá học)
    3. Cho 1 mảng blacklist lhp[]. Chỉ cần thoả điều kiện trùng -> push vào blacklist và break for
    4. 3 đối tượng để liệt vào blacklist: thuHoc, tuTietHoc denTietHoc
    5. Chạy 2 for lồng. Ứng với mỗi lhp từ UnitClasses
      5 Ứng với mỗi lhp svlhp
        5 Nếu thuHoc svlhp [j] == thuHoc lhp unitclasses [i]. Thì kiểm tra field tuTienHoc
          5 Nếu tuTietHoc svlhp [j] == tuTietHoc unitclasses [i] || tuTietHoc svlhp [j] == denTietHoc unitclasses [i]
  */
  const getDataFilterSame = async (unitClasses) => {
    const javaIp = await publicIP();
    const response = await axios.get("http://"+javaIp+":8080/api/unit_class/getUnitClassesStudentRegisterByStudentIdAndMaKhoaHoc/" + currentUser.maSinhVien + "/" + hocKySelected, {headers: {"Authorization": token}});
    const svlhp_lhps = response.data;
    let blackListLHPIds = [];
    for(let i=0; i<unitClasses.length;i++) {
      const systemLHP = unitClasses[i];
      if(systemLHP.thoiKhoaBieus.length <= 0) {
        blackListLHPIds.push(systemLHP.maLopHocPhan);
      } else {
        //Lấy ra tất cả tkb của 1 lhp trong 1000
        let multiesSystemTKBSystemToCheck = [];
        for(let j=0;j<systemLHP.thoiKhoaBieus.length;j++) {
          const systemTKB = systemLHP.thoiKhoaBieus[j];//Ứng với mỗi TKB
          multiesSystemTKBSystemToCheck.push(systemTKB);
          if(systemTKB.thoiKhoaBieuCons.length > 0) {
            for(let k=0;k<systemTKB.thoiKhoaBieuCons.length;k++) {
              const systemTKBCon = systemTKB.thoiKhoaBieuCons[k];
              multiesSystemTKBSystemToCheck.push(systemTKBCon);
            }
          }
        }
        //-> Đã có 1 đống tkbs của unitclassess r đem check vs tkb của mình
        let signalBreaking = false;
        for(let l=0;l<multiesSystemTKBSystemToCheck.length;l++) { //Ứng với mỗi TKB unitclasses cần check
          if(!signalBreaking) {
            const systemTKB = multiesSystemTKBSystemToCheck[l];
            for(let m=0;m<svlhp_lhps.length;m++) {
              if(!signalBreaking) {
                const myLHP = svlhp_lhps[m];
                for(let n=0;n<myLHP.thoiKhoaBieus.length;n++) {//Mỗi tkb của myLHP sẽ đem check
                  const myTKB = myLHP.thoiKhoaBieus[n];
                  if(myTKB.thuHoc == systemTKB.thuHoc) { //Nếu thuHoc == nhau
                    const scale = createScale(myTKB.tuTietHoc, myTKB.denTietHoc);
                    if(compareWithScale(systemTKB.tuTietHoc, scale) == 0){//Nếu systemTKB có tuTietHoc thuộc khoảng scale tuTietHoc - denTietHoc tkb khác cũ của mình thì
                      blackListLHPIds.push(systemLHP.maLopHocPhan);
                      signalBreaking = true;
                      break;
                    }
                  } 
                }
              } else break; //break for này để systemLHP++
            }
          } else break; //break for này để systemLHP++
        }
      }
    }
    let unitClassessFilter = [];
    for(let i=0; i<unitClasses.length;i++) {
      const lhp = unitClasses[i];
      if(!blackListLHPIds.includes(lhp.maLopHocPhan))
        unitClassessFilter.push(lhp);
    }
    return unitClassessFilter;
  }
  const handleFilterSame = async () => {
    if(isFilterSame.current == false) { //Nếu là check vào
      isFilterSame.current = true;
      let unitClassessData = await getDataFilterSame(unitClasses);
      if(isFilterLock.current == true) {//Nếu isFilterLock đang check -> filter x2
        unitClassessData = getDataFilterLock(unitClassessData);
      }
      // implementing...chưa handle th if svlhp_lhps = [];
      setUnitClasses(unitClassessData);
    } else {
      isFilterSame.current = false;
      if(isFilterLock.current == true) {
        isFilterLock.current = false;
        handleFilterLock();
      } else
        seeClassesBySubject(monHocSelected);
    }
  }
  const getDataFilterLock = (unitClasses) => {
    let lhpsUnlocked = [];
    for(let i=0;i<unitClasses.length;i++) {
      const lhp = unitClasses[i];
      const myDateString = lhp.ngayBatDau;
      const myD1 = new Date(myDateString);
      var previous7Day = new Date(myD1);
      previous7Day.setDate(previous7Day.getDate() - 7);
      const myD2 = new Date();
      if(myD2 <= previous7Day) {
        lhpsUnlocked.push(lhp);
      }
    }
    return lhpsUnlocked;
  }
  const handleFilterLock = async () => {
    if(isFilterLock.current == false) {
      isFilterLock.current = true;
      let unitClassessData = getDataFilterLock(unitClasses);
      if(isFilterSame.current == true) {
        unitClassessData = await getDataFilterSame(unitClassessData);
      }
      setUnitClasses(unitClassessData);
    } else {
      isFilterLock.current = false;
      if(isFilterSame.current == true) {//Gọi đến filter nhưng phải uncheck thằng filter thì mới vào đc hàm filter để lọc
        isFilterSame.current = false;
        handleFilterSame();
      }
      else
        seeClassesBySubject(monHocSelected);
    }
    
  }
  const getTKBsBiTrung = async () => {
    const javaIp = await publicIP();
    const response = await axios.get("http://"+javaIp+":8080/api/sv_lhp/getSVLHPStudentRegistered/" + currentUser.maSinhVien + "/" + hocKySelected, {headers: {"Authorization": token}});
    const svlhps = response.data;
    let tkbBiTrung = [];
    let multiesSystemTKBSystemToCheck = [];
    for(let j=0;j<lhpSelected.thoiKhoaBieus.length;j++) {
      const systemTKB = lhpSelected.thoiKhoaBieus[j];//Ứng với mỗi TKB
      multiesSystemTKBSystemToCheck.push(systemTKB);
      if(systemTKB.thoiKhoaBieuCons.length > 0) {
        for(let k=0;k<systemTKB.thoiKhoaBieuCons.length;k++) {
          const systemTKBCon = systemTKB.thoiKhoaBieuCons[k];
          multiesSystemTKBSystemToCheck.push(systemTKBCon);
        }
      }
    }
    for(let l=0;l<multiesSystemTKBSystemToCheck.length;l++) { //Ứng với mỗi TKB unitclasses cần check
      const systemTKB = multiesSystemTKBSystemToCheck[l];
      let mytkbs = [];
      for(let m=0;m<svlhps.length;m++) {
        //Thu thập tkb & tkbcon..
        const svlhp = svlhps[m];
        mytkbs.push(svlhp.thoiKhoaBieu);
        if(svlhp.thoiKhoaBieuCon)
        mytkbs.push(svlhp.thoiKhoaBieuCon)
      }
      for(let n=0;n<mytkbs.length;n++) {
        const myTKB = mytkbs[n];
        if(myTKB.thuHoc == systemTKB.thuHoc) {
          const scale = createScale(myTKB.tuTietHoc, myTKB.denTietHoc);
          if(compareWithScale(systemTKB.tuTietHoc, scale) == 0) {
            tkbBiTrung.push(myTKB);
          }
        }
      }
    }
    return tkbBiTrung;
  }
  const seeSameTimeTables = async () => {
    //Xong for này ta dc 1 list tkbBiTrung chứa tất cả tkb của svlhp. Tuy nhiên mảng object có thể có nhiều object trùng nhau. Nhưng điều lý tưởng này phát sinh khi data lớn
    //Sử lý list mySameTkbs 1 data theo mẫu renderTKBItem(). Chuẩn: [{tkb: objectTKB, tkbCons:[{obj1}, {obj2}]}, {tkb: objectTKB, tkbCons:[]}]
    const tkbBiTrung = await getTKBsBiTrung();
    setMySameTkbs(tkbBiTrung);
    setModalSameTimetablesVisible(true);
  }
  const register = (maThoiKhoaBieu, maThoiKhoaBieuCon) => {//tkb có thể là tkb || tkbCon
    /*
      Test case sequence:
      1. LHP trùng lịch
      2. Đã đăng ký LHP rồi
      3. LHP Đã đủ SL
      4. LHP đã khoá
      5. Thành công
    */
      Alert.alert(
        'Xác nhận',
        'Nếu lớp học phần ở trạng thái `Chấp nhận nmở lớp`. Thì sẽ không thể hủy đăng ký lại nghĩa là chỉ đăng ký được và sẽ không thể huỷ cơ bản được. Và điều đó sẽ rất tệ! Bạn có muốn tiếp tục?',
        [
          {
            text: 'Cancel',
            onPress: () => console.log('No button clicked'),
            style: 'cancel',
          },
          {
            text: 'Continue',
            onPress: async () => {
              console.log("tkb will regis="+maThoiKhoaBieu+"|"+maThoiKhoaBieuCon);
              const tkbBiTrung = await getTKBsBiTrung();
              if(tkbBiTrung.length > 0) {
                setModalTimetablesVisible(false);
                setModalUnitClassesVisible(false);
                Toast.show({
                  type: 'error',
                  text1: 'Đăng ký thất bại',
                  text2: 'Lớp học phần bị trùng lịch.'
                });
              }
              const javaIp = await publicIP();
              const response = await axios.get("http://"+javaIp+":8080/api/time_table/getTimeTableById/"+maThoiKhoaBieu, {headers: {"Authorization": token}});
              if(response.data) {
                const myDateString = response.data.lopHocPhan.ngayBatDau;
                const myD1 = new Date(myDateString);
                var previous7Day = new Date(myD1);
                previous7Day.setDate(previous7Day.getDate() - 7);
                const myD2 = new Date();
              if(myD2 > previous7Day) { {/* Case1: LHP đã regis */}
                setModalTimetablesVisible(false);
                setModalUnitClassesVisible(false);
                Toast.show({
                  type: 'error',
                  text1: 'Đăng ký thất bại',
                  text2: 'Lớp học phần đã hết hạn đăng ký.'
                });
              }
              if(response.data.lopHocPhan.soLuong >= response.data.lopHocPhan.soLuongMax) {
                setModalTimetablesVisible(false);
                setModalUnitClassesVisible(false);
                Toast.show({
                  type: 'error',
                  text1: 'Đăng ký thất bại',
                  text2: 'Lớp học phần đã đủ số lượng.'
                });
              }
              const response2 = await axios.get("http://"+javaIp+":8080/api/sv_lhp/isStudentRegisThisUnitClass/"+lhpSelected.maLopHocPhan+"/"+monHocSelected+"/"+hocKySelected+"/"+currentUser.maSinhVien, {headers: {"Authorization": token}});
              if(response2.data == true) {
                setModalTimetablesVisible(false);
                setModalUnitClassesVisible(false);
                Toast.show({
                  type: 'error',
                  text1: 'Đăng ký thất bại',
                  text2: 'Bạn đã đăng ký LHP này rồi.'
                });
              }
                  const data = {maThoiKhoaBieu, maThoiKhoaBieuCon, maSinhVien: currentUser.maSinhVien};
                  const response3 = await axios.post("http://"+javaIp+":8080/api/sv_lhp/addAndUpdateSoLuong", data, {headers: {"Authorization": token}});
                  if(response3.data) {
                    setModalTimetablesVisible(false);
                    setModalUnitClassesVisible(false);
                    Toast.show({
                      type: 'success',
                      text1: 'Đăng ký Thành công',
                      text2: 'Đăng ký lớp học phần hoàn tất.'
                    });
                  }
              }
            },
          },
        ],
        { cancelable: false }
      );
  }
  const destroy = () => {
    setModalLHPRegisteredVisible(false);
    Alert.alert(
      'Xác nhận',
      'Lớp học phần này sẽ giảm đi số lượng (-1). Và có thể bị dành chỗ mất bởi người khác. Trường hợp LHP không đủ số lượng người đăng ký cũng sẽ bị hủy!',
      [
        {
          text: 'Cancel',
          onPress: () => console.log('No button clicked'),
          style: 'cancel',
        },
        {
          text: 'Continue',
          onPress: async () => {
            // /api/sv_lhp/deleteById/"+maSVLHP
            const javaIp = await publicIP();
            const response = await axios.get("http://"+javaIp+":8080/api/sv_lhp/getSVLHPByMaLopHocPhanId/"+selectedLHPRegistered.current.maLopHocPhan, {headers: {"Authorization": token}});
            const svlhp = response.data;
            const response2 = await axios.delete("http://"+javaIp+":8080/api/sv_lhp/deleteById/"+svlhp.id, {headers: {"Authorization": token}});
            const myStringResult = response2.data;
            if(myStringResult == "OUT_OF_DATE") {
              setModalLHPRegisteredVisible(false);
              Toast.show({
                type: 'error',
                text1: 'Thất bại',
                text2: 'Lớp học ở trạng thái "Đã Khóa" hoặc "Chấp Nhận Mở Lớp" sẽ không thể hủy được!'
              });
            } else {
              if(myStringResult == "OK") {
                setModalLHPRegisteredVisible(false);
                Toast.show({
                  type: 'success',
                  text1: 'Thành công',
                  text2: 'Đã hủy thành công lớp học phần.'
                });
              } else {
                setModalLHPRegisteredVisible(false);
                Toast.show({
                  type: 'error',
                  text1: 'Thất bại',
                  text2: 'Internal Server Error'
                });
              }
            }
          },
        },
      ],
      { cancelable: false }
    );
  }
  React.useEffect(() => {
    const getCourses = async () => {
      try {
        const javaIp = await publicIP();
        const response = await axios.get("http://"+javaIp+":8080/api/course/getCourses", {headers: {"Authorization": token}});
        latestCourseId.current = response.data[response.data.length-1].maKhoaHoc;
        setCourses(response.data);
      } catch (error) {
        console.error(error.message);
      }
    }
    getCourses();
  }, [])

  return (
    <NativeBaseProvider>
      <Box zIndex="1"><Toast position='top' /></Box>
          <Box> {/* Thanh select học kỳ */}
            <Select
              selectedValue={hocKySelected}
              minWidth="200"
              accessibilityLabel="Chọn đợt đăng ký học phần"
              placeholder="Chọn đợt đăng ký học phần"
              _selectedItem={{
                bg: "teal.600",
                endIcon: <CheckIcon size="5" />
              }} mt={1}
              onValueChange={itemValue => onChangeHocKySelected(itemValue)}
              >
              {
                courses.map((item) => {
                  let isLatestMaKhoaHoc = " ❌";
                  if(item.maKhoaHoc == latestCourseId.current)
                    isLatestMaKhoaHoc = " ✔️";
                  return <Select.Item label={item.alias + " (" + item.namBatDau + "-" + item.namKetThuc + ")" + isLatestMaKhoaHoc} value={item.maKhoaHoc} key={Math.random()} />
                })
              }
            </Select>
          </Box>
          <Box> {/* Radio select loại học kỳ*/}
            <Radio.Group
              name="myRadioGroup"
              value={loaiHoc}
              onChange={(nextValue) => {setLoaiHoc(nextValue)}}
              colorScheme="emerald"
              accessibilityLabel="favorite number"
            >
              <HStack space="3">
                <Radio size="sm" value="HOC_MOI"><Text fontSize="xs">Học mới</Text></Radio>
                <Radio size="sm" value="HOC_LAI"><Text fontSize="xs">Học lại</Text></Radio>
                <Radio size="sm" value="HOC_CAI_THIEN"><Text fontSize="xs">Học cải thiện</Text></Radio>
              </HStack>
            </Radio.Group>
          </Box>
          <Box flex="1"> {/* List subjects */}
            <ScrollView horizontal>
              <Box maxW="100%">
                <ScrollView>
                  <Text><Entypo name="book" size={24} color="teal" /> Danh sách môn học chờ đăng ký:</Text>
                  <Box borderWidth="0.5" borderColor="gray.400" borderRadius="sm" p="1" my="1">
                    {
                      (subjects.length > 0) ?
                      subjects.map((item) => {
                        let isRequired = <MaterialCommunityIcons name="progress-close" size={16} color="red" />;
                        if(item.loaiMon === "BAT_BUOC")
                          isRequired = <FontAwesome name="check-square-o" size={16} color="green" />;
                        return <Pressable onPress={() => seeClassesBySubject(item.maMonHoc)} key={Math.random()}>
                        <Box bg="teal.400" borderBottomColor="black" borderBottomWidth="0.5">
                          <HStack>
                            <Box w="3/6" display="flex" alignItems="center" justifyContent="center">
                              <Center>
                                <Text bold fontSize="xs">{item.maMonHoc} -</Text>
                                <Text fontSize="xs">{item.tenMonHoc}</Text>
                              </Center>
                            </Box>
                            <Box w="2/6">
                              <Text fontSize="xs">Số tín chỉ: {item.soTinChi}</Text>
                              <Text fontSize="xs">Bắt buộc: {isRequired}</Text>
                              <Text fontSize="xs">Môn ràng buộc: {item.maMonYeuCau != 0 ? <Text bold color="red.500">{item.maMonYeuCau}</Text> : "Không"}</Text>
                            </Box>
                            <Box w="1/6" display="flex" alignItems="center" justifyContent="center">
                              <Center>
                                <FontAwesome5 name="hand-sparkles" size={16} color="white" />
                                <Text fontSize="xs">Chọn</Text>
                              </Center>
                            </Box>
                          </HStack>
                        </Box>
                      </Pressable>
                      })
                      : <Box px="2"><Text>Không / chưa học kỳ được chọn!</Text></Box>
                    }
                  </Box>
                </ScrollView>
              </Box>
              <Box maxW="100%" pl="2">
                <Text><Entypo name="download" size={24} color="teal" /> Danh sách học phần / lớp học phần đã đăng ký.......:</Text>
                <Box borderWidth="0.5" borderColor="gray.400" borderRadius="sm" py="2" >
                  <ScrollView>
                  {
                    (unitClassesRegistered.length > 0) ?
                    unitClassesRegistered.map((lhpRegistered) => {
                      return renderLHPRegistered(lhpRegistered);
                    })
                    : <Box px="2"><Text>Không / chưa có LHP nào được đăng ký!</Text></Box>
                  }
                  <Text>{'\n'}</Text>
                  </ScrollView>
                </Box>
              </Box>
            </ScrollView>
          </Box>
      

      <Modal isOpen={modalUnitClassesVisible} onClose={() => setModalUnitClassesVisible(false)} size={"xl"}>
        <Modal.Content>
          <Modal.CloseButton />
          <Modal.Header>
            <Text>Danh sách lớp học phần:</Text>
            <Text fontSize="xs">(Được mở theo môn chọn) | <Text bold color="teal.900">{loaiHocShortcut[loaiHoc]}</Text></Text>
          </Modal.Header>
          <Modal.Body>
            <ScrollView>
              <Text>Có thể nhấp chọn LHP bên dưới:</Text>
                <Checkbox
                  value="Photography"
                  checked={isFilterSame.current}
                  onPress={handleFilterSame}
                ><Text fontSize="xs">Hiển thị LHP ko trùng lịch</Text></Checkbox>
                <Checkbox
                  value="Photography2"
                  checked={isFilterLock.current}
                  onPress={handleFilterLock}
                ><Text fontSize="xs">Hiển thị LHP chưa khoá</Text></Checkbox>
              <Divider my="3"></Divider>
              {/* FlatList LHP come from here!! */}
              {
                unitClasses.length > 0 ?
                  unitClasses.map((item) => {
                    return renderLHP(item);
                  })
                : <Text bold fontSize="xs" color="blue.700">Không tìm thấy LHP nào được mở!</Text>
              }
            </ScrollView>
          </Modal.Body>
          <Modal.Footer>
            <Button.Group space={2}>
              <Button variant="ghost" colorScheme="blueGray" onPress={() => {
              setModalUnitClassesVisible(false);
            }}>
                Cancel
              </Button>
            </Button.Group>
          </Modal.Footer>
        </Modal.Content>
      </Modal>
      <Modal isOpen={modalTimetablesVisible} onClose={() => setModalTimetablesVisible(false)} size={"xl"}>
        <Modal.Content>
          <Modal.CloseButton />
          <Modal.Header>
            <Text>Danh sách thời khoá biểu:</Text>
            <Text fontSize="xs">(Thời khoá biểu cho LHP vừa chọn)</Text>
          </Modal.Header>
          <Modal.Body>
            <ScrollView>
              <Text fontSize="xs">Lớp học phần vừa chọn:</Text>
              {renderLHPSelected()}
              <Divider my="3"></Divider>
              <Text fontSize="xs">Danh sách TKBs:</Text>
              {/* FlatList Timetables come from here!! */}
              {
                tkbs.map((item) => {
                  return renderTKBItem(item);
                })
              }
              <Box><Button bg="teal.500" onPress={() => seeSameTimeTables()}>Xem lịch trùng</Button></Box>
            </ScrollView>
          </Modal.Body>
          <Modal.Footer>
            <Button.Group space={2}>
              <Button
                variant="ghost"
                colorScheme="blueGray"
                onPress={() => {
                  setModalTimetablesVisible(false);
                }}
              >
                Cancel
              </Button>
            </Button.Group>
          </Modal.Footer>
        </Modal.Content>
      </Modal>
      <Modal isOpen={modalSameTimetablesVisible} onClose={() => setModalSameTimetablesVisible(false)} size={"xl"}>
        <Modal.Content>
          <Modal.CloseButton />
          <Modal.Header>
            <Text>Danh sách thời khoá biểu trùng:</Text>
            <Text fontSize="xs">(Trùng với TKB cá nhân)</Text>
          </Modal.Header>
          <Modal.Body>
            <ScrollView>
              <Text fontSize="xs">Lịch trùng lớp học phần chọn:</Text>
              {renderTKBSelected()}
              <Divider my="3"></Divider>
              <Text fontSize="xs" color="error.600" bold>Lịch trùng của bạn:</Text>
              {/* FlatList Timetables come from here!! */}
              {
                (mySameTkbs.length > 0) ?
                  mySameTkbs.map((item) => {
                    return renderSameTKBItem(item);
                  })
                : <Text fontSize="xs">(Không)</Text>
              }
            </ScrollView>
          </Modal.Body>
          <Modal.Footer>
            <Button.Group space={2}>
              <Button
                variant="ghost"
                colorScheme="blueGray"
                onPress={() => {
                  setModalSameTimetablesVisible(false);
                }}
              >
                Cancel
              </Button>
            </Button.Group>
          </Modal.Footer>
        </Modal.Content>
      </Modal>
      <Modal isOpen={modalLHPRegisteredVisible} onClose={() => setModalLHPRegisteredVisible(false)} size={"xl"} _backdrop={{
          _dark: {
            bg: "coolGray.800"
          },
          bg: "warmGray.50"
        }}
      >
        <Modal.Content>
          <Modal.CloseButton />
          <Modal.Header>
            <Text fontSize="xs">Thông tin lớp học phần:</Text>
            <Text fontSize="xs">(LHP đã đăng ký)</Text>
          </Modal.Header>
          <Modal.Body>
            {renderLHPRegisteredBody()}
          </Modal.Body>
          <Modal.Footer>
            <Button.Group space={2}>
              <Button variant="ghost" colorScheme="blueGray" onPress={() => {
              setModalLHPRegisteredVisible(false);
            }}>
                Cancel
              </Button>
              <Button variant="subtle" colorScheme="secondary" onPress={() => {
              destroy();
            }}>
                Huỷ lớp
              </Button>
            </Button.Group>
          </Modal.Footer>
        </Modal.Content>
      </Modal>
    </NativeBaseProvider>
  )
}

export default DkhpPage