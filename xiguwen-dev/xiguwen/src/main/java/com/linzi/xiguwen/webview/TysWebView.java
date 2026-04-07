package com.linzi.xiguwen.webview;

import android.app.Activity;
import android.content.Context;
import android.webkit.WebView;
import android.widget.FrameLayout;
import android.widget.LinearLayout;

/**
 * Created by devin on 2016/10/26 11:12
 * Description
 */
public class TysWebView {

    private WebView mWebView;
    private Context mContext;
    private TYSWebChromeClient mWebChromeClient;
    private TYSWebViewClient mWebViewClient;
    private LinearLayout mContentView;
    private FrameLayout videoView;

    /**
     * 初始化webviw
     *
     * @param context
     * @param mWebView

     * @param videoView    用于全屏播放H5视频的view
     * @param mContentView //承载webview内容的view
     */
    public TysWebView(Context context, WebView mWebView, FrameLayout videoView, LinearLayout mContentView) {
        this.mWebView = mWebView;
        this.mContext = context;
        this.mContentView = mContentView;
        this.videoView = videoView;
        init();
    }

    private void init() {
        new WebViewSettings(mContext, mWebView);
//        if (WebViewSettings.isTysApi(url)) {
//            mWebView.addJavascriptInterface(new JSBridgeTYSNAV(mContext, mWebView, mHandler), "TYSNAV");
//        }
        mWebChromeClient = new TYSWebChromeClient((Activity) mContext, mWebView, mContentView, videoView);
        mWebViewClient = new TYSWebViewClient(mContext, mWebView);
        mWebView.setWebChromeClient(mWebChromeClient);
        mWebView.setWebViewClient(mWebViewClient);
    }


    public void setmFileChooserImplForAndroid(TYSWebChromeClient.FileChooserImplForAndroid mFileChooserImplForAndroid) {
        if (mWebChromeClient != null)
            mWebChromeClient.setmFileChooserImplForAndroid(mFileChooserImplForAndroid);
    }

    public void setWebStatusListener(TYSWebViewClient.WebStatusListener listener) {
        if (listener != null)
            mWebViewClient.WebStatusListener(listener);
    }

    public boolean inCustomView() {

        return mWebChromeClient.inCustomView();
    }

    public void hideCustomView() {
        mWebChromeClient.onHideCustomView();
    }

    public void setWebTitle(OnWebTitleListener webTitle) {
        if (mWebChromeClient != null) {
            mWebChromeClient.setWebTitleListener(webTitle);
        }
    }
}
