package com.linzi.xiguwen.bean;

import java.util.List;

/**
 * Created by pc on 2018/5/25.
 */

public class JiFenHongBaoDetailBean {

    /**
     * data : {"id":1,"img":"http://imgcache.boyihunjia.com/19d5d201803152043335164.jpg","jine":5,"lingqunum":1,"name":"一起5元宝","number":200,"xuyaojifen":4}
     * youlike : [{"id":1,"img":"http://imgcache.boyihunjia.com/19d5d201803152043335164.jpg","jine":5,"lingqunum":1,"name":"一起5元宝","number":200,"xuyaojifen":4},{"id":2,"img":"http://imgcache.boyihunjia.com/19d5d201803152043335164.jpg","jine":5,"lingqunum":1,"name":"5元宝","number":200,"xuyaojifen":4}]
     */

    private DataBean data;
    private List<YoulikeBean> youlike;

    public DataBean getData() {
        return data;
    }

    public void setData(DataBean data) {
        this.data = data;
    }

    public List<YoulikeBean> getYoulike() {
        return youlike;
    }

    public void setYoulike(List<YoulikeBean> youlike) {
        this.youlike = youlike;
    }

    public static class DataBean {
        /**
         * id : 1
         * img : http://imgcache.boyihunjia.com/19d5d201803152043335164.jpg
         * jine : 5
         * lingqunum : 1
         * name : 一起5元宝
         * number : 200
         * xuyaojifen : 4
         */

        private int id;
        private String img;
        private String jine;
        private int lingqunum;
        private String name;
        private int number;
        private int xuyaojifen;

        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }

        public String getImg() {
            return img;
        }

        public void setImg(String img) {
            this.img = img;
        }

        public String getJine() {
            return jine;
        }

        public void setJine(String jine) {
            this.jine = jine;
        }

        public int getLingqunum() {
            return lingqunum;
        }

        public void setLingqunum(int lingqunum) {
            this.lingqunum = lingqunum;
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public int getNumber() {
            return number;
        }

        public void setNumber(int number) {
            this.number = number;
        }

        public int getXuyaojifen() {
            return xuyaojifen;
        }

        public void setXuyaojifen(int xuyaojifen) {
            this.xuyaojifen = xuyaojifen;
        }
    }

    public static class YoulikeBean {
        /**
         * id : 1
         * img : http://imgcache.boyihunjia.com/19d5d201803152043335164.jpg
         * jine : 5
         * lingqunum : 1
         * name : 一起5元宝
         * number : 200
         * xuyaojifen : 4
         */

        private int id;
        private String img;
        private String jine;
        private int lingqunum;
        private String name;
        private int number;
        private int xuyaojifen;

        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }

        public String getImg() {
            return img;
        }

        public void setImg(String img) {
            this.img = img;
        }

        public String getJine() {
            return jine;
        }

        public void setJine(String jine) {
            this.jine = jine;
        }

        public int getLingqunum() {
            return lingqunum;
        }

        public void setLingqunum(int lingqunum) {
            this.lingqunum = lingqunum;
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public int getNumber() {
            return number;
        }

        public void setNumber(int number) {
            this.number = number;
        }

        public int getXuyaojifen() {
            return xuyaojifen;
        }

        public void setXuyaojifen(int xuyaojifen) {
            this.xuyaojifen = xuyaojifen;
        }
    }
}
