package com.linzi.xiguwen.net;

import android.os.Handler;
import android.os.Looper;

import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.utils.NetworkLog;

import org.xutils.common.Callback;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import okhttp3.Call;
import okhttp3.FormBody;
import okhttp3.Headers;
import okhttp3.HttpUrl;
import okhttp3.MediaType;
import okhttp3.MultipartBody;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

/**
 * Title:
 * Description:
 * Copyright:Copyright(c)2018
 * Company: Cree
 * CreateTime:2018/3/22  15:35
 *
 * @author luyongjiang
 * @version 1.0
 */
public class Api {

    private static final OkHttpClient CLIENT = new OkHttpClient();
    private static final Handler MAIN_HANDLER = new Handler(Looper.getMainLooper());
    private static final MediaType FILE_MEDIA_TYPE = MediaType.parse("application/octet-stream");


    /**
     * 发起post请求
     *
     * @param url      请求地址
     * @param callback 回调接口
     * @param <T>
     */
    public static <T extends BaseBean> void post(String url, MapUtils mapUtils, BaseCallBack<T> callback) {
        enqueue(createPostRequest(url, mapUtils == null ? null : mapUtils.getValue()), callback);
    }

    public static <T extends BaseBean> void get(String url, MapUtils mapUtils, BaseCallBack<T> callback) {
        enqueue(createGetRequest(url, mapUtils == null ? null : mapUtils.getValue()), callback);
    }

    /**
     * 这个请求会自动拼接参数
     *
     * @param url      请求地址
     * @param callback 回调接口
     * @param <T>
     */
    public static <T extends BaseBean> void postSternUrl(MapUtils mapUtils, String url, BaseCallBack<T> callback) {
        //差一行拼接地址方法
        enqueue(createPostRequest(url, mapUtils == null ? null : mapUtils.getValue()), callback);
    }


    /**
     * 发起post请求
     *
     * @param <T>
     * @param url      请求地址
     * @param callback 回调接口
     */
    public static <T extends BaseBean> Callback.Cancelable post(String url, MapUtilsX mapUtils, BaseCallBack<T> callback) {
        return enqueue(createPostRequest(url, mapUtils == null ? null : mapUtils.getValue()), callback);
    }


    private static Request createPostRequest(String url, Map<String, Object> value) {
        RequestBody requestBody = createPostRequestBody(value);
        return new Request.Builder()
                .url(url)
                .post(requestBody)
                .build();
    }

    private static Request createGetRequest(String url, Map<String, Object> value) {
        HttpUrl requestUrl = createGetUrl(url, value);
        return new Request.Builder()
                .url(requestUrl)
                .get()
                .build();
    }

    private static RequestBody createPostRequestBody(Map<String, Object> value) {
        List<ParameterItem> parameterItems = collectParameterItems(value);
        boolean hasFile = false;
        for (ParameterItem item : parameterItems) {
            if (item.file != null) {
                hasFile = true;
                break;
            }
        }

        if (hasFile) {
            MultipartBody.Builder bodyBuilder = new MultipartBody.Builder().setType(MultipartBody.FORM);
            for (ParameterItem item : parameterItems) {
                if (item.file != null) {
                    bodyBuilder.addFormDataPart(
                            item.key,
                            item.file.getName(),
                            RequestBody.create(item.file, FILE_MEDIA_TYPE)
                    );
                } else {
                    bodyBuilder.addFormDataPart(item.key, item.value);
                }
            }
            return bodyBuilder.build();
        }

        FormBody.Builder bodyBuilder = new FormBody.Builder();
        for (ParameterItem item : parameterItems) {
            bodyBuilder.add(item.key, item.value);
        }
        return bodyBuilder.build();
    }

    private static HttpUrl createGetUrl(String url, Map<String, Object> value) {
        HttpUrl httpUrl = HttpUrl.parse(url);
        if (httpUrl == null) {
            throw new IllegalArgumentException("参数错误:{url->" + url + "}");
        }
        HttpUrl.Builder urlBuilder = httpUrl.newBuilder();
        List<ParameterItem> parameterItems = collectParameterItems(value);
        for (ParameterItem item : parameterItems) {
            if (item.file != null) {
                throw new IllegalArgumentException("参数错误:{" + item.key + "->" + item.file + "}");
            }
            urlBuilder.addQueryParameter(item.key, item.value);
        }
        return urlBuilder.build();
    }

    private static Callback.Cancelable enqueue(Request request, BaseCallBack<?> callback) {
        String params = buildRequestParams(request);
        NetworkLog.Chain chain = NetworkLog.start(request.method(), request.url().toString(), params);
        Call call = CLIENT.newCall(request);
        OkHttpCancelable cancelable = new OkHttpCancelable(call);
        call.enqueue(new okhttp3.Callback() {
            @Override
            public void onFailure(Call call, IOException e) {
                Throwable error = call.isCanceled() ? new IOException("Cancelled") : e;
                NetworkLog.failure(chain, -1, "", error);
                if (callback == null) {
                    return;
                }
                MAIN_HANDLER.post(() -> {
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
                } catch (IOException e) {
                    NetworkLog.failure(chain, responseCode, responseBody, e);
                    if (callback == null) {
                        return;
                    }
                    MAIN_HANDLER.post(() -> {
                        callback.onError(e, false);
                        callback.onFinished();
                    });
                    return;
                } finally {
                    response.close();
                }

                if (success) {
                    NetworkLog.success(chain, responseCode, responseBody);
                } else {
                    String message = "HTTP " + responseCode;
                    if (responseBody != null && !responseBody.isEmpty()) {
                        message = message + " " + responseBody;
                    }
                    NetworkLog.failure(chain, responseCode, responseBody, new IOException(message));
                }

                if (callback == null) {
                    return;
                }

                if (success) {
                    final String finalResponseBody = responseBody;
                    MAIN_HANDLER.post(() -> {
                        try {
                            callback.onSuccess(finalResponseBody);
                        } catch (Throwable throwable) {
                            callback.onError(throwable, false);
                        } finally {
                            callback.onFinished();
                        }
                    });
                } else {
                    String message = "HTTP " + responseCode;
                    if (responseBody != null && !responseBody.isEmpty()) {
                        message = message + " " + responseBody;
                    }
                    IOException exception = new IOException(message);
                    MAIN_HANDLER.post(() -> {
                        callback.onError(exception, false);
                        callback.onFinished();
                    });
                }
            }
        });
        return cancelable;
    }

    private static String buildRequestParams(Request request) {
        if (request == null) {
            return "";
        }
        String query = buildQueryParams(request.url());
        String body = buildBodyParams(request.body());
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

    private static String buildQueryParams(HttpUrl url) {
        if (url == null || url.querySize() == 0) {
            return "";
        }
        StringBuilder sb = new StringBuilder();
        for (String name : url.queryParameterNames()) {
            List<String> values = url.queryParameterValues(name);
            if (values == null || values.isEmpty()) {
                appendParam(sb, name, "");
                continue;
            }
            for (String value : values) {
                appendParam(sb, name, value);
            }
        }
        return sb.toString();
    }

    private static String buildBodyParams(RequestBody body) {
        if (body == null) {
            return "";
        }
        if (body instanceof FormBody) {
            return buildFormBodyParams((FormBody) body);
        }
        if (body instanceof MultipartBody) {
            return buildMultipartParams((MultipartBody) body);
        }
        String contentType = body.contentType() == null ? "unknown" : body.contentType().toString();
        long length = -1L;
        try {
            length = body.contentLength();
        } catch (IOException ignored) {
        }
        return "contentType=" + contentType + "&length=" + length;
    }

    private static String buildFormBodyParams(FormBody body) {
        if (body == null || body.size() == 0) {
            return "";
        }
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < body.size(); i++) {
            appendParam(sb, body.name(i), body.value(i));
        }
        return sb.toString();
    }

    private static String buildMultipartParams(MultipartBody body) {
        if (body == null) {
            return "";
        }
        StringBuilder sb = new StringBuilder();
        int index = 0;
        for (MultipartBody.Part part : body.parts()) {
            index++;
            Headers headers = part.headers();
            String disposition = headers == null ? null : headers.get("Content-Disposition");
            String name = extractDispositionValue(disposition, "name");
            String filename = extractDispositionValue(disposition, "filename");
            String key = name == null ? "part" + index : name;
            String value = filename == null ? "<binary>" : "@" + filename;
            appendParam(sb, key, value);
        }
        return sb.toString();
    }

    private static String extractDispositionValue(String header, String key) {
        if (header == null || key == null) {
            return null;
        }
        String target = key + "=\"";
        int start = header.indexOf(target);
        if (start < 0) {
            return null;
        }
        start += target.length();
        int end = header.indexOf("\"", start);
        if (end < 0) {
            return null;
        }
        return header.substring(start, end);
    }

    private static void appendParam(StringBuilder sb, String key, String value) {
        if (key == null || key.isEmpty()) {
            return;
        }
        if (sb.length() > 0) {
            sb.append("&");
        }
        sb.append(key).append("=").append(value == null ? "" : value);
    }

    private static List<ParameterItem> collectParameterItems(Map<String, Object> value) {
        List<ParameterItem> parameterItems = new ArrayList<>();
        if (value == null || value.isEmpty()) {
            return parameterItems;
        }

        Iterator<String> iterator = value.keySet().iterator();
        while (iterator.hasNext()) {
            String key = iterator.next();
            Object va = value.get(key);
            addBodyParameter(parameterItems, key, va);
        }
        return parameterItems;
    }

    private static List<ParameterItem> addBodyParameter(List<ParameterItem> parameterItems, String key, Object va) throws IllegalArgumentException {
        if (va instanceof String) {
            parameterItems.add(ParameterItem.value(key, (String) va));
        } else if (va instanceof Integer) {
            parameterItems.add(ParameterItem.value(key, (int) va + ""));
        } else if (va instanceof Double) {
            parameterItems.add(ParameterItem.value(key, (double) va + ""));
        } else if (va instanceof Float) {
            parameterItems.add(ParameterItem.value(key, (float) va + ""));
        } else if (va instanceof Short) {
            parameterItems.add(ParameterItem.value(key, (short) va + ""));
        } else if (va instanceof Long) {
            parameterItems.add(ParameterItem.value(key, (long) va + ""));
        } else if (va instanceof Boolean) {
            parameterItems.add(ParameterItem.value(key, (boolean) va ? "true" : "false"));
        } else if (va instanceof Byte) {
            parameterItems.add(ParameterItem.value(key, (byte) va + ""));
        } else if (va instanceof File) {
            parameterItems.add(ParameterItem.file(key, (File) va));
        } else if (va instanceof List) {
            List cache = (List) va;
            for (Object o : cache) {
                addBodyParameter(parameterItems, key, o);
            }
        } else {
            throw new IllegalArgumentException("参数错误:{" + key + "->" + va + "}");
        }
        return parameterItems;
    }

    private static class ParameterItem {
        final String key;
        final String value;
        final File file;

        private ParameterItem(String key, String value, File file) {
            this.key = key;
            this.value = value;
            this.file = file;
        }

        static ParameterItem value(String key, String value) {
            return new ParameterItem(key, value, null);
        }

        static ParameterItem file(String key, File file) {
            return new ParameterItem(key, null, file);
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
}
