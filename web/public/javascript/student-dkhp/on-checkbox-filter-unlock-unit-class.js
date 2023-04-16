function getIdLHPUnlockUnitClass() {//trả về list id LHP chưa khoá
    return $.ajax({
        type: "POST",
        url: "<%= process.env.SELF_EJS_API_URL %>/student/dkhp/getUnitClassesBySubjectIdAndLoaiHocAndMaKhoaHoc",
        data: JSON.stringify({maMonHoc: selected_ma_mon_hoc, loaiHoc: selected_loai_hoc, maKhoaHoc: selected_ma_khoa_hoc}),
        contentType: 'application/json',
    })
    .then(LHPs => {
        var idFiltered = [];
        for(let i=0;i<LHPs.length;i++) {
            const lhp = LHPs[i];
            const myDateString = lhp.ngayBatDau;
            const myD1 = new Date(myDateString);
            var previous7Day = new Date(myD1);
            previous7Day.setDate(previous7Day.getDate() - 7);
            const myD2 = new Date();
            if(myD2 <= previous7Day) {
                idFiltered.push(lhp.maLopHocPhan);
            }
        }
        return idFiltered;
    });
}
async function onCheckUnlockUnitClass(val) {
    audio.play();
    const myCheckBox = document.getElementById("SHOW_NON_LOCK_UNIT_CLASS");
    if(myCheckBox.checked) {
        if(selected_ma_lop_hoc_phan) {
            var LHPsFiltered = [];
            if(global_filter_same_unit_class_checked) {//Filter x2
                const idLHPsUnLock = await getIdLHPUnlockUnitClass();
                const idBlacklist = await getIdBlackListLHPSameUnitClass();
                for(let i=0;i<idLHPsUnLock.length;i++) {
                    const lhp = await getLHPById(idLHPsUnLock[i]);
                    if(!idBlacklist.includes(lhp.maLopHocPhan))
                        LHPsFiltered.push(lhp);
                }
            } else {//Filter x1 only for unlock
                const idLHPsUnLock = await getIdLHPUnlockUnitClass();
                for(let i=0;i<idLHPsUnLock.length;i++) {
                    const lhp = await getLHPById(idLHPsUnLock[i]);
                    LHPsFiltered.push(lhp);
                }
            }
            var trsUnitClasses = "";
            var trsTimeTables = "";
            for(let i=0; i<LHPsFiltered.length;i++) {
                var trangThaiBeLike = '<span class="fw-bold text-success">Đang chờ sinh viên đăng ký</span>';
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
            }//end for
            global_filter_unlock_unit_class_checked = "checked";
            if(trsUnitClasses == "") {
                $("#tab1TBody").html("Không tìm thấy dữ liệu phù hợp!");
                $("#tab2TBody").html("Không tìm thấy dữ liệu phù hợp!");
            }
            else {
                renderListUnitClass(trsUnitClasses, trsTimeTables);
                changeTimeTable(selected_ma_lop_hoc_phan);;
            }
        }
    } else {
        global_filter_unlock_unit_class_checked = "";
        renderUnitClassBySujectId();
    }
}