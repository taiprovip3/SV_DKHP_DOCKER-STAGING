package com.se.dto;


import java.util.List;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class MetaDatasetChart {
    private List<Integer> listYear;
    private List<DatasetChart> datasets;
}
