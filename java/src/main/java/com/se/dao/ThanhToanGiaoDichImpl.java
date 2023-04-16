package com.se.dao;

import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Date;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.se.dto.ThanhToanGiaoDich2DTO;
import com.se.dto.ThanhToanGiaoDichDTO;
import com.se.entity.SinhVien;
import com.se.entity.ThanhToanGiaoDich;
import com.se.repo.SinhVienRepository;
import com.se.repo.ThanhToanGiaoDichRepository;
import com.se.service.ThanhToanGiaoDichService;

@Service
public class ThanhToanGiaoDichImpl implements ThanhToanGiaoDichService{
	
	private String alpha = "abcdefghijklmnopqrstuvwxyz"; // a-z
    private String alphaUpperCase = alpha.toUpperCase(); // A-Z
    private String digits = "0123456789"; // 0-9
    private String ALPHA_NUMERIC = alpha + alphaUpperCase + digits;
    private Random generator = new Random();

    @Autowired
    private ThanhToanGiaoDichRepository thanhToanGiaoDichRepository;
    @Autowired
    private SinhVienRepository sinhVienRepository;

    @Override
    public String createTransaction(long studentId, double balance, String unDebtIds) {
        SinhVien sv = sinhVienRepository.findById(studentId).orElse(null);
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(new Date());
        calendar.add(Calendar.MINUTE, 10);
        Timestamp timestamp = new Timestamp(calendar.getTimeInMillis());
        String randomMaGiaoDich = randomAlphaNumeric(8);
        ThanhToanGiaoDich thanhToanGiaoDich = ThanhToanGiaoDich
	        .builder()
	        .maGiaoDich(randomMaGiaoDich)
	        .sinhVien(sv)
	        .balance(balance)
	        .expiredTime(timestamp)
	        .unDebtIds(unDebtIds)
	        .status(false)
	        .ghiChu("")
	        .build();
	    thanhToanGiaoDichRepository.save(thanhToanGiaoDich);
        return randomMaGiaoDich;
    }
    
    private String randomAlphaNumeric(int numberOfCharactor) {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < numberOfCharactor; i++) {
            int number = randomNumber(0, ALPHA_NUMERIC.length() - 1);
            char ch = ALPHA_NUMERIC.charAt(number);
            sb.append(ch);
        }
        return sb.toString();
    }
    
    private int randomNumber(int min, int max) {
        return generator.nextInt((max - min) + 1) + min;
    }

	@Override
	public ThanhToanGiaoDich getPaymentById(String id) {
		return thanhToanGiaoDichRepository.findById(id).orElse(null);
	}

	@Override
	public ThanhToanGiaoDich updatePaymentToPassById(ThanhToanGiaoDichDTO thanhToanGiaoDichDTO) {
		if(thanhToanGiaoDichDTO.getMaGiaoDich().equalsIgnoreCase("") || thanhToanGiaoDichDTO.getMaGiaoDich() == "") {//TH tao ra phieu thu do thanh toan = student wallet (maGiaoDich = " ")
			
		}
		ThanhToanGiaoDich thanhToanGiaoDich = thanhToanGiaoDichRepository.findById(thanhToanGiaoDichDTO.getMaGiaoDich()).orElse(null);
		thanhToanGiaoDich.setGhiChu(thanhToanGiaoDichDTO.getGhiChu());
		thanhToanGiaoDich.setStatus(true);
		thanhToanGiaoDich.setBalance(thanhToanGiaoDichDTO.getBalance());
		return thanhToanGiaoDichRepository.save(thanhToanGiaoDich);
	}

	@Override
	public String createTransaction(ThanhToanGiaoDich2DTO thanhToanGiaoDich2DTO) {
		SinhVien sv = sinhVienRepository.findById(thanhToanGiaoDich2DTO.getMaSinhVien()).orElse(null);
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(new Date());
        Timestamp timestamp = new Timestamp(calendar.getTimeInMillis());
        String randomMaGiaoDich = randomAlphaNumeric(8);
        ThanhToanGiaoDich thanhToanGiaoDich = ThanhToanGiaoDich
	        .builder()
	        .maGiaoDich(randomMaGiaoDich)
	        .sinhVien(sv)
	        .balance(thanhToanGiaoDich2DTO.getBalance())
	        .expiredTime(timestamp)
	        .unDebtIds(thanhToanGiaoDich2DTO.getUnDebtIds())
	        .status(true)
	        .ghiChu(thanhToanGiaoDich2DTO.getGhiChu())
	        .build();
	    thanhToanGiaoDichRepository.save(thanhToanGiaoDich);
		return randomMaGiaoDich;
	}

	@Override
	public String getTokenByPaymentAndStudentId(String paymentId, long studentId) {
		return thanhToanGiaoDichRepository.getTokenByPaymentAndStudentId(paymentId, studentId);
	}

	@Override
	public ThanhToanGiaoDich getStudentPayedDebtByDebtId(long debtId, long studentId) {
		return thanhToanGiaoDichRepository.getStudentPayedDebtByDebtId(debtId, studentId);
	}

}
