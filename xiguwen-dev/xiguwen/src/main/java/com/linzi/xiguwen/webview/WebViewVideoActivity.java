package com.linzi.xiguwen.webview;

import android.content.Context;
import android.content.Intent;
import android.content.res.Configuration;
import android.os.Build;
import android.os.Bundle;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import android.view.WindowManager;
import android.webkit.WebView;
import android.widget.FrameLayout;
import android.widget.LinearLayout;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.utils.AppUtil;
import com.linzi.xiguwen.utils.StatusBarUtil;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

/**
 * Created by devin on 2018/4/17 15:01
 * Description  视频播放web
 */

public class WebViewVideoActivity extends AppCompatActivity {

    @BindView(R.id.web_video_view)
    FrameLayout webVideoView;
    @BindView(R.id.web_webview)
    WebView mWebview;
    @BindView(R.id.web_content_view)
    LinearLayout webContentView;
    private TysWebView mTysWebView;

    private String url;

    public static void startAction(Context context, String url) {
        if (AppUtil.isEmpty(url)) {
            com.linzi.xiguwen.utils.LogUtil.e("==========", "url==null");
            return;
        }
        Intent intent = new Intent(context, WebViewVideoActivity.class);
        intent.putExtra("url", url);
        context.startActivity(intent);
    }

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //改变为白色背景黑色字体的状态栏
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            StatusBarUtil.setStatusBarColor(WebViewVideoActivity.this, R.color.black);
        }

        setContentView(R.layout.activiy_webview_video);
        ButterKnife.bind(this);
        init();
        url = getIntent().getStringExtra("url");
        int width=AppUtil.getWidth(this);
        mWebview.setLayoutParams(new LinearLayout.LayoutParams(width,width*9/16));
        mWebview.loadUrl(url);
    }

    @Override
    protected void onResume() {
        super.onResume();
        mWebview.onResume();
        mWebview.resumeTimers();
    }

    @Override
    protected void onPause() {
        super.onPause();
        mWebview.onPause();
        mWebview.pauseTimers();
    }

    @Override
    protected void onDestroy() {
//        mWebview.removeJavascriptInterface("TYSNAV");
        mWebview.loadUrl("about:blank");
        mWebview.stopLoading();
        mWebview.setWebChromeClient(null);
        mWebview.setWebViewClient(null);
        mWebview.clearHistory();
        webContentView.removeView(mWebview);
        mWebview.removeAllViews();
        mWebview.destroy();
        mWebview = null;
        super.onDestroy();
    }

    private void init() {
        mTysWebView = new TysWebView(this, mWebview, webVideoView, webContentView);
//        mTysWebView.setmFileChooserImplForAndroid(this);
        mWebview.setVerticalScrollBarEnabled(false);//去掉webview的滚动条
    }

    @Override
    public void onConfigurationChanged(Configuration newConfig) {
        super.onConfigurationChanged(newConfig);
        if (newConfig.orientation == Configuration.ORIENTATION_LANDSCAPE) {
            // com.linzi.xiguwen.utils.LogUtil.i("webview", " 现在是横屏1");
            getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN,
                    WindowManager.LayoutParams.FLAG_FULLSCREEN);
            getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON); // 不息屏

        } else if (newConfig.orientation == Configuration.ORIENTATION_PORTRAIT) {
            // com.linzi.xiguwen.utils.LogUtil.i("webview", " 现在是竖屏1");
            getWindow().clearFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN);
        }
    }

    @Override
    public void onBackPressed() {
        super.onBackPressed();
        finish();
    }

    @OnClick(R.id.web_back)
    public void onViewClicked() {
        finish();
    }
}
