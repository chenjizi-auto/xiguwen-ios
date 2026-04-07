package com.linzi.xiguwen.view;

import android.app.Activity;
import android.app.Dialog;
import android.content.Context;
import android.graphics.Color;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.utils.DPUtils;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by linzi on 2017/8/10.
 */

public class AskDialog extends Dialog {
    Context mContext;
    ViewHolder vh;
    Activity mActivity;
    public static final int DEF_CLICK_BUTTON_INDEX = 0;
    private int mClickButtonIndex = DEF_CLICK_BUTTON_INDEX;

    public AskDialog(@NonNull Context context, Activity activity) {
        super(context);
        mContext = context;
        mActivity = activity;
        initView();
    }

    private void initView() {
        View view = LayoutInflater.from(mContext).inflate(R.layout.dialog_notice_layout, null);
        vh = new ViewHolder(view);
        setContentView(view);
        setCancelable(true);
        setCanceledOnTouchOutside(true);

        Window window = getWindow();
        window.setBackgroundDrawableResource(android.R.color.transparent);


        WindowManager.LayoutParams lp = window.getAttributes();
        lp.width = DPUtils.dip2px(mContext,247);
        lp.gravity = Gravity.CENTER;
        window.setAttributes(lp);

        try {
            //用来去除Holo主题的蓝色线条
            Context context = getContext();
            int dividerID = context.getResources().getIdentifier("android:id/titleDivider", null, null);
            View divider = findViewById(dividerID);
            if (divider != null){
                divider.setBackgroundColor(Color.TRANSPARENT);
            }
        } catch (Exception e) {
            com.linzi.xiguwen.utils.LogUtil.printStackTrace(e);
        }
    }

    @Override
    public void setTitle(@Nullable CharSequence title) {
//        super.setTitle(title);
        vh.tvTitle.setText(title);
    }

    public void setMessage(String msg) {
        vh.tvMsg.setText(msg);
    }

    public void setCancleListener(String title, View.OnClickListener listener) {
        vh.tvClose.setText(title);
        vh.tvClose.setOnClickListener(listener);
    }

    public void setSubmitListener(String title, View.OnClickListener listener) {
        vh.tvSubmit.setText(title);
        vh.tvSubmit.setOnClickListener(listener);
    }

    public void setSignButton(String title, View.OnClickListener listener){
        vh.ll2Button.setVisibility(View.GONE);
        vh.llSigleButton.setVisibility(View.VISIBLE);
        vh.tvButtonTxt.setText(title);
        vh.llSigleButton.setOnClickListener(listener);
    }

    /**
     * 获取被点击按钮的索引
     *
     * @return 被点击按钮的索引
     */
    public int getClickButtonIndex() {
        return mClickButtonIndex;
    }

    @Override
    public void show() {
        mClickButtonIndex = DEF_CLICK_BUTTON_INDEX;
        super.show();
    }
    class ViewHolder {
        @BindView(R.id.tv_title)
        TextView tvTitle;
        @BindView(R.id.tv_msg)
        TextView tvMsg;
        @BindView(R.id.tv_close)
        TextView tvClose;
        @BindView(R.id.tv_submit)
        TextView tvSubmit;
        @BindView(R.id.ll_2_button)
        LinearLayout ll2Button;
        @BindView(R.id.tv_button_txt)
        TextView tvButtonTxt;
        @BindView(R.id.ll_sigle_button)
        LinearLayout llSigleButton;

        ViewHolder(View view) {
            ButterKnife.bind(this, view);
        }
    }
}
