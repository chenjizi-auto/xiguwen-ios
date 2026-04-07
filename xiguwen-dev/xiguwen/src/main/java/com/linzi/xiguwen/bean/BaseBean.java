package com.linzi.xiguwen.bean;

/**
 * Created by jiang on 2018/1/31.
 */

public class BaseBean {
    /**
     * code : 10002
     * message : 该手机号码已注册
     */

    private int code;
    private String message;
    private String data;

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }

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
}
