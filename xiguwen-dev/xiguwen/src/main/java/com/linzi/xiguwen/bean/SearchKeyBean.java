package com.linzi.xiguwen.bean;

import java.io.Serializable;
import java.util.List;

/**
 * Created by PC on 2018-04-14.
 */

public class SearchKeyBean implements Serializable {

    private List<SearchKeyHotBean> hot;

    public List<SearchKeyHotBean> getHot() {
        return hot;
    }

    public void setHot(List<SearchKeyHotBean> hot) {
        this.hot = hot;
    }
}
