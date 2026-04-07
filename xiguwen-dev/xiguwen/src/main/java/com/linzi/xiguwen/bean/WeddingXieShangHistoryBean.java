package com.linzi.xiguwen.bean;

import java.util.List;

/**
 * Created by pc on 2018/4/20.
 */

public class WeddingXieShangHistoryBean {

    /**
     * data : [{"head":"http://imgcache.boyihunjia.com/4320b201804191521149861.jpg","nickname":"杜卡基老师","text":"是非公经济","times":"2018-04-19 18:54:00"}]
     * shop : {"userid":1121,"mobile":"15928967476","user_im":16,"shop_im":1121}
     */

    private ShopBean shop;
    private List<DataBean> data;

    public ShopBean getShop() {
        return shop;
    }

    public void setShop(ShopBean shop) {
        this.shop = shop;
    }

    public List<DataBean> getData() {
        return data;
    }

    public void setData(List<DataBean> data) {
        this.data = data;
    }

    public static class ShopBean {
        /**
         * userid : 1121
         * mobile : 15928967476
         * user_im : 16
         * shop_im : 1121
         */

        private int userid;
        private String mobile;
        private String user_im;
        private String shop_im;

        public int getUserid() {
            return userid;
        }

        public void setUserid(int userid) {
            this.userid = userid;
        }

        public String getMobile() {
            return mobile;
        }

        public void setMobile(String mobile) {
            this.mobile = mobile;
        }

        public String getUser_im() {
            return user_im;
        }

        public void setUser_im(String user_im) {
            this.user_im = user_im;
        }

        public String getShop_im() {
            return shop_im;
        }

        public void setShop_im(String shop_im) {
            this.shop_im = shop_im;
        }
    }

    public static class DataBean {
        /**
         * head : http://imgcache.boyihunjia.com/4320b201804191521149861.jpg
         * nickname : 杜卡基老师
         * text : 是非公经济
         * times : 2018-04-19 18:54:00
         */

        private String head;
        private String nickname;
        private String text;
        private String times;

        public String getHead() {
            return head;
        }

        public void setHead(String head) {
            this.head = head;
        }

        public String getNickname() {
            return nickname;
        }

        public void setNickname(String nickname) {
            this.nickname = nickname;
        }

        public String getText() {
            return text;
        }

        public void setText(String text) {
            this.text = text;
        }

        public String getTimes() {
            return times;
        }

        public void setTimes(String times) {
            this.times = times;
        }
    }
}
