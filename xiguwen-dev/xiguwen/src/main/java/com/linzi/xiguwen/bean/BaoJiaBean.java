package com.linzi.xiguwen.bean;

import com.linzi.xiguwen.network.Constans;

import java.io.Serializable;
import java.util.ArrayList;

/**
 * Created by PC on 2018-03-24.
 * 报价类
 */

public class BaoJiaBean extends BaseStatusBean implements Serializable{


    //1审核中 2通过 3失败 4待审核
    /**
     * {
     　　　　　　"imglist":[
     　　　　　　　　"http://boyiapi.xxwlb.com/uploads/20180122/2adca842d20dde950efd5fafed4b9f3d.jpg",
     　　　　　　　　"http://boyiapi.xxwlb.com/uploads/20180122/fd620babe1ba9c96400cd66b445b320d.jpg",
     　　　　　　　　"http://boyiapi.xxwlb.com/uploads/20180122/f21d458cad5e5df542d3e10e6c0a2388.jpg",
     　　　　　　　　"http://boyiapi.xxwlb.com/uploads/20180122/8e6486685dba6c155ea631c4915f9d2d.jpg",
     　　　　　　　　"http://boyiapi.xxwlb.com/uploads/20180122/e89a2c933bb0c73e44fd3d1b55797bf9.jpg"
     　　　　　　],
     　　　　　　"deductible":"0.00",
     　　　　　　"name":"爱情几何（西式婚礼策划套餐）",
     　　　　　　"namea":"爱情几何（...",
     　　　　　　"price":"16080.00",
     　　　　　　"quotationid":40,
     　　　　　　"state":2,
     　　　　　　"status":1,
     　　　　　　"weigh":1
     　　　　}
     */
//    public static final int CHECK_ON = 1;// 审核中
//    public static final int CHECK_FINISH = 2;// 通过
//    public static final int CHECK_ERR = 3;// 失败
//    public static final int CHECK_WAIT = 4;// 待审核
//
//    public static final int STATUS_PUT_ON_SHELVES = 1;// 已上架
//    public static final int STATUS_PUT_OFF_SHELVES = 0;// 已下架


    private ArrayList<String> imglist;      //报价图片
    private String deductible;              //报价
    private String name;
    private String namea;
    private String price;
    private int quotationid;
    private int state;
    private int status;     // 上架下架
    private int weigh;


    public ArrayList<String> getImglist() {
        return imglist;
    }

    public void setImglist(ArrayList<String> imglist) {
        this.imglist = imglist;
    }

    public String getDeductible() {
        return deductible;
    }

    public void setDeductible(String deductible) {
        this.deductible = deductible;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getNamea() {
        return namea;
    }

    public void setNamea(String namea) {
        this.namea = namea;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public int getQuotationid() {
        return quotationid;
    }

    public void setQuotationid(int quotationid) {
        this.quotationid = quotationid;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getWeigh() {
        return weigh;
    }

    public void setWeigh(int weigh) {
        this.weigh = weigh;
    }

    @Override
    public int getMyStatus() {
        return getStatus();
    }

    @Override
    public int getMyState() {
        return getState();
    }

    @Override
    public String getMyTitle() {
        return getName();
    }

    @Override
    public String getMyContent() {
        return Constans.RMB + getPrice();
    }

    @Override
    public String getMyCover() {
        ArrayList<String> imglist = getImglist();
        return (imglist == null || imglist.size() == 0) ? null : imglist.get(0);
    }
}
