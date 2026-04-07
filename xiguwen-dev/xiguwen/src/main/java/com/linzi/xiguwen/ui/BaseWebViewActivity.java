package com.linzi.xiguwen.ui;

import android.content.Context;
import android.media.AudioManager;
import android.net.Uri;
import android.os.Bundle;
import android.view.Gravity;
import android.view.View;
import android.view.WindowManager;
import android.webkit.GeolocationPermissions;
import android.webkit.ValueCallback;
import android.webkit.WebChromeClient;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import com.hjq.permissions.OnPermissionCallback;
import com.hjq.permissions.Permission;
import com.hjq.permissions.XXPermissions;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.utils.GlideEngine;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.SelectPhotoTypePop;
import com.linzi.xiguwen.widget.FullCommonPopWindow;
import com.luck.picture.lib.basic.PictureSelector;
import com.luck.picture.lib.config.SelectMimeType;
import com.luck.picture.lib.engine.CompressFileEngine;
import com.luck.picture.lib.entity.LocalMedia;
import com.luck.picture.lib.interfaces.OnResultCallbackListener;
import com.luck.picture.lib.utils.ToastUtils;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import cn.jpush.android.helper.Logger;
import top.zibin.luban.Luban;
import top.zibin.luban.OnNewCompressListener;

/**
 * Created by PC on 2018-04-09.
 */

public abstract class BaseWebViewActivity extends AppCompatActivity implements AudioManager.OnAudioFocusChangeListener {

    @BindView(R.id.web)
    protected WebView mWebView;

    private AudioManager mAudioManager; // 音频管理器，用于控制后台不播放。
    private WebSettings mWebViewSettings;
    private ValueCallback mFilePathCallback; // 文件选择的回调
    public static final int REQUEST_CODE = 1000;


    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(getContentView());
        ButterKnife.bind(this);
        //mWebView = getWebView();
        initWebView();
        mAudioManager = (AudioManager) getSystemService(Context.AUDIO_SERVICE);
    }

    @Override
    protected void onResume() {
        if (mWebView != null) {
            mWebView.resumeTimers();
            mWebView.onResume();
        }

        if (mAudioManager != null) {
            //释放音频焦点
            if(mAudioManager != null){
                mAudioManager.abandonAudioFocus(BaseWebViewActivity.this);
                //手动播放音乐
                mWebView.loadUrl("javascript:try{media.play();}catch(err){}");
            }
        }
        super.onResume();
    }

    protected void loadUrl(String url) {
//        mWebView.clearCache(false);
        mWebView.clearHistory();
        mWebView.loadUrl(url);
    }

    @Override
    protected void onPause() {
        if (mWebView != null) {
            mWebView.onPause();
            mWebView.pauseTimers();
        }

        // 请求获取音频焦点，这样webview的音频由于没有焦点将会暂停。
        if (mAudioManager != null) {
            int i = 0;
            do {
                int result = mAudioManager.requestAudioFocus(this, AudioManager.STREAM_MUSIC, AudioManager.AUDIOFOCUS_GAIN_TRANSIENT);
                if (result == AudioManager.AUDIOFOCUS_REQUEST_GRANTED) {
                    NToast.log("QingJianZhiZuoYuLanActivity", "I get Audio right: ");
                    break;
                }
                i++;
            } while (i < 10);
        }
        super.onPause();
    }

    @Override
    protected void onDestroy() {
        if (mWebView != null) {
            mWebView.stopLoading();
            mWebView.destroy();
            mWebView = null;
        }

        if (mAudioManager != null) {
            //释放音频焦点
            mAudioManager.abandonAudioFocus(this);
            mAudioManager = null;
        }
        super.onDestroy();
    }

    //public abstract WebView getWebView();

    public abstract int getContentView();

    private void initWebView() {
        //mWebView.setLayerType(View.LAYER_TYPE_HARDWARE,null);
        //设置web
        mWebViewSettings = mWebView.getSettings();
        mWebViewSettings.setJavaScriptEnabled(true);

        mWebViewSettings.setSupportZoom(true); // 可以缩放
        mWebViewSettings.setBuiltInZoomControls(true); // 显示放大缩小 controler
        mWebViewSettings.setDisplayZoomControls(false);
        mWebViewSettings.setDefaultZoom(WebSettings.ZoomDensity.CLOSE);// 默认缩放模式

        mWebViewSettings.setGeolocationEnabled(true);
        mWebViewSettings.setDomStorageEnabled(true);
        mWebViewSettings.setUseWideViewPort(true);
        mWebViewSettings.setLoadWithOverviewMode(true);
        mWebViewSettings.setLoadsImagesAutomatically(true);
        mWebViewSettings.setAllowFileAccess(true);  //设置可以访问文件
        mWebViewSettings.setCacheMode(WebSettings.LOAD_DEFAULT);
        mWebViewSettings.setNeedInitialFocus(true); //当webview调用requestFocus时为webview设置节点
        mWebViewSettings.setJavaScriptCanOpenWindowsAutomatically(true);


        mWebViewSettings.setMediaPlaybackRequiresUserGesture(false);
        //触摸焦点起作用
        mWebView.requestFocus();
        mWebView.setFocusableInTouchMode(true);


        mWebView.setWebViewClient(new WebViewClient() {
            @Override
            public boolean shouldOverrideUrlLoading(WebView view, String url) {
                view.loadUrl(url);
                return true;
            }
        });

        mWebView.setWebChromeClient(new WebChromeClient() {
            @Override
            public void onProgressChanged(WebView view, int newProgress) {
                super.onProgressChanged(view, newProgress);
//                if (newProgress == 100) {
//                    LoadDialog.CancelDialog();
//                } else {
//                    LoadDialog.showDialog(BaseWebViewActivity.this);
//                }
            }

            @Override
            public void onGeolocationPermissionsShowPrompt(String origin,
                                                           GeolocationPermissions.Callback callback) {
                callback.invoke(origin, true, false);
                super.onGeolocationPermissionsShowPrompt(origin, callback);
            }

            // For Android 5.0以上
            @Override
            public boolean onShowFileChooser(WebView webView, ValueCallback<Uri[]> filePathCallback, FileChooserParams fileChooserParams) {
                mFilePathCallback = filePathCallback;
                goToPhotos();
                return true;
            }

            // For Android 3.0
            //只能单独传一个uri
            public void openFileChooser(ValueCallback uploadMsg) {
                mFilePathCallback = uploadMsg;
                goToPhotos();
            }

            // For Android 4.1
            public void openFileChooser(ValueCallback uploadMsg, String acceptType, String capture) {
                openFileChooser(uploadMsg);
            }

        });
    }

    public void goToPhotos() {
        showPop(REQUEST_CODE);
    }

    @Override
    public void onBackPressed() {
        if(mWebView.canGoBack()){
            mWebView.goBack();
        }else{
            super.onBackPressed();
        }
    }


    @Override
    public void onAudioFocusChange(int focusChange) {
        NToast.log("QingjianZhiZuoYulanActivity", "AudioFocusChange-> " + focusChange);
    }


    private void showPop(int type) {
        XXPermissions.with(this)
                .permission(Permission.MANAGE_EXTERNAL_STORAGE)
                .request(new OnPermissionCallback() {
                    @Override
                    public void onGranted(@NonNull List<String> permissions, boolean allGranted) {
                        if (!allGranted){
                            FullCommonPopWindow commonPopWindow = new FullCommonPopWindow(BaseWebViewActivity.this);
                            commonPopWindow.showAtLocation(mWebView, Gravity.CENTER, 0, 0);
                            commonPopWindow.getTitText().setText(getResources().getString(R.string.per_picture));
                            commonPopWindow.getCancel().setOnClickListener(view -> {
                                commonPopWindow.dismiss();
                                realShow(type);
                            });
                            commonPopWindow.getSure().setOnClickListener(view -> {
                                commonPopWindow.dismiss();
                            });

                        }else {
                            realShow(type);
                        }
                    }

                    @Override
                    public void onDenied(@NonNull List<String> permissions, boolean doNotAskAgain) {
                        if (doNotAskAgain) {
                            ToastUtils.showToast(BaseWebViewActivity.this,"被永久拒绝授权，请手动存储权限");
                            // 如果是被永久拒绝就跳转到应用权限系统设置页面
                            XXPermissions.startPermissionActivity(BaseWebViewActivity.this, permissions);
                        } else {
                            ToastUtils.showToast(BaseWebViewActivity.this,"获取存储权限失败");
                        }
                    }
                });


    }

    private void realShow(int type) {
        SelectPhotoTypePop selectPhotoTypePop = new SelectPhotoTypePop(this);
        selectPhotoTypePop.showAtLocation(mWebView, Gravity.BOTTOM, 0, 0);
        selectPhotoTypePop.getTake_photo().setVisibility(View.GONE);
        selectPhotoTypePop.getChose_pic().setOnClickListener(v -> {
            selectPhotoTypePop.dismiss();
            PictureSelector.create(this)
                    .openGallery(SelectMimeType.ofImage())
                    .setMaxSelectNum(1)
                    .setImageEngine(GlideEngine.createGlideEngine())
                    .setCompressEngine((CompressFileEngine) (context, source, call) -> {
                        com.linzi.xiguwen.utils.LogUtil.e(getClass().getSimpleName(),"onStartCompress source "+source.size());
                        Luban.with(getApplicationContext())
                                .load(source)
                                .ignoreBy(150).setCompressListener(new OnNewCompressListener() {
                                    @Override
                                    public void onStart() {

                                    }

                                    @Override
                                    public void onSuccess(String source, File compressFile) {
                                        if (call != null) {
                                            call.onCallback(source, compressFile.getAbsolutePath());
                                        }
                                    }

                                    @Override
                                    public void onError(String source, Throwable e) {
                                        if (call != null) {
                                            call.onCallback(source, null);
                                        }

                                    }
                                }).launch();
                    })
                    .forResult(new OnResultCallbackListener<LocalMedia>() {
                        @Override
                        public void onResult(ArrayList<LocalMedia> path) {
                            String availablePath = path.get(0).getAvailablePath();
                            if (availablePath.startsWith("content://")){
                                availablePath = path.get(0).getRealPath();
                            }
                            mFilePathCallback.onReceiveValue(Uri.fromFile(new File(availablePath)));
                            mFilePathCallback = null;
                        }
                        @Override
                        public void onCancel() {

                        }
                    });
        });
        selectPhotoTypePop.setOnDismissListener(() -> {
            WindowManager.LayoutParams params = getWindow().getAttributes();
            params.alpha = 1f;
            getWindow().setAttributes(params);
        });
    }
}
