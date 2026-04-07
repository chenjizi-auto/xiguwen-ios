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
import com.linzi.xiguwen.bean.RenZhengListBean;
import com.linzi.xiguwen.component.magicindicator.MagicIndicator;
import com.linzi.xiguwen.component.magicindicator.ViewPagerHelper;
import com.linzi.xiguwen.component.magicindicator.buildins.commonnavigator.CommonNavigator;
import com.linzi.xiguwen.component.magicindicator.buildins.commonnavigator.abs.CommonNavigatorAdapter;
import com.linzi.xiguwen.component.magicindicator.buildins.commonnavigator.abs.IPagerIndicator;
import com.linzi.xiguwen.component.magicindicator.buildins.commonnavigator.abs.IPagerTitleView;
import com.linzi.xiguwen.component.magicindicator.buildins.commonnavigator.indicators.LinePagerIndicator;
import com.linzi.xiguwen.component.magicindicator.buildins.commonnavigator.titles.ColorTransitionPagerTitleView;
import com.linzi.xiguwen.component.magicindicator.buildins.commonnavigator.titles.SimplePagerTitleView;
import com.linzi.xiguwen.fragment.RenZhengFragment;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

public class DianPuRenZhengActivity extends BaseActivity {

    @BindView(R.id.magic_indicator)
    MagicIndicator magicIndicator;
    @BindView(R.id.view_pager)
    ViewPager viewPager;

    private RenZhengListBean mData;

    private static final String[] CHANNELS = new String[]{"平台认证", "诚信认证","学院认证"};

    private List<String> mDataList = Arrays.asList(CHANNELS);

    private List<Fragment> mFragmentList;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_dian_pu_ren_zheng);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        setTitle("店铺认证");
        setBack();

        initMagicIndicator();
        viewPager.setAdapter(new ViewPagerAdapter(getSupportFragmentManager(), getFragment()));
        viewPager.setCurrentItem(0);

        requestNetData();
    }

    public void requestNetData(){
        LoadDialog.showDialog(mContext);
        ApiManager.getRenZhengInfo(new OnRequestFinish<BaseBean<RenZhengListBean>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<RenZhengListBean> data) {
                loadFinish(data);
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
            }
        });
    }

    private void loadFinish(BaseBean<RenZhengListBean> data) {
        mData = data.getData();
        List<RenZhengListBean.RenZhengBean> pt = new ArrayList();
        List<RenZhengListBean.RenZhengBean> cx = new ArrayList();
        pt.add(mData.getPingtai());
        cx.add(mData.getChengxin());
        ((RenZhengFragment)(mFragmentList.get(0))).setDatas(pt);
        ((RenZhengFragment)(mFragmentList.get(1))).setDatas(cx);
        ((RenZhengFragment)(mFragmentList.get(2))).setDatas(mData.getXueyuan());
    }

    private List<Fragment> getFragment() {
        if (mFragmentList != null) {
            mFragmentList.clear();
        } else {
            mFragmentList = new ArrayList<>();
        }
//        for (int x = 0; x < mDataList.size(); x++) {
            mFragmentList.add(RenZhengFragment.newInstance(RenZhengFragment.TAG_RENZHENG_PINGTAI));
            mFragmentList.add(RenZhengFragment.newInstance(RenZhengFragment.TAG_RENZHENG_CHENGXIN));
            mFragmentList.add(RenZhengFragment.newInstance(RenZhengFragment.TAG_RENZHENG_XUEYUAN));
//        }
        return mFragmentList;
    }

    private void initMagicIndicator() {
        magicIndicator.setBackgroundColor(Color.WHITE);
        CommonNavigator commonNavigator = new CommonNavigator(this);
        commonNavigator.setAdjustMode(true);
        commonNavigator.setLeftPadding(100);
        commonNavigator.setRightPadding(100);
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


    /**
     * 根据名字获取认证对象
     * @return
     */
    public List<RenZhengListBean.RenZhengBean> getData(int tag){
        switch (tag){
            case RenZhengFragment.TAG_RENZHENG_CHENGXIN:
                if(mData != null){
                    List<RenZhengListBean.RenZhengBean> data = new ArrayList<>();
                    data.add(mData.getChengxin());
                    return data;
                }
                break;
            case RenZhengFragment.TAG_RENZHENG_PINGTAI:
                if(mData != null){
                    List<RenZhengListBean.RenZhengBean> data = new ArrayList<>();
                    data.add(mData.getPingtai());
                    return data;
                }
                break;
            case RenZhengFragment.TAG_RENZHENG_XUEYUAN:
                if(mData != null){
                    return mData.getXueyuan();
                }
                break;
        }
        return null;
    }


}
