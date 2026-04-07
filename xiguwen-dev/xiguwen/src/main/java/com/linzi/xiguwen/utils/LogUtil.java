package com.linzi.xiguwen.utils;

import android.text.TextUtils;
import android.util.Log;

public final class LogUtil {
    private static final String DEFAULT_TAG = "XiGuWen";
    private static final int MAX_LENGTH = 3000;

    private LogUtil() {
    }

    public static int v(String tag, String msg) {
        return print(Log.VERBOSE, tag, msg, null);
    }

    public static int v(String tag, String msg, Throwable tr) {
        return print(Log.VERBOSE, tag, msg, tr);
    }

    public static int d(String tag, String msg) {
        return print(Log.DEBUG, tag, msg, null);
    }

    public static int d(String tag, String msg, Throwable tr) {
        return print(Log.DEBUG, tag, msg, tr);
    }

    public static int i(String tag, String msg) {
        return print(Log.INFO, tag, msg, null);
    }

    public static int i(String tag, String msg, Throwable tr) {
        return print(Log.INFO, tag, msg, tr);
    }

    public static int w(String tag, String msg) {
        return print(Log.WARN, tag, msg, null);
    }

    public static int w(String tag, String msg, Throwable tr) {
        return print(Log.WARN, tag, msg, tr);
    }

    public static int w(String tag, Throwable tr) {
        return print(Log.WARN, tag, null, tr);
    }

    public static int e(String tag, String msg) {
        return print(Log.ERROR, tag, msg, null);
    }

    public static int e(String tag, String msg, Throwable tr) {
        return print(Log.ERROR, tag, msg, tr);
    }

    public static int e(String tag, Throwable tr) {
        return print(Log.ERROR, tag, null, tr);
    }

    public static void printStackTrace(Throwable throwable) {
        if (throwable == null) {
            return;
        }
        e(DEFAULT_TAG, Log.getStackTraceString(throwable));
    }

    public static void printStackTrace(String tag, Throwable throwable) {
        if (throwable == null) {
            return;
        }
        e(tag, Log.getStackTraceString(throwable));
    }

    private static int print(int priority, String tag, String msg, Throwable tr) {
        String safeTag = TextUtils.isEmpty(tag) ? DEFAULT_TAG : tag;
        String safeMsg = msg == null ? "" : msg;
        if (tr != null) {
            String trace = Log.getStackTraceString(tr);
            safeMsg = TextUtils.isEmpty(safeMsg) ? trace : safeMsg + "\n" + trace;
        }
        if (safeMsg.length() <= MAX_LENGTH) {
            return Log.println(priority, safeTag, safeMsg);
        }
        int result = 0;
        for (int start = 0; start < safeMsg.length(); start += MAX_LENGTH) {
            int end = Math.min(safeMsg.length(), start + MAX_LENGTH);
            result = Log.println(priority, safeTag, safeMsg.substring(start, end));
        }
        return result;
    }
}
