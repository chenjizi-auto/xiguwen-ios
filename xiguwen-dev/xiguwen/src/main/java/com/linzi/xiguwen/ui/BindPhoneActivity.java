package com.linzi.xiguwen.ui;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.net.OnRequestSubscribe;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.AppUtil;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.TimeReader;
import com.linzi.xiguwen.utils.yixin.preference.Preferences;
import com.luck.picture.lib.utils.ToastUtils;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class BindPhoneActivity extends BaseActivity {

    @BindView(R.id.tv_phone)
    TextView edPhone;
    @BindView(R.id.bt_get_code)
    Button btGetCode;
    @BindView(R.id.ed_code)
    EditText edCode;
    @BindView(R.id.tv_to_guestion)
    TextView tvToGuestion;
    @BindView(R.id.bt_next_step)
    Button btNextStep;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_bind_phone);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        setTitle("改绑手机号");
        setBack();
        edPhone.setText(Preferences.getString(Preferences.USER_PHONE) + "");
    }

    @OnClick({R.id.bt_get_code, R.id.tv_to_guestion, R.id.bt_next_step})
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.bt_get_code:
                if (reader == null || reader.mFlag == 0) {
                    httpCode();
                }
                break;
            case R.id.tv_to_guestion:

                break;
            case R.id.bt_next_step:
//                Intent intent = new Intent(mContext, BindPhone2Activity.class);
//                startActivity(intent);
                httpNext();
                break;
        }
    }

    private TimeReader reader;

    private void httpCode() {
        String phone = edPhone.getText().toString().trim();
        if (AppUtil.isEmpty(phone)) {
            ToastUtils.showToast(mContext, "请输入手机号码");
            return;
        }
        LoadDialog.showDialog(this);
        ApiManager.getSms1(phone, null, new OnRequestSubscribe<BaseBean>() {
            @Override
            public void onSuccess(BaseBean data) {
                LoadDialog.CancelDialog();
                ToastUtils.showToast(mContext, "验证码发送成功");
                if (reader == null) {
                    reader = new TimeReader(60000, 1000, btGetCode, mContext);
                }
                reader.start();

            }

            @Override
            public void onError(Exception ex) {
                ToastUtils.showToast(mContext, ex.getMessage());
                LoadDialog.CancelDialog();
            }
        });
    }

    private void httpNext() {
        final String code = edCode.getText().toString().trim();
        final String phone = edPhone.getText().toString().trim();
        if (AppUtil.isEmpty(phone)) {
            ToastUtils.showToast(mContext, "请输入手机号码");
            return;
        }
        if (AppUtil.isEmpty(code)) {
            ToastUtils.showToast(mContext, "请输入验证码");
            return;
        }
        LoadDialog.showDialog(this);
        ApiManager.bindpassOne(code, phone, new OnRequestSubscribe<BaseBean>() {
            @Override
            public void onSuccess(BaseBean data) {
                LoadDialog.CancelDialog();
                Intent intent = new Intent(mContext, BindPhone2Activity.class);
                intent.putExtra("code", code);
                intent.putExtra("phone", phone);
                startActivity(intent);
                finish();
            }

            @Override
            public void onError(Exception ex) {
                LoadDialog.CancelDialog();
                ToastUtils.showToast(mContext, ex.getMessage());
            }
        });
    }
}
