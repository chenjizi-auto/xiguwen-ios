package com.linzi.xiguwen.adapter;

/**
 * Created by jiang on 2016/11/25.
 */

import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentStatePagerAdapter;
import android.view.ViewGroup;

import java.util.List;

public class ViewPagerAdapter extends FragmentStatePagerAdapter {

    public FragmentManager fm;
    public List<Fragment> list;
    private List<String> liststr;

    public ViewPagerAdapter(FragmentManager fm, List<Fragment> mFragmentList, List<String> liststr) {
        super(fm);
        this.fm = fm;
        this.list = mFragmentList;
        this.liststr = liststr;
    }

    public ViewPagerAdapter(FragmentManager fm, List<Fragment> list) {
        super(fm);
        this.fm = fm;
        this.list = list;
    }


    public void setTitle(List<String> liststr) {
        this.liststr = liststr;
        notifyDataSetChanged();
    }

    @Override
    public Fragment getItem(int position) {
        return list.get(position);
    }

    @Override
    public int getCount() {
        return list == null ? 0 : list.size();
    }

    @Override
    public Fragment instantiateItem(ViewGroup container, int position) {
        Fragment fragment = (Fragment) super.instantiateItem(container,
                position);
        if (fragment != null) {
            fm.beginTransaction().show(fragment).commit();
        }
        return fragment;
    }

    @Override
    public CharSequence getPageTitle(int position) {
        return liststr.get(position);
    }

    public void removeAllFragment() {
        for (Fragment childFragment : fm.getFragments()) {
            list.remove(childFragment);
            fm.beginTransaction().remove(childFragment).commit();
        }
    }

    @Override
    public void destroyItem(ViewGroup container, int position, Object object) {
        // super.destroyItem(container, position, object);
        Fragment fragment = list.get(position);
        if (fragment != null) {
            fm.beginTransaction().hide(fragment).commit();
        }
    }
}

