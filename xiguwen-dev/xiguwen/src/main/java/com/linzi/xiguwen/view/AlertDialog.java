package com.linzi.xiguwen.view;

import android.app.Dialog;
import android.content.Context;
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

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by linzi on 2017/8/10.
 */

public class AlertDialog extends Dialog implements View.OnClickListener {
    Context mContext;
    ViewHolder vh;

    View.OnClickListener mCloseListener;
    View.OnClickListener mSubmitListener;

    public AlertDialog(@NonNull Context context) {
        super(context);
        mContext = context;
        initView();
    }

    private void initView() {
        View view = LayoutInflater.from(mContext).inflate(R.layout.dialog_alert, null);
        vh = new ViewHolder(view);
        setContentView(view);
        setCancelable(true);
        setCanceledOnTouchOutside(true);


        Window window = getWindow();
        window.setBackgroundDrawableResource(android.R.color.transparent);

        WindowManager.LayoutParams lp = window.getAttributes();
        lp.height = WindowManager.LayoutParams.WRAP_CONTENT;
        lp.width = getWindow().getWindowManager().getDefaultDisplay().getWidth() / 4 * 3;
        lp.gravity = Gravity.CENTER;
        window.setAttributes(lp);

        vh.llClose.setOnClickListener(this);
        vh.llSubmit.setOnClickListener(this);
    }

    @Override
    public void setTitle(@Nullable CharSequence title) {
        if(title == null){
            vh.tvTitle.setVisibility(View.GONE);
        }else{
            vh.tvTitle.setVisibility(View.VISIBLE);
            vh.tvTitle.setText(title);
        }
    }

    public AlertDialog setMessage(String msg) {
        if(msg == null){
            vh.tvContent.setVisibility(View.GONE);
        }else{
            vh.tvContent.setVisibility(View.VISIBLE);
            vh.tvContent.setText(msg);
        }
        return this;
    }

    public AlertDialog setCancleListener(View.OnClickListener listener) {
        mCloseListener = listener;
        return this;
    }

    public AlertDialog setConfirmListener(View.OnClickListener listener) {
        mSubmitListener = listener;
        return this;
    }

    @Override
    public void onClick(View view) {
        switch (view.getId()){
            case R.id.ll_close:
                if(mCloseListener != null){
                    mCloseListener.onClick(view);
                }
                dismiss();
                break;
            case R.id.ll_submit:
                if(mSubmitListener != null){
                    mSubmitListener.onClick(view);
                }
                dismiss();
                break;
        }
    }


    static class ViewHolder {
        @BindView(R.id.tv_title)
        TextView tvTitle;
        @BindView(R.id.tv_content)
        TextView tvContent;
        @BindView(R.id.ll_close)
        LinearLayout llClose;
        @BindView(R.id.ll_submit)
        LinearLayout llSubmit;

        ViewHolder(View view) {
            ButterKnife.bind(this, view);
        }
    }
}
