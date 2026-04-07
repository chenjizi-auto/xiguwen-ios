package com.linzi.xiguwen.bean;

/**
 * Created by PC on 2018-03-24.
 * 认证类
 */

public class RenZhengBean {
    /**
     * {
     　　　　　　"id":2,
     　　　　　　"parameter1":"平台认证",
     　　　　　　"parameter2":"300.00",
     　　　　　　"mark":"0"
     　　　　}
     */

    private int id;                 //
    private String parameter1;      // 名称
    private String parameter2;      // 金额
    private String mark;            //

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getParameter1() {
        return parameter1;
    }

    public void setParameter1(String parameter1) {
        this.parameter1 = parameter1;
    }

    public String getParameter2() {
        return parameter2;
    }

    public void setParameter2(String parameter2) {
        this.parameter2 = parameter2;
    }

    public String getMark() {
        return mark;
    }

    public void setMark(String mark) {
        this.mark = mark;
    }

//    public float getPrice(){
//        float price = -1;
//        try {
//            price = Float.parseFloat(getParameter2());
//        }catch (Exception e){
//            com.linzi.xiguwen.utils.LogUtil.printStackTrace(e);
//        }
//        return price;
//    }

    public String getName(){
        return getParameter1();
    }
}
