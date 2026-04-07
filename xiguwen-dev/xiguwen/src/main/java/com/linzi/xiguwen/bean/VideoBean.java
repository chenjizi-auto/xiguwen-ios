package com.linzi.xiguwen.bean;

import java.io.Serializable;

/**
 * Created by PC on 2018-03-28.
 */

public class VideoBean extends BaseStatusBean implements Serializable {
    /**
     * {
     　　　　　　"clicked":1,
     　　　　　　"cover":"http://boyiapi.xxwlb.com/uploads/20180113/5229607970220083eb377d6ade285d3c.jpg",
     　　　　　　"create_ti":1515817157,
     　　　　　　"examinetime":"2018-01-22 19:16:49",
     　　　　　　"followed":0,
     　　　　　　"id":7,
     　　　　　　"putaway":0,
     　　　　　　"statecontent":"审核通过",
     　　　　　　"status":2,
     　　　　　　"title":"123",
     　　　　　　"titlea":"123...",
     　　　　　　"update_ti":1515844603,
     　　　　　　"userid":16,
     　　　　　　"username":"18581882801",
     　　　　　　"video_url":"http://boyiapi.xxwlb.com/Index/admin/video/20180113/7cb9be486d85065d9106079eba2488f5.mp4",
     　　　　　　"video_urla":"http://boyiapi.xxwlb.com/Index/admin/video/2...",
     　　　　　　"weigh":12
     　　　　}
     */
    //审核状态1审核中 2通过 3未通过

    private int clicked;
    private String cover;
    private long create_ti;
    private String examinetime;
    private int followed;
    private int id;
    private int putaway;
    private String statecontent;
    private int status;
    private String title;
    private String titlea;
    private long update_ti;
    private int userid;
    private String username;
    private String video_url;
    private int weigh;

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

    public String getExaminetime() {
        return examinetime;
    }

    public void setExaminetime(String examinetime) {
        this.examinetime = examinetime;
    }

    public int getFollowed() {
        return followed;
    }

    public void setFollowed(int followed) {
        this.followed = followed;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
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

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getTitlea() {
        return titlea;
    }

    public void setTitlea(String titlea) {
        this.titlea = titlea;
    }

    public long getUpdate_ti() {
        return update_ti;
    }

    public void setUpdate_ti(long update_ti) {
        this.update_ti = update_ti;
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

    public String getVideo_url() {
        return video_url;
    }

    public void setVideo_url(String video_url) {
        this.video_url = video_url;
    }

    public int getWeigh() {
        return weigh;
    }

    public void setWeigh(int weigh) {
        this.weigh = weigh;
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
        return getTitle();
    }

    @Override
    public String getMyContent() {
        return getTitle();
    }

    @Override
    public String getMyCover() {
        return getCover();
    }
}
