package com.linzi.xiguwen.cache.repository;

import android.content.Context;
import android.os.Handler;
import android.os.Looper;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.linzi.xiguwen.bean.CityData;
import com.linzi.xiguwen.bean.CityEntity;
import com.linzi.xiguwen.cache.CachePolicy;
import com.linzi.xiguwen.cache.OnCacheRequestFinish;
import com.linzi.xiguwen.cache.dao.ApiCacheDao;
import com.linzi.xiguwen.net.OnRequestSubscribe;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;

import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class CityDictionaryRepository {

    private static final String CITY_LIST_CACHE_KEY = "system_city_list";
    private static volatile CityDictionaryRepository sInstance;

    private final ApiCacheDao apiCacheDao;
    private final Gson gson;
    private final ExecutorService ioExecutor;
    private final Handler mainHandler;

    public static CityDictionaryRepository getInstance(Context context) {
        if (sInstance == null) {
            synchronized (CityDictionaryRepository.class) {
                if (sInstance == null) {
                    sInstance = new CityDictionaryRepository(context.getApplicationContext());
                }
            }
        }
        return sInstance;
    }

    private CityDictionaryRepository(Context context) {
        apiCacheDao = new ApiCacheDao(context);
        gson = new Gson();
        ioExecutor = Executors.newSingleThreadExecutor();
        mainHandler = new Handler(Looper.getMainLooper());
    }

    public void getCityList(final OnCacheRequestFinish<CityData> callback) {
        getCachedObject(CITY_LIST_CACHE_KEY, "/System/city", new TypeToken<CityData>() {}.getType(),
                CachePolicy.TTL_DICT, callback, new RemoteObjectLoader<CityData>() {
                    @Override
                    public void load(final RemoteObjectCallback<CityData> remoteCallback) {
                        ApiManager.cityList(new OnRequestSubscribe<BaseBean<CityData>>() {
                            @Override
                            public void onSuccess(BaseBean<CityData> data) {
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

    public void getAreas(final int cityId, final OnCacheRequestFinish<ArrayList<CityEntity>> callback) {
        getCachedObject("system_city_areas_" + cityId, "/System/getCity",
                new TypeToken<ArrayList<CityEntity>>() {}.getType(), CachePolicy.TTL_DICT, callback,
                new RemoteObjectLoader<ArrayList<CityEntity>>() {
                    @Override
                    public void load(final RemoteObjectCallback<ArrayList<CityEntity>> remoteCallback) {
                        ApiManager.getCiteListeNew(String.valueOf(cityId), new OnRequestSubscribe<BaseBean<ArrayList<CityEntity>>>() {
                            @Override
                            public void onSuccess(BaseBean<ArrayList<CityEntity>> data) {
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

    public void getCityIdByName(final String cityName, final OnCacheRequestFinish<CityEntity> callback) {
        getCachedObject("system_city_id_" + cityName, "/System/getCityId",
                new TypeToken<CityEntity>() {}.getType(), CachePolicy.TTL_DICT, callback,
                new RemoteObjectLoader<CityEntity>() {
                    @Override
                    public void load(final RemoteObjectCallback<CityEntity> remoteCallback) {
                        ApiManager.getCityIdNew(cityName, new OnRequestSubscribe<BaseBean<CityEntity>>() {
                            @Override
                            public void onSuccess(BaseBean<CityEntity> data) {
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

    private <T> void getCachedObject(final String cacheKey, final String apiPath, final Type type,
                                     final long ttl, final OnCacheRequestFinish<T> callback,
                                     final RemoteObjectLoader<T> loader) {
        ioExecutor.execute(new Runnable() {
            @Override
            public void run() {
                ApiCacheDao.CacheRecord record = apiCacheDao.get(cacheKey);
                if (record != null && record.dataJson != null && record.dataJson.length() > 0) {
                    final T localData = gson.fromJson(record.dataJson, type);
                    if (localData != null) {
                        postSuccess(callback, localData, true);
                        postFinished(callback);
                        if (apiCacheDao.isExpired(record)) {
                            requestRemote(cacheKey, apiPath, type, ttl, callback, loader, false);
                        }
                        return;
                    }
                }
                requestRemote(cacheKey, apiPath, type, ttl, callback, loader, true);
            }
        });
    }

    private <T> void requestRemote(final String cacheKey, final String apiPath, final Type type,
                                   final long ttl, final OnCacheRequestFinish<T> callback,
                                   final RemoteObjectLoader<T> loader, final boolean callbackResult) {
        loader.load(new RemoteObjectCallback<T>() {
            @Override
            public void onSuccess(final T data) {
                if (data != null) {
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

    private <T> void postSuccess(final OnCacheRequestFinish<T> callback, final T data, final boolean fromCache) {
        mainHandler.post(new Runnable() {
            @Override
            public void run() {
                callback.onSuccess(data, fromCache);
            }
        });
    }

    private <T> void postError(final OnCacheRequestFinish<T> callback, final Exception ex) {
        mainHandler.post(new Runnable() {
            @Override
            public void run() {
                callback.onError(ex);
            }
        });
    }

    private <T> void postFinished(final OnCacheRequestFinish<T> callback) {
        mainHandler.post(new Runnable() {
            @Override
            public void run() {
                callback.onFinished();
            }
        });
    }

    private interface RemoteObjectLoader<T> {
        void load(RemoteObjectCallback<T> remoteCallback);
    }

    private interface RemoteObjectCallback<T> {
        void onSuccess(T data);

        void onError(Exception ex);

        void onFinished();
    }
}
