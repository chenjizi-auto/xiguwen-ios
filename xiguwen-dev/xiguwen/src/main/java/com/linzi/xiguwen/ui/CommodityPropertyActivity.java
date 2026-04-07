package com.linzi.xiguwen.ui;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.widget.EditText;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;

import butterknife.BindView;

/**
 * Created by PC on 2018-04-12.
 * 商品属性设置界面
 */

public class CommodityPropertyActivity extends BaseActivity {

    @BindView(R.id.ed_property1)
    EditText mEdProperty1;
    @BindView(R.id.ed_property2)
    EditText mEdProperty2;

    public static void startActivity(Activity activity, String property1, String property2, int requestCode){
        Intent intent = new Intent(activity, CommodityPropertyActivity.class);
        intent.putExtra("property1", property1);
        intent.putExtra("property2", property2);
        activity.startActivityForResult(intent, requestCode);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_commodity_property);
    }

    @Override
    protected void initData() {
        setTitle("属性设置");
        setBack();
        String property1 = getIntent().getStringExtra("property1");
        String property2 = getIntent().getStringExtra("property2");
        if(null != property1){
            mEdProperty1.setText(property1);
        }
        if(null != property2){
            mEdProperty2.setText(property2);
        }
    }

    @Override
    public void finish() {
        Intent data = new Intent();
        data.putExtra("data", new String[]{mEdProperty1.getText().toString().trim(), mEdProperty2.getText().toString().trim()});
        setResult(RESULT_OK, data);
        super.finish();
    }
}
