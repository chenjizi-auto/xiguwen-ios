package com.linzi.xiguwen.bean;

import java.io.Serializable;

/**
 * Created by PC on 2018-04-12.
 */

public class CommodityInventoryBean implements Serializable {
    private String sku1name;   // 属性1
    private String sku2name;   // 属性2
    private String prices;   // 价格
    private String number;   //库存

    public String getSku1name() {
        return sku1name;
    }

    public void setSku1name(String sku1name) {
        this.sku1name = sku1name;
    }

    public String getSku2name() {
        return sku2name;
    }

    public void setSku2name(String sku2name) {
        this.sku2name = sku2name;
    }

    public String getPrices() {
        return prices;
    }

    public void setPrices(String prices) {
        this.prices = prices;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }
}
