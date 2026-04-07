package com.linzi.xiguwen.bean;

import com.linzi.xiguwen.network.Constans;

import java.io.Serializable;
import java.util.ArrayList;

/**
 * Created by PC on 2018-03-24.
 * 我的商品列表类
 */

public class CommodityBean extends BaseStatusBean implements Serializable{


    //1审核中 2通过 3失败 4待审核
    /**
     * {
     "shopimg": [
     "http://boyiapi.xxwlb.com/uploads/20180106/caa8c8695eb76c0dde51836c303382b8.jpg"
     ],
     "spec_name_1": 1,
     "spec_name_2": 1,
     "statecontent": 1,
     "city": "天津市",
     "cityid": 35,
     "clicked": 0,
     "columnid": 6,
     "columnname": "婚礼布置",
     "company": "个",
     "county": "河北区",
     "countyid": 400,
     "coupons_price": "80.00",
     "expressid": 3,
     "expressname": "3件包邮",
     "followed": 0,
     "num": 0,
     "number": 0,
     "pcolumnid": 4,
     "pcolumnname": "婚庆布置/舞台布置",
     "price": "168.00",
     "province": "天津市",
     "provinceid": 3,
     "saled": 0,
     "shopid": 96,
     "shopname": "红色蕾丝婚鞋高跟鞋细跟尖头2018春秋新款名媛新娘结婚鞋子单鞋女",
     "state": 1,
     "statetime": 1515806643,
     "status": 0,
     "time": 1515416409,
     "userid": 16,
     "username": "18581882801",
     "weigh": 2
     }
     */


    private ArrayList<String> shopimg;      //报价图片
    private String city;                    //城市名称
    private int cityid;                     //城市id
    private int clicked;
    private int columind;                   // 商品2级类目id
    private String columnname;              // 商品2级类目名称
    private String company;                 // 商品单位
    private String county;                  // 区县
    private int countyid;                   // 区县id
    private String coupons_price;           // 。。。
    private int expressid;                  //运费模板id
    private String expressname;             //运费模板
    private int followed;
    private int num;
    private int number;
    private int pcolumnid;                  // 商品1级类目id
    private String pcolumnname;             // 商品1级类目名称
    private String price;
    private String province;                // 省份
    private int provinceid;                 // 省份id
    private int saled;
    private int shopid;                    // 商品id
    private String shopname;                // 商品名称
    private String spec_name_1;
    private String spec_name_2;
    private int state;                      //审核状态4待提交 1审核中 2通过 3未通过
    private String statecontent;
    private long statetime;
    private int status;                     //1上架 0下架
    private long time;
    private long userid;
    private String username;
    private int weigh;


    public ArrayList<String> getShopimg() {
        return shopimg;
    }

    public void setShopimg(ArrayList<String> shopimg) {
        this.shopimg = shopimg;
    }

    public String getCity() {
        return city == null ? "" : city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public int getCityid() {
        return cityid;
    }

    public void setCityid(int cityid) {
        this.cityid = cityid;
    }

    public int getClicked() {
        return clicked;
    }

    public void setClicked(int clicked) {
        this.clicked = clicked;
    }

    public int getColumind() {
        return columind;
    }

    public void setColumind(int columind) {
        this.columind = columind;
    }

    public String getColumnname() {
        return columnname;
    }

    public void setColumnname(String columnname) {
        this.columnname = columnname;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public String getCounty() {
        return county == null ? "" : county;
    }

    public void setCounty(String county) {
        this.county = county;
    }

    public int getCountyid() {
        return countyid;
    }

    public void setCountyid(int countyid) {
        this.countyid = countyid;
    }

    public String getCoupons_price() {
        return coupons_price;
    }

    public void setCoupons_price(String coupons_price) {
        this.coupons_price = coupons_price;
    }

    public int getExpressid() {
        return expressid;
    }

    public void setExpressid(int expressid) {
        this.expressid = expressid;
    }

    public String getExpressname() {
        return expressname;
    }

    public void setExpressname(String expressname) {
        this.expressname = expressname;
    }

    public int getFollowed() {
        return followed;
    }

    public void setFollowed(int followed) {
        this.followed = followed;
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

    public int getPcolumnid() {
        return pcolumnid;
    }

    public void setPcolumnid(int pcolumnid) {
        this.pcolumnid = pcolumnid;
    }

    public String getPcolumnname() {
        return pcolumnname;
    }

    public void setPcolumnname(String pcolumnname) {
        this.pcolumnname = pcolumnname;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getProvince() {
        return province == null ? "" : province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public int getProvinceid() {
        return provinceid;
    }

    public void setProvinceid(int provinceid) {
        this.provinceid = provinceid;
    }

    public int getSaled() {
        return saled;
    }

    public void setSaled(int saled) {
        this.saled = saled;
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

    public String getSpec_name_1() {
        return spec_name_1;
    }

    public void setSpec_name_1(String spec_name_1) {
        this.spec_name_1 = spec_name_1;
    }

    public String getSpec_name_2() {
        return spec_name_2;
    }

    public void setSpec_name_2(String spec_name_2) {
        this.spec_name_2 = spec_name_2;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
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

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public long getTime() {
        return time;
    }

    public void setTime(long time) {
        this.time = time;
    }

    public long getUserid() {
        return userid;
    }

    public void setUserid(long userid) {
        this.userid = userid;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
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
        return getShopname();
    }

    @Override
    public String getMyContent() {
        return Constans.RMB + getPrice();
    }

    @Override
    public String getMyCover() {
        ArrayList<String> imglist = getShopimg();
        return (imglist == null || imglist.size() == 0) ? null : imglist.get(0);
    }
}
