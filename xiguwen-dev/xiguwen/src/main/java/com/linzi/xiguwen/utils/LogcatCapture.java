package com.linzi.xiguwen.utils;

import android.content.Context;
import android.os.Process;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.nio.charset.StandardCharsets;

public final class LogcatCapture {
    private static LogcatCapture sInstance;

    private Thread worker;
    private java.lang.Process process;

    private LogcatCapture() {
    }

    public static void start(Context context) {
        if (sInstance != null) {
            return;
        }
        sInstance = new LogcatCapture();
        sInstance.startInternal(context.getApplicationContext());
    }

    private void startInternal(final Context context) {
        worker = new Thread(new Runnable() {
            @Override
            public void run() {
                int pid = Process.myPid();
                try {
                    File logFile = LogFileManager.getRuntimeLogFile(context);
                    BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(
                            new FileOutputStream(logFile, true), StandardCharsets.UTF_8));

                    ProcessBuilder builder = new ProcessBuilder("logcat", "-v", "threadtime", "--pid=" + pid);
                    try {
                        process = builder.start();
                    } catch (Exception e) {
                        process = new ProcessBuilder("logcat", "-v", "threadtime").start();
                    }

                    BufferedReader reader = new BufferedReader(new InputStreamReader(process.getInputStream(), StandardCharsets.UTF_8));
                    String line;
                    String pidToken = " " + pid + " ";
                    while ((line = reader.readLine()) != null) {
                        if (line.contains(pidToken)) {
                            writer.write(line);
                            writer.newLine();
                        }
                    }
                    writer.flush();
                    writer.close();
                    reader.close();
                } catch (Exception ignored) {
                }
            }
        }, "logcat-capture");
        worker.setDaemon(true);
        worker.start();
    }
}
