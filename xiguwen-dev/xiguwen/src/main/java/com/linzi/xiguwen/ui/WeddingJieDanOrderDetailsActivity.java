package com.linzi.xiguwen.ui;

import android.os.Bundle;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;

import butterknife.ButterKnife;

/**
 * Created by pc on 2018/5/3.
 */

public class WeddingJieDanOrderDetailsActivity extends BaseActivity {

    @Override
    protected void initData() {

    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.new_order_details_layout);
        ButterKnife.bind(this);
        EventBusUtil.register(this);
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
         
        EventBusUtil.unregister(this);
    }
}
