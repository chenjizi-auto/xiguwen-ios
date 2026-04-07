package com.linzi.xiguwen.ui;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.linzi.xiguwen.BuildConfig;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.utils.SPUtil;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;
import com.linzi.xiguwen.utils.yixin.LogoutHelper;

import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class SettingActivity extends BaseActivity {

    @BindView(R.id.ll_address)
    LinearLayout llAddress;
    @BindView(R.id.ll_user_msg)
    LinearLayout llUserMsg;
    @BindView(R.id.ll_bind)
    LinearLayout llBind;
    @BindView(R.id.ll_safe)
    LinearLayout llSafe;
    @BindView(R.id.ll_logs)
    LinearLayout llLogs;
    @BindView(R.id.textView)
    TextView textView;
    @BindView(R.id.ll_exit)
    LinearLayout llExit;

    private int titleClickCount = 0;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_setting);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        setTitle("设置");
        setBack();
        EventBusUtil.register(this);
        if (BuildConfig.DEBUG) {
            llLogs.setVisibility(View.VISIBLE);
        } else {
            llLogs.setVisibility(View.GONE);
            setTitleClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    titleClickCount++;
                    if (titleClickCount >= 4) {
                        titleClickCount = 0;
                        Intent intentLog = new Intent(mContext, LogCenterActivity.class);
                        startActivity(intentLog);
                    }
                }
            });
        }
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        EventBusUtil.unregister(this);
    }

    @Subscribe(threadMode = ThreadMode.MAIN)
    public void receiveEvent(Event entity) {
        if (entity == null)
            return;
        try {
            int code = entity.getCode();
            switch (code) {
                case EventCode.PASSWORD_UPDATE_SUCCESS:
                case EventCode.FINISH:
                    finish();
                    break;
            }
        } catch (Exception e) {
        }

    }

    @OnClick({R.id.ll_address, R.id.ll_user_msg, R.id.ll_bind, R.id.ll_safe, R.id.ll_logs, R.id.ll_exit})
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.ll_address:
                Intent intent1 = new Intent(mContext, AddressManagerActivity.class);
                startActivity(intent1);
                break;
            case R.id.ll_user_msg:
                Intent intent = new Intent(mContext, UserMessageActivity.class);
                startActivity(intent);
                break;
            case R.id.ll_bind:
                Intent intent2 = new Intent(mContext, BindActivity.class);
                startActivity(intent2);

//                WebViewVideoActivity.startAction(mContext,"http://cadknews.tiyushe.net/p1.2/VideoWeb/Detail/v75314df2c07.html?v=1500888081.html?appTag=@aykAPP_video");
                break;
            case R.id.ll_safe:
                Intent intent3 = new Intent(mContext, PassUpdateIndexActivity.class);
//                intent3.putExtra("tag", 1);
                startActivity(intent3);
                break;
            case R.id.ll_logs:
                Intent intentLog = new Intent(mContext, LogCenterActivity.class);
                startActivity(intentLog);
                break;
            case R.id.ll_exit:
                Intent intent4 = new Intent(mContext, LoginActivity.class);
                SPUtil.clear();
                LogoutHelper.logout();
                startActivity(intent4);
                finish();

                break;
        }
    }

}
