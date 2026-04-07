package com.linzi.xiguwen.net;

/**
 * Title:
 * Description:
 * Copyright:Copyright(c)2018
 * Company: Cree
 * CreateTime:2018/3/22  16:43
 *
 * @author luyongjiang
 * @version 1.0
 */
public interface OnRequestSubscribe<T> {
    void onSuccess(T data);

    void onError(Exception ex);

}
