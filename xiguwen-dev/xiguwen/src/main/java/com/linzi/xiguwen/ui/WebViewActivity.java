package com.linzi.xiguwen.ui;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.webkit.GeolocationPermissions;
import android.webkit.ValueCallback;
import android.webkit.WebChromeClient;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.ImageView;
import android.widget.LinearLayout;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

import com.hjq.permissions.OnPermissionCallback;
import com.hjq.permissions.Permission;
import com.hjq.permissions.XXPermissions;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.utils.GlideEngine;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.SelectPhotoTypePop;
import com.linzi.xiguwen.utils.StatusBarUtil;
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

public class WebViewActivity extends AppCompatActivity {

    @BindView(R.id.ll_bar)
    LinearLayout llBar;
    @BindView(R.id.web)
    WebView web;
    @BindView(R.id.iv_back)
    ImageView ivBack;

    Context mContext;
    String url;
    WebSettings settings;

    int load_flag = 0;

    ValueCallback mFilePathCallback;

    int callback_flag = 0;

    private ArrayList<String> path = new ArrayList<>();
    public static final int REQUEST_CODE = 1000;


    public static void startActivity(Context context, String url){
        Intent intent = new Intent(context, WebViewActivity.class);
        intent.putExtra("url", url);
        context.startActivity(intent);
    }


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //改变为白色背景黑色字体的状态栏
        getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
        StatusBarUtil.setStatusBarColor(WebViewActivity.this, R.color.trans);
        setContentView(R.layout.activity_webview);
        ButterKnife.bind(this);
        mContext=this;
        initView();

        url = getIntent().getStringExtra("url");
        web.loadUrl(url);
    }
    private void initView(){
        //获得状态栏高度
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, StatusBarUtil.getStatusBarHeight(WebViewActivity.this));
        llBar.setLayoutParams(params);

        ivBack.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                finish();
            }
        });

        //设置web
        settings = web.getSettings();
        settings.setJavaScriptEnabled(true);
//        settings.setDatabaseEnabled(true);
        settings.setGeolocationEnabled(true);
//        settings.setGeolocationDatabasePath(dir);
//        settings.setPluginsEnabled(true);
        settings.setDomStorageEnabled(true);
        settings.setUseWideViewPort(true);
        settings.setLoadWithOverviewMode(true);
        settings.setLoadsImagesAutomatically(true);
        settings.setAllowFileAccess(true);  //设置可以访问文件
        settings.setCacheMode(WebSettings.LOAD_CACHE_ELSE_NETWORK);
        settings.setNeedInitialFocus(true); //当webview调用requestFocus时为webview设置节点
        settings.setJavaScriptCanOpenWindowsAutomatically(true);
        //触摸焦点起作用
        web.requestFocus();
        web.setFocusableInTouchMode(true);



        web.setWebViewClient(new WebViewClient() {
            @Override
            public boolean shouldOverrideUrlLoading(WebView view, String url) {
                view.loadUrl(url);
                return true;
            }
        });

        web.setWebChromeClient(new WebChromeClient() {
            @Override
            public void onProgressChanged(WebView view, int newProgress) {
//                super.onProgressChanged(view, newProgress);
                if (newProgress == 100) {
                    LoadDialog.CancelDialog();
                } else {
                    LoadDialog.showDialog(mContext);
                }
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
        path.clear();
//        ImageSelect.ActivityImageSelectMore(WebViewActivity.this, mContext, 1, path, REQUEST_CODE);
        showPop(REQUEST_CODE);
        
        load_flag = 1;
        callback_flag = 1;
    }



    private void showPop(int type) {
        XXPermissions.with(this)
                .permission(Permission.MANAGE_EXTERNAL_STORAGE)
                .request(new OnPermissionCallback() {
                    @Override
                    public void onGranted(@NonNull List<String> permissions, boolean allGranted) {
                        if (!allGranted){
                            FullCommonPopWindow commonPopWindow = new FullCommonPopWindow(WebViewActivity.this);
                            commonPopWindow.showAtLocation(ivBack, Gravity.CENTER, 0, 0);
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
                            ToastUtils.showToast(WebViewActivity.this,"被永久拒绝授权，请手动存储权限");
                            // 如果是被永久拒绝就跳转到应用权限系统设置页面
                            XXPermissions.startPermissionActivity(WebViewActivity.this, permissions);
                        } else {
                            ToastUtils.showToast(WebViewActivity.this,"获取存储权限失败");
                        }
                    }
                });


    }

    private void realShow(int type) {
        SelectPhotoTypePop selectPhotoTypePop = new SelectPhotoTypePop(this);
        selectPhotoTypePop.showAtLocation(ivBack, Gravity.BOTTOM, 0, 0);
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




    @Override
    public void onPause() {
        super.onPause();
        web.onPause();
        web.pauseTimers();
    }

    @Override
    public void onResume() {
        super.onResume();
        web.resumeTimers();
        web.onResume();
    }


    @Override
    protected void onDestroy() {
        web.destroy();
        web = null;
        super.onDestroy();
    }
}
