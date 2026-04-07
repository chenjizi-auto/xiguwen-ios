package com.linzi.xiguwen.bean;

import java.util.List;

/**
 * Created by pc on 2018/5/23.
 */

public class JiFenDetailsBean {

    /**
     * num : 34
     * data : [{"id":46,"type":1,"title":"签到获得","huodeshijian":"2018-05-23 12:17:30","userid":16,"jifen":1},{"id":45,"type":1,"title":"签到获得","huodeshijian":"2018-05-23 12:12:28","userid":16,"jifen":1},{"id":44,"type":1,"title":"签到获得","huodeshijian":"2018-05-23 12:08:29","userid":16,"jifen":1},{"id":43,"type":1,"title":"签到获得","huodeshijian":"2018-05-23 12:06:54","userid":16,"jifen":1},{"id":42,"type":1,"title":"签到获得","huodeshijian":"2018-05-23 11:59:48","userid":16,"jifen":1},{"id":41,"type":1,"title":"签到获得","huodeshijian":"2018-05-23 11:57:49","userid":16,"jifen":2},{"id":37,"type":1,"title":"签到获得","huodeshijian":"2018-05-22 15:26:44","userid":16,"jifen":1},{"id":27,"type":1,"title":"签到获得","huodeshijian":"2018-05-21 15:19:13","userid":16,"jifen":1},{"id":26,"type":1,"title":"签到获得","huodeshijian":"2018-05-21 15:19:09","userid":16,"jifen":7},{"id":25,"type":1,"title":"签到获得","huodeshijian":"2018-05-21 15:19:03","userid":16,"jifen":6}]
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
         * id : 46
         * type : 1
         * title : 签到获得
         * huodeshijian : 2018-05-23 12:17:30
         * userid : 16
         * jifen : 1
         */

        private int id;
        private int type;
        private String title;
        private String huodeshijian;
        private int userid;
        private int jifen;

        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }

        public int getType() {
            return type;
        }

        public void setType(int type) {
            this.type = type;
        }

        public String getTitle() {
            return title;
        }

        public void setTitle(String title) {
            this.title = title;
        }

        public String getHuodeshijian() {
            return huodeshijian;
        }

        public void setHuodeshijian(String huodeshijian) {
            this.huodeshijian = huodeshijian;
        }

        public int getUserid() {
            return userid;
        }

        public void setUserid(int userid) {
            this.userid = userid;
        }

        public int getJifen() {
            return jifen;
        }

        public void setJifen(int jifen) {
            this.jifen = jifen;
        }
    }
}
