package com.linzi.xiguwen.ui;

import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.widget.Button;
import android.widget.EditText;

import com.alibaba.fastjson.JSON;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.BankCard1Entity;
import com.linzi.xiguwen.net.OnRequestSubscribe;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.AppUtil;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;

import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class AddCardStep1Activity extends BaseActivity {

    @BindView(R.id.ed_name)
    EditText edName;
    @BindView(R.id.ed_card_num)
    EditText edCardNum;
    @BindView(R.id.bt_next_step)
    Button btNextStep;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_add_card_step1);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        setTitle("添加账户");
        setBack();

        EventBusUtil.register(this);

        edName.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence charSequence, int i, int i1, int i2) {

            }

            @Override
            public void onTextChanged(CharSequence s, int i, int i1, int i2) {
                if (s.length() > 0) {
                    if (edCardNum.getText().length() > 0) {
                        btNextStep.setBackgroundColor(getResources().getColor(R.color.colorTitleRed));
                    } else {
                        btNextStep.setBackgroundColor(Color.parseColor("#d9d9d9"));
                    }
                } else {
                    btNextStep.setBackgroundColor(Color.parseColor("#d9d9d9"));
                }
            }

            @Override
            public void afterTextChanged(Editable editable) {

            }
        });

        edCardNum.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence charSequence, int i, int i1, int i2) {

            }

            @Override
            public void onTextChanged(CharSequence s, int i, int i1, int i2) {
                if (s.length() > 0) {
                    if (edName.getText().length() > 0) {
                        btNextStep.setBackgroundColor(getResources().getColor(R.color.colorTitleRed));
                    } else {
                        btNextStep.setBackgroundColor(Color.parseColor("#d9d9d9"));
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

    @OnClick(R.id.bt_next_step)
    public void onClick() {

        httpNext();
    }

//    private void httpNext() {
//        String name = edName.getText().toString().trim();
//        String num = edCardNum.getText().toString().trim();
//        if (AppUtil.isEmpty(name) || AppUtil.isEmpty(num)) {
//            return;
//        }
//        LoadDialog.showDialog(this);
//        ApiManager.bankAddCard1(num, name, new OnRequestSubscribe<BaseBean<BankCard1Entity>>() {
//            @Override
//            public void onSuccess(BaseBean<BankCard1Entity> data) {
//                LoadDialog.CancelDialog();
//                BankCard1Entity entity = data.getData();
//                Intent intent = new Intent(AddCardStep1Activity.this, AddCardStep2Activity.class);
//                intent.putExtra("cardData", JSON.toJSONString(entity));
//                startActivity(intent);
//            }
//
//            @Override
//            public void onError(Exception ex) {
//                LoadDialog.CancelDialog();
//                ToastUtils.showToast(AddCardStep1Activity.this, ex.getMessage());
//            }
//        });
//    }

    private void httpNext() {
        String name = edName.getText().toString().trim();
        String num = edCardNum.getText().toString().trim();
        if (AppUtil.isEmpty(name) || AppUtil.isEmpty(num)) {
            return;
        }
//        LoadDialog.showDialog(this);
//        ApiManager.bankAddCard1(num, name, new OnRequestSubscribe<BaseBean<BankCard1Entity>>() {
//            @Override
//            public void onSuccess(BaseBean<BankCard1Entity> data) {
//                LoadDialog.CancelDialog();
//                BankCard1Entity entity = data.getData();
//                Intent intent = new Intent(AddCardStep1Activity.this, AddCardStep2Activity.class);
//                intent.putExtra("cardData", JSON.toJSONString(entity));
//                startActivity(intent);
//            }
//
//            @Override
//            public void onError(Exception ex) {
//                LoadDialog.CancelDialog();
//                ToastUtils.showToast(AddCardStep1Activity.this, ex.getMessage());
//            }
//        });
        Intent intent = new Intent(this,GetMsgCodeActivity.class);
        intent.putExtra("name",name);
        intent.putExtra("ali_name",num);
        startActivity(intent);
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
}
