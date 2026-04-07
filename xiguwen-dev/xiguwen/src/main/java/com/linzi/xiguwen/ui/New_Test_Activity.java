package com.linzi.xiguwen.ui;

import android.os.Bundle;
import androidx.annotation.Nullable;

import com.linzi.xiguwen.R;

/**
 * Created by pc on 2018/5/7.
 */

public class New_Test_Activity extends BaseWebViewActivity {

    @Override
    public int getContentView() {
        return  R.layout.activity_qingjian_yulan;
    }

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        loadUrl("http://www.oschina.net/question/54100_34836");
    }
}
