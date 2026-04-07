package com.linzi.xiguwen.ui;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import androidx.annotation.NonNull;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.View;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.FayangaoAdapter;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.FaYanGaoBean;
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

public class FayanListActivity extends BaseActivity implements CallBack.FayangaoEditListener,CallBack.FayangaoDelListener,com.jcodecraeer.xrecyclerview.OnItemClickListener{

    @BindView(R.id.refresh_layout)
    SmartRefreshLayout refreshLayout;
    @BindView(R.id.recycle)
    RecyclerView recycle;
    @BindView(R.id.nodata_layout)
    View mNodataLayout;

    FayangaoAdapter mAdapter;
    Context mContext;

    private int mPage = 1;
    private int mRows = 10;
    private List<FaYanGaoBean> mDatas;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_fayan_list);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        mContext=this;
        setBack();
        setTitle("婚礼宝典");
        setRightAdd(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent=new Intent(mContext,EditFayangaoActivity.class);
                startActivityForResult(intent, 100);
            }
        });

        mDatas = new ArrayList<>();
        mAdapter=new FayangaoAdapter(mContext,mDatas, this,this,this);
        LinearLayoutManager manager=new LinearLayoutManager(mContext);
        recycle.setLayoutManager(manager);
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
        ApiManager.getFaYanGaoList(refresh ? 1 : mPage, mRows, new OnRequestFinish<BaseBean<List<FaYanGaoBean>>>() {
            @Override
            public void onFinished() {
                refreshLayout.finishRefresh(0);
                refreshLayout.finishLoadMore(0);
            }

            @Override
            public void onSuccess(BaseBean<List<FaYanGaoBean>> data) {
                if(refresh){
                    mPage = 1;
                    mDatas.clear();
                }
                mPage ++;
                mDatas.addAll(data.getData());
                mAdapter.notifyDataSetChanged();
                if(mDatas.size() == 0){
                    mNodataLayout.setVisibility(View.VISIBLE);
                }else{
                    mNodataLayout.setVisibility(View.GONE);
                }
                if(data.getData().size() < mRows){
                    refreshLayout.setNoMoreData(true);
                }else{
                    refreshLayout.setNoMoreData(false);
                }
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
                if(mDatas.size() == 0){
                    mNodataLayout.setVisibility(View.VISIBLE);
                }else{
                    mNodataLayout.setVisibility(View.GONE);
                }
            }
        });
    }

    private void del(final FaYanGaoBean data){
        if(data != null){
            MsgLoadDialog.showDialog(this,"删除中...");
            ApiManager.delFaYanGao(data.getId(), new OnRequestFinish<BaseBean<String>>() {
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
    public void editListener(int id) {
        Intent intent=new Intent(mContext,EditFayangaoActivity.class);
        intent.putExtra("data", mDatas.get(id));
        startActivityForResult(intent, 100);
    }

    @Override
    public void delListener(final int id) {
        final AskDialog dialog=new AskDialog(mContext,FayanListActivity.this);
        dialog.setTitle("确定要删除吗？");
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

    @Override
    public void onItemClick(View view, int postion) {
        Intent intent=new Intent(mContext,ShowFayangaoActivity.class);
        intent.putExtra("data", mDatas.get(postion));
        startActivity(intent);
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if(resultCode == RESULT_OK){
            refreshLayout.autoRefresh();
        }
    }
}
