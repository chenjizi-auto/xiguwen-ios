package com.linzi.xiguwen.fragment;

import android.os.Bundle;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.FragmentActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.HistoryAdapter;
import com.linzi.xiguwen.base.BaseLazyFragment;
import com.linzi.xiguwen.bean.WhthinBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.ui.HistoryActivity;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;
import com.linzi.xiguwen.utils.yixin.preference.Preferences;
import com.linzi.xiguwen.view.MyRefreshFooter;
import com.linzi.xiguwen.view.MyRefreshHeader;
import com.scwang.smartrefresh.layout.SmartRefreshLayout;
import com.scwang.smartrefresh.layout.api.RefreshLayout;
import com.scwang.smartrefresh.layout.listener.OnLoadMoreListener;
import com.scwang.smartrefresh.layout.listener.OnRefreshListener;

import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2017/12/11.
 */

public class HistoryFragment extends BaseLazyFragment {
    @BindView(R.id.recycle_view)
    RecyclerView recycleView;
    @BindView(R.id.no_data_view)
    ImageView noDataView;
    @BindView(R.id.refreshLayout)
    SmartRefreshLayout refreshLayout;

    private int flag = -1;

    private int page = 1;
    private int limit = 20;
    private int timeslot = 2;//时间段，1上午2中午3下午4晚上5全天
    private String date = null;//时间
    private int occupationid;//职业ID

    HistoryAdapter mAdapter;

    private List<WhthinBean> mlist;

    //传递数据源
    public static HistoryFragment newInstance(int FLAG, int occupationid) {
        Bundle args = new Bundle();
        args.putInt("type", FLAG);
        args.putInt("occupationid", occupationid);
        HistoryFragment fragment = new HistoryFragment();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View view = LayoutInflater.from(getActivity()).inflate(R.layout.fragment_history_layout, null);
        ButterKnife.bind(this, view);
        return view;
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        initViews();
        EventBusUtil.register(this);
        initListener();
        refreshLayout.autoRefresh();
    }

    public int getOccupationid() {
        return occupationid;
    }

    private void initViews() {
        mlist = new ArrayList<>();
        Bundle bu = getArguments();
        flag = bu.getInt("type");
        occupationid = bu.getInt("occupationid");
        LinearLayoutManager manager = new LinearLayoutManager(getActivity());
        recycleView.setLayoutManager(manager);
        mAdapter = new HistoryAdapter(getActivity(), new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int postion) {

            }
        }, flag);
        recycleView.setAdapter(mAdapter);

        refreshLayout.setRefreshHeader(new MyRefreshHeader(getActivity()));
        refreshLayout.setRefreshFooter(new MyRefreshFooter(getActivity()));
    }

    private void initListener() {
        refreshLayout.setOnRefreshListener(new OnRefreshListener() {
            @Override
            public void onRefresh(@NonNull RefreshLayout refreshLayout) {
                getData(false);
                refreshLayout.finishRefresh();
                refreshLayout.setNoMoreData(false);
            }
        });
        refreshLayout.setOnLoadMoreListener(new OnLoadMoreListener() {
            @Override
            public void onLoadMore(@NonNull RefreshLayout refreshLayout) {
                getData(true);
            }
        });
    }


    @Override
    public void onLazyLoad() {
        //getData(false);
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
         
    }

    public void refreshData(String date, int timeslot) {
        this.date = date;
        this.timeslot = timeslot;
        page = 1;
        LoadDialog.showDialog(getActivity());
        ApiManager.getWhthin(date, Preferences.getCity().getId(), occupationid + "", page + "", limit + "", timeslot + "", new OnRequestFinish<BaseBean<ArrayList<WhthinBean>>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<ArrayList<WhthinBean>> data) {
                if (data.getData() != null && data.getData().size() > 0) {
                    mlist = data.getData();
                    noDataView.setVisibility(View.GONE);
                    mAdapter.setData(mlist);
                } else {
                    noDataView.setVisibility(View.VISIBLE);
                }

            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }



    private void getData(final boolean ismore) {
        com.linzi.xiguwen.utils.LogUtil.e("--","getDatagetdata"+ismore);
        FragmentActivity activity = getActivity();
        if (activity instanceof HistoryActivity){
             date = ((HistoryActivity) getActivity()).getDate();
             timeslot = ((HistoryActivity) getActivity()).getTimeslot();
        }
        if (ismore) {
            page++;
        } else {
            page = 1;
        }
        ApiManager.getWhthin(date, Preferences.getCity().getId(), occupationid + "", page + "", limit + "", timeslot + "", new OnRequestFinish<BaseBean<ArrayList<WhthinBean>>>() {
            @Override
            public void onFinished() {
                if (ismore)
                    refreshLayout.finishLoadMore();
            }

            @Override
            public void onSuccess(BaseBean<ArrayList<WhthinBean>> data) {
                if (data.getData() != null && data.getData().size() > 0) {
                    if (ismore) {
                        mlist.addAll(data.getData());
                    } else {
                        mlist = data.getData();
                        noDataView.setVisibility(View.GONE);
                    }
                    mAdapter.setData(mlist);
                } else {
                    if (!ismore)
                        noDataView.setVisibility(View.VISIBLE);
                    else
                        page--;
                }

            }

            @Override
            public void onError(Exception ex) {
                if (ismore)
                    page--;
            }
        });
    }



    @Subscribe(threadMode = ThreadMode.MAIN)
    public void receiveEvent(Event entity) {
        if (entity == null)
            return;
        try {
            int code = entity.getCode();
            switch (code) {
                case EventCode.REFRESH_HISTORY:
                       getData(false);
                    break;
            }
        } catch (Exception e) {
        }

    }
}