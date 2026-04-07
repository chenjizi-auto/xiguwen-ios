package com.linzi.xiguwen.fragment.message;

import android.os.Build;
import android.os.Bundle;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.PrefrentialAdapter;
import com.linzi.xiguwen.bean.MessagePrefrentialBean;
import com.linzi.xiguwen.fragment.vm.RefreshViewModel;
import com.linzi.xiguwen.net.OnRequestSubscribe;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.ui.WenzhangDetailsActivity;
import com.linzi.xiguwen.utils.StatusBarUtil;
import com.linzi.xiguwen.utils.yixin.preference.Preferences;
import com.scwang.smartrefresh.layout.SmartRefreshLayout;
import com.scwang.smartrefresh.layout.api.RefreshLayout;
import com.scwang.smartrefresh.layout.listener.OnLoadMoreListener;
import com.scwang.smartrefresh.layout.listener.OnRefreshListener;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;


/**
 * Created by PC on 2018-04-06.
 */

public class PreferentialActivity extends AppCompatActivity implements com.jcodecraeer.xrecyclerview.OnItemClickListener1 {

    @BindView(R.id.ll_bar)
    View llBar;
    @BindView(R.id.tv_title)
    TextView tvTitle;
    @BindView(R.id.hot_recycle)
    RecyclerView mRecycle;
    @BindView(R.id.refreshLayout)
    SmartRefreshLayout refreshLayout;

    private PrefrentialAdapter mAdapter;
    private RefreshViewModel mRefreshViewModel;


    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
            StatusBarUtil.setStatusBarColor(PreferentialActivity.this, R.color.white);
            StatusBarUtil.setNavigationBarColor(PreferentialActivity.this, R.color.white);
        }
        Preferences.saveDiscount(0);
        setContentView(R.layout.activity_message_prefrential);
        ButterKnife.bind(this);

        //获得状态栏高度
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, StatusBarUtil.getStatusBarHeight(this));
        llBar.setLayoutParams(params);

        init();
        mRefreshViewModel.autoRefresh();
    }

    private void init() {
        tvTitle.setText("优惠");
        mAdapter = new PrefrentialAdapter(this, this);
        LinearLayoutManager manager = new LinearLayoutManager(this);
        mRecycle.setLayoutManager(manager);
        mRecycle.setAdapter(mAdapter);
        mRefreshViewModel = RefreshViewModel.initRefresh(refreshLayout).addOnRefreshListener(new OnRefreshListener() {
            @Override
            public void onRefresh(@NonNull final RefreshLayout refreshLayout) {
                mRefreshViewModel.resetPage();
                refreshLayout.setEnableLoadMore(true);
                requestData(refreshLayout, mRefreshViewModel.getPage(), true);
            }
        }).addOnLoadMoreListener(new OnLoadMoreListener() {
            @Override
            public void onLoadMore(@NonNull RefreshLayout refreshLayout) {
                mRefreshViewModel.pageAddOne();
                requestData(refreshLayout, mRefreshViewModel.getPage(), false);
            }
        });
    }

    @OnClick(R.id.iv_back)
    public void onViewClicked() {
        finish();
    }


    //---------------------------跟View相关的请求操作---------------------------------

    /**
     * @param refreshLayout
     * @param p
     * @param isRefreshOrLoadMore true 刷新  false 加载更多
     */
    private void requestData(@NonNull final RefreshLayout refreshLayout, int p, boolean isRefreshOrLoadMore) {
//        String comprehensive = mSortVm.getValue();
//        String cityId = mCityVm.getValue();
//        String type = mClassificationVm.getValue();

        String page = p + "";
        String row = "15";
//        String moneyMax = mScreenPopVM.getMaxPrice();
//        String moneyMin = mScreenPopVM.getMinPrice();
        if (isRefreshOrLoadMore) {
            refresh(refreshLayout, page, row);
        } else {
            loadMore(refreshLayout, page, row);
        }
    }

    private void refresh(@NonNull final RefreshLayout refreshLayout, String page, String row) {
        ApiManager.messagePrefrential(page, row, new OnRequestSubscribe<BaseBean<MessagePrefrentialBean>>() {
            @Override
            public void onSuccess(BaseBean<MessagePrefrentialBean> data) {
                refreshLayout.finishRefresh();
                mAdapter.addFirst(data.getData().getCont());
                if (data.getData().getCont().size() == 0) {
                    refreshLayout.setEnableLoadMore(false);
                }
            }

            @Override
            public void onError(Exception ex) {
                refreshLayout.finishRefresh();
            }
        });
    }

    private void loadMore(@NonNull final RefreshLayout refreshLayout, String page, String row) {
        ApiManager.messagePrefrential(page, row, new OnRequestSubscribe<BaseBean<MessagePrefrentialBean>>() {
            @Override
            public void onSuccess(BaseBean<MessagePrefrentialBean> data) {
                refreshLayout.finishLoadMore();
                if (data.getData() == null || data.getData().getCont() == null || data.getData().getCont().size() == 0) {
                    refreshLayout.setEnableLoadMore(false);
                } else {
                    mAdapter.addMore(data.getData().getCont());
                }
            }

            @Override
            public void onError(Exception ex) {
                refreshLayout.finishRefresh();
            }
        });
    }

    @Override
    public void onItemClick(View view, int postion, Object data) {
        MessagePrefrentialBean.PrefrentialList ben = (MessagePrefrentialBean.PrefrentialList) data;
        WenzhangDetailsActivity.startAction(this, ben.getSrc(), ben.getTitle(), true);
    }
}
