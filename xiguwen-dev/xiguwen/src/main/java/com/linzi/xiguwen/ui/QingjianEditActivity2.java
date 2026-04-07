//package com.linzi.bytc_new.ui;
//
//import android.content.Context;
//import android.content.Intent;
//import android.graphics.drawable.ColorDrawable;
//import android.media.AudioManager;
//import android.os.Build;
//import android.os.Bundle;
//import android.support.v7.app.AppCompatActivity;
//import android.view.Gravity;
//import android.view.LayoutInflater;
//import android.view.View;
//import android.view.ViewGroup;
//import android.view.WindowManager;
//import android.webkit.WebChromeClient;
//import android.webkit.WebSettings;
//import android.webkit.WebView;
//import android.webkit.WebViewClient;
//import android.widget.ImageView;
//import android.widget.LinearLayout;
//import android.widget.PopupWindow;
//import android.widget.RelativeLayout;
//
//import com.bumptech.glide.Glide;
//import com.linzi.bytc_new.R;
//import com.linzi.bytc_new.utils.ImageSelect;
//import com.linzi.bytc_new.utils.NToast;
//import com.linzi.bytc_new.utils.StatusBarUtil;
//import com.yancy.imageselector.ImageSelectorActivity;
//
//import java.util.ArrayList;
//import java.util.List;
//
//import butterknife.BindView;
//import butterknife.ButterKnife;
//
//public class QingjianEditActivity2 extends AppCompatActivity implements AudioManager.OnAudioFocusChangeListener {
//    @BindView(R.id.ll_bar)
//    LinearLayout llBar;
//    @BindView(R.id.web)
//    WebView web;
//    @BindView(R.id.iv_back)
//    ImageView ivBack;
//    @BindView(R.id.ll_del)
//    LinearLayout llDel;
//    @BindView(R.id.ll_setting)
//    LinearLayout llSetting;
//    @BindView(R.id.ll_toshow)
//    LinearLayout llToshow;
//    @BindView(R.id.ll_send)
//    LinearLayout llSend;
//    @BindView(R.id.ll_parent)
//    LinearLayout llParent;
//
//    Context mContext;
//    String url;
//    WebSettings setting;
//
//    ArrayList<String> path = new ArrayList<>();
//    ViewHolder vh;
//    View pop_view;
//    AudioManager mAudioManager; // 音频管理器，用于控制后台不播放。
//
//    public static void startActivity(Context context, String url) {
//        Intent intent = new Intent(context, QingjianEditActivity2.class);
//        intent.putExtra("url", url);
//        context.startActivity(intent);
//    }
//
//    @Override
//    protected void onCreate(Bundle savedInstanceState) {
//        super.onCreate(savedInstanceState);
//        //改变为白色背景黑色字体的状态栏
//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
//            getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
//            StatusBarUtil.setStatusBarColor(QingjianEditActivity2.this, R.color.trans);
//        }
//        setContentView(R.layout.activity_qingjian_edit);
//        ButterKnife.bind(this);
//        mContext = this;
//        url = getIntent().getStringExtra("url");
//
//        mAudioManager = (AudioManager) mContext.getSystemService(Context.AUDIO_SERVICE);
//        initView();
//    }
//
//    @Override
//    public void onPause() {
//        super.onPause();
//        web.onPause();
//        web.pauseTimers();
//
//        // 请求获取音频焦点，这样webview的音频由于没有焦点将会暂停。
//        int i = 0;
//        do {
//            int result = mAudioManager.requestAudioFocus(this
//                    , AudioManager.STREAM_MUSIC, AudioManager.AUDIOFOCUS_GAIN_TRANSIENT);
//
//            if (result == AudioManager.AUDIOFOCUS_REQUEST_GRANTED) {
//                NToast.log("QingJianZhiZuoYuLanActivity", "I get Audio right: ");
//                break;
//            }
//            i++;
//        } while (i < 10);
//    }
//
//    @Override
//    public void onResume() {
//        super.onResume();
//        if (web != null) {
//            web.resumeTimers();
//            web.onResume();
//        }
//
//        if (mAudioManager != null) {
//            //释放音频焦点
//            mAudioManager.abandonAudioFocus(this);
//        }
//    }
//
//    @Override
//    protected void onDestroy() {
//        if (web != null) {
//            web.stopLoading();
//            web.destroy();
//            web = null;
//        }
//
//        if (mAudioManager != null) {
//            //释放音频焦点
//            mAudioManager.abandonAudioFocus(this);
//            mAudioManager = null;
//        }
//        super.onDestroy();
//    }
//
//    private void initView() {
//        //获得状态栏高度
//        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, StatusBarUtil.getStatusBarHeight(QingjianEditActivity2.this));
//        llBar.setLayoutParams(params);
//
//        ivBack.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View view) {
//                finish();
//            }
//        });
//
//        setting = web.getSettings();
//        setting.setJavaScriptEnabled(true);
////        settings.setDatabaseEnabled(true);
//        setting.setGeolocationEnabled(true);
////        settings.setGeolocationDatabasePath(dir);
////        settings.setPluginsEnabled(true);
//        setting.setDomStorageEnabled(true);
//        setting.setUseWideViewPort(true);
//        setting.setLoadWithOverviewMode(true);
//        setting.setLoadsImagesAutomatically(true);
//        setting.setAllowFileAccess(true);  //设置可以访问文件
//        setting.setCacheMode(WebSettings.LOAD_CACHE_ELSE_NETWORK);
//        setting.setNeedInitialFocus(true); //当webview调用requestFocus时为webview设置节点
//        setting.setJavaScriptCanOpenWindowsAutomatically(true);
//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR1) {
//            setting.setMediaPlaybackRequiresUserGesture(false);
//        }
//        //触摸焦点起作用
//        web.requestFocus();
//        web.setFocusableInTouchMode(true);
//
//        web.setWebViewClient(new WebViewClient() {
//            @Override
//            public boolean shouldOverrideUrlLoading(WebView view, String url) {
//                view.loadUrl(url);
//                return true;
//            }
//        });
//        web.setWebChromeClient(new WebChromeClient() {
//            @Override
//            public void onProgressChanged(WebView view, int newProgress) {
////                super.onProgressChanged(view, newProgress);
////                if (newProgress == 100) {
////                    LoadDialog.CancelDialog();
////                } else {
////                    LoadDialog.showDialog(mContext);
////                }
//            }
//        });
//        if (url != null) {
//            web.loadUrl(url);
//        }
//
//        llSend.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View view) {
//                sharePop();
//            }
//        });
//
//        llSetting.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View view) {
//                Intent intent = new Intent(mContext, ChooseMusicActivity.class);
//                startActivity(intent);
//            }
//        });
//    }
//
//    @Override
//    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
////        super.onActivityResult(requestCode, resultCode, data);
//        if (requestCode == 1001 && resultCode == RESULT_OK && data != null) {
//            List<String> pathList = data.getStringArrayListExtra(ImageSelectorActivity.EXTRA_RESULT);
//            path.clear();
//            path.addAll(pathList);
//            if (vh != null) {
//                Glide.with(mContext).load(path.get(0)).into(vh.ivHeadImg);
//            }
//        }
//    }
//
//    // 分享
//    private void sharePop() {
//        final PopupWindow pop = new PopupWindow(mContext);
//        if (vh == null) {
//            pop_view = LayoutInflater.from(mContext).inflate(R.layout.pop_share_qj_layout, null);
//            vh = new ViewHolder(pop_view);
//            pop_view.setTag(vh);
//        } else {
//            vh = (ViewHolder) pop_view.getTag();
//        }
//        vh.llClose.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View view) {
//                pop.dismiss();
//            }
//        });
//
//        vh.rlSlectPhoto.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View view) {
//                ImageSelect.ActivityImageSelectSingle(QingjianEditActivity2.this, mContext, path, 1001);
//            }
//        });
//
//        // 设置弹出窗体可点击
//        pop.setFocusable(true);
//        int w = this.getWindowManager().getDefaultDisplay().getWidth();
////        int h = (this.getWindowManager().getDefaultDisplay().getHeight() / 2);
//        pop.setWidth(w);
////        pop.setHeight(h);
//        // 实例化一个ColorDrawable颜色为半透明
//        ColorDrawable dw = new ColorDrawable(0xffff0000);
//        // 设置弹出窗体的背景
//        pop.setBackgroundDrawable(dw);
//        // 设置弹出窗体显示时的动画，从底部向上弹出
//        pop.setAnimationStyle(R.style.AnimationPreview);
//        pop.setContentView(pop_view);
//        pop.update();
//        pop.showAtLocation(llParent, Gravity.BOTTOM | Gravity.CENTER_HORIZONTAL, 0, 0);
//        lightoff(true);
//        pop.setOnDismissListener(new PopupWindow.OnDismissListener() {
//            @Override
//            public void onDismiss() {
//                lightoff(false);
//            }
//        });
//    }
//
//    public void lightoff(boolean isoff) {
//        WindowManager.LayoutParams lp = getWindow().getAttributes();
//        if (isoff) {
//            lp.alpha = 0.3f;
//        } else {
//            lp.alpha = 1f;
//        }
//        getWindow().setAttributes(lp);
//    }
//
//    @Override
//    public void onAudioFocusChange(int focusChange) {
//
//    }
//
//    class ViewHolder {
//        @BindView(R.id.iv_head_img)
//        ImageView ivHeadImg;
//        @BindView(R.id.rl_slect_photo)
//        RelativeLayout rlSlectPhoto;
//        @BindView(R.id.ll_share_cir)
//        LinearLayout llShareCir;
//        @BindView(R.id.ll_share_fri)
//        LinearLayout llShareFri;
//        @BindView(R.id.ll_share_qq)
//        LinearLayout llShareQq;
//        @BindView(R.id.ll_share_qzone)
//        LinearLayout llShareQzone;
//        @BindView(R.id.ll_share_sina)
//        LinearLayout llShareSina;
//        @BindView(R.id.ll_share_msg)
//        LinearLayout llShareMsg;
//        @BindView(R.id.ll_close)
//        LinearLayout llClose;
//
//        ViewHolder(View view) {
//            ButterKnife.bind(this, view);
//        }
//    }
//}
