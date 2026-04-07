package com.linzi.xiguwen.ui;

import android.os.Bundle;
import com.google.android.material.tabs.TabLayout;
import androidx.fragment.app.Fragment;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.PagerAdapter;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.fragment.cart.MallCartFragment;
import com.linzi.xiguwen.fragment.cart.WeddingCartFragment;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.network.Constans;
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
 * Created by pc on 2018/4/26.
 */

public class CartActivity extends BaseActivity {
    @BindView(R.id.tablayout)
    TabLayout tablayout;
    @BindView(R.id.tv_page_title)
    android.widget.TextView tvPageTitle;
    @BindView(R.id.pager)
    MyViewPager pager;

    private List<Fragment> mFragmentList;
    private final List<String> titlelist = new ArrayList<>();
    private int index;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.newcart_fra_layout);
        ButterKnife.bind(this);
        EventBusUtil.register(this);
        initView();
        index = getIntent().getIntExtra("index", -1);
        if (index >= 0 && index < mFragmentList.size()) {
            pager.setCurrentItem(index);
        }
    }

    private void initView() {
        initTitles();
        tvPageTitle.setText("购物车");
        tablayout.setVisibility(android.view.View.GONE);

        pager.setScanScroll(false);
        pager.setAdapter(new PagerAdapter(getSupportFragmentManager(), getFragment()));
        pager.setCurrentItem(0);
        getCartNum();
    }

    private List<Fragment> getFragment() {
        if (mFragmentList != null) {
            mFragmentList.clear();
        } else {
            mFragmentList = new ArrayList<>();
        }
        mFragmentList.add(WeddingCartFragment.create());
        if (Constans.SHOW_MALL_CATEGORY) {
            mFragmentList.add(MallCartFragment.create());
        }
        return mFragmentList;
    }

    private void initTitles() {
        titlelist.clear();
        titlelist.add("婚庆");
        if (Constans.SHOW_MALL_CATEGORY) {
            titlelist.add("商城");
        }
    }

    @Override
    protected void initData() {

    }

    private void getCartNum() {
        ApiManager.getCartNum(1, new OnRequestFinish<BaseBean>() {
            @Override
            public void onFinished() {

            }

            @Override
            public void onSuccess(BaseBean data) {
                tvPageTitle.setText("购物车(" + data.getData() + ")");
            }

            @Override
            public void onError(Exception ex) {
                tvPageTitle.setText("购物车");
            }
        });
    }

    @Subscribe(threadMode = ThreadMode.MAIN)
    public void receiveEvent(Event entity) {
        if (entity == null) {
            return;
        }
        if (entity.getCode() == EventCode.REFRESH_CART_NUM) {
            getCartNum();
        }
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        EventBusUtil.unregister(this);
        EventBusUtil.sendEvent(new Event(EventCode.REFRESH_CART_NUM));
    }
}
