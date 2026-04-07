package com.linzi.xiguwen.ui;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.LinearLayout;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.utils.SPUtil;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class ChooseRZTypeActivity extends BaseActivity {

    @BindView(R.id.ll_person)
    LinearLayout llPerson;
    @BindView(R.id.ll_company)
    LinearLayout llCompany;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_choose_rztype);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        setTitle("实名认证");
        setBack();

        switch ((int) SPUtil.get("usertype", SPUtil.Type.INT)) {//1是商场商家，2是婚庆商家。3是用户
            case 1:
                llPerson.setVisibility(View.VISIBLE);
                llCompany.setVisibility(View.VISIBLE);
                break;
            case 2:
                llPerson.setVisibility(View.VISIBLE);
                llCompany.setVisibility(View.VISIBLE);
                break;
            case 3:
                llPerson.setVisibility(View.VISIBLE);
                llCompany.setVisibility(View.GONE);
                break;
        }
    }

    @OnClick({R.id.ll_person, R.id.ll_company})
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.ll_person:
                Intent intent = new Intent(this, PersonRZActivity.class);
                startActivity(intent);
                break;
            case R.id.ll_company:
                Intent intent2 = new Intent(this, CompanyRZActivity.class);
                startActivity(intent2);
                break;
        }
    }
}
