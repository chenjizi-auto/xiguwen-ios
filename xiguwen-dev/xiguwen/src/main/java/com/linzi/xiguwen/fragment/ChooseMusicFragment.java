package com.linzi.xiguwen.fragment;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import androidx.annotation.NonNull;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.ChooseMusicAdapter;
import com.linzi.xiguwen.base.BaseFragment;
import com.linzi.xiguwen.bean.InvitationsTemplateTypeBean;
import com.linzi.xiguwen.bean.MusicBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.ui.ChooseMusicActivity;
import com.linzi.xiguwen.utils.MsgLoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;
import com.linzi.xiguwen.view.MyRefreshFooter;
import com.linzi.xiguwen.view.MyRefreshHeader;
import com.scwang.smartrefresh.layout.SmartRefreshLayout;
import com.scwang.smartrefresh.layout.api.RefreshLayout;
import com.scwang.smartrefresh.layout.listener.OnRefreshLoadMoreListener;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

public class ChooseMusicFragment extends BaseFragment {

    @BindView(R.id.refresh_layout)
    SmartRefreshLayout refreshLayout;
    @BindView(R.id.recycle)
    RecyclerView recycleView;
    @BindView(R.id.nodata_layout)
    View mNodataLayout;

    private InvitationsTemplateTypeBean mType;
    private List<MusicBean.DataBean> mDatas;

    private boolean isPrepare = false;
    private ChooseMusicAdapter mAdapter;


    private int mPage = 1;
    private int mRows = 15;

    private int qingjianid;

    public static ChooseMusicFragment newInstance(InvitationsTemplateTypeBean type,int qingjianid) {
        Bundle args = new Bundle();
        args.putSerializable("type", type);
        args.putSerializable("qingjianid", qingjianid);
        ChooseMusicFragment fragment = new ChooseMusicFragment();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View view = LayoutInflater.from(getActivity()).inflate(R.layout.fragment_refresh_list_layout, null);
        ButterKnife.bind(this, view);
        return view;
    }

    @Override
    public void onActivityCreated(Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);
        initViews();
    }

    private void initViews() {
        Bundle bu = getArguments();
        mType = (InvitationsTemplateTypeBean) bu.getSerializable("type");
        qingjianid = (int) bu.getSerializable("qingjianid");
        LinearLayoutManager manager = new LinearLayoutManager(getActivity());
        recycleView.setLayoutManager(manager);

        mDatas = new ArrayList<>();
        mAdapter = new ChooseMusicAdapter(getContext(), new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int postion) {
                ((ChooseMusicActivity) getActivity()).setChooseMusic(mDatas.get(postion));
                setMusic(mDatas.get(postion));
            }
        });
        mAdapter.setList(mDatas);
        recycleView.setAdapter(mAdapter);

        refreshLayout.setEnableRefresh(true);
        refreshLayout.setEnableLoadMore(true);
        refreshLayout.setRefreshHeader(new MyRefreshHeader(getContext()));
        refreshLayout.setRefreshFooter(new MyRefreshFooter(getContext()));
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

    /**
     * 请求网络数据
     *
     * @param isRefresh
     */
    private void requestNetData(final boolean isRefresh) {
        ApiManager.getMusicList(mType.getId(), isRefresh ? 1 : mPage, mRows, new OnRequestFinish<BaseBean<MusicBean>>() {
            @Override
            public void onFinished() {
                refreshLayout.finishRefresh(0);
                refreshLayout.finishLoadMore(0);
            }

            @Override
            public void onSuccess(BaseBean<MusicBean> data) {
                if (isRefresh) {
                    mDatas.clear();
                    mPage = 1;
                }
                mPage++;
                if (data.getData() != null && data.getData() != null) {
                    mDatas.addAll(data.getData().getData());
                    if (data.getData().getData().size() < mRows) {
                        refreshLayout.setNoMoreData(true);
                    } else {
                        refreshLayout.setNoMoreData(false);
                    }
                }
                if (mDatas.size() == 0) {
                    mNodataLayout.setVisibility(View.VISIBLE);
                } else {
                    mNodataLayout.setVisibility(View.GONE);
                }
                mAdapter.notifyDataSetChanged();
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
    protected void lazyLoad() {
        if (!isVisible || !isPrepare) {
            return;
        }
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (resultCode == Activity.RESULT_OK) {
            refreshLayout.autoRefresh();
        }
    }


    public void notifyDataSetChange() {
        if (mAdapter != null) {
            mAdapter.notifyDataSetChanged();
        }
    }


    private void setMusic(MusicBean.DataBean music) {
        MsgLoadDialog.showDialog(getActivity(), "设置中...");
        ApiManager.setTemplateMusic(qingjianid, music.getId(), new OnRequestFinish<BaseBean<String>>() {
            @Override
            public void onFinished() {
                MsgLoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<String> data) {
                NToast.show("设置成功");
                Event event = new Event(EventCode.YULAN);
                EventBusUtil.sendEvent(event);
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
            }
        });
    }

}
