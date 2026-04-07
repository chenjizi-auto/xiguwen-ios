package com.linzi.xiguwen.bean;

import java.io.Serializable;

/**
 * Created by devin on 2018/4/20 10:34
 * Description
 */

public class AgreementEntity implements Serializable {
    private String content;
    private String title;

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
}
