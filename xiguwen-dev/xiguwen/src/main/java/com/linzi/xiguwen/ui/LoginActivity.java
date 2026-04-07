package com.linzi.xiguwen.ui;

import android.content.Context;
import android.content.Intent;
import android.graphics.Paint;
import android.os.Build;
import android.os.Bundle;
import android.text.Editable;
import android.text.SpannableString;
import android.text.TextPaint;
import android.text.TextUtils;
import android.text.TextWatcher;
import android.text.style.ClickableSpan;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import androidx.appcompat.app.AppCompatActivity;

import com.alibaba.fastjson.JSONObject;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.LoginBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.AppUtil;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.SPUtil;
import com.linzi.xiguwen.utils.StatusBarUtil;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;
import com.linzi.xiguwen.utils.yixin.DemoCache;
import com.linzi.xiguwen.utils.yixin.preference.Preferences;
import com.linzi.xiguwen.utils.yixin.preference.UserPreferences;
import com.linzi.xiguwen.widget.AskDialog;
import com.netease.nimlib.sdk.AbortableFuture;
import com.netease.nimlib.sdk.NIMClient;
import com.netease.nimlib.sdk.StatusBarNotificationConfig;
import com.netease.nimlib.sdk.auth.LoginInfo;
import com.umeng.socialize.UMAuthListener;
import com.umeng.socialize.UMShareAPI;
import com.umeng.socialize.bean.SHARE_MEDIA;

import org.xutils.common.Callback;

import java.util.Map;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;
import cn.jpush.android.api.JPushInterface;

public class LoginActivity extends AppCompatActivity implements Callback.CommonCallback<String> {

    @BindView(R.id.ed_user_name)
    EditText edUserName;
    @BindView(R.id.ed_pwd)
    EditText edPwd;
    @BindView(R.id.bt_login)
    TextView btLogin;
    @BindView(R.id.tv_forget)
    TextView tvForget;
    @BindView(R.id.bt_wechat)
    TextView btWechat;
    @BindView(R.id.tv_user_register)
    TextView tvUserRegister;
    /*@BindView(R.id.tv_mall_register)
    TextView tvMallRegister;*/
    @BindView(R.id.iv_close)
    ImageView ivClose;
//    @BindView(R.id.ll_bar)
//    LinearLayout llBar;

    private Context mContext;
    private AbortableFuture<LoginInfo> loginRequest;

    private String phone;
    private String pass;

    public AskDialog askDialog;


    public static void startAction(Context context) {
        Intent intent = new Intent(context, LoginActivity.class);
        context.startActivity(intent);
    }


    public void showDialog(String title, String canalStr, String sureStr, String content, View.OnClickListener canalClickListener, View.OnClickListener clickListener) {
        askDialog = null;
        askDialog = new AskDialog(this);
        askDialog.setSubmitListener(canalStr, sureStr, content, clickListener, canalClickListener);
        askDialog.setMessage(title);
        askDialog.show();
    }

    public void showDialog(String title, String canalStr, String sureStr, SpannableString builder, View.OnClickListener canalClickListener, View.OnClickListener clickListener) {
        askDialog = null;
        askDialog = new AskDialog(this);
        askDialog.setSubmitListener(canalStr, sureStr, clickListener, canalClickListener);
        askDialog.setMessage(title);
        askDialog.setContent(builder);
        askDialog.show();
    }


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        //改变为白色背景黑色字体的状态栏
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
            StatusBarUtil.setStatusBarColor(LoginActivity.this, R.color.trans);
            StatusBarUtil.setNavigationBarColor(LoginActivity.this, R.color.white);
        }

        setContentView(R.layout.activity_login);
        ButterKnife.bind(this);
        mContext = this;
        initData();

    }

    private void initData() {
        //获得状态栏高度
        final LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, StatusBarUtil.getStatusBarHeight(LoginActivity.this));
//        llBar.setLayoutParams(params);

        ivClose.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                finish();
            }
        });

        edPwd.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {

            }

            @Override
            public void afterTextChanged(Editable s) {
                pass = edPwd.getText().toString();
                phone = edUserName.getText().toString();
                if (!AppUtil.isEmpty(pass) && !AppUtil.isEmpty(phone)) {
                    btLogin.setBackgroundResource(R.drawable.login_bt_selector);
                } else {
                    btLogin.setBackgroundResource(R.drawable.btn_gray);
                }
            }
        });

        edUserName.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {

            }

            @Override
            public void afterTextChanged(Editable s) {
                pass = edPwd.getText().toString();
                phone = edUserName.getText().toString();
                if (!AppUtil.isEmpty(pass) && !AppUtil.isEmpty(phone)) {
                    btLogin.setBackgroundResource(R.drawable.login_bt_selector);
                } else {
                    btLogin.setBackgroundResource(R.drawable.btn_gray);
                }
            }
        });
    }


    //@OnClick({R.id.bt_login, R.id.tv_forget, R.id.bt_wechat, R.id.tv_user_register, R.id.tv_mall_register})
    @OnClick({R.id.bt_login, R.id.tv_forget, R.id.bt_wechat, R.id.tv_user_register})
    public void onClick(View view) {
        Intent intent;
        switch (view.getId()) {
            case R.id.bt_login:
                if (TextUtils.isEmpty(edUserName.getText())) {
                    NToast.show("请输入账户");
                    return;
                }
                if (TextUtils.isEmpty(edPwd.getText())) {
                    NToast.show("请输入密码");
                    return;
                }
                LoadDialog.showDialog(mContext);
                new ApiManager().login(edUserName.getText().toString(), edPwd.getText().toString(), 0, "", JPushInterface.getRegistrationID(this),this);
                break;
            case R.id.tv_forget:
//                intent = new Intent(this, ForGotActivity.class);
//                startActivity(intent);
                Intent intent3 = new Intent(mContext, BindPhone2Activity.class);
                intent3.putExtra("tag", 3);
                startActivity(intent3);
                break;
            case R.id.bt_wechat:
                if (mShareAPI == null) {
                    mShareAPI = UMShareAPI.get(this);
                }
                mShareAPI.getPlatformInfo(this, SHARE_MEDIA.WEIXIN, umAuthListener);
                break;
            case R.id.tv_user_register:
                intent = new Intent(this, RegisterActivity.class);
                intent.putExtra("type", 3);
                startActivity(intent);
                break;
                /*
            case R.id.tv_mall_register:
                intent = new Intent(this, RegisterStepActivity.class);
                startActivity(intent);
                break;*/
        }
    }

    //8ebd32cc0515edbf19f9b497415721d6656c1f6c   76
    @Override
    public void onSuccess(String result) {
        NToast.log("结果", result);
        LoginBean bean = JSONObject.parseObject(result, LoginBean.class);
        if (bean.getCode() == 0) {

            int userId = bean.getData().getToken().getUserid();
            String token = bean.getData().getToken().getToken();
            String imToken = bean.getData().getToken().getIm_token();
            SPUtil.put("token", token);
            SPUtil.put("userid", userId);
            SPUtil.put("im", bean.getData().getToken().getIm_token());
            SPUtil.put("account", bean.getData().getUser().getMobile());
            SPUtil.put("usertype", bean.getData().getUser().getUsertype());

            Preferences.saveString(Preferences.USER_PHONE, bean.getData().getUser().getMobile());
            Preferences.saveString(Preferences.WACHAT_OPENID, bean.getData().getUser().getWachat_openid());
//            doLogin(bean.getData().getUser().getMobile(),bean.getData().getToken().getIm_token());

          //  login("user" + userId, imToken);

//            Intent intent = new Intent(mContext, MainActivity.class);
//            startActivity(intent);
//            finish();
            onLoginDone();
            saveLoginInfo("user" + userId, token);
            EventBusUtil.sendEvent(new Event(EventCode.LOGIN_SUCCESS));
            finish();
        } else if (bean.getCode() == 908) {//第三方登录未绑定手机

            int userId = bean.getData().getToken().getUserid();
            String token = bean.getData().getToken().getToken();
//            Preferences.saveInt(Preferences.LOGIN_OHTER_UID, userId);
//            Preferences.saveString(Preferences.LOGIN_OTHER_TOKEN, token);
            Intent intent = new Intent(this, RegisterActivity.class);
            intent.putExtra("type", 4);
            intent.putExtra("otherUid", userId + "");
            intent.putExtra("otherToken", token);
            startActivity(intent);
        } else {
            NToast.show(bean.getMessage());
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


//    public void doLogin(String account ,String token) {
//        LoginInfo info = new LoginInfo(account,token); // config...
//        RequestCallback<LoginInfo> callback =
//                new RequestCallback<LoginInfo>() {
//                    @Override
//                    public void onSuccess(LoginInfo param) {
//
//                    }
//
//                    @Override
//                    public void onFailed(int code) {
//
//                    }
//
//                    @Override
//                    public void onException(Throwable exception) {
//
//                    }
//                    // 可以在此保存LoginInfo到本地，下次启动APP做自动登录用
//                };
//        NIMClient.getService(AuthService.class).login(info)
//                .setCallback(callback);
//    }

    private void onLoginDone() {
        loginRequest = null;
//        DialogMaker.dismissProgressDialog();
        LoadDialog.CancelDialog();
    }

    private void login(final String account, final String token) {
//        DialogMaker.showProgressDialog(this, null, getString(R.string.logining), true, new DialogInterface.OnCancelListener() {
//            @Override
//            public void onCancel(DialogInterface dialog) {
//                if (loginRequest != null) {
//                    loginRequest.abort();
//                    onLoginDone();
//                }
//            }
//        }).setCanceledOnTouchOutside(false);

        LoadDialog.showDialog(this);

        // 云信只提供消息通道，并不包含用户资料逻辑。开发者需要在管理后台或通过服务器接口将用户帐号和token同步到云信服务器。
        // 在这里直接使用同步到云信服务器的帐号和token登录。
        // 这里为了简便起见，demo就直接使用了密码的md5作为token。
        // 如果开发者直接使用这个demo，只更改appkey，然后就登入自己的账户体系的话，需要传入同步到云信服务器的token，而不是用户密码。
//        final String account = "hhh1234567890";
//        final String token = "e10adc3949ba59abbe56e057f20f883e";
//        final String account="user67";
//        final String    token="42b49fdeb4908d48ec2670313c2cb504";
        // 登录
//        loginRequest = NimUIKit.login(new LoginInfo(account, token), new RequestCallback<LoginInfo>() {
//            @Override
//            public void onSuccess(LoginInfo param) {
////                LogUtil.i("IM", "login success");
//
//                onLoginDone();
//
//                DemoCache.setAccount(account);
//                saveLoginInfo(account, token);
//// 打开单聊界面
////                NimUIKit.startP2PSession(this, "user16");
//                // 初始化消息提醒配置
//                initNotificationConfig();
//
//                // 进入主界面
////                MainActivity.start(LoginActivity.this, null);
////                finish();
//
////                Intent intent = new Intent(mContext, MainActivity.class);
////                startActivity(intent);
//                EventBusUtil.sendEvent(new Event(EventCode.LOGIN_SUCCESS));
//                finish();
//            }
//
//            @Override
//            public void onFailed(int code) {
//                onLoginDone();
//                if (code == 302 || code == 404) {
//                    Toast.makeText(LoginActivity.this, R.string.login_failed, Toast.LENGTH_SHORT).show();
//                } else {
//                    Toast.makeText(LoginActivity.this, "IM登录失败: " + code, Toast.LENGTH_SHORT).show();
//                }
//            }
//
//            @Override
//            public void onException(Throwable exception) {
//                NToast.log("APPTAG", exception.toString());
//                Toast.makeText(LoginActivity.this, exception.toString(), Toast.LENGTH_LONG).show();
//                onLoginDone();
//            }
//        });
    }

    private void saveLoginInfo(final String account, final String token) {
        Preferences.saveUserAccount(account);
        Preferences.saveUserToken(token);
    }

    private void initNotificationConfig() {
        // 初始化消息提醒
        NIMClient.toggleNotification(UserPreferences.getNotificationToggle());

        // 加载状态栏配置
        StatusBarNotificationConfig statusBarNotificationConfig = UserPreferences.getStatusConfig();
        if (statusBarNotificationConfig == null) {
            statusBarNotificationConfig = DemoCache.getNotificationConfig();
            statusBarNotificationConfig.ring = true;
            statusBarNotificationConfig.notificationSound = "android.resource://com.linzi.xiguwen/raw/msg";
            UserPreferences.setStatusConfig(statusBarNotificationConfig);
        }
        // 更新配置
        NIMClient.updateStatusBarNotificationConfig(statusBarNotificationConfig);
    }

    UMShareAPI mShareAPI;

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        UMShareAPI.get(this).onActivityResult(requestCode, resultCode, data);

    }

    private String loginId;
    private String nickname;
    private String head;
    private String sex;


    UMAuthListener umAuthListener = new UMAuthListener() {
        @Override
        public void onStart(SHARE_MEDIA share_media) {
            LoadDialog.showDialog(mContext);
        }

        @Override
        public void onComplete(SHARE_MEDIA share_media, int i, Map<String, String> map) {
//            LoadDialog.showDialog(mContext);
            loginId = map.get("uid");
            nickname = map.get("name");
            head = map.get("iconurl");
            sex = map.get("gender");
//            new ApiManager().login(edUserName.getText().toString(), edPwd.getText().toString(), 1, id, LoginActivity.this);
//            LoadDialog.CancelDialog();
            new ApiManager().loginOther(nickname, head, sex, 3, loginId, JPushInterface.getRegistrationID(LoginActivity.this), LoginActivity.this);
        }

        @Override
        public void onError(SHARE_MEDIA share_media, int i, Throwable throwable) {
//            LoadDialog.CancelDialog();
            if (throwable != null)
                NToast.show(throwable.getMessage());
            LoadDialog.CancelDialog();
        }

        @Override
        public void onCancel(SHARE_MEDIA share_media, int i) {
            LoadDialog.CancelDialog();
//            LoadDialog.CancelDialog();
//            NToast.show("请输入密码");
        }
    };

    /**
     * 实现一个TextView 部分文字响应不同的点击事件
     */
    class Clickable extends ClickableSpan {
        private final View.OnClickListener mListener;

        public Clickable(View.OnClickListener l) {
            mListener = l;
        }

        @Override
        public void onClick(View view) {
            mListener.onClick(view);
        }

        /**
         * 重写父类updateDrawState方法  我们可以给TextView设置字体颜色,背景颜色等等...
         */
        @Override
        public void updateDrawState(TextPaint ds) {
            //ds.setColor(getResources().getColor(R.color.blue));
            ds.setFlags(Paint.UNDERLINE_TEXT_FLAG);
            ds.setAntiAlias(true);
        }
    }

}
