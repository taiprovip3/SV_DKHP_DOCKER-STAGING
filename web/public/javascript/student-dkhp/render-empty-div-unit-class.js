function renderEmptyDivUnitClass(){
    const empty = 
    '<div class="w-100 pe-1">'+
        '<div class="mb-2">'+
            '<span class="fw-bold">Chọn danh sách lớp học phần: <i class="fas fa-question-circle text-primary" data-bs-toggle="tooltip" title="Bảng sẽ hiển thị danh sách các lớp học phần tương ứng với học phần vừa chọn ở bảng trên. Các lớp học phần này được mở bởi Khoa."></i></span><br>'+
            '<input type="checkbox" class="form-check-input" id="checkempty1" />'+
            '<label class="form-check-label" for="checkempty1">&emsp;Hiển thị lớp học phần không trùng lịch</label><br>'+
            '<input type="checkbox" class="form-check-input" id="checkempty2" />'+
            '<label for="checkempty2">&emsp;Hiển thị lớp học phần chưa khóa</label>'+
        '</div>'+
        '<div class="table table-responsive">'+
            '<table class="table table-striped table-hover">'+
                '<thead>'+
                    '<tr>'+
                        '<th></th>'+
                        '<th>STT</th>'+
                        '<th>Thông tin lớp học phần</th>'+
                        '<th>Đã đăng ký</th>'+
                    '</tr>'+
                '</thead>'+
                '<tbody>'+
                    '<tr>'+
                        '<td></td>'+
                        '<td></td>'+
                        '<td>Chưa lên kế hoạch</td>'+
                        '<td></td>'+
                    '</tr>'+
                '</tbody>'+
            '</table>'+
        '</div>'+
    '</div>'+
    '<div class="w-100 ps-1">'+
        '<br>'+
        '<div class="mb-2" style="direction: rtl;">'+
            '<span class="fw-bold">Chọn lịch học mong muốn: <i class="fas fa-question-circle text-primary" data-bs-toggle="tooltip" title="Bảng sẽ hiển thị danh sách lịch học tương ứng với lớp học phần. Bạn có thể tự do lựa chọn một trong các lịch học mong muốn để tránh việc áp cứng giờ giấc."></i></span><br>'+
            '<button class="btn btn-primary btn-sm" onclick="audio.play();">Xem lịch trùng</button>'+
        '</div>'+
        '<div class="table table-responsive">'+
            '<table class="table table-striped table-hover">'+
                '<thead id="tab2THead">'+
                    '<tr>'+
                        '<th></th>'+
                        '<th>Trạng thái: <span class="fw-bold text-danger">Đã khóa</span></th>'+
                        '<th>Nhóm học</th>'+
                        '<th>Thông tin thêm</th>'+
                    '</tr>'+
                '</thead>'+
                '<tbody id="tab2TBody">'+
                    '<tr>'+
                        '<td></td>'+
                        '<td></td>'+
                        '<td>Chưa lên kế hoạch lịch học</td>'+
                        '<td></td>'+
                    '</tr>'+
                '</tbody>'+
            '</table>'+
        '</div>'+
        '<div class="d-flex justify-content-center align-content-center">'+
            '<button class="btn btn-primary px-lg-5" onclick="register();">Đăng ký</button>'+
        '</div>'+
    '</div>';
    return empty;
}