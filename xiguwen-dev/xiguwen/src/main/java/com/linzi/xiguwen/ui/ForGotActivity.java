package com.linzi.xiguwen.ui;

import android.content.Context;
import android.os.Build;
import android.os.Bundle;
import androidx.appcompat.app.AppCompatActivity;
import android.text.TextUtils;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.alibaba.fastjson.JSONObject;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.BaseBean;
import com.linzi.xiguwen.bean.CodeBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.StatusBarUtil;
import com.linzi.xiguwen.utils.TimeReader;

import org.xutils.common.Callback;

import butterknife.BindView;
import butterknife.ButterKnife;

public class ForGotActivity extends AppCompatActivity {
    @BindView(R.id.ed_phone)
    EditText edPhone;
    @BindView(R.id.ed_code)
    EditText edCode;
    @BindView(R.id.bt_get_code)
    Button btGetCode;
    @BindView(R.id.ed_pwd)
    EditText edPwd;
    @BindView(R.id.ed_pwd2)
    EditText edPwd2;
    @BindView(R.id.bt_register)
    Button btRegister;
    @BindView(R.id.tv_to_login)
    TextView tvToLogin;
    @BindView(R.id.tv_argument)
    TextView tvArgument;
    @BindView(R.id.ll_bar)
    LinearLayout llBar;
    @BindView(R.id.iv_close)
    ImageView ivClose;
    @BindView(R.id.tv_title)
    TextView tvTitle;

    private Context mContext;

    private TimeReader reader;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //改变为白色背景黑色字体的状态栏
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
            StatusBarUtil.setStatusBarColor(ForGotActivity.this, R.color.trans);
            StatusBarUtil.setNavigationBarColor(ForGotActivity.this, R.color.white);
        }

        setContentView(R.layout.activity_forgot);
        ButterKnife.bind(this);
        mContext = this;
        initData();
    }

    private void initData() {
        tvTitle.setText("修改密码");
        //获得状态栏高度
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, StatusBarUtil.getStatusBarHeight(ForGotActivity.this));
        llBar.setLayoutParams(params);

        reader = new TimeReader(60000, 1000, btGetCode, mContext);

        ivClose.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                finish();
            }
        });

        btGetCode.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (reader.mFlag == 0) {
                    if (TextUtils.isEmpty(edPhone.getText())) {
                        NToast.show("请输入手机号码");
                        return;
                    }
                    getCode(edPhone.getText().toString());
                } else {
                    NToast.show("请稍候再试");
                }
            }
        });

        btRegister.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View view) {
                if (TextUtils.isEmpty(edPhone.getText())) {
                    NToast.show("请输入手机号");
                    return;
                }
                if (TextUtils.isEmpty(edCode.getText())) {
                    NToast.show("请输入验证码");
                    return;
                }
                if (TextUtils.isEmpty(edPwd.getText())) {
                    NToast.show("请输入密码");
                    return;
                }
                register(edPhone.getText().toString(), edCode.getText().toString(), edPwd.getText().toString());
            }
        });
    }

    private void getCode(String phone) {
        LoadDialog.showDialog(mContext);
        new ApiManager().getSms(phone, "findpwd", new Callback.CommonCallback<String>() {
            @Override
            public void onSuccess(String result) {
                NToast.log("结果", result);
                BaseBean codebean = JSONObject.parseObject(result, BaseBean.class);
                NToast.show(codebean.getMessage());
//                if (codebean.getCode()==0) {
                    reader.start();
//                }
            }

            @Override
            public void onError(Throwable ex, boolean isOnCallback) {

            }

            @Override
            public void onCancelled(CancelledException cex) {

            }

            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }
        });
    }

    private void register(String phone, String code, String pwd) {
        LoadDialog.showDialog(mContext);
        new ApiManager().ForGot(phone, code, pwd, new Callback.CommonCallback<String>() {
            @Override
            public void onSuccess(String result) {
                NToast.log("结果",result);
                CodeBean bean = JSONObject.parseObject(result, CodeBean.class);
                NToast.show(bean.getMessage());
                if (bean.getCode().equals("0")) {
                    finish();
                }
            }

            @Override
            public void onError(Throwable ex, boolean isOnCallback) {

            }

            @Override
            public void onCancelled(CancelledException cex) {

            }

            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }
        });
    }
}
