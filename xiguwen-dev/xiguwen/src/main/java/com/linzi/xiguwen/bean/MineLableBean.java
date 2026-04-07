package com.linzi.xiguwen.bean;

import java.io.Serializable;

/**
 * Created by jiang on 2018/2/2.
 */

public class MineLableBean implements Serializable {
    private int id;
    private String title;
    private int url;
    private int uri;

    public int getUri() {
        return uri;
    }

    public MineLableBean setUri(int uri) {
        this.uri = uri;
        return this;
    }

    public int getId() {
        return id;
    }

    public MineLableBean setId(int id) {
        this.id = id;
        return this;
    }

    public String getTitle() {
        return title;
    }

    public MineLableBean setTitle(String title) {
        this.title = title;
        return this;
    }

    public int getUrl() {
        return url;
    }

    public MineLableBean setUrl(int url) {
        this.url = url;
        return this;
    }
}
