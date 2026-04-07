package com.linzi.xiguwen.ui;

import android.os.Build;
import android.os.Bundle;
import com.google.android.material.tabs.TabLayout;
import androidx.fragment.app.Fragment;
import androidx.appcompat.app.AppCompatActivity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.ViewPagerAdapter;
import com.linzi.xiguwen.fragment.BingKeReplyFragment;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.StatusBarUtil;
import com.linzi.xiguwen.view.MyViewPager;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

public class BingkeReplyActivity extends AppCompatActivity {

    @BindView(R.id.ll_bar)
    LinearLayout llBar;
    @BindView(R.id.iv_back)
    ImageView ivBack;
    @BindView(R.id.tv_title)
    TextView tvTitle;
    @BindView(R.id.tab_title)
    TabLayout tabTitle;
    //@BindView(R.id.magic_indicator)
    //MagicIndicator magicIndicator;
    @BindView(R.id.view_pager)
    MyViewPager viewPager;

    private static final String[] CHANNELS = new String[]{"祝福", "赴宴", "待定"};


    private List<String> mDataList = Arrays.asList(CHANNELS);

    private List<Fragment> mFragmentList;

    private int qingjianid;

    //更新tab
    public void refreshTab(int index, int num) {
        if (tabTitle != null && tabTitle.getTabCount() > 0) {
            TabLayout.Tab tab = tabTitle.getTabAt(index - 1);
            TextView textView = (TextView) tab.getCustomView().findViewById(R.id.tv_title);
            textView.setText(mDataList.get(index - 1) + "(" + num + ")");//设置tab上的文字
        }
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
            StatusBarUtil.setStatusBarColor(BingkeReplyActivity.this, R.color.trans);
            StatusBarUtil.setNavigationBarColor(BingkeReplyActivity.this, R.color.white);
        }
        setContentView(R.layout.activity_bingke_reply);
        ButterKnife.bind(this);
        initViews();
    }

    private void initViews() {
        //获得状态栏高度
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, StatusBarUtil.getStatusBarHeight(BingkeReplyActivity.this));
        llBar.setLayoutParams(params);

        qingjianid = getIntent().getIntExtra("qingjianid", -1);
        if (qingjianid != -1) {

            tvTitle.setText("宾客回复");
            ivBack.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    finish();
                }
            });


            // initMagicIndicator();

            viewPager.setScanScroll(false);
            viewPager.setOffscreenPageLimit(3);
            viewPager.setAdapter(new ViewPagerAdapter(getSupportFragmentManager(), getFragment(), mDataList));
            viewPager.setCurrentItem(getIntent().getIntExtra("tag", 0));
            tabTitle.setupWithViewPager(viewPager);
            initFristTab();

        } else {
            NToast.show("跳转错误，请重试！");
            finish();
        }
    }

    private List<Fragment> getFragment() {
        if (mFragmentList != null) {
            mFragmentList.clear();
        } else {
            mFragmentList = new ArrayList<>();
        }
        mFragmentList.add(BingKeReplyFragment.newInstance(BingKeReplyFragment.PAGE_TYPE_ZHUFU, qingjianid));
        mFragmentList.add(BingKeReplyFragment.newInstance(BingKeReplyFragment.PAGE_TYPE_FUYAN, qingjianid));
        mFragmentList.add(BingKeReplyFragment.newInstance(BingKeReplyFragment.PAGE_TYPE_DAIDING, qingjianid));
        return mFragmentList;
    }

//    private void initMagicIndicator() {
//        magicIndicator.setBackgroundColor(Color.WHITE);
//        CommonNavigator commonNavigator = new CommonNavigator(this);
//        commonNavigator.setAdjustMode(true);
//        commonNavigator.setLeftPadding(80);
//        commonNavigator.setRightPadding(80);
//        commonNavigator.setAdapter(new CommonNavigatorAdapter() {
//            @Override
//            public int getCount() {
//                return mDataList == null ? 0 : mDataList.size();
//            }
//
//            @Override
//            public IPagerTitleView getTitleView(Context context, final int index) {
//                SimplePagerTitleView simplePagerTitleView = new ColorTransitionPagerTitleView(context);
//                simplePagerTitleView.setText(mDataList.get(index));
//                simplePagerTitleView.setTextSize(15);
//                simplePagerTitleView.setNormalColor(Color.parseColor("#666666"));
//                simplePagerTitleView.setSelectedColor(Color.parseColor("#ff5384"));
//                simplePagerTitleView.setOnClickListener(new View.OnClickListener() {
//                    @Override
//                    public void onClick(View v) {
//                        viewPager.setCurrentItem(index);
//                    }
//                });
//                return simplePagerTitleView;
//            }
//
//            @Override
//            public IPagerIndicator getIndicator(Context context) {
//                LinePagerIndicator indicator = new LinePagerIndicator(context);
//                indicator.setColors(Color.parseColor("#ff5384"));
//                return indicator;
//            }
//        });
//        magicIndicator.setNavigator(commonNavigator);
//        ViewPagerHelper.bind(magicIndicator, viewPager);
//    }

    private void initFristTab() {
        for (int i = 0; i < mDataList.size(); i++) {
            TabLayout.Tab tab = tabTitle.getTabAt(i);
            tab.setCustomView(R.layout.jifen_tab);
            TextView textView = (TextView) tab.getCustomView().findViewById(R.id.tv_title);
            textView.setText(mDataList.get(i));//设置tab上的文字
            textView.setTextSize(16);
        }
        //setIndicator(getActivity(), tabTitle, 70, 70);
    }
}
