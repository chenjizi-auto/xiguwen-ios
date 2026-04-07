package com.linzi.xiguwen.cache.repository;

import android.content.Context;
import android.os.Handler;
import android.os.Looper;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.linzi.xiguwen.bean.CaseTypeEntity;
import com.linzi.xiguwen.bean.WeddingEnvironmentBean;
import com.linzi.xiguwen.bean.WeddingTypsBean;
import com.linzi.xiguwen.cache.CachePolicy;
import com.linzi.xiguwen.cache.OnCacheRequestFinish;
import com.linzi.xiguwen.cache.dao.ApiCacheDao;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.OnRequestSubscribe;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;

import java.lang.reflect.Type;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class WeddingDictionaryRepository {

    private static volatile WeddingDictionaryRepository sInstance;

    private final ApiCacheDao apiCacheDao;
    private final Gson gson;
    private final ExecutorService ioExecutor;
    private final Handler mainHandler;

    public static WeddingDictionaryRepository getInstance(Context context) {
        if (sInstance == null) {
            synchronized (WeddingDictionaryRepository.class) {
                if (sInstance == null) {
                    sInstance = new WeddingDictionaryRepository(context.getApplicationContext());
                }
            }
        }
        return sInstance;
    }

    private WeddingDictionaryRepository(Context context) {
        apiCacheDao = new ApiCacheDao(context);
        gson = new Gson();
        ioExecutor = Executors.newSingleThreadExecutor();
        mainHandler = new Handler(Looper.getMainLooper());
    }

    public void getWeddingTypes(final OnCacheRequestFinish<List<WeddingTypsBean>> callback) {
        getCachedList("system_wedding_types", "/System/weddingtype",
                new TypeToken<List<WeddingTypsBean>>() {}.getType(), callback,
                new RemoteListLoader<WeddingTypsBean>() {
                    @Override
                    public void load(final RemoteListCallback<WeddingTypsBean> remoteCallback) {
                        ApiManager.getWeddingTypes(new OnRequestFinish<BaseBean<List<WeddingTypsBean>>>() {
                            @Override
                            public void onFinished() {
                                remoteCallback.onFinished();
                            }

                            @Override
                            public void onSuccess(BaseBean<List<WeddingTypsBean>> data) {
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

    public void getWeddingEnvironments(final OnCacheRequestFinish<List<WeddingEnvironmentBean>> callback) {
        getCachedList("system_wedding_environments", "/System/weddingenvironment",
                new TypeToken<List<WeddingEnvironmentBean>>() {}.getType(), callback,
                new RemoteListLoader<WeddingEnvironmentBean>() {
                    @Override
                    public void load(final RemoteListCallback<WeddingEnvironmentBean> remoteCallback) {
                        ApiManager.getWeddingEnvironment(new OnRequestFinish<BaseBean<List<WeddingEnvironmentBean>>>() {
                            @Override
                            public void onFinished() {
                                remoteCallback.onFinished();
                            }

                            @Override
                            public void onSuccess(BaseBean<List<WeddingEnvironmentBean>> data) {
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

    public void getWeddingCaseTypes(final OnCacheRequestFinish<List<CaseTypeEntity>> callback) {
        getCachedList("system_wedding_case_types", "/System/weddingtype_case",
                new TypeToken<List<CaseTypeEntity>>() {}.getType(), callback,
                new RemoteListLoader<CaseTypeEntity>() {
                    @Override
                    public void load(final RemoteListCallback<CaseTypeEntity> remoteCallback) {
                        ApiManager.getWeddingTypes1(new OnRequestSubscribe<BaseBean<List<CaseTypeEntity>>>() {
                            @Override
                            public void onSuccess(BaseBean<List<CaseTypeEntity>> data) {
                                remoteCallback.onSuccess(data == null ? null : data.getData());
                                remoteCallback.onFinished();
                            }

                            @Override
                            public void onError(Exception ex) {
                                remoteCallback.onError(ex);
                                remoteCallback.onFinished();
                            }
                        });
                    }
                });
    }

    public void getWeddingCaseEnvironments(final OnCacheRequestFinish<List<CaseTypeEntity>> callback) {
        getCachedList("system_wedding_case_environments", "/System/weddingenvironment_case",
                new TypeToken<List<CaseTypeEntity>>() {}.getType(), callback,
                new RemoteListLoader<CaseTypeEntity>() {
                    @Override
                    public void load(final RemoteListCallback<CaseTypeEntity> remoteCallback) {
                        ApiManager.getWeddingEnvironment1(new OnRequestSubscribe<BaseBean<List<CaseTypeEntity>>>() {
                            @Override
                            public void onSuccess(BaseBean<List<CaseTypeEntity>> data) {
                                remoteCallback.onSuccess(data == null ? null : data.getData());
                                remoteCallback.onFinished();
                            }

                            @Override
                            public void onError(Exception ex) {
                                remoteCallback.onError(ex);
                                remoteCallback.onFinished();
                            }
                        });
                    }
                });
    }

    private <T> void getCachedList(final String cacheKey, final String apiPath, final Type type,
                                   final OnCacheRequestFinish<List<T>> callback,
                                   final RemoteListLoader<T> loader) {
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
                            requestRemote(cacheKey, apiPath, type, callback, loader, false);
                        }
                        return;
                    }
                }
                requestRemote(cacheKey, apiPath, type, callback, loader, true);
            }
        });
    }

    private <T> void requestRemote(final String cacheKey, final String apiPath, final Type type,
                                   final OnCacheRequestFinish<List<T>> callback,
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
                                        gson.toJson(data, type), null, now + CachePolicy.TTL_DICT, now);
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
