package com.linzi.xiguwen.bean;

import java.util.List;

/**
 * 祝福实体
 */
public class ZhuFuBean {
    /**
     * info : [{"id":7,"name":"杜卡基老师","createti":"2018-02-24 16:26:26","telephone":"18581882822","cont":"祝福博艺婚嫁越办越好！！"},{"id":12,"name":"试试","createti":"2018-03-24 11:12:47","telephone":"18581882822","cont":"色色问"},{"id":13,"name":"测试时","createti":"2018-03-24 11:14:19","telephone":"18581882822","cont":"但韩国首尔"},{"id":14,"name":"惹我","createti":"2018-03-24 11:16:57","telephone":"18581882822","cont":"色法工会投入力度的"},{"id":15,"name":"23风","createti":"2018-03-24 11:18:41","telephone":"18581882822","cont":"大公会"},{"id":16,"name":"dfvd","createti":"2018-03-24 14:39:49","telephone":"18581882822","cont":"sdafs"},{"id":17,"name":"22","createti":"2018-03-24 18:39:58","telephone":"18581882822","cont":"22"},{"id":18,"name":"等回电话给","createti":"2018-04-19 19:24:38","telephone":"18581882822","cont":"收到好多好多好好"},{"id":19,"name":"娃儿","createti":"2018-04-21 01:37:46","telephone":"18581882822","cont":"吃饭的好哥哥反反复复"},{"id":20,"name":"李海涛","createti":"2018-04-23 11:10:19","telephone":"18581882822","cont":"幸福快乐"},{"id":21,"name":"是谁","createti":"2018-04-24 11:00:22","telephone":"18581882822","cont":"感受世界的角度"},{"id":22,"name":"章怀洋","createti":"2018-05-02 11:08:59","telephone":"18581882822","cont":"新婚快乐"},{"id":23,"name":"离开","createti":"2018-05-10 18:59:28","telephone":"18581882822","cont":"18581882801"},{"id":24,"name":"墨修成","createti":"2018-05-10 19:05:53","telephone":"18581882822","cont":"13880700685"}]
     * num : 14
     */

    private int num;
    private List<InfoBean> info;

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }

    public List<InfoBean> getInfo() {
        return info;
    }

    public void setInfo(List<InfoBean> info) {
        this.info = info;
    }

    public static class InfoBean {
        /**
         * id : 7
         * name : 杜卡基老师
         * createti : 2018-02-24 16:26:26
         * telephone : 18581882822
         * cont : 祝福博艺婚嫁越办越好！！
         */

        private int id;
        private String name;
        private String createti;
        private String telephone;
        private String cont;

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

        public String getCreateti() {
            return createti;
        }

        public void setCreateti(String createti) {
            this.createti = createti;
        }

        public String getTelephone() {
            return telephone;
        }

        public void setTelephone(String telephone) {
            this.telephone = telephone;
        }

        public String getCont() {
            return cont;
        }

        public void setCont(String cont) {
            this.cont = cont;
        }
    }


//    private List<ZhuFu> zhufu;
//
//    public List<ZhuFu> getZhufu() {
//        return zhufu;
//    }
//
//    public void setZhufu(List<ZhuFu> zhufu) {
//        this.zhufu = zhufu;
//    }
//
//    public static class ZhuFu{
//        private String createti;        //时间
//        private int id;                 //
//        private String name;            //姓名
//        private long userid;            //
//        private String zhufu;           // 祝福语
//
//        public String getCreateti() {
//            return createti;
//        }
//
//        public void setCreateti(String createti) {
//            this.createti = createti;
//        }
//
//        public int getId() {
//            return id;
//        }
//
//        public void setId(int id) {
//            this.id = id;
//        }
//
//        public String getName() {
//            return name;
//        }
//
//        public void setName(String name) {
//            this.name = name;
//        }
//
//        public long getUserid() {
//            return userid;
//        }
//
//        public void setUserid(long userid) {
//            this.userid = userid;
//        }
//
//        public String getZhufu() {
//            return zhufu;
//        }
//
//        public void setZhufu(String zhufu) {
//            this.zhufu = zhufu;
//        }
//    }


}
