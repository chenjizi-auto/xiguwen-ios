package com.linzi.xiguwen.ui;

import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import androidx.appcompat.app.AppCompatActivity;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.LoginUtil;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.StatusBarUtil;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class RegisterStepActivity extends AppCompatActivity {

    @BindView(R.id.rb_service)
    CheckBox rbService;
    @BindView(R.id.rb_mall)
    CheckBox rbMall;
    @BindView(R.id.bt_next)
    Button btNext;

    private int type = 1;
    private int form_type;//1 表示申请成为商家

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //改变为白色背景黑色字体的状态栏
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
            StatusBarUtil.setStatusBarColor(this, R.color.trans);
            StatusBarUtil.setNavigationBarColor(this, R.color.white);
        }

        setContentView(R.layout.activity_register_step);
        ButterKnife.bind(this);
        form_type = getIntent().getIntExtra("form_type", -1);
        if (form_type == 1) {
            btNext.setText("确认");
        }
    }

//    @Override
//    protected void initData() {
//        setTitle("账号注册");
//        setBack();
//    }

    @OnClick({R.id.rb_service, R.id.rb_mall, R.id.bt_next, R.id.iv_close})
    public void onClick(View view) {
        Intent intent;
        switch (view.getId()) {
            case R.id.rb_service:
                rbMall.setChecked(false);
                rbService.setChecked(true);
                type = 2;
                break;
            case R.id.rb_mall:
                rbMall.setChecked(true);
                rbService.setChecked(false);
                type = 1;
                break;
            case R.id.bt_next:
                if (type != -1) {
                    if (form_type == 1) {
                        postData();
                    } else {
                        intent = new Intent(this, RegisterActivity.class);
                        intent.putExtra("type", type);
                        startActivity(intent);
                    }
                } else {
                    NToast.show("请选择类型");
                }
                finish();
                break;
            case R.id.iv_close:
                finish();
                break;
        }
    }

    private void postData() {
        LoadDialog.showDialog(RegisterStepActivity.this);
        ApiManager.shenQingBeShop( type, new OnRequestFinish<BaseBean>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean data) {
                NToast.show(data.getMessage());
                finish();
                LoginUtil.loginOut();
                RegisterStepActivity.this.startActivity(new Intent(RegisterStepActivity.this, LoginActivity.class));
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
            }
        });
    }
}
