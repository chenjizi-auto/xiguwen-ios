package com.linzi.xiguwen.fragment.vm.need;

import android.view.View;
import android.widget.TextView;

import com.linzi.xiguwen.fragment.vm.model.ModelBack;
import com.linzi.xiguwen.fragment.vm.need.bean.BaseBean;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by PC on 2018-04-10.
 */

public class NeedVM extends PopwindowVM{

    public NeedVM(View parent, TextView rbAll) {
        super(parent, rbAll);
    }

    @Override
    void bindData(final ArrayList<BaseBean> arrayList) {
        arrayList.clear();
        mBaseModel.getData(new ModelBack<List<BaseBean>>() {
            @Override
            public void onBack(List<BaseBean> data) {
                arrayList.addAll(data);
                if(mAdapter != null){
                    mAdapter.notifyDataSetChanged();
                }
            }
        });
    }

    @Override
    void onItemClick(int position) {

    }
}
