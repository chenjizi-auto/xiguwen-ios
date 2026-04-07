package com.linzi.xiguwen.bean;

import java.io.Serializable;

/**
 * Created by jiang on 2018/2/11.
 */

public class ListPeoBean implements Serializable {
    private String head;
    private String name;
    private String zhiye;
    private String phone;
    private boolean invated;

    public String getHead() {
        return head;
    }

    public void setHead(String head) {
        this.head = head;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getZhiye() {
        return zhiye;
    }

    public void setZhiye(String zhiye) {
        this.zhiye = zhiye;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public boolean isInvated() {
        return invated;
    }

    public void setInvated(boolean invated) {
        this.invated = invated;
    }
}
