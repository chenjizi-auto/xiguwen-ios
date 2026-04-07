package com.linzi.xiguwen.webview;

import android.app.Activity;
import android.content.Intent;
import android.content.pm.ActivityInfo;
import android.net.Uri;
import android.view.View;
import android.webkit.ValueCallback;
import android.webkit.WebChromeClient;
import android.webkit.WebView;
import android.widget.FrameLayout;
import android.widget.LinearLayout;


public class TYSWebChromeClient extends WebChromeClient {

    private WebView mWebView;
    private LinearLayout mContentView;
    private FrameLayout videoView;
    private Activity activity;
    private View xCustomView;
    private CustomViewCallback xCustomViewCallback;
    private OnWebTitleListener onTitle;

    public final static int FILECHOOSER_RESULTCODE = 1;
    public final static int FILECHOOSER_RESULTCODE_FOR_ANDROID_5 = 2;
    private FileChooserImplForAndroid mFileChooserImplForAndroid;

    public TYSWebChromeClient(Activity activity, WebView mwebView, LinearLayout contentView, FrameLayout videoView) {

        this.videoView = videoView;
        this.mContentView = contentView;
        this.mWebView = mwebView;
        this.activity = activity;
    }


    @Override
    public void onShowCustomView(View view, CustomViewCallback callback) {
        activity.setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE);
        mContentView.setVisibility(View.GONE);
        // 如果一个视图已经存在，那么立刻终止并新建一个
        if (xCustomView != null) {
            callback.onCustomViewHidden();
            videoView.removeView(xCustomView);
            return;
        }
//		videoView.removeAllViews();

        com.linzi.xiguwen.utils.LogUtil.e("", "KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK");
        videoView.addView(view);
        xCustomView = view;
        xCustomViewCallback = callback;
        videoView.setVisibility(View.VISIBLE);
    }

    @Override
    public void onHideCustomView() {

        if (xCustomView == null)// 不是全屏播放状态
            return;

        // Hide the custom view.

        activity.setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT);
        xCustomView.setVisibility(View.GONE);

        // Remove the custom view from its container.
        videoView.removeView(xCustomView);
        xCustomView = null;
        videoView.setVisibility(View.GONE);
        xCustomViewCallback.onCustomViewHidden();

        mContentView.setVisibility(View.VISIBLE);

        // com.linzi.xiguwen.utils.LogUtil.i(LOGTAG, "set it to webVew");

    }

    @Override
    public void onReceivedTitle(WebView view, String title) {
        super.onReceivedTitle(view, title);
        if (title != null) {
            if (onTitle != null) {
                onTitle.setWebTitle(title);
            }
        }

    }

    // 扩展浏览器上传文件
    public void openFileChooser(ValueCallback<Uri> uploadMsg, String acceptType) {
        openFileChooserImpl(uploadMsg);
    }

    // 3.0--版本
    public void openFileChooser(ValueCallback<Uri> uploadMsg) {
        openFileChooserImpl(uploadMsg);
    }

    // For Android > 4.1.1
    public void openFileChooser(ValueCallback<Uri> uploadMsg, String acceptType, String capture) {
        openFileChooserImpl(uploadMsg);
    }

    // For Android > 5.0
    public boolean onShowFileChooser(WebView webView, ValueCallback<Uri[]> uploadMsg,
                                     FileChooserParams fileChooserParams) {
        openFileChooserImplForAndroid5(uploadMsg);
        return true;
    }

    private void openFileChooserImpl(ValueCallback<Uri> uploadMsg) {
        com.linzi.xiguwen.utils.LogUtil.e("openFileChooserImpl", "======================================");
        Intent i = new Intent(Intent.ACTION_GET_CONTENT);
        i.addCategory(Intent.CATEGORY_OPENABLE);
        i.setType("image/*");
        if (mFileChooserImplForAndroid != null) {
            mFileChooserImplForAndroid.UploadMessage(uploadMsg);
        }
        activity.startActivityForResult(Intent.createChooser(i, "图片选择"), FILECHOOSER_RESULTCODE);
    }

    private void openFileChooserImplForAndroid5(ValueCallback<Uri[]> uploadMsg) {

        Intent contentSelectionIntent = new Intent(Intent.ACTION_GET_CONTENT);
        contentSelectionIntent.addCategory(Intent.CATEGORY_OPENABLE);
        contentSelectionIntent.setType("image/*");

        Intent chooserIntent = new Intent(Intent.ACTION_CHOOSER);
        chooserIntent.putExtra(Intent.EXTRA_INTENT, contentSelectionIntent);
        chooserIntent.putExtra(Intent.EXTRA_TITLE, "图片选择");
        if (mFileChooserImplForAndroid != null) {
            mFileChooserImplForAndroid.UploadMessageForAndroid5(uploadMsg);
        }
        activity.startActivityForResult(chooserIntent, FILECHOOSER_RESULTCODE_FOR_ANDROID_5);
    }

    /**
     * 判断是否全屏
     *
     * @return
     */
    public boolean inCustomView() {
        return (xCustomView != null);
    }

    public void setWebTitleListener(OnWebTitleListener onTitle) {
        this.onTitle = onTitle;
    }

    public void setmFileChooserImplForAndroid(FileChooserImplForAndroid mFileChooserImplForAndroid) {
        this.mFileChooserImplForAndroid = mFileChooserImplForAndroid;
    }

    /**
     * 监听url title接口
     */
    public interface FileChooserImplForAndroid {
        /**
         * 扩展浏览器上传文件 5.0版本
         *
         * @param uploadMessageForAndroid5
         */
        public void UploadMessageForAndroid5(ValueCallback<Uri[]> uploadMessageForAndroid5);

        /**
         * // 扩展浏览器上传文件 // 3.0++版本
         *
         * @param uploadMessage
         */
        public void UploadMessage(ValueCallback<Uri> uploadMessage);
    }
//
//	/** 监听url title接口 */
//	public interface onTitle {
//
//		/**
//		 *
//		 * @param title
//		 *            url title回调
//		 */
//		public void getTitle(String title);
//	}

}
