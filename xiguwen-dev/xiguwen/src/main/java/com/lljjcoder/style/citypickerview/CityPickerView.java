package com.lljjcoder.style.citypickerview;

import android.app.Activity;
import android.text.TextUtils;

import com.github.gzuliyujiang.wheelpicker.AddressPicker;
import com.github.gzuliyujiang.wheelpicker.annotation.AddressMode;
import com.github.gzuliyujiang.wheelpicker.contract.OnAddressPickedListener;
import com.github.gzuliyujiang.wheelpicker.entity.CityEntity;
import com.github.gzuliyujiang.wheelpicker.entity.CountyEntity;
import com.github.gzuliyujiang.wheelpicker.entity.ProvinceEntity;
import com.lljjcoder.Interface.OnCityItemClickListener;
import com.lljjcoder.bean.CityBean;
import com.lljjcoder.bean.DistrictBean;
import com.lljjcoder.bean.ProvinceBean;
import com.lljjcoder.citywheel.CityConfig;

public class CityPickerView {
    private Activity activity;
    private CityConfig cityConfig = new CityConfig.Builder().build();
    private OnCityItemClickListener listener;

    public void init(Activity activity) {
        this.activity = activity;
    }

    public void setConfig(CityConfig cityConfig) {
        if (cityConfig != null) {
            this.cityConfig = cityConfig;
        }
    }

    public void setOnCityItemClickListener(OnCityItemClickListener listener) {
        this.listener = listener;
    }

    public void showCityPicker() {
        if (activity == null) {
            return;
        }
        AddressPicker picker = new AddressPicker(activity) {
            @Override
            protected void onCancel() {
                if (listener != null) {
                    listener.onCancel();
                }
            }
        };
        picker.setAddressMode(resolveAddressMode(cityConfig.getCityWheelType()));
        picker.setDefaultValue(
                nonEmpty(cityConfig.getDefaultProvinceName(), "四川省"),
                nonEmpty(cityConfig.getDefaultCityName(), "成都市"),
                nonEmpty(cityConfig.getDefaultDistrict(), "武侯区"));
        picker.setOnAddressPickedListener(new OnAddressPickedListener() {
            @Override
            public void onAddressPicked(ProvinceEntity province, CityEntity city, CountyEntity county) {
                if (listener == null) {
                    return;
                }
                String provinceName = valueOf(province == null ? null : province.getName());
                String cityName = valueOf(city == null ? null : city.getName());
                String districtName = valueOf(county == null ? null : county.getName());
                String districtCode = valueOf(county == null ? null : county.getCode());
                ProvinceBean provinceBean = new ProvinceBean(provinceName, provinceName);
                CityBean cityBean = new CityBean(cityName, cityName);
                String districtId = TextUtils.isEmpty(districtCode) ? districtName : districtCode;
                DistrictBean districtBean = new DistrictBean(districtId, districtName);
                listener.onSelected(provinceBean, cityBean, districtBean);
            }
        });
        picker.show();
    }

    private int resolveAddressMode(CityConfig.WheelType wheelType) {
        if (wheelType == CityConfig.WheelType.PRO_CITY) {
            return AddressMode.PROVINCE_CITY;
        }
        return AddressMode.PROVINCE_CITY_COUNTY;
    }

    private String nonEmpty(String value, String fallback) {
        return TextUtils.isEmpty(value) ? fallback : value;
    }

    private String valueOf(String value) {
        return value == null ? "" : value;
    }
}
