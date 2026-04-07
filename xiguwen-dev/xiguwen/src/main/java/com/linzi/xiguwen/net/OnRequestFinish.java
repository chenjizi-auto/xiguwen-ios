package com.linzi.xiguwen.net;

/**
 * Title:
 * Description:
 * Copyright:Copyright(c)2018
 * Company: Cree
 * CreateTime:2018/3/23  11:00
 *
 * @author luyongjiang
 * @version 1.0
 */
public interface OnRequestFinish<T> extends OnRequestSubscribe<T> {
    void onFinished();
}
