package com.linzi.xiguwen.bean;

import java.util.List;

/**
 * Created by pc on 2018/5/23.
 */

public class ExchangeJiFenBean {

    /**
     * num : 4
     * data : [{"id":4,"name":"1654","img":"http://imgcache.boyihunjia.com/513dd201805151151121552.jpg","date":"2018-05-18 14:14:57","jifen":100,"status":4,"jine":0},{"id":3,"name":"111","img":"http://imgcache.boyihunjia.com/513dd201805151151121552.jpg","date":"2018-05-18 14:14:57","jifen":11,"status":4,"jine":0},{"id":2,"name":"3","img":"http://imgcache.boyihunjia.com/513dd201805151151121552.jpg","date":"2018-05-18 14:14:57","jifen":18,"status":4,"jine":0},{"id":1,"name":"145","img":"http://imgcache.boyihunjia.com/513dd201805151151121552.jpg","date":"2018-05-18 14:14:57","jifen":100,"status":4,"jine":0}]
     */

    private int num;
    private List<DataBean> data;

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
         * id : 4
         * name : 1654
         * img : http://imgcache.boyihunjia.com/513dd201805151151121552.jpg
         * date : 2018-05-18 14:14:57
         * jifen : 100
         * status : 4
         * jine : 0
         */

        private int id;
        private String name;
        private String img;
        private String date;
        private int jifen;
        private int status;
        private String jine;

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

        public String getImg() {
            return img;
        }

        public void setImg(String img) {
            this.img = img;
        }

        public String getDate() {
            return date;
        }

        public void setDate(String date) {
            this.date = date;
        }

        public int getJifen() {
            return jifen;
        }

        public void setJifen(int jifen) {
            this.jifen = jifen;
        }

        public int getStatus() {
            return status;
        }

        public void setStatus(int status) {
            this.status = status;
        }

        public String getJine() {
            return jine;
        }

        public void setJine(String jine) {
            this.jine = jine;
        }
    }
}
