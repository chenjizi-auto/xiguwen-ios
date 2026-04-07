package com.linzi.xiguwen.fragment.vm.club;

import android.view.View;
import android.widget.TextView;

import com.linzi.xiguwen.bean.GetCityBean;
import com.linzi.xiguwen.fragment.vm.model.ModelBack;
import com.linzi.xiguwen.net.base.BaseBean;

import java.util.ArrayList;

/**
 * Title:
 * Description:
 * Copyright:Copyright(c)2018
 * Company: Cree
 * CreateTime:2018/3/23  10:12
 *
 * @author luyongjiang
 * @version 1.0
 */
public class CityVM extends PopwindowVM {
    public CityVM(View parent, TextView rbAll) {
        super(parent, rbAll);
    }

    @Override
    void bindData(final ArrayList<String> arrayList) {
        arrayList.clear();
        mBaseModel.getData(new ModelBack<BaseBean<ArrayList<GetCityBean>>>() {
            @Override
            public void onBack(BaseBean<ArrayList<GetCityBean>> data) {
                //---------------------------伪造的数据 用来筛选全部---------------------------------
                GetCityBean getCityBean = new GetCityBean();
                getCityBean.setId(-1);
                getCityBean.setName("全区域");
                data.getData().add(0, getCityBean);
                arrayList.addAll(toStringArrays(data.getData()));
            }
        });
    }

    private ArrayList<String> toStringArrays(ArrayList<GetCityBean> arrayList) {
        ArrayList<String> strings = new ArrayList<>();
        for (GetCityBean getCityBean : arrayList) {
            strings.add(getCityBean.getName());
        }
        return strings;
    }

    @Override
    void onItemClick(int position) {
        if (mBaseModel.getData() == null)
            return;
        GetCityBean bean = ((BaseBean<ArrayList<GetCityBean>>) mBaseModel.getData()).getData().get(position);
        //如果点击的是伪造的数据,则置空条件,并且不终止这个方法
        if (bean.getId() == -1) {
            city = null;
            return;
        }
        city = bean.getCityid();
    }

    private String city = null;

    public String getValue() {
        return city;
    }

}
