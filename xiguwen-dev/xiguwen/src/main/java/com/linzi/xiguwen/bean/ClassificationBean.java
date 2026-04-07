package com.linzi.xiguwen.bean;

import java.io.Serializable;

/**
 * Title:
 * Description:
 * Copyright:Copyright(c)2018
 * Company: Cree
 * CreateTime:2018/3/23  09:36
 *
 * @author luyongjiang
 * @version 1.0
 */
public class ClassificationBean implements Serializable{
    /**
     * occupationid : 21
     * proname : 婚宴酒店
     * wapimg : http://imgcache.boyihunjia.com/97cd6201803191557504246.png
     */

    private int occupationid;
    private String proname;
    private String wapimg;

    public int getOccupationid() {
        return occupationid;
    }

    public void setOccupationid(int occupationid) {
        this.occupationid = occupationid;
    }

    public String getProname() {
        return proname;
    }

    public void setProname(String proname) {
        this.proname = proname;
    }

    public String getWapimg() {
        return wapimg;
    }

    public void setWapimg(String wapimg) {
        this.wapimg = wapimg;
    }

}
