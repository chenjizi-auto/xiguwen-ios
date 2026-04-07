package com.linzi.xiguwen.bean;

import java.util.List;

/**
 * Created by pc on 2018/5/25.
 */

public class JiFenGoodsDetailBean {

    /**
     * data : {"id":1,"jiage":0,"jifen":20,"kucuun":30,"miaoshu":["http://imgcache.boyihunjia.com/513dd201805151151121552.jpg","http://imgcache.boyihunjia.com/513dd201805151151121552.jpg"],"name":"商品1","tupian":["http://imgcache.boyihunjia.com/513dd201805151151121552.jpg","http://imgcache.boyihunjia.com/513dd201805151151121552.jpg","http://imgcache.boyihunjia.com/513dd201805151151121552.jpg"],"yiduinum":2}
     * youlike : [{"id":1,"jiage":0,"jifen":20,"kucuun":30,"name":"商品1","tupian":"http://imgcache.boyihunjia.com/513dd201805151151121552.jpg","yiduinum":2},{"id":2,"jiage":0,"jifen":200,"kucuun":30,"name":"商品2","tupian":"http://imgcache.boyihunjia.com/513dd201805151151121552.jpg","yiduinum":1},{"id":3,"jiage":11,"jifen":200,"kucuun":30,"name":"商品3","tupian":"http://imgcache.boyihunjia.com/513dd201805151151121552.jpg","yiduinum":1},{"id":7,"jiage":0,"jifen":10,"kucuun":20,"name":"商品4","tupian":"http://imgcache.boyihunjia.com/3af56201805211129015881.png","yiduinum":1}]
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
         * jiage : 0
         * jifen : 20
         * kucuun : 30
         * miaoshu : ["http://imgcache.boyihunjia.com/513dd201805151151121552.jpg","http://imgcache.boyihunjia.com/513dd201805151151121552.jpg"]
         * name : 商品1
         * tupian : ["http://imgcache.boyihunjia.com/513dd201805151151121552.jpg","http://imgcache.boyihunjia.com/513dd201805151151121552.jpg","http://imgcache.boyihunjia.com/513dd201805151151121552.jpg"]
         * yiduinum : 2
         */

        private int id;
        private String jiage;
        private int jifen;
        private int kucuun;
        private String name;
        private int yiduinum;
        private List<String> miaoshu;
        private List<String> tupian;
        private List<PicsBean> picsBean;

        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
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

        public int getKucuun() {
            return kucuun;
        }

        public void setKucuun(int kucuun) {
            this.kucuun = kucuun;
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public int getYiduinum() {
            return yiduinum;
        }

        public void setYiduinum(int yiduinum) {
            this.yiduinum = yiduinum;
        }

        public List<String> getMiaoshu() {
            return miaoshu;
        }

        public void setMiaoshu(List<String> miaoshu) {
            this.miaoshu = miaoshu;
        }

        public List<String> getTupian() {
            return tupian;
        }

        public void setTupian(List<String> tupian) {
            this.tupian = tupian;
        }

        public List<PicsBean> getPicsBean() {
            return picsBean;
        }

        public void setPicsBean(List<PicsBean> picsBean) {
            this.picsBean = picsBean;
        }

        public static class PicsBean {
            private String imgurl;

            public String getImgurl() {
                return imgurl;
            }

            public void setImgurl(String imgurl) {
                this.imgurl = imgurl;
            }
        }
    }

    public static class YoulikeBean {
        /**
         * id : 1
         * jiage : 0
         * jifen : 20
         * kucuun : 30
         * name : 商品1
         * tupian : http://imgcache.boyihunjia.com/513dd201805151151121552.jpg
         * yiduinum : 2
         */

        private int id;
        private String jiage;
        private int jifen;
        private int kucuun;
        private String name;
        private String tupian;
        private int yiduinum;

        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
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

        public int getKucuun() {
            return kucuun;
        }

        public void setKucuun(int kucuun) {
            this.kucuun = kucuun;
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
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
