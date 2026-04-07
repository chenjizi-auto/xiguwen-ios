package com.linzi.xiguwen.view;

import android.app.Dialog;
import android.content.Context;
import android.os.Bundle;
import androidx.annotation.NonNull;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import com.jungly.gridpasswordview.GridPasswordView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.view.dialog.InputPassWordDialog;

/**
 * Created by PC on 2018-04-16.
 */

public class YuEPassWordDialog extends Dialog {
    private TextView tv_price;
    private GridPasswordView passwordView;
    private ImageView iv_close;
    private Context context;
    private String price;
    private String id;
    private InputPassWordDialog.RefreshNum refreshNum;

    public void setRefreshNum(InputPassWordDialog.RefreshNum refreshNum) {
        this.refreshNum = refreshNum;
    }

    public interface RefreshNum {
        void onRefresh();
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public void setId(String id) {
        this.id = id;
    }

    public YuEPassWordDialog(@NonNull Context context, int themeResId) {
        super(context, themeResId);
        this.context = context;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.pay_inputpassword_layout);
        //按空白处取消动画
        setCanceledOnTouchOutside(true);

        initView();
    }

    private void initView() {
        tv_price = findViewById(R.id.tv_price);
        passwordView = findViewById(R.id.pswView);
        iv_close = findViewById(R.id.iv_close);
        iv_close.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                dismiss();
            }
        });
        passwordView.setOnPasswordChangedListener(new GridPasswordView.OnPasswordChangedListener() {
            @Override
            public void onTextChanged(String psw) {
                if (psw.length() == 6) {//6位密码自动支付

                }
            }

            @Override
            public void onInputFinish(String psw) {

            }
        });
        tv_price.setText("￥" + price);
    }

    public void isShow() {
        if (this.isShowing()) {
            dismiss();
        } else {
            show();
        }
    }



}