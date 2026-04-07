package com.linzi.xiguwen.fragment.vm.club.model;

import android.nfc.Tag;

import com.baidu.location.BDLocation;
import com.linzi.xiguwen.bean.GetCityBean;
import com.linzi.xiguwen.fragment.vm.model.BaseModel;
import com.linzi.xiguwen.fragment.vm.model.ModelBack;
import com.linzi.xiguwen.net.OnRequestSubscribe;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.location.CustomLocationListener;
import com.linzi.xiguwen.utils.location.LocationHelper;
import com.linzi.xiguwen.utils.yixin.preference.Preferences;

import java.util.ArrayList;

/**
 * Title:
 * Description:用来获取城市的model
 * Copyright:Copyright(c)2018
 * Company: Cree
 * CreateTime:2018/3/23  09:42
 *
 * @author luyongjiang
 * @version 1.0
 */
public class CityModel implements BaseModel<BaseBean<ArrayList<GetCityBean>>> {
    private BaseBean<ArrayList<GetCityBean>> bean;

    public static BaseModel createModel() {
        return new CityModel();
    }


    @Override
    public void getData(final ModelBack<BaseBean<ArrayList<GetCityBean>>> modelBack) {
        if (bean != null) {
            modelBack.onBack(bean);
            return;
        }
//        //请求定位,自动释放回调
        LocationHelper.requestLocation(new CustomLocationListener.ReceiveLocation() {
            @Override
            public void onLocation(BDLocation bdLocation) {
        int id = 273;
                if(Preferences.getCity()!=null &&  ((Integer) Preferences.getCity().getId()) != null) {
                    id = Preferences.getCity().getId();
                }else{
                    id=273;
                }
        ApiManager.getCiteListe(id + "", new OnRequestSubscribe<BaseBean<ArrayList<GetCityBean>>>() {
            @Override
            public void onSuccess(BaseBean<ArrayList<GetCityBean>> data) {

                NToast.log("cree", "城市列表信息加载完毕:" + data);
                modelBack.onBack(data);
                bean = data;
            }

            @Override
            public void onError(Exception ex) {
                NToast.log("APPTAG", ex.toString());
            }
        });

        }
        });
    }

    @Override
    public BaseBean<ArrayList<GetCityBean>> getData() {
        return bean;
    }
}
