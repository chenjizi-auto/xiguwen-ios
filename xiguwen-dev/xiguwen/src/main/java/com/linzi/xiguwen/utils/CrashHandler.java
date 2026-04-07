package com.linzi.xiguwen.utils;

import android.content.Context;
import android.os.Build;

import java.io.File;
import java.io.FileOutputStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.nio.charset.StandardCharsets;

public final class CrashHandler implements Thread.UncaughtExceptionHandler {
    private static CrashHandler sInstance;
    private final Context appContext;
    private final Thread.UncaughtExceptionHandler defaultHandler;

    private CrashHandler(Context context) {
        this.appContext = context.getApplicationContext();
        this.defaultHandler = Thread.getDefaultUncaughtExceptionHandler();
    }

    public static void install(Context context) {
        if (sInstance == null) {
            sInstance = new CrashHandler(context);
            Thread.setDefaultUncaughtExceptionHandler(sInstance);
        }
    }

    @Override
    public void uncaughtException(Thread thread, Throwable ex) {
        try {
            long now = System.currentTimeMillis();
            File file = LogFileManager.createCrashLogFile(appContext, now);
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            pw.println("time=" + LogFileManager.format(new java.util.Date(now), "yyyy-MM-dd HH:mm:ss"));
            pw.println("thread=" + thread.getName());
            pw.println("device=" + Build.MANUFACTURER + " " + Build.MODEL);
            pw.println("sdk=" + Build.VERSION.SDK_INT + " (" + Build.VERSION.RELEASE + ")");
            pw.println();
            ex.printStackTrace(pw);
            pw.flush();
            FileOutputStream fos = new FileOutputStream(file, true);
            fos.write(sw.toString().getBytes(StandardCharsets.UTF_8));
            fos.flush();
            fos.close();
        } catch (Exception ignored) {
        } finally {
            if (defaultHandler != null) {
                defaultHandler.uncaughtException(thread, ex);
            }
        }
    }
}
