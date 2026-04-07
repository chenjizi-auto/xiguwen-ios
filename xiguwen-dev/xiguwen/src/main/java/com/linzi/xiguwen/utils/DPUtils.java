package com.linzi.xiguwen.utils;

import android.content.Context;
import android.content.res.Resources;

/**
 * Title:
 * Description:
 * Copyright:Copyright(c)2018
 * Company: Cree
 * CreateTime:2018/3/27  13:57
 *
 * @author luyongjiang
 * @version 1.0
 */
public class DPUtils {
    /**
     * DP转PX
     *
     * @param context
     * @param value
     * @return
     */
    public static float DPToPX(Context context, float value) {
        float scale = context.getResources().getDisplayMetrics().density;
        return (int) (value * scale + 0.5f);
    }

    public static int dip2px(Context context, float dpValue) {
        final float scale = context.getApplicationContext().getResources().getDisplayMetrics().density;
        return (int) (dpValue * scale + 0.5f);
    }

    /**
     * 获取状态栏高度
     */
    public static int getStatusBarHeight(Context context) {
        int result = 0;
        int resourceId = Resources.getSystem().getIdentifier("status_bar_height", "dimen", "android");
        if (resourceId > 0) {
            result = context.getResources().getDimensionPixelSize(resourceId);
        }
        return result == 0 ? dip2px(context, 26) : result;
    }
}
