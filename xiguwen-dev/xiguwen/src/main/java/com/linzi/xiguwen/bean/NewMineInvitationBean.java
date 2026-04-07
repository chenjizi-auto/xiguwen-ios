package com.linzi.xiguwen.bean;

import java.util.List;

/**
 * Created by pc on 2018/6/14.
 */

public class NewMineInvitationBean {

    /**
     * user : [{"id":61,"userid":16,"mobanid":1,"cover":"http://img.zcool.cn/community/014608582ae13ea84a0e282b0b2099.jpg@1280w_1l_2o_100sh.jpg","uid":"like112225dJ106142018oO8152894654525511969zbI","url":"http://www.boyihunjia.com/invitation/xishichengshuang/xishilianlian.html?id=like112225dJ106142018oO8152894654525511969zbI"},{"id":60,"userid":16,"mobanid":1,"cover":"http://img.zcool.cn/community/014608582ae13ea84a0e282b0b2099.jpg@1280w_1l_2o_100sh.jpg","uid":"like111407vh706142018mdV152894604725087916XkA","url":"http://www.boyihunjia.com/invitation/xishichengshuang/xishilianlian.html?id=like111407vh706142018mdV152894604725087916XkA"},{"id":59,"userid":16,"mobanid":1,"cover":"http://img.zcool.cn/community/014608582ae13ea84a0e282b0b2099.jpg@1280w_1l_2o_100sh.jpg","uid":"like11121641L06142018viK15289459362107318828R","url":"http://www.boyihunjia.com/invitation/xishichengshuang/xishilianlian.html?id=like11121641L06142018viK15289459362107318828R"},{"id":58,"userid":16,"mobanid":1,"cover":"http://img.zcool.cn/community/014608582ae13ea84a0e282b0b2099.jpg@1280w_1l_2o_100sh.jpg","uid":"like111206TeO06142018BzB152894592650156260gIt","url":"http://www.boyihunjia.com/invitation/xishichengshuang/xishilianlian.html?id=like111206TeO06142018BzB152894592650156260gIt"},{"id":57,"userid":16,"mobanid":1,"cover":"http://img.zcool.cn/community/014608582ae13ea84a0e282b0b2099.jpg@1280w_1l_2o_100sh.jpg","uid":"like111109NYI06142018YoO152894586964715365FGb","url":"http://www.boyihunjia.com/invitation/xishichengshuang/xishilianlian.html?id=like111109NYI06142018YoO152894586964715365FGb"},{"id":56,"userid":16,"mobanid":1,"cover":"http://img.zcool.cn/community/014608582ae13ea84a0e282b0b2099.jpg@1280w_1l_2o_100sh.jpg","uid":"like110754nOZ06142018tqA152894567430915684EMp","url":"http://www.boyihunjia.com/invitation/xishichengshuang/xishilianlian.html?id=like110754nOZ06142018tqA152894567430915684EMp"},{"id":55,"userid":16,"mobanid":1,"cover":"http://img.zcool.cn/community/014608582ae13ea84a0e282b0b2099.jpg@1280w_1l_2o_100sh.jpg","uid":"like110351vCr06142018w01152894543162357562wfz","url":"http://www.boyihunjia.com/invitation/xishichengshuang/xishilianlian.html?id=like110351vCr06142018w01152894543162357562wfz"},{"id":54,"userid":16,"mobanid":1,"cover":"http://img.zcool.cn/community/014608582ae13ea84a0e282b0b2099.jpg@1280w_1l_2o_100sh.jpg","uid":"like105823BNI06142018Rag152894510345456432n4m","url":"http://www.boyihunjia.com/invitation/xishichengshuang/xishilianlian.html?id=like105823BNI06142018Rag152894510345456432n4m"},{"id":53,"userid":16,"mobanid":1,"cover":"http://img.zcool.cn/community/014608582ae13ea84a0e282b0b2099.jpg@1280w_1l_2o_100sh.jpg","uid":"like105725gg006142018YrU1528945045117667055kS","url":"http://www.boyihunjia.com/invitation/xishichengshuang/xishilianlian.html?id=like105725gg006142018YrU1528945045117667055kS"},{"id":52,"userid":16,"mobanid":1,"cover":"http://img.zcool.cn/community/014608582ae13ea84a0e282b0b2099.jpg@1280w_1l_2o_100sh.jpg","uid":"like105306JKo06142018V0r152894478648232746dF2","url":"http://www.boyihunjia.com/invitation/xishichengshuang/xishilianlian.html?id=like105306JKo06142018V0r152894478648232746dF2"}]
     * num : 59
     */

    private int num;
    private List<UserBean> user;

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }

    public List<UserBean> getUser() {
        return user;
    }

    public void setUser(List<UserBean> user) {
        this.user = user;
    }

    public static class UserBean {
        /**
         * id : 61
         * userid : 16
         * mobanid : 1
         * cover : http://img.zcool.cn/community/014608582ae13ea84a0e282b0b2099.jpg@1280w_1l_2o_100sh.jpg
         * uid : like112225dJ106142018oO8152894654525511969zbI
         * url : http://www.boyihunjia.com/invitation/xishichengshuang/xishilianlian.html?id=like112225dJ106142018oO8152894654525511969zbI
         */

        private int id;
        private int userid;
        private int mobanid;
        private String cover;
        private String uid;
        private String url;
        private String sharetime;
        private String shareurl;

        public String getShareurl() {
            return shareurl;
        }

        public void setShareurl(String shareurl) {
            this.shareurl = shareurl;
        }

        public String getSharetime() {
            return sharetime;
        }

        public void setSharetime(String sharetime) {
            this.sharetime = sharetime;
        }

        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }

        public int getUserid() {
            return userid;
        }

        public void setUserid(int userid) {
            this.userid = userid;
        }

        public int getMobanid() {
            return mobanid;
        }

        public void setMobanid(int mobanid) {
            this.mobanid = mobanid;
        }

        public String getCover() {
            return cover;
        }

        public void setCover(String cover) {
            this.cover = cover;
        }

        public String getUid() {
            return uid;
        }

        public void setUid(String uid) {
            this.uid = uid;
        }

        public String getUrl() {
            return url;
        }

        public void setUrl(String url) {
            this.url = url;
        }
    }
}
