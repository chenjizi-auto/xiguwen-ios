package com.linzi.xiguwen.bean;

import java.io.Serializable;

/**
 * Created by PC on 2018-04-21.
 */

public class CommuntiyInvitationEntity implements Serializable {
//      "head": "http://imgcache.boyihunjia.com/a7d33201803121826421369.jpg",
//              "nickname": "成都墨家影视文化传播",
//              "mobile": "18080861808",
//              "occupationid": "摄像师",
//              "userid": 540

    private String head;
    private String nickname;
    private String mobile;
    private String occupationid;
    private String userid;

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

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getOccupationid() {
        return occupationid;
    }

    public void setOccupationid(String occupationid) {
        this.occupationid = occupationid;
    }

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }
}
