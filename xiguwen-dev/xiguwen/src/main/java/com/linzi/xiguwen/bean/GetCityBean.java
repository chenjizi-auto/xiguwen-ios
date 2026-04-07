package com.linzi.xiguwen.bean;

/**
 * Title:
 * Description:
 * Copyright:Copyright(c)2018
 * Company: Cree
 * CreateTime:2018/3/22  17:28
 *
 * @author luyongjiang
 * @version 1.0
 */
public class GetCityBean {

    /**
     * id : 2636
     * cityid : 510104
     * name : 锦江区
     * pid : 273
     * pinyin : Jinjiang Qu
     * initial : J
     * lv : 3
     * isnew : 0
     * status : 1
     * weigh : 0
     */

    private int id;
    private String cityid;
    private String name;
    private int pid;
    private String pinyin;
    private String initial;
    private String lv;
    private int isnew;
    private int status;
    private int weigh;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCityid() {
        return cityid;
    }

    public void setCityid(String cityid) {
        this.cityid = cityid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getPid() {
        return pid;
    }

    public void setPid(int pid) {
        this.pid = pid;
    }

    public String getPinyin() {
        return pinyin;
    }

    public void setPinyin(String pinyin) {
        this.pinyin = pinyin;
    }

    public String getInitial() {
        return initial;
    }

    public void setInitial(String initial) {
        this.initial = initial;
    }

    public String getLv() {
        return lv;
    }

    public void setLv(String lv) {
        this.lv = lv;
    }

    public int getIsnew() {
        return isnew;
    }

    public void setIsnew(int isnew) {
        this.isnew = isnew;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getWeigh() {
        return weigh;
    }

    public void setWeigh(int weigh) {
        this.weigh = weigh;
    }

    @Override
    public String toString() {
        return "GetCityBean{" +
                "id=" + id +
                ", cityid='" + cityid + '\'' +
                ", name='" + name + '\'' +
                ", pid=" + pid +
                ", pinyin='" + pinyin + '\'' +
                ", initial='" + initial + '\'' +
                ", lv='" + lv + '\'' +
                ", isnew=" + isnew +
                ", status=" + status +
                ", weigh=" + weigh +
                '}';
    }
}
