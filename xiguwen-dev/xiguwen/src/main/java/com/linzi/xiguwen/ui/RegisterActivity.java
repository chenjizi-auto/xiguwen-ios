package com.linzi.xiguwen.ui;

import android.content.Context;
import android.content.Intent;
import android.graphics.Color;
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
import com.baidu.location.BDLocation;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.CodeBean;
import com.linzi.xiguwen.bean.RigisterBean;
import com.linzi.xiguwen.net.OnRequestSubscribe;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.AppUtil;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.StatusBarUtil;
import com.linzi.xiguwen.utils.TimeReader;
import com.linzi.xiguwen.utils.location.CustomLocationListener;
import com.linzi.xiguwen.utils.location.LocationHelper;
import com.lljjcoder.Interface.OnCityItemClickListener;
import com.lljjcoder.bean.DistrictBean;
import com.lljjcoder.bean.ProvinceBean;
import com.lljjcoder.citywheel.CityConfig;
import com.lljjcoder.style.citypickerview.CityPickerView;

import org.xutils.common.Callback;

import butterknife.BindView;
import butterknife.ButterKnife;

public class RegisterActivity extends AppCompatActivity {
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
    //    @BindView(R.id.ll_bar)
//    LinearLayout llBar;
    @BindView(R.id.iv_close)
    ImageView ivClose;
    @BindView(R.id.tv_city)
    TextView tvCity;
    @BindView(R.id.tv_argument2)
    TextView tvArgument2;

    private int type = -1;

    private Context mContext;

    private TimeReader reader;

    private String userid;
    private String token;
    private final CityPickerView mPicker=new CityPickerView();
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //改变为白色背景黑色字体的状态栏
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
            StatusBarUtil.setStatusBarColor(RegisterActivity.this, R.color.trans);
            StatusBarUtil.setNavigationBarColor(RegisterActivity.this, R.color.white);
        }
        mPicker.init(this);

        setContentView(R.layout.activity_register);
        ButterKnife.bind(this);
        mContext = this;
        initData();
    }

    private void initData() {
        //获得状态栏高度
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, StatusBarUtil.getStatusBarHeight(RegisterActivity.this));
//        llBar.setLayoutParams(params);

        reader = new TimeReader(60000, 1000, btGetCode, mContext);

        ivClose.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                finish();
            }
        });
        tvToLogin.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                finish();
            }
        });
        Intent intent = getIntent();
        type = intent.getIntExtra("type", 0);

        switch (type) {
            case 4:
                setTitle("绑定账号");
                userid = intent.getStringExtra("otherUid");
                token = intent.getStringExtra("otherToken");
                btRegister.setText("立即绑定");
                break;
            case 3:
                setTitle("用户注册");
                break;
            case 1:
                setTitle("商家注册");
                break;
            case 2:
                setTitle("商家注册");
                break;
        }

        requestCity();

        tvCity.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                selectCity();
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
                    if (type == 4) {
                        getOherCode(edPhone.getText().toString());
                    } else {
                        getCode(edPhone.getText().toString());
                    }

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
                if (TextUtils.isEmpty(edPwd2.getText())) {
                    NToast.show("请确认密码");
                    return;
                }
                if (!edPwd.getText().toString().equals(edPwd2.getText().toString())) {
                    NToast.show("两次密码输入不同");
                    return;
                }
                if (AppUtil.isEmpty(provence) || AppUtil.isEmpty(county) || AppUtil.isEmpty(city)) {
                    NToast.show("请选择城市");
                    return;
                }
                if (type == 4) {
                    registerOther(edPhone.getText().toString(), edCode.getText().toString(), edPwd.getText().toString(), edPwd2.getText().toString(), 3, userid, token);
                } else {
                    register(edPhone.getText().toString(), edCode.getText().toString(), edPwd.getText().toString(), edPwd2.getText().toString());
                }

            }
        });

        tvArgument.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                //startActivity(new Intent(mContext, AgreementActivity.class));
                WenzhangDetailsActivity.startAction(mContext, "http://www.boyihunjia.com/wap/news/userprotocol.html", "用户协议", false);
            }
        });
        tvArgument2.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                //startActivity(new Intent(mContext, AgreementActivity.class));
                WenzhangDetailsActivity.startAction(mContext, "http://www.boyihunjia.com/wap/news/privacy_protocol.html", "隐私政策", false);
            }
        });
    }

    private void getCode(String phone) {
        LoadDialog.showDialog(mContext);
        new ApiManager().getSms(phone, "register", new Callback.CommonCallback<String>() {
            @Override
            public void onSuccess(String result) {
                NToast.log("结果", result);
                CodeBean codebean = JSONObject.parseObject(result, CodeBean.class);
                NToast.show(codebean.getMessage());
                if (codebean.getCode().equals("0")) {
                    reader.start();
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

    private void register(String phone, String code, String pwd, String pwd2) {
        LoadDialog.showDialog(mContext);
        new ApiManager().register(phone, code, pwd, pwd2, type, provence, city, county, new Callback.CommonCallback<String>() {
            @Override
            public void onSuccess(String result) {
                RigisterBean bean = JSONObject.parseObject(result, RigisterBean.class);
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

    //第三方绑定获取验证码
    private void getOherCode(String phone) {
        LoadDialog.showDialog(mContext);
        ApiManager.getSms1(phone, null, new OnRequestSubscribe<BaseBean>() {
            @Override
            public void onSuccess(BaseBean data) {
                NToast.show(data.getMessage());
                LoadDialog.CancelDialog();
                reader.start();
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                LoadDialog.CancelDialog();
            }
        });
    }

    //第三方绑定
    private void registerOther(String phone, String code, String pwd, String pwd2, int type, String userid, String token) {
        LoadDialog.showDialog(mContext);
        ApiManager.registerOther(phone, code, pwd, pwd2, type, userid, token, provence, city, county, new OnRequestSubscribe<BaseBean>() {
            @Override
            public void onSuccess(BaseBean data) {
                LoadDialog.CancelDialog();
                NToast.show("绑定成功，请重新登录");
                finish();
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                LoadDialog.CancelDialog();
            }
        });
    }

    private String provence = "";
    private String county = "";
    private String city = "";



    private void selectCity() {
        CityConfig cityConfig = new CityConfig.Builder().build();
        mPicker.setConfig(cityConfig);

//监听选择点击事件及返回结果
        mPicker.setOnCityItemClickListener(new OnCityItemClickListener() {
            @Override
            public void onSelected(ProvinceBean province, com.lljjcoder.bean.CityBean cityBean, DistrictBean district) {
                provence = province.getName();
                city = cityBean.getName();
                county = district.getName();
//                edLocation.setText(citySelected[0] + citySelected[1] + citySelected[2]);
                tvCity.setText(provence + " " + city + " " + county);
            }

            @Override
            public void onCancel() {
                com.lljjcoder.style.citylist.Toast.ToastUtils.showLongToast(mContext, "已取消");
            }
        });

        //显示
        mPicker.showCityPicker( );

    }



    private void requestCity() {
        LocationHelper.requestLocation(new CustomLocationListener.ReceiveLocation() {
            @Override
            public void onLocation(BDLocation bdLocation) {
                if (bdLocation == null || bdLocation.getLocType() == BDLocation.TypeServerError || bdLocation.getCity() == null) {
                } else {
                    provence = bdLocation.getProvince();
                    city = bdLocation.getCity();
                    county = bdLocation.getDistrict();
                    tvCity.setText(provence + " " + city + " " + county);
                }

            }
        });
    }

}
