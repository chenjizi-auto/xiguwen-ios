package com.linzi.xiguwen.ui;

import android.content.Context;
import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;
import androidx.fragment.app.Fragment;
import androidx.viewpager.widget.ViewPager;
import android.view.View;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.ViewPagerAdapter;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.BaoJiaBean;
import com.linzi.xiguwen.component.magicindicator.MagicIndicator;
import com.linzi.xiguwen.component.magicindicator.ViewPagerHelper;
import com.linzi.xiguwen.component.magicindicator.buildins.commonnavigator.CommonNavigator;
import com.linzi.xiguwen.component.magicindicator.buildins.commonnavigator.abs.CommonNavigatorAdapter;
import com.linzi.xiguwen.component.magicindicator.buildins.commonnavigator.abs.IPagerIndicator;
import com.linzi.xiguwen.component.magicindicator.buildins.commonnavigator.abs.IPagerTitleView;
import com.linzi.xiguwen.component.magicindicator.buildins.commonnavigator.indicators.LinePagerIndicator;
import com.linzi.xiguwen.component.magicindicator.buildins.commonnavigator.titles.ColorTransitionPagerTitleView;
import com.linzi.xiguwen.component.magicindicator.buildins.commonnavigator.titles.SimplePagerTitleView;
import com.linzi.xiguwen.fragment.MineBaojiaFragment;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

public class MineBaojiarActivity extends BaseActivity {

    @BindView(R.id.magic_indicator)
    MagicIndicator magicIndicator;
    @BindView(R.id.view_pager)
    ViewPager viewPager;

    private boolean mIsLoad;
    private ArrayList<BaoJiaBean> mData;

    private static final String[] CHANNELS = new String[]{"待提交", "审核中", "审核通过", "审核未通过"};

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
        setTitle("我的报价");
        setBack();
        setRightAdd(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent=new Intent(mContext,AddBaojiaActivity.class);
                startActivity(intent);
            }
        });
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
        mFragmentList.add(MineBaojiaFragment.newInstance(BaoJiaBean.STATE_NO_SUBMIT_0));
        mFragmentList.add(MineBaojiaFragment.newInstance(BaoJiaBean.STATE_ON));
        mFragmentList.add(MineBaojiaFragment.newInstance(BaoJiaBean.STATE_PASS));
        mFragmentList.add(MineBaojiaFragment.newInstance(BaoJiaBean.STATE_FAILED));
        return mFragmentList;
    }

    private void initMagicIndicator() {
        magicIndicator.setBackgroundColor(Color.WHITE);
        CommonNavigator commonNavigator = new CommonNavigator(this);
        commonNavigator.setAdjustMode(true);
        commonNavigator.setLeftPadding(40);
        commonNavigator.setRightPadding(40);
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
