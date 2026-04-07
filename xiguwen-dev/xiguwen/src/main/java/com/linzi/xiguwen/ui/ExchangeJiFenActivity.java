package com.linzi.xiguwen.ui;

import android.os.Bundle;
import com.google.android.material.tabs.TabLayout;
import androidx.fragment.app.Fragment;
import androidx.viewpager.widget.ViewPager;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.ViewPagerAdapter;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.fragment.jifen.GoodsJiFenFragment;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by pc on 2018/5/23.
 */

public class ExchangeJiFenActivity extends BaseActivity {
    @BindView(R.id.tab_title)
    TabLayout tabTitle;
    @BindView(R.id.pager)
    ViewPager pager;

    private List<Fragment> mFragmentList;

    ViewPagerAdapter pagerAdapter;

    private List<String> titlelist;


    @Override
    protected void initData() {

    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.exchangejifen_layout);
        ButterKnife.bind(this);
        initView();
    }

    private void initView() {
        setBack();
        setTitle("兑换记录");

        titlelist = new ArrayList<>();
        titlelist.add("商品兑换");
        titlelist.add("红包兑换");

        getFragment();
        pagerAdapter = new ViewPagerAdapter(getSupportFragmentManager(), mFragmentList, titlelist);
        pager.setAdapter(pagerAdapter);
        pager.setCurrentItem(0);
        tabTitle.setupWithViewPager(pager);

        initFristTab();
    }

    //加载第一个tablayout tab
    private void initFristTab() {
        for (int i = 0; i < titlelist.size(); i++) {
            TabLayout.Tab tab = tabTitle.getTabAt(i);
            tab.setCustomView(R.layout.jifen_tab);
            TextView textView = (TextView) tab.getCustomView().findViewById(R.id.tv_title);
            textView.setText(titlelist.get(i));//设置tab上的文字
            textView.setTextSize(16);
        }
        //setIndicator(getActivity(), tabTitle, 70, 70);
    }

    private List<Fragment> getFragment() {
        if (mFragmentList != null) {
            mFragmentList.clear();
        } else {
            mFragmentList = new ArrayList<>();
        }
        for (int x = 0; x < 2; x++) {//0商品兑换 1红包兑换
            mFragmentList.add(GoodsJiFenFragment.newInstance(x));
        }
        return mFragmentList;
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
         
    }
}
