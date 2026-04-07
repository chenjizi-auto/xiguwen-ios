package com.linzi.xiguwen.widget;

import android.app.Dialog;
import android.content.Context;
import android.graphics.Color;
import androidx.annotation.Nullable;
import android.text.SpannableString;
import android.text.method.LinkMovementMethod;
import android.view.LayoutInflater;
import android.view.View;
import android.view.Window;
import android.widget.TextView;

import com.linzi.xiguwen.R;

import butterknife.BindView;
import butterknife.ButterKnife;

public class AskDialog extends Dialog {
    Context mContext;
    ViewHolder vh;


    public AskDialog(Context context) {
        super(context);
        mContext = context;
        initView();
    }

    private void initView() {
        View view = LayoutInflater.from(mContext).inflate(R.layout.dialog_ask, null);
        vh = new ViewHolder(view);
        vh.tvCanale.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dismiss();
            }
        });
        setContentView(view);
        setCancelable(true);
        setCanceledOnTouchOutside(true);

        Window window = getWindow();
        window.setBackgroundDrawableResource(android.R.color.transparent);

//        WindowManager.LayoutParams lp = window.getAttributes();
//        lp.width = ScreenUtil.dip2px( 247);
//
//        lp.gravity = Gravity.CENTER;
//        window.setAttributes(lp);

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
        vh.tvTitle.setText(title);
    }

    public void setMessage(String msg) {
        vh.tvTitle.setText(msg);
        vh.tvTitle.setVisibility(msg!=null&&!msg.equals("")?View.VISIBLE:View.GONE);
    }

    public void setSubmitListener(String title, String tvContent, View.OnClickListener listener) {

        vh.tvSure.setText(title);
        vh.tvContent.setText(tvContent);
        vh.tvSure.setOnClickListener(listener);
    }

    public void setSubmitListener(String ctitle,String title, View.OnClickListener listener,View.OnClickListener clistener) {
        vh.tvCanale.setText(ctitle);
        vh.tvSure.setText(title);
        vh.tvSure.setOnClickListener(listener);
        vh.tvCanale.setOnClickListener(clistener);
    }

    public void setSubmitListener(String ctitle,String title,String content, View.OnClickListener listener,View.OnClickListener clistener) {
        vh.tvCanale.setText(ctitle);
        vh.tvSure.setText(title);
        vh.tvContent.setText(content);
        vh.tvSure.setOnClickListener(listener);
        vh.tvCanale.setOnClickListener(clistener);
        setCancelable(false);
        setCanceledOnTouchOutside(false);
    }



    public void setContent( SpannableString builder){
        vh.tvContent.setHighlightColor(mContext.getResources().getColor(android.R.color.transparent));
        vh.tvContent.setText(builder);
        vh.tvContent.setMovementMethod(LinkMovementMethod.getInstance());
        setCancelable(false);
        setCanceledOnTouchOutside(false);
    }

    @Override
    public void show() {
        super.show();
    }

    class ViewHolder {
        @BindView(R.id.tv_title)
        TextView tvTitle;
        @BindView(R.id.tv_canale)
        TextView tvCanale;
        @BindView(R.id.tv_sure)
        TextView tvSure;
        @BindView(R.id.tv_content)
        TextView tvContent;

        ViewHolder(View view) {
            ButterKnife.bind(this, view);
        }
    }
}
