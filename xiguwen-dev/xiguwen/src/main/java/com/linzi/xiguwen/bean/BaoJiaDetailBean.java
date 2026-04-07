package com.linzi.xiguwen.bean;

import com.linzi.xiguwen.network.Constans;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by PC on 2018-03-27.
 */

public class BaoJiaDetailBean extends BaseStatusBean implements Serializable {

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

    /**
     * {
     "company": "3",
     "content": " <img src=\"\\uploads\\20180105\\60c536059e266e179ef5c74bece99f6b.jpg\" alt=\"undefined\">123 ",
     "createtime": 1515152504,
   ----  "deductible": "4.00",
     "deposit": "0.00",
     "haopin": 100,
     "imglist": [
     {
     "photo": "http://boyiapi.xxwlb.comuploads/20180105/0525ce6d1fb32f5284b9bcb5764099c1.jpg"
     },
     {
     "photo": "http://boyiapi.xxwlb.comuploads/20180105/48d4a1f1e31c2ed03fd3e0e29fd0a5bf.jpg"
     },
     {
     "photo": "http://boyiapi.xxwlb.comuploads/20180105/f2d7a2f1a0a099fb8eccf63ab5ccb51d.jpg"
     },
     {
     "photo": "http://boyiapi.xxwlb.comuploads/20180105/ab420117adff3a80773df44f8dc7907a.jpg"
     }
     ],
    ----- "name": "测试1",
     "num": 0,
     "number": 0,
    ----- "price": "2.00",
     "pv": 1,
    ----- "quotationid": 31,
    ----- "state": 2,
     "statecontent": 1,
     "statetime": 1,
    ----- "status": 1,
     "temporarypay": "0.00",
     "uname": "15114030130",
     "userid": 10,
    ----- "weigh": 5
     }
     */

    private String company;
    private String content;
    private long createtime;
    private String deposit;
    private int haopin;
    private List<Photo> imglist;
    private int num;
    private int number;
    private int pv;
    private String statecontent;
    private long statetime;
    private String temporarypay;
    private String uname;
    private long userid;
    private String deductible;              //报价
    private String name;
    private String namea;
    private String price;
    private int quotationid;
    private int state;
    private int status;     // 上架下架
    private int weigh;


    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public long getCreatetime() {
        return createtime;
    }

    public void setCreatetime(long createtime) {
        this.createtime = createtime;
    }

    public String getDeposit() {
        return deposit;
    }

    public void setDeposit(String deposit) {
        this.deposit = deposit;
    }

    public int getHaopin() {
        return haopin;
    }

    public void setHaopin(int haopin) {
        this.haopin = haopin;
    }

    public List<Photo> getImglist() {
        return this.imglist;
    }

    public void setImglist(List<Photo> imglist) {
        this.imglist = imglist;
    }

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }

    public int getPv() {
        return pv;
    }

    public void setPv(int pv) {
        this.pv = pv;
    }

    public String getStatecontent() {
        return statecontent;
    }

    public void setStatecontent(String statecontent) {
        this.statecontent = statecontent;
    }

    public long getStatetime() {
        return statetime;
    }

    public void setStatetime(long statetime) {
        this.statetime = statetime;
    }

    public String getTemporarypay() {
        return temporarypay;
    }

    public void setTemporarypay(String temporarypay) {
        this.temporarypay = temporarypay;
    }

    public String getUname() {
        return uname;
    }

    public void setUname(String uname) {
        this.uname = uname;
    }

    public long getUserid() {
        return userid;
    }

    public void setUserid(long userid) {
        this.userid = userid;
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
        List<Photo> imglist = getImglist();
        return (imglist == null || imglist.size() == 0) ? null : imglist.get(0).getPhoto();
    }

    public static class Photo implements Serializable{
        private String photo;

        public String getPhoto() {
            return photo;
        }

        public void setPhoto(String photo) {
            this.photo = photo;
        }
    }
}
