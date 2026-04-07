package com.linzi.xiguwen.bean;

import java.io.Serializable;
import java.util.List;

/**
 * Created by PC on 2018-04-08.
 */

public class InvitationsTemplateBean implements Serializable{
    /**
     * data : [{"cover":"http://img.zcool.cn/community/014608582ae13ea84a0e282b0b2099.jpg@1280w_1l_2o_100sh.jpg","id":1,"isvip":46,"title":"6546","url":"http://www.boyihunjia.com/Invitation/day4/index.html"}]
     * num : 1
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

    public static class DataBean implements Serializable{
        /**
         * cover : http://img.zcool.cn/community/014608582ae13ea84a0e282b0b2099.jpg@1280w_1l_2o_100sh.jpg
         * id : 1
         * isvip : 46
         * title : 6546
         * url : http://www.boyihunjia.com/Invitation/day4/index.html
         */

        private String cover;
        private int id;
        private int isvip;
        private String title;
        private String url;

        public String getCover() {
            return cover;
        }

        public void setCover(String cover) {
            this.cover = cover;
        }

        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }

        public int getIsvip() {
            return isvip;
        }

        public void setIsvip(int isvip) {
            this.isvip = isvip;
        }

        public String getTitle() {
            return title;
        }

        public void setTitle(String title) {
            this.title = title;
        }

        public String getUrl() {
            return url;
        }

        public void setUrl(String url) {
            this.url = url;
        }
    }


//    /**
//     * {
//     "cover": "http://boyiapi.xxwlb.comsdsdf",
//     "create": 2311,
//     "id": 1,
//     "isvip": 1,
//     "status": 2,
//     "title": "csd",
//     "weight": 1
//     }
//     */
//    /**
//     *  "id": 11,
//     "title": "day8",
//     "weight": 8,
//     "cover": "http:\/\/imgcache.boyihunjia.com\/ec775201803262100048573.jpg",
//     "isvip": 2,
//     "status": 1,
//     "create": 1522069211,
//     "hot": 0,
//     "boutique": 0,
//     "url": "http:\/\/www.boyihunjia.com\/invitation\/day8\/index",
//     "leibie": 1
//     */
//    private String cover;   //封面地址
//    private long create;    // 创建时间
//    private int id;         //
//    private int isvip;      //是否VIP, 1是0否
//    private int status;     // 1启用 2停用
//    private String title;   //模板标题
//    private int weight;     // 权重
//    private int hot;
//    private int boutique;
//    private String url;
//    private int leibie;
//
//    public String getCover() {
//        return cover;
//    }
//
//    public void setCover(String cover) {
//        this.cover = cover;
//    }
//
//    public long getCreate() {
//        return create;
//    }
//
//    public void setCreate(long create) {
//        this.create = create;
//    }
//
//    public int getId() {
//        return id;
//    }
//
//    public void setId(int id) {
//        this.id = id;
//    }
//
//    public int getIsvip() {
//        return isvip;
//    }
//
//    public void setIsvip(int isvip) {
//        this.isvip = isvip;
//    }
//
//    public int getStatus() {
//        return status;
//    }
//
//    public void setStatus(int status) {
//        this.status = status;
//    }
//
//    public String getTitle() {
//        return title;
//    }
//
//    public void setTitle(String title) {
//        this.title = title;
//    }
//
//    public int getWeight() {
//        return weight;
//    }
//
//    public void setWeight(int weight) {
//        this.weight = weight;
//    }
//
//    public int getHot() {
//        return hot;
//    }
//
//    public void setHot(int hot) {
//        this.hot = hot;
//    }
//
//    public int getBoutique() {
//        return boutique;
//    }
//
//    public void setBoutique(int boutique) {
//        this.boutique = boutique;
//    }
//
//    public String getUrl() {
//        return url;
//    }
//
//    public void setUrl(String url) {
//        this.url = url;
//    }
//
//    public int getLeibie() {
//        return leibie;
//    }
//
//    public void setLeibie(int leibie) {
//        this.leibie = leibie;
//    }
}
