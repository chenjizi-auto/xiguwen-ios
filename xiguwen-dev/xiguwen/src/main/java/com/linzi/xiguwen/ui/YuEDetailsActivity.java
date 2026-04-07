package com.linzi.xiguwen.ui;

import android.os.Bundle;
import androidx.annotation.NonNull;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.View;
import android.widget.ImageView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.YuEDetailsAdapter;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.YuEDetailEntity;
import com.linzi.xiguwen.fragment.vm.RefreshViewModel;
import com.linzi.xiguwen.net.OnRequestSubscribe;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.scwang.smartrefresh.layout.SmartRefreshLayout;
import com.scwang.smartrefresh.layout.api.RefreshLayout;
import com.scwang.smartrefresh.layout.listener.OnLoadMoreListener;
import com.scwang.smartrefresh.layout.listener.OnRefreshListener;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

public class YuEDetailsActivity extends BaseActivity {

    @BindView(R.id.recycle)
    RecyclerView mRecycle;
    @BindView(R.id.no_data_view)
    ImageView noDataView;
    @BindView(R.id.refreshLayout)
    SmartRefreshLayout refreshLayout;
    private RefreshViewModel mRefreshViewModel;

    YuEDetailsAdapter mAdapter;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
//        setContentView(R.layout.activity_yu_edetails);
        setContentView(R.layout.fragment_recycle_layout_refresh);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        setTitle("收支明细");
        setBack();
        initList();
        mRefreshViewModel.autoRefresh();
    }

    private void initList() {
        LinearLayoutManager manager = new LinearLayoutManager(this);
        mAdapter = new YuEDetailsAdapter(this);
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
        ApiManager.bankMoneyDetail(page, row, new OnRequestSubscribe<BaseBean<List<YuEDetailEntity>>>() {
            @Override
            public void onSuccess(BaseBean<List<YuEDetailEntity>> data) {
                refreshLayout.finishRefresh();
                mAdapter.addFirst(data.getData());
                noDataView.setVisibility(View.GONE);
                if (data.getData().size() == 0) {
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
        ApiManager.bankMoneyDetail(page, row,  new OnRequestSubscribe<BaseBean<List<YuEDetailEntity>>>() {
            @Override
            public void onSuccess(BaseBean<List<YuEDetailEntity>> data) {
                refreshLayout.finishLoadMore();
                if (data.getData() == null || data.getData() == null || data.getData().size() == 0) {
                    refreshLayout.setEnableLoadMore(false);
                } else {
                    mAdapter.addMore(data.getData());
                }
            }

            @Override
            public void onError(Exception ex) {
                refreshLayout.finishRefresh();
            }
        });
    }

}
