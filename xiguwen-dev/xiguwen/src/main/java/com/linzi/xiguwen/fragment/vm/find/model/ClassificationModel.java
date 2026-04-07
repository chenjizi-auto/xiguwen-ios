package com.linzi.xiguwen.fragment.vm.find.model;

import com.linzi.xiguwen.bean.ClassificationBean;
import com.linzi.xiguwen.fragment.vm.model.BaseModel;
import com.linzi.xiguwen.fragment.vm.model.ModelBack;
import com.linzi.xiguwen.net.OnRequestSubscribe;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.NToast;

import java.util.ArrayList;

/**
 * Title:
 * Description:用于职业信息获取的Model
 * Copyright:Copyright(c)2018
 * Company: Cree
 * CreateTime:2018/3/23  09:31
 *
 * @author luyongjiang
 * @version 1.0
 */
public class ClassificationModel implements BaseModel<BaseBean<ArrayList<ClassificationBean>>> {
    private BaseBean<ArrayList<ClassificationBean>> bean;

    private ClassificationModel() {
    }


    public static BaseModel createModel() {
        return new ClassificationModel();
    }


    @Override
    public void getData(final ModelBack<BaseBean<ArrayList<ClassificationBean>>> modelBack) {
        if (bean != null) {
            modelBack.onBack(bean);
            return;
        }
        ApiManager.getClassification(new OnRequestSubscribe<BaseBean<ArrayList<ClassificationBean>>>() {
            @Override
            public void onSuccess(BaseBean<ArrayList<ClassificationBean>> data) {
                NToast.log("cree", "获取到职业列表信息:" + data);
                bean = data;
                ClassificationBean allBean = new ClassificationBean();
                allBean.setOccupationid(-1);
                allBean.setProname("全部");
                bean.getData().add(0, allBean);
                modelBack.onBack(data);

            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }

    @Override
    public BaseBean<ArrayList<ClassificationBean>> getData() {
        return bean;
    }
}
