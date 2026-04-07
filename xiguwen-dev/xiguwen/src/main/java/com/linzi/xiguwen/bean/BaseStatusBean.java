package com.linzi.xiguwen.bean;

import java.io.Serializable;

/**
 * Created by PC on 2018-03-28.
 */

public abstract class BaseStatusBean implements Serializable{
    /*审核中*/
    public static final int STATE_ON = 1 ;//
    /*审核通过*/
    public static final int STATE_PASS = 2;
    /*审核未通过*/
    public static final int STATE_FAILED = 3;
    /*未提交*/
    public static final int STATE_NO_SUBMIT_0 = 0; // 0为图册和案例的未提交
    public static final int STATE_NO_SUBMIT_4 = 4;  //4为视频和报价的未提交


    /**
     * 已经上架
     */
    public static final int STATUS_PUT_ON_SHELVES = 1;// 已上架
    /**
     * 已经下架
     */
    public static final int STATUS_PUT_OFF_SHELVES = 0;// 已下架


    // 获取上下架状态
    public abstract int getMyStatus();
    // 获取审核状态
    public abstract int getMyState();
    // 获取标题
    public abstract String getMyTitle();
    // 获取显示内容
    public abstract String getMyContent();
    // 获取图标
    public abstract String getMyCover();
}
