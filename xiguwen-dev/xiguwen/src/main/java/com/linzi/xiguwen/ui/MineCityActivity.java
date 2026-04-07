package com.linzi.xiguwen.ui;

import android.os.Bundle;
import androidx.annotation.NonNull;
import androidx.recyclerview.widget.LinearLayoutManager;

import android.view.View;
import android.view.ViewGroup;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.MineServiceAdapter;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.ServiceCity;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.DPUtils;
import com.linzi.xiguwen.utils.MsgLoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.view.AskDialog;
import com.linzi.xiguwen.view.MyRefreshFooter;
import com.linzi.xiguwen.view.MyRefreshHeader;
import com.lljjcoder.Interface.OnCityItemClickListener;
import com.lljjcoder.bean.CityBean;
import com.lljjcoder.bean.DistrictBean;
import com.lljjcoder.bean.ProvinceBean;
import com.lljjcoder.citywheel.CityConfig;
import com.lljjcoder.style.citylist.Toast.ToastUtils;
import com.lljjcoder.style.citypickerview.CityPickerView;
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

public class MineCityActivity extends BaseActivity {

    @BindView(R.id.refresh_layout)
    SmartRefreshLayout refreshLayout;
    @BindView(R.id.recycle)
    SwipeMenuRecyclerView recycleView;
    @BindView(R.id.nodata_layout)
    View mNodataLayout;

    private int mPage = 1;
    private int mRows = 15;
    MineServiceAdapter mAdapter;
    private List<ServiceCity> mDatas;

    private final CityPickerView mPicker=new CityPickerView();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_mine_city);
        ButterKnife.bind(this);
        mPicker.init(this);
    }


    private void showCity() {
        CityConfig cityConfig = new CityConfig.Builder()
                .setCityWheelType(CityConfig.WheelType.PRO_CITY)
                .build();
        cityConfig.setDefaultProvinceName("四川省");
        cityConfig.setDefaultCityName("成都市");
        mPicker.setConfig(cityConfig);

//监听选择点击事件及返回结果
        mPicker.setOnCityItemClickListener(new OnCityItemClickListener() {
            @Override
            public void onSelected(ProvinceBean province, CityBean cityBean, DistrictBean district) {
                addServiceCity(province.getName(), cityBean.getName());
            }

            @Override
            public void onCancel() {
                ToastUtils.showLongToast(mContext, "已取消");
            }
        });

        //显示
        mPicker.showCityPicker( );

    }
    @Override
    protected void initData() {
        setTitle("服务城市");
        setBack();
        setRightAdd(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                showCity();
            }
        });

        LinearLayoutManager manager=new LinearLayoutManager(this);
        recycleView.setLayoutManager(manager);
        mDatas = new ArrayList<>();
        mAdapter=new MineServiceAdapter(this, mDatas, new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int postion) {
            }
        });
        recycleView.setSwipeMenuCreator(new SwipeMenuCreator() {
            @Override
            public void onCreateMenu(SwipeMenu swipeLeftMenu, SwipeMenu swipeRightMenu, int viewType) {
                SwipeMenuItem item = new SwipeMenuItem(MineCityActivity.this);
                item.setBackgroundColorResource(R.color.red_color);
                item.setText("删除");
                item.setTextColorResource(R.color.colorWhite);
                item.setHeight(ViewGroup.LayoutParams.MATCH_PARENT);
                item.setWidth((int) DPUtils.DPToPX(MineCityActivity.this, 80));
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
        ApiManager.delMyServiceCity(mDatas.get(position).getId(), new OnRequestFinish<BaseBean<String>>() {
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
     * 添加服务城市
     * @param province  省份
     * @param city      城市
     */
    private void addServiceCity(String province, String city) {
        MsgLoadDialog.showDialog(this,"请稍候...");
        ApiManager.addMyServiceCity(province, city, new OnRequestFinish<BaseBean<String>>() {
            @Override
            public void onFinished() {
                MsgLoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<String> data) {
                NToast.show("添加成功");
                refreshLayout.autoRefresh();
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
    private void requestNetData(final boolean isRefresh){
        ApiManager.getMyServiceCityList(isRefresh ? 1 : mPage, mRows,new OnRequestFinish<BaseBean<List<ServiceCity>>>() {
            @Override
            public void onFinished() {
                refreshLayout.finishRefresh(0);
            }

            @Override
            public void onSuccess(BaseBean<List<ServiceCity>> data) {
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
                }else{
                    mNodataLayout.setVisibility(View.VISIBLE);
                }
            }
        });
    }
}
