package com.linzi.xiguwen.bean;

import java.util.List;

/**
 * Created by pc on 2018/5/23.
 */

public class JiFenIndexBean {

    /**
     * jifen : 62
     * duihuanjilushu : 8
     * lianxutianshu : 2
     * ganggao : [{"adid":120,"title":"嘻嘻嘻","wapimg":"http://imgcache.boyihunjia.com/909e8201805181710411937.png","aptid":19,"aptype":1,"src":"","price":"1.00"},{"adid":121,"title":"哈哈哈哈","wapimg":"http://imgcache.boyihunjia.com/366ef201805181711013770.png","aptid":67,"aptype":2,"src":"","price":"11.00"}]
     * shop : [{"id":1,"name":"商品1","jiage":0,"jifen":20,"tupian":"http://imgcache.boyihunjia.com/513dd201805151151121552.jpg"},{"id":2,"name":"商品2","jiage":0,"jifen":200,"tupian":"http://imgcache.boyihunjia.com/513dd201805151151121552.jpg"},{"id":3,"name":"商品3","jiage":11,"jifen":200,"tupian":"http://imgcache.boyihunjia.com/513dd201805151151121552.jpg"},{"id":7,"name":"1","jiage":0,"jifen":1,"tupian":"http://imgcache.boyihunjia.com/3af56201805211129015881.png"}]
     * hongbao : [{"id":1,"name":"1","jine":2,"xuyaojifen":4,"img":"http://imgcache.boyihunjia.com/19d5d201803152043335164.jpg"},{"id":2,"name":"1","jine":2,"xuyaojifen":4,"img":"http://imgcache.boyihunjia.com/19d5d201803152043335164.jpg"}]
     */

    private int jifen;
    private int duihuanjilushu;
    private int lianxutianshu;
    private int shifouqiandao;
    private List<GanggaoBean> ganggao;
    private List<ShopBean> shop;
    private List<HongbaoBean> hongbao;

    public int getShifouqiandao() {
        return shifouqiandao;
    }

    public void setShifouqiandao(int shifouqiandao) {
        this.shifouqiandao = shifouqiandao;
    }

    public int getJifen() {
        return jifen;
    }

    public void setJifen(int jifen) {
        this.jifen = jifen;
    }

    public int getDuihuanjilushu() {
        return duihuanjilushu;
    }

    public void setDuihuanjilushu(int duihuanjilushu) {
        this.duihuanjilushu = duihuanjilushu;
    }

    public int getLianxutianshu() {
        return lianxutianshu;
    }

    public void setLianxutianshu(int lianxutianshu) {
        this.lianxutianshu = lianxutianshu;
    }

    public List<GanggaoBean> getGanggao() {
        return ganggao;
    }

    public void setGanggao(List<GanggaoBean> ganggao) {
        this.ganggao = ganggao;
    }

    public List<ShopBean> getShop() {
        return shop;
    }

    public void setShop(List<ShopBean> shop) {
        this.shop = shop;
    }

    public List<HongbaoBean> getHongbao() {
        return hongbao;
    }

    public void setHongbao(List<HongbaoBean> hongbao) {
        this.hongbao = hongbao;
    }

    public static class GanggaoBean {
        /**
         * adid : 120
         * title : 嘻嘻嘻
         * wapimg : http://imgcache.boyihunjia.com/909e8201805181710411937.png
         * aptid : 19
         * aptype : 1
         * src :
         * price : 1.00
         */

        private int adid;
        private String title;
        private String wapimg;
        private int aptid;
        private int aptype;
        private String src;
        private String price;

        public int getAdid() {
            return adid;
        }

        public void setAdid(int adid) {
            this.adid = adid;
        }

        public String getTitle() {
            return title;
        }

        public void setTitle(String title) {
            this.title = title;
        }

        public String getWapimg() {
            return wapimg;
        }

        public void setWapimg(String wapimg) {
            this.wapimg = wapimg;
        }

        public int getAptid() {
            return aptid;
        }

        public void setAptid(int aptid) {
            this.aptid = aptid;
        }

        public int getAptype() {
            return aptype;
        }

        public void setAptype(int aptype) {
            this.aptype = aptype;
        }

        public String getSrc() {
            return src;
        }

        public void setSrc(String src) {
            this.src = src;
        }

        public String getPrice() {
            return price;
        }

        public void setPrice(String price) {
            this.price = price;
        }
    }

    public static class ShopBean {
        /**
         * id : 1
         * name : 商品1
         * jiage : 0
         * jifen : 20
         * tupian : http://imgcache.boyihunjia.com/513dd201805151151121552.jpg
         */

        private int id;
        private String name;
        private String jiage;
        private int jifen;
        private String tupian;

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
    }

    public static class HongbaoBean {
        /**
         * id : 1
         * name : 1
         * jine : 2
         * xuyaojifen : 4
         * img : http://imgcache.boyihunjia.com/19d5d201803152043335164.jpg
         */

        private int id;
        private String name;
        private int jine;
        private int xuyaojifen;
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

        public int getJine() {
            return jine;
        }

        public void setJine(int jine) {
            this.jine = jine;
        }

        public int getXuyaojifen() {
            return xuyaojifen;
        }

        public void setXuyaojifen(int xuyaojifen) {
            this.xuyaojifen = xuyaojifen;
        }

        public String getImg() {
            return img;
        }

        public void setImg(String img) {
            this.img = img;
        }
    }
}
