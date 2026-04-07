package com.linzi.xiguwen.ui;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.webkit.WebChromeClient;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by pc on 2018/3/23.
 */

public class PhotoViewActivity extends BaseActivity {
    @BindView(R.id.web)
    WebView web;

    Context mContext;
    String url = "";
    WebSettings setting;
    private Intent intent;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_wenzhang_details);
        ButterKnife.bind(this);
        mContext = this;
        if (intent == null) {
            intent = getIntent();
            url = intent.getStringExtra("url");
            NToast.log(mContext, url + "");

        }
        if (url.equals("")) {
            NToast.show("跳转错误请重试！");
            finish();
        }
        initView();
    }

    private void initView() {
        setBack();
        setTitle("图片详情");
        setting = web.getSettings();
        setting.setJavaScriptEnabled(true);
    }

    @Override
    protected void initData() {

        setRightAdd(R.mipmap.icon_share, new View.OnClickListener() {
            @Override
            public void onClick(View view) {

            }
        });

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
        });
        web.loadUrl(url);
    }
}
