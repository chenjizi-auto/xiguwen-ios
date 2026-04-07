package com.linzi.xiguwen.bean;

import java.io.Serializable;
import java.util.List;

/**
 * Created by jiang on 2018/3/5.
 */

public class MineInvitationBean implements Serializable{

    /**
     * code : 0
     * data : [{"cover":"http://boyiapi.xxwlb.com/Index/admin/image/180201/85Bd0418648001517490579.jpeg","id":1,"mobanid":3,"url":"http://boyiapi.xxwlb.com/invitation/index/do/id/1","userid":16}]
     * message : ok
     * num : 1
     */

    private int code;
    private String message;
    private int num;
    private List<DataBean> data;

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }

    public List<DataBean> getData() {
        return data;
    }

    public void setData(List<DataBean> data) {
        this.data = data;
    }

    public static class DataBean {
        /**
         * cover : http://boyiapi.xxwlb.com/Index/admin/image/180201/85Bd0418648001517490579.jpeg
         * id : 1
         * mobanid : 3
         * url : http://boyiapi.xxwlb.com/invitation/index/do/id/1
         * userid : 16
         */

        private String cover;
        private int id;
        private int mobanid;
        private String url;
        private int userid;
        private String xinlang;
        private String xinniang;
        private long hunlitime;
        private String hotel;
        private String hunlidizhi;

        public String getCover() {
            return cover;
        }

        public void setCover(String cover) {
            this.cover = cover;
        }

        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }

        public int getMobanid() {
            return mobanid;
        }

        public void setMobanid(int mobanid) {
            this.mobanid = mobanid;
        }

        public String getUrl() {
            return url;
        }

        public void setUrl(String url) {
            this.url = url;
        }

        public int getUserid() {
            return userid;
        }

        public void setUserid(int userid) {
            this.userid = userid;
        }

        public String getXinlang() {
            return xinlang;
        }

        public void setXinlang(String xinlang) {
            this.xinlang = xinlang;
        }

        public String getXinniang() {
            return xinniang;
        }

        public void setXinniang(String xinniang) {
            this.xinniang = xinniang;
        }

        public long getHunlitime() {
            return hunlitime;
        }

        public void setHunlitime(long hunlitime) {
            this.hunlitime = hunlitime;
        }

        public String getHotel() {
            return hotel;
        }

        public void setHotel(String hotel) {
            this.hotel = hotel;
        }

        public String getHunlidizhi() {
            return hunlidizhi;
        }

        public void setHunlidizhi(String hunlidizhi) {
            this.hunlidizhi = hunlidizhi;
        }
    }
}
