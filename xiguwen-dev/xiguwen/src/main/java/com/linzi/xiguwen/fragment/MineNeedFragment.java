package com.linzi.xiguwen.fragment;

import android.app.Activity;
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
import com.linzi.xiguwen.adapter.MineNeedAdapter;
import com.linzi.xiguwen.base.BaseFragment;
import com.linzi.xiguwen.bean.MineNeedBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.ui.ForNeedActivity;
import com.linzi.xiguwen.ui.NeedDetailsActivity;
import com.linzi.xiguwen.utils.CallBack;
import com.linzi.xiguwen.utils.MsgLoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.view.AskDialog;
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

public class MineNeedFragment extends BaseFragment implements CallBack.EditListener, CallBack.CloseListener, CallBack.DelListener {
    @BindView(R.id.refresh_layout)
    SmartRefreshLayout refreshLayout;
    @BindView(R.id.recycle)
    RecyclerView recycle;
    @BindView(R.id.nodata_layout)
    View mNodataLayout;

    private boolean isPrepare = false;
    private int mStatus;
    private List<MineNeedBean> mDatas;
    MineNeedAdapter mAdapter;

    private int mPage = 1;
    private int mRows = 10;

    public static MineNeedFragment newInstance (int status) {
        Bundle args = new Bundle();
        args.putInt("status", status);
        MineNeedFragment fragment=new MineNeedFragment();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,Bundle savedInstanceState) {
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

    private void initViews(){
        LinearLayoutManager manager=new LinearLayoutManager(getContext());
        recycle.setLayoutManager(manager);

        mDatas = new ArrayList<>();
        mAdapter=new MineNeedAdapter(getActivity(), mDatas, true, new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int postion) {
                NeedDetailsActivity.startActivity(getContext(), mDatas.get(postion));
            }
        });
        mAdapter.setmEdit(this);
        mAdapter.setmClose(this);
        mAdapter.setmDel(this);
        recycle.setAdapter(mAdapter);

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

    private void requestNetData(final boolean isRefresh){
        ApiManager.getMineNeedList(mStatus, isRefresh ? 1 : mPage, mRows, new OnRequestFinish<BaseBean<List<MineNeedBean>>>() {
            @Override
            public void onFinished() {
                refreshLayout.finishRefresh(0);
                refreshLayout.finishLoadMore(0);
            }

            @Override
            public void onSuccess(BaseBean<List<MineNeedBean>> data) {
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
    public void edit(int in) {
        Intent intent = new Intent(getContext(), ForNeedActivity.class);
        intent.putExtra("data", mDatas.get(in));
        startActivityForResult(intent, 100);
    }

    @Override
    public void close(final int in) {
        final AskDialog dialog = new AskDialog(getContext(), getActivity());
        dialog.setTitle("警告");
        dialog.setMessage("是否关闭此条需求？");
        dialog.setSubmitListener("确定关闭", new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dialog.dismiss();
                _close(in);
            }
        });
        dialog.setCancleListener("我点错了", new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dialog.dismiss();
            }
        });
        dialog.show();
    }

    private void _close(int position){
        MsgLoadDialog.showDialog(getContext(), "关闭中...");
        ApiManager.closeMineNeed(mDatas.get(position).getId(), new OnRequestFinish<BaseBean<String>>() {
            @Override
            public void onFinished() {
                MsgLoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<String> data) {
                NToast.show("关闭成功");
                refreshLayout.autoRefresh();
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
            }
        });
    }

    @Override
    public void del(final int in) {
        final AskDialog dialog = new AskDialog(getContext(), getActivity());
        dialog.setTitle("警告");
        dialog.setMessage("是否删除此条需求？");
        dialog.setSubmitListener("确定删除", new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dialog.dismiss();
                _del(in);
            }
        });
        dialog.setCancleListener("我点错了", new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dialog.dismiss();
            }
        });
        dialog.show();
    }

    private void _del(final int position){
        MsgLoadDialog.showDialog(getContext(), "删除中...");
        ApiManager.delMineNeed(mDatas.get(position).getId(), new OnRequestFinish<BaseBean<String>>() {
            @Override
            public void onFinished() {
                MsgLoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<String> data) {
                NToast.show("删除成功");
                mDatas.remove(position);
                mAdapter.notifyItemRemoved(position);
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
            }
        });
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if(resultCode == Activity.RESULT_OK){
            refreshLayout.autoRefresh();
        }
    }

    @Override
    protected void lazyLoad() {
        if (!isVisible || !isPrepare) {
            return;
        }
    }
}
