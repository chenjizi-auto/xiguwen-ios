package com.linzi.xiguwen.ui;

import android.graphics.Color;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

import com.alibaba.fastjson.JSONObject;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.BankCard1Entity;
import com.linzi.xiguwen.net.OnRequestSubscribe;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.AppUtil;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.TimeReader;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;
import com.luck.picture.lib.utils.ToastUtils;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class AddCardFinalActivity extends BaseActivity {

    @BindView(R.id.ed_phone)
    EditText edPhone;
    @BindView(R.id.bt_getCode)
    Button btGetCode;
    @BindView(R.id.ed_code)
    EditText edCode;
    @BindView(R.id.bt_next_step)
    Button btNextStep;

    private BankCard1Entity entity;
    private TimeReader reader;
    private String province;
    private String city;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_add_card_final);
        ButterKnife.bind(this);
        province = getIntent().getStringExtra("province");
        city = getIntent().getStringExtra("city");
    }

    @Override
    protected void initData() {
        setTitle("添加银行卡");
        setBack();
        String data = getIntent().getStringExtra("cardData");
        try {
            entity = JSONObject.parseObject(data, BankCard1Entity.class);
        } catch (Exception e) {

        }
        edPhone.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence charSequence, int i, int i1, int i2) {

            }

            @Override
            public void onTextChanged(CharSequence s, int i, int i1, int i2) {
                if (s.length() > 0) {
                    btGetCode.setBackgroundColor(getResources().getColor(R.color.colorMain));
                    if (edCode.getText().length() > 0) {
                        btNextStep.setBackgroundColor(getResources().getColor(R.color.colorMain));
                    } else {
                        btNextStep.setBackgroundColor(Color.parseColor("#d9d9d9"));
                    }
                } else {
                    btGetCode.setBackgroundColor(Color.parseColor("#d9d9d9"));
                }
            }

            @Override
            public void afterTextChanged(Editable editable) {

            }
        });

        edCode.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence charSequence, int i, int i1, int i2) {

            }

            @Override
            public void onTextChanged(CharSequence s, int i, int i1, int i2) {
                if (s.length() > 0) {
                    btNextStep.setBackgroundColor(getResources().getColor(R.color.colorMain));
                    if (edPhone.getText().length() > 0) {
                        btGetCode.setBackgroundColor(getResources().getColor(R.color.colorMain));
                    } else {
                        btGetCode.setBackgroundColor(Color.parseColor("#d9d9d9"));
                    }
                } else {
                    btNextStep.setBackgroundColor(Color.parseColor("#d9d9d9"));
                }
            }

            @Override
            public void afterTextChanged(Editable editable) {

            }
        });
    }

    private void httpAdd() {
        String mobile = edPhone.getText().toString().trim();
        String vCode = edCode.getText().toString().trim();
        if (!AppUtil.isEmpty(mobile) && !AppUtil.isEmpty(vCode)) {
            LoadDialog.showDialog(this);
            ApiManager.bankAddCard3(entity.getBlank(), entity.getBankcard(), province, city, entity.getName(), mobile, entity.getSite(), vCode, new OnRequestSubscribe<BaseBean>() {
                @Override
                public void onSuccess(BaseBean data) {
                    LoadDialog.CancelDialog();
                    ToastUtils.showToast(AddCardFinalActivity.this, "添加成功");
                    EventBusUtil.sendEvent(new Event(EventCode.BANK_ADD_SUCCESS, 0));
                    finish();
                }

                @Override
                public void onError(Exception ex) {
                    LoadDialog.CancelDialog();
                    ToastUtils.showToast(AddCardFinalActivity.this, ex.getMessage());
                }
            });
        }
    }

    private void httpCode() {
        String phone = edPhone.getText().toString().trim();
        if (AppUtil.isEmpty(phone)) {
            return;
        }
        LoadDialog.showDialog(this);
        ApiManager.getSms1(phone, null, new OnRequestSubscribe<BaseBean>() {
            @Override
            public void onSuccess(BaseBean data) {
                LoadDialog.CancelDialog();
                if (reader == null) {
                    reader = new TimeReader(60000, 1000, btGetCode, mContext);
                }
                reader.start();

            }

            @Override
            public void onError(Exception ex) {
                ToastUtils.showToast(AddCardFinalActivity.this, ex.getMessage());
                LoadDialog.CancelDialog();
            }
        });


    }

    @OnClick({R.id.bt_getCode, R.id.bt_next_step})
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.bt_getCode:
                if (reader == null || reader.mFlag == 0) {
                    httpCode();
                }
                break;
            case R.id.bt_next_step:
                httpAdd();
                break;
        }
    }
}
