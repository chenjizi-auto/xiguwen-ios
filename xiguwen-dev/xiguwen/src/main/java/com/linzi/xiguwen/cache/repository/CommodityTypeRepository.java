package com.linzi.xiguwen.cache.repository;

import android.content.Context;
import android.os.Handler;
import android.os.Looper;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.linzi.xiguwen.bean.MineCommodityType;
import com.linzi.xiguwen.cache.CachePolicy;
import com.linzi.xiguwen.cache.OnCacheRequestFinish;
import com.linzi.xiguwen.cache.dao.ApiCacheDao;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;

import java.lang.reflect.Type;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class CommodityTypeRepository {

    private static final String PARENT_CACHE_KEY = "shops_commodity_type_parent";
    private static volatile CommodityTypeRepository sInstance;

    private final ApiCacheDao apiCacheDao;
    private final Gson gson;
    private final ExecutorService ioExecutor;
    private final Handler mainHandler;

    public static CommodityTypeRepository getInstance(Context context) {
        if (sInstance == null) {
            synchronized (CommodityTypeRepository.class) {
                if (sInstance == null) {
                    sInstance = new CommodityTypeRepository(context.getApplicationContext());
                }
            }
        }
        return sInstance;
    }

    private CommodityTypeRepository(Context context) {
        apiCacheDao = new ApiCacheDao(context);
        gson = new Gson();
        ioExecutor = Executors.newSingleThreadExecutor();
        mainHandler = new Handler(Looper.getMainLooper());
    }

    public void getParentTypes(final OnCacheRequestFinish<List<MineCommodityType>> callback) {
        final Type type = new TypeToken<List<MineCommodityType>>() {}.getType();
        getCachedList(PARENT_CACHE_KEY, "/Shops/commodityParent", type, CachePolicy.TTL_CONFIG, callback,
                new RemoteListLoader<MineCommodityType>() {
                    @Override
                    public void load(final RemoteListCallback<MineCommodityType> remoteCallback) {
                        ApiManager.getMineCommodityTypeParent(new OnRequestFinish<BaseBean<List<MineCommodityType>>>() {
                            @Override
                            public void onFinished() {
                                remoteCallback.onFinished();
                            }

                            @Override
                            public void onSuccess(BaseBean<List<MineCommodityType>> data) {
                                remoteCallback.onSuccess(data == null ? null : data.getData());
                            }

                            @Override
                            public void onError(Exception ex) {
                                remoteCallback.onError(ex);
                            }
                        });
                    }
                });
    }

    public void getChildTypes(final int pid, final OnCacheRequestFinish<List<MineCommodityType>> callback) {
        final Type type = new TypeToken<List<MineCommodityType>>() {}.getType();
        final String cacheKey = "shops_commodity_type_child_" + pid;
        getCachedList(cacheKey, "/Shops/commodityChild", type, CachePolicy.TTL_CONFIG, callback,
                new RemoteListLoader<MineCommodityType>() {
                    @Override
                    public void load(final RemoteListCallback<MineCommodityType> remoteCallback) {
                        ApiManager.getMineCommodityTypeChild(pid, new OnRequestFinish<BaseBean<List<MineCommodityType>>>() {
                            @Override
                            public void onFinished() {
                                remoteCallback.onFinished();
                            }

                            @Override
                            public void onSuccess(BaseBean<List<MineCommodityType>> data) {
                                remoteCallback.onSuccess(data == null ? null : data.getData());
                            }

                            @Override
                            public void onError(Exception ex) {
                                remoteCallback.onError(ex);
                            }
                        });
                    }
                });
    }

    private <T> void getCachedList(final String cacheKey, final String apiPath, final Type type, final long ttl,
                                   final OnCacheRequestFinish<List<T>> callback, final RemoteListLoader<T> loader) {
        ioExecutor.execute(new Runnable() {
            @Override
            public void run() {
                ApiCacheDao.CacheRecord record = apiCacheDao.get(cacheKey);
                if (record != null && record.dataJson != null && record.dataJson.length() > 0) {
                    final List<T> localData = gson.fromJson(record.dataJson, type);
                    if (localData != null && !localData.isEmpty()) {
                        postSuccess(callback, localData, true);
                        postFinished(callback);
                        if (apiCacheDao.isExpired(record)) {
                            requestRemote(cacheKey, apiPath, ttl, callback, type, loader, false);
                        }
                        return;
                    }
                }
                requestRemote(cacheKey, apiPath, ttl, callback, type, loader, true);
            }
        });
    }

    private <T> void requestRemote(final String cacheKey, final String apiPath, final long ttl,
                                   final OnCacheRequestFinish<List<T>> callback, final Type type,
                                   final RemoteListLoader<T> loader, final boolean callbackResult) {
        loader.load(new RemoteListCallback<T>() {
            @Override
            public void onSuccess(final List<T> data) {
                if (data != null && !data.isEmpty()) {
                    ioExecutor.execute(new Runnable() {
                        @Override
                        public void run() {
                            try {
                                long now = System.currentTimeMillis();
                                apiCacheDao.save(cacheKey, apiPath, "", "0",
                                        gson.toJson(data, type), null, now + ttl, now);
                            } catch (Exception ignored) {
                            }
                        }
                    });
                }
                if (callbackResult) {
                    callback.onSuccess(data, false);
                }
            }

            @Override
            public void onError(final Exception ex) {
                if (callbackResult) {
                    postError(callback, ex);
                }
            }

            @Override
            public void onFinished() {
                if (callbackResult) {
                    postFinished(callback);
                }
            }
        });
    }

    private <T> void postSuccess(final OnCacheRequestFinish<List<T>> callback, final List<T> data, final boolean fromCache) {
        mainHandler.post(new Runnable() {
            @Override
            public void run() {
                callback.onSuccess(data, fromCache);
            }
        });
    }

    private <T> void postError(final OnCacheRequestFinish<List<T>> callback, final Exception ex) {
        mainHandler.post(new Runnable() {
            @Override
            public void run() {
                callback.onError(ex);
            }
        });
    }

    private <T> void postFinished(final OnCacheRequestFinish<List<T>> callback) {
        mainHandler.post(new Runnable() {
            @Override
            public void run() {
                callback.onFinished();
            }
        });
    }

    private interface RemoteListLoader<T> {
        void load(RemoteListCallback<T> remoteCallback);
    }

    private interface RemoteListCallback<T> {
        void onSuccess(List<T> data);

        void onError(Exception ex);

        void onFinished();
    }
}
