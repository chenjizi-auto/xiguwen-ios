package com.linzi.xiguwen.view;

import android.app.Activity;
import android.app.Dialog;
import android.content.Context;
import android.content.DialogInterface;
import android.graphics.Color;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import android.view.Gravity;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.widget.TextView;

import com.linzi.xiguwen.R;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by pc on 2018/5/7.
 */

public class UpdateDialog extends Dialog {

    private Context context;
    private ViewHolder vh;
    private Activity mActivity;

    public static final int DEF_CLICK_BUTTON_INDEX = 0;
    private int mClickButtonIndex = DEF_CLICK_BUTTON_INDEX;

    public UpdateDialog(@NonNull Context context, Activity activity) {
        super(context);
        this.context = context;
        mActivity = activity;
        initView();
    }

    private void initView() {
        View view = LayoutInflater.from(context).inflate(R.layout.update_dialog, null);
        vh = new ViewHolder(view);
        setContentView(view);
        setCancelable(true);
        setCanceledOnTouchOutside(false);

        Window window = getWindow();
        window.setBackgroundDrawableResource(android.R.color.transparent);

        WindowManager.LayoutParams lp = window.getAttributes();
        lp.height = WindowManager.LayoutParams.WRAP_CONTENT;
        lp.width = WindowManager.LayoutParams.WRAP_CONTENT;
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

    @Override
    public void setTitle(@Nullable CharSequence title) {
//        super.setTitle(title);
        vh.title.setText(title);
    }

    public void setMessage(String msg) {
        vh.tvContent.setText(msg);
    }

    public void setCancleListener(String title, View.OnClickListener listener) {
        vh.tvCancel.setText(title);
        vh.tvCancel.setOnClickListener(listener);
    }

    public void setSubmitListener(String title, View.OnClickListener listener) {
        vh.tvSure.setText(title);
        vh.tvSure.setOnClickListener(listener);
    }

    public void setSignButton(String title, View.OnClickListener listener) {
        setCanceledOnTouchOutside(false);
        vh.tvCancel.setVisibility(View.GONE);
        vh.tvSure.setVisibility(View.VISIBLE);
        vh.line.setVisibility(View.GONE);
        vh.tvSure.setText(title);
        vh.tvSure.setOnClickListener(listener);
        setOnKeyListener(new OnKeyListener() {
            @Override
            public boolean onKey(DialogInterface dialogInterface, int i, KeyEvent keyEvent) {
                if (i == KeyEvent.KEYCODE_BACK && keyEvent.getRepeatCount() == 0) {
                    mActivity.finish();
                }
                return false;
            }
        });
    }

    @Override
    public void show() {
        mClickButtonIndex = DEF_CLICK_BUTTON_INDEX;
        super.show();
    }

    class ViewHolder {
        @BindView(R.id.tv_cancel)
        TextView tvCancel;
        @BindView(R.id.tv_sure)
        TextView tvSure;
        @BindView(R.id.title)
        TextView title;
        @BindView(R.id.tv_content)
        TextView tvContent;
        @BindView(R.id.line)
        View line;

        ViewHolder(View view) {
            ButterKnife.bind(this, view);
        }
    }
}
