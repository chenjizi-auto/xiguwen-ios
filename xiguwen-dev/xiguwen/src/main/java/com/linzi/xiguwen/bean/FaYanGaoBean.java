package com.linzi.xiguwen.bean;

import java.io.Serializable;

/**
 * Created by PC on 2018-03-31.
 */

public class FaYanGaoBean implements Serializable{
    /**
     *  {
     "content": "斯蒂芬沙发撒旦法vxzcvzwedf务实合作典范",
     "creater": 1517393634,
     "id": 1,
     "title": "默认1",
     "userid": 16
     }
     */
    private String content;
    private long creater;
    private int id;
    private String title;
    private long userid;

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public long getCreater() {
        return creater;
    }

    public void setCreater(long creater) {
        this.creater = creater;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public long getUserid() {
        return userid;
    }

    public void setUserid(long userid) {
        this.userid = userid;
    }
}
