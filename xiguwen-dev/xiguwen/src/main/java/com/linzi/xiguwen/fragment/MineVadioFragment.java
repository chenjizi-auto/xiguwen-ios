package com.linzi.xiguwen.fragment;

import android.content.Intent;
import android.os.Bundle;
import androidx.recyclerview.widget.LinearLayoutManager;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.jcodecraeer.xrecyclerview.ProgressStyle;
import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.MineVadioAdapter;
import com.linzi.xiguwen.base.BaseFragment;
import com.linzi.xiguwen.bean.VideoBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.ui.MineVadioDetailsActivity;
import com.linzi.xiguwen.utils.NToast;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2017/12/11.
 */

public class MineVadioFragment extends BaseFragment {
    @BindView(R.id.recycle_view)
    XRecyclerView recycleView;
    @BindView(R.id.nodata_layout)
    View mNodataLayout;

    private int mStatus = -1;

    private boolean isPrepare = false;
    MineVadioAdapter mAdapter;

    private List<VideoBean> mDatas;
    private int mPage = 1;
    private int mRows = 15;

    public static MineVadioFragment newInstance (int FLAG) {
        Bundle args = new Bundle();
        args.putInt("status", FLAG);
        MineVadioFragment fragment=new MineVadioFragment();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,Bundle savedInstanceState) {
        View view = LayoutInflater.from(getActivity()).inflate(R.layout.fragment_history_layout, null);
        ButterKnife.bind(this, view);
        return view;
    }

    @Override
    public void onActivityCreated(Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);
        initViews();
    }

    private void initViews(){
        Bundle bu = getArguments();
        mStatus = bu.getInt("status");

        LinearLayoutManager manager=new LinearLayoutManager(getActivity());
        recycleView.setRefreshProgressStyle(ProgressStyle.BallTrianglePath);
        recycleView.setLoadingMoreProgressStyle(ProgressStyle.BallScaleRipple);
        recycleView.setLoadingMoreEnabled(true);
        recycleView.setLayoutManager(manager);
        mDatas = new ArrayList<>();
        mAdapter=new MineVadioAdapter(getActivity(), mDatas, mStatus, new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int postion) {
                Intent intent=new Intent(getActivity(),MineVadioDetailsActivity.class);
                intent.putExtra("tag",mStatus);
                startActivity(intent);
            }
        });
        recycleView.setAdapter(mAdapter);
        recycleView.setLoadingListener(new XRecyclerView.LoadingListener() {
            @Override
            public void onRefresh() {
                requestNetData(true);
            }

            @Override
            public void onLoadMore() {
                requestNetData(false);
            }
        });
    }

    /**
     * 请求网络数据
     * @param isRefresh
     */
    private void requestNetData(final boolean isRefresh){
        ApiManager.getVideoList(isRefresh ? 1 : mPage, mRows, mStatus, new OnRequestFinish<BaseBean<List<VideoBean>>>() {
            @Override
            public void onFinished() {
                recycleView.refreshComplete();
                recycleView.loadMoreComplete();
            }

            @Override
            public void onSuccess(BaseBean<List<VideoBean>> data) {
                if (isRefresh) {
                    mDatas.clear();
                    mPage = 1;
                }
                mPage++;
                mDatas.addAll(data.getData());
                mAdapter.notifyDataSetChanged();
                if (data.getData().size() < mRows) {
                    recycleView.setNoMore(true);
                } else {
                    recycleView.setNoMore(false);
                }
                if (mDatas.size() == 0) {
                    mNodataLayout.setVisibility(View.VISIBLE);
                }
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
            }
        });
    }
    @Override
    protected void lazyLoad() {
        if (!isVisible || !isPrepare) {
            return;
        }
    }
}
