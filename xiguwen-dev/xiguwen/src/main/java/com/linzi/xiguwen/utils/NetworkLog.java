package com.linzi.xiguwen.utils;


import java.util.Date;
import java.util.Locale;
import java.util.concurrent.atomic.AtomicLong;

public final class NetworkLog {
    private static final String TAG = "NET_CHAIN";
    private static final AtomicLong SEQ = new AtomicLong(1L);
    private static final int MAX_PARAMS_LENGTH = 2000;
    private static final int MAX_BODY_LENGTH = 4000;

    private NetworkLog() {
    }

    public static final class Chain {
        private final String id;
        private final long startAt;

        private Chain(String id, long startAt) {
            this.id = id;
            this.startAt = startAt;
        }
    }

    public static Chain start(String method, String url, String params) {
        long now = System.currentTimeMillis();
        String id = buildId(now);
        String time = LogFileManager.format(new Date(now), "yyyy-MM-dd HH:mm:ss.SSS");
        String safeParams = sanitize(params, MAX_PARAMS_LENGTH);
        String line = String.format(Locale.US,
                "REQ id=%s time=%s method=%s url=%s params=%s",
                id,
                time,
                safe(method),
                safe(url),
                safeParams);
        writeLine(line);
        return new Chain(id, now);
    }

    public static void success(Chain chain, int code, String body) {
        finish(chain, true, code, body, null);
    }

    public static void failure(Chain chain, int code, String body, Throwable error) {
        finish(chain, false, code, body, error);
    }

    private static void finish(Chain chain, boolean success, int code, String body, Throwable error) {
        if (chain == null) {
            return;
        }
        long endAt = System.currentTimeMillis();
        long cost = endAt - chain.startAt;
        String time = LogFileManager.format(new Date(endAt), "yyyy-MM-dd HH:mm:ss.SSS");
        String safeBody = sanitize(body, MAX_BODY_LENGTH);
        String errorMsg = error == null ? "" : sanitize(error.toString(), 500);
        String line = String.format(Locale.US,
                "RES id=%s time=%s cost=%dms success=%s code=%d body=%s error=%s",
                chain.id,
                time,
                cost,
                success,
                code,
                safeBody,
                errorMsg);
        com.linzi.xiguwen.utils.LogUtil.d(TAG, line);
    }

    private static String buildId(long now) {
        long seq = SEQ.getAndIncrement();
        return now + "-" + seq;
    }

    private static String safe(String value) {
        if (value == null) {
            return "";
        }
        return sanitize(value, 1000);
    }

    private static String sanitize(String value, int maxLen) {
        if (value == null) {
            return "";
        }
        String sanitized = value.replace('\n', ' ')
                .replace('\r', ' ')
                .replace('\t', ' ');
        if (sanitized.length() <= maxLen) {
            return sanitized;
        }
        return sanitized.substring(0, maxLen) + "...(truncated)";
    }

    private static void writeLine(String line) {
        com.linzi.xiguwen.utils.LogUtil.d(TAG, line);
    }
}
