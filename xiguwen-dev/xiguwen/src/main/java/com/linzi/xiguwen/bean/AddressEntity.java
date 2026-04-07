package com.linzi.xiguwen.bean;

import java.io.Serializable;

/**
 * Created by devin on 2018/4/17 16:14
 * Description
 */

public class AddressEntity implements Serializable {
    //        "id": 82,
//                "userid": 16,
//                "username": "",
//                "mobile": "1354654135",
//                "provinceid": 30,
//                "cityid": 353,
//                "countyid": 3371,
//                "province": "青海省",
//                "city": "",
//                "county": "泽库县",
//                "site": "四川省成都市云华路33",
//                "hot": 1
    private String id;
    private String username;
    private String mobile;
    private String province;
    private String county;
    private String site;
    private int hot;
    private String city;

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getCounty() {
        return county;
    }

    public void setCounty(String county) {
        this.county = county;
    }

    public String getSite() {
        return site;
    }

    public void setSite(String site) {
        this.site = site;
    }

    public int getHot() {
        return hot;
    }

    public void setHot(int hot) {
        this.hot = hot;
    }
}
