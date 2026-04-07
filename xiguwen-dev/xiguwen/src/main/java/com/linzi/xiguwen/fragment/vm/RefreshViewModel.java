package com.linzi.xiguwen.fragment.vm;

import android.view.View;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.fragment.vm.club.PopwindowVM;
import com.linzi.xiguwen.view.MyRefreshFooter;
import com.linzi.xiguwen.view.MyRefreshHeader;
import com.scwang.smartrefresh.layout.SmartRefreshLayout;
import com.scwang.smartrefresh.layout.listener.OnLoadMoreListener;
import com.scwang.smartrefresh.layout.listener.OnRefreshListener;

/**
 * Title:
 * Description:用来初始化下拉刷新模型的
 * Copyright:Copyright(c)2018
 * Company: Cree
 * CreateTime:2018/3/22  11:14
 *
 * @author luyongjiang
 * @version 1.0
 */
public class RefreshViewModel {
    private SmartRefreshLayout mSmartRefreshLayout;
    private int page = 1;

    public int getPage() {
        return page;
    }

    public void pageAddOne() {
        page++;
    }

    public void resetPage() {
        page = 1;
    }

    public PopwindowVM.RequestListDelegate mRequestListDelegate = new PopwindowVM.RequestListDelegate() {
        @Override
        public void method() {
            mSmartRefreshLayout.autoRefresh();
        }
    };

    private RefreshViewModel(View view) {
        if (view != null) {
            mSmartRefreshLayout = (SmartRefreshLayout) view.findViewById(R.id.refreshLayout);
            if (mSmartRefreshLayout != null) {
                mSmartRefreshLayout.setEnableRefresh(false);
                mSmartRefreshLayout.setEnableLoadMore(false);
            }
        }
    }

    private RefreshViewModel(SmartRefreshLayout view) {
        mSmartRefreshLayout = view;
        mSmartRefreshLayout.setEnableRefresh(false);
        mSmartRefreshLayout.setEnableLoadMore(false);

    }

    public void autoRefresh() {
        mSmartRefreshLayout.autoRefresh();
    }

    public static RefreshViewModel initRefresh(View rootView) {
        return new RefreshViewModel(rootView);
    }

    public static RefreshViewModel initRefresh(SmartRefreshLayout l) {
        return new RefreshViewModel(l);
    }

    public RefreshViewModel addOnRefreshListener(OnRefreshListener refreshListener) {
        mSmartRefreshLayout.setEnableRefresh(true);
        mSmartRefreshLayout.setRefreshHeader(new MyRefreshHeader(mSmartRefreshLayout.getContext()));
        mSmartRefreshLayout.setOnRefreshListener(refreshListener);
        return this;
    }

    public RefreshViewModel addOnLoadMoreListener(OnLoadMoreListener loadMoreListener) {
        mSmartRefreshLayout.setEnableLoadMore(true);
        mSmartRefreshLayout.setRefreshFooter(new MyRefreshFooter(mSmartRefreshLayout.getContext()));
        mSmartRefreshLayout.setOnLoadMoreListener(loadMoreListener);
        return this;
    }
}
