package com.linzi.xiguwen.view.dateview;

import android.app.Activity;
import android.content.Context;
import android.graphics.drawable.ColorDrawable;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.WindowManager;
import android.widget.PopupWindow;

import com.linzi.xiguwen.R;

/**
 * Created by pc on 2018/5/29.
 */

public class NewChooseDatePop extends PopupWindow {
    private View view;
    private Context context;

    public NewChooseDatePop(Context context) {
        super(context);
        this.context = context;
        view = LayoutInflater.from(context).inflate(R.layout.new_choose_pop_time_layout, null);
        initView();

    }

    private void initView() {
        // 设置弹出窗体可点击
        setFocusable(true);
        int w = ((Activity) context).getWindowManager().getDefaultDisplay().getWidth();
        int h = (((Activity) context).getWindowManager().getDefaultDisplay().getHeight() / 3);
        setWidth(w);
        setHeight(h);
        // 实例化一个ColorDrawable颜色为半透明
        ColorDrawable dw = new ColorDrawable(0xffff0000);
        // 设置弹出窗体的背景
        setBackgroundDrawable(dw);
        // 设置弹出窗体显示时的动画，从底部向上弹出
        setAnimationStyle(R.style.AnimationPreview);
        setContentView(view);
        update();
        setOnDismissListener(new PopupWindow.OnDismissListener() {
            @Override
            public void onDismiss() {
                lightoff(false);
            }
        });
    }

    public void setShowWithView(View view) {
        showAtLocation(view, Gravity.BOTTOM | Gravity.CENTER_HORIZONTAL, 0, 0);
        lightoff(true);
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
}
