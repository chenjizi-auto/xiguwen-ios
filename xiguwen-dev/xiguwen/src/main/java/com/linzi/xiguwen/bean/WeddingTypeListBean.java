package com.linzi.xiguwen.bean;

import java.util.List;

/**
 * Created by pc on 2018/4/4.
 */

public class WeddingTypeListBean {
    /**
     * data : [{"team":2,"fans":0,"userid":540,"nickname":"成都墨家影视文化传播","head":"http://imgcache.boyihunjia.com/a7d33201803121826421369.jpg","evaluate":0,"occupationid":"摄像师","isshopvip":1,"sincerity":0,"platform":1,"college":1,"team2":1,"shopnum":6,"anlinum":0,"zuidijia":"900.00","shiming":0,"xueyuan":14,"xueyuanname":"二星黄金团队认证"},{"team":2,"fans":0,"userid":646,"nickname":"九亦影视","head":"http://imgcache.boyihunjia.com/b28cd201803190823518799.jpg","evaluate":3,"occupationid":"摄像师","isshopvip":1,"sincerity":0,"platform":1,"college":1,"team2":1,"shopnum":2,"anlinum":0,"zuidijia":"800.00","shiming":0,"xueyuan":14,"xueyuanname":"二星黄金团队认证"},{"team":1,"fans":0,"userid":1125,"nickname":"九亦影视\u2014Superduty土豆","head":"http://imgcache.boyihunjia.com/98bd0201803131444008355.jpg","evaluate":0,"occupationid":"摄像师","isshopvip":1,"sincerity":0,"platform":1,"college":1,"team2":0,"shopnum":2,"anlinum":0,"zuidijia":"800.00","shiming":1,"xueyuan":7,"xueyuanname":"中级认证"},{"team":3,"fans":9,"userid":16,"nickname":"杜卡基老师","head":"http://www.boyihunjia.com/uploads/20180205/67baf9df47ef09f4c37e41847b7e7b31.jpg","evaluate":11,"occupationid":null,"isshopvip":0,"sincerity":1,"platform":1,"college":1,"team2":0,"shopnum":3,"anlinum":2,"zuidijia":"0.03","shiming":1,"xueyuan":0,"xueyuanname":""},{"team":1,"fans":0,"userid":1124,"nickname":"九亦影视\u2014枫子","head":"http://imgcache.boyihunjia.com/fdeba201803151256148515.jpg","evaluate":0,"occupationid":"摄像师","isshopvip":1,"sincerity":0,"platform":1,"college":1,"team2":0,"shopnum":2,"anlinum":0,"zuidijia":"800.00","shiming":1,"xueyuan":7,"xueyuanname":"中级认证"},{"team":2,"fans":1,"userid":537,"nickname":"左右视觉-大川摄影","head":"http://imgcache.boyitongcheng.com/30bc0201803071128143963.jpg","evaluate":0,"occupationid":"摄影师","isshopvip":0,"sincerity":0,"platform":1,"college":1,"team2":0,"shopnum":3,"anlinum":8,"zuidijia":"900.00","shiming":1,"xueyuan":0,"xueyuanname":""},{"team":1,"fans":0,"userid":647,"nickname":"九一影视文化传媒\u2014老廖","head":"http://www.boyihunjia.com/home/default/imghead.png","evaluate":0,"occupationid":null,"isshopvip":1,"sincerity":0,"platform":1,"college":1,"team2":0,"shopnum":0,"anlinum":0,"zuidijia":0,"shiming":0,"xueyuan":7,"xueyuanname":"中级认证"},{"team":1,"fans":0,"userid":1269,"nickname":"沙湾大红灯笼婚礼文化","head":"http://imgcache.boyihunjia.com/5d0f2201803141442566774.png","evaluate":0,"occupationid":"策划师","isshopvip":0,"sincerity":0,"platform":1,"college":0,"team2":0,"shopnum":0,"anlinum":0,"zuidijia":0,"shiming":1,"xueyuan":0,"xueyuanname":""},{"team":2,"fans":0,"userid":1272,"nickname":"用户15902886110","head":"http://imgcache.boyihunjia.com/76fca201803121334194595.png","evaluate":0,"occupationid":"策划师","isshopvip":0,"sincerity":0,"platform":1,"college":0,"team2":0,"shopnum":0,"anlinum":0,"zuidijia":0,"shiming":1,"xueyuan":0,"xueyuanname":""},{"team":2,"fans":0,"userid":1322,"nickname":"好心情婚礼定制","head":"http://imgcache.boyihunjia.com/b5a70201803231725202081.png","evaluate":0,"occupationid":"婚庆公司","isshopvip":0,"sincerity":0,"platform":1,"college":0,"team2":0,"shopnum":2,"anlinum":2,"zuidijia":"1500.00","shiming":1,"xueyuan":0,"xueyuanname":""}]
     * num : 623
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
         * team : 2
         * fans : 0
         * userid : 540
         * nickname : 成都墨家影视文化传播
         * head : http://imgcache.boyihunjia.com/a7d33201803121826421369.jpg
         * evaluate : 0
         * occupationid : 摄像师
         * isshopvip : 1
         * sincerity : 0
         * platform : 1
         * college : 1
         * team2 : 1
         * shopnum : 6
         * anlinum : 0
         * zuidijia : 900.00
         * shiming : 0
         * xueyuan : 14
         * xueyuanname : 二星黄金团队认证
         */

        private int team;
        private int fans;
        private int userid;
        private String nickname;
        private String head;
        private int evaluate;
        private String occupationid;
        private int isshopvip;
        private int sincerity;
        private int platform;
        private int college;
        private int team2;
        private int shopnum;
        private int anlinum;
        private String zuidijia;
        private int shiming;
        private int xueyuan;
        private String xueyuanname;

        public int getTeam() {
            return team;
        }

        public void setTeam(int team) {
            this.team = team;
        }

        public int getFans() {
            return fans;
        }

        public void setFans(int fans) {
            this.fans = fans;
        }

        public int getUserid() {
            return userid;
        }

        public void setUserid(int userid) {
            this.userid = userid;
        }

        public String getNickname() {
            return nickname;
        }

        public void setNickname(String nickname) {
            this.nickname = nickname;
        }

        public String getHead() {
            return head;
        }

        public void setHead(String head) {
            this.head = head;
        }

        public int getEvaluate() {
            return evaluate;
        }

        public void setEvaluate(int evaluate) {
            this.evaluate = evaluate;
        }

        public String getOccupationid() {
            return occupationid;
        }

        public void setOccupationid(String occupationid) {
            this.occupationid = occupationid;
        }

        public int getIsshopvip() {
            return isshopvip;
        }

        public void setIsshopvip(int isshopvip) {
            this.isshopvip = isshopvip;
        }

        public int getSincerity() {
            return sincerity;
        }

        public void setSincerity(int sincerity) {
            this.sincerity = sincerity;
        }

        public int getPlatform() {
            return platform;
        }

        public void setPlatform(int platform) {
            this.platform = platform;
        }

        public int getCollege() {
            return college;
        }

        public void setCollege(int college) {
            this.college = college;
        }

        public int getTeam2() {
            return team2;
        }

        public void setTeam2(int team2) {
            this.team2 = team2;
        }

        public int getShopnum() {
            return shopnum;
        }

        public void setShopnum(int shopnum) {
            this.shopnum = shopnum;
        }

        public int getAnlinum() {
            return anlinum;
        }

        public void setAnlinum(int anlinum) {
            this.anlinum = anlinum;
        }

        public String getZuidijia() {
            return zuidijia;
        }

        public void setZuidijia(String zuidijia) {
            this.zuidijia = zuidijia;
        }

        public int getShiming() {
            return shiming;
        }

        public void setShiming(int shiming) {
            this.shiming = shiming;
        }

        public int getXueyuan() {
            return xueyuan;
        }

        public void setXueyuan(int xueyuan) {
            this.xueyuan = xueyuan;
        }

        public String getXueyuanname() {
            return xueyuanname;
        }

        public void setXueyuanname(String xueyuanname) {
            this.xueyuanname = xueyuanname;
        }
    }
}
