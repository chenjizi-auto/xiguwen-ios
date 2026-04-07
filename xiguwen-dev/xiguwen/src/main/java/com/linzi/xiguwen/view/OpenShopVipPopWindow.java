package com.linzi.xiguwen.view;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.graphics.drawable.ColorDrawable;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.WindowManager;
import android.widget.ImageView;
import android.widget.PopupWindow;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.ui.ToPayActivity;


/**
 * Created by pc on 2018/4/26.
 */

public class OpenShopVipPopWindow extends PopupWindow {
    RadioButton rb1;
    RadioButton rb2;
    RadioButton rb3;
    RadioGroup radiogroup;
    TextView price;
    TextView tv_submit;
    ImageView iv_close;

    private View view;
    private Context context;
    private String longtime = 12 + "";
    private String price1, price2, price3;

    public OpenShopVipPopWindow(final Context context, String price1, String price2, String price3) {
        super(context);
        this.context = context;
        this.price1 = price1;
        this.price2 = price2;
        this.price3 = price3;

        view = LayoutInflater.from(context).inflate(R.layout.open_shop_vip_pop, null);
        rb1 = (RadioButton) view.findViewById(R.id.rb_1);
        rb1.setTag(price1);
        rb2 = (RadioButton) view.findViewById(R.id.rb_2);
        rb2.setTag(price2);
        rb3 = (RadioButton) view.findViewById(R.id.rb_3);
        rb3.setTag(price3);
        price = (TextView) view.findViewById(R.id.price);
        price.setText(price1);
        tv_submit = (TextView) view.findViewById(R.id.tv_submit);
        radiogroup = (RadioGroup) view.findViewById(R.id.radiogroup);
        iv_close = (ImageView) view.findViewById(R.id.iv_close);
        tv_submit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(context, ToPayActivity.class);
                intent.putExtra("price", price.getText().toString());
                intent.putExtra("intentType", 5);
                intent.putExtra("longtime", longtime);
                context.startActivity(intent);
                dismiss();
            }
        });
        iv_close.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                dismiss();
            }
        });
        initPop();
        initView();
    }

    private void initPop() {
        // 设置弹出窗体可点击
        setFocusable(true);
        // 实例化一个ColorDrawable颜色为半透明
        ColorDrawable dw = new ColorDrawable(0xffff0000);
        // 设置弹出窗体的背景
        setBackgroundDrawable(dw);
        // 设置弹出窗体显示时的动画，从底部向上弹出
        setAnimationStyle(R.style.AnimationPreview);
        setContentView(view);
        update();
        setOnDismissListener(new OnDismissListener() {
            @Override
            public void onDismiss() {
                lightoff(false);
            }
        });
    }


    private void initView() {
        radiogroup.setOnCheckedChangeListener(new RadioGroup.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(RadioGroup radioGroup, int i) {
                price.setText(((RadioButton) view.findViewById(radioGroup.getCheckedRadioButtonId())).getTag().toString());
                if (((RadioButton) view.findViewById(radioGroup.getCheckedRadioButtonId())).getTag().toString().equals(price1)) {
                    longtime = 12 + "";
                } else if (((RadioButton) view.findViewById(radioGroup.getCheckedRadioButtonId())).getTag().toString().equals(price2)) {
                    longtime = 24 + "";
                } else {
                    longtime = 36 + "";
                }
            }
        });

    }


    //显示消失动画
    public void lightoff(boolean isoff) {
        WindowManager.LayoutParams lp = ((Activity) context).getWindow().getAttributes();
        if (isoff) {
            lp.alpha = 0.3f;
        } else {
            lp.alpha = 1f;
        }
        ((Activity) context).getWindow().setAttributes(lp);
    }

    public void setShowWithView(View view) {
        showAtLocation(view, Gravity.CENTER, 0, 0);
        lightoff(true);
    }

}
