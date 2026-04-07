package com.linzi.xiguwen.bean;

import java.util.List;

/**
 * Created by pc on 2018/4/20.
 */

public class MallXieShangHistoryBean {

    /**
     * data : [{"head":"http://www.boyihunjia.com/Index/admin/image/180222/d4Md0279000001519271679.png","nickname":"墨修成","text":"有了，谢谢","times":"2018-03-31 15:33:57"},{"head":"http://www.boyihunjia.com/home/default/imghead.png","nickname":"测试","text":"同意退款","times":"2018-03-31 15:46:06"}]
     * shop : {"userid":1457,"mobile":"15708447139","user_im":541,"shop_im":1457}
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
         * userid : 1457
         * mobile : 15708447139
         * user_im : 541
         * shop_im : 1457
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
         * head : http://www.boyihunjia.com/Index/admin/image/180222/d4Md0279000001519271679.png
         * nickname : 墨修成
         * text : 有了，谢谢
         * times : 2018-03-31 15:33:57
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
