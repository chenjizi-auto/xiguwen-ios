package com.linzi.xiguwen.fragment.club;

import java.util.List;

/**
 * Title:
 * Description:
 * Copyright:Copyright(c)2018
 * Company: Cree
 * CreateTime:2018/3/29  14:10
 *
 * @author luyongjiang
 * @version 1.0
 */
public class TestBean {


    /**
     * chuangshiren : {"userid":16,"head":"http://www.boyihunjia.com/uploads/20180205/67baf9df47ef09f4c37e41847b7e7b31.jpg","nickname":"杜卡基老师","occupationid":24,"usertype":2,"occupation":"花艺师","zuidijia":0}
     * chengyuan : [{"userid":13,"head":"http://www.boyihunjia.com/uploads/20180208/19819c2510bc8adf5b275d58cbfec355.jpg","nickname":"爱诺寐铺家纺店","occupationid":1,"usertype":1,"occupation":"策划师","zuidijia":0},{"userid":1483,"head":"http://www.boyihunjia.com/home/default/imghead.png","nickname":"测试账户","occupationid":24,"usertype":2,"occupation":"花艺师","zuidijia":0}]
     * num : 3
     */

    private ChuangshirenBean chuangshiren;
    private int num;
    private List<ChengyuanBean> chengyuan;

    public ChuangshirenBean getChuangshiren() {
        return chuangshiren;
    }

    public void setChuangshiren(ChuangshirenBean chuangshiren) {
        this.chuangshiren = chuangshiren;
    }

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }

    public List<ChengyuanBean> getChengyuan() {
        return chengyuan;
    }

    public void setChengyuan(List<ChengyuanBean> chengyuan) {
        this.chengyuan = chengyuan;
    }

    public static class ChuangshirenBean {
        /**
         * userid : 16
         * head : http://www.boyihunjia.com/uploads/20180205/67baf9df47ef09f4c37e41847b7e7b31.jpg
         * nickname : 杜卡基老师
         * occupationid : 24
         * usertype : 2
         * occupation : 花艺师
         * zuidijia : 0
         */

        private int userid;
        private String head;
        private String nickname;
        private int occupationid;
        private int usertype;
        private String occupation;
        private int zuidijia;

        public int getUserid() {
            return userid;
        }

        public void setUserid(int userid) {
            this.userid = userid;
        }

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

        public int getOccupationid() {
            return occupationid;
        }

        public void setOccupationid(int occupationid) {
            this.occupationid = occupationid;
        }

        public int getUsertype() {
            return usertype;
        }

        public void setUsertype(int usertype) {
            this.usertype = usertype;
        }

        public String getOccupation() {
            return occupation;
        }

        public void setOccupation(String occupation) {
            this.occupation = occupation;
        }

        public int getZuidijia() {
            return zuidijia;
        }

        public void setZuidijia(int zuidijia) {
            this.zuidijia = zuidijia;
        }
    }

    public static class ChengyuanBean {
        /**
         * userid : 13
         * head : http://www.boyihunjia.com/uploads/20180208/19819c2510bc8adf5b275d58cbfec355.jpg
         * nickname : 爱诺寐铺家纺店
         * occupationid : 1
         * usertype : 1
         * occupation : 策划师
         * zuidijia : 0
         */

        private int userid;
        private String head;
        private String nickname;
        private int occupationid;
        private int usertype;
        private String occupation;
        private int zuidijia;

        public int getUserid() {
            return userid;
        }

        public void setUserid(int userid) {
            this.userid = userid;
        }

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

        public int getOccupationid() {
            return occupationid;
        }

        public void setOccupationid(int occupationid) {
            this.occupationid = occupationid;
        }

        public int getUsertype() {
            return usertype;
        }

        public void setUsertype(int usertype) {
            this.usertype = usertype;
        }

        public String getOccupation() {
            return occupation;
        }

        public void setOccupation(String occupation) {
            this.occupation = occupation;
        }

        public int getZuidijia() {
            return zuidijia;
        }

        public void setZuidijia(int zuidijia) {
            this.zuidijia = zuidijia;
        }
    }
}
