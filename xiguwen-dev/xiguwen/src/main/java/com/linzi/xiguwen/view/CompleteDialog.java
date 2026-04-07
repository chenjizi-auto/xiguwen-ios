package com.linzi.xiguwen.view;

import android.app.Activity;
import android.app.Dialog;
import android.content.Context;
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
import com.linzi.xiguwen.utils.CallBack;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by linzi on 2017/8/10.
 */

public class CompleteDialog extends Dialog {
    Context mContext;
    ViewHolder vh;
    Activity mActivity;
    public static final int DEF_CLICK_BUTTON_INDEX = 0;
    private int mClickButtonIndex = DEF_CLICK_BUTTON_INDEX;
    private int choose_id=0;

    public CompleteDialog(@NonNull Context context, Activity activity) {
        super(context);
        mContext = context;
        mActivity = activity;
        initView();
    }

    private void initView() {
        View view = LayoutInflater.from(mContext).inflate(R.layout.dialog_order_comlete_layout, null);
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
    }

//    @Override
//    public void setTitle(@Nullable CharSequence title) {
////        super.setTitle(title);
//        vh.tvTitle.setText(title);
//    }

    public CompleteDialog setMessage(String msg) {
        vh.tvMsg.setText(msg);
        return this;
    }

    public CompleteDialog setCancleListener(View.OnClickListener listener) {
        vh.llClose.setOnClickListener(listener);
        this.dismiss();
        return this;
    }

    public CompleteDialog setSubmitListener( View.OnClickListener listener) {
        vh.llSubmit.setOnClickListener(listener);
        this.dismiss();
        return this;
    }

    public CompleteDialog setChooseButton(final CallBack.ComleteTypeListener mListener) {
        vh.rbOnline.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                choose_id=0;
                mListener.completeType(choose_id);
            }
        });
        vh.rbDownline.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                choose_id=1;
                mListener.completeType(choose_id);
            }
        });
        return this;
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
        @BindView(R.id.tv_msg)
        TextView tvMsg;
        @BindView(R.id.rb_online)
        RadioButton rbOnline;
        @BindView(R.id.rb_downline)
        RadioButton rbDownline;
        @BindView(R.id.ll_close)
        LinearLayout llClose;
        @BindView(R.id.ll_submit)
        LinearLayout llSubmit;

        ViewHolder(View view) {
            ButterKnife.bind(this, view);
        }
    }
}
