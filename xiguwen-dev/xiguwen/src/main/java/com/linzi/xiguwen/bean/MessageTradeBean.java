package com.linzi.xiguwen.bean;

import java.util.List;

/**
 * Created by PC on 2018-04-07.
 */

public class MessageTradeBean {

    private List<MessageTradeEntity> cont;

    public List<MessageTradeEntity> getCont() {
        return cont;
    }

    public void setCont(List<MessageTradeEntity> cont) {
        this.cont = cont;
    }

    public static class MessageTradeEntity {
//       "id": 5,
//               "titile": "买家发货",
//               "cont": "电话告诉对方豆腐干",
//               "url": null,
//               "type": 1,
//               "img": "http:\/\/www.boyihunjia.com\/uploads\/20180113\/9dc32ec458c8b0db3490c86f9dcc6d38.jpg",
//               "createtime": "2018-04-07 14:58:27",
//               "userid": 16

        private String id;
        private String cont;
        private String url;
        private String type;
        private String img;
        private String createtime;
        private String userid;
        private String order_sn;
        private String title;
        private int types;
        private int sid;
        private int readType;
        private int shifoujiedan;
        private int status;

        public int getStatus() {
            return status;
        }

        public void setStatus(int status) {
            this.status = status;
        }

        public int getShifoujiedan() {
            return shifoujiedan;
        }

        public void setShifoujiedan(int shifoujiedan) {
            this.shifoujiedan = shifoujiedan;
        }

        public int getReadType() {
            return readType;
        }

        public void setReadType(int readType) {
            this.readType = readType;
        }

        public int getTypes() {
            return types;
        }

        public void setTypes(int types) {
            this.types = types;
        }

        public int getSid() {
            return sid;
        }

        public void setSid(int sid) {
            this.sid = sid;
        }

        public String getOrder_sn() {
            return order_sn;
        }

        public void setOrder_sn(String order_sn) {
            this.order_sn = order_sn;
        }

        public String getTitle() {
            return title;
        }

        public void setTitle(String title) {
            this.title = title;
        }

        public String getId() {
            return id;
        }

        public void setId(String id) {
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
