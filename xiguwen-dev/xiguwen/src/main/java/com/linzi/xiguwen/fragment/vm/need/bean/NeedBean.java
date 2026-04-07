package com.linzi.xiguwen.fragment.vm.need.bean;

/**
 * Created by PC on 2018-04-10.
 */

public class NeedBean extends BaseBean {

    private final String mName;
    private final String mValue;

    public NeedBean(String key, String name){
        this.mName = name;
        this.mValue = key;
    }

    @Override
    public String getValue() {
        return mValue;
    }

    @Override
    public String getName() {
        return mName;
    }
}
