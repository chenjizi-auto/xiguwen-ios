package com.linzi.xiguwen.webview;

import android.app.Activity;
import android.content.Context;
import android.graphics.Bitmap;
import android.net.Uri;
import android.net.http.SslError;
import android.webkit.SslErrorHandler;
import android.webkit.WebResourceResponse;
import android.webkit.WebView;
import android.webkit.WebViewClient;

import com.linzi.xiguwen.utils.LoadDialog;

import java.io.IOException;

public class TYSWebViewClient extends WebViewClient {
    private WebView mWebView;
    private Context activity;
    /**
     * 1.表示URL中存在“@aykAPP_othersite”，在当前web中请求url
     */
    private int isOhter;

    private WebStatusListener listener;
    private ADIntentUtils adIntentUtils;

    public void WebStatusListener(WebStatusListener listener) {
        this.listener = listener;
    }

    public TYSWebViewClient(Context activity, WebView mWebView) {
        this.mWebView = mWebView;
        this.activity = activity;
        adIntentUtils = new ADIntentUtils((Activity) activity);
    }

    @Override
    public boolean shouldOverrideUrlLoading(WebView view, String url) {
        com.linzi.xiguwen.utils.LogUtil.e("weburl", "==shouldurl==" + url);
        String lowerCase = url.toLowerCase();

//        if (lowerCase.startsWith("http://") || lowerCase.startsWith("https://")) {
//            if (isOhter == 1 || lowerCase.contains(AykappConstants.aykAPP_err.toLowerCase())
//                    || lowerCase.contains(AykappConstants.aykAPP_native.toLowerCase())) {
////                view.loadUrl(url);
//
////                return super.shouldOverrideUrlLoading(view, url);
//                return adIntentUtils.shouldOverrideUrlLoadingByApp(mWebView,url);
//            } else {
//                WebViewActivity.startAction(activity,  url);
//            }
//            return true;
//
//        }
//        view.loadUrl(url);
        return adIntentUtils.shouldOverrideUrlLoadingByApp(mWebView, url);
//        return super.shouldOverrideUrlLoading(view, url);
    }

    @Override
    public void onPageStarted(WebView view, String url, Bitmap favicon) {
        com.linzi.xiguwen.utils.LogUtil.d("webstarturl", "==starturl==" + url);
//        String lowerCase = url.toLowerCase();
//        if (lowerCase.contains(AykappConstants.aykAPP_othersite.toLowerCase())||lowerCase.contains(AykappConstants.aykAPP_single.toLowerCase())) {
//            isOhter = 1;
//        }
//        if (listener != null && isOhter == 1) {
//            listener.start();
//        }
        LoadDialog.showDialog(activity);
        super.onPageStarted(view, url, favicon);
    }

    @Override
    public void onPageFinished(WebView view, String url) {

        if (!mWebView.getSettings().getLoadsImagesAutomatically()) {
            mWebView.getSettings().setLoadsImagesAutomatically(true);
        }
        LoadDialog.CancelDialog();
        //&& isOhter == 1  去掉  12-0711:08 jayqiu
        if (listener != null) {
            listener.loadFinish();
        }
    }

    @Override
    public void onReceivedError(WebView view, int errorCode, String description, String failingUrl) {
        super.onReceivedError(view, errorCode, description, failingUrl);
        view.loadUrl("file:///android_asset/app/match_neterror.html#errorCode=" + errorCode + "&curUrl="
                + Uri.encode(failingUrl));


    }

    private static final String INJECTION_TOKEN = "**injection**";

    @Override
    public WebResourceResponse shouldInterceptRequest(WebView view, String url) {
        WebResourceResponse response = super.shouldInterceptRequest(view, url);
        if (url != null && url.contains(INJECTION_TOKEN)) {
            String assetPath = url.substring(url.indexOf(INJECTION_TOKEN) + INJECTION_TOKEN.length(), url.length());
            try {
                response = new WebResourceResponse(
                        "application/javascript",
                        "UTF-8",
                        activity.getAssets().open(assetPath)
                );
            } catch (IOException e) {
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(e); // Failed to load asset file
            }
        }
        return response;
    }


    @Override
    public void onReceivedSslError(WebView view, SslErrorHandler handler, SslError error) {
//        super.onReceivedSslError(view, handler, error);
        handler.proceed();
    }

    public interface WebStatusListener {

        void start();

        void loadFinish();

        void downloadApk(String url);
    }
}
