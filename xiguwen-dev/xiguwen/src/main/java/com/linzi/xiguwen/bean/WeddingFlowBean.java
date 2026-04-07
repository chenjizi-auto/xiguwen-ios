package com.linzi.xiguwen.bean;

import java.io.Serializable;

/**
 * Created by PC on 2018-04-03.
 */

public class WeddingFlowBean implements Serializable {
    /**
     *  {
     "creater": 1,
     "id": 1,
     "renyuan": "得粉身碎骨",
     "shijian": "14：25",
     "shixiang": "的风格色调",
     "title": "阿飞",
     "userid": 16
     }
     */

    private int creater;
    private int id;
    private String renyuan;     // 人员
    private String shijian;     // 时间
    private String shixiang;    // 事项
    private String title;       // 标题
    private long userid;

    public int getCreater() {
        return creater;
    }

    public void setCreater(int creater) {
        this.creater = creater;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getRenyuan() {
        return renyuan;
    }

    public void setRenyuan(String renyuan) {
        this.renyuan = renyuan;
    }

    public String getShijian() {
        return shijian;
    }

    public void setShijian(String shijian) {
        this.shijian = shijian;
    }

    public String getShixiang() {
        return shixiang;
    }

    public void setShixiang(String shixiang) {
        this.shixiang = shixiang;
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
