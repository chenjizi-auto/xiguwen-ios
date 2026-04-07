package com.linzi.xiguwen.bean;

import java.io.Serializable;

/**
 * Created by PC on 2018-04-21.
 */

public class CommunityCenterEntity implements Serializable {
//    address		string	@mock=云华路333号7栋307
//    appphotourl		string	@mock=http://boyiapi.xxwlb.com/uploads/20180125/89b956f439ceb43342a20c65e05c3fb9.jpg
//    chengyuan	成员数	number	@mock=2
//    cityid		number	@mock=273
//    clicked		number	@mock=422
//    countyid		number	@mock=2639
//    create_ti		number	@mock=1515391982
//    cydangqi	成员档期	number
//    dizhi	地区	string	@mock=成都市武侯区
//    id	id	number	@mock=8
//    jiaid	加入的id	number
//    jrxinzeng	今日新增	number
//    jryoudan	今日有单	number
//    logourl	社团logo	string	@mock=http://boyiapi.xxwlb.com/uploads/20180125/08392e6129286bf0381f7dde9dc5a7d8.jpg
//    name	社团名称	string	@mock=古今缘婚庆团队
//    profile		string	@mock=2009年6月，古今缘传统婚礼策划公司成立于四川成都，发展至今古今缘（中国）传统婚礼文化、成都古今缘婚庆礼仪有限公司，已成为中国知名传统中、汉式婚礼连锁品牌服务机构，亦是中国很早专业从事中、汉式婚礼研发与推广的研发型策划公司。
//    provinceid		number	@mock=24
//    type	社团职业	string	@mock=主持人
//    update_ti		number	@mock=1517838754
//    userid		number	@mock=16
//    username		string	@mock=18581882801

    private String id;
    private String address;
    private String appphotourl;
    private String chengyuan;
    private String cityid;
    private String clicked;
    private String create_ti;
    private String cydangqi;
    private String dizhi;
    private String jiaid;
    private String jrxinzeng;
    private String jryoudan;
    private String logourl;
    private String name;
    private String profile;
    private String type;
    private String update_ti;
    private int userid;
    private String username;

    private int jiaose;

    public int getJiaose() {
        return jiaose;
    }

    public void setJiaose(int jiaose) {
        this.jiaose = jiaose;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getAppphotourl() {
        return appphotourl;
    }

    public void setAppphotourl(String appphotourl) {
        this.appphotourl = appphotourl;
    }

    public String getChengyuan() {
        return chengyuan;
    }

    public void setChengyuan(String chengyuan) {
        this.chengyuan = chengyuan;
    }

    public String getCityid() {
        return cityid;
    }

    public void setCityid(String cityid) {
        this.cityid = cityid;
    }

    public String getClicked() {
        return clicked;
    }

    public void setClicked(String clicked) {
        this.clicked = clicked;
    }

    public String getCreate_ti() {
        return create_ti;
    }

    public void setCreate_ti(String create_ti) {
        this.create_ti = create_ti;
    }

    public String getCydangqi() {
        return cydangqi;
    }

    public void setCydangqi(String cydangqi) {
        this.cydangqi = cydangqi;
    }

    public String getDizhi() {
        return dizhi;
    }

    public void setDizhi(String dizhi) {
        this.dizhi = dizhi;
    }

    public String getJiaid() {
        return jiaid;
    }

    public void setJiaid(String jiaid) {
        this.jiaid = jiaid;
    }

    public String getJrxinzeng() {
        return jrxinzeng;
    }

    public void setJrxinzeng(String jrxinzeng) {
        this.jrxinzeng = jrxinzeng;
    }

    public String getJryoudan() {
        return jryoudan;
    }

    public void setJryoudan(String jryoudan) {
        this.jryoudan = jryoudan;
    }

    public String getLogourl() {
        return logourl;
    }

    public void setLogourl(String logourl) {
        this.logourl = logourl;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getProfile() {
        return profile;
    }

    public void setProfile(String profile) {
        this.profile = profile;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getUpdate_ti() {
        return update_ti;
    }

    public void setUpdate_ti(String update_ti) {
        this.update_ti = update_ti;
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
}
