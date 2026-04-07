package com.linzi.xiguwen.bean;

import java.io.Serializable;

/**
 * Created by PC on 2018-04-21.
 */

public class communityAddEntity implements Serializable {
//    address		string	@mock=云华路333号7栋307
//    addressd	社团地区	string	@mock=四川省-成都市-武侯区
//    appphotourl	app背景图	string	@mock=http://boyiapi.xxwlb.com/uploads/20180125/89b956f439ceb43342a20c65e05c3fb9.jpg
//    cityid		number	@mock=273
//    countyid		number	@mock=2639
//    id	社团id	number	@mock=8
//    logourl	社团logo	string	@mock=http://boyiapi.xxwlb.com/uploads/20180125/08392e6129286bf0381f7dde9dc5a7d8.jpg
//    mobile		string	@mock=18581882801
//    name	社团名称	string	@mock=古今缘婚庆团队111
//    profile		string	@mock=2009年6月，古今缘传统婚礼策划公司成立于四川成都，发展至今古今缘（中国）传统婚礼文化、成都古今缘婚庆礼仪有限公司，已成为中国知名传统中、汉式婚礼连锁品牌服务机构，亦是中国很早专业从事中、汉式婚礼研发与推广的研发型策划公司。
//    profiled		string	@mock=2009年6月，古今缘传统婚礼策划公司成立于四川成都，发展至今古今缘（中国）传统婚礼文化、成都古今缘
//    provinceid		number	@mock=24
//    renshu	社团人数	number	@mock=6
//    status	0 可加入 1可退出 21同意加入 22等待同意	number	@mock=0
//    type	社团类型	string	@mock=主持人

    private String id;
    private String address;
    private String addressd;
    private String appphotourl;
    private String cityid;
    private String countyid;
    private String logourl;
    private String mobile;
    private String profile;
    private String profiled;
    private String provinceid;
    private String renshu;
    private int status;
    private String type;
    private String name;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
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

    public String getAddressd() {
        return addressd;
    }

    public void setAddressd(String addressd) {
        this.addressd = addressd;
    }

    public String getAppphotourl() {
        return appphotourl;
    }

    public void setAppphotourl(String appphotourl) {
        this.appphotourl = appphotourl;
    }

    public String getCityid() {
        return cityid;
    }

    public void setCityid(String cityid) {
        this.cityid = cityid;
    }

    public String getCountyid() {
        return countyid;
    }

    public void setCountyid(String countyid) {
        this.countyid = countyid;
    }

    public String getLogourl() {
        return logourl;
    }

    public void setLogourl(String logourl) {
        this.logourl = logourl;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getProfile() {
        return profile;
    }

    public void setProfile(String profile) {
        this.profile = profile;
    }

    public String getProfiled() {
        return profiled;
    }

    public void setProfiled(String profiled) {
        this.profiled = profiled;
    }

    public String getProvinceid() {
        return provinceid;
    }

    public void setProvinceid(String provinceid) {
        this.provinceid = provinceid;
    }

    public String getRenshu() {
        return renshu;
    }

    public void setRenshu(String renshu) {
        this.renshu = renshu;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}
