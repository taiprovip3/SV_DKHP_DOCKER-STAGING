package com.se.entity;

import com.se.enums.BacDaoTao;
import com.se.enums.CoSo;
import com.se.enums.LoaiHinhDaoTao;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.persistence.*;

@Data
@ToString
@Embeddable
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class DaoTao {
    @Enumerated(EnumType.STRING)
    private BacDaoTao bacDaoTao;
    @Enumerated(EnumType.STRING)
    private LoaiHinhDaoTao loaiHinhDaoTao;
    @Enumerated(EnumType.STRING)
    private CoSo coSo;
}
