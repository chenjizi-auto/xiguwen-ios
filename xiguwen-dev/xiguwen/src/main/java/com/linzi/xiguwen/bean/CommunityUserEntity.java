package com.linzi.xiguwen.bean;

import java.io.Serializable;

/**
 * Created by PC on 2018-04-21.
 */

public class CommunityUserEntity implements Serializable {
//       "id": 19,
//               "uid": 8,
//               "userid": 16,
//               "username": "18581882801",
//               "create_ti": 1515391982,
//               "status": 1,
//               "jiaose": 1,
//               "sort": null,
//               "head": "http://imgcache.boyihunjia.com/706e6201804201902447326.jpg",
//               "nickname": "杜卡基老师",
//               "occupationid": "主持人",
//               "dizhi": "四川省成都市"

    private String id;
    private String uid;
    private int userid;
    private String username;
    private String create_ti;
    private String status;
    private int jiaose;
    private String sort;
    private String head;
    private String nickname;
    private String occupationid;
    private String dizhi;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
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

    public String getCreate_ti() {
        return create_ti;
    }

    public void setCreate_ti(String create_ti) {
        this.create_ti = create_ti;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getJiaose() {
        return jiaose;
    }

    public void setJiaose(int jiaose) {
        this.jiaose = jiaose;
    }

    public String getSort() {
        return sort;
    }

    public void setSort(String sort) {
        this.sort = sort;
    }

    public String getHead() {
        return head;
    }

    public void setHead(String head) {
        this.head = head;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getOccupationid() {
        return occupationid;
    }

    public void setOccupationid(String occupationid) {
        this.occupationid = occupationid;
    }

    public String getDizhi() {
        return dizhi;
    }

    public void setDizhi(String dizhi) {
        this.dizhi = dizhi;
    }
}
