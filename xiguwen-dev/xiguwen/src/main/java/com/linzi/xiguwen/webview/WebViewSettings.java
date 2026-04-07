package com.linzi.xiguwen.webview;

import android.content.Context;
import android.os.Build;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.widget.ZoomButtonsController;

import com.linzi.xiguwen.utils.GetNetworkType;

import java.lang.reflect.Method;

/***
 * @author devin
 * @description 初始化webviewSettings
 * @createTime 2016年1月9日
 */
public class WebViewSettings {
    ZoomButtonsController zoom_controll;
    WebSettings webset;

    public WebViewSettings(Context mContext, WebView mWebView) {
        webset = mWebView.getSettings();
        webset.setJavaScriptEnabled(true);
        webset.setJavaScriptCanOpenWindowsAutomatically(true);
        webset.setGeolocationEnabled(true); // default is true
        webset.setGeolocationDatabasePath(mContext.getFilesDir().getPath());
//        webset.setUserAgentString(webset.getUserAgentString() + Constants.WEB_USER_AGENT + getCpuType());
        webset.setAllowFileAccess(true);
        webset.setSupportZoom(true);
        webset.setBuiltInZoomControls(true); // 设置显示缩放按钮
        webset.setDatabaseEnabled(true);
        webset.setUseWideViewPort(true);// 设定支持viewport
        webset.setSupportMultipleWindows(false);
        webset.setDomStorageEnabled(true);
//        webset.setAppCacheEnabled(true);
//        webset.setAppCachePath(mContext.getFilesDir().getPath());
        webset.setLoadWithOverviewMode(true);
        webset.setUseWideViewPort(true);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
            mWebView.setWebContentsDebuggingEnabled(true);
        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            webset.setMixedContentMode(WebSettings.MIXED_CONTENT_ALWAYS_ALLOW);
        }
        if (GetNetworkType.IsNetWorkEnable(mContext)) {//是否存在网络
            webset.setCacheMode(WebSettings.LOAD_DEFAULT);//优先使用缓存
        } else {
            webset.setCacheMode(WebSettings.LOAD_CACHE_ELSE_NETWORK);//优先使用缓存
        }

//		webset.setLayoutAlgorithm(LayoutAlgorithm.SINGLE_COLUMN);

        String dir = mWebView.getContext().getDir("database", Context.MODE_PRIVATE).getPath();
        // if ( Build.VERSION.SDK_INT < 19 ){
        webset.setDatabasePath(dir);
        // }
        if (Build.VERSION.SDK_INT >= 19) {
            webset.setLoadsImagesAutomatically(true);
        } else {
            webset.setLoadsImagesAutomatically(false);
        }

        // 去掉缩放按钮
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.HONEYCOMB) {
            // Use the API 11+ calls to disable the controls
            webset.setBuiltInZoomControls(true);
            webset.setDisplayZoomControls(false);
        } else {
            // Use the reflection magic to make it work on earlier APIs
            getControlls();
        }

    }


    /*
     * This is where the magic happens :D
     */
    private void getControlls() {
        try {
            Class webview = Class.forName("android.webkit.WebView");
            Method method = webview.getMethod("getZoomButtonsController");
            zoom_controll = (ZoomButtonsController) method.invoke(this, true);
        } catch (Exception e) {
            com.linzi.xiguwen.utils.LogUtil.printStackTrace(e);
        }
    }


}
