package com.linzi.xiguwen.bean;

import java.io.Serializable;
import java.util.List;

/**
 * Created by PC on 2018-04-15.
 */

public class SearchSJBean implements Serializable {
    private String type;
    private List<WhthinBean> shangjia;
    private List<CaseBean.DataBean> anli;
    private List<ShopEntity> shop;
    private List<PriceEntity> baojia;


    public List<ShopEntity> getShop() {
        return shop;
    }

    public void setShop(List<ShopEntity> shop) {
        this.shop = shop;
    }

    public List<PriceEntity> getBaojia() {
        return baojia;
    }

    public void setBaojia(List<PriceEntity> baojia) {
        this.baojia = baojia;
    }

    public List<CaseBean.DataBean> getAnli() {
        return anli;
    }

    public void setAnli(List<CaseBean.DataBean> anli) {
        this.anli = anli;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public List<WhthinBean> getShangjia() {
        return shangjia;
    }

    public void setShangjia(List<WhthinBean> shangjia) {
        this.shangjia = shangjia;
    }
}
