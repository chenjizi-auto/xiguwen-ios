package com.lljjcoder.Interface;

import com.lljjcoder.bean.CityBean;
import com.lljjcoder.bean.DistrictBean;
import com.lljjcoder.bean.ProvinceBean;

public interface OnCityItemClickListener {
    void onSelected(ProvinceBean province, CityBean city, DistrictBean district);

    void onCancel();
}
