function renderTrsTKB(tkb) {
    let embedElement = "";
    if(tkb.thoiKhoaBieuCons.length <= 0) {//Nếu tkbLT ko có tkbTH nào
        let radioSelect = '<input type="radio" name="SelectedTimeTable" id="'+ tkb.maThoiKhoaBieu +'" value="'+ tkb.maThoiKhoaBieu +'" class="form-check-input" onchange="changeTimeTableIdListener(this.value,0);" checked onclick="audio.play();" />';
        changeTimeTableIdListener(tkb.maThoiKhoaBieu, 0);
        embedElement += 
        '<tr>'+
            '<td>'+ radioSelect +'</td>'+
            '<td>'+
                '<ul style="list-style-type: square;">'+
                    '<li>Lịch học: <span class="fw-bold">'+ tkb.loaiBuoiHoc +' - '+ tkb.thuHoc +' (Tiết '+ tkb.tuTietHoc +' -> '+ tkb.denTietHoc +' )</span></li>'+
                    '<li>Dãy nhà: <span class="fw-bold">'+ tkb.phongHoc +'</span></li>'+
                    '<li>Phòng: <span class="fw-bold">'+ tkb.phongHoc +'</span></li>'+
                '</ul>'+
            '</td>'+
            '<td class="text-center">Không phân nhóm</td>'+
            '<td>'+
                '<ul style="list-style-type: square;">'+
                    '<li>GV: <span class="fw-bol">TS/Th.s '+ tkb.lopHocPhan.giaoVien.tenGiaoVien +'</span></li>'+
                    '<li>Bắt đầu học: <span class="fw-bold">'+ formatDate(tkb.lopHocPhan.ngayBatDau) +'</span> - <span class="fw-bold">'+ formatDate(tkb.lopHocPhan.ngayKetThuc) +'</span></li>'+
                    '<li>Đã đăng ký: <span>'+ tkb.soLuongDaDangKy +'</span>/<span>'+ tkb.lopHocPhan.soLuongMax +'</span></li>'+
            '</td>'+
        '</tr>';
    } else {
        changeTimeTableIdListener(tkb.maThoiKhoaBieu, 1);
        for(let i=0; i<tkb.thoiKhoaBieuCons.length; i++) { //sử lý cái tkb mà có các tkb con
            const tkbCon = tkb.thoiKhoaBieuCons[i];
            let radioSelect2 = '<input type="radio" name="SelectedTimeTable" id="'+ tkb.maThoiKhoaBieu +'" value="'+ tkb.maThoiKhoaBieu +'" class="form-check-input" onchange="changeTimeTableIdListener(this.value,'+ tkbCon.maThoiKhoaBieuCon +');" onclick="audio.play();" />';
            if(i == 0) {
                radioSelect2 = '<input type="radio" name="SelectedTimeTable" id="'+ tkb.maThoiKhoaBieu +'" value="'+ tkb.maThoiKhoaBieu +'" class="form-check-input" onchange="changeTimeTableIdListener(this.value,'+ tkbCon.maThoiKhoaBieuCon +');" checked onclick="audio.play();" />';
            }
            embedElement += 
            '<tr>'+
                '<td>'+ radioSelect2 +'</td>'+
                '<td>'+
                    '<span>Lý thuyết:</span>'+
                    '<ul style="list-style-type: square;">'+
                        '<li>Lịch học: <span class="fw-bold">'+ tkb.thuHoc +' (Tiết '+ tkb.tuTietHoc +' -> '+ tkb.denTietHoc +')</span></li>'+
                        '<li>Dãy nhà: <span class="fw-bold">'+ tkb.phongHoc.substring(0,1) +'</span>, phòng <span class="fw-bold">'+ tkb.phongHoc +'</span></li>'+
                    '</ul>'+
                    '<span>Thực hành:</span>'+
                    '<ul style="list-style-type: square;">'+
                        '<li>Lịch học: <span class="fw-bold">'+  tkbCon.thuHoc +' (Tiết '+  tkbCon.tuTietHoc +' -> '+  tkbCon.denTietHoc +')</span></li>'+
                        '<li>Dãy nhà: <span class="fw-bold">'+ tkbCon.phongHoc.substring(0,1) +'</span>, phòng <span class="fw-bold">'+ tkbCon.phongHoc +'</span></li>'+
                    '</ul>'+
                '</td>'+
                '<td class="text-center">'+
                    '<p>LT - Nhóm 0</p><br><br>'+
                    '<p>TH - Nhóm '+ tkbCon.nhomHoc +'</p>'+
                '</td>'+
                '<td>'+
                    '<ul style="list-style-type: square;">'+
                        '<li>GV Lý thuyết: <span class="fw-bol">TS/Th.s '+ tkb.lopHocPhan.giaoVien.tenGiaoVien +'</span></li>'+
                        '<li>GV Thực hành: <span class="fw-bol">TS/Th.s '+ tkbCon.giaoVien.tenGiaoVien +'</span></li>'+
                        '<li>Bắt đầu học: <span class="fw-bold">'+ formatDate(tkb.lopHocPhan.ngayBatDau) +'</span> - <span class="fw-bold">'+ formatDate(tkb.lopHocPhan.ngayKetThuc) +'</span></li>'+
                        '<li>Đã đăng ký: <span>'+ tkbCon.soLuongDaDangKy +'</span>/<span>'+ Math.floor(tkb.lopHocPhan.soLuongMax / tkb.thoiKhoaBieuCons.length) +'</span></li>'+
                    '</ul>'+
                '</td>'+
            '</tr>';
        }
    }
    return embedElement;
}