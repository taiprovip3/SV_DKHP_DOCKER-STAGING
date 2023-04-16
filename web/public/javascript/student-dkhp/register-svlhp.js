function register() {
    audio.play();
    if(selected_ma_thoi_khoa_bieu !== '') {
        swal({
            title: "Bạn có chắc chắn?",
            text: "Nếu lớp học phần "+ selected_ma_lop_hoc_phan +" ở trạng thái`Chấp nhận\nmở lớp`. Thì sẽ không thể hủy đăng ký lại.\nVà điều đó sẽ rất tệ!",
            icon: "warning",
            buttons: true,
            dangerMode: true,
        }).then(async (willDelete) => {
            if(willDelete) {
                //Thuật toán & điều kiện & testcase
                // 1. Kiểm tra nếu đăng ký mã LHP này thì coi LHP này có trùng lịch với LHP nào trong myLHP hay ko;
                // 2. save sv_lhp
                audio.play();
                const serverThoiKhoaBieus = await getTimeTablesByUnitClassId();
                const LHPsRegistered = await getUnitClassesStudentRegisterByStudentIdAndMaKhoaHoc();
                var misLHPsTKBs = [];
                for(let i=0; i<LHPsRegistered.length; i++) {
                    const lhp = LHPsRegistered[i];
                    const timeTables = await getTimeTables(lhp.maLopHocPhan);
                    misLHPsTKBs.push({lopHocPhan: lhp, thoiKhoaBieus: timeTables});
                }
                var blackListServerTKBs = [];
                var blackListMyTKBs = [];
                for(let i=0; i<misLHPsTKBs.length; i++) {
                    const objectMine = misLHPsTKBs[i];
                    for(let j=0; j<objectMine.thoiKhoaBieus.length; j++) {
                        const myThuHoc = objectMine.thoiKhoaBieus[j].thuHoc;
                        const myTuTietHoc = objectMine.thoiKhoaBieus[j].tuTietHoc;
                        const myDenTietHoc = objectMine.thoiKhoaBieus[j].denTietHoc;
                        for(let k=0; k<serverThoiKhoaBieus.length; k++) {
                            const serverThuHoc = serverThoiKhoaBieus[k].thuHoc;
                            const serverTuTietHoc = serverThoiKhoaBieus[k].tuTietHoc;
                            const serverDenTietHoc = serverThoiKhoaBieus[k].denTietHoc;
                            if(serverThuHoc == myThuHoc)
                                if(serverTuTietHoc == myTuTietHoc || serverTuTietHoc == myDenTietHoc) {
                                    blackListServerTKBs.push(serverThoiKhoaBieus[k]);
                                    blackListMyTKBs.push(objectMine.thoiKhoaBieus[j]);
                                }
                        }
                    }
                }
                if(blackListServerTKBs.length > 0 || blackListMyTKBs > 0) {
                    swal({title: "Thất bại!",text: "Lớp học phần này bị trùng lịch",icon: "warning", dangerMode: true});
                    return;
                }
                $.ajax({
                    type: "POST",
                    url: "<%= process.env.SELF_EJS_API_URL %>/student/dkhp/sv_lhp",
                    data: JSON.stringify({ maThoiKhoaBieu: selected_ma_thoi_khoa_bieu, maThoiKhoaBieuCon: selected_thoi_khoa_bieu_con, maMonHoc: selected_ma_mon_hoc, maKhoaHoc: selected_ma_khoa_hoc }),
                    contentType: 'application/json',
                    success: function(data) {
                        if(data.command === "REFRESH_PAGE") {
                            swal({title: data.title,text: data.text,icon: data.icon, dangerMode: data.dangerMode})
                                .then((value) => {
                                    audio.play();
                                    location.reload();
                                });
                        } else {
                            swal({title: data.title,text: data.text,icon: data.icon, dangerMode: data.dangerMode});
                        }
                    }
                });
            } else audio.play();
        });
    } else {
        //toast here....
    }
}