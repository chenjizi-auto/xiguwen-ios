package com.linzi.xiguwen.ui;

import android.os.Bundle;
import android.text.TextUtils;
import android.view.View;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.utils.NToast;

import butterknife.BindView;
import butterknife.OnClick;

public class LogCenterActivity extends BaseActivity {

    @BindView(R.id.tv_log_content)
    TextView tvLogContent;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_log_center);
    }

    @Override
    protected void initData() {
        setTitle("日志中心");
        setBack();
        refreshLogContent();
    }

    @OnClick({R.id.tv_refresh_log, R.id.tv_clear_log})
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.tv_refresh_log:
                refreshLogContent();
                break;
            case R.id.tv_clear_log:
                NToast.clearLogRecords();
                refreshLogContent();
                NToast.show("日志已清空");
                break;
        }
    }

    private void refreshLogContent() {
        String logs = NToast.getLogRecordsText();
        tvLogContent.setText(TextUtils.isEmpty(logs) ? "暂无日志" : logs);
    }
}
