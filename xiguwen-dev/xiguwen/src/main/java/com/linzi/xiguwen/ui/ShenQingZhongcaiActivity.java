package com.linzi.xiguwen.ui;

import androidx.appcompat.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;

public class ShenQingZhongcaiActivity extends BaseActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_shen_qing_zhongcai);
    }

    @Override
    protected void initData() {
        setTitle("填写仲裁原因");
        setBack();
        setRight("提交", new View.OnClickListener() {
            @Override
            public void onClick(View v) {

            }
        });
    }
}
