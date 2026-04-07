package com.linzi.xiguwen.fragment;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import androidx.recyclerview.widget.LinearLayoutManager;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.jcodecraeer.xrecyclerview.ProgressStyle;
import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.MineListAdapter;
import com.linzi.xiguwen.base.BaseFragment;
import com.linzi.xiguwen.bean.BaseStatusBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.ui.BaojiaDetails2Activity;
import com.linzi.xiguwen.ui.CommodityDetailsActivity;
import com.linzi.xiguwen.ui.MineExampleDetailsActivity;
import com.linzi.xiguwen.ui.MineListActivity;
import com.linzi.xiguwen.ui.MineVadioDetailsActivity;
import com.linzi.xiguwen.ui.TuCeDetailsActivity;
import com.linzi.xiguwen.utils.NToast;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2017/12/11.
 */

public class MineListFragment extends BaseFragment {


    @BindView(R.id.recycle_view)
    XRecyclerView recycleView;
    @BindView(R.id.nodata_layout)
    View mNodataLayout;

    private int mStatus = -1;
    private int mPageType = -1;

    private boolean isPrepare = false;
    MineListAdapter mAdapter;

    private List<BaseStatusBean> mDatas;
    private int mPage = 1;
    private int mRows = 15;

    public static MineListFragment newInstance (int page_type, int status) {
        Bundle args = new Bundle();
        args.putInt("status", status);
        args.putInt("page_type", page_type);
        MineListFragment fragment=new MineListFragment();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,Bundle savedInstanceState) {
        View view = LayoutInflater.from(getActivity()).inflate(R.layout.fragment_mine_list_layout, null);
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
        mPageType = bu.getInt("page_type");

        LinearLayoutManager manager=new LinearLayoutManager(getActivity());
        recycleView.setRefreshProgressStyle(ProgressStyle.BallTrianglePath);
        recycleView.setLoadingMoreProgressStyle(ProgressStyle.BallScaleRipple);
        recycleView.setLoadingMoreEnabled(true);
        recycleView.setLayoutManager(manager);
        mDatas = new ArrayList<>();
        mAdapter=new MineListAdapter(getActivity(), mDatas, new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int postion) {
                Intent intent;
                BaseStatusBean data = mDatas.get(postion - 1);
                switch (mPageType){
                    case MineListActivity.TYPE_ANLI:
                        intent=new Intent(getActivity(),MineExampleDetailsActivity.class);
                        intent.putExtra("data", data);
                        startActivityForResult(intent, 100);
                        break;
                    case MineListActivity.TYPE_BAOJIA:
                        intent=new Intent(getActivity(),BaojiaDetails2Activity.class);
                        intent.putExtra("data", data);
                        startActivityForResult(intent, 100);
                        break;
                    case MineListActivity.TYPE_SHIPING:
                        intent=new Intent(getActivity(),MineVadioDetailsActivity.class);
                        intent.putExtra("data", data);
                        startActivityForResult(intent, 100);
                        break;
                    case MineListActivity.TYPE_TUCE:
                        intent=new Intent(getActivity(),TuCeDetailsActivity.class);
                        intent.putExtra("data",data);
                        startActivityForResult(intent, 100);
                        break;
                    case MineListActivity.TYPE_COMMODITY:
                        intent=new Intent(getActivity(),CommodityDetailsActivity.class);
                        intent.putExtra("data",data);
                        startActivityForResult(intent, 100);
                        break;
                }
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

//        recycleView.refresh();
    }

    @Override
    public void onResume() {
        super.onResume();
        if(((MineListActivity)getActivity()).shouldRefresh(mStatus)){
            recycleView.refresh();
        }
    }

    /**
     * 请求网络数据
     * @param isRefresh
     */
    private void requestNetData(final boolean isRefresh){
        ApiManager.getMyList(mPageType, isRefresh ? 1 : mPage, mRows, mStatus, new OnRequestFinish<BaseBean<List<BaseStatusBean>>>() {
            @Override
            public void onFinished() {
                recycleView.refreshComplete();
                recycleView.loadMoreComplete();
                ((MineListActivity)getActivity()).setRefreshFinish(mStatus);
            }

            @Override
            public void onSuccess(BaseBean<List<BaseStatusBean>> data) {
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
    protected void lazyLoad() {
        if (!isVisible || !isPrepare) {
            return;
        }
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if(resultCode == Activity.RESULT_OK){
            recycleView.refresh();
        }
    }
}
