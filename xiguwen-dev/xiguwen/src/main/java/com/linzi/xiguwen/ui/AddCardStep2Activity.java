package com.linzi.xiguwen.ui;

import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.BankCard1Entity;
import com.linzi.xiguwen.bean.CityEntity;
import com.linzi.xiguwen.utils.AppUtil;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;
import com.lljjcoder.Interface.OnCityItemClickListener;
import com.lljjcoder.bean.DistrictBean;
import com.lljjcoder.bean.ProvinceBean;
import com.lljjcoder.citywheel.CityConfig;
import com.lljjcoder.style.citypickerview.CityPickerView;
import com.luck.picture.lib.utils.ToastUtils;
import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class AddCardStep2Activity extends BaseActivity {

    @BindView(R.id.tv_user_name)
    TextView tvUserName;
    @BindView(R.id.tv_card_num)
    TextView tvCardNum;
    @BindView(R.id.tv_bank_name)
    TextView tvBankName;
    @BindView(R.id.ll_choose_bank)
    LinearLayout llChooseBank;
    @BindView(R.id.tv_city)
    TextView tvCity;
    @BindView(R.id.ll_city)
    LinearLayout llCity;
    @BindView(R.id.tv_fenhang)
    EditText tvFenhang;
    @BindView(R.id.ll_fenhang)
    LinearLayout llFenhang;
    @BindView(R.id.bt_next_step)
    Button btNextStep;

    private BankCard1Entity entity;
    private final CityPickerView mPicker=new CityPickerView();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        mPicker.init(this);
        setContentView(R.layout.activity_add_card_step2);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        setTitle("添加银行卡");
        setBack();
        event();
        EventBusUtil.register(this);
        String data = getIntent().getStringExtra("cardData");
        try {
            entity = JSONObject.parseObject(data, BankCard1Entity.class);
            tvUserName.setText(entity.getName() + "");
            tvBankName.setText(entity.getBlank() + "");
            tvCardNum.setText(entity.getBankcard() + "");
        } catch (Exception e) {

        }
    }

    private void event() {
        tvFenhang.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {

            }

            @Override
            public void afterTextChanged(Editable s) {
                String content = tvFenhang.getText().toString().trim();
                if (content.length() > 1) {
                    btNextStep.setBackgroundColor(getResources().getColor(R.color.red_color));
                } else {
                    btNextStep.setBackgroundColor(Color.parseColor("#d9d9d9"));
                }
            }
        });
    }

    @OnClick({R.id.ll_choose_bank, R.id.ll_city, R.id.ll_fenhang, R.id.bt_next_step})
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.ll_choose_bank:
                break;
            case R.id.ll_city:
                selectCity();
                break;
            case R.id.ll_fenhang:
                break;
            case R.id.bt_next_step:
                String bankChild = tvFenhang.getText().toString().trim();
                if (AppUtil.isEmpty(bankChild)) {
                    ToastUtils.showToast(this, "请输入分行名称");
                    break;
                }
                if (province == null && !province.equals("")) {
                    ToastUtils.showToast(this, "请选择银行卡所属地");
                    break;
                }
                entity.setSite(bankChild);
                Intent intent = new Intent(this, AddCardFinalActivity.class);
                intent.putExtra("cardData", JSON.toJSONString(entity));
                intent.putExtra("province", province);
                intent.putExtra("city", city);
                startActivity(intent);
                break;
        }
    }

    @Subscribe(threadMode = ThreadMode.MAIN)
    public void receiveEvent(Event entity) {
        if (entity == null)
            return;
        try {
            int code = entity.getCode();
            switch (code) {
                case EventCode.BANK_ADD_SUCCESS:
                    finish();
                    break;
            }
        } catch (Exception e) {
        }
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        EventBusUtil.unregister(this);
    }

    private String province;
    private String city;

    private void selectCity() {
        CityConfig cityConfig = new CityConfig.Builder().build();
        mPicker.setConfig(cityConfig);

//监听选择点击事件及返回结果
        mPicker.setOnCityItemClickListener(new OnCityItemClickListener() {
            @Override
            public void onSelected(ProvinceBean provinceBean, com.lljjcoder.bean.CityBean cityBean, DistrictBean district) {
                province = provinceBean.getName();
                city = cityBean.getName();
                tvCity.setText(province + " " + city + " ");
            }

            @Override
            public void onCancel() {
                com.lljjcoder.style.citylist.Toast.ToastUtils.showLongToast(mContext, "已取消");
            }
        });

        //显示
        mPicker.showCityPicker( );

    }
}
