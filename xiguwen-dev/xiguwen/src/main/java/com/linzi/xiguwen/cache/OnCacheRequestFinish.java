package com.linzi.xiguwen.cache;

public interface OnCacheRequestFinish<T> {
    void onSuccess(T data, boolean fromCache);

    void onError(Exception ex);

    void onFinished();
}
