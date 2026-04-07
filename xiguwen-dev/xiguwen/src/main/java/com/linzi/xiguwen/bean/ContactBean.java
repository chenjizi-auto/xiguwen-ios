package com.linzi.xiguwen.bean;

import java.util.List;

/**
 * Title:
 * Description:
 * Copyright:Copyright(c)2018
 * Company: Cree
 * CreateTime:2018/3/29  11:48
 *
 * @author luyongjiang
 * @version 1.0
 */
public class ContactBean {
    public interface OnContact {
        String getNickname();

        String getMobile();

        int getUserid();
    }

    /**
     * chuangshiren : {"userid":16,"nickname":"杜卡基老师","mobile":"18581882801","usertype":2}
     * chengyuan : [{"userid":13,"nickname":"爱诺寐铺家纺店","mobile":"15181305414","usertype":1},{"userid":1483,"nickname":"测试账户","mobile":"17777777777","usertype":2}]
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

    public static class ChuangshirenBean implements OnContact {
        /**
         * userid : 16
         * nickname : 杜卡基老师
         * mobile : 18581882801
         * usertype : 2
         */

        private int userid;
        private String nickname;
        private String mobile;
        private int usertype;

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

        public String getMobile() {
            return mobile;
        }

        public void setMobile(String mobile) {
            this.mobile = mobile;
        }

        public int getUsertype() {
            return usertype;
        }

        public void setUsertype(int usertype) {
            this.usertype = usertype;
        }
    }

    public static class ChengyuanBean implements OnContact {
        /**
         * userid : 13
         * nickname : 爱诺寐铺家纺店
         * mobile : 15181305414
         * usertype : 1
         */

        private int userid;
        private String nickname;
        private String mobile;
        private int usertype;

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

        public String getMobile() {
            return mobile;
        }

        public void setMobile(String mobile) {
            this.mobile = mobile;
        }

        public int getUsertype() {
            return usertype;
        }

        public void setUsertype(int usertype) {
            this.usertype = usertype;
        }
    }
}
