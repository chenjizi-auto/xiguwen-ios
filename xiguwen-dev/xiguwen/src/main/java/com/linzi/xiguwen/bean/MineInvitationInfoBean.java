package com.linzi.xiguwen.bean;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by PC on 2018-04-10.
 * 我的邀请信息对象
 */

public class MineInvitationInfoBean {
    /**
     * {
     * list:[
     * {
     "created_at": "2018-03-09 15:08:05",
     "mobile": "18993644298"
     }
     ],
     "money": "1000.00",
     "num": 10
     }
     */

    private ArrayList<InvitationDetail> list;
    private String money;
    private int num;

    public ArrayList<InvitationDetail> getList() {
        return list;
    }

    public void setList(ArrayList<InvitationDetail> list) {
        this.list = list;
    }

    public String getMoney() {
        return money;
    }

    public void setMoney(String money) {
        this.money = money;
    }

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }

    public static class InvitationDetail implements Serializable{
        private String created_at;
        private String mobile;

        public String getCreated_at() {
            return created_at;
        }

        public void setCreated_at(String created_at) {
            this.created_at = created_at;
        }

        public String getMobile() {
            return mobile;
        }

        public void setMobile(String mobile) {
            this.mobile = mobile;
        }
    }
}
