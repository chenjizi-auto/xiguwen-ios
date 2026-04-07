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
import com.linzi.xiguwen.adapter.MineBaojiaAdapter;
import com.linzi.xiguwen.base.BaseFragment;
import com.linzi.xiguwen.bean.BaoJiaBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.ui.BaojiaDetails2Activity;
import com.linzi.xiguwen.utils.NToast;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2017/12/11.
 */

public class MineBaojiaFragment extends BaseFragment implements XRecyclerView.LoadingListener {
    @BindView(R.id.recycle_view)
    XRecyclerView recycleView;
    @BindView(R.id.nodata_layout)
    View mNoDataLayout;

    private int flag=-1;

    private boolean isPrepare = false;

    MineBaojiaAdapter mAdapter;

    private List<BaoJiaBean> mDatas;
    private int mPage = 1;
    private int mRows = 15;

    public static MineBaojiaFragment newInstance (int FLAG) {
        Bundle args = new Bundle();
        args.putInt("type", FLAG);
        MineBaojiaFragment fragment=new MineBaojiaFragment();
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
        flag = bu.getInt("type");

        LinearLayoutManager manager=new LinearLayoutManager(getActivity());
        recycleView.setRefreshProgressStyle(ProgressStyle.BallTrianglePath);
        recycleView.setLoadingMoreProgressStyle(ProgressStyle.BallScaleRipple);
        recycleView.setLoadingMoreEnabled(true);
        recycleView.setLayoutManager(manager);
        mDatas = new ArrayList<>();
        mAdapter=new MineBaojiaAdapter(getActivity(), mDatas, new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int postion) {
                BaoJiaBean baoJiaBean = mDatas.get(postion);
                Intent intent=new Intent(getActivity(),BaojiaDetails2Activity.class);
//                intent.putExtra("tag",flag);
                intent.putExtra("data", baoJiaBean);
                startActivity(intent);
            }
        });
        recycleView.setAdapter(mAdapter);
        recycleView.setLoadingListener(this);
        loadData(true);
    }

    /**
     * 加载网络数据，
     * @param refresh
     */
    private void loadData(final boolean refresh){
        ApiManager.getMyBaoJia(refresh ? 1 : mPage, mRows, flag, new OnRequestFinish<BaseBean<ArrayList<BaoJiaBean>>>() {
            @Override
            public void onFinished() {
                recycleView.refreshComplete();
                recycleView.loadMoreComplete();
            }

            @Override
            public void onSuccess(BaseBean<ArrayList<BaoJiaBean>> data) {
                ArrayList<BaoJiaBean> baoJiaBeans = data.getData();
                if(refresh){
                    mDatas.clear();
                }
                mDatas.addAll(baoJiaBeans);
                mAdapter.notifyDataSetChanged();
                if(refresh){
                    mPage = 1;
                }
                mPage ++ ;
                if(data.getData().size() < mRows){
                    recycleView.setNoMore(true);
                }else{
                    recycleView.setNoMore(false);
                }
                if(mDatas.size() == 0){
                    mNoDataLayout.setVisibility(View.VISIBLE);
                }
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
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
    public void onRefresh() {
        loadData(true);
    }

    @Override
    public void onLoadMore() {
        loadData(false);
    }
}
