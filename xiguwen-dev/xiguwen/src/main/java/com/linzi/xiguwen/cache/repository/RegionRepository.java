package com.linzi.xiguwen.cache.repository;

import android.content.Context;
import android.os.Handler;
import android.os.Looper;

import com.linzi.xiguwen.bean.ProvinceBean;
import com.linzi.xiguwen.cache.CachePolicy;
import com.linzi.xiguwen.cache.OnCacheRequestFinish;
import com.linzi.xiguwen.cache.dao.ApiCacheDao;
import com.linzi.xiguwen.cache.dao.RegionDao;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;

import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class RegionRepository {

    private static final String REGION_CACHE_KEY = "system_huoqudiqu";
    private static volatile RegionRepository sInstance;

    private final RegionDao regionDao;
    private final ApiCacheDao apiCacheDao;
    private final ExecutorService ioExecutor;
    private final Handler mainHandler;

    private volatile List<ProvinceBean> memoryCache;

    public static RegionRepository getInstance(Context context) {
        if (sInstance == null) {
            synchronized (RegionRepository.class) {
                if (sInstance == null) {
                    sInstance = new RegionRepository(context.getApplicationContext());
                }
            }
        }
        return sInstance;
    }

    private RegionRepository(Context context) {
        regionDao = new RegionDao(context);
        apiCacheDao = new ApiCacheDao(context);
        ioExecutor = Executors.newSingleThreadExecutor();
        mainHandler = new Handler(Looper.getMainLooper());
    }

    public void getRegions(final OnCacheRequestFinish<List<ProvinceBean>> callback) {
        if (memoryCache != null && !memoryCache.isEmpty()) {
            callback.onSuccess(memoryCache, true);
            callback.onFinished();
            return;
        }

        ioExecutor.execute(new Runnable() {
            @Override
            public void run() {
                List<ProvinceBean> localData = regionDao.getAllProvinceTree();
                ApiCacheDao.CacheRecord record = apiCacheDao.get(REGION_CACHE_KEY);
                if (localData != null && !localData.isEmpty()) {
                    memoryCache = localData;
                    postSuccess(callback, localData, true);
                    postFinished(callback);
                    if (apiCacheDao.isExpired(record)) {
                        refreshInBackground();
                    }
                    return;
                }
                requestRemote(callback);
            }
        });
    }

    public void refreshInBackground() {
        requestRemote(null);
    }

    public void forceRefresh(final OnCacheRequestFinish<List<ProvinceBean>> callback) {
        requestRemote(callback);
    }

    private void requestRemote(final OnCacheRequestFinish<List<ProvinceBean>> callback) {
        ApiManager.getProvinces(new OnRequestFinish<BaseBean<List<ProvinceBean>>>() {
            @Override
            public void onFinished() {
                if (callback != null) {
                    callback.onFinished();
                }
            }

            @Override
            public void onSuccess(BaseBean<List<ProvinceBean>> data) {
                final List<ProvinceBean> result = data == null ? null : data.getData();
                if (result != null && !result.isEmpty()) {
                    memoryCache = result;
                    ioExecutor.execute(new Runnable() {
                        @Override
                        public void run() {
                            try {
                                regionDao.replaceAll(result);
                                long now = System.currentTimeMillis();
                                apiCacheDao.save(REGION_CACHE_KEY, "/System/huoqudiqu", "", "0",
                                        "1", null, now + CachePolicy.TTL_REGION, now);
                            } catch (Exception ignored) {
                            }
                        }
                    });
                }

                if (callback != null) {
                    callback.onSuccess(result, false);
                }
            }

            @Override
            public void onError(final Exception ex) {
                if (callback == null) {
                    return;
                }

                ioExecutor.execute(new Runnable() {
                    @Override
                    public void run() {
                        List<ProvinceBean> localData = regionDao.getAllProvinceTree();
                        if (localData != null && !localData.isEmpty()) {
                            memoryCache = localData;
                            postSuccess(callback, localData, true);
                        } else {
                            postError(callback, ex);
                        }
                    }
                });
            }
        });
    }

    private void postSuccess(final OnCacheRequestFinish<List<ProvinceBean>> callback,
                             final List<ProvinceBean> data, final boolean fromCache) {
        mainHandler.post(new Runnable() {
            @Override
            public void run() {
                callback.onSuccess(data, fromCache);
            }
        });
    }

    private void postError(final OnCacheRequestFinish<List<ProvinceBean>> callback, final Exception ex) {
        mainHandler.post(new Runnable() {
            @Override
            public void run() {
                callback.onError(ex);
            }
        });
    }

    private void postFinished(final OnCacheRequestFinish<List<ProvinceBean>> callback) {
        mainHandler.post(new Runnable() {
            @Override
            public void run() {
                callback.onFinished();
            }
        });
    }

}
