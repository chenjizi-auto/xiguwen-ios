package com.linzi.xiguwen.bean;

import java.io.Serializable;

/**
 * Created by PC on 2018-04-09.
 * 我的需求列表
 */

public class OtherNeedBean implements Serializable{
    public static final int TYPE_ALL = 0;
    public static final int TYPE_HAND = 1;// 进行中
    public static final int TYPE_END = 2;// 已结束

    /**
     *  {
     　　　　　　"type":2,
     　　　　　　"id":66,
     　　　　　　"status":2,
     　　　　　　"title":"fgsdfgds",
     　　　　　　"create_ti":"2018-04-08 17:27:35",
     　　　　　　"browsingvolume":21,
     　　　　　　"price":23,
     　　　　　　"openphone":1,
     　　　　　　"openmessage":0,
     　　　　　　"provinceid":null,
     　　　　　　"cityid":null,
     　　　　　　"countyid":null,
     　　　　　　"details":"fafdasfds",
     　　　　　　"address":"123",
     　　　　　　"remainingtime":"2018-04-10 17:27:35",
     　　　　　　"countdown":0,
     　　　　　　"renshu":0,
     　　　　　　"mobile":"18581882801"
     　　　　}
     */

    private int id;
    private int status;             // 需求状态 1进行之中，2已结束
    private long browsingvolume;    // 浏览量
    private String create_ti;       // 创建时间
    private float price;            // 价格
    private String remainingtime;   //到期时间
    private int renshu;             // 参与人数
    private String title;           // 标题
    private long countdown;         // 倒计时
    private int type;               //类型： 1.婚庆  2.商城

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

    public long getBrowsingvolume() {
        return browsingvolume;
    }

    public void setBrowsingvolume(long browsingvolume) {
        this.browsingvolume = browsingvolume;
    }

    public String getCreate_ti() {
        return create_ti;
    }

    public void setCreate_ti(String create_ti) {
        this.create_ti = create_ti;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public String getRemainingtime() {
        return remainingtime;
    }

    public void setRemainingtime(String remainingtime) {
        this.remainingtime = remainingtime;
    }

    public int getRenshu() {
        return renshu;
    }

    public void setRenshu(int renshu) {
        this.renshu = renshu;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
}
