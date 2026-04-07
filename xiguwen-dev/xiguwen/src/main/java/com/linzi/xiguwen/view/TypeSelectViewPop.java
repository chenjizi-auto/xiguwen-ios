package com.linzi.xiguwen.view;

import android.app.Activity;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.MyDateBean;
import com.linzi.xiguwen.fragment.search.MyPopWindow;

import java.util.ArrayList;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

/**
 * Created by devin on 2018/4/23 14:03
 * Description
 */

public class TypeSelectViewPop {
    @BindView(R.id.tv_close)
    TextView tvClose;
    @BindView(R.id.tv_submit)
    TextView tvSubmit;
    @BindView(R.id.pick_type)
    ScrollerDatePicker pickType;
    private MyPopWindow popView;
    private View contentView;

    public TypeSelectViewPop(Activity activity) {
        contentView = LayoutInflater.from(activity).inflate(R.layout.view_type_select, null);
        ButterKnife.bind(this,contentView);
        popView = new MyPopWindow.PopupWindowBuilder(activity)
                .setView(contentView)
                .size(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT)//显示大小
                .setOutsideTouchable(true)
                .enableBackgroundDark(true)
                .create();


//        screenPopView.showAsDropDown(rbScreen, 0, 1);
//        screenPopView.showBackgroundDark();
//        screenPopView.showAtLocation(rbScreen, Gravity.RIGHT, 0, 0);

    }


    public void show(View view) {
        popView.showBackgroundDark();
        popView.showAtLocation(view, Gravity.BOTTOM, 0, 0);
    }

    public void setData(ArrayList<MyDateBean> data) {
        pickType.setData(data);
    }

    @OnClick({R.id.tv_close, R.id.tv_submit})
    public void onViewClicked(View view) {
        switch (view.getId()) {
            case R.id.tv_close:
                popView.dissmiss();
                break;
            case R.id.tv_submit:
                if (listener != null) {
                    listener.selectTye(pickType.getData());
                    popView.dissmiss();
                }
                break;
        }
    }

    private TypeJobSelectListener listener;

    public void setListener(TypeJobSelectListener listener) {
        this.listener = listener;
    }

    public interface TypeJobSelectListener {
        void selectTye(MyDateBean bean);
    }
}
