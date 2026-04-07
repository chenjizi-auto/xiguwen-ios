package com.linzi.xiguwen.ui;

import android.content.Context;
import android.graphics.Color;
import android.os.Bundle;
import androidx.fragment.app.Fragment;
import androidx.viewpager.widget.ViewPager;
import android.view.View;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.ViewPagerAdapter;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.component.magicindicator.MagicIndicator;
import com.linzi.xiguwen.component.magicindicator.ViewPagerHelper;
import com.linzi.xiguwen.component.magicindicator.buildins.commonnavigator.CommonNavigator;
import com.linzi.xiguwen.component.magicindicator.buildins.commonnavigator.abs.CommonNavigatorAdapter;
import com.linzi.xiguwen.component.magicindicator.buildins.commonnavigator.abs.IPagerIndicator;
import com.linzi.xiguwen.component.magicindicator.buildins.commonnavigator.abs.IPagerTitleView;
import com.linzi.xiguwen.component.magicindicator.buildins.commonnavigator.indicators.LinePagerIndicator;
import com.linzi.xiguwen.component.magicindicator.buildins.commonnavigator.titles.ColorTransitionPagerTitleView;
import com.linzi.xiguwen.component.magicindicator.buildins.commonnavigator.titles.SimplePagerTitleView;
import com.linzi.xiguwen.fragment.ShangChengJieDanFragment;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

public class ShangchengJieDanActivity extends BaseActivity {

    @BindView(R.id.magic_indicator)
    MagicIndicator magicIndicator;
    @BindView(R.id.view_pager)
    ViewPager viewPager;

    private static final String[] CHANNELS = new String[]{"全部", "待付款", "代发货", "代收货", "待评价"};

    private List<String> mDataList = Arrays.asList(CHANNELS);

    private List<Fragment> mFragmentList;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_hun_qin_order);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        setTitle("商城接单");
        setBack();
        initMagicIndicator();
        viewPager.setAdapter(new ViewPagerAdapter(getSupportFragmentManager(), getFragment()));
        viewPager.setCurrentItem(0);
    }

    private List<Fragment> getFragment() {
        if (mFragmentList != null) {
            mFragmentList.clear();
        } else {
            mFragmentList = new ArrayList<>();
        }
        for (int x = 0; x < mDataList.size(); x++) {
            mFragmentList.add(ShangChengJieDanFragment.newInstance(x));
        }
        return mFragmentList;
    }

    private void initMagicIndicator() {
        magicIndicator.setBackgroundColor(Color.WHITE);
        CommonNavigator commonNavigator = new CommonNavigator(this);
        commonNavigator.setAdjustMode(true);
        commonNavigator.setLeftPadding(8);
        commonNavigator.setRightPadding(8);
        commonNavigator.setAdapter(new CommonNavigatorAdapter() {
            @Override
            public int getCount() {
                return mDataList == null ? 0 : mDataList.size();
            }

            @Override
            public IPagerTitleView getTitleView(Context context, final int index) {
                SimplePagerTitleView simplePagerTitleView = new ColorTransitionPagerTitleView(context);
                simplePagerTitleView.setText(mDataList.get(index));
                simplePagerTitleView.setTextSize(15);
                simplePagerTitleView.setNormalColor(Color.parseColor("#666666"));
                simplePagerTitleView.setSelectedColor(Color.parseColor("#ff5384"));
                simplePagerTitleView.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        viewPager.setCurrentItem(index);
                    }
                });
                return simplePagerTitleView;
            }

            @Override
            public IPagerIndicator getIndicator(Context context) {
                LinePagerIndicator indicator = new LinePagerIndicator(context);
                indicator.setColors(Color.parseColor("#ff5384"));
                return indicator;
            }
        });
        magicIndicator.setNavigator(commonNavigator);
        ViewPagerHelper.bind(magicIndicator, viewPager);
    }
}
