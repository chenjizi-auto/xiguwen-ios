package com.linzi.xiguwen.bean;

/**
 * Created by PC on 2018-03-28.
 * 服务城市类
 */

public class ServiceCity {
    /**
     * {
     "city": "【成都市】",
     "id": 2,
     "province": "四川省",
     "userid": 16,
     "username": "18581882801",
     "weight": 1
     }
     */

    private int id;
    private String province;
    private String city;
    private int userid;
    private String username;
    private int weight;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
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

    public int getWeight() {
        return weight;
    }

    public void setWeight(int weight) {
        this.weight = weight;
    }
}
