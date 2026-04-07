package com.linzi.xiguwen.ui;

import android.os.Bundle;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.network.ApiManager;

import java.io.IOException;

import butterknife.BindView;
import butterknife.ButterKnife;

public class UserArgumentActivity extends BaseActivity {

    @BindView(R.id.tv_context)
    TextView tvContext;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_user_argument);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        setTitle("用户协议");
        setBack();

        try {
            String text= ApiManager.streamToString(mContext.getResources().getAssets().open("UserArgument.dc"));
            tvContext.setText(text);
        } catch (IOException e) {
            com.linzi.xiguwen.utils.LogUtil.printStackTrace(e);
        }
    }
}
