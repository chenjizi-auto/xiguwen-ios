package com.linzi.xiguwen.bean;

import java.io.Serializable;
import java.util.List;

/**
 * Created by devin on 2018/4/13 16:19
 * Description
 */

public class CityData implements Serializable{

    private List<CityEntity> newsite;
    private List<CityEntity> site;

    public List<CityEntity> getNewsite() {
        return newsite;
    }

    public void setNewsite(List<CityEntity> newsite) {
        this.newsite = newsite;
    }

    public List<CityEntity> getSite() {
        return site;
    }

    public void setSite(List<CityEntity> site) {
        this.site = site;
    }
}
