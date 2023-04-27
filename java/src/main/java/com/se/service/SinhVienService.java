package com.se.service;

import java.util.List;

import com.se.dto.MetaDatasetChart;
import com.se.dto.SinhVienAddBalanceDTO;
import com.se.dto.SinhVienDTO;
import com.se.entity.SinhVien;

public interface SinhVienService {
	public SinhVien addStudent(SinhVienDTO sinhVien);
	public List<Long> removeStudent(List<Long> listIdStudent);
	public SinhVien getStudentById(long id);
	public double getStudentBalance(long studentId);
	public double updateBalance(long studentId, double soDu);
    public double addStudentBalance(SinhVienAddBalanceDTO sinhVienAddBalanceDTO);
    public double reduceStudentBalance(long studentId, long balanceToReduce);
	public List<Integer> findAllYearsStudent();
	public Integer getCounterStudentByYearAndMajorId(int year, long majorId);
    public MetaDatasetChart getMetaDatasetsInputChart();
}
