package com.linzi.xiguwen.utils;

import android.content.Context;
import android.widget.Toast;

/**
 * Created by linzi on 2017/8/7.
 */

public class NToast {
    public static Context mContext;
    protected static Toast toast = null;
    private static long oneTime = 0;
    private static long twoTime = 0;
    private static String oldMsg;

    public static void init(Context context) {
        mContext = context;
    }

    public static void show(String msg) {
        if (mContext != null) {
            if (toast == null) {
                toast = Toast.makeText(mContext, msg, Toast.LENGTH_SHORT);
                toast.show();
                oneTime = System.currentTimeMillis();
            } else {
                twoTime = System.currentTimeMillis();
                if (msg.equals(oldMsg)) {
                    if (twoTime - oneTime > Toast.LENGTH_SHORT) {
                        toast.show();
                    }
                } else {
                    oldMsg = msg;
                    toast.setText(msg);
                    toast.show();
                }
            }
            oneTime = twoTime;
        }
    }

    public static void log(String tag, String msg) {
        com.linzi.xiguwen.utils.LogUtil.e(tag, msg);
    }

    //打印classname
    public static void log(Context context, String msg) {
        com.linzi.xiguwen.utils.LogUtil.d("TAG：" + context.toString().substring(context.toString().lastIndexOf(".") + 1, context.toString().indexOf("@")), msg);
    }

    public static void logE(String msg) {
        com.linzi.xiguwen.utils.LogUtil.e("TAG===============", msg);
    }
}
