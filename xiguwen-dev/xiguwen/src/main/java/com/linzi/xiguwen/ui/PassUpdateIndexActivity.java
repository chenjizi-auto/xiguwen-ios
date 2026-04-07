package com.linzi.xiguwen.ui;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;

import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

/**
 * Created by devin on 2018/4/18 17:40
 * Description
 */

public class PassUpdateIndexActivity extends BaseActivity {

    @BindView(R.id.passupdate_login)
    TextView passupdateLogin;
    @BindView(R.id.passupdate_pay)
    TextView passupdatePay;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_pass_update_index);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {

        setTitle("安全设置");
        setBack();
        EventBusUtil.register(this);
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
                    finish();
                    break;
            }
        } catch (Exception e) {
        }

    }

    @OnClick({R.id.passupdate_login, R.id.passupdate_pay})
    public void onViewClicked(View view) {
        switch (view.getId()) {
            case R.id.passupdate_login:
                Intent intent3 = new Intent(mContext, BindPhone2Activity.class);
                intent3.putExtra("tag", 1);
                startActivity(intent3);
                break;
            case R.id.passupdate_pay:
                Intent intent1 = new Intent(mContext, BindPhone2Activity.class);
                intent1.putExtra("tag", 2);
                startActivity(intent1);
                break;
        }
    }
}
