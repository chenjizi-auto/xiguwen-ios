package com.linzi.xiguwen.bean;

/**
 * Created by jiang on 2018/3/5.
 */

public class InvitationUrlBean {

    /**
     * code : 0
     * message : ok
     * url : http://boyiapi.xxwlb.com/invitation/index/defaultbj/userid/76/id/11
     * mid : 11
     */

    private int code;
    private String message;
    private String url;
    private int mid;

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

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public int getMid() {
        return mid;
    }

    public void setMid(int mid) {
        this.mid = mid;
    }
}
