package com.linzi.xiguwen.fragment.shop.model;

import com.linzi.xiguwen.bean.ShopUserDetailsBean;
import com.linzi.xiguwen.fragment.multistage.bean.MultistageTandemBean;
import com.linzi.xiguwen.fragment.multistage.fragment.MultistageTandemFragment;

import java.util.List;

/**
 * Created by pc on 2018/3/29.
 */

public interface ShopUserDetailModel {
    ShopUserDetailsBean.UserBean getUserBean();

    ShopUserDetailsBean.UserinfoBean getUserinfoBean();

    int getUserf();

    MultistageTandemFragment getBean();

}
