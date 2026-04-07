package com.linzi.xiguwen.bean;

import java.io.Serializable;

/**
 * Created by PC on 2018-04-15.
 */

public class CaseTypeEntity implements Serializable {

    private int id;
    private String title;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
}
