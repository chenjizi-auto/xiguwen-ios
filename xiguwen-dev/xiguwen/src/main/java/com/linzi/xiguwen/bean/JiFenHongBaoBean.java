package com.linzi.xiguwen.bean;

import java.util.List;

/**
 * Created by pc on 2018/5/23.
 */

public class JiFenHongBaoBean {

    /**
     * num : 2
     * data : [{"id":1,"name":"一起5元宝","xuyaojifen":4,"lingqunum":1,"img":"http://imgcache.boyihunjia.com/19d5d201803152043335164.jpg"},{"id":2,"name":"5元宝","xuyaojifen":4,"lingqunum":1,"img":"http://imgcache.boyihunjia.com/19d5d201803152043335164.jpg"}]
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
         * id : 1
         * name : 一起5元宝
         * xuyaojifen : 4
         * lingqunum : 1
         * img : http://imgcache.boyihunjia.com/19d5d201803152043335164.jpg
         */

        private int id;
        private String name;
        private int xuyaojifen;
        private int lingqunum;
        private String img;

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

        public int getXuyaojifen() {
            return xuyaojifen;
        }

        public void setXuyaojifen(int xuyaojifen) {
            this.xuyaojifen = xuyaojifen;
        }

        public int getLingqunum() {
            return lingqunum;
        }

        public void setLingqunum(int lingqunum) {
            this.lingqunum = lingqunum;
        }

        public String getImg() {
            return img;
        }

        public void setImg(String img) {
            this.img = img;
        }
    }
}
