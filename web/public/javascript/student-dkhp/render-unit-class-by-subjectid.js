function renderUnitClassBySujectId() {
    $.ajax({
        type: "POST",
        url: "<%= process.env.SELF_EJS_API_URL %>/student/dkhp/getUnitClassesBySubjectIdAndLoaiHocAndMaKhoaHoc",
        data: JSON.stringify({maMonHoc: selected_ma_mon_hoc, loaiHoc: selected_loai_hoc, maKhoaHoc: selected_ma_khoa_hoc}),
        contentType: 'application/json',
        success: function(data) {
            console.log('mydata: ', data);
            if(data.length <= 0) {
                $("#ListUnitClass").html(renderEmptyDivUnitClass());
                selected_ma_lop_hoc_phan = '';
            } else {//Sử lý tab1
                var trsUnitClasses = '';
                var trsTimeTables ='<tr><td></td><td></td><td>Chưa lên kế hoạch lịch học</td><td></td></tr>';
                for(let i=0; i<data.length;i++) {
                    //Bảng 1
                    var trangThaiBeLike = '<span class="fw-bold text-success">Đang chờ sinh viên đăng ký</span>';
                    const myDateString = data[i].ngayBatDau;
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
                    var radioButtonBeLike = '<input type="radio" name="SelectedUnitClass" id="'+ data[i].maLopHocPhan +'" value="'+ data[i].maLopHocPhan +'" class="form-check-input" onchange="changeTimeTable(this.value)" onclick="audio.play();" />';
                    if(i == 0) {
                        radioButtonBeLike = '<input type="radio" name="SelectedUnitClass" id="'+ data[i].maLopHocPhan +'" value="'+ data[i].maLopHocPhan +'" class="form-check-input" onchange="changeTimeTable(this.value)" checked onclick="audio.play();" />';
                    }
                    selected_ma_lop_hoc_phan = data[0].maLopHocPhan;
                    trsUnitClasses += 
                        '<tr>'+
                            '<td>'+ radioButtonBeLike +'</td>'+
                            '<td>'+ parseInt(i+1) +'</td>'+
                            '<td>'+
                                '<ul>'+
                                    '<li class="fw-bold text-uppercase">'+ data[i].monHoc.tenMonHoc +'</li>'+
                                    '<li>Trạng thái: <span class="fw-bold">'+ trangThaiBeLike +'</span></li>'+
                                    '<li>Lớp học phần: <span class="fw-bold">'+ data[i].maLopHocPhan +' - '+ data[i].tenLopHocPhan +'</span></li>'+
                                '</ul>'+
                            '</td>'+
                            '<td class="text-center">'+
                                '<span>'+ data[i].soLuong +'</span>/<span>'+ data[i].soLuongMax +'</span>'+
                            '</td>'+
                        '</tr>';
                }//end for, we have trsUnitClasses
                renderListUnitClass(trsUnitClasses, trsTimeTables);
            }
        }, error: function(error) {
            console.error(error);
        }, complete: function() {//Sử lý tab2
            if(selected_ma_lop_hoc_phan != '') {
                $.ajax({
                    type: "POST",
                    url: "<%= process.env.SELF_EJS_API_URL %>/student/dkhp/getTimeTablesByUnitClassId",
                    data: JSON.stringify({maLopHocPhan: selected_ma_lop_hoc_phan}),
                    contentType: 'application/json',
                    success: function(tkbsLT) {
                        console.log('mydata2: ', tkbsLT);
                        if(tkbsLT.length > 0) {
                            //Sử lý tHead
                            var timeLeft = 'Trạng thái: <span class="fw-bold text-danger">Đã khóa</span>';
                            const myDateString = tkbsLT[0].ngayBatDau;
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
                            var tab2HeadElement =
                            '<tr>'+
                                '<th></th>'+
                                '<th>'+ timeLeft +'</th>'+
                                '<th>Nhóm học</th>'+
                                '<th>Thông tin thêm</th>'+
                            '</tr>';
                            $("#tab2THead").html(tab2HeadElement);
                            //Sử lý tBody. tkbsLT: list all tkb, data2: list tkb đơn
                            var myLoop = "";
                            for(var i=0; i<tkbsLT.length; i++) {
                                myLoop += renderTrsTKB(tkbsLT[i]);//mỗi 1tkb trả về 2tr nối nhau
                            }
                            $("#tab2TBody").html(myLoop);
                        }
                    }, error: function(error) {
                        console.error(error);
                    }
                });
            }
        }
    });
}