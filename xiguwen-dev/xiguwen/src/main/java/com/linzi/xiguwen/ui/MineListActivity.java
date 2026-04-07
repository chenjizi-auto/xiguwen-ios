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
import com.linzi.xiguwen.bean.BaseStatusBean;
import com.linzi.xiguwen.component.magicindicator.MagicIndicator;
import com.linzi.xiguwen.component.magicindicator.ViewPagerHelper;
import com.linzi.xiguwen.component.magicindicator.buildins.commonnavigator.CommonNavigator;
import com.linzi.xiguwen.component.magicindicator.buildins.commonnavigator.abs.CommonNavigatorAdapter;
import com.linzi.xiguwen.component.magicindicator.buildins.commonnavigator.abs.IPagerIndicator;
import com.linzi.xiguwen.component.magicindicator.buildins.commonnavigator.abs.IPagerTitleView;
import com.linzi.xiguwen.component.magicindicator.buildins.commonnavigator.indicators.LinePagerIndicator;
import com.linzi.xiguwen.component.magicindicator.buildins.commonnavigator.titles.ColorTransitionPagerTitleView;
import com.linzi.xiguwen.component.magicindicator.buildins.commonnavigator.titles.SimplePagerTitleView;
import com.linzi.xiguwen.fragment.MineListFragment;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import butterknife.BindView;
import butterknife.ButterKnife;

public class MineListActivity extends BaseActivity {

    public static final int TYPE_BAOJIA = 0x001;
    public static final int TYPE_TUCE = 0x010;
    public static final int TYPE_SHIPING = 0x011;
    public static final int TYPE_ANLI = 0x100;
    public static final int TYPE_COMMODITY = 0x101;

    @BindView(R.id.magic_indicator)
    MagicIndicator magicIndicator;
    @BindView(R.id.view_pager)
    ViewPager viewPager;

    private int mType;

    private static final String[] CHANNELS = new String[]{ "审核中", "审核通过", "审核未通过"};

    private List<String> mDataList = Arrays.asList(CHANNELS);

    private List<Fragment> mFragmentList;

    private Map<Integer, Boolean> mRefreshStatus = new HashMap<>();

    public static void startActivity(Context context, int type){
        Intent intent = new Intent(context, MineListActivity.class);
        intent.putExtra("type", type);
        context.startActivity(intent);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_hun_qin_order);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        mType = getIntent().getIntExtra("type", TYPE_BAOJIA);
        switch (mType){
            case TYPE_BAOJIA:
                setTitle("我的报价");
                break;
            case TYPE_TUCE:
                setTitle("我的图册");
                break;
            case TYPE_SHIPING:
                setTitle("我的视频");
                break;
            case TYPE_ANLI:
                setTitle("我的案例");
                break;
            case TYPE_COMMODITY:
                setTitle("我的商品");
                break;
        }
        setBack();
        setRightAdd(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = null;
                switch (mType){
                    case TYPE_BAOJIA:
                        intent = new Intent(mContext, AddBaojiaActivity.class);
                        break;
                    case TYPE_TUCE:
                        intent = new Intent(mContext,AddTuCeActivity.class);
                        break;
                    case TYPE_SHIPING:
                        intent = new Intent(mContext, AddVideoActivity.class);
                        break;
                    case TYPE_ANLI:
                        intent = new Intent(mContext,AddExampleActivity.class);
                        break;
                    case TYPE_COMMODITY:
                        intent = new Intent(mContext , AddMineCommodityActivity.class);
                        break;
                }
                if(intent != null){
                    startActivityForResult(intent, 100);
                }
            }
        });
        initMagicIndicator();
        viewPager.setAdapter(new ViewPagerAdapter(getSupportFragmentManager(), getFragment()));
        viewPager.setCurrentItem(0);
    }

    private List<Fragment> getFragment() {
        if (mFragmentList != null) {
            mFragmentList.clear();
            mRefreshStatus.clear();
        } else {
            mFragmentList = new ArrayList<>();
        }
        mRefreshStatus.put(BaseStatusBean.STATE_NO_SUBMIT_4, true);
        mRefreshStatus.put(BaseStatusBean.STATE_NO_SUBMIT_0, true);
        mRefreshStatus.put(BaseStatusBean.STATE_ON, true);
        mRefreshStatus.put(BaseStatusBean.STATE_PASS, true);
        mRefreshStatus.put(BaseStatusBean.STATE_FAILED, true);
//        if(mType == TYPE_BAOJIA || mType == TYPE_SHIPING){
//            mFragmentList.add(MineListFragment.newInstance(mType, BaseStatusBean.STATE_NO_SUBMIT_4));
//        }else{
//            mFragmentList.add(MineListFragment.newInstance(mType, BaseStatusBean.STATE_NO_SUBMIT_0));
//        }
        mFragmentList.add(MineListFragment.newInstance(mType, BaseStatusBean.STATE_ON));
        mFragmentList.add(MineListFragment.newInstance(mType, BaseStatusBean.STATE_PASS));
        mFragmentList.add(MineListFragment.newInstance(mType, BaseStatusBean.STATE_FAILED));
        return mFragmentList;
    }

    public boolean shouldRefresh(int state){
        if(mRefreshStatus.containsKey(state)){
            return mRefreshStatus.get(state);
        }else{
            return true;
        }
    }

    public void setRefreshFinish(int state){
        mRefreshStatus.put(state, false);
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

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if(resultCode == RESULT_OK){
            mRefreshStatus.put(BaseStatusBean.STATE_NO_SUBMIT_4, true);
            mRefreshStatus.put(BaseStatusBean.STATE_NO_SUBMIT_0, true);
            mRefreshStatus.put(BaseStatusBean.STATE_ON, true);
            mRefreshStatus.put(BaseStatusBean.STATE_FAILED, true);
            mRefreshStatus.put(BaseStatusBean.STATE_PASS, true);
        }
    }
}
