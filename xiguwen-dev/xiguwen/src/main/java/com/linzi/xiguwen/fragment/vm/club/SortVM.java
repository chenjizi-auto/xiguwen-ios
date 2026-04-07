package com.linzi.xiguwen.fragment.vm.club;

import android.view.View;
import android.widget.TextView;

import com.linzi.xiguwen.fragment.vm.model.ModelBack;

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
public class SortVM extends PopwindowVM {
    public SortVM(View parent, TextView rbAll) {
        super(parent, rbAll);
    }

    @Override
    void bindData(final ArrayList<String> arrayList) {
        arrayList.clear();
        mBaseModel.getData(new ModelBack<ArrayList<String>>() {
            @Override
            public void onBack(ArrayList<String> data) {
                arrayList.addAll(data);
            }
        });
    }

    @Override
    void onItemClick(int position) {

    }

    @Override
    public void onTitleClick() {
        super.onTitleClick();
        value = "1";
    }

    private String value = null;

    public String getValue() {
        return value;
    }

    public void relaseValue() {
        value = null;
    }
}
