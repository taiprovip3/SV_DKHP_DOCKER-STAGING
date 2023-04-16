package com.se.repo;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.se.entity.ThanhToanGiaoDich;

@Repository
public interface ThanhToanGiaoDichRepository extends CrudRepository<ThanhToanGiaoDich, String> {

    @Query(value = "SELECT tk.token FROM thanh_toan_giao_dich ttgd JOIN sinh_vien sv ON ttgd.ma_sinh_vien = sv.ma_sinh_vien JOIN user u ON sv.ma_tai_khoan = u.id JOIN token tk ON tk.created_by = u.id WHERE ttgd.ma_giao_dich = ?1 AND ttgd.ma_sinh_vien = ?2", nativeQuery = true)
    public String getTokenByPaymentAndStudentId(String paymentId, long studentId);

    @Query(value = "SELECT * FROM thanh_toan_giao_dich WHERE un_debt_ids = ?1 AND ma_sinh_vien = ?2 AND status = 1 AND ghi_chu != '' LIMIT 1", nativeQuery = true)
    public ThanhToanGiaoDich getStudentPayedDebtByDebtId(long debtId, long studentId);

}
