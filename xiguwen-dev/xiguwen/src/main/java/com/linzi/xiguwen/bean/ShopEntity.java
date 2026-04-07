package com.linzi.xiguwen.bean;

import java.io.Serializable;
import java.util.List;

/**
 * Created by PC on 2018-04-15.
 */

public class ShopEntity implements Serializable {

    private int shopid;
    private String shopname;
    private String price;
    private int saled;
    private List<String> shopimg;
    private int num;


    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
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

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public int getSaled() {
        return saled;
    }

    public void setSaled(int saled) {
        this.saled = saled;
    }

    public List<String> getShopimg() {
        return shopimg;
    }

    public void setShopimg(List<String> shopimg) {
        this.shopimg = shopimg;
    }
}
