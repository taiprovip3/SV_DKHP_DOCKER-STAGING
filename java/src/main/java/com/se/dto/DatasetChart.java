package com.se.dto;

import java.util.List;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class DatasetChart {
    private String label;
    private List<Integer> data;
    private String borderColor;
    private boolean fill;
}
