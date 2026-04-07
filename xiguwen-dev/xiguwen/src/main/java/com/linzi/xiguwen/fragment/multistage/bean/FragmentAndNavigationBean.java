package com.linzi.xiguwen.fragment.multistage.bean;

import androidx.fragment.app.Fragment;

/**
 * Title:
 * Description:创建联动Fragment需要用到的实体类
 * Copyright:Copyright(c)2018
 * Company: Cree
 * CreateTime:2018/3/26  17:14
 *
 * @author luyongjiang
 * @version 1.0
 */
public class FragmentAndNavigationBean {
    private String name;
    private Fragment mFragment;

    public static FragmentAndNavigationBean create(String name, Fragment fragment) {
        return new FragmentAndNavigationBean().setFragment(fragment).setName(name);
    }

    public String getName() {
        return name;
    }

    public FragmentAndNavigationBean setName(String name) {
        this.name = name;
        return this;
    }

    public Fragment getFragment() {
        return mFragment;
    }

    public FragmentAndNavigationBean setFragment(Fragment fragment) {
        mFragment = fragment;
        return this;
    }
}
