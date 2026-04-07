package com.linzi.xiguwen.ui;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.text.SpannableString;
import android.text.Spanned;
import android.text.TextPaint;
import android.text.TextUtils;
import android.text.style.ClickableSpan;
import android.view.View;
import android.widget.ImageView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.utils.SPUtil;
import com.linzi.xiguwen.utils.StatusBarUtil;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;
import com.linzi.xiguwen.utils.yixin.preference.Preferences;
import com.linzi.xiguwen.widget.AskDialog;
import com.netease.nimlib.sdk.NimIntent;
import com.netease.nimlib.sdk.msg.model.IMMessage;
import java.util.ArrayList;
import butterknife.BindView;
import butterknife.ButterKnife;
public class WelcomeActivity extends Activity {
    @BindView(R.id.bg)
    ImageView bg;
    private String user_id;
    private String token;

    private static final String TAG = "WelcomeActivity";

    private boolean customSplash = false;
    private Context mContext;

    private static boolean firstEnter = true; // 是否首次进入
    public AskDialog askDialog;

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
            StatusBarUtil.setStatusBarColor(WelcomeActivity.this, R.color.trans);
            StatusBarUtil.setNavigationBarColor(WelcomeActivity.this, R.color.trans);
        }
        setContentView(R.layout.activity_welcome);
        ButterKnife.bind(this);
        mContext = this;

//        bg.setBackgroundResource(R.mipmap.icon_welcome);
        com.linzi.xiguwen.utils.LogUtil.e("setBackgroundResource",""+(boolean) SPUtil.get("isNeedZC", SPUtil.Type.BOOL));
        if (!(boolean) SPUtil.get("isNeedZC", SPUtil.Type.BOOL)) {
            com.linzi.xiguwen.utils.LogUtil.e("setBackgroundResource",""+"--------11");
            SpannableString builder = new SpannableString("感谢您信任并使用喜顾问，在您使用喜顾问服务前，请认真阅读《喜顾问用户协议》和《隐私政策》的全部内容，以了解用户权利义务和个人信息处理规则。\n" +
                    "\n" +
                    "我们将严格按照《喜顾问用户协议》和《隐私政策》为您提供服务。\n" +
                    "\n" +
                    "如您同意，请点击“同意”使用我们的服务\n");
            builder.setSpan(new Clickable(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    WenzhangDetailsActivity.startAction(mContext, "http://www.xiguwen520.com/wap/news/userprotocol.html", "用户协议", false);
                }
            }), 28, 37, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE);
            builder.setSpan(new Clickable(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    WenzhangDetailsActivity.startAction(mContext, "http://www.xiguwen520.com/wap/news/privacy.html", "隐私协议", false);
                }
            }), 39, 44, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE);

            builder.setSpan(new Clickable(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    WenzhangDetailsActivity.startAction(mContext, "http://www.xiguwen520.com/wap/news/userprotocol.html", "用户协议", false);
                }
            }), 78, 87, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE);
            builder.setSpan(new Clickable(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    WenzhangDetailsActivity.startAction(mContext, "http://www.xiguwen520.com/wap/news/privacy.html", "隐私协议", false);
                }
            }), 89, 94, Spanned.SPAN_EXCLUSIVE_EXCLUSIVE);


            showDialog("用户协议与隐私保护", "不同意", "同意并继续", builder, new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    askDialog.dismiss();
                    showDialog(null, "不同意并退出", "同意并使用", "不同意将无法使用我们的产品和服务，并会退出App", new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            finish();
                            askDialog.dismiss();
                        }
                    }, new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            SPUtil.put("isNeedZC", true);
                            EventBusUtil.sendEvent(new Event(EventCode.AGREE));
                            initView();
                            askDialog.dismiss();
                        }
                    });
                }
            }, new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    SPUtil.put("isNeedZC", true);
                    EventBusUtil.sendEvent(new Event(EventCode.AGREE));
                    initView();
                    askDialog.dismiss();
                }
            });

        }else {
            com.linzi.xiguwen.utils.LogUtil.e("setBackgroundResource",""+"--------21");
            initView();
        }

    }

    private void initView() {
        token = SPUtil.get("token", SPUtil.Type.STR).toString();
        new Handler(new Handler.Callback() {

            @Override
            public boolean handleMessage(Message msg) {
                startActivity(new Intent(WelcomeActivity.this, MainActivity.class));
//                if (!TextUtils.isEmpty(token)) {
//                    startActivity(new Intent(WelcomeActivity.this, MainActivity.class));
//                } else {
//                    startActivity(new Intent(WelcomeActivity.this, LoginActivity.class));
//                }
                finish();
                overridePendingTransition(R.anim.activity_enter, R.anim.activity_exit);
                return false;
            }
        }).sendEmptyMessageDelayed(0, 1500);
    }


    private void showSplashView() {
        // 首次进入，打开欢迎界面
        initView();
        customSplash = true;
    }

    @Override
    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
    }

    @Override
    protected void onResume() {
        super.onResume();
    }

    @Override
    public void finish() {
        super.finish();
//        overridePendingTransition(0, 0);
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
//        DemoCache.setMainTaskLaunching(false);

    }

    @Override
    protected void onSaveInstanceState(Bundle outState) {
        super.onSaveInstanceState(outState);
//        outState.clear();
    }

    /**
     * 已经登陆过，自动登陆
     */
    private boolean canAutoLogin() {
        String account = Preferences.getUserAccount();
        String token = Preferences.getUserToken();

        com.linzi.xiguwen.utils.LogUtil.i(TAG, "get local sdk token =" + token);
        return !TextUtils.isEmpty(account) && !TextUtils.isEmpty(token);
    }

    private void parseNotifyIntent(Intent intent) {
        ArrayList<IMMessage> messages = (ArrayList<IMMessage>) intent.getSerializableExtra(NimIntent.EXTRA_NOTIFY_CONTENT);
        if (messages == null || messages.size() > 1) {
            showMainActivity(null);
        } else {
            showMainActivity(new Intent().putExtra(NimIntent.EXTRA_NOTIFY_CONTENT, messages.get(0)));
        }
    }



    private void parseNormalIntent(Intent intent) {
        showMainActivity(intent);
    }

    private void showMainActivity() {
        showMainActivity(null);
    }

    private void showMainActivity(Intent intent) {
        MainActivity.start(WelcomeActivity.this, intent);
        finish();
    }


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
            ds.setColor(getResources().getColor(R.color.blue));
//            ds.setFlags(Paint.UNDERLINE_TEXT_FLAG);
//            ds.setAntiAlias(true);
        }
    }
}
