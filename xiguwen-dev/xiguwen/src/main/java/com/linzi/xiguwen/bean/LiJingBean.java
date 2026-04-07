package com.linzi.xiguwen.bean;

import java.util.List;

/**
 * Created by pc on 2018/6/15.
 */

public class LiJingBean {

    /**
     * list : [{"id":36,"qingjianid":1,"userid":16,"name":"参数测试","lijin":0.01,"paytime":"2018-05-25 15:04:27"},{"id":15,"qingjianid":1,"userid":16,"name":"刘云","lijin":0.01,"paytime":"2018-05-25 10:55:20"},{"id":10,"qingjianid":1,"userid":16,"name":"家里","lijin":0.01,"paytime":"2018-05-25 10:49:08"},{"id":1,"qingjianid":1,"userid":16,"name":"刘云","lijin":100,"paytime":"2018-05-24 17:48:12"}]
     * lijinzongshu : 100.03
     * num : 4
     */

    private String lijinzongshu;
    private int num;
    private List<ListBean> list;

    public String getLijinzongshu() {
        return lijinzongshu;
    }

    public void setLijinzongshu(String lijinzongshu) {
        this.lijinzongshu = lijinzongshu;
    }

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }

    public List<ListBean> getList() {
        return list;
    }

    public void setList(List<ListBean> list) {
        this.list = list;
    }

    public static class ListBean {
        /**
         * id : 36
         * qingjianid : 1
         * userid : 16
         * name : 参数测试
         * lijin : 0.01
         * paytime : 2018-05-25 15:04:27
         */

        private int id;
        private int qingjianid;
        private int userid;
        private String name;
        private String lijin;
        private String paytime;

        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }

        public int getQingjianid() {
            return qingjianid;
        }

        public void setQingjianid(int qingjianid) {
            this.qingjianid = qingjianid;
        }

        public int getUserid() {
            return userid;
        }

        public void setUserid(int userid) {
            this.userid = userid;
        }

        public String getName() {
            return name;
        }

        public void setName(String name) {
            this.name = name;
        }

        public String getLijin() {
            return lijin;
        }

        public void setLijin(String lijin) {
            this.lijin = lijin;
        }

        public String getPaytime() {
            return paytime;
        }

        public void setPaytime(String paytime) {
            this.paytime = paytime;
        }
    }
}
