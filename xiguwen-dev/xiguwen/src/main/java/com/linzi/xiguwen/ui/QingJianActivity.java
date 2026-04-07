package com.linzi.xiguwen.ui;

import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.MobanAdapter;
import com.linzi.xiguwen.adapter.WrapperAdapter;
import com.linzi.xiguwen.bean.NewMineInvitationBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.StatusBarUtil;
import com.linzi.xiguwen.view.MyRefreshFooter;
import com.linzi.xiguwen.view.MyRefreshHeader;
import com.scwang.smartrefresh.layout.SmartRefreshLayout;
import com.scwang.smartrefresh.layout.api.RefreshLayout;
import com.scwang.smartrefresh.layout.listener.OnRefreshLoadMoreListener;


import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

public class QingJianActivity extends AppCompatActivity {

    @BindView(R.id.ll_bar)
    LinearLayout llBar;
    @BindView(R.id.iv_back)
    ImageView ivBack;
    @BindView(R.id.tv_title)
    TextView tvTitle;
    @BindView(R.id.recycle)
    RecyclerView recycle;
    @BindView(R.id.ll_nodata)
    LinearLayout llNodata;
    @BindView(R.id.bt_create)
    Button btCreate;
    @BindView(R.id.refresh_layout)
    SmartRefreshLayout refreshLayout;

    Context mContext;

    WrapperAdapter mWrapperAdapter;
    List<NewMineInvitationBean.UserBean> mList;
    private int mPage = 1;
    private int mRows = 15;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
//        //改变为白色背景黑色字体的状态栏
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
            StatusBarUtil.setStatusBarColor(QingJianActivity.this, R.color.trans);
            StatusBarUtil.setNavigationBarColor(QingJianActivity.this, R.color.white);
        }
        setContentView(R.layout.activity_qing_jian);
        ButterKnife.bind(this);
        mContext=this;
        initViews();
    }
    private void initViews(){
        //获得状态栏高度
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, StatusBarUtil.getStatusBarHeight(QingJianActivity.this));
        llBar.setLayoutParams(params);

        tvTitle.setText("电子请柬");
        ivBack.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                finish();
            }
        });

        mList=new ArrayList<>();

        btCreate.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent=new Intent(mContext,ChooseMobanActivity.class);
                startActivityForResult(intent, 100);
            }
        });

        GridLayoutManager manager=new GridLayoutManager(mContext,2);
        recycle.setLayoutManager(manager);
        MobanAdapter adapter =new MobanAdapter(mContext, new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int postion) {
                NewMineInvitationBean.UserBean data = mList.get(postion);
                QingjianEditActivity.ShareBean shareBean = new QingjianEditActivity.ShareBean();
                shareBean.setUrl(data.getUrl());
                shareBean.setInvitationsId(data.getId());
                shareBean.setShareurl(data.getShareurl());
//                shareBean.setGirlName(data.getXinniang());
//                shareBean.setBoyName(data.getXinlang());
//                shareBean.setTime(data.getHunlitime());
//                shareBean.setHotle(data.getHotel());
//                shareBean.setAddress(data.getHunlidizhi());
                QingjianEditActivity.startActivityForResult(QingJianActivity.this, shareBean,1, 123);
            }
        });
        adapter.setmList(mList);
        mWrapperAdapter = new WrapperAdapter(adapter);

        recycle.setAdapter(mWrapperAdapter);


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

//    // 显示请柬内容
//    private void showInvitationContent(final int position){
//        //请求编辑url
//        MsgLoadDialog.showDialog(this, "请稍候...");
//        ApiManager.getInvitationUrl(mList.get(position).getId(), true, new OnRequestFinish<BaseBean<String>>() {
//            @Override
//            public void onFinished() {
//                MsgLoadDialog.CancelDialog();
//            }
//
//            @Override
//            public void onSuccess(BaseBean<String> data) {
//                QingjianEditActivity.ShareBean shareBean = new QingjianEditActivity.ShareBean();
//                shareBean.setUrl(data.getData());
//                MineInvitationBean.DataBean list = mList.get(position);
//                shareBean.setInvitationsId(list.getId());
//                shareBean.setGirlName(list.getXinniang());
//                shareBean.setBoyName(list.getXinlang());
//                shareBean.setTime(list.getHunlitime());
//                shareBean.setHotle(list.getHotel());
//                shareBean.setAddress(list.getHunlidizhi());
//                QingjianEditActivity.startActivityForResult(QingJianActivity.this, shareBean, 123);
//            }
//
//            @Override
//            public void onError(Exception ex) {
//                NToast.show(ex.getMessage());
//                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
//            }
//        });
//    }

    private void requestNetData(final boolean isRefresh){
        ApiManager.getbNewMineInvitationList( isRefresh ? 1 : mPage, mRows, new OnRequestFinish<BaseBean<NewMineInvitationBean>>() {
            @Override
            public void onFinished() {
                refreshLayout.finishRefresh(0);
                refreshLayout.finishLoadMore(0);
            }

            @Override
            public void onSuccess(BaseBean<NewMineInvitationBean> data) {
                if (isRefresh) {
                    mList.clear();
                    mPage = 1;
                }
                mPage++;
                if(data.getData() != null && data.getData() != null){
                    mList.addAll(data.getData().getUser());
                    if (data.getData().getUser().size() < mRows) {
                        refreshLayout.setNoMoreData(true);
                    } else {
                        refreshLayout.setNoMoreData(false);
                    }
                }
                if (mList.size() == 0) {
                    llNodata.setVisibility(View.VISIBLE);
                }else{
                    llNodata.setVisibility(View.GONE);
                }
                mWrapperAdapter.notifyDataSetChanged();
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
                if (mList.size() == 0) {
                    llNodata.setVisibility(View.VISIBLE);
                }
            }
        });
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if(resultCode == RESULT_OK){
            refreshLayout.autoRefresh();
        }
    }
}
