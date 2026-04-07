package com.linzi.xiguwen.bean;

import java.io.Serializable;

/**
 * Created by PC on 2018-04-08.
 * 请柬模板类型
 */

public class InvitationsTemplateTypeBean implements Serializable{
    /**
     *  {
     "create": 151,
     "id": 1,
     "status": 1,
     "title": "测试1",
     "weight": 1
     }
     */
    private long create;
    private int id;
    private int status;
    private String title;
    private int weight;

    public long getCreate() {
        return create;
    }

    public void setCreate(long create) {
        this.create = create;
    }

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

    public int getWeight() {
        return weight;
    }

    public void setWeight(int weight) {
        this.weight = weight;
    }
}
