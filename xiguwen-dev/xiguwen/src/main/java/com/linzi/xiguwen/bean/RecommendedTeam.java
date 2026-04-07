package com.linzi.xiguwen.bean;

/**
 * Created by PC on 2018-03-28.
 * 我的推荐团队类
 */

public class RecommendedTeam {
    /**
     *  {
     "create_ti": 1514884017,
     "id": 3,
     "nickname": "店铺名称未填写",
     "shopcode": "12",
     "update_ti": 1515159629,
     "userid": 16,
     "username": "18581882801",
     "weight": 1
     }
     */

    private int id;
    private long create_ti;
    private String nickname;
    private String shopcode;
    private long update_ti;
    private int userid;
    private String username;
    private int weight;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public long getCreate_ti() {
        return create_ti;
    }

    public void setCreate_ti(long create_ti) {
        this.create_ti = create_ti;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getShopcode() {
        return shopcode;
    }

    public void setShopcode(String shopcode) {
        this.shopcode = shopcode;
    }

    public long getUpdate_ti() {
        return update_ti;
    }

    public void setUpdate_ti(long update_ti) {
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

    public int getWeight() {
        return weight;
    }

    public void setWeight(int weight) {
        this.weight = weight;
    }
}
