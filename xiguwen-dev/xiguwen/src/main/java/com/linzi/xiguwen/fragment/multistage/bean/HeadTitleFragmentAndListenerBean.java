package com.linzi.xiguwen.fragment.multistage.bean;

import androidx.fragment.app.Fragment;

/**
 * Title:
 * Description:
 * Copyright:Copyright(c)2018
 * Company: Cree
 * CreateTime:2018/3/26  17:24
 *
 * @author luyongjiang
 * @version 1.0
 */
public class HeadTitleFragmentAndListenerBean {
    private Fragment head, title;
    private OnHeadOffsetListener mOnHeadOffsetListener;


    public static HeadTitleFragmentAndListenerBean create(Fragment head, Fragment title, OnHeadOffsetListener onHeadOffsetListener) {
        return new HeadTitleFragmentAndListenerBean().setHead(head).setTitle(title).setOnHeadOffsetListener(onHeadOffsetListener);
    }

    public Fragment getHead() {
        return head;
    }

    public HeadTitleFragmentAndListenerBean setHead(Fragment head) {
        this.head = head;
        return this;
    }

    public Fragment getTitle() {
        return title;
    }

    public HeadTitleFragmentAndListenerBean setTitle(Fragment title) {
        this.title = title;
        return this;
    }

    public OnHeadOffsetListener getOnHeadOffsetListener() {
        return mOnHeadOffsetListener;
    }

    public HeadTitleFragmentAndListenerBean setOnHeadOffsetListener(OnHeadOffsetListener onHeadOffsetListener) {
        mOnHeadOffsetListener = onHeadOffsetListener;
        return this;
    }

    /**
     * 用于head滑动值的传递
     */
    public static interface OnHeadOffsetListener {
        void onCallback(float alpha, float offset);
    }
}
