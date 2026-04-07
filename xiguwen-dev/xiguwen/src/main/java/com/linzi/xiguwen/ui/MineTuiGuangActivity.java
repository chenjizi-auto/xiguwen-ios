package com.linzi.xiguwen.ui;

import android.content.Intent;
import android.os.Bundle;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.PopularizeRemainBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.MsgLoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;

import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class MineTuiGuangActivity extends BaseActivity {

    @BindView(R.id.tv_guanggaowei)
    TextView tvGuanggaowei;
    @BindView(R.id.tv_time)
    TextView tvTime;
    @BindView(R.id.bt_qiangtuiguang)
    Button btQiangtuiguang;
    @BindView(R.id.ll_getTuiguang)
    LinearLayout llGetTuiguang;
    @BindView(R.id.ll_no_data)
    LinearLayout llNoData;

    private PopularizeRemainBean mData;
    private String price;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_mine_tui_guang);
        ButterKnife.bind(this);
        EventBusUtil.register(this);
    }

    @Override
    protected void initData() {
        setTitle("推广助手");
        setBack();

        requestNetData();
    }

    private void requestNetData() {
        LoadDialog.showDialog(this);
        ApiManager.getPopularizeRemainNum(new OnRequestFinish<PopularizeRemainBean>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(PopularizeRemainBean data) {
                mData = data;
                price = mData.getMoney();
                if (mData.getUser() == 1) {
                    btQiangtuiguang.setClickable(false);
                    btQiangtuiguang.setText("已抢推广");
                } else {
                    btQiangtuiguang.setClickable(true);
                    btQiangtuiguang.setText("抢推广");
                }
                tvGuanggaowei.setText(mData.getSum() + "");
                if (mData.getSum() == 0) {
                    llGetTuiguang.setBackgroundResource(R.mipmap.icon_tuiguang_fail);
                } else {
                    llGetTuiguang.setBackgroundResource(R.mipmap.icon_tuiguang_bg);
                }
                tvTime.setText(mData.getDate());
                if (mData.getSum() > 0) {
                    btQiangtuiguang.setEnabled(true);
                }
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
            }
        });
    }

    //抢推广
    @OnClick(R.id.bt_qiangtuiguang)
    protected void robPopularize() {
        Intent intent = new Intent(mContext, ToPayActivity.class);
        intent.putExtra("price", price);
        intent.putExtra("intentType", 3);
        startActivity(intent);
    }

    @Subscribe(threadMode = ThreadMode.MAIN)
    public void receiveEvent(Event event) {
        if (event == null)
            return;
        try {
            int code = event.getCode();
            switch (code) {
                case EventCode.PAY_SUCCRSS:
                    this.requestNetData();
                    break;
            }
        } catch (Exception e) {
        }

    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
         
        EventBusUtil.unregister(this);
    }
}
