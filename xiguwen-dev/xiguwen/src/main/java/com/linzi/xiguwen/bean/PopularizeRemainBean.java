package com.linzi.xiguwen.bean;



/**
 * Created by PC on 2018-03-29.
 * 推广助手剩余广告位
 */

public class PopularizeRemainBean extends com.linzi.xiguwen.net.base.BaseBean<String>{
/**
 * {
 "code": 0,
 "date": "2018-02-02",
 "message": "ok",
 "sum": 30,
 "user": 16335
 }
 */
    private String date;
    private int sum;
    private long user;
    private String money;

    public String getMoney() {
        return money;
    }

    public void setMoney(String money) {
        this.money = money;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public int getSum() {
        return sum;
    }

    public void setSum(int sum) {
        this.sum = sum;
    }

    public long getUser() {
        return user;
    }

    public void setUser(long user) {
        this.user = user;
    }
}
