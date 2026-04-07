package com.linzi.xiguwen.adapter;

/**
 * Created by jiang on 2016/11/25.
 */

import android.os.Bundle;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentPagerAdapter;
import android.view.ViewGroup;

import java.util.List;

public class PagerAdapter extends FragmentPagerAdapter {

    public FragmentManager fm;
    public List<Fragment> list;

    public PagerAdapter(FragmentManager fm) {
        super(fm);
    }

    public PagerAdapter(FragmentManager fm, List<Fragment> list) {
        super(fm);
        this.fm = fm;
        this.list = list;
    }

    @Override
    public Fragment getItem(int position) {
        Fragment fragment = null;
        com.linzi.xiguwen.utils.LogUtil.i("sssssssssssss", "getItem");
        fragment = list.get(position);
        Bundle bundle = fragment.getArguments();
        if (bundle == null) {
            bundle = new Bundle();
        }
        bundle.putString("id", "" + position);
        fragment.setArguments(bundle);
        return fragment;
    }

    @Override
    public int getCount() {
        return list.size();
    }

    @Override
    public Fragment instantiateItem(ViewGroup container, int position) {
        Fragment fragment = (Fragment) super.instantiateItem(container,
                position);
        fm.beginTransaction().show(fragment).commit();
        return fragment;
    }

    @Override
    public void destroyItem(ViewGroup container, int position, Object object) {
        // super.destroyItem(container, position, object);
        Fragment fragment = list.get(position);
        fm.beginTransaction().hide(fragment).commit();
    }
}

