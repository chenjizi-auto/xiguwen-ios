package com.linzi.xiguwen.bean;

/**
 * Created by linzi on 2017/8/8.
 */

public class CalendarBean {
    private int id;
    private String data;
    private boolean isChecked;
    private boolean isJi;

    public boolean isJi() {
        return isJi;
    }

    public void setJi(boolean ji) {
        isJi = ji;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }

    public boolean isChecked() {
        return isChecked;
    }

    public void setChecked(boolean checked) {
        isChecked = checked;
    }
}
