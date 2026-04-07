package com.linzi.xiguwen.bean;

import java.util.List;

/**
 * Created by PC on 2018-04-07.
 */

public class MessagePrefrentialBean {

    private int num;
    private List<PrefrentialList> cont;

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }

    public List<PrefrentialList> getCont() {
        return cont;
    }

    public void setCont(List<PrefrentialList> cont) {
        this.cont = cont;
    }

    public static class PrefrentialList{

                /*"columnid": 56,
                        "title": "优惠测试",
                        "typeid": 21,
                        "typename": "广告",
                        "weigh": 1,
                        "is_show": 1,
                        "isnew": null,
                        "content": "优惠测试优惠测试",
                        "createtime": "2018-04-06 14:14:52",
                        "updatetime": 0,
                        "pv": 0,
                        "img": "http:\/\/www.boyihunjia.com\/index\/index\/login.html",
                        "src": "http:\/\/www.boyihunjia.com\/index\/index\/login.html"*/
        private String content;
        private String img;
        private String src;
        private String createtime;
        private String title;

        public String getContent() {
            return content;
        }

        public void setContent(String content) {
            this.content = content;
        }

        public String getImg() {
            return img;
        }

        public void setImg(String img) {
            this.img = img;
        }

        public String getSrc() {
            return src;
        }

        public void setSrc(String src) {
            this.src = src;
        }

        public String getCreatetime() {
            return createtime;
        }

        public void setCreatetime(String createtime) {
            this.createtime = createtime;
        }

        public String getTitle() {
            return title;
        }

        public void setTitle(String title) {
            this.title = title;
        }
    }
}
