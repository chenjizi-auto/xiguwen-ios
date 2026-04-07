package com.linzi.xiguwen.view.dialog;

import android.app.Activity;
import android.app.Dialog;
import android.content.Context;
import android.graphics.Color;
import androidx.annotation.NonNull;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.widget.LinearLayout;
import android.widget.RadioButton;
import android.widget.TextView;

import com.linzi.xiguwen.R;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by pc on 2018/4/23.
 */

public class ChoosePayDialog extends Dialog {

    private Context mContext;
    private ViewHolder vh;
    private Activity mActivity;
    private int type;//1线上 2线下

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public ChoosePayDialog(@NonNull Context context, Activity activity) {
        super(context);
        mContext = context;
        mActivity = activity;
        initView();
    }

    private void initView() {
        View view = LayoutInflater.from(mContext).inflate(R.layout.choose_pay_dialog, null);
        vh = new ViewHolder(view);
        setContentView(view);
        setCancelable(true);
        setCanceledOnTouchOutside(true);

        Window window = getWindow();
        window.setBackgroundDrawableResource(android.R.color.transparent);

        WindowManager.LayoutParams lp = window.getAttributes();
        lp.height = WindowManager.LayoutParams.WRAP_CONTENT;
        lp.width = mActivity.getWindowManager().getDefaultDisplay().getWidth() / 4 * 3;
        lp.gravity = Gravity.CENTER;
        window.setAttributes(lp);

        try {
            //用来去除Holo主题的蓝色线条
            Context context = getContext();
            int dividerID = context.getResources().getIdentifier("android:id/titleDivider", null, null);
            View divider = findViewById(dividerID);
            divider.setBackgroundColor(Color.TRANSPARENT);
        } catch (Exception e) {
            com.linzi.xiguwen.utils.LogUtil.printStackTrace(e);
        }
    }

    public void setCancleListener(View.OnClickListener listener) {
        vh.tvClose.setOnClickListener(listener);
    }

    public void setSubmitListener(View.OnClickListener listener) {
        vh.tvSubmit.setOnClickListener(listener);
    }

    public int getClickButtonIndex() {
        if (vh.rb1.isChecked()) {
            return 0;
        } else {
            return 1;
        }
    }

    class ViewHolder {
        @BindView(R.id.tv_title)
        TextView tvTitle;
        @BindView(R.id.rb_1)
        RadioButton rb1;
        @BindView(R.id.rb_2)
        RadioButton rb2;
        @BindView(R.id.tv_close)
        TextView tvClose;
        @BindView(R.id.tv_submit)
        TextView tvSubmit;
        @BindView(R.id.ll_2_button)
        LinearLayout ll2Button;

        ViewHolder(View view) {
            ButterKnife.bind(this, view);
        }
    }
}
