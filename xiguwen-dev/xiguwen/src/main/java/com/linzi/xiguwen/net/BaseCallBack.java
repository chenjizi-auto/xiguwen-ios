package com.linzi.xiguwen.net;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.net.base.ObjectRequestBean;
import com.linzi.xiguwen.utils.NToast;

import org.xutils.common.Callback;

import java.lang.reflect.Type;

/**
 * Title:
 * Description:
 * Copyright:Copyright(c)2018
 * Company: Cree
 * CreateTime:2018/3/22  14:57
 *
 * @author luyongjiang
 * @version 1.0
 */
public class BaseCallBack<T extends BaseBean> implements Callback.CommonCallback<String> {
    private Gson mGson = new Gson();
    private OnRequestSubscribe<T> mOnRequestSubscribe;
    private Type type;

    public BaseCallBack(TypeToken<T> typeToken, OnRequestSubscribe<T> onRequestSubscribe) {
        type = typeToken.getType();
        setSubscribe(onRequestSubscribe);
    }

    public BaseCallBack(TypeToken<T> typeToken, OnRequestFinish<T> onRequestSubscribe) {
        type = typeToken.getType();
        setSubscribe(onRequestSubscribe);
    }


    public BaseCallBack<T> setSubscribe(OnRequestSubscribe<T> onRequestSubscribe) {
        this.mOnRequestSubscribe = onRequestSubscribe;
        return this;
    }


    @Override
    public void onSuccess(String result) {
        ObjectRequestBean typeBean = mGson.fromJson(result, ObjectRequestBean.class);
        //NToast.log("APPTAG", result);
        if (typeBean.getCode() == 0) {
            //请求成功,并且返回的数据也是成功
            mOnRequestSubscribe.onSuccess((T) mGson.fromJson(result, type));
        } else {
            //请求成功,但是返回失败
            mOnRequestSubscribe.onError(new Exception(typeBean.getMessage()));
        }
    }

    @Override
    public void onError(Throwable ex, boolean isOnCallback) {
         //NToast.log("APPTAG", "message:" + ex);
         //NToast.log("APPTAG", "message:" + ex.getMessage());
         //NToast.show(ex.getMessage());
        mOnRequestSubscribe.onError(new Exception(ex.getMessage()));
    }

    @Override
    public void onCancelled(CancelledException cex) {

    }

    @Override
    public void onFinished() {
        if (mOnRequestSubscribe instanceof OnRequestFinish) {
            ((OnRequestFinish) mOnRequestSubscribe).onFinished();
        }
    }


}