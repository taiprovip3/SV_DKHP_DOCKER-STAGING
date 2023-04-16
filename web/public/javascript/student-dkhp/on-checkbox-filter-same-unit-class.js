async function onCheckSameUnitClass(val) {
    audio.play();
    //1. Chkbox thuộc datatab, chưa check. Khi check vô -> rơi vào if này -> tiến hành filter
    //2. Filter xong -> set global_filter_same_unit_class_checked thành checked
    //Nếu filter xong -> ko có LHP nào -> myCheckBox -> biến mất -> sẽ ko rơi if hay else mà throw excep
    //Vậy nên nếu ko tồn tại myCHeckBox sẽ render lại toàn Div2
    const myCheckBox = document.getElementById("SHOW_NON_SAME_UNIT_CLASS");
    if(myCheckBox.checked) {
        if(selected_ma_lop_hoc_phan) {
            $.ajax({
                type: "POST",
                url: "<%= process.env.SELF_EJS_API_URL %>/student/dkhp/getUnitClassesBySubjectIdAndLoaiHocAndMaKhoaHoc",
                data: JSON.stringify({maMonHoc: selected_ma_mon_hoc, loaiHoc: selected_loai_hoc, maKhoaHoc: selected_ma_khoa_hoc}),
                contentType: 'application/json',
                success: async function(LHPs) {
                    var LHPsFiltered = [];
                    if(global_filter_unlock_unit_class_checked) {//Thật toán filter x2 lần
                        const idBlacklist = await getIdBlackListLHPSameUnitClass();
                        for(let i=0;i<LHPs.length;i++) {
                            const lhp = LHPs[i];
                            const myDateString = lhp.ngayBatDau;
                            const myD1 = new Date(myDateString);
                            var previous7Day = new Date(myD1);
                            previous7Day.setDate(previous7Day.getDate() - 7);
                            const myD2 = new Date();
                            if(myD2 <= previous7Day) {
                                const diffD = Math.abs(myD2 - previous7Day);
                                const one_day=1000*60*60*24;
                                const myResult = Math.round(diffD/one_day);
                                timeLeft = 'Khóa sau: <span class="fw-bold text-success">'+ (myResult <10 ? "0"+myResult : myResult) +'</span> ngày nữa';
                            }
                            if(!idBlacklist.includes(lhp.maLopHocPhan) && myD2 <= previous7Day)
                                LHPsFiltered.push(lhp);
                        }
                        console.log("LHPsFiltered x2: ", LHPsFiltered);
                    } else { //Thuật toán filter x1
                        const idBlacklist = await getIdBlackListLHPSameUnitClass();
                        for(let i=0;i<LHPs.length;i++) {
                            if(!idBlacklist.includes(LHPs[i].maLopHocPhan))
                                LHPsFiltered.push(LHPs[i]);
                        }
                        console.log("LHPsFiltered x1: ", LHPsFiltered);
                    }
                    //Đã có LHPsFiltered -> render lại ListUnitClass
                    var trsUnitClasses = "";
                    var trsTimeTables = "";
                    for(let i=0; i<LHPsFiltered.length;i++) {
                        var trangThaiBeLike = '<span class="fw-bold text-success">Đang chờ sinh viên đăng ký</span>';
                        const myDateString = LHPsFiltered[i].ngayBatDau;
                        const myD1 = new Date(myDateString);
                        var previous7Day = new Date(myD1);
                        previous7Day.setDate(previous7Day.getDate() - 7);
                        const myD2 = new Date();
                        if(myD2 > previous7Day) {
                            const diffD = Math.abs(myD2 - previous7Day);
                            const one_day=1000*60*60*24;
                            const myResult = Math.round(diffD/one_day);
                            var trangThaiBeLike = '<span class="fw-bold text-danger">Đã hết hạn đăng ký '+ myResult +' ngày trước</span>';
                        }
                        var radioButtonBeLike = '<input type="radio" name="SelectedUnitClass" id="'+ LHPsFiltered[i].maLopHocPhan +'" value="'+ LHPsFiltered[i].maLopHocPhan +'" class="form-check-input" onchange="changeTimeTable(this.value)">';
                        if(i == 0) {
                            radioButtonBeLike = '<input type="radio" name="SelectedUnitClass" id="'+ LHPsFiltered[i].maLopHocPhan +'" value="'+ LHPsFiltered[i].maLopHocPhan +'" class="form-check-input" onchange="changeTimeTable(this.value)" checked>';
                        }
                        selected_ma_lop_hoc_phan = LHPsFiltered[0].maLopHocPhan;
                        trsUnitClasses += 
                            '<tr>'+
                                '<td>'+ radioButtonBeLike +'</td>'+
                                '<td>'+ parseInt(i+1) +'</td>'+
                                '<td>'+
                                    '<ul>'+
                                        '<li class="fw-bold text-uppercase">'+ LHPsFiltered[i].monHoc.tenMonHoc +'</li>'+
                                        '<li>Trạng thái: <span class="fw-bold">'+ trangThaiBeLike +'</span></li>'+
                                        '<li>Lớp học phần: <span class="fw-bold">'+ LHPsFiltered[i].maLopHocPhan +' - '+ LHPsFiltered[i].tenLopHocPhan +'</span></li>'+
                                    '</ul>'+
                                '</td>'+
                                '<td class="text-center">'+
                                    '<span>'+ LHPsFiltered[i].soLuong +'</span>/<span>'+ LHPsFiltered[i].soLuongMax +'</span>'+
                                '</td>'+
                            '</tr>';
                    }
                    global_filter_same_unit_class_checked = "checked";
                    if(trsUnitClasses == "") {
                        $("#tab1TBody").html("Không tìm thấy dữ liệu phù hợp!");
                        $("#tab2TBody").html("Không tìm thấy dữ liệu phù hợp!");
                    }
                    else {
                        renderListUnitClass(trsUnitClasses, trsTimeTables);
                        changeTimeTable(selected_ma_lop_hoc_phan);
                    }
                }//end success
            });
        }
    } else {
        global_filter_same_unit_class_checked = "";
        renderUnitClassBySujectId();
    }
}