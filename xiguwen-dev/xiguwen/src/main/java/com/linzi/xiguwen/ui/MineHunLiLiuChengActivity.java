package com.linzi.xiguwen.ui;

import android.content.Intent;
import android.os.Bundle;
import androidx.annotation.NonNull;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.View;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.HunliLiuchengAdapter;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.WeddingFlowBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
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

public class MineHunLiLiuChengActivity extends BaseActivity implements CallBack.DelListener, CallBack.EditListener {

    @BindView(R.id.refresh_layout)
    SmartRefreshLayout refreshLayout;
    @BindView(R.id.recycle)
    RecyclerView recycle;
    @BindView(R.id.nodata_layout)
    View mNodataLayout;

    private int mPage = 1;
    private int mRows = 10;
    private List<WeddingFlowBean> mDatas;
    HunliLiuchengAdapter mAdapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_mine_hun_li_liu_cheng);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        setTitle("婚礼流程");
        setBack();
        setRightAdd(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent=new Intent(mContext,AddLiuchengActivity.class);
                startActivityForResult(intent, 100);
            }
        });

        LinearLayoutManager manager=new LinearLayoutManager(mContext);
        recycle.setLayoutManager(manager);

        mDatas = new ArrayList<>();
        mAdapter=new HunliLiuchengAdapter(mContext, mDatas);
        mAdapter.setEditListener(this);
        mAdapter.setDelListener(this);
        recycle.setAdapter(mAdapter);

        refreshLayout.setEnableRefresh(true);
        refreshLayout.setEnableLoadMore(true);
        refreshLayout.setRefreshHeader(new MyRefreshHeader(this));
        refreshLayout.setRefreshFooter(new MyRefreshFooter(this));
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


    // 请求网络数据
    private void requestNetData(final boolean refresh){
        ApiManager.getWeddingFlowList(refresh ? 1 : mPage, mRows, new OnRequestFinish<BaseBean<List<WeddingFlowBean>>>() {
            @Override
            public void onFinished() {
                refreshLayout.finishRefresh(0);
                refreshLayout.finishLoadMore(0);
            }

            @Override
            public void onSuccess(BaseBean<List<WeddingFlowBean>> data) {
                if (refresh) {
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
    public void del(final int id) {
        final AskDialog dialog=new AskDialog(mContext,this);
        dialog.setTitle("确定要删除婚礼流程吗？");
        dialog.setMessage("删除后将不能恢复哦~");
        dialog.setCancleListener("我点错了", new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                dialog.dismiss();
            }
        });
        dialog.setSubmitListener("确认删除", new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                dialog.dismiss();
                del(mDatas.get(id));
            }
        });
        dialog.show();
    }

    private void del(final WeddingFlowBean data) {
        if(data != null){
            MsgLoadDialog.showDialog(this,"删除中...");
            ApiManager.delWeddingFlowList(data.getId(), new OnRequestFinish<BaseBean<String>>() {
                @Override
                public void onFinished() {
                    MsgLoadDialog.CancelDialog();
                }

                @Override
                public void onSuccess(BaseBean<String> result) {
                    NToast.show("删除成功");
                    int index = mDatas.indexOf(data);
                    mDatas.remove(data);
                    mAdapter.notifyItemRemoved(index);
                }

                @Override
                public void onError(Exception ex) {
                    NToast.show(ex.getMessage());
                    com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
                }
            });
        }
    }

    @Override
    public void edit(int id) {
        Intent intent=new Intent(mContext,AddLiuchengActivity.class);
        intent.putExtra("data", mDatas.get(id));
        startActivityForResult(intent, 100);
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if(resultCode == RESULT_OK){
            refreshLayout.autoRefresh();
        }
    }
}
