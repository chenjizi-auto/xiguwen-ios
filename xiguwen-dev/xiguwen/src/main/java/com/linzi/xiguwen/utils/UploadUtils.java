package com.linzi.xiguwen.utils;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.linzi.xiguwen.net.OkHttpRequest;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.Constans;

import org.xutils.common.Callback;
import org.xutils.http.RequestParams;

import java.io.File;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * Created by PC on 2018-03-28.
 */

public class UploadUtils<T> implements Callback.Cancelable {
    private Callback.Cancelable cancelable;
    private Gson mGson;
    private String mUrl;
    private String key;
    private List<String> paths;
    private OnUploadListener mListener;
    private Class<T> classType;

    public UploadUtils(String url, String key, List<String> paths, Class<T> clasType, OnUploadListener<T> mListener){
        mGson = new Gson();
        this.mUrl = url;
        this.key = key;
        this.paths = paths;
        this.mListener = mListener;
        this.classType = clasType;
    }

//    public static void uploadFiles(String key, List<File> file, String url, OnUploadListener listener){
//        //TODO
//    }
//
//    public static void uploadFile(String key, File file, String url, OnUploadListener listener){
//        //TODO
//    }
//
//    public static void uploadImgBase64(String key, String filePath, String url, OnUploadListener listener){
//
//
//    }

    public Callback.Cancelable uploadImgBase64s(){
        uploadImgBase64s(paths.size(), 1);
        return this;
    }

    /**
     * 取消任务
     */
    public void cancel(){
        if(cancelable != null){
            cancelable.cancel();
        }
    }

    /**
     * 是否已经取消
     * @return
     */
    @Override
    public boolean isCancelled() {
        if(cancelable != null){
            return cancelable.isCancelled();
        }
        return true;
    }

    private void uploadImgBase64s(final int count, final int current){
        RequestParams entity = new RequestParams(mUrl);
        String uploadFile = paths.get(current - 1);
        String imgBase64Code = Img2Base64Util.getMimeTypeHead(uploadFile) + Img2Base64Util.getImgStr(uploadFile);
        entity.addBodyParameter(key, imgBase64Code);
        if(mListener != null){
            mListener.onItemStart(count, current);
        }
        this.cancelable = OkHttpRequest.post(entity, new Callback.CommonCallback<String>() {
            boolean success;
            @Override
            public void onSuccess(String result) {
                // 仅仅是请求成功，也有可能上传失败
                com.linzi.xiguwen.bean.BaseBean tBaseBean = mGson.fromJson(result, com.linzi.xiguwen.bean.BaseBean.class);
                if(mListener != null){
                    if(tBaseBean.getCode() == 0){
                        success = true;
                        T t;
                        if(classType != String.class){
                            t = mGson.fromJson(tBaseBean.getData(), classType);
                        }else{
                            t = (T)tBaseBean.getData();
                        }
                        BaseBean<T> bean = new BaseBean<>();
                        bean.setCode(tBaseBean.getCode());
                        bean.setMessage(tBaseBean.getMessage());
                        bean.setData(t);
                        mListener.onItemSuccess(count, current, bean);
                    }else{
                        success = false;
                        mListener.onErr(count, current, new Throwable(tBaseBean.getMessage()));
                    }
                }
            }

            @Override
            public void onError(Throwable ex, boolean isOnCallback) {
                success = false;
                if(mListener != null){
                    mListener.onErr(count, current, ex);
                }
            }

            @Override
            public void onCancelled(CancelledException cex) {
                success = false;
                if(mListener != null){
                    mListener.onCancel();
                }
            }

            @Override
            public void onFinished() {
                if(count == current){
                    if(mListener != null){
                        mListener.onAllFinish();
                    }
                }
                if(count > current && success){
                    uploadImgBase64s( count, current + 1);
                }
            }
        });
//        this.cancelable = OkHttpRequest.post(entity, new Callback.ProgressCallback<String>() {
//            boolean success;
//            @Override
//            public void onSuccess(String result) {
//                // 仅仅是请求成功，也有可能上传失败
//                com.linzi.bytc_new.bean.BaseBean tBaseBean = mGson.fromJson(result, com.linzi.bytc_new.bean.BaseBean.class);
//                if(listener != null){
//                    if(tBaseBean.getCode() == 0){
//                        success = true;
//                        T t;
//                        if(clasType != String.class){
//                            t = mGson.fromJson(tBaseBean.getData(), clasType);
//                        }else{
//                            t = (T)tBaseBean.getData();
//                        }
//                        BaseBean<T> bean = new BaseBean<>();
//                        bean.setCode(tBaseBean.getCode());
//                        bean.setMessage(tBaseBean.getMessage());
//                        bean.setData(t);
//                        listener.onItemSuccess(count, current, bean);
//                    }else{
//                        success = false;
//                        listener.onErr(count, current, new Throwable(tBaseBean.getMessage()));
//                    }
//                }
//            }
//
//            @Override
//            public void onError(Throwable ex, boolean isOnCallback) {
//                success = false;
//                if(listener != null){
//                    listener.onErr(count, current, ex);
//                }
//            }
//
//            @Override
//            public void onCancelled(CancelledException cex) {
//                success = false;
//                if(listener != null){
//                    listener.onCancel();
//                }
//            }
//
//            @Override
//            public void onFinished() {
//                if(count == current){
//                    if(listener != null){
//                        listener.onAllFinish();
//                    }
//                }
//                if(count > current && success){
//                    uploadImgBase64s(url, key, filePaths, count, current + 1, clasType, listener);
//                }
//            }
//
//            @Override
//            public void onWaiting() {
//
//            }
//
//            @Override
//            public void onStarted() {
//                if(listener != null){
//                    listener.onItemStart(count, current);
//                }
//            }
//
//            @Override
//            public void onLoading(long total, long c, boolean isDownloading) {
//                if(listener != null){
//                    listener.onProgress(count, current, (total * 1.0f) / (c * 1.0f));
//                }
//            }
//        });
    }

    public static interface OnUploadListener<T>{
        void onItemStart(int count ,int current);

        /**
         * 上传失败的回调
         * @param count
         * @param current
         * @param ex
         */
        void onErr(int count, int current, Throwable ex);

        /**
         * 上传完成的回调
         * @param count
         */
        void onItemSuccess(int count, int current, BaseBean<T> t);

        /**
         * 所有文件上传完成的回调
         */
        void onAllFinish();

        /**
         * 上次取消的回调
         */
        void onCancel();
    }
}
