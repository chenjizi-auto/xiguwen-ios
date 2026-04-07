package com.linzi.xiguwen.bean;

import java.util.List;

/**
 * Created by pc on 2018/5/23.
 */

public class JiFenGoodsBean {

    /**
     * num : 4
     * data : [{"id":1,"name":"商品1","jiage":0,"jifen":20,"tupian":"http://imgcache.boyihunjia.com/513dd201805151151121552.jpg","yiduinum":2},{"id":2,"name":"商品2","jiage":0,"jifen":200,"tupian":"http://imgcache.boyihunjia.com/513dd201805151151121552.jpg","yiduinum":1},{"id":3,"name":"商品3","jiage":11,"jifen":200,"tupian":"http://imgcache.boyihunjia.com/513dd201805151151121552.jpg","yiduinum":1},{"id":7,"name":"商品4","jiage":0,"jifen":10,"tupian":"http://imgcache.boyihunjia.com/3af56201805211129015881.png","yiduinum":1}]
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
         * name : 商品1
         * jiage : 0
         * jifen : 20
         * tupian : http://imgcache.boyihunjia.com/513dd201805151151121552.jpg
         * yiduinum : 2
         */

        private int id;
        private String name;
        private String jiage;
        private int jifen;
        private String tupian;
        private int yiduinum;

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

        public String getJiage() {
            return jiage;
        }

        public void setJiage(String jiage) {
            this.jiage = jiage;
        }

        public int getJifen() {
            return jifen;
        }

        public void setJifen(int jifen) {
            this.jifen = jifen;
        }

        public String getTupian() {
            return tupian;
        }

        public void setTupian(String tupian) {
            this.tupian = tupian;
        }

        public int getYiduinum() {
            return yiduinum;
        }

        public void setYiduinum(int yiduinum) {
            this.yiduinum = yiduinum;
        }
    }
}
