package com.linzi.xiguwen.ui;

import android.os.Bundle;
import androidx.annotation.NonNull;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.View;
import android.widget.EditText;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.AddTeamAdapter;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.communityAddEntity;
import com.linzi.xiguwen.fragment.vm.RefreshViewModel;
import com.linzi.xiguwen.net.OnRequestSubscribe;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.network.Constans;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.scwang.smartrefresh.layout.SmartRefreshLayout;
import com.scwang.smartrefresh.layout.api.RefreshLayout;
import com.scwang.smartrefresh.layout.listener.OnLoadMoreListener;
import com.scwang.smartrefresh.layout.listener.OnRefreshListener;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

public class AddTeamActivity extends BaseActivity {

    @BindView(R.id.ed_name)
    EditText edName;
    @BindView(R.id.recycle)
    RecyclerView mRecycle;
    @BindView(R.id.refreshLayout)
    SmartRefreshLayout refreshLayout;

    AddTeamAdapter mAdpater;
    private RefreshViewModel mRefreshViewModel;
    private String name;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_add_team);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        setTitle("加入社团");
        setBack();

        initView();
        mRefreshViewModel.autoRefresh();
    }

    private void initView() {
        final LinearLayoutManager manager = new LinearLayoutManager(mContext);
        mRecycle.setLayoutManager(manager);
        mAdpater = new AddTeamAdapter(mContext);
        mAdpater.setItemClickListener(new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int postion) {
//                Intent intent = new Intent(mContext, TeamCenterActivity.class);
//                startActivity(intent);
                communityAddEntity entity = mAdpater.getmBens().get(postion);
                if (entity.getStatus() == 0) {
                    httpAdd(entity.getId(), postion);
                } else {
//                    Intent intent = new Intent(mContext, TeamCenterActivity.class);
//                    startActivity(intent);
                }

            }
        });
        mRecycle.setAdapter(mAdpater);
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


        edName.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {

            }

            @Override
            public void afterTextChanged(Editable s) {
                name = edName.getText().toString();
                mRefreshViewModel.resetPage();
                refreshLayout.setEnableLoadMore(true);
                requestData(refreshLayout, mRefreshViewModel.getPage(), true);
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
        ApiManager.communityAddList(name, page, row, new OnRequestSubscribe<BaseBean<List<communityAddEntity>>>() {
            @Override
            public void onSuccess(BaseBean<List<communityAddEntity>> data) {
                refreshLayout.finishRefresh();
                mAdpater.addFirst(data.getData());
                if (data.getData().size() == 0) {
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
        ApiManager.communityAddList(name, page, row, new OnRequestSubscribe<BaseBean<List<communityAddEntity>>>() {
            @Override
            public void onSuccess(BaseBean<List<communityAddEntity>> data) {
                refreshLayout.finishLoadMore();
                if ( data.getData() == null || data.getData().size() == 0) {
                    refreshLayout.setEnableLoadMore(false);
                } else {
                    mAdpater.addMore(data.getData());
                }
            }

            @Override
            public void onError(Exception ex) {
                refreshLayout.finishLoadMore();
            }
        });
    }

    private void httpAdd(String id, final int position) {
        LoadDialog.showDialog(this);
        ApiManager.communityAddApplyDeal(id, Constans.Action.COMMUNITY_ADD_APPLY, new OnRequestSubscribe<BaseBean>() {
            @Override
            public void onSuccess(BaseBean data) {
                LoadDialog.CancelDialog();
                NToast.show(data.getMessage());
                mAdpater.getmBens().get(position).setStatus(4);
                mAdpater.notifyDataSetChanged();
            }

            @Override
            public void onError(Exception ex) {
                LoadDialog.CancelDialog();
                NToast.show(ex.getMessage());
            }
        });
    }

}
