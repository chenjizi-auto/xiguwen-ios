package com.linzi.xiguwen.bean;

import java.util.ArrayList;

/**
 * Created by PC on 2018-03-24.
 * 店铺信息
 */

public class StoreInformationBean {

    /**
     * {"code":0,"data":
     * {"background":"http:\/\/boyiapi.xxwlb.com\/uploads\/20180123\/19b5db9625de416ece576232bd494b77.jpg","countyid":378,"occupationid":24,"site":"\u4e91\u534e\u8def333\u53f77\u680b307","cityid":33,"provinceid":2,"shopimg":['http://boyiapi.xxwlb.com/uploads/20180123/28f089678984faf77a4019aa0271566d.jpg','http://boyiapi.xxwlb.com/uploads/20180123/f8a5e62caecd608e41fc4341a5f1f315.jpg','http://boyiapi.xxwlb.com/uploads/20180123/ae744290e913fd449d5e40590c0a64e2.jpg','http://boyiapi.xxwlb.com/uploads/20180123/796add39283df50e500e7fe6d2abd51a.jpg'],"team":1,"nickname":"\u7b56\u5212\u5e08\u58a8\u4fee\u6210","userid":16,"content":"2009\u5e746\u6708\uff0c\u53e4\u4eca\u7f18\u4f20\u7edf\u5a5a\u793c\u7b56\u5212\u516c\u53f8\u6210\u7acb\u4e8e\u56db\u5ddd\u6210\u90fd\uff0c\u53d1\u5c55\u81f3\u4eca\u53e4\u4eca\u7f18\uff08\u4e2d\u56fd\uff09\u4f20\u7edf\u5a5a\u793c\u6587\u5316、\u6210\u90fd\u53e4\u4eca\u7f18\u5a5a\u5e86\u793c\u4eea\u6709\u9650\u516c\u53f8\uff0c\u5df2\u6210\u4e3a\u4e2d\u56fd\u77e5\u540d\u4f20\u7edf\u4e2d、\u6c49\u5f0f\u5a5a\u793c\u8fde\u9501\u54c1\u724c\u670d\u52a1\u673a\u6784\uff0c\u4ea6\u662f\u4e2d\u56fd\u5f88\u65e9\u4e13\u4e1a\u4ece\u4e8b\u4e2d、\u6c49\u5f0f\u5a5a\u793c\u7814\u53d1\u4e0e\u63a8\u5e7f\u7684\u7814\u53d1\u578b\u7b56\u5212\u516c\u53f8。"},
     * "message":"ok"}
     */
    private String background;              //店铺背景
    private String cityid;                  //城市名称
    private String content;                 //店铺描述
    private String countyid;                //店铺区域
    private String nickname;                //店铺名称
    private String occupationid;               //职业类别
    private String provinceid;                 //省份
    private ArrayList<String> shopimg;      //店铺图片
    private String site;                    //详细地址
    private int team;                       //店铺类型
    private int userid;                     //店铺id
    private int usertype;
    private int onlinestatus;

    public int getOnlinestatus() {
        return onlinestatus;
    }

    public void setOnlinestatus(int onlinestatus) {
        this.onlinestatus = onlinestatus;
    }

    public int getUsertype() {
        return usertype;
    }

    public void setUsertype(int usertype) {
        this.usertype = usertype;
    }

    public String getBackground() {
        return background == null ? "" : background;
    }

    public void setBackground(String background) {
        this.background = background;
    }

    public String getCityid() {
        return cityid == null ? "" : cityid;
    }

    public void setCityid(String cityid) {
        this.cityid = cityid;
    }

    public String getContent() {
        return content == null ? "" : content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getCountyid() {
        return countyid == null ? "" : countyid;
    }

    public void setCountyid(String countyid) {
        this.countyid = countyid;
    }

    public String getNickname() {
        return nickname == null ? "" : nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getOccupationid() {
        return occupationid == null ? "" : occupationid;
    }

    public void setOccupationid(String occupationid) {
        this.occupationid = occupationid;
    }

    public String getProvinceid() {
        return provinceid == null ? "" : provinceid;
    }

    public void setProvinceid(String provinceid) {
        this.provinceid = provinceid;
    }

    public ArrayList<String> getShopimg() {
        return shopimg;
    }

    public void setShopimg(ArrayList<String> shopimg) {
        this.shopimg = shopimg;
    }

    public String getSite() {
        return site == null ? "" : site;
    }

    public void setSite(String site) {
        this.site = site;
    }

    public int getTeam() {
        return team;
    }

    public void setTeam(int team) {
        this.team = team;
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }

    public String getPathFormat() {
        String provinceid = getProvinceid() == null ? "" : getProvinceid();
        String cityid = getCityid() == null ? "" : getCityid();
        String countyid = getCountyid() == null ? "" : getCountyid();

        return provinceid + cityid + countyid;
    }

    public String getTeamFormat() {
        switch (team) {
            case 1:
                return "个人商家";
            case 2:
                return "团队商家";
            default:
                return "其它";
        }
    }

    public String getStatusFormat() {
        switch (onlinestatus) {
            case 1:
                return "上线";
            case 2:
                return "下线";
            default:
                return "上线";
        }
    }
}
