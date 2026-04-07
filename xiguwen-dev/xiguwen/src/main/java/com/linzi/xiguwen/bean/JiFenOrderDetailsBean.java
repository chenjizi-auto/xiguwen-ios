package com.linzi.xiguwen.bean;

import java.util.List;

/**
 * Created by pc on 2018/5/28.
 */

public class JiFenOrderDetailsBean {

    /**
     * data : {"id":1,"order_sn":"111111111","buyid":16,"shop_code":1,"shop_name":"商品i","shop_tupian":"http://imgcache.boyihunjia.com/513dd201805151151121552.jpg","jifen":1,"jine":1,"number":1,"status":5,"paixiashijian":"2018-05-18 14:14:57","fukuanshijian":"","fahuoshijian":"","shouhuoshijian":"","liuyan":"asdasd","postname":"11","postaddress":"3333","postmobile":"333","postaddressid":4,"kuaidicode":"ZTO","kuaidinum":"479163558523","paytype":"","kouchujifen":2,"fukuantime":0}
     * youlike : [{"id":1,"jiage":0,"jifen":20,"kucuun":30,"name":"商品1","tupian":"http://imgcache.boyihunjia.com/513dd201805151151121552.jpg","yiduinum":2},{"id":2,"jiage":0,"jifen":200,"kucuun":30,"name":"商品2","tupian":"http://imgcache.boyihunjia.com/513dd201805151151121552.jpg","yiduinum":1},{"id":3,"jiage":11,"jifen":200,"kucuun":30,"name":"商品3","tupian":"http://imgcache.boyihunjia.com/513dd201805151151121552.jpg","yiduinum":1},{"id":7,"jiage":0,"jifen":10,"kucuun":19,"name":"商品4","tupian":"http://imgcache.boyihunjia.com/3af56201805211129015881.png","yiduinum":2},{"id":11,"jiage":0.01,"jifen":1,"kucuun":99,"name":"商品s","tupian":"http://imgcache.boyihunjia.com/21e0c20180525165208708.png","yiduinum":1}]
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
         * order_sn : 111111111
         * buyid : 16
         * shop_code : 1
         * shop_name : 商品i
         * shop_tupian : http://imgcache.boyihunjia.com/513dd201805151151121552.jpg
         * jifen : 1
         * jine : 1
         * number : 1
         * status : 5
         * paixiashijian : 2018-05-18 14:14:57
         * fukuanshijian :
         * fahuoshijian :
         * shouhuoshijian :
         * liuyan : asdasd
         * postname : 11
         * postaddress : 3333
         * postmobile : 333
         * postaddressid : 4
         * kuaidicode : ZTO
         * kuaidinum : 479163558523
         * paytype :
         * kouchujifen : 2
         * fukuantime : 0
         */

        private int id;
        private String order_sn;
        private int buyid;
        private int shop_code;
        private String shop_name;
        private String shop_tupian;
        private int jifen;
        private String jine;
        private int number;
        private int status;
        private String paixiashijian;
        private String fukuanshijian;
        private String fahuoshijian;
        private String shouhuoshijian;
        private String liuyan;
        private String postname;
        private String postaddress;
        private String postmobile;
        private int postaddressid;
        private String kuaidicode;
        private String kuaidinum;
        private String paytype;
        private int kouchujifen;
        private int fukuantime;
        private String paidmoney;

        public String getPaidmoney() {
            return paidmoney;
        }

        public void setPaidmoney(String paidmoney) {
            this.paidmoney = paidmoney;
        }

        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }

        public String getOrder_sn() {
            return order_sn;
        }

        public void setOrder_sn(String order_sn) {
            this.order_sn = order_sn;
        }

        public int getBuyid() {
            return buyid;
        }

        public void setBuyid(int buyid) {
            this.buyid = buyid;
        }

        public int getShop_code() {
            return shop_code;
        }

        public void setShop_code(int shop_code) {
            this.shop_code = shop_code;
        }

        public String getShop_name() {
            return shop_name;
        }

        public void setShop_name(String shop_name) {
            this.shop_name = shop_name;
        }

        public String getShop_tupian() {
            return shop_tupian;
        }

        public void setShop_tupian(String shop_tupian) {
            this.shop_tupian = shop_tupian;
        }

        public int getJifen() {
            return jifen;
        }

        public void setJifen(int jifen) {
            this.jifen = jifen;
        }

        public String getJine() {
            return jine;
        }

        public void setJine(String jine) {
            this.jine = jine;
        }

        public int getNumber() {
            return number;
        }

        public void setNumber(int number) {
            this.number = number;
        }

        public int getStatus() {
            return status;
        }

        public void setStatus(int status) {
            this.status = status;
        }

        public String getPaixiashijian() {
            return paixiashijian;
        }

        public void setPaixiashijian(String paixiashijian) {
            this.paixiashijian = paixiashijian;
        }

        public String getFukuanshijian() {
            return fukuanshijian;
        }

        public void setFukuanshijian(String fukuanshijian) {
            this.fukuanshijian = fukuanshijian;
        }

        public String getFahuoshijian() {
            return fahuoshijian;
        }

        public void setFahuoshijian(String fahuoshijian) {
            this.fahuoshijian = fahuoshijian;
        }

        public String getShouhuoshijian() {
            return shouhuoshijian;
        }

        public void setShouhuoshijian(String shouhuoshijian) {
            this.shouhuoshijian = shouhuoshijian;
        }

        public String getLiuyan() {
            return liuyan;
        }

        public void setLiuyan(String liuyan) {
            this.liuyan = liuyan;
        }

        public String getPostname() {
            return postname;
        }

        public void setPostname(String postname) {
            this.postname = postname;
        }

        public String getPostaddress() {
            return postaddress;
        }

        public void setPostaddress(String postaddress) {
            this.postaddress = postaddress;
        }

        public String getPostmobile() {
            return postmobile;
        }

        public void setPostmobile(String postmobile) {
            this.postmobile = postmobile;
        }

        public int getPostaddressid() {
            return postaddressid;
        }

        public void setPostaddressid(int postaddressid) {
            this.postaddressid = postaddressid;
        }

        public String getKuaidicode() {
            return kuaidicode;
        }

        public void setKuaidicode(String kuaidicode) {
            this.kuaidicode = kuaidicode;
        }

        public String getKuaidinum() {
            return kuaidinum;
        }

        public void setKuaidinum(String kuaidinum) {
            this.kuaidinum = kuaidinum;
        }

        public String getPaytype() {
            return paytype;
        }

        public void setPaytype(String paytype) {
            this.paytype = paytype;
        }

        public int getKouchujifen() {
            return kouchujifen;
        }

        public void setKouchujifen(int kouchujifen) {
            this.kouchujifen = kouchujifen;
        }

        public int getFukuantime() {
            return fukuantime;
        }

        public void setFukuantime(int fukuantime) {
            this.fukuantime = fukuantime;
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
