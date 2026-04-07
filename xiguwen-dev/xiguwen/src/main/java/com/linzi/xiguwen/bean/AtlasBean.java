package com.linzi.xiguwen.bean;

import java.io.Serializable;

/**
 * Created by PC on 2018-03-27.
 * 我的图册类
 */

public class AtlasBean extends BaseStatusBean implements Serializable {

    /**
     * {
　　　　　　"update_ti":1,
　　　　　　"clicked":1,
　　　　　　"cover":"http://boyiapi.xxwlb.com/uploads/20180127/7510165ad8a7c318cfa888b89ba6c505.jpg",
　　　　　　"create_ti":1517042288,
　　　　　　"examinetime":1517043006,
　　　　　　"followed":0,
　　　　　　"id":19,
　　　　　　"name":"测试图册",
　　　　　　"putaway":0,
　　　　　　"statecontent":"审核通过",
　　　　　　"status":2,
　　　　　　"synopsis":"123",
　　　　　　"userid":16,
　　　　　　"username":"18581882801",
　　　　　　"weight":3
 　　　　}
     */
//    /*审核中*/
//    public static final int STATUS_ON = 1 ;//
//    /*审核通过*/
//    public static final int STATUS_PASS = 2;
//    /*审核未通过*/
//    public static final int STATUS_UNPASS = 3;
//    /*未提交*/
//    public static final int STATUS_NO_SUBMIT = 0;

    private int update_ti;
    private int clicked;
    private String cover; // 封面地址
    private long create_ti; // 创建时间戳
    private long examinetime; //
    private int follwed;
    private int id;
    private String name; // 名称
    private int putaway;
    private String statecontent; // 审核状态文字描述
    private int status; // 审核状态  1审核中 2通过 3未通过 0未提交
    private String synopsis;    // 图册简介
    private int userid;
    private String username;
    private int weight;

    public int getUpdate_ti() {
        return update_ti;
    }

    public void setUpdate_ti(int update_ti) {
        this.update_ti = update_ti;
    }

    public int getClicked() {
        return clicked;
    }

    public void setClicked(int clicked) {
        this.clicked = clicked;
    }

    public String getCover() {
        return cover;
    }

    public void setCover(String cover) {
        this.cover = cover;
    }

    public long getCreate_ti() {
        return create_ti;
    }

    public void setCreate_ti(long create_ti) {
        this.create_ti = create_ti;
    }

    public long getExaminetime() {
        return examinetime;
    }

    public void setExaminetime(long examinetime) {
        this.examinetime = examinetime;
    }

    public int getFollwed() {
        return follwed;
    }

    public void setFollwed(int follwed) {
        this.follwed = follwed;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getPutaway() {
        return putaway;
    }

    public void setPutaway(int putaway) {
        this.putaway = putaway;
    }

    public String getStatecontent() {
        return statecontent;
    }

    public void setStatecontent(String statecontent) {
        this.statecontent = statecontent;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getSynopsis() {
        return synopsis;
    }

    public void setSynopsis(String synopsis) {
        this.synopsis = synopsis;
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public int getWeight() {
        return weight;
    }

    public void setWeight(int weight) {
        this.weight = weight;
    }

    @Override
    public int getMyStatus() {
        return getPutaway();
    }

    @Override
    public int getMyState() {
        return getStatus();
    }

    @Override
    public String getMyTitle() {
        return getName();
    }

    @Override
    public String getMyContent() {
        return getSynopsis();
    }

    @Override
    public String getMyCover() {
        return getCover();
    }
}

