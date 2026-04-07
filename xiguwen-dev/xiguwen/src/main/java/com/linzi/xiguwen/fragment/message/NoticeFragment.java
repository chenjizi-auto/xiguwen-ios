package com.linzi.xiguwen.fragment.message;


import android.os.Bundle;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.MessageNoticeAdapter;
import com.linzi.xiguwen.bean.MessageNoticeBean;
import com.linzi.xiguwen.fragment.discover.DiscoverDetailActivity;
import com.linzi.xiguwen.fragment.vm.RefreshViewModel;
import com.linzi.xiguwen.net.OnRequestSubscribe;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.AppUtil;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;
import com.linzi.xiguwen.utils.yixin.preference.Preferences;
import com.scwang.smartrefresh.layout.SmartRefreshLayout;
import com.scwang.smartrefresh.layout.api.RefreshLayout;
import com.scwang.smartrefresh.layout.listener.OnLoadMoreListener;
import com.scwang.smartrefresh.layout.listener.OnRefreshListener;

import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by PC on 2018-04-05.
 */

public class NoticeFragment extends Fragment implements com.jcodecraeer.xrecyclerview.OnItemClickListener1 {
    @BindView(R.id.hot_recycle)
    RecyclerView mRecycle;
    @BindView(R.id.refreshLayout)
    SmartRefreshLayout refreshLayout;

    private MessageNoticeAdapter mAdapter;
    private RefreshViewModel mRefreshViewModel;

    public static NoticeFragment newInstance() {
        NoticeFragment fragment = new NoticeFragment();
        return fragment;
    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_message_notice, container, false);
        ButterKnife.bind(this, view);
        EventBusUtil.register(this);
        initView();
        mRefreshViewModel.autoRefresh();
        return view;
    }

    private void initView() {
        LinearLayoutManager manager = new LinearLayoutManager(getActivity());
        mAdapter = new MessageNoticeAdapter(getActivity(), this);
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
        ApiManager.messageNotice(page, row, new OnRequestSubscribe<BaseBean<MessageNoticeBean>>() {
            @Override
            public void onSuccess(BaseBean<MessageNoticeBean> data) {
                refreshLayout.finishRefresh();
                mAdapter.addFirst(data.getData().getCont());
//                mAdapter.addFirst(getData(data.getData().getCont()));
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
        ApiManager.messageNotice(page, row, new OnRequestSubscribe<BaseBean<MessageNoticeBean>>() {
            @Override
            public void onSuccess(BaseBean<MessageNoticeBean> data) {
                refreshLayout.finishLoadMore();
                if (data.getData() == null || data.getData().getCont() == null || data.getData().getCont().size() == 0) {
                    refreshLayout.setEnableLoadMore(false);
                } else {
                    mAdapter.addMore(data.getData().getCont());
//                    mAdapter.addMore(getData(data.getData().getCont()));
                }
            }

            @Override
            public void onError(Exception ex) {
                refreshLayout.finishLoadMore();
            }
        });
    }

    @Override
    public void onItemClick(View view, int postion, Object data) {
        MessageNoticeBean.MessageNoticeEntity entity = (MessageNoticeBean.MessageNoticeEntity) data;
        DiscoverDetailActivity.startAction(getActivity(), entity.getSid(), postion);
    }

    @Subscribe(threadMode = ThreadMode.MAIN)
    public void receiveEvent(Event entity) {
        if (entity == null)
            return;
        int code = entity.getCode();
        if (code == EventCode.LOGIN_SUCCESS) {
            mRefreshViewModel.autoRefresh();
        }
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
        EventBusUtil.unregister(this);
         
    }

    private List<MessageNoticeBean.MessageNoticeEntity> getData(List<MessageNoticeBean.MessageNoticeEntity> entityList) {
        List<String> tradeIds = Preferences.getPushTradeIds();
        if (AppUtil.isEmpty(tradeIds) || AppUtil.isEmpty(entityList)) {
            return entityList;
        }

        for (MessageNoticeBean.MessageNoticeEntity entity : entityList) {
            if (tradeIds.contains(entity.getId() + "")) {
                entity.setReadType(1);
            }
        }
        return entityList;
    }
}
