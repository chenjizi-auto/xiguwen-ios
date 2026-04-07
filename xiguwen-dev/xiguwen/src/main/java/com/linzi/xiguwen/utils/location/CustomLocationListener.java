package com.linzi.xiguwen.utils.location;

import com.baidu.location.BDAbstractLocationListener;
import com.baidu.location.BDLocation;
import com.linzi.xiguwen.utils.NToast;

/**
 * Title:
 * Description:
 * Copyright:Copyright(c)2018
 * Company: Cree
 * CreateTime:2018/3/22  13:28
 *
 * @author luyongjiang
 * @version 1.0
 */
public class CustomLocationListener extends BDAbstractLocationListener {

    @Override
    public void onReceiveLocation(BDLocation location) {
        //此处的BDLocation为定位结果信息类，通过它的各种get方法可获取定位相关的全部结果
        //以下只列举部分获取地址相关的结果信息
        //更多结果信息获取说明，请参照类参考中BDLocation类中的说明

        String addr = location.getAddrStr();    //获取详细地址信息
        String country = location.getCountry();    //获取国家
        String province = location.getProvince();    //获取省份
        String city = location.getCity();    //获取城市
        String district = location.getDistrict();    //获取区县
        String street = location.getStreet();    //获取街道信息
        //NToast.log("cree", "city:" + city + " location:" + location);
        if (mReceiveLocation != null) {
            mReceiveLocation.onLocation(location);
        }
    }

    ReceiveLocation mReceiveLocation;

    public void injectReceive(ReceiveLocation receiveLocation) {
        mReceiveLocation = receiveLocation;
    }

    public interface ReceiveLocation {
        void onLocation(BDLocation bdLocation);
    }
}
