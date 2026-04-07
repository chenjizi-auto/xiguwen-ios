package com.linzi.xiguwen.bean;

import java.util.List;

/**
 * Created by PC on 2018-03-29.
 * 认证提交的资料
 */

public class RenZhengSubmitInfoBean {
    /**
     *  {
     "byautoid": 44,
     "did": 12,
     "r_data": [
     "/uploads/20180201/0482a4be98ebcd98a67a82f42c4da843.png",
     "/uploads/20180201/0482a4be98ebcd98a67a82f42c4da843.png",
     "/uploads/20180201/0482a4be98ebcd98a67a82f42c4da843.png",
     ""
     ],
     "userid": 16,
     "video_url": "0"
     },
     */

    private int did;            //id
    private int byautoid;       // 审核提交表id
    private List<String> r_data;// 认证材料
    private long userid;
    private String video_url;   // 视频材料

    public int getDid() {
        return did;
    }

    public void setDid(int did) {
        this.did = did;
    }

    public int getByautoid() {
        return byautoid;
    }

    public void setByautoid(int byautoid) {
        this.byautoid = byautoid;
    }

    public List<String> getR_data() {
        return r_data;
    }

    public void setR_data(List<String> r_data) {
        this.r_data = r_data;
    }

    public long getUserid() {
        return userid;
    }

    public void setUserid(long userid) {
        this.userid = userid;
    }

    public String getVideo_url() {
        return video_url;
    }

    public void setVideo_url(String video_url) {
        this.video_url = video_url;
    }
}
