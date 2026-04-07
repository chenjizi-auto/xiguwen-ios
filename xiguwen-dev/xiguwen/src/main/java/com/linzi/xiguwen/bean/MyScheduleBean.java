package com.linzi.xiguwen.bean;

/**
 * Created by YuToo on 2018/4/5.
 * 我的日程安排实体
 */

public class MyScheduleBean {
    /**
     *  {
     "creater": 61838,
     "conn": "cheshishdafd",
     "endtime": "16:35",
     "id": 1,
     "isend": 2,
     "riqi": "2018-01-06",
     "statime": "14:23",
     "userid": 16
     }
     */

    public final static int STATE_FINISHED = 1;  // 已经完成
    public final static int STATE_UNFINISHED = 2; // 未完成

    private int id;
    private String creater;
    private String conn;        //日程内容
    private String riqi;        // 日期  eg: 2018-08-15
    private String statime;     // 开始时间 08:09
    private String endtime;     // 结束时间 03::03
    private int isend;          // 是否完成     1完成 2未完成
    private long userid;

    public String getCreater() {
        return creater;
    }

    public void setCreater(String creater) {
        this.creater = creater;
    }

    public String getConn() {
        return conn;
    }

    public void setConn(String conn) {
        this.conn = conn;
    }

    public String getRiqi() {
        return riqi;
    }

    public void setRiqi(String riqi) {
        this.riqi = riqi;
    }

    public String getStatime() {
        return statime;
    }

    public void setStatime(String statime) {
        this.statime = statime;
    }

    public String getEndtime() {
        return endtime;
    }

    public void setEndtime(String endtime) {
        this.endtime = endtime;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getIsend() {
        return isend;
    }

    public void setIsend(int isend) {
        this.isend = isend;
    }

    public long getUserid() {
        return userid;
    }

    public void setUserid(long userid) {
        this.userid = userid;
    }
}
