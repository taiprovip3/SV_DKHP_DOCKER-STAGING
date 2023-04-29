package com.se.util;

import java.util.Comparator;

import com.se.entity.ThoiKhoaBieu;

public class ThoiKhoaBieuComparator implements Comparator<ThoiKhoaBieu> {

    @Override
    public int compare(ThoiKhoaBieu o1, ThoiKhoaBieu o2) {
        return o1.getTuTietHoc().compareTo(o2.getTuTietHoc());
    }
    
}
