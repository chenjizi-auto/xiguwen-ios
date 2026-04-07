package com.linzi.xiguwen.ui;

import android.content.Intent;
import android.os.Bundle;
import androidx.annotation.NonNull;
import androidx.recyclerview.widget.LinearLayoutManager;

import android.view.View;
import android.view.ViewGroup;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.MineTuijianAdapter;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.RecommendedTeam;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.DPUtils;
import com.linzi.xiguwen.utils.MsgLoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.view.AskDialog;
import com.linzi.xiguwen.view.MyRefreshFooter;
import com.linzi.xiguwen.view.MyRefreshHeader;
import com.scwang.smartrefresh.layout.SmartRefreshLayout;
import com.scwang.smartrefresh.layout.api.RefreshLayout;
import com.scwang.smartrefresh.layout.listener.OnRefreshLoadMoreListener;
import com.yanzhenjie.recyclerview.swipe.SwipeMenu;
import com.yanzhenjie.recyclerview.swipe.SwipeMenuBridge;
import com.yanzhenjie.recyclerview.swipe.SwipeMenuCreator;
import com.yanzhenjie.recyclerview.swipe.SwipeMenuItem;
import com.yanzhenjie.recyclerview.swipe.SwipeMenuItemClickListener;
import com.yanzhenjie.recyclerview.swipe.SwipeMenuRecyclerView;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

public class MineTuijianActivity extends BaseActivity {

    @BindView(R.id.refresh_layout)
    SmartRefreshLayout refreshLayout;
    @BindView(R.id.recycle)
    SwipeMenuRecyclerView recycleView;
    @BindView(R.id.nodata_layout)
    View mNodataLayout;

    MineTuijianAdapter mAdapter;
    private List<RecommendedTeam> mDatas;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_mine_tuijian);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        setTitle("推荐团队");
        setBack();
        setRightAdd(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent=new Intent(mContext,MineAddTuijianActivity.class);
                startActivityForResult(intent, 100);
            }
        });

        LinearLayoutManager manager=new LinearLayoutManager(this);
        recycleView.setLayoutManager(manager);
        mDatas = new ArrayList<>();
        mAdapter=new MineTuijianAdapter(this, mDatas, new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int postion) {

            }
        });
        recycleView.setSwipeMenuCreator(new SwipeMenuCreator() {
            @Override
            public void onCreateMenu(SwipeMenu swipeLeftMenu, SwipeMenu swipeRightMenu, int viewType) {
                SwipeMenuItem item = new SwipeMenuItem(MineTuijianActivity.this);
                item.setBackgroundColorResource(R.color.red_color);
                item.setText("删除");
                item.setTextColorResource(R.color.colorWhite);
                item.setHeight(ViewGroup.LayoutParams.MATCH_PARENT);
                item.setWidth((int) DPUtils.DPToPX(MineTuijianActivity.this, 80));
                swipeRightMenu.addMenuItem(item);
            }
        });
        recycleView.setSwipeMenuItemClickListener(new SwipeMenuItemClickListener() {
            @Override
            public void onItemClick(SwipeMenuBridge menuBridge) {
                del(menuBridge.getAdapterPosition());
                menuBridge.closeMenu();
            }
        });
        recycleView.setAdapter(mAdapter);

        refreshLayout.setEnableRefresh(true);
        refreshLayout.setEnableLoadMore(false);

        refreshLayout.setRefreshHeader(new MyRefreshHeader(this));
        refreshLayout.setRefreshFooter(new MyRefreshFooter(this));
//        refreshLayout.setEnableLoadMoreWhenContentNotFull(true); // 设置没有满屏也可以加载更多
        refreshLayout.setOnRefreshLoadMoreListener(new OnRefreshLoadMoreListener() {
            @Override
            public void onLoadMore(@NonNull RefreshLayout refreshLayout) {

            }

            @Override
            public void onRefresh(@NonNull RefreshLayout refreshLayout) {
                requestNetData();

            }
        });

        refreshLayout.autoRefresh();
    }

    // s删除
    private void del(final int position){
        final AskDialog dialog = new AskDialog(this, this);
        dialog.setTitle("警告");
        dialog.setMessage("是否删除该服务城市？");
        dialog.setCancleListener("我点错了", new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dialog.dismiss();
            }
        });
        dialog.setSubmitListener("确定删除", new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                _del(position);
                dialog.dismiss();
            }
        });
        dialog.show();
    }

    private void _del(final int position){
        MsgLoadDialog.showDialog(this, "删除中...");
        ApiManager.delRecommendedTeam(mDatas.get(position).getId(), new OnRequestFinish<BaseBean<String>>() {
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


    /**
     * 请求网络数据
     */
    private void requestNetData(){
        ApiManager.getRecommendedTeamList(new OnRequestFinish<BaseBean<List<RecommendedTeam>>>() {
            @Override
            public void onFinished() {
                refreshLayout.finishRefresh(0);
            }

            @Override
            public void onSuccess(BaseBean<List<RecommendedTeam>> data) {
                mDatas.clear();
                mDatas.addAll(data.getData());
                mAdapter.notifyDataSetChanged();
                if (mDatas.size() == 0) {
                    mNodataLayout.setVisibility(View.VISIBLE);
                }else{
                    mNodataLayout.setVisibility(View.GONE);
                }
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
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if(requestCode == 100){
            if(resultCode == RESULT_OK){
                refreshLayout.autoRefresh();
            }
        }
    }
}
