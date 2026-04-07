package com.linzi.xiguwen.utils.yixin;

import android.app.Activity;
import android.content.Context;
import android.view.View;
import android.view.ViewGroup;
import android.widget.RelativeLayout;

/**
 * Created by pc on 2018/5/31.
 */

public class ViewUtil {
    /**
     * 传入一个view根据屏幕大小等分宽度
     *
     * @param context
     * @param view
     * @param num     几等分屏幕
     */
    public static void setNumOfScreenWidth(Context context, View view, int num) {
        int w = ((Activity) context).getWindowManager().getDefaultDisplay().getWidth();
        int h = w;
        RelativeLayout.LayoutParams layoutParams = (RelativeLayout.LayoutParams) view.getLayoutParams();
        layoutParams.width = w / num;
        layoutParams.height = h / num;
        view.setLayoutParams(layoutParams);
    }

    public static void setTwoColumnCardLayout(Context context, View cardView, View imageView, int position,
                                              int outerMarginDp, int innerMarginDp, int verticalMarginDp) {
        int outerMarginPx = dip2px(context, outerMarginDp);
        int innerMarginPx = dip2px(context, innerMarginDp);
        int verticalMarginPx = dip2px(context, verticalMarginDp);

        ViewGroup.LayoutParams layoutParams = cardView.getLayoutParams();
        if (layoutParams instanceof ViewGroup.MarginLayoutParams) {
            ViewGroup.MarginLayoutParams marginLayoutParams = (ViewGroup.MarginLayoutParams) layoutParams;
            boolean isRightColumn = position % 2 == 1;
            marginLayoutParams.leftMargin = isRightColumn ? innerMarginPx : outerMarginPx;
            marginLayoutParams.rightMargin = isRightColumn ? outerMarginPx : innerMarginPx;
            marginLayoutParams.topMargin = verticalMarginPx;
            marginLayoutParams.bottomMargin = verticalMarginPx;
            cardView.setLayoutParams(marginLayoutParams);
        }

        int screenWidth = ((Activity) context).getWindowManager().getDefaultDisplay().getWidth();
        int cardWidth = screenWidth / 2 - outerMarginPx - innerMarginPx;
        RelativeLayout.LayoutParams imageLayoutParams = (RelativeLayout.LayoutParams) imageView.getLayoutParams();
        imageLayoutParams.width = cardWidth;
        imageLayoutParams.height = cardWidth;
        imageView.setLayoutParams(imageLayoutParams);
    }

    private static int dip2px(Context context, float dpValue) {
        final float scale = context.getResources().getDisplayMetrics().density;
        return (int) (dpValue * scale + 0.5f);
    }
}
