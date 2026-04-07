package com.linzi.xiguwen.fragment.cart;

import android.os.Bundle;
import androidx.annotation.Nullable;
import com.google.android.material.tabs.TabLayout;
import androidx.fragment.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.PagerAdapter;
import com.linzi.xiguwen.base.BaseLazyFragment;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.network.Constans;
import com.linzi.xiguwen.utils.StatusBarUtil;
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
 * Created by pc on 2018/4/9.
 */

public class NewCartFragment extends BaseLazyFragment {
    @BindView(R.id.tablayout)
    TabLayout tablayout;
    @BindView(R.id.tv_page_title)
    TextView tvPageTitle;
    @BindView(R.id.pager)
    MyViewPager pager;
    @BindView(R.id.ll_bar)
    LinearLayout llBar;

    private List<Fragment> mFragmentList;
    private final List<String> titlelist = new ArrayList<>();

    @Override
    public void onLazyLoad() {

    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.newcart_fra_layout, null);
        ButterKnife.bind(this, view);
        EventBusUtil.register(this);
        return view;
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        initView();
    }

    private void initView() {
        initTitles();
        //获得状态栏高度
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, StatusBarUtil.getStatusBarHeight(getActivity()));
        llBar.setLayoutParams(params);
        llBar.setBackgroundColor(getActivity().getResources().getColor(R.color.white));
        //ViewCompat.setAlpha(llBar, 0);
        tvPageTitle.setText("购物车");
        tablayout.setVisibility(View.GONE);

        pager.setScanScroll(false);
        pager.setAdapter(new PagerAdapter(getChildFragmentManager(), getFragment()));
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

    @Override
    public void onDestroyView() {
        super.onDestroyView();
        EventBusUtil.unregister(this);
    }

    //加载第一个tablayout tab
    private void initFristTab() {
        for (int i = 0; i < titlelist.size(); i++) {
            TabLayout.Tab tab = tablayout.getTabAt(i);
            tab.setCustomView(R.layout.jifen_tab);
            TextView textView = (TextView) tab.getCustomView().findViewById(R.id.tv_title);
            textView.setText(titlelist.get(i));//设置tab上的文字
            textView.setTextSize(16);
        }
        //setIndicator(getActivity(), tabTitle, 70, 70);
    }

    private void initTitles() {
        titlelist.clear();
        titlelist.add("婚庆");
        if (Constans.SHOW_MALL_CATEGORY) {
            titlelist.add("商城");
        }
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

}
