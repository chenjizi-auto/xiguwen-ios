package com.linzi.xiguwen.ui;

import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.MineDangqi2Adapter;
import com.linzi.xiguwen.bean.MyGradeBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.MsgLoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.PopChooserUtils;
import com.linzi.xiguwen.utils.StatusBarUtil;
import com.linzi.xiguwen.view.MyRefreshFooter;
import com.linzi.xiguwen.view.MyRefreshHeader;
import com.scwang.smartrefresh.layout.SmartRefreshLayout;
import com.scwang.smartrefresh.layout.api.RefreshLayout;
import com.scwang.smartrefresh.layout.listener.OnRefreshLoadMoreListener;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class MineDangqiActivity extends AppCompatActivity {

    @BindView(R.id.ll_bar)
    LinearLayout llBar;
    @BindView(R.id.iv_back)
    ImageView ivBack;
    @BindView(R.id.iv_add)
    ImageView ivAdd;
    @BindView(R.id.iv_setting)
    ImageView ivSetting;
    @BindView(R.id.recycle_view)
    RecyclerView recyclerView;
    @BindView(R.id.refresh_layout)
    SmartRefreshLayout refreshLayout;
    @BindView(R.id.bt_shengcheng)
    Button btShengcheng;
    @BindView(R.id.nodata_layout)
    View mNodataLayout;

    private MineDangqi2Adapter mAdapter;
    private Context mContext;

    private int mPage = 1;  // 加载页
    private int mRows = 20; // 每页条数

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        com.linzi.xiguwen.utils.LogUtil.e("oncreate ","MineDangqiActivity");
        //改变为白色背景黑色字体的状态栏
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
            StatusBarUtil.setStatusBarColor(MineDangqiActivity.this, R.color.white);
        }
        setContentView(R.layout.activity_mine_dangqi);
        ButterKnife.bind(this);
        mContext = this;
        initViews();
    }

    private void initViews() {
        //获得状态栏高度
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, StatusBarUtil.getStatusBarHeight(MineDangqiActivity.this));
        llBar.setLayoutParams(params);

        final LinearLayoutManager manager = new LinearLayoutManager(mContext);
        recyclerView.setLayoutManager(manager);
        mAdapter = new MineDangqi2Adapter(mContext);
        mAdapter.setItemClickListener(new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int postion) {
                DangQiDetailsActivity.startActivityForResult(MineDangqiActivity.this, mAdapter.getChild(postion), 101);
            }
        });
        recyclerView.setAdapter(mAdapter);

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
        refreshLayout.setRefreshHeader(new MyRefreshHeader(this));
        refreshLayout.setRefreshFooter(new MyRefreshFooter(this));
        refreshLayout.setEnableLoadMoreWhenContentNotFull(true); // 设置没有满屏也可以加载更多
        refreshLayout.setEnableRefresh(true);


        refreshLayout.autoRefresh();
    }


    private void requestNetData(final boolean refresh) {
        ApiManager.getGradeList(refresh ? 1 : mPage, mRows, new OnRequestFinish<BaseBean<List<MyGradeBean>>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<List<MyGradeBean>> data) {
                if (refresh) {
                    mPage = 1;
                    mAdapter.setDatas(data.getData());
                    if (data.getData().size() == 0) {
                        mNodataLayout.setVisibility(View.VISIBLE);
                    } else {
                        mNodataLayout.setVisibility(View.GONE);
                    }
                } else {
                    mAdapter.addDatas(data.getData());
                }
                mPage++;

                refreshLayout.finishRefresh(0, true);
                refreshLayout.finishLoadMore(0, true, false);
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
                refreshLayout.finishRefresh(false);
                refreshLayout.finishLoadMore(false);
            }
        });
    }

    private String url2;//生成图片的地址
    private void createGradeCard2() {
        MsgLoadDialog.showDialog(this, "请稍候...");
        ApiManager.createGradeCard(2,new OnRequestFinish<BaseBean<String>>() {
            @Override
            public void onFinished() {
                MsgLoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<String> data) {
                //WebViewActivity.startActivity(MineDangqiActivity.this, data.getData());
                // activity.startAction(MineDangqiActivity.this, data.getData(), "我的档期卡", true);
                Intent intent = new Intent(mContext, WenzhangDetailsActivity.class);
                intent.putExtra("url", data.getData());
                intent.putExtra("title", "我的档期卡");
                intent.putExtra("isShowShare", true);
                intent.putExtra("isDangQiShare", 1);
                intent.putExtra("DangQiValue",2 );
                intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TOP);
                mContext.startActivity(intent);
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
            }
        });
    }

    private void createGradeCard() {
        MsgLoadDialog.showDialog(this, "请稍候...");
        ApiManager.createGradeCard(1,new OnRequestFinish<BaseBean<String>>() {
            @Override
            public void onFinished() {
                MsgLoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<String> data) {
                //WebViewActivity.startActivity(MineDangqiActivity.this, data.getData());
                // activity.startAction(MineDangqiActivity.this, data.getData(), "我的档期卡", true);
                Intent intent = new Intent(mContext, WenzhangDetailsActivity.class);
                intent.putExtra("url", data.getData());
                intent.putExtra("title", "我的档期卡");
                intent.putExtra("isShowShare", true);
                intent.putExtra("isDangQiShare", 1);
                intent.putExtra("DangQiValue", 1);
                intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_CLEAR_TOP);
                mContext.startActivity(intent);
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
            }
        });
    }

    private String[] menuTitles = new String[]{"链接分享", "图片分享"};

    @OnClick({R.id.iv_back, R.id.iv_add, R.id.iv_setting, R.id.bt_shengcheng})
    public void onClick(View view) {
        Intent intent;
        switch (view.getId()) {
            case R.id.iv_back:
                finish();
                break;
            case R.id.iv_add:
                intent = new Intent(this, MineAddDangQiActivity.class);
                startActivityForResult(intent, 102);
                break;
            case R.id.iv_setting:
                intent = new Intent(this, MineDangqiJiedanNumActivity.class);
                startActivityForResult(intent, 103);
                break;
            case R.id.bt_shengcheng:


                new PopChooserUtils(MineDangqiActivity.this)
                        .setChooseData(menuTitles)
                        .setListenner(new PopChooserUtils.ItemClickListener() {
                            @Override
                            public void popItemClick(View view, int position) {
                                switch (position) {
                                    case 0: //H5分享
                                        createGradeCard();
                                        break;
                                    case 1: //图片分享
                                        createGradeCard2();
                                        break;
                                }
                            }
                        })
                        .show(btShengcheng);
                break;
        }
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (resultCode == RESULT_OK) {
            refreshLayout.autoRefresh();
        }
    }
}
