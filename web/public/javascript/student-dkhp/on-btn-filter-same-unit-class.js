async function getUnitClassesStudentRegisterByStudentIdAndMaKhoaHoc() {
    return  $.ajax({
        type: "POST",
        url: "<%= process.env.SELF_EJS_API_URL %>/student/dkhp/getUnitClassesStudentRegisterByStudentIdAndMaKhoaHoc",
        contentType: 'application/json',
        data: JSON.stringify({ maKhoaHoc: selected_ma_khoa_hoc }),
    }).then(data => data);
}
async function handleFilterSameUnitClass() {
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
    var trsForMyTBody = "";
    for(let i=0; i<blackListMyTKBs.length; i++) {
        trsForMyTBody += 
        '<tr>'+
            '<td>'+ parseInt(i+1) +'</td>'+
            '<td>'+ blackListMyTKBs[i].lopHocPhan.maLopHocPhan +'</td>'+
            '<td>'+ blackListMyTKBs[i].lopHocPhan.tenLopHocPhan +'</td>'+
            '<td>'+ blackListMyTKBs[i].lopHocPhan.monHoc.tenMonHoc +'</td>'+
            '<td class="bg-danger text-white">'+ blackListMyTKBs[i].thuHoc +'</td>'+
            '<td class="bg-danger text-white">'+ blackListMyTKBs[i].tuTietHoc +'</td>'+
            '<td class="bg-danger text-white">'+ blackListMyTKBs[i].denTietHoc +'</td>'+
        '</tr>';
    }
    var trsForServerTBody = "";
    for(let i=0; i<blackListServerTKBs.length; i++) {
        trsForServerTBody += 
        '<tr>'+
            '<td>'+ parseInt(i+1) +'</td>'+
            '<td>'+ blackListServerTKBs[i].lopHocPhan.maLopHocPhan +'</td>'+
            '<td>'+ blackListServerTKBs[i].lopHocPhan.tenLopHocPhan +'</td>'+
            '<td>'+ blackListServerTKBs[i].lopHocPhan.monHoc.tenMonHoc +'</td>'+
            '<td>'+ blackListServerTKBs[i].thuHoc +'</td>'+
            '<td>'+ blackListServerTKBs[i].tuTietHoc +'</td>'+
            '<td>'+ blackListServerTKBs[i].denTietHoc +'</td>'+
        '</tr>';
    }
    $("#tBodyMyDuplicate").html(trsForMyTBody);
    $("#tBodyServerDuplicate").html(trsForServerTBody);
}