package com.linzi.xiguwen.bean;

/**
 * 接单数量
 */
public class TakingOrderNumBean {

    /**
     * {
     "date": "2018-04-12",
     "id": 55,
     "setnumber": 5
     }
     */

    private String date;
    private int id;
    private int setnumber;

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getSetnumber() {
        return setnumber;
    }

    public void setSetnumber(int setnumber) {
        this.setnumber = setnumber;
    }
}
