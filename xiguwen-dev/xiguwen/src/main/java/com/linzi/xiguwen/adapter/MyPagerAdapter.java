package com.linzi.xiguwen.adapter;

import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentManager;
import android.view.View;

import java.util.List;

/**
 * Created by pc on 2018/3/28.
 */

public class MyPagerAdapter extends PagerAdapter {
    private List<Fragment> list;

    public MyPagerAdapter(FragmentManager fm, List<Fragment> list) {
        super(fm, list);
        this.list = list;
    }

    @Override
    public int getCount() {
        return list == null ? 0 : list.size();
    }

    @Override
    public boolean isViewFromObject(View view, Object object) {
        return view == object;
    }


}
