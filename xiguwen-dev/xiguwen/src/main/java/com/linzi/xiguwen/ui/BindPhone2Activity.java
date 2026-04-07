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
import com.linzi.xiguwen.network.Constans;
import com.linzi.xiguwen.utils.AppUtil;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.SPUtil;
import com.linzi.xiguwen.utils.TimeReader;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;
import com.linzi.xiguwen.utils.yixin.LogoutHelper;
import com.linzi.xiguwen.utils.yixin.preference.Preferences;
import com.luck.picture.lib.utils.ToastUtils;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class BindPhone2Activity extends BaseActivity {

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

    private int tag = 0;
    private String codeType;
    private String oldCode;
    private String oldPhone;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_bind_phone2);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        setBack();

        Intent intent = getIntent();
        tag = intent.getIntExtra("tag", 0);
        if (tag == 0) {
            setTitle("改绑手机号");
            edPhone.setHint("请输入新手机号码");
            oldCode = intent.getStringExtra("code");
            oldPhone = intent.getStringExtra("phone");
        } else if (tag == 1) {
            edPhone.setText(Preferences.getString(Preferences.USER_PHONE) + "");
            codeType = "findpwd";
            setTitle("修改登录密码");
            btNextStep.setText("下一步");
            edPhone.setFocusable(false);
        } else if (tag == 2) {
            edPhone.setText(Preferences.getString(Preferences.USER_PHONE) + "");
            setTitle("修改支付密码");
            btNextStep.setText("下一步");
            edPhone.setFocusable(false);
        } else if (tag == 3) {
            tag = 1;
            codeType = "findpwd";
            setTitle("找回密码");
            btNextStep.setText("下一步");
        }
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
                if (tag == 0) {
//                    final AskDialog dialog = new AskDialog(mContext, BindPhone2Activity.this);
//                    dialog.setTitle("绑定成功！");
//                    dialog.setMessage("159****6364已成功绑定您的账号。该手机号可用于登录、接收交易信息和订阅短信。祝您购物愉快~");
//                    dialog.setSignButton("我知道了", new View.OnClickListener() {
//                        @Override
//                        public void onClick(View view) {
//                            dialog.dismiss();
//                        }
//                    });
//                    dialog.show();
                    phoneBind();
                } else {
//                    Intent intent = new Intent(this, EditPasswordActivity.class);
//                    startActivity(intent);
                    httpNextUpdate();
                }
                break;
        }
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        if (reader != null) {
            reader.cancel();
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
        ApiManager.getSms1(phone, codeType, new OnRequestSubscribe<BaseBean>() {
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

    //修改密码
    private void httpNextUpdate() {
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
        String api = "";
        if (tag == 1) {
            api = Constans.Action.PASSWORD_UPDATE_ONE;
        } else if (tag == 2) {
            api = Constans.Action.PASSWORD_UPDATE_ONE_PAY;
        }
        LoadDialog.showDialog(this);
        ApiManager.passwordOne(code, phone, api, new OnRequestSubscribe<BaseBean>() {
            @Override
            public void onSuccess(BaseBean data) {
                LoadDialog.CancelDialog();

                Intent intent = new Intent(mContext, EditPasswordActivity.class);
                intent.putExtra("code", code);
                intent.putExtra("phone", phone);
                intent.putExtra("tag", tag);
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

    //绑定手机
    private void phoneBind() {
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
        ApiManager.bindpassTwo(oldCode, oldPhone, code, phone, new OnRequestSubscribe<BaseBean>() {
            @Override
            public void onSuccess(BaseBean data) {
                LoadDialog.CancelDialog();
                Intent intent4 = new Intent(mContext, LoginActivity.class);
                SPUtil.clear();
                LogoutHelper.logout();
                startActivity(intent4);
                ToastUtils.showToast(mContext, "修改成功，请重新登录");
                EventBusUtil.sendEvent(new Event(EventCode.PASSWORD_UPDATE_SUCCESS));
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
