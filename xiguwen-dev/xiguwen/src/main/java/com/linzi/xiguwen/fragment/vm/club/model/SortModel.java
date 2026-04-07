package com.linzi.xiguwen.fragment.vm.club.model;

import com.linzi.xiguwen.fragment.vm.model.BaseModel;
import com.linzi.xiguwen.fragment.vm.model.ModelBack;
import com.linzi.xiguwen.utils.NToast;

import java.util.ArrayList;

/**
 * Title:
 * Description:
 * Copyright:Copyright(c)2018
 * Company: Cree
 * CreateTime:2018/3/23  09:43
 *
 * @author luyongjiang
 * @version 1.0
 */
public class SortModel implements BaseModel<ArrayList<String>> {
    private SortModel() {

    }

    ArrayList<String> arrays = new ArrayList<>();

    public static BaseModel createModel() {
        return new SortModel();
    }


    @Override
    public void getData(ModelBack<ArrayList<String>> modelBack) {
        NToast.log("cree", "排序信息加载完毕");

        modelBack.onBack(arrays);
    }

    @Override
    public ArrayList<String> getData() {
        return arrays;
    }
}
