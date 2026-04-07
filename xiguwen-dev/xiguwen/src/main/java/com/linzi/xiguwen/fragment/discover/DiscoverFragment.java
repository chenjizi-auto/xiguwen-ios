package com.linzi.xiguwen.fragment.discover;


import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.os.Bundle;
import android.os.SystemClock;
import androidx.annotation.NonNull;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.WindowManager;
import android.widget.LinearLayout;
import android.widget.PopupWindow;
import android.widget.RadioButton;
import android.widget.TextView;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.discover.DisCoverAdapter;
import com.linzi.xiguwen.adapter.discover.JobSerachAdapter;
import com.linzi.xiguwen.bean.ClassificationBean;
import com.linzi.xiguwen.bean.WeddingRingBean;
import com.linzi.xiguwen.fragment.vm.RefreshViewModel;
import com.linzi.xiguwen.net.OnRequestSubscribe;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.network.Constans;
import com.linzi.xiguwen.utils.CallBack;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;
import com.linzi.xiguwen.widget.NestRadioGroup;
import com.luck.picture.lib.utils.ToastUtils;
import com.scwang.smartrefresh.layout.SmartRefreshLayout;
import com.scwang.smartrefresh.layout.api.RefreshLayout;
import com.scwang.smartrefresh.layout.listener.OnLoadMoreListener;
import com.scwang.smartrefresh.layout.listener.OnRefreshListener;

import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.OnClick;

/**
 * Created by devin on 2018/4/11 10:52
 * Description  发现子列表页
 */

public class DiscoverFragment extends BaseFragment implements JobSerachAdapter.JobSearchListener, com.jcodecraeer.xrecyclerview.OnItemClickListener {

    @BindView(R.id.discover_condition)
    TextView txCondition;
    @BindView(R.id.discover_condition_item)
    LinearLayout itemCondition;
    @BindView(R.id.discover_type_new)
    RadioButton radioTypeNew;
    @BindView(R.id.discover_type_hot)
    RadioButton radioTypeHot;
    @BindView(R.id.discover_type_attention)
    RadioButton radioTypeAttention;
    @BindView(R.id.discover_radiogroup)
    NestRadioGroup radiogroup;
    @BindView(R.id.recycle)
    RecyclerView mRecycle;
    @BindView(R.id.refreshLayout)
    SmartRefreshLayout refreshLayout;
    private RefreshViewModel mRefreshViewModel;

    private int flag;

    //    private FindChildAdapter mAdapter;
    private DisCoverAdapter mAdapter;
    private RecyclerView poprecyclerView;
    private PopupWindow popupWindow;
    private List<ClassificationBean> jobBean;
    private JobSerachAdapter jobSerachAdapter;


    private String follow;//关注
    private String hot;//热门
    private String newest = "desc";//最新
    private int jobType;//职业 0代表全部
    private int selectType;

    private String api = "";
    private long lastAutoRefreshAt = 0L;
    private boolean isRefreshing = false;

    //FLAG 区分是婚庆还是商城
    public static DiscoverFragment newInstance(int FLAG) {
        Bundle args = new Bundle();
        args.putInt("type", FLAG);
        DiscoverFragment fragment = new DiscoverFragment();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public int setlayoutResID() {
        return R.layout.fragment_discover_list;
    }

    @Override
    public void initView() {
        EventBusUtil.register(this);
        flag = getArguments().getInt("type", flag);
        if (flag == 0) {
            itemCondition.setVisibility(View.VISIBLE);
            api = Constans.Action.HUNQINGQUAN;
        } else {
            itemCondition.setVisibility(View.GONE);
            api = Constans.Action.SHOPQUAN;

        }
        init();
    }

    @Override
    protected void initEvents() {

        radiogroup.setOnCheckedChangeListener(new NestRadioGroup.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(NestRadioGroup group, int checkedId) {

                if (checkedId == radioTypeNew.getId()) {
                    newest = "desc";
                    hot = null;
                    follow = null;
                    jobType = selectType;
                    triggerAutoRefresh();
                } else if (checkedId == radioTypeHot.getId()) {
                    newest = null;
                    hot = "desc";
                    follow = null;
                    jobType = selectType;
                    triggerAutoRefresh();

                } else if (checkedId == radioTypeAttention.getId()) {
                    newest = null;
                    hot = null;
                    follow = "1";
                    jobType = 0;
                    triggerAutoRefresh();
                }

            }
        });
        mAdapter.setCareClikListener(new CallBack.CaseCareClikListener() {
            @Override
            public void CaseCareClik(int postion) {
                try {
                    LoadDialog.showDialog(getActivity());
                    WeddingRingBean bean = mAdapter.getDatas().get(postion);
                    if (bean.getFollow() == 1) {
                        attentionCancel(bean.getUserid(), postion);
                    } else {
                        attention(bean.getUserid(), postion);
                    }
                } catch (Exception e) {
                    LoadDialog.showDialog(getActivity());
                    ToastUtils.showToast(getActivity(), "操作失败");
                }

            }
        });

    }

    @Override
    public void initData() {

        if (flag == 0) {
            initPop();
            getClassification();
        }
        triggerAutoRefresh();
    }


    private void init() {
        LinearLayoutManager manager = new LinearLayoutManager(getActivity());
        mAdapter = new DisCoverAdapter(getActivity(), flag, this);
        mRecycle.setLayoutManager(manager);
        mRecycle.setAdapter(mAdapter);
        mRefreshViewModel = RefreshViewModel.initRefresh(refreshLayout).addOnRefreshListener(new OnRefreshListener() {
            @Override
            public void onRefresh(@NonNull final RefreshLayout refreshLayout) {
                isRefreshing = true;
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
        ApiManager.getDiscover(api, follow, hot, newest, page, row, jobType + "", new OnRequestSubscribe<BaseBean<ArrayList<WeddingRingBean>>>() {
            @Override
            public void onSuccess(BaseBean<ArrayList<WeddingRingBean>> data) {
                refreshLayout.finishRefresh();
                isRefreshing = false;
                mAdapter.addFirst(data.getData());
                mRecycle.scrollToPosition(0);
                if (data.getData().size() == 0) {
                    refreshLayout.setEnableLoadMore(false);
                }
            }

            @Override
            public void onError(Exception ex) {
                refreshLayout.finishRefresh();
                isRefreshing = false;
            }
        });
    }

    private void loadMore(@NonNull final RefreshLayout refreshLayout, String page, String row) {

        ApiManager.getDiscover(api, follow, hot, newest, page, row, jobType + "", new OnRequestSubscribe<BaseBean<ArrayList<WeddingRingBean>>>() {
            @Override
            public void onSuccess(BaseBean<ArrayList<WeddingRingBean>> data) {
                refreshLayout.finishLoadMore();
                if (data.getData() == null || data.getData() == null || data.getData().size() == 0) {
                    refreshLayout.setEnableLoadMore(false);
                } else {
                    mAdapter.addMore(data.getData());
                }
            }

            @Override
            public void onError(Exception ex) {
                refreshLayout.finishRefresh();
            }
        });

    }


    private void attention(int id, final int position) {

        ApiManager.discoverAttention(id + "", new OnRequestSubscribe<BaseBean>() {
            @Override
            public void onSuccess(BaseBean data) {
                LoadDialog.CancelDialog();
                try {
                    mAdapter.getDatas().get(position).setFollow(1);
                    mAdapter.notifyDataSetChanged();
                } catch (Exception e) {

                }
            }

            @Override
            public void onError(Exception ex) {
                LoadDialog.CancelDialog();
                ToastUtils.showToast(getActivity(), ex.getMessage());
            }
        });
    }

    private void attentionCancel(int id, final int position) {
        ApiManager.discoverAttentionCancel(id + "", new OnRequestSubscribe<BaseBean>() {
            @Override
            public void onSuccess(BaseBean data) {
                LoadDialog.CancelDialog();
                try {
                    mAdapter.getDatas().get(position).setFollow(0);
                    mAdapter.notifyDataSetChanged();
                } catch (Exception e) {

                }

            }

            @Override
            public void onError(Exception ex) {
                ToastUtils.showToast(getActivity(), ex.getMessage());
                LoadDialog.CancelDialog();
            }
        });
    }

    private void showPop() {
        //是否展开pop
        if (popupWindow == null) {
            return;
        }
        if (popupWindow.isShowing()) {
            popupWindow.dismiss();
        } else {
            popupWindow.showAsDropDown(itemCondition);
        }
    }

    private void initPop() {
        View view = LayoutInflater.from(getActivity()).inflate(R.layout.find_pop_layout, null);
        poprecyclerView = (RecyclerView) view.findViewById(R.id.recycleview);
        LinearLayoutManager manager = new LinearLayoutManager(getActivity());
        poprecyclerView.setLayoutManager(manager);
        popupWindow = new PopupWindow(view, 300, WindowManager.LayoutParams.WRAP_CONTENT, true);
        popupWindow.setBackgroundDrawable(new ColorDrawable(Color.TRANSPARENT));
        popupWindow.setOutsideTouchable(true);
        // 设置PopupWindow是否能响应点击事件
        popupWindow.setTouchable(true);
    }

    //初始化职业列表
    private void getClassification() {
        ApiManager.getClassification(new OnRequestSubscribe<BaseBean<ArrayList<ClassificationBean>>>() {
            @Override
            public void onSuccess(BaseBean<ArrayList<ClassificationBean>> data) {
                jobBean = data.getData();
                ClassificationBean allBean = new ClassificationBean();
                allBean.setOccupationid(0);
                allBean.setProname("全部");
                jobBean.add(0, allBean);
                if (jobSerachAdapter == null) {
                    jobSerachAdapter = new JobSerachAdapter(getActivity());
                    poprecyclerView.setAdapter(jobSerachAdapter);
                    jobSerachAdapter.setListener(DiscoverFragment.this);
                }
                jobSerachAdapter.setData(jobBean);
            }

            @Override
            public void onError(Exception ex) {
                NToast.log(getActivity(), ex.toString());
            }
        });
    }

    @OnClick({R.id.discover_condition, R.id.discover_condition_item})
    public void onViewClicked(View view) {
        switch (view.getId()) {
            case R.id.discover_condition:
            case R.id.discover_condition_item:
                showPop();
//                Intent intent = new Intent(getActivity(), ActivitiesDetailsActivity.class);
//                startActivity(intent);
                break;
        }
    }

    @Override
    public void jobSecector(ClassificationBean bean) {
        txCondition.setText(bean.getProname());
        selectType = bean.getOccupationid();
        popupWindow.dismiss();
        jobType = selectType;
        radioTypeNew.setChecked(true);
        newest = "desc";
        hot = null;
        follow = null;
        triggerAutoRefresh();

    }

    @Override
    public void onItemClick(View view, int postion) {
//        Intent intent = new Intent(getActivity(), NewClubDetailsPersonActivity.class);

//        Intent intent = new Intent(getActivity(), DiscoverDetailActivity.class);
//        intent.putExtra("id",mAdapter.getItem(postion).getId());
//        startActivity(intent);

        DiscoverDetailActivity.startAction(getActivity(), flag, mAdapter.getItem(postion).getId(), postion);

    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
        EventBusUtil.unregister(this);
    }

    @Subscribe(threadMode = ThreadMode.MAIN)
    public void receiveEvent(Event entity) {
        if (entity == null)
            return;
        try {
            int code = entity.getCode();
            switch (code) {
                case EventCode.LOGIN_SUCCESS:
                    if (isRefreshing) {
                        return;
                    }
                    if (SystemClock.elapsedRealtime() - lastAutoRefreshAt < 1500) {
                        return;
                    }
                    triggerAutoRefresh();
                    break;
            }
        } catch (Exception e) {
        }
    }

    private void triggerAutoRefresh() {
        if (isRefreshing) {
            return;
        }
        lastAutoRefreshAt = SystemClock.elapsedRealtime();
        mRefreshViewModel.autoRefresh();
    }
}
