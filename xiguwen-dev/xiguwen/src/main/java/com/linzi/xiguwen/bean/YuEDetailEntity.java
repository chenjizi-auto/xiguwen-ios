package com.linzi.xiguwen.bean;

import java.io.Serializable;

/**
 * Created by devin on 2018/4/16 14:51
 * Description
 */

public class YuEDetailEntity implements Serializable {
//           "id": 310,
//                   "userid": 16,
//                   "subject": "[订单]wedding2018041611370247400完成",
//                   "beforemoney": "6515.19",
//                   "inmoney": "0.08",
//                   "outmoney": "0.00",
//                   "aftermoney": "6515.27",
//                   "trade_type": 1,
//                   "remark": "[订单]wedding2018041611370247400完成",
//                   "created_at": 1523849878,
//                   "updated_at": 0,
//                   "relation_model": "ordershq",
//                   "relation_id": 702

    private int id;
    private String subject;
    private String beforemoney;
    private String inmoney;
    private String outmoney;
    private String aftermoney;
    private int trade_type;
    private String remark;
    private String created_at;
    private String updated_at;
    private String relation_model;
    private String relation_id;


    public String getOutmoney() {
        return outmoney;
    }

    public void setOutmoney(String outmoney) {
        this.outmoney = outmoney;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getBeforemoney() {
        return beforemoney;
    }

    public void setBeforemoney(String beforemoney) {
        this.beforemoney = beforemoney;
    }

    public String getInmoney() {
        return inmoney;
    }

    public void setInmoney(String inmoney) {
        this.inmoney = inmoney;
    }

    public String getAftermoney() {
        return aftermoney;
    }

    public void setAftermoney(String aftermoney) {
        this.aftermoney = aftermoney;
    }

    public int getTrade_type() {
        return trade_type;
    }

    public void setTrade_type(int trade_type) {
        this.trade_type = trade_type;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getCreated_at() {
        return created_at;
    }

    public void setCreated_at(String created_at) {
        this.created_at = created_at;
    }

    public String getUpdated_at() {
        return updated_at;
    }

    public void setUpdated_at(String updated_at) {
        this.updated_at = updated_at;
    }

    public String getRelation_model() {
        return relation_model;
    }

    public void setRelation_model(String relation_model) {
        this.relation_model = relation_model;
    }

    public String getRelation_id() {
        return relation_id;
    }

    public void setRelation_id(String relation_id) {
        this.relation_id = relation_id;
    }
}
