package com.linzi.xiguwen.net;

import android.os.Handler;
import android.os.Looper;
import android.text.TextUtils;

import com.linzi.xiguwen.utils.NetworkLog;

import org.xutils.common.Callback;
import org.xutils.common.util.KeyValue;
import org.xutils.http.BaseParams;
import org.xutils.http.RequestParams;

import java.io.FilterOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;
import java.util.concurrent.TimeUnit;

import okhttp3.Call;
import okhttp3.HttpUrl;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;
import okio.BufferedSink;

public final class OkHttpRequest {

    private static final OkHttpClient BASE_CLIENT = new OkHttpClient();
    private static final Handler MAIN_HANDLER = new Handler(Looper.getMainLooper());
    private static final RequestBody EMPTY_REQUEST_BODY = RequestBody.create(new byte[0]);

    private OkHttpRequest() {
    }

    public static Callback.Cancelable post(RequestParams params, Callback.CommonCallback<String> callback) {
        return execute("POST", params, callback, null);
    }

    public static Callback.Cancelable post(RequestParams params, Callback.ProgressCallback<String> callback) {
        return execute("POST", params, callback, callback);
    }

    public static Callback.Cancelable get(RequestParams params, Callback.CommonCallback<String> callback) {
        return execute("GET", params, callback, null);
    }

    private static Callback.Cancelable execute(String method,
                                               RequestParams params,
                                               Callback.CommonCallback<String> callback,
                                               Callback.ProgressCallback<String> progressCallback) {
        if (params == null) {
            postError(callback, new IllegalArgumentException("RequestParams is null"));
            return new EmptyCancelable();
        }
        final Request request;
        try {
            request = buildRequest(method, params, progressCallback);
        } catch (Throwable throwable) {
            postError(callback, throwable);
            return new EmptyCancelable();
        }

        if (progressCallback != null) {
            postToMain(() -> {
                progressCallback.onWaiting();
                progressCallback.onStarted();
            });
        }

        boolean isGet = "GET".equalsIgnoreCase(method);
        String paramSummary = buildParamsSummary(params, isGet);
        NetworkLog.Chain chain = NetworkLog.start(method, request.url().toString(), paramSummary);
        Call call = buildClient(params).newCall(request);
        OkHttpCancelable cancelable = new OkHttpCancelable(call);
        call.enqueue(new okhttp3.Callback() {
            @Override
            public void onFailure(Call call, IOException e) {
                Throwable error = call.isCanceled() ? new IOException("Cancelled") : e;
                NetworkLog.failure(chain, -1, "", error);
                if (callback == null) {
                    return;
                }
                postToMain(() -> {
                    if (call.isCanceled()) {
                        callback.onCancelled(new Callback.CancelledException("Cancelled"));
                    } else {
                        callback.onError(e, false);
                    }
                    callback.onFinished();
                });
            }

            @Override
            public void onResponse(Call call, Response response) {
                String responseBody = "";
                int responseCode = response.code();
                boolean success = response.isSuccessful();
                try {
                    if (response.body() != null) {
                        responseBody = response.body().string();
                    }
                } catch (Throwable throwable) {
                    NetworkLog.failure(chain, responseCode, responseBody, throwable);
                    if (callback == null) {
                        return;
                    }
                    final Throwable readException = throwable;
                    postToMain(() -> {
                        callback.onError(readException, false);
                        callback.onFinished();
                    });
                    return;
                } finally {
                    response.close();
                }

                if (success) {
                    NetworkLog.success(chain, responseCode, responseBody);
                } else {
                    String errorMessage = "HTTP " + responseCode;
                    if (!TextUtils.isEmpty(responseBody)) {
                        errorMessage = errorMessage + " " + responseBody;
                    }
                    NetworkLog.failure(chain, responseCode, responseBody, new IOException(errorMessage));
                }

                if (callback == null) {
                    return;
                }

                final String finalResponseBody = responseBody;
                final boolean finalSuccess = success;
                postToMain(() -> {
                    try {
                        if (finalSuccess) {
                            callback.onSuccess(finalResponseBody);
                        } else {
                            String errorMessage = "HTTP " + responseCode;
                            if (!TextUtils.isEmpty(finalResponseBody)) {
                                errorMessage = errorMessage + " " + finalResponseBody;
                            }
                            callback.onError(new IOException(errorMessage), false);
                        }
                    } catch (Throwable throwable) {
                        callback.onError(throwable, false);
                    } finally {
                        callback.onFinished();
                    }
                });
            }
        });
        return cancelable;
    }

    private static String buildParamsSummary(RequestParams params, boolean includeBodyAsQuery) {
        if (params == null) {
            return "";
        }
        String query = buildKeyValueString(params.getQueryStringParams());
        String body = buildKeyValueString(params.getBodyParams());
        if (includeBodyAsQuery) {
            if (!body.isEmpty()) {
                if (!query.isEmpty()) {
                    query = query + "&" + body;
                } else {
                    query = body;
                }
            }
            body = "";
        }
        if (!query.isEmpty() && !body.isEmpty()) {
            return "query=" + query + " body=" + body;
        }
        if (!query.isEmpty()) {
            return "query=" + query;
        }
        if (!body.isEmpty()) {
            return "body=" + body;
        }
        return "";
    }

    private static String buildKeyValueString(List<KeyValue> params) {
        if (params == null || params.isEmpty()) {
            return "";
        }
        StringBuilder sb = new StringBuilder();
        for (KeyValue keyValue : params) {
            if (keyValue == null || TextUtils.isEmpty(keyValue.key)) {
                continue;
            }
            String value = keyValue.getValueStrOrNull();
            if (value == null) {
                value = "<binary>";
            }
            if (sb.length() > 0) {
                sb.append("&");
            }
            sb.append(keyValue.key).append("=").append(value);
        }
        return sb.toString();
    }

    private static Request buildRequest(String method,
                                        RequestParams params,
                                        Callback.ProgressCallback<String> progressCallback) throws IOException {
        boolean isGet = "GET".equalsIgnoreCase(method);
        HttpUrl url = buildUrl(params, isGet);
        Request.Builder builder = new Request.Builder().url(url);
        addHeaders(builder, params.getHeaders());
        if (isGet) {
            builder.get();
        } else {
            builder.post(buildRequestBody(params, progressCallback));
        }
        return builder.build();
    }

    private static HttpUrl buildUrl(RequestParams params, boolean includeBodyAsQuery) {
        HttpUrl httpUrl = HttpUrl.parse(params.getUri());
        if (httpUrl == null) {
            throw new IllegalArgumentException("参数错误:{url->" + params.getUri() + "}");
        }
        HttpUrl.Builder builder = httpUrl.newBuilder();
        appendQueryParams(builder, params.getQueryStringParams());
        if (includeBodyAsQuery) {
            appendQueryParams(builder, params.getBodyParams());
        }
        return builder.build();
    }

    private static void appendQueryParams(HttpUrl.Builder builder, List<KeyValue> params) {
        if (params == null || params.isEmpty()) {
            return;
        }
        for (KeyValue keyValue : params) {
            if (keyValue == null || TextUtils.isEmpty(keyValue.key)) {
                continue;
            }
            String value = keyValue.getValueStrOrNull();
            if (value == null) {
                continue;
            }
            builder.addQueryParameter(keyValue.key, value);
        }
    }

    private static void addHeaders(Request.Builder builder, List<BaseParams.Header> headers) {
        if (headers == null || headers.isEmpty()) {
            return;
        }
        for (BaseParams.Header header : headers) {
            if (header == null || TextUtils.isEmpty(header.key) || header.value == null) {
                continue;
            }
            builder.addHeader(header.key, String.valueOf(header.value));
        }
    }

    private static RequestBody buildRequestBody(RequestParams params,
                                                Callback.ProgressCallback<String> progressCallback) throws IOException {
        org.xutils.http.body.RequestBody sourceBody = params.getRequestBody();
        if (sourceBody == null) {
            return EMPTY_REQUEST_BODY;
        }
        return new DelegatingRequestBody(sourceBody, progressCallback);
    }

    private static OkHttpClient buildClient(RequestParams params) {
        OkHttpClient.Builder builder = BASE_CLIENT.newBuilder();
        int connectTimeout = params.getConnectTimeout();
        if (connectTimeout > 0) {
            builder.connectTimeout(connectTimeout, TimeUnit.MILLISECONDS);
        }
        int readTimeout = params.getReadTimeout();
        if (readTimeout > 0) {
            builder.readTimeout(readTimeout, TimeUnit.MILLISECONDS);
            builder.writeTimeout(readTimeout, TimeUnit.MILLISECONDS);
        }
        if (params.getHostnameVerifier() != null) {
            builder.hostnameVerifier(params.getHostnameVerifier());
        }
        return builder.build();
    }

    private static void postError(Callback.CommonCallback<String> callback, Throwable throwable) {
        if (callback == null) {
            return;
        }
        postToMain(() -> {
            callback.onError(throwable, false);
            callback.onFinished();
        });
    }

    private static void postToMain(Runnable runnable) {
        if (Looper.myLooper() == Looper.getMainLooper()) {
            runnable.run();
        } else {
            MAIN_HANDLER.post(runnable);
        }
    }

    private static class DelegatingRequestBody extends RequestBody {
        private static final long LOADING_NOTIFY_INTERVAL_MS = 120L;
        private final org.xutils.http.body.RequestBody sourceBody;
        private final Callback.ProgressCallback<String> progressCallback;

        private DelegatingRequestBody(org.xutils.http.body.RequestBody sourceBody,
                                      Callback.ProgressCallback<String> progressCallback) {
            this.sourceBody = sourceBody;
            this.progressCallback = progressCallback;
        }

        @Override
        public MediaType contentType() {
            String contentType = sourceBody.getContentType();
            if (TextUtils.isEmpty(contentType)) {
                return null;
            }
            return MediaType.parse(contentType);
        }

        @Override
        public long contentLength() {
            return sourceBody.getContentLength();
        }

        @Override
        public void writeTo(BufferedSink sink) throws IOException {
            if (progressCallback == null) {
                sourceBody.writeTo(sink.outputStream());
                return;
            }
            long total = contentLength();
            OutputStream outputStream = sink.outputStream();
            ProgressOutputStream progressOutputStream = new ProgressOutputStream(outputStream, total, progressCallback);
            sourceBody.writeTo(progressOutputStream);
            progressOutputStream.notifyFinished();
        }
    }

    private static class ProgressOutputStream extends FilterOutputStream {
        private final long total;
        private final Callback.ProgressCallback<String> callback;
        private long current;
        private long lastNotifyTime;

        private ProgressOutputStream(OutputStream out, long total, Callback.ProgressCallback<String> callback) {
            super(out);
            this.total = total;
            this.callback = callback;
        }

        @Override
        public void write(int b) throws IOException {
            out.write(b);
            current++;
            notifyProgress(false);
        }

        @Override
        public void write(byte[] b, int off, int len) throws IOException {
            out.write(b, off, len);
            current += len;
            notifyProgress(false);
        }

        private void notifyProgress(boolean force) {
            long now = System.currentTimeMillis();
            if (!force && (now - lastNotifyTime) < DelegatingRequestBody.LOADING_NOTIFY_INTERVAL_MS) {
                return;
            }
            lastNotifyTime = now;
            long callbackCurrent = current;
            postToMain(() -> callback.onLoading(total, callbackCurrent, false));
        }

        private void notifyFinished() {
            notifyProgress(true);
        }

        @Override
        public void close() throws IOException {
            flush();
        }
    }

    private static class OkHttpCancelable implements Callback.Cancelable {
        private final Call call;

        private OkHttpCancelable(Call call) {
            this.call = call;
        }

        @Override
        public void cancel() {
            call.cancel();
        }

        @Override
        public boolean isCancelled() {
            return call.isCanceled();
        }
    }

    private static class EmptyCancelable implements Callback.Cancelable {

        @Override
        public void cancel() {
        }

        @Override
        public boolean isCancelled() {
            return true;
        }
    }
}
