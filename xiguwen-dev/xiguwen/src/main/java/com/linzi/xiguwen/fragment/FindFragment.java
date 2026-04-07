package com.linzi.xiguwen.fragment;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import androidx.annotation.Nullable;
import com.google.android.material.tabs.TabLayout;
import androidx.fragment.app.Fragment;
import androidx.viewpager.widget.ViewPager;
import android.util.DisplayMetrics;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.ViewPagerAdapter;
import com.linzi.xiguwen.fragment.discover.DiscoverFragment;
import com.linzi.xiguwen.network.Constans;
import com.linzi.xiguwen.ui.AddActivitiesActivity;
import com.linzi.xiguwen.ui.LoginActivity;
import com.linzi.xiguwen.utils.LoginUtil;
import com.linzi.xiguwen.utils.StatusBarUtil;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;


/**
 * Created by jiang on 2018/1/26.
 */

public class FindFragment extends Fragment {
    @BindView(R.id.tab_title)
    TabLayout tabTitle;

    @BindView(R.id.pager)
    ViewPager pager;
    @BindView(R.id.tv_page_title)
    TextView tvPageTitle;
    @BindView(R.id.iv_add)
    ImageView ivAdd;
    @BindView(R.id.ll_bar)
    LinearLayout llBar;

    private List<Fragment> mFragmentList;

    ViewPagerAdapter pagerAdapter;

    private List<String> titlelist;


    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = LayoutInflater.from(getActivity()).inflate(R.layout.fragment_find_layout, null);
        ButterKnife.bind(this, view);
        return view;
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        initView();
    }

    private void initView() {
        //获得状态栏高度
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, StatusBarUtil.getStatusBarHeight(getActivity()));
        llBar.setLayoutParams(params);
        llBar.setBackgroundColor(getActivity().getResources().getColor(R.color.white));
        //ViewCompat.setAlpha(llBar, 0);

        tvPageTitle.setText("婚庆圈子");
        tabTitle.setVisibility(View.GONE);

        titlelist = new ArrayList<>();
        titlelist.add("婚庆圈");
        getFragment();
        pagerAdapter = new ViewPagerAdapter(getChildFragmentManager(), mFragmentList, titlelist);
        pager.setAdapter(pagerAdapter);
        pager.setCurrentItem(0);

        ivAdd.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (!LoginUtil.isLogin()) {
                    LoginActivity.startAction(getActivity());
                    return;
                }
                Intent intent = new Intent(getActivity(), AddActivitiesActivity.class);
                startActivity(intent);
            }
        });
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

    //反射修改下划线宽度，混淆需要-keep class android.support.** { *; }
    public static void setIndicator(Context context, TabLayout tabs, int leftDip, int rightDip) {
        Class<?> tabLayout = tabs.getClass();
        Field tabStrip = null;
        try {
            tabStrip = tabLayout.getDeclaredField("mTabStrip");
        } catch (NoSuchFieldException e) {
            com.linzi.xiguwen.utils.LogUtil.printStackTrace(e);
        }

        tabStrip.setAccessible(true);
        LinearLayout ll_tab = null;
        try {
            ll_tab = (LinearLayout) tabStrip.get(tabs);
        } catch (IllegalAccessException e) {
            com.linzi.xiguwen.utils.LogUtil.printStackTrace(e);
        }

        int left = (int) (getDisplayMetrics(context).density * leftDip);
        int right = (int) (getDisplayMetrics(context).density * rightDip);

        for (int i = 0; i < ll_tab.getChildCount(); i++) {
            View child = ll_tab.getChildAt(i);
            child.setPadding(0, 0, 0, 0);
            LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(0, LinearLayout.LayoutParams.MATCH_PARENT, 1);
            params.leftMargin = left;
            params.rightMargin = right;
            child.setLayoutParams(params);
            child.invalidate();
        }
    }

    public static DisplayMetrics getDisplayMetrics(Context context) {
        DisplayMetrics metric = new DisplayMetrics();
        ((Activity) context).getWindowManager().getDefaultDisplay().getMetrics(metric);
        return metric;
    }

    private List<Fragment> getFragment() {
        if (mFragmentList != null) {
            mFragmentList.clear();
        } else {
            mFragmentList = new ArrayList<>();
        }
        mFragmentList.add(DiscoverFragment.newInstance(0));
        if (Constans.SHOW_MALL_CATEGORY) {
            mFragmentList.add(DiscoverFragment.newInstance(1));
        }
        return mFragmentList;
    }


    @Override
    public void onDestroyView() {
        super.onDestroyView();
         
    }


}
