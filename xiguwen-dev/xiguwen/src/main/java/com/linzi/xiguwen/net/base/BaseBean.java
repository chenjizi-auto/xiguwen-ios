package com.linzi.xiguwen.net.base;

/**
 * Title:
 * Description: 请求对象基类
 * Copyright:Copyright(c)2018
 * Company: Cree
 * CreateTime:2018/3/22  15:00
 *
 * @author luyongjiang
 * @version 1.0
 */

public class BaseBean<T> {
    private int code;
    private String message;
    private T data;

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }
}

