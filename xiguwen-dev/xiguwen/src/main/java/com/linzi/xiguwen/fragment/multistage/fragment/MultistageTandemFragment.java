package com.linzi.xiguwen.fragment.multistage.fragment;

import android.os.Bundle;
import androidx.annotation.IdRes;
import androidx.annotation.Nullable;
import com.google.android.material.appbar.AppBarLayout;
import com.google.android.material.tabs.TabLayout;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentStatePagerAdapter;
import androidx.viewpager.widget.ViewPager;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.fragment.multistage.bean.MultistageTandemBean;
import com.linzi.xiguwen.utils.DPUtils;


/**
 * Title:
 * Description:多级联动Fragment
 * Copyright:Copyright(c)2018
 * Company: Cree
 * CreateTime:2018/3/26  17:17
 *
 * @author luyongjiang
 * @version 1.0
 */
public class MultistageTandemFragment extends Fragment {
    private ViewPager mViewPager;
    private TabLayout mTabLayout;
    private LayoutInflater mInflater;
    private AppBarLayout mAppBarLayout;

    private MultistageTandemBean mTandemBean;


    public static MultistageTandemFragment create(MultistageTandemBean mMultistageTandemBean) {
        MultistageTandemFragment fragment = new MultistageTandemFragment();
        fragment.setTandemBean(mMultistageTandemBean);
        return fragment;
    }

    public void setTandemBean(MultistageTandemBean tandemBean) {
        mTandemBean = tandemBean;
    }

    public void selectTab(int index) {
        if (mViewPager != null)
            mViewPager.setCurrentItem(index);
    }

    private View mItemView = null;

    private float mDensity = 1.0f;

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        if (mInflater == null) {
            mInflater = inflater;
        }
        mDensity = getResources().getDisplayMetrics().density;
        mItemView = inflater.inflate(R.layout.fr_multistage, container, false);
        initView();
        bindData();
        return mItemView;
    }


    private void initView() {
        mViewPager = findViewById(R.id.vp_fragment);
        mTabLayout = findViewById(R.id.tl_navigation);
        mAppBarLayout = findViewById(R.id.abl_bar);
    }

    private void bindData() {
        mViewPager.setAdapter(new PageAdapter(getActivity().getSupportFragmentManager()));
        mTabLayout.setupWithViewPager(mViewPager);
        //---------------------------设置自定义tab---------------------------------
        createNewTab();
        //---------------------------设置头部---------------------------------
        mAppBarLayout.addOnOffsetChangedListener(new AppBarLayout.OnOffsetChangedListener() {
            @Override
            public void onOffsetChanged(AppBarLayout appBarLayout, int verticalOffset) {
                float alpha = (Math.abs(verticalOffset)) / (appBarLayout.getHeight() - DPUtils.DPToPX(getContext(), 120));
                if (mTandemBean.getTitleBean().getOnHeadOffsetListener() != null) {
                    mTandemBean.getTitleBean().getOnHeadOffsetListener().onCallback(alpha, verticalOffset);
                }
            }
        });
        //---------------------------加入标题Fragment以及头部Fragment---------------------------------
        if (mTandemBean.getTitleBean().getHead() != null && mTandemBean.getTitleBean().getTitle() != null)
            getChildFragmentManager().beginTransaction()
                    .replace(R.id.fl_content, mTandemBean.getTitleBean().getHead(), HEAD)
                    .replace(R.id.fl_title, mTandemBean.getTitleBean().getTitle(), TITLE)
                    .commitAllowingStateLoss();

    }

    private static final String HEAD = "HEAD", TITLE = "TITLE";

    public <T> T findViewById(@IdRes int id) {
        return (T) mItemView.findViewById(id);
    }

    private void createNewTab() {
        for (int i = 0; i < mTandemBean.getNavigationBeans().size(); i++) {
            TabLayout.Tab tab = mTabLayout.getTabAt(i);//获得每一个tab
            tab.setCustomView(R.layout.item_tab_tv);//给每一个tab设置view
            if (i == 0) {
                // 设置第一个tab的TextView是被选择的样式
                tab.getCustomView().findViewById(R.id.tab_text).setSelected(true);//第一个tab被选中
            }
            TextView textView = (TextView) tab.getCustomView().findViewById(R.id.tab_text);
            textView.setText(mTandemBean.getNavigationBeans().get(i).getName());//设置tab上的文字
        }
    }


    private class PageAdapter extends FragmentStatePagerAdapter {


        public PageAdapter(FragmentManager fm) {
            super(fm);
        }

        @Override
        public int getCount() {
            return mTandemBean.getNavigationBeans().size();
        }

        @Override
        public Fragment getItem(int position) {
            return mTandemBean.getNavigationBeans().get(position).getFragment();
        }
    }
}
