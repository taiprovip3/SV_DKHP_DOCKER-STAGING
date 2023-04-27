package com.se.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.se.dto.MetaDatasetChart;
import com.se.service.SinhVienService;

@RestController
@CrossOrigin(origins = "http://localhost:19006")
public class DefaultController {

    @Autowired
    private SinhVienService sinhVienService;
    
    @GetMapping("/")
    public String hello() {
        return "Hello World!";
    }

    @GetMapping("/api/findAllYearsStudent")
	public List<Integer> findAllYearsStudent() {
		return sinhVienService.findAllYearsStudent();
	}

    @GetMapping("/api/getCounterStudentByYearAndMajorId/{year}/{majorId}")
	public Integer getCounterStudentByYearAndMajorId(@PathVariable int year, @PathVariable long majorId) {
		return sinhVienService.getCounterStudentByYearAndMajorId(year, majorId);
	}

    @GetMapping("/api/getMetaDatasetsInputChart")
    public MetaDatasetChart getMetaDatasetsInputChart() {
        return sinhVienService.getMetaDatasetsInputChart();
    }

}
