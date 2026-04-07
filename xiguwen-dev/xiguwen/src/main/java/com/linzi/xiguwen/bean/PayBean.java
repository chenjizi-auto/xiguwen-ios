package com.linzi.xiguwen.bean;

import com.google.gson.annotations.SerializedName;

/**
 * Created by pc on 2018/4/15.
 */

public class PayBean {


    /**
     * appId : wx9d4329a0f1007c7c
     * nonceStr : QUo0bpLQq4r7CcYXbKqAZOitx8L3Sjm7
     * package : Sign=WXPay
     * partnerId : 1501404821
     * prepayId : wx152002330184151983eeee513771747574
     * timeStamp : 1523793753
     * sign : FBEB148B7E45D5F6A580D5757DBE20C7
     */

    private String appid;
    private String noncestr;
    private String packageX;
    private String partnerid;
    private String prepayid;
    private String timestamp;
    private String sign;
    private String data;

    public String getAppid() {
        return appid;
    }

    public void setAppid(String appid) {
        this.appid = appid;
    }

    public String getNoncestr() {
        return noncestr;
    }

    public void setNoncestr(String noncestr) {
        this.noncestr = noncestr;
    }

    public String getPartnerid() {
        return partnerid;
    }

    public void setPartnerid(String partnerid) {
        this.partnerid = partnerid;
    }

    public String getPrepayid() {
        return prepayid;
    }

    public void setPrepayid(String prepayid) {
        this.prepayid = prepayid;
    }

    public String getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }

    public String getPackageX() {
        return packageX;
    }

    public void setPackageX(String packageX) {
        this.packageX = packageX;
    }

    public String getSign() {
        return sign;
    }

    public void setSign(String sign) {
        this.sign = sign;
    }
}
