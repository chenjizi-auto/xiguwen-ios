package com.linzi.xiguwen.bean;

import java.util.List;

/**
 * Created by jiang on 2018/1/31.
 */

public class IndexGoodsVadioBean {
    private int id;
    private String name;
    private String zhiye;
    private int isCare;
    private int type;//0商品，1视频，2图册
    private String img_url;
    private String head_img;
    private String title;
    private String price;
    private String content;
    private List<Tuce>tuce;
    private int dianjiliang;
    private int guanzhuliang;
    private int pinglunliang;

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

    public String getZhiye() {
        return zhiye;
    }

    public void setZhiye(String zhiye) {
        this.zhiye = zhiye;
    }

    public int getIsCare() {
        return isCare;
    }

    public void setIsCare(int isCare) {
        this.isCare = isCare;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public String getImg_url() {
        return img_url;
    }

    public void setImg_url(String img_url) {
        this.img_url = img_url;
    }

    public String getHead_img() {
        return head_img;
    }

    public void setHead_img(String head_img) {
        this.head_img = head_img;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public List<Tuce> getTuce() {
        return tuce;
    }

    public void setTuce(List<Tuce> tuce) {
        this.tuce = tuce;
    }

    public int getDianjiliang() {
        return dianjiliang;
    }

    public void setDianjiliang(int dianjiliang) {
        this.dianjiliang = dianjiliang;
    }

    public int getGuanzhuliang() {
        return guanzhuliang;
    }

    public void setGuanzhuliang(int guanzhuliang) {
        this.guanzhuliang = guanzhuliang;
    }

    public int getPinglunliang() {
        return pinglunliang;
    }

    public void setPinglunliang(int pinglunliang) {
        this.pinglunliang = pinglunliang;
    }

    public class Tuce{
        private int id;
        private String url;

        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }

        public String getUrl() {
            return url;
        }

        public void setUrl(String url) {
            this.url = url;
        }
    }
}
