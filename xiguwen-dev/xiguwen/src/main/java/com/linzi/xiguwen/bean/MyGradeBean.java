package com.linzi.xiguwen.bean;

import com.google.gson.annotations.SerializedName;

import java.io.Serializable;
import java.util.List;

/**
 * Created by PC on 2018-03-30.
 */

public class MyGradeBean implements Serializable {
/**
 * [
 {
 "0": [
 {
 "contactnumber": "11",
 "contacts": "112",
 "create_ti": 1515157396,
 "date": "2018-01-09",
 "dateye": "2018年01月",
 "id": 3,
 "remarks": "111",
 "shijiancuo": 1515427200,
 "timeslot": "上午",
 "update_ti": 1515157400,
 "userid": 16,
 "username": "18581882801"
 }
 ],
 "danshu": 5,
 "dateye": "2018年01月"
 },
 {
 "0": [
 {
 "contactnumber": "23",
 "contacts": "23",
 "create_ti": 1515460242,
 "date": "2018-01-09",
 "dateye": "2018年01月",
 "id": 4,
 "remarks": "423",
 "shijiancuo": 1515427200,
 "timeslot": "上午",
 "userid": 16,
 "username": "18581882801"
 }
 ],
 "danshu": 1,
 "dateye": "2018年02月"
 },]
 */

    private int danshu; // 单数
    private String dateye; // 时间
    private List<Grade> a; // 所有的单


    public int getDanshu() {
        return danshu;
    }

    public void setDanshu(int danshu) {
        this.danshu = danshu;
    }

    public String getDateye() {
        return dateye;
    }

    public void setDateye(String dateye) {
        this.dateye = dateye;
    }

    public List<Grade> getA() {
        return a;
    }

    public void setA(List<Grade> a) {
        this.a = a;
    }

    public static class Grade implements Serializable{
        private String contactnumber;       //联系电话
        private String contacts;            // 联系人
        private long create_ti;             // 创建时间
        private String date;                // 档期日志
        private String dateye;              //
        private int id;                     // id
        private long order_id;
        private String remarks;             // 备注
        private int remind;                 //是否提醒1是0否
        private List<RemindData> tixing;
        private long shijiancuo;            // 时间戳
        private String timeslot;            // 时间段  1上午2中午3下午4晚上5全天6不接单
        private long userid;                // 商家id
        private String username;            // 用户名
        private int xitong;                 //是否是系统生成1是0否

        public String getContactnumber() {
            return contactnumber;
        }

        public void setContactnumber(String contactnumber) {
            this.contactnumber = contactnumber;
        }

        public String getContacts() {
            return contacts;
        }

        public void setContacts(String contacts) {
            this.contacts = contacts;
        }

        public long getCreate_ti() {
            return create_ti;
        }

        public void setCreate_ti(long create_ti) {
            this.create_ti = create_ti;
        }

        public String getDate() {
            return date;
        }

        public void setDate(String date) {
            this.date = date;
        }

        public String getDateye() {
            return dateye;
        }

        public void setDateye(String dateye) {
            this.dateye = dateye;
        }

        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }

        public String getRemarks() {
            return remarks;
        }

        public void setRemarks(String remarks) {
            this.remarks = remarks;
        }

        public long getShijiancuo() {
            return shijiancuo;
        }

        public void setShijiancuo(long shijiancuo) {
            this.shijiancuo = shijiancuo;
        }

        public String getTimeslot() {
            return timeslot;
        }

        public void setTimeslot(String timeslot) {
            this.timeslot = timeslot;
        }

        public long getUserid() {
            return userid;
        }

        public void setUserid(long userid) {
            this.userid = userid;
        }

        public String getUsername() {
            return username;
        }

        public void setUsername(String username) {
            this.username = username;
        }

        public long getOrder_id() {
            return order_id;
        }

        public void setOrder_id(long order_id) {
            this.order_id = order_id;
        }

        public int getRemind() {
            return remind;
        }

        public void setRemind(int remind) {
            this.remind = remind;
        }

        public int getXitong() {
            return xitong;
        }

        public void setXitong(int xitong) {
            this.xitong = xitong;
        }

        public List<RemindData> getTixing() {
            return tixing;
        }

        public void setTixing(List<RemindData> tixing) {
            this.tixing = tixing;
        }

        ///////////////////////////////////////////////////
        public boolean isRemind(){
            return getRemind() == 1;
        }

        public boolean isXiTong(){
            return getXitong() == 1;
        }

        public static class RemindData implements Serializable{
            /**
             *  {
             "beizhu": "备注",
             "didian": "地点",
             "hunlishijian": "01月07日 18:00 周六日",
             "id": 4,
             "shijian": "01月07日 18:00 周六",
             "tixinshijian1": "01月07日 18:00 周六日",
             "tixinshijian2": "01月07日 18:00 周六日",
             "type": 1,
             "uid": 368
             }
             */
            /**
             * 1彩排提醒
             */
            public static final int TYPE_CAIPAI = 1;
            /**
             * 2约见提醒
             */
            public static final int TYPE_YUEJIAN = 2;
            /**
             *  3其他提醒
             */
            public static final int TYPE_QITA = 3;

            private int id;
            private String beizhu;
            private String didian;
            private String hunlishijian;
            private String shijian;
            private String tixinshijian1;
            private String tixinshijian2;
            private int type;
            private long uid;

            public int getId() {
                return id;
            }

            public void setId(int id) {
                this.id = id;
            }

            public String getBeizhu() {
                return beizhu;
            }

            public void setBeizhu(String beizhu) {
                this.beizhu = beizhu;
            }

            public String getDidian() {
                return didian;
            }

            public void setDidian(String didian) {
                this.didian = didian;
            }

            public String getHunlishijian() {
                return hunlishijian;
            }

            public void setHunlishijian(String hunlishijian) {
                this.hunlishijian = hunlishijian;
            }

            public String getShijian() {
                return shijian;
            }

            public void setShijian(String shijian) {
                this.shijian = shijian;
            }

            public String getTixinshijian1() {
                return tixinshijian1;
            }

            public void setTixinshijian1(String tixinshijian1) {
                this.tixinshijian1 = tixinshijian1;
            }

            public String getTixinshijian2() {
                return tixinshijian2;
            }

            public void setTixinshijian2(String tixinshijian2) {
                this.tixinshijian2 = tixinshijian2;
            }

            public int getType() {
                return type;
            }

            public void setType(int type) {
                this.type = type;
            }

            public long getUid() {
                return uid;
            }

            public void setUid(long uid) {
                this.uid = uid;
            }
        }
    }
}
