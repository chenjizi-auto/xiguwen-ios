package com.linzi.xiguwen.ui;

import android.Manifest;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Picture;
import android.os.Build;
import android.os.Bundle;
import android.os.Environment;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import android.view.KeyEvent;
import android.view.View;
import android.view.WindowManager;
import android.webkit.ValueCallback;
import android.webkit.WebChromeClient;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.ShareContentBean;
import com.linzi.xiguwen.utils.GetShareContentUtil;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.LoginUtil;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.SPUtil;
import com.linzi.xiguwen.utils.ShareUtils;

import java.io.File;
import java.io.FileOutputStream;
import java.util.Arrays;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

public class WenzhangDetailsActivity extends BaseActivity {
    @BindView(R.id.web)
    WebView web;
    Context mContext;
    String url = "";
    WebSettings setting;
    private boolean isShowShare;
    private View.OnClickListener listener;
    private String[] menuTitles = new String[]{"链接分享", "图片分享"};
    private int dangQiValue = -1;

    public void setListener(View.OnClickListener listener) {
        this.listener = listener;
    }

    public static void startAction(Context context, String url, String title, boolean isShowShare) {
        Intent intent = new Intent(context, WenzhangDetailsActivity.class);
        NToast.log("URL_____",url);
        intent.putExtra("url", url);
        intent.putExtra("title", title);
        intent.putExtra("isShowShare", isShowShare);
        intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TOP);
        context.startActivity(intent);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        checkSdkVersion();
        setContentView(R.layout.activity_wenzhang_details);
        getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
        getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE | WindowManager.LayoutParams.SOFT_INPUT_STATE_HIDDEN);

        getLlBar().setVisibility(View.GONE);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        getLlBack().setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (web.canGoBack()) {
                    web.goBack();
                } else {
                    finish();
                }
            }
        });
        setTitle(getIntent().getStringExtra("title"));
        if (getIntent().getIntExtra("isDangQiShare", -1) == 1) {
            dangQiValue = getIntent().getIntExtra("DangQiValue", -1);
            if (dangQiValue != -1) {
                requestPermission();

                listener = new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        if (!LoginUtil.isLogin()) {
                            LoginActivity.startAction(mContext);
                            return;
                        }
                        if (dangQiValue == 1) {
//                            ShareContentBean bean = getIntent().getParcelableArrayListExtra()
//                            ShareUtils.showShare(this, getIntent().getStringExtra("url"), shareContentBean.getTitle(), shareContentBean.getImage(), shareContentBean.getDescr());
                            GetShareContentUtil.getContent(WenzhangDetailsActivity.this, (int) SPUtil.get("userid", SPUtil.Type.INT), 5, -1);
                        } else {
                            getSnapshot();
                        }

//                    View view1 = LayoutInflater.from(mContext).inflate(R.layout.activity_wenzhang_details,null);
//                    ShareUtils.showShare(WenzhangDetailsActivity.this, GenerateLayoutImagesUtil.viewSaveToImage(view1,"dangqicard"));
                    }
                };
            } else {
                finish();
                NToast.show("参数错误，请重试！");
            }
        }
        if (getIntent().getIntExtra("isWeddingNewsShare", -1) == 1) {
            listener = new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    ShareContentBean shareContentBean = getIntent().getParcelableExtra("shareBean");
                    ShareUtils.showShare(WenzhangDetailsActivity.this, shareContentBean.getUrl(), shareContentBean.getTitle(), shareContentBean.getImage(), shareContentBean.getDescr());
                }
            };
        }

        if (getIntent().getIntExtra("isHouDongShare", -1) == 1) {
            listener = new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
                        web.evaluateJavascript("GetQueryString()", new ValueCallback<String>() {
                            @Override
                            public void onReceiveValue(String s) {
                                if (!s.equals("null")) {
                                    s = s.replace("\"", "");
                                    List idList = Arrays.asList(s.split(","));
                                    if (idList.get(1).equals("0")) {
                                        //用户
                                        GetShareContentUtil.getActivityContent(WenzhangDetailsActivity.this, (String) idList.get(0), 17);
                                    } else {
                                        //活动
                                        GetShareContentUtil.getActivityContent(WenzhangDetailsActivity.this, (String) idList.get(0), 16);
                                    }

                                } else {
                                    NToast.show("该页面不能分享 ");
                                }
                            }
                        });
                    }
                }
            };
        }

        if (getIntent().getBooleanExtra("isShowShare", false) == true) {
            setRightAdd(R.mipmap.icon_share, listener);
        }
        url = getIntent().getStringExtra("url");
        mContext = this;
        setting = web.getSettings();
        setting.setJavaScriptEnabled(true);
        setting.setUseWideViewPort(true);
        setting.setLoadWithOverviewMode(true);

        web.setWebViewClient(new WebViewClient());
        web.setWebChromeClient(new WebChromeClient() {
            @Override
            public void onProgressChanged(WebView view, int newProgress) {
                if (newProgress == 100) {
                    LoadDialog.CancelDialog();
                } else {
                    LoadDialog.showDialog(mContext);
                }
            }
        });
        web.loadUrl(url);
    }

    private void getSnapshot() {
        Picture picture = web.capturePicture();
        int width = picture.getWidth();
        int height = picture.getHeight();
        if (width > 0 && height > 0) {
            Bitmap bitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888);
            Canvas canvas = new Canvas(bitmap);
            picture.draw(canvas);
            try {
                String fileName = Environment.getExternalStorageDirectory().getPath() + "/dangqi.jpg";
                FileOutputStream fos = new FileOutputStream(fileName);
                //压缩bitmap到输出流中
                bitmap.compress(Bitmap.CompressFormat.JPEG, 70, fos);
                fos.close();
                bitmap.recycle();
                ShareUtils.showShare(WenzhangDetailsActivity.this, new File(Environment.getExternalStorageDirectory().getPath() + "/dangqi.jpg"));
            } catch (Exception e) {
                NToast.show(e.getMessage());
            }
        }
    }

    /**
     * 当系统版本大于5.0时 开启enableSlowWholeDocumentDraw 获取整个html文档内容
     */
    private void checkSdkVersion() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            WebView.enableSlowWholeDocumentDraw();
        }
    }

    private static final int MANAGE_EXTERNAL_STORAGE_REQUEST_CODE = 200;

    /**
     * 当build target为23时，需要动态申请权限
     */
    private void requestPermission() {
        if (Build.VERSION.SDK_INT > Build.VERSION_CODES.LOLLIPOP_MR1) {

            if (ContextCompat.checkSelfPermission(this, Manifest.permission.MANAGE_EXTERNAL_STORAGE)
                    != PackageManager.PERMISSION_GRANTED) {
                //申请MANAGE_EXTERNAL_STORAGE权限
                ActivityCompat.requestPermissions(this, new String[]{Manifest.permission.MANAGE_EXTERNAL_STORAGE},
                        MANAGE_EXTERNAL_STORAGE_REQUEST_CODE);
            }

        }
    }


    @Override
    public void onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
        switch (requestCode) {
            case 200:
                boolean writeAccepted = grantResults[0] == PackageManager.PERMISSION_GRANTED;
                NToast.log("apptag", "writeAcceped--" + writeAccepted);
                break;

        }
    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if (keyCode == KeyEvent.KEYCODE_BACK && web.canGoBack()) {
            web.goBack();// 返回前一个页面
            return true;
        }
        return super.onKeyDown(keyCode, event);
    }
}
