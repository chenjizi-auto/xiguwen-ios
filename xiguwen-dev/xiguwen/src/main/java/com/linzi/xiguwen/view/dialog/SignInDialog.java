package com.linzi.xiguwen.view.dialog;

import android.app.Dialog;
import android.content.Context;
import android.graphics.Color;
import androidx.annotation.NonNull;
import android.view.LayoutInflater;
import android.view.View;
import android.view.Window;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.SignInBean;
import com.linzi.xiguwen.utils.NToast;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by pc on 2018/5/22.
 */

public class SignInDialog extends Dialog {

    private Context context;
    private View view;
    private ViewHolder viewHolder;

    private SignInBean signInBean;

   // private GoodView goodView;

    public SignInDialog(@NonNull Context context, SignInBean signInBean) {
        super(context);
        this.context = context;
        this.signInBean = signInBean;
        initView();
    }

    private void initView() {
       // goodView = new GoodView(context);

        view = LayoutInflater.from(context).inflate(R.layout.sign_in_dialog_layout, null);
        viewHolder = new ViewHolder(view);

        Window window = getWindow();
        window.setBackgroundDrawableResource(android.R.color.transparent);

        setContentView(view);
        setCancelable(false);
        setCanceledOnTouchOutside(false);

        try {
            //用来去除Holo主题的蓝色线条
            Context context = getContext();
            int dividerID = context.getResources().getIdentifier("android:id/titleDivider", null, null);
            View divider = findViewById(dividerID);
            divider.setBackgroundColor(Color.TRANSPARENT);
        } catch (Exception e) {
            com.linzi.xiguwen.utils.LogUtil.printStackTrace(e);
        }
        if (signInBean.getJifen().size() == 7) {
            viewHolder.tvJifen1.setText(signInBean.getJifen().get(0) + "积分");
            viewHolder.tvJifen2.setText(signInBean.getJifen().get(1) + "积分");
            viewHolder.tvJifen3.setText(signInBean.getJifen().get(2) + "积分");
            viewHolder.tvJifen4.setText(signInBean.getJifen().get(3) + "积分");
            viewHolder.tvJifen5.setText(signInBean.getJifen().get(4) + "积分");
            viewHolder.tvJifen6.setText(signInBean.getJifen().get(5) + "积分");
            viewHolder.tvJifen7.setText(signInBean.getJifen().get(6) + "积分");
        } else {
            NToast.show("签到积分奖励有误！");
            dismiss();
        }

        int signNum = signInBean.getLianxutianshu();
        viewHolder.tvSignInDay.setText("连续签到" + signNum + "天");

        switch (signNum) {
            case 1:
                viewHolder.signIcon.setBackgroundResource(R.mipmap.sign_day1);
                break;
            case 2:
                viewHolder.signIcon.setBackgroundResource(R.mipmap.sign_day2);
                break;
            case 3:
                viewHolder.signIcon.setBackgroundResource(R.mipmap.sign_day3);
                break;
            case 4:
                viewHolder.signIcon.setBackgroundResource(R.mipmap.sign_day4);
                break;
            case 5:
                viewHolder.signIcon.setBackgroundResource(R.mipmap.sign_day5);
                break;
            case 6:
                viewHolder.signIcon.setBackgroundResource(R.mipmap.sign_day6);
                break;
            case 7:
                viewHolder.signIcon.setBackgroundResource(R.mipmap.sign_day7);
                break;
        }

        viewHolder.bt_submit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
//                if (goodView != null) {
//                    goodView.setTextInfo("+" + signInBean.getHuodejifen() + "积分", Color.RED, 50);
//                    goodView.show(viewHolder.signIcon);
//                }
                dismiss();
            }
        });
    }

    class ViewHolder {
        @BindView(R.id.bt_submit)
        Button bt_submit;
        @BindView(R.id.tv_sign_in_day)
        TextView tvSignInDay;
        @BindView(R.id.tv_jifen1)
        TextView tvJifen1;
        @BindView(R.id.tv_jifen2)
        TextView tvJifen2;
        @BindView(R.id.tv_jifen3)
        TextView tvJifen3;
        @BindView(R.id.tv_jifen4)
        TextView tvJifen4;
        @BindView(R.id.sign_icon)
        ImageView signIcon;
        @BindView(R.id.tv_jifen7)
        TextView tvJifen7;
        @BindView(R.id.tv_jifen6)
        TextView tvJifen6;
        @BindView(R.id.tv_jifen5)
        TextView tvJifen5;

        public ViewHolder(View view) {
            ButterKnife.bind(this, view);
        }
    }
}
