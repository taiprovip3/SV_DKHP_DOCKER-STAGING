function changeTimeTable(maLopHocPhan) {
    selected_ma_lop_hoc_phan = maLopHocPhan;
    $.ajax({
        type: "POST",
        url: pathNodejs+"/student/dkhp/getTimeTablesByUnitClassId",
        data: JSON.stringify({maLopHocPhan}),
        contentType: 'application/json',
        success: function(data) {
            if(data.length > 0) {
                //Sử lý tHead
                var timeLeft = 'Trạng thái: <span class="fw-bold text-danger">Đã khóa</span>';
                const myDateString = data[0].lopHocPhan.ngayBatDau;
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
                var myLoop = "";
                for(var i=0; i<data.length; i++) {
                    myLoop += renderTrsTKB(data[i]);//mỗi 1tkb trả về 2tr nối nhau
                }
                $("#tab2TBody").html(myLoop);
            } else {//TH data ThoiKhoaBieu (rỗng) -> id thead, tbody đã tồn tại
                const emptyTHead = '<tr>'+
                        '<th></th>'+
                        '<th>Trạng thái: <span class="fw-bold text-danger">Đã khóa</span></th>'+
                        '<th>Nhóm học</th>'+
                        '<th>Thông tin thêm</th>'+
                    '</tr>';
                $("#tab2THead").html(emptyTHead);
                const emptyTBody = '<tr>'+
                        '<td></td>'+
                        '<td></td>'+
                        '<td>Chưa lên kế hoạch lịch học</td>'+
                        '<td></td>'+
                    '</tr>';
                $("#tab2TBody").html(emptyTBody);
                changeTimeTableIdListener('');
            }
        }, error: function(error) {
            console.error(error);
        }
    });
}