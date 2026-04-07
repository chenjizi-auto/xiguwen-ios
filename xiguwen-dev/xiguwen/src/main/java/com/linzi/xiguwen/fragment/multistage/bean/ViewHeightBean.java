package com.linzi.xiguwen.fragment.multistage.bean;

/**
 * Title:
 * Description:视图高度对象,为什么要创建对象...可能以后会存在多多个视图设置高度
 * Copyright:Copyright(c)2018
 * Company: Cree
 * CreateTime:2018/3/26  17:18
 *
 * @author luyongjiang
 * @version 1.0
 */
public class ViewHeightBean {
    private float headHeight;

    public static ViewHeightBean create(float headHeight) {
        return new ViewHeightBean().setHeadHeight(headHeight);
    }

    public float getHeadHeight() {
        return headHeight;
    }

    public ViewHeightBean setHeadHeight(float headHeight) {
        this.headHeight = headHeight;
        return this;
    }
}
