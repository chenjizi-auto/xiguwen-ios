package com.linzi.xiguwen.utils;

import android.content.Context;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.concurrent.TimeUnit;

public final class LogFileManager {
    private static final String LOG_DIR_NAME = "logs";
    private static final Object LOCK = new Object();
    private static File runtimeLogFile;
    private static Context appContext;

    private LogFileManager() {
    }

    public static void init(Context context) {
        if (context != null) {
            appContext = context.getApplicationContext();
        }
    }

    private static Context requireContext(Context context) {
        if (context != null) {
            return context.getApplicationContext();
        }
        return appContext;
    }

    public static File ensureLogDir(Context context) {
        Context ctx = requireContext(context);
        if (ctx == null) {
            return new File(".");
        }
        File base = ctx.getExternalFilesDir(null);
        File dir = new File(base, LOG_DIR_NAME);
        if (!dir.exists()) {
            dir.mkdirs();
        }
        return dir;
    }

    public static void deleteLogsOlderThan(Context context, int days) {
        if (days <= 0) {
            return;
        }
        File dir = ensureLogDir(context);
        if (dir == null || !dir.exists() || !dir.isDirectory()) {
            return;
        }
        long cutoff = System.currentTimeMillis() - TimeUnit.DAYS.toMillis(days);
        File[] files = dir.listFiles();
        if (files == null) {
            return;
        }
        for (File file : files) {
            if (file != null && file.isFile() && file.lastModified() < cutoff) {
                // Best-effort cleanup.
                try {
                    //noinspection ResultOfMethodCallIgnored
                    file.delete();
                } catch (Exception ignored) {
                }
            }
        }
    }

    public static File getRuntimeLogFile(Context context) {
        synchronized (LOCK) {
            if (runtimeLogFile == null) {
                runtimeLogFile = new File(ensureLogDir(context),
                        "xiguwen_run_" + format(new Date(), "yyyyMMdd_HH:mm:ss") + ".log");
            }
            return runtimeLogFile;
        }
    }

    public static File getNetworkLogFile(Context context) {
        return new File(ensureLogDir(context),
                "xiguwen_run_http_" + format(new Date(), "yyyyMMdd") + ".log");
    }

    public static Context getContext() {
        return appContext;
    }

    public static File createCrashLogFile(Context context, long timeMillis) {
        return new File(ensureLogDir(context),
                "xiguwen_crash_" + format(new Date(timeMillis), "yyyyMMdd_HH:mm:ss") + ".log");
    }

    public static String format(Date date, String pattern) {
        return new SimpleDateFormat(pattern, Locale.CHINA).format(date);
    }
}
