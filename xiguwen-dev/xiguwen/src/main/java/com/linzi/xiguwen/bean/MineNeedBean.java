package com.linzi.xiguwen.bean;

import java.io.Serializable;

/**
 * Created by PC on 2018-04-09.
 * 我的需求列表
 */

public class MineNeedBean implements Serializable{
    public static final int STATUS_ALL = 0;
    public static final int STATUS_HAND = 1;// 进行中
    public static final int STATUS_END = 2;// 已结束

    public static final int TYPE_HUNQING = 1;       // 婚庆
    public static final int TYPE_SHANGCHENG = 2;    // 商城

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
    private String dizhi;           // 地址，查看需求专有。
    private String details;         // 需求详情
    private String address;         // 地址
    private String mobile;          // 电话
    private int openmessage;        // 是否公开聊天
    private int openphone;          // 是否公开电话
    private String provinceid;
    private String cityid;
    private String countyid;

    private int userid;             // 查看需求：发布人id
    private int jiedan;             // 查看需求：当前用户是否已经接单

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

    public long getCountdown() {
        return countdown;
    }

    public void setCountdown(long countdown) {
        this.countdown = countdown;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public String getDizhi() {
        return dizhi;
    }

    public void setDizhi(String dizhi) {
        this.dizhi = dizhi;
    }

    public String getDetails() {
        return details;
    }

    public void setDetails(String details) {
        this.details = details;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public int getOpenmessage() {
        return openmessage;
    }

    public void setOpenmessage(int openmessage) {
        this.openmessage = openmessage;
    }

    public int getOpenphone() {
        return openphone;
    }

    public void setOpenphone(int openphone) {
        this.openphone = openphone;
    }

    public String getProvinceid() {
        return provinceid;
    }

    public void setProvinceid(String provinceid) {
        this.provinceid = provinceid;
    }

    public String getCityid() {
        return cityid;
    }

    public void setCityid(String cityid) {
        this.cityid = cityid;
    }

    public String getCountyid() {
        return countyid;
    }

    public void setCountyid(String countyid) {
        this.countyid = countyid;
    }

    public boolean isOpenMessage(){
        return getOpenmessage() == 1;
    }

    public boolean isOpenPhone(){
        return getOpenphone() == 1;
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }

    public int getJiedan() {
        return jiedan;
    }

    public void setJiedan(int jiedan) {
        this.jiedan = jiedan;
    }

    public boolean isJieDan(){
        return getJiedan() == 1;
    }

    public String getTypeString(){
        switch (getType()){
            case TYPE_HUNQING:
                return "[婚庆] ";
            case TYPE_SHANGCHENG:
                return "[商城] ";
        }
        return "";
    }
}
