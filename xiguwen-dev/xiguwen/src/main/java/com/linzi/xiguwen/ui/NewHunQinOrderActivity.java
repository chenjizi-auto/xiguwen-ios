package com.linzi.xiguwen.ui;

import android.content.Intent;
import android.os.Bundle;
import com.google.android.material.tabs.TabLayout;
import androidx.fragment.app.Fragment;
import android.view.View;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.PagerAdapter;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.fragment.NewHunQinOrderFragment;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;
import com.linzi.xiguwen.view.MyViewPager;

import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by pc on 2018/4/16.
 */

public class NewHunQinOrderActivity extends BaseActivity {
    @BindView(R.id.tablayout)
    TabLayout tablayout;
    @BindView(R.id.pager)
    MyViewPager pager;
    private List<Fragment> mFragmentList;
    private String[] titlelist;
    private int index = 0;
    private String title;
    private int intentType;//0婚庆订单，1商城订单.2婚庆接单，3商城接单

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.new_wedding_order_layout);
        ButterKnife.bind(this);
        EventBusUtil.register(this);
        title = getIntent().getStringExtra("title");
        index = getIntent().getIntExtra("index", -1);
        intentType = getIntent().getIntExtra("intentType", -1);
        getTitleList(intentType);
        initView();
        if (index != -1) {
            if (index == 4 && intentType == 0) {
                pager.setCurrentItem(index + 1);
            } else if (index == 4 && intentType == 2) {
                pager.setCurrentItem(index + 1);
            } else {
                pager.setCurrentItem(index);
            }
        } else {
            finish();
            NToast.show("跳转错误，请重试！");
        }
    }

    //组成title[]
    private void getTitleList(int intentType) {
        switch (intentType) {
            case 0:
                titlelist = new String[]{"全部", "待付款", "待接单", "待服务", "已服务", "待评价", "已完成"};
                setRightAdd(R.mipmap.icon_black_search, new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        Intent intent = new Intent(NewHunQinOrderActivity.this, OrderSearchActivity.class);
                        intent.putExtra("intentType", 0);
                        startActivity(intent);
                    }
                });
                break;
            case 1:
                titlelist = new String[]{"全部", "待付款", "待发货", "待收货", "待评价"};
                break;
            case 2:
                titlelist = new String[]{"全部", "待付款", "待接单", "待服务", "已服务", "待评价", "已完成", "已关闭", "退款单"};
                setRightAdd(R.mipmap.icon_black_search, new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        Intent intent = new Intent(NewHunQinOrderActivity.this, OrderSearchActivity.class);
                        intent.putExtra("intentType", 2);
                        startActivity(intent);
                    }
                });
                break;
            case 3:
                titlelist = new String[]{"全部", "待付款", "待发货", "待收货", "待评价", "已完成", "已关闭", "退款单"};
                break;
        }
    }

    private void initView() {
        setBack();
        setTitle(title);

        pager.setOffscreenPageLimit(1);
        pager.setAdapter(new PagerAdapter(getSupportFragmentManager(), getFragment()));
        tablayout.setupWithViewPager(pager);

        for (int i = 0; i < mFragmentList.size(); i++) {
            tablayout.getTabAt(i).setText(titlelist[i]);
        }

        tablayout.addOnTabSelectedListener(new TabLayout.OnTabSelectedListener() {
            @Override
            public void onTabSelected(TabLayout.Tab tab) {
                EventBusUtil.sendEvent(new Event(EventCode.REFRESH));
            }

            @Override
            public void onTabUnselected(TabLayout.Tab tab) {

            }

            @Override
            public void onTabReselected(TabLayout.Tab tab) {
                EventBusUtil.sendEvent(new Event(EventCode.REFRESH));
            }
        });
    }

    private List<Fragment> getFragment() {
        if (mFragmentList != null) {
            mFragmentList.clear();
        } else {
            mFragmentList = new ArrayList<>();
        }
        for (int x = 0; x < titlelist.length; x++) {
            mFragmentList.add(NewHunQinOrderFragment.createFragment(x, intentType));
        }
        return mFragmentList;
    }

    @Override
    protected void initData() {
    }

    @Subscribe(threadMode = ThreadMode.MAIN)
    public void receiveEvent(Event event) {
        if (event == null)
            return;
        try {
            int code = event.getCode();
            switch (code) {
                case EventCode.PAY_SUCCRSS:
                    if (mFragmentList != null) {
                        ((NewHunQinOrderFragment) mFragmentList.get(tablayout.getSelectedTabPosition())).refreshView();
                    }
                    break;
                case EventCode.REFRESH:
                    if (mFragmentList != null) {
                        ((NewHunQinOrderFragment) mFragmentList.get(tablayout.getSelectedTabPosition())).refreshView();
                    }
                    break;
            }
        } catch (Exception e) {
        }

    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        EventBusUtil.unregister(this);
    }
}
