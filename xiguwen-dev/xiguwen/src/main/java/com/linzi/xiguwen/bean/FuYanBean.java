package com.linzi.xiguwen.bean;

import java.util.List;

/**
 * 赴宴实体
 */
public class FuYanBean {
    /**
     * info : [{"id":7,"name":"杜卡基老师","createti":"2018-02-24 16:26:26","telephone":"18581882822","cont":1},{"id":12,"name":"试试","createti":"2018-03-24 11:12:47","telephone":"18581882822","cont":1},{"id":15,"name":"23风","createti":"2018-03-24 11:18:41","telephone":"18581882822","cont":8},{"id":18,"name":"等回电话给","createti":"2018-04-19 19:24:38","telephone":"18581882822","cont":2},{"id":20,"name":"李海涛","createti":"2018-04-23 11:10:19","telephone":"18581882822","cont":3},{"id":22,"name":"章怀洋","createti":"2018-05-02 11:08:59","telephone":"18581882822","cont":8},{"id":24,"name":"墨修成","createti":"2018-05-10 19:05:53","telephone":"18581882822","cont":5}]
     * num : 7
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
         * cont : 1
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


//    /**
//     * "fuyan": [
//     {
//     "createti": "2018-02-02 19:57:22",
//     "fuyan": "赴宴",
//     "fuyannum": 2,
//     "id": 1,
//     "name": "流逝",
//     "userid": 16
//     },
//     */
//    private List<FuYan> fuyan;
//
//    public List<FuYan> getFuyan() {
//        return fuyan;
//    }
//
//    public void setFuyan(List<FuYan> fuyan) {
//        this.fuyan = fuyan;
//    }
//
//    public static class FuYan{
//        public static final int TYPE_FUYAN = 1;
//        public static final int TYPE_DAIDING = 2;
//        public static final int TYPE_YOUSHI = 3;
//
//
//        private String createti;        // 时间
//        private String fuyan;           // 赴宴类型  （1赴宴 2待定 3有事）
//        private int fuyannum;           // 赴宴人数
//        private int id;
//        private String name;            // 姓名
//        private long userid;
//
//        public String getCreateti() {
//            return createti;
//        }
//
//        public void setCreateti(String createti) {
//            this.createti = createti;
//        }
//
//        public String getFuyan() {
//            return fuyan;
//        }
//
//        public void setFuyan(String fuyan) {
//            this.fuyan = fuyan;
//        }
//
//        public int getFuyannum() {
//            return fuyannum;
//        }
//
//        public void setFuyannum(int fuyannum) {
//            this.fuyannum = fuyannum;
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
//        public String getFuYanFormat(){
//            switch (getFuyan()){
//                case "1":
//                    return "赴宴";
//                case "2":
//                    return "待定";
//                case "3":
//                    return "有事";
//            }
//            return "";
//        }
//    }
}
