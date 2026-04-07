package com.linzi.xiguwen.bean;

import java.io.Serializable;

/**
 * Created by PC on 2018-04-21.
 */

public class ShareEntity implements Serializable {
    private String url;
    private String erweima;

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getErweima() {
        return erweima;
    }

    public void setErweima(String erweima) {
        this.erweima = erweima;
    }
}
