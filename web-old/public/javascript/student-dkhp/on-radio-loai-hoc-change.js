function onLoaiHocChange(loaiHoc) {
    selected_loai_hoc = loaiHoc;
    const selected_course_id = document.getElementById("select_course").value;
    if(selected_course_id != 0) {
        const test = $("#ListUnitClass").text();
        if(test.length > 150) {
            renderUnitClassBySujectId();
        }
    }
}