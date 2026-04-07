package com.linzi.xiguwen.ui;

import android.os.Bundle;
import android.text.TextUtils;
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
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;
import com.linzi.xiguwen.utils.yixin.preference.Preferences;
import com.luck.picture.lib.utils.ToastUtils;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by pc on 2019/3/5.
 */

public class GetMsgCodeActivity extends BaseActivity {

    @BindView(R.id.ed_phone)
    EditText edPhone;
    @BindView(R.id.bt_get_code)
    Button btGetCode;
    @BindView(R.id.ed_code)
    EditText edCode;
    @BindView(R.id.tv_to_guestion)
    TextView tvToGuestion;
    @BindView(R.id.bt_next_step)
    Button btNextStep;
    private String ali_name, name;
    private TimeReader reader;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_bind_phone2);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        ali_name = getIntent().getStringExtra("ali_name");
        name = getIntent().getStringExtra("name");
        setTitle("身份验证");
        setBack();
        btNextStep.setText("下一步");
        edPhone.setEnabled(false);
        edPhone.setText(Preferences.getString(Preferences.USER_PHONE) + "");

        btGetCode.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                httpCode();
            }
        });
        btNextStep.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (!TextUtils.isEmpty(edCode.getText().toString())) {
                    httpNext();
                }
            }
        });
    }

    private void httpCode() {
        String phone = edPhone.getText().toString().trim();
        if (AppUtil.isEmpty(phone)) {
            ToastUtils.showToast(mContext, "请输入手机号码");
            return;
        }
        LoadDialog.showDialog(this);
        ApiManager.getSms1(phone, "findpwd", new OnRequestSubscribe<BaseBean>() {
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
        LoadDialog.showDialog(this);
        ApiManager.aliPayAdd(ali_name, name, edPhone.getText().toString().trim(), edCode.getText().toString().trim(), new OnRequestSubscribe<BaseBean>() {
            @Override
            public void onSuccess(BaseBean data) {
                LoadDialog.CancelDialog();
                ToastUtils.showToast(mContext, data.getMessage());
                EventBusUtil.sendEvent(new Event(EventCode.BANK_ADD_SUCCESS));
                finish();
            }

            @Override
            public void onError(Exception ex) {
                LoadDialog.CancelDialog();
                ToastUtils.showToast(GetMsgCodeActivity.this, ex.getMessage());
            }
        });
    }

}
