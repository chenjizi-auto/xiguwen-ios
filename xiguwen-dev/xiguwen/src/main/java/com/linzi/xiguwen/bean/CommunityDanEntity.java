package com.linzi.xiguwen.bean;

import java.io.Serializable;

/**
 * Created by PC on 2018-04-21.
 */

public class CommunityDanEntity implements Serializable {
//        "date": "2020-04-22",
//                "timeslot": 2,
//                "nickname": "芸芸老师",
//                "create_ti": "3小时前"
    private String date;
    private int timeslot;
    private String nickname;
    private String create_ti;

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public int getTimeslot() {
        return timeslot;
    }

    public void setTimeslot(int timeslot) {
        this.timeslot = timeslot;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getCreate_ti() {
        return create_ti;
    }

    public void setCreate_ti(String create_ti) {
        this.create_ti = create_ti;
    }
}
