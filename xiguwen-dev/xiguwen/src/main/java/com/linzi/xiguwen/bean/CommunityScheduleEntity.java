package com.linzi.xiguwen.bean;

import java.io.Serializable;

/**
 * Created by PC on 2018-04-21.
 */

public class CommunityScheduleEntity implements Serializable {
//        "head": "http://imgcache.boyihunjia.com/be416201804181239587757.jpg",
//                "occupationid": "婚宴酒店",
//                "userid": 1121,
//                "nickname": "芸芸老师",
//                "usertype": 2,
//                "zuidijia": "0.10"

    private String head;
    private String occupationid;
    private int userid;
    private String nickname;
    private String usertype;
    private String zuidijia;

    public String getHead() {
        return head;
    }

    public void setHead(String head) {
        this.head = head;
    }

    public String getOccupationid() {
        return occupationid;
    }

    public void setOccupationid(String occupationid) {
        this.occupationid = occupationid;
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getUsertype() {
        return usertype;
    }

    public void setUsertype(String usertype) {
        this.usertype = usertype;
    }

    public String getZuidijia() {
        return zuidijia;
    }

    public void setZuidijia(String zuidijia) {
        this.zuidijia = zuidijia;
    }
}
