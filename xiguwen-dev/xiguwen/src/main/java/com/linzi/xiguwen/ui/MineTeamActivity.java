package com.linzi.xiguwen.ui;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.LinearLayout;

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

public class MineTeamActivity extends BaseActivity {

    @BindView(R.id.ll_create_team)
    LinearLayout llCreateTeam;
    @BindView(R.id.ll_add_team)
    LinearLayout llAddTeam;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_mine_team);
        ButterKnife.bind(this);
        EventBusUtil.register(this);
    }

    @Override
    protected void initData() {
        setTitle("我的社团");
        setBack();
    }

    @OnClick({R.id.ll_create_team, R.id.ll_add_team})
    public void onClick(View view) {
        Intent intent;
        switch (view.getId()) {
            case R.id.ll_create_team:
                intent = new Intent(this, CreateTeamActivity.class);
                startActivity(intent);
                break;
            case R.id.ll_add_team:
                intent = new Intent(this, AddTeamActivity.class);
                startActivity(intent);
                break;
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
                case EventCode.TEAM_ADD_SUCCESS:
                    finish();
                    break;
            }
        } catch (Exception e) {
        }
    }

}
