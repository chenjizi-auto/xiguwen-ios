package com.linzi.xiguwen.bean;

/**
 * Created by PC on 2018-03-30.
 * 婚礼环境表
 */

public class WeddingEnvironmentBean {
    /**
     * {
     "id": 1,
     "status": 1,
     "title": "教堂",
     "weigh": 60
     }
     */

    private int id;
    private int status;
    private String title;
    private int weigh;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getWeigh() {
        return weigh;
    }

    public void setWeigh(int weigh) {
        this.weigh = weigh;
    }
}
