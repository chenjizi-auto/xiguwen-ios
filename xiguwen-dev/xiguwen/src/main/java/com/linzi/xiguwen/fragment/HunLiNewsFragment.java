package com.linzi.xiguwen.fragment;

import android.content.Intent;
import android.os.Bundle;
import androidx.annotation.NonNull;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.MineNewsAdapter;
import com.linzi.xiguwen.base.BaseFragment;
import com.linzi.xiguwen.bean.ShareContentBean;
import com.linzi.xiguwen.bean.WeddingNewsBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.ui.WenzhangDetailsActivity;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.view.MyRefreshFooter;
import com.linzi.xiguwen.view.MyRefreshHeader;
import com.scwang.smartrefresh.layout.SmartRefreshLayout;
import com.scwang.smartrefresh.layout.api.RefreshLayout;
import com.scwang.smartrefresh.layout.listener.OnRefreshLoadMoreListener;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2017/12/11.
 */

public class HunLiNewsFragment extends BaseFragment {

    @BindView(R.id.refresh_layout)
    SmartRefreshLayout refreshLayout;
    @BindView(R.id.recycle)
    RecyclerView recycleView;
    @BindView(R.id.nodata_layout)
    View mNodataLayout;

    private boolean isPrepare = false;
    private int mPage = 1;
    private int mRows = 15;

    private List<WeddingNewsBean> mDatas;
    private int mStatus;
    private MineNewsAdapter mAdapter;

    public static HunLiNewsFragment newInstance(int status) {
        Bundle args = new Bundle();
        args.putInt("status", status);
        HunLiNewsFragment fragment = new HunLiNewsFragment();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View view = LayoutInflater.from(getActivity()).inflate(R.layout.fragment_refresh_list_layout, null);
        ButterKnife.bind(this, view);
        return view;
    }

    @Override
    public void onActivityCreated(Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);
        mStatus = getArguments().getInt("status", -1);
        initViews();
    }

    private void initViews() {
        LinearLayoutManager manager = new LinearLayoutManager(getContext());
        recycleView.setLayoutManager(manager);

        mDatas = new ArrayList<>();
        mAdapter = new MineNewsAdapter(getActivity(), mDatas, new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int postion) {
                WeddingNewsBean newsBean = mDatas.get(postion);
                Intent intent = new Intent(getActivity(), WenzhangDetailsActivity.class);
                ShareContentBean shareContentBean = new ShareContentBean();
                shareContentBean.setTitle(newsBean.getTitle());
                shareContentBean.setUrl(newsBean.getContent());
                shareContentBean.setDescr(newsBean.getDescr());
                shareContentBean.setImage(newsBean.getImg());
                //WenzhangDetailsActivity.startAction(getContext(), newsBean.getContent(), "新闻详情", true);
                intent.putExtra("shareBean", shareContentBean);
                intent.putExtra("title", "新闻详情");
                intent.putExtra("isWeddingNewsShare", 1);
                intent.putExtra("url", shareContentBean.getUrl());
                intent.putExtra("isShowShare", true);
                intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TOP);
                getActivity().startActivity(intent);
            }
        });
        recycleView.setAdapter(mAdapter);

        refreshLayout.setEnableRefresh(true);
        refreshLayout.setEnableLoadMore(true);
        refreshLayout.setRefreshHeader(new MyRefreshHeader(getContext()));
        refreshLayout.setRefreshFooter(new MyRefreshFooter(getContext()));
        refreshLayout.setEnableLoadMoreWhenContentNotFull(true); // 设置没有满屏也可以加载更多
        refreshLayout.setOnRefreshLoadMoreListener(new OnRefreshLoadMoreListener() {
            @Override
            public void onLoadMore(@NonNull RefreshLayout refreshLayout) {
                requestNetData(false);
            }

            @Override
            public void onRefresh(@NonNull RefreshLayout refreshLayout) {
                requestNetData(true);
            }
        });

        refreshLayout.autoRefresh();
    }

    private void requestNetData(final boolean isRefresh) {
        ApiManager.getWeddingNews(mStatus, isRefresh ? 1 : mPage, mRows, new OnRequestFinish<BaseBean<List<WeddingNewsBean>>>() {
            @Override
            public void onFinished() {
                refreshLayout.finishRefresh(0);
                refreshLayout.finishLoadMore(0);
            }

            @Override
            public void onSuccess(BaseBean<List<WeddingNewsBean>> data) {
                if (isRefresh) {
                    mPage = 1;
                    mDatas.clear();
                }
                mPage++;
                mDatas.addAll(data.getData());
                mAdapter.notifyDataSetChanged();
                if (mDatas.size() == 0) {
                    mNodataLayout.setVisibility(View.VISIBLE);
                } else {
                    mNodataLayout.setVisibility(View.GONE);
                }
                if (data.getData().size() < mRows) {
                    refreshLayout.setNoMoreData(true);
                } else {
                    refreshLayout.setNoMoreData(false);
                }
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
                if (mDatas.size() == 0) {
                    mNodataLayout.setVisibility(View.VISIBLE);
                } else {
                    mNodataLayout.setVisibility(View.GONE);
                }
            }
        });
    }

    @Override
    protected void lazyLoad() {
        if (!isVisible || !isPrepare) {
            return;
        }
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
         
    }
}
