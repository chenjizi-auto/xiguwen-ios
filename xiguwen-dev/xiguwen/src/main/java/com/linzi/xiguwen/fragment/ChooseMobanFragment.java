package com.linzi.xiguwen.fragment;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import androidx.annotation.NonNull;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.Moban2Adapter;
import com.linzi.xiguwen.base.BaseFragment;
import com.linzi.xiguwen.bean.InvitationsTemplateBean;
import com.linzi.xiguwen.bean.InvitationsTemplateTypeBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.ui.QingjianZhiZuoYulanActivity;
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

public class ChooseMobanFragment extends BaseFragment {

    @BindView(R.id.refresh_layout)
    SmartRefreshLayout refreshLayout;
    @BindView(R.id.recycle)
    RecyclerView recycleView;
    @BindView(R.id.nodata_layout)
    View mNodataLayout;

    private InvitationsTemplateTypeBean mType;
    private List<InvitationsTemplateBean.DataBean> mDatas;

    private boolean isPrepare = false;
    private Moban2Adapter mAdapter;


    private int mPage = 1;
    private int mRows = 15;

    public static ChooseMobanFragment newInstance(InvitationsTemplateTypeBean type) {
        Bundle args = new Bundle();
        args.putSerializable("type", type);
        ChooseMobanFragment fragment = new ChooseMobanFragment();
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
        initViews();
    }

    private void initViews() {
        Bundle bu = getArguments();
        mType = (InvitationsTemplateTypeBean) bu.getSerializable("type");

        GridLayoutManager manager = new GridLayoutManager(getActivity(), 3);
        recycleView.setLayoutManager(manager);

        mDatas = new ArrayList<>();
        mAdapter = new Moban2Adapter(getContext(), new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int postion) {
                QingjianZhiZuoYulanActivity.startActivityForResult(getActivity(), mDatas.get(postion), 100);
            }
        });
        mAdapter.setmList(mDatas);
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

    /**
     * 请求网络数据
     *
     * @param isRefresh
     */
    private void requestNetData(final boolean isRefresh) {
        ApiManager.getInvitationsTemplateList(mType.getId(), isRefresh ? 1 : mPage, mRows, new OnRequestFinish<BaseBean<InvitationsTemplateBean>>() {
            @Override
            public void onFinished() {
                refreshLayout.finishRefresh(0);
                refreshLayout.finishLoadMore(0);
            }

            @Override
            public void onSuccess(BaseBean<InvitationsTemplateBean> data) {
                if (isRefresh) {
                    mDatas.clear();
                    mPage = 1;
                }
                mPage++;
                if (data.getData() != null && data.getData() != null) {
                    mDatas.addAll(data.getData().getData());
                    if (data.getData().getData().size() < mRows) {
                        refreshLayout.setNoMoreData(true);
                    } else {
                        refreshLayout.setNoMoreData(false);
                    }
                }
                if (mDatas.size() == 0) {
                    mNodataLayout.setVisibility(View.VISIBLE);
                } else {
                    mNodataLayout.setVisibility(View.GONE);
                }
                mAdapter.notifyDataSetChanged();
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
                if (mDatas.size() == 0) {
                    mNodataLayout.setVisibility(View.VISIBLE);
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
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (resultCode == Activity.RESULT_OK) {
            refreshLayout.autoRefresh();
        }
    }
}
