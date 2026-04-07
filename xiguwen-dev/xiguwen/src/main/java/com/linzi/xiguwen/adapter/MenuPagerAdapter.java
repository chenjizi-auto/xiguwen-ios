package com.linzi.xiguwen.adapter;

import android.content.Context;

import androidx.viewpager.widget.PagerAdapter;
import androidx.viewpager.widget.ViewPager;
import android.view.View;
import android.view.ViewGroup;

import java.util.List;

/**
 * Created by linzi on 2017/8/7.
 */

public class MenuPagerAdapter extends PagerAdapter {
    Context mContext;
    List<View>mList;

    public MenuPagerAdapter(Context mContext, List<View> mList) {
        this.mContext = mContext;
        this.mList = mList;
    }

    @Override
    public int getCount() {
        return mList==null?0:mList.size();
    }

    @Override
    public boolean isViewFromObject(View view, Object object) {
        return view==object;
    }

    @Override
    public Object instantiateItem(ViewGroup container, int position) {
//        ((ViewPager) container).removeAllViews();
        ((ViewPager)container).addView(mList.get(position));
        return mList.get(position);
    }

    @Override
    public void destroyItem(ViewGroup container, int position, Object object) {
//        super.destroyItem(container, position, object);
        ((ViewPager) container).removeView(mList.get(position));
    }
}
