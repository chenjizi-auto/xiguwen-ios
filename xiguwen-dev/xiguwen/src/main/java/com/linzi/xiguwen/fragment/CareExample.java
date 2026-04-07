package com.linzi.xiguwen.fragment;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.View;
import android.widget.ImageView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.CareExampleAdapter;
import com.linzi.xiguwen.bean.AttentionData;
import com.linzi.xiguwen.bean.CaseBean;
import com.linzi.xiguwen.fragment.discover.BaseFragment;
import com.linzi.xiguwen.fragment.vm.RefreshViewModel;
import com.linzi.xiguwen.net.OnRequestSubscribe;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.CallBack;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.SPUtil;
import com.luck.picture.lib.utils.ToastUtils;
import com.scwang.smartrefresh.layout.SmartRefreshLayout;
import com.scwang.smartrefresh.layout.api.RefreshLayout;
import com.scwang.smartrefresh.layout.listener.OnLoadMoreListener;
import com.scwang.smartrefresh.layout.listener.OnRefreshListener;

import java.util.List;

import org.xutils.common.Callback;

import butterknife.BindView;

/**
 * Created by jiang on 2018/2/3.
 */

public class CareExample extends BaseFragment {
    @BindView(R.id.recycle)
    RecyclerView mRecycle;
    @BindView(R.id.no_data_view)
    ImageView noDataView;
    @BindView(R.id.refreshLayout)
    SmartRefreshLayout refreshLayout;
    private RefreshViewModel mRefreshViewModel;

    CareExampleAdapter mAdapter;

    @Override
    public int setlayoutResID() {
        return R.layout.fragment_recycle_layout_refresh;
    }

    @Override
    public void initView() {
        initList();
    }

    @Override
    protected void initEvents() {

        mAdapter.setCareClikListener(new CallBack.CaseCareClikListener() {
            @Override
            public void CaseCareClik(int postion) {
                LoadDialog.showDialog(getActivity());
                delCare(mAdapter.getDatas().get(postion).getId(), postion);
            }
        });
    }

    @Override
    public void initData() {
        mRefreshViewModel.autoRefresh();
    }

    private void initList() {
        LinearLayoutManager manager = new LinearLayoutManager(getActivity());
        mAdapter = new CareExampleAdapter(getActivity());
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
    //---------------------------跟View相关的请求操作---------------------------------

    /**
     * @param refreshLayout
     * @param p
     * @param isRefreshOrLoadMore true 刷新  false 加载更多
     */
    private void requestData(@NonNull final RefreshLayout refreshLayout, int p, boolean isRefreshOrLoadMore) {
        String page = p + "";
        String row = "15";
        if (isRefreshOrLoadMore) {
            refresh(refreshLayout, page, row);
        } else {
            loadMore(refreshLayout, page, row);
        }
    }

    private void refresh(@NonNull final RefreshLayout refreshLayout, String page, String row) {
        ApiManager.myAttentionList(page, row, 3, new OnRequestSubscribe<BaseBean<AttentionData>>() {
            @Override
            public void onSuccess(BaseBean<AttentionData> data) {
                refreshLayout.finishRefresh();
                List<CaseBean.DataBean> list = data.getData() == null ? null : data.getData().getAnli();
                mAdapter.addFirst(list);
                noDataView.setVisibility(View.GONE);
                if (list == null || list.isEmpty()) {
                    refreshLayout.setEnableLoadMore(false);
                    noDataView.setVisibility(View.VISIBLE);
                }
            }

            @Override
            public void onError(Exception ex) {
                refreshLayout.finishRefresh();
            }
        });
    }

    private void loadMore(@NonNull final RefreshLayout refreshLayout, String page, String row) {
        ApiManager.myAttentionList(page, row, 3, new OnRequestSubscribe<BaseBean<AttentionData>>() {
            @Override
            public void onSuccess(BaseBean<AttentionData> data) {
                refreshLayout.finishLoadMore();
                List<CaseBean.DataBean> list = data.getData() == null ? null : data.getData().getAnli();
                if (list == null || list.isEmpty()) {
                    refreshLayout.setEnableLoadMore(false);
                } else {
                    mAdapter.addMore(list);
                }
            }

            @Override
            public void onError(Exception ex) {
                refreshLayout.finishRefresh();
            }
        });
    }

    //取消关注商家
    private void delCare(final int id, final int postion) {
        LoadDialog.showDialog(getActivity());
        new ApiManager().cancelCarUser("" + id, "" + SPUtil.get("token", SPUtil.Type.STR), "" + SPUtil.get("userid", SPUtil.Type.INT), new Callback.CommonCallback<String>() {
            @Override
            public void onSuccess(String result) {
                ToastUtils.showToast(getActivity(),"取消成功");
                mAdapter.remove(postion);
            }

            @Override
            public void onError(Throwable ex, boolean isOnCallback) {
                ToastUtils.showToast(getActivity(),"取消失败");
            }

            @Override
            public void onCancelled(CancelledException cex) {

            }

            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }
        });
    }
}
