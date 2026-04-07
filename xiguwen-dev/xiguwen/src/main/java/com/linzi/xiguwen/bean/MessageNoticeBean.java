package com.linzi.xiguwen.bean;

import java.util.List;

/**
 * Created by PC on 2018-04-07.
 */

public class MessageNoticeBean {

    private List<MessageNoticeEntity> cont;

    public List<MessageNoticeEntity> getCont() {
        return cont;
    }

    public void setCont(List<MessageNoticeEntity> cont) {
        this.cont = cont;
    }

    public static class MessageNoticeEntity {
//       "id": 5,
//               "titile": "买家发货",
//               "cont": "电话告诉对方豆腐干",
//               "url": null,
//               "type": 1,
//               "img": "http:\/\/www.boyihunjia.com\/uploads\/20180113\/9dc32ec458c8b0db3490c86f9dcc6d38.jpg",
//               "createtime": "2018-04-07 14:58:27",
//               "userid": 16

        private int id;
        private String cont;
        private String url;
        private String type;
        private String img;
        private String createtime;
        private String userid;
        private String order_sn;
        private String titlea;
        private String head;
        private String titleb;
        private int sid;
        private int readType;

        public int getReadType() {
            return readType;
        }

        public void setReadType(int readType) {
            this.readType = readType;
        }

        public int getSid() {
            return sid;
        }

        public void setSid(int sid) {
            this.sid = sid;
        }

        public String getHead() {
            return head;
        }

        public void setHead(String head) {
            this.head = head;
        }

        public String getOrder_sn() {
            return order_sn;
        }

        public void setOrder_sn(String order_sn) {
            this.order_sn = order_sn;
        }

        public String getTitlea() {
            return titlea;
        }

        public void setTitlea(String titlea) {
            this.titlea = titlea;
        }

        public String getTitleb() {
            return titleb;
        }

        public void setTitleb(String titleb) {
            this.titleb = titleb;
        }

        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }

        public String getCont() {
            return cont;
        }

        public void setCont(String cont) {
            this.cont = cont;
        }

        public String getUrl() {
            return url;
        }

        public void setUrl(String url) {
            this.url = url;
        }

        public String getType() {
            return type;
        }

        public void setType(String type) {
            this.type = type;
        }

        public String getImg() {
            return img;
        }

        public void setImg(String img) {
            this.img = img;
        }

        public String getCreatetime() {
            return createtime;
        }

        public void setCreatetime(String createtime) {
            this.createtime = createtime;
        }

        public String getUserid() {
            return userid;
        }

        public void setUserid(String userid) {
            this.userid = userid;
        }
    }
}
