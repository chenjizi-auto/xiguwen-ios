package com.linzi.xiguwen.ui;

import android.content.Intent;
import android.os.Bundle;
import android.widget.EditText;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.net.OnRequestSubscribe;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.AppUtil;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.SPUtil;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;
import com.linzi.xiguwen.utils.yixin.LogoutHelper;
import com.luck.picture.lib.utils.ToastUtils;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class EditPasswordActivity extends BaseActivity {

    @BindView(R.id.ed_pwd)
    EditText edPwd;
    @BindView(R.id.ed_pwd2)
    EditText edPwd2;

    private String code;
    private String phone;
    private int tag;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_edit_password);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {

        setBack();

        Intent intent = getIntent();
        code = intent.getStringExtra("code");
        phone = intent.getStringExtra("phone");
        tag = intent.getIntExtra("tag", 1);
        if (tag == 1){
           setTitle("修改登录密码");
        }else {
            setTitle("修改支付密码");
        }
    }

    @OnClick(R.id.bt_submit)
    public void onViewClicked() {
        submit();
    }

    String pass1;
    String pass2;

    private void submit() {
        pass1 = edPwd.getText().toString().trim();
        pass2 = edPwd2.getText().toString().trim();

        if (AppUtil.isEmpty(pass1)) {
            ToastUtils.showToast(mContext, "请输入密码");
            return;
        }

        if (!pass1.equals(pass2)) {
            ToastUtils.showToast(mContext, "两次密码不一致");
            return;
        }
        LoadDialog.showDialog(this);
        if (tag == 1) {
            httpLoginPass();
        } else if (tag == 2) {
            httpPayPass();
        }
    }

    private void httpLoginPass() {
        ApiManager.passwordTwo(code, phone, pass1, new OnRequestSubscribe<BaseBean>() {
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

    private void httpPayPass() {
        ApiManager.passwordPayTwo(code, phone, pass1, pass2, new OnRequestSubscribe<BaseBean>() {
            @Override
            public void onSuccess(BaseBean data) {
                LoadDialog.CancelDialog();
                ToastUtils.showToast(mContext, "修改成功");
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
