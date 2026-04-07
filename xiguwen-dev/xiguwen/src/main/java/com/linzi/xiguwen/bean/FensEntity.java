package com.linzi.xiguwen.bean;

import java.io.Serializable;

/**
 * Created by devin on 2018/4/16 10:38
 * Description
 */

public class FensEntity implements Serializable {
//      "nickname": "",
//              "userid": 16,
//              "head": "http://www.boyihunjia.com/uploads/20180205/67baf9df47ef09f4c37e41847b7e7b31.jpg",
//              "occupationid": "",
//              "diqu": "/成都市",
//              "follow": 1
    private String nickname;
    private int userid;
    private String head;
    private String diqu;
    private int follow;
    private String occupationid;

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }

    public String getHead() {
        return head;
    }

    public void setHead(String head) {
        this.head = head;
    }

    public String getDiqu() {
        return diqu;
    }

    public void setDiqu(String diqu) {
        this.diqu = diqu;
    }

    public int getFollow() {
        return follow;
    }

    public void setFollow(int follow) {
        this.follow = follow;
    }

    public String getOccupationid() {
        return occupationid;
    }

    public void setOccupationid(String occupationid) {
        this.occupationid = occupationid;
    }
}
