package com.linzi.xiguwen.fragment.search;

import android.os.Bundle;
import androidx.annotation.NonNull;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RadioButton;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.SearchPriceAdapter;
import com.linzi.xiguwen.bean.CityEntity;
import com.linzi.xiguwen.bean.SearchSJBean;
import com.linzi.xiguwen.fragment.discover.BaseFragment;
import com.linzi.xiguwen.fragment.vm.RefreshViewModel;
import com.linzi.xiguwen.net.OnRequestSubscribe;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.yixin.preference.Preferences;
import com.linzi.xiguwen.widget.NestRadioGroup;
import com.scwang.smartrefresh.layout.SmartRefreshLayout;
import com.scwang.smartrefresh.layout.api.RefreshLayout;
import com.scwang.smartrefresh.layout.listener.OnLoadMoreListener;
import com.scwang.smartrefresh.layout.listener.OnRefreshListener;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

/**
 * Created by PC on 2018-04-15.
 */

public class SearchPriceFragment extends BaseFragment {

    @BindView(R.id.rb_one)
    RadioButton rbOne;
    @BindView(R.id.rb_two)
    RadioButton rbTwo;
    @BindView(R.id.rb_three)
    RadioButton rbThree;
    @BindView(R.id.ll_three)
    LinearLayout llThree;
    @BindView(R.id.rb_screen)
    RadioButton rbScreen;
    @BindView(R.id.ll_screen)
    LinearLayout llScreen;
    @BindView(R.id.no_data_view)
    ImageView noDataView;
    @BindView(R.id.hot_recycle)
    RecyclerView mRecycle;
    @BindView(R.id.refreshLayout)
    SmartRefreshLayout refreshLayout;
    @BindView(R.id.rb_group)
    NestRadioGroup rbGroup;

    private CityEntity cityEntity;
    private String content;
    private int cityType;
    private String price = null;
    private int salesvolume;
    private int comprehensive;
    private RefreshViewModel mRefreshViewModel;

    private SearchPriceAdapter mAdapter;

    //FLAG 区分是case还是goods
    public static SearchPriceFragment newInstance(int FLAG, String content, int cityType) {
        Bundle args = new Bundle();
        args.putInt("type", FLAG);
        args.putInt("cityType", cityType);
        args.putString("content", content);
        SearchPriceFragment fragment = new SearchPriceFragment();
        fragment.setArguments(args);
        return fragment;
    }


    @Override
    public int setlayoutResID() {
//        return R.layout.fragment_search_goods;
        return R.layout.fragment_search_merchants;
    }

    @Override
    public void initView() {
        cityType = getArguments().getInt("cityType", 1);
        content = getArguments().getString("content");
        llScreen.setVisibility(View.GONE);
        rbOne.setText("价格排序");
        rbTwo.setText("综合排序");
        rbThree.setText("销量排序");
        initList();
    }

    @Override
    protected void initEvents() {

        rbGroup.setOnCheckedChangeListener(new NestRadioGroup.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(NestRadioGroup group, int checkedId) {
                if (checkedId == rbTwo.getId()) {
                    price = null;
                    comprehensive = 1;
                    salesvolume = 0;
                    mRefreshViewModel.autoRefresh();
                } else if (checkedId == rbThree.getId()) {
                    price = null;
                    comprehensive = 0;
                    salesvolume = 1;
                    mRefreshViewModel.autoRefresh();
                }
            }
        });
    }

    @Override
    public void initData() {
        cityEntity = Preferences.getCity();
        setCityType(cityType);
    }

    public void setCityType(int cityType) {
        this.cityType = cityType;
        if (llThree == null||isFirstLoad) {
            return;
        }
//        if (cityType == 1) {
//            llThree.setVisibility(View.VISIBLE);
//        } else {
//            llThree.setVisibility(View.GONE);
//        }
        mRefreshViewModel.autoRefresh();
    }

    public void setSearchContent(String content) {
        this.content = content;
//        refresh(null, "1", "15");
        if (mRefreshViewModel != null&&!isFirstLoad)
            mRefreshViewModel.autoRefresh();
    }

    private void initList() {
        GridLayoutManager manager = new GridLayoutManager(getActivity(), 2);
        mAdapter = new SearchPriceAdapter(getActivity());
        mRecycle.setLayoutManager(manager);
        mRecycle.setAdapter(mAdapter);
        mRefreshViewModel = RefreshViewModel.initRefresh(refreshLayout).addOnRefreshListener(new OnRefreshListener() {
            @Override
            public void onRefresh(@NonNull final RefreshLayout refreshLayout) {
                mRefreshViewModel.resetPage();
                refreshLayout.setEnableLoadMore(true);
                requestData(refreshLayout, mRefreshViewModel.getPage(), true);
            }
        }).addOnLoadMoreListener(new OnLoadMoreListener() {
            @Override
            public void onLoadMore(@NonNull RefreshLayout refreshLayout) {
                mRefreshViewModel.pageAddOne();
                requestData(refreshLayout, mRefreshViewModel.getPage(), false);
            }
        });

    }
    //---------------------------跟View相关的请求操作---------------------------------

    /**
     * @param refreshLayout
     * @param p
     * @param isRefreshOrLoadMore true 刷新  false 加载更多
     */
    private void requestData(@NonNull final RefreshLayout refreshLayout, int p, boolean isRefreshOrLoadMore) {
        String page = p + "";
        String row = "15";
        if (isRefreshOrLoadMore) {
            refresh(refreshLayout, page, row);
        } else {
            loadMore(refreshLayout, page, row);
        }
    }


    private void refresh(@NonNull final RefreshLayout refreshLayout, String page, String row) {
        ApiManager.searchShop(page, row, content, cityEntity.getId(), cityType,
                "fw", comprehensive, price, salesvolume,
                new OnRequestSubscribe<BaseBean<SearchSJBean>>() {
                    @Override
                    public void onSuccess(BaseBean<SearchSJBean> data) {
                        refreshLayout.finishRefresh();
                        noDataView.setVisibility(View.GONE);
                        mRecycle.scrollToPosition(0);
                        mAdapter.addFirst(data.getData().getBaojia());
                        if (data.getData().getAnli().size() == 0) {
                            refreshLayout.setEnableLoadMore(false);
                            noDataView.setVisibility(View.VISIBLE);
                        }
                    }

                    @Override
                    public void onError(Exception ex) {
                        refreshLayout.finishRefresh();
                    }
                });
    }

    private void loadMore(@NonNull final RefreshLayout refreshLayout, String page, String row) {

        ApiManager.searchShop(page, row, content, cityEntity.getId(), cityType,
                "fw", comprehensive, price, salesvolume,
                new OnRequestSubscribe<BaseBean<SearchSJBean>>() {
                    @Override
                    public void onSuccess(BaseBean<SearchSJBean> data) {
                        SearchSJBean bean = data.getData();
                        refreshLayout.finishLoadMore();

                        if (bean.getAnli().size() == 0) {
                            refreshLayout.setEnableLoadMore(false);
                        } else {
                            mAdapter.addMore(bean.getBaojia());
                        }
                    }

                    @Override
                    public void onError(Exception ex) {
                        refreshLayout.finishRefresh();
                    }
                });
    }


    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        // TODO: inflate a fragment view
        View rootView = super.onCreateView(inflater, container, savedInstanceState);
        ButterKnife.bind(this, rootView);
        return rootView;
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
         
    }


    @OnClick(R.id.rb_one)
    public void onViewClicked() {
        comprehensive = 0;
        salesvolume = 0;
        if (price != null && price.equals("desc")) {
            price = "asc";
        } else {
            price = "desc";
        }
        mRefreshViewModel.autoRefresh();
    }
}