package com.linzi.xiguwen.bean;

/**
 * Created by pc on 2018/5/25.
 */

public class JiFenOrderBean {

    /**
     * id : 1
     * jiage : 0
     * jifen : 20
     * name : 商品1
     * tupian : http://imgcache.boyihunjia.com/513dd201805151151121552.jpg
     * shangjianame : 博艺婚嫁
     */

    private int id;
    private String jiage;
    private int jifen;
    private String name;
    private String tupian;
    private String shangjianame;

    private String liuyan;

    public String getLiuyan() {
        return liuyan;
    }

    public void setLiuyan(String liuyan) {
        this.liuyan = liuyan;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getJiage() {
        return jiage;
    }

    public void setJiage(String jiage) {
        this.jiage = jiage;
    }

    public int getJifen() {
        return jifen;
    }

    public void setJifen(int jifen) {
        this.jifen = jifen;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getTupian() {
        return tupian;
    }

    public void setTupian(String tupian) {
        this.tupian = tupian;
    }

    public String getShangjianame() {
        return shangjianame;
    }

    public void setShangjianame(String shangjianame) {
        this.shangjianame = shangjianame;
    }
}
