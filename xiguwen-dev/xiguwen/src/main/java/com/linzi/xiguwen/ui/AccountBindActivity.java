package com.linzi.xiguwen.ui;

import android.os.Bundle;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class AccountBindActivity extends BaseActivity {

    @BindView(R.id.iv_is_bind)
    ImageView ivIsBind;
    @BindView(R.id.tv_is_bind_phone)
    TextView tvIsBindPhone;
    @BindView(R.id.ll_phone)
    LinearLayout llPhone;
    @BindView(R.id.iv_is_bind_wx)
    ImageView ivIsBindWx;
    @BindView(R.id.tv_is_bind_wx)
    TextView tvIsBindWx;
    @BindView(R.id.ll_wechat)
    LinearLayout llWechat;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_account_bind);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        setTitle("账号绑定");
        setBack();
    }

    @OnClick({R.id.ll_phone, R.id.ll_wechat})
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.ll_phone:
                break;
            case R.id.ll_wechat:
                break;
        }
    }
}
