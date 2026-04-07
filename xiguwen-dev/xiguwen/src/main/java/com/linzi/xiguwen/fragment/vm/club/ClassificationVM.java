package com.linzi.xiguwen.fragment.vm.club;

import android.view.View;
import android.widget.TextView;

import com.linzi.xiguwen.bean.ClassificationBean;
import com.linzi.xiguwen.fragment.vm.model.ModelBack;
import com.linzi.xiguwen.net.base.BaseBean;

import java.util.ArrayList;

/**
 * Title:
 * Description:
 * Copyright:Copyright(c)2018
 * Company: Cree
 * CreateTime:2018/3/23  10:11
 *
 * @author luyongjiang
 * @version 1.0
 */
public class ClassificationVM extends PopwindowVM {

    public ClassificationVM(View parent, TextView rbAll) {
        super(parent, rbAll);
    }


    @Override
    void bindData(final ArrayList<String> arrayList) {
        arrayList.clear();
        mBaseModel.getData(new ModelBack<BaseBean<ArrayList<ClassificationBean>>>() {
            @Override
            public void onBack(BaseBean<ArrayList<ClassificationBean>> data) {
                arrayList.addAll(changeToStringArray(data.getData()));
            }
        });

    }

    private ArrayList<String> changeToStringArray(ArrayList<ClassificationBean> data) {
        ArrayList<String> strings = new ArrayList<>();
        for (ClassificationBean datum : data) {
            strings.add(datum.getProname());
        }
        return strings;
    }

    @Override
    void onItemClick(int position) {
        int occupationid = ((BaseBean<ArrayList<ClassificationBean>>) mBaseModel.getData()).getData().get(position).getOccupationid();
        classification = occupationid == -1 ? null : occupationid + "";
    }

    private String classification = null;

    public String getValue() {
        return classification;
    }
}
