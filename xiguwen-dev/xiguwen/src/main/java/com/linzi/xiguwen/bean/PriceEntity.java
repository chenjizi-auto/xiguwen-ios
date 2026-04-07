package com.linzi.xiguwen.bean;


import java.io.Serializable;

/**
 * Created by PC on 2018-04-15.
 */

public class PriceEntity implements Serializable {
    private int quotationid;
    private String name;
    private String price;
    private String imglist;
    private int num;


    public int getQuotationid() {
        return quotationid;
    }

    public void setQuotationid(int quotationid) {
        this.quotationid = quotationid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getImglist() {
        return imglist;
    }

    public void setImglist(String imglist) {
        this.imglist = imglist;
    }

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }
}
