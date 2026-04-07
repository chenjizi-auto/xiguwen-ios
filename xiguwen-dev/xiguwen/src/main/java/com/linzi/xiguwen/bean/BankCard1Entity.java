package com.linzi.xiguwen.bean;

import java.io.Serializable;

/**
 * Created by devin on 2018/4/16 16:53
 * Description
 */

public class BankCard1Entity extends BaseBean implements Serializable {

    private String bankcard;
    private String blank;
    private String name;
    private String mobele;
    private String site;
    private String verifyCode;

    public String getMobele() {
        return mobele;
    }

    public void setMobele(String mobele) {
        this.mobele = mobele;
    }

    public String getSite() {
        return site;
    }

    public void setSite(String site) {
        this.site = site;
    }

    public String getVerifyCode() {
        return verifyCode;
    }

    public void setVerifyCode(String verifyCode) {
        this.verifyCode = verifyCode;
    }

    public String getBankcard() {
        return bankcard;
    }

    public void setBankcard(String bankcard) {
        this.bankcard = bankcard;
    }

    public String getBlank() {
        return blank;
    }

    public void setBlank(String blank) {
        this.blank = blank;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
