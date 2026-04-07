package com.linzi.xiguwen.fragment.vm.club;

import android.app.Activity;
import android.graphics.drawable.ColorDrawable;
import android.text.TextUtils;
import android.view.Gravity;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.widget.EditText;
import android.widget.PopupWindow;

import com.linzi.xiguwen.R;

/**
 * Title:
 * Description:
 * Copyright:Copyright(c)2018
 * Company: Cree
 * CreateTime:2018/3/23  15:45
 *
 * @author luyongjiang
 * @version 1.0
 */
public class ScreenPopVM {

    private String maxPrice, minPrice;

    private ScreenPopVM(View view) {
        this.rootView = view;
        rootView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                initPopupWindow();
            }
        });
    }

    public String getMaxPrice() {
        return maxPrice;
    }

    public String getMinPrice() {
        return minPrice;
    }

    private View rootView;

    public static ScreenPopVM initVM(View view) {
        return new ScreenPopVM(view);
    }

    private PopwindowVM.RequestListDelegate mRequestListDelegate;

    public ScreenPopVM setRequestListDelegate(PopwindowVM.RequestListDelegate requestListDelegate) {
        mRequestListDelegate = requestListDelegate;
        return this;
    }


    protected void initPopupWindow() {
        View popupWindowView = ((Activity) rootView.getContext()).getLayoutInflater().inflate(R.layout.pop_price, null);
        final EditText etMinPrice = (EditText) popupWindowView.findViewById(R.id.et_minPrice);
        final EditText etMaxPrice = (EditText) popupWindowView.findViewById(R.id.et_maxPrice);
        if (!TextUtils.isEmpty(maxPrice)) {
            etMaxPrice.setText(maxPrice);
        }
        if (!TextUtils.isEmpty(minPrice)) {
            etMinPrice.setText(minPrice);
        }
        //内容，高度，宽度
        final PopupWindow popupWindow = new PopupWindow(popupWindowView, (int) (((Activity) rootView.getContext()).getWindowManager().getDefaultDisplay().getWidth() * 0.7f), ViewGroup.LayoutParams.MATCH_PARENT, true);
        popupWindowView.findViewById(R.id.b_complete).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String maxStr = etMaxPrice.getText().toString();
                if (!TextUtils.isEmpty(maxStr)) {
                    maxPrice = maxStr;
                } else {
                    maxPrice = null;
                }
                String minStr = etMinPrice.getText().toString();
                if (!TextUtils.isEmpty(minStr)) {
                    minPrice = minStr;
                } else {
                    minPrice = null;
                }
                if (mRequestListDelegate != null) {
                    mRequestListDelegate.method();
                }
                popupWindow.dismiss();
            }
        });
        //动画效果
//        popupWindow.setAnimationStyle(R.style.AnimationRightFade);
        //菜单背景色
        ColorDrawable dw = new ColorDrawable(0xffffffff);
        popupWindow.setBackgroundDrawable(dw);
        //显示位置
        popupWindow.showAtLocation(((Activity) rootView.getContext()).findViewById(android.R.id.content), Gravity.RIGHT, 0, 500);
        //设置背景半透明
        backgroundAlpha(0.5f);

        popupWindow.setOnDismissListener(new PopupWindow.OnDismissListener() {
            @Override
            public void onDismiss() {
                backgroundAlpha(1f);
            }
        });
        popupWindowView.setOnTouchListener(new View.OnTouchListener() {

            @Override
            public boolean onTouch(View v, MotionEvent event) {
                /*if( popupWindow!=null && popupWindow.isShowing()){
                    popupWindow.dismiss();
                    popupWindow=null;
                }*/
                // 这里如果返回true的话，touch事件将被拦截
                // 拦截后 PopupWindow的onTouchEvent不被调用，这样点击外部区域无法dismiss
                return false;
            }
        });

    }

    /**
     * 设置添加屏幕的背景透明度
     *
     * @param bgAlpha
     */
    public void backgroundAlpha(float bgAlpha) {
        WindowManager.LayoutParams lp = ((Activity) rootView.getContext()).getWindow().getAttributes();
        lp.alpha = bgAlpha; //0.0-1.0
        ((Activity) rootView.getContext()).getWindow().setAttributes(lp);
    }

}
