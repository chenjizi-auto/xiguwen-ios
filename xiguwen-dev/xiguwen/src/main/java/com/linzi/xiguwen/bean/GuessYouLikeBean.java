package com.linzi.xiguwen.bean;

import java.io.Serializable;
import java.util.List;

/**
 * Created by jiang on 2018/1/31.
 */

public class GuessYouLikeBean implements Serializable {

    /**
     * pinluns : 0
     * clicked : 23
     * title : 童话里的我们
     * id : 15
     * follow : 0
     * nickname : 策划师墨修成
     * weddingdescribe : 星空闪烁，仿佛遥远的召唤：“愿深情一眼挚爱万年，几度轮回恋恋不灭！”
     * head : http://boyiapi.xxwlb.com/uploads/20180123/d7a23bd184fb160b5a1521783a39dd33.jpg
     * followed : 1
     * weddingexpenses : 68000
     * occupationid : 花艺师
     * typee : 1
     * weddingcover : http://boyiapi.xxwlb.com/uploads/20180124/d2174b0b7709ccab54243e43ce856eca.jpg
     * cover : http://boyiapi.xxwlb.com/uploads/20180124/e1f7a6ac635325290d26dd354641e29f.jpg
     * name : 双机跟拍
     * photourl : [{"id":38,"photo":"http://boyiapi.xxwlb.com/uploads/20180124/38832e1ef9f62bf6fa377ab938f16923.jpg","atlas_id":17},{"id":39,"photo":"http://boyiapi.xxwlb.com/uploads/20180124/ea20d7ecf37c3235e6b8ca2fa3f6b9ab.jpg","atlas_id":17},{"id":40,"photo":"http://boyiapi.xxwlb.com/uploads/20180124/24f0e1522e56f5747ef094ef8beb4939.jpg","atlas_id":17}]
     * video_url : http://boyiapi.xxwlb.com/Index/admin/video/20180113/7cb9be486d85065d9106079eba2488f5.mp4
     * shopimg : http://boyiapi.xxwlb.com/uploads/20180106/f5a649f9232154ace6769080b4a78a22.jpg
     * price : 1.00
     * shopid : 103
     * shopname : 哈哈哈
     */

    private int pinluns;
    private int clicked;
    private String title;
    private int id;
    private int follow;
    private String nickname;
    private String weddingdescribe;
    private String head;
    private int followed;
    private int weddingexpenses;
    private String occupationid;
    private String typee;
    private String weddingcover;
    private String cover;
    private String name;
    private String video_url;
    private String shopimg;
    private String price;
    private int shopid;
    private String shopname;
    private List<PhotourlBean> photourl;

    public int getPinluns() {
        return pinluns;
    }

    public void setPinluns(int pinluns) {
        this.pinluns = pinluns;
    }

    public int getClicked() {
        return clicked;
    }

    public void setClicked(int clicked) {
        this.clicked = clicked;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getFollow() {
        return follow;
    }

    public void setFollow(int follow) {
        this.follow = follow;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getWeddingdescribe() {
        return weddingdescribe;
    }

    public void setWeddingdescribe(String weddingdescribe) {
        this.weddingdescribe = weddingdescribe;
    }

    public String getHead() {
        return head;
    }

    public void setHead(String head) {
        this.head = head;
    }

    public int getFollowed() {
        return followed;
    }

    public void setFollowed(int followed) {
        this.followed = followed;
    }

    public int getWeddingexpenses() {
        return weddingexpenses;
    }

    public void setWeddingexpenses(int weddingexpenses) {
        this.weddingexpenses = weddingexpenses;
    }

    public String getOccupationid() {
        return occupationid;
    }

    public void setOccupationid(String occupationid) {
        this.occupationid = occupationid;
    }

    public String getTypee() {
        return typee;
    }

    public void setTypee(String typee) {
        this.typee = typee;
    }

    public String getWeddingcover() {
        return weddingcover;
    }

    public void setWeddingcover(String weddingcover) {
        this.weddingcover = weddingcover;
    }

    public String getCover() {
        return cover;
    }

    public void setCover(String cover) {
        this.cover = cover;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getVideo_url() {
        return video_url;
    }

    public void setVideo_url(String video_url) {
        this.video_url = video_url;
    }

    public String getShopimg() {
        return shopimg;
    }

    public void setShopimg(String shopimg) {
        this.shopimg = shopimg;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public int getShopid() {
        return shopid;
    }

    public void setShopid(int shopid) {
        this.shopid = shopid;
    }

    public String getShopname() {
        return shopname;
    }

    public void setShopname(String shopname) {
        this.shopname = shopname;
    }

    public List<PhotourlBean> getPhotourl() {
        return photourl;
    }

    public void setPhotourl(List<PhotourlBean> photourl) {
        this.photourl = photourl;
    }

    public static class PhotourlBean {
        /**
         * id : 38
         * photo : http://boyiapi.xxwlb.com/uploads/20180124/38832e1ef9f62bf6fa377ab938f16923.jpg
         * atlas_id : 17
         */

        private int id;
        private String photo;
        private int atlas_id;

        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }

        public String getPhoto() {
            return photo;
        }

        public void setPhoto(String photo) {
            this.photo = photo;
        }

        public int getAtlas_id() {
            return atlas_id;
        }

        public void setAtlas_id(int atlas_id) {
            this.atlas_id = atlas_id;
        }
    }
}
