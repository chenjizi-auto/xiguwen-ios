package com.linzi.xiguwen.fragment;

import android.content.Intent;
import android.os.Bundle;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.RelativeLayout;

import com.alibaba.fastjson.JSONObject;
import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.ExampleFragmentAdapter;
import com.linzi.xiguwen.bean.BaseBean;
import com.linzi.xiguwen.bean.CaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.ui.CaseByTYpeActivty;
import com.linzi.xiguwen.ui.NewExampleDetailsActivity;
import com.linzi.xiguwen.ui.NewMallDetailsActivity;
import com.linzi.xiguwen.utils.CallBack;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.SPUtil;
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
import org.xutils.common.Callback;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

/**
 * Created by jiang on 2017/12/19.
 * 案例Fragment
 */

public class ExampleFragment extends Fragment implements Callback.CommonCallback<String> {
    @BindView(R.id.rl_today_top)
    RelativeLayout rlTodayTop;
    @BindView(R.id.rl_week_peo)
    RelativeLayout rlWeekPeo;
    @BindView(R.id.rl_month_peo)
    RelativeLayout rlMonthPeo;
    @BindView(R.id.rl_week_hot)
    RelativeLayout rlWeekHot;
    @BindView(R.id.rl_month_hot)
    RelativeLayout rlMonthHot;
    @BindView(R.id.recycle)
    RecyclerView recycleView;


    ExampleFragmentAdapter mAdapter;
    @BindView(R.id.refreshLayout)
    SmartRefreshLayout refreshLayout;
    @BindView(R.id.no_data_view)
    ImageView noDataView;

    private int page = 1;
    private int limit = 10;
    private int type = 1;//1今日推荐2本周人气3本月人气4本周热门5本月热门
    private int cityid;
    private List<CaseBean.DataBean> caseBean;
    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = LayoutInflater.from(getActivity()).inflate(R.layout.fragment_example_layout, null);
        ButterKnife.bind(this, view);
        initVIews();
        initlistener();
        getData();
        return view;
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        EventBusUtil.register(this);
    }

    //初始化案例数据源
    private void getData() {
        LoadDialog.showDialog(getActivity());
        cityid = Preferences.getCity().getId();
        new ApiManager().getCase(cityid, page + "", limit + "", (String) SPUtil.get("token", SPUtil.Type.STR), type + "", (int) SPUtil.get("userid", SPUtil.Type.INT) + "", this);
    }

    //加载更多
    private void getMoreData() {
        CommonCallback call = new CommonCallback<String>() {
            @Override
            public void onSuccess(String result) {
                if (JSONObject.parseObject(result, CaseBean.class).getData().size() == 0) {
                    page--;
                    NToast.show("没有更多数据了！");
                    refreshLayout.finishLoadMoreWithNoMoreData();//将不会再次触发加载更多事件
                } else {
                    mAdapter.addData(JSONObject.parseObject(result, CaseBean.class).getData());
                    caseBean = mAdapter.getData();
                }
            }

            @Override
            public void onError(Throwable ex, boolean isOnCallback) {
                page--;
            }

            @Override
            public void onCancelled(CancelledException cex) {

            }

            @Override
            public void onFinished() {
                refreshLayout.finishLoadMore();
            }
        };

        new ApiManager().getCase(cityid, page + "", limit + "", (String) SPUtil.get("token", SPUtil.Type.STR), type + "", (int) SPUtil.get("userid", SPUtil.Type.INT) + "", call);

    }

    private void initVIews() {
        recycleView.setLayoutManager(new LinearLayoutManager(getActivity()));
        mAdapter = new ExampleFragmentAdapter(getActivity(), new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int postion) {
                Intent intent = new Intent(getActivity(), NewExampleDetailsActivity.class);
                intent.putExtra("caseid", mAdapter.getData().get(postion).getId());//传递案例id
                getActivity().startActivity(intent);
            }
        });
        recycleView.setAdapter(mAdapter);
        refreshLayout.setRefreshHeader(new MyRefreshHeader(getActivity()));
        refreshLayout.setRefreshFooter(new MyRefreshFooter(getActivity()));
    }

    private void initlistener() {
        mAdapter.setListener(new CallBack.CaseCareClikListener() {
            @Override
            public void CaseCareClik(int postion) {
                if (caseBean.get(postion).getAfollow() == 1) {
                    delCare(caseBean.get(postion).getId(), postion);
                } else {
                    addCare(caseBean.get(postion).getId(), postion);
                }
            }
        });

        mAdapter.setListener(new CallBack.CaseUserClikListener() {
            @Override
            public void CaseUserClik(int postion) {
                Intent intent = new Intent(getActivity(), NewMallDetailsActivity.class);
                intent.putExtra("shop_id", caseBean.get(postion).getUserid());
                startActivity(intent);
            }
        });

        refreshLayout.setOnRefreshListener(new OnRefreshListener() {
            @Override
            public void onRefresh(@NonNull RefreshLayout refreshLayout) {
                page = 1;
                type = 1;
                getData();
                refreshLayout.finishRefresh();
                refreshLayout.setNoMoreData(false);
            }
        });
        refreshLayout.setOnLoadMoreListener(new OnLoadMoreListener() {
            @Override
            public void onLoadMore(@NonNull RefreshLayout refreshLayout) {
                page++;
                getMoreData();
            }
        });
    }


    @Override
    public void onDestroyView() {
        super.onDestroyView();
         
        EventBusUtil.unregister(this);
    }

    @Override
    public void onSuccess(String result) {

        caseBean = JSONObject.parseObject(result, CaseBean.class).getData();
        if (caseBean.size() > 0) {
            mAdapter.setData(caseBean);
            noDataView.setVisibility(View.GONE);
        } else {
            mAdapter.clearList();
            noDataView.setVisibility(View.VISIBLE);
        }
    }

    @Override
    public void onError(Throwable ex, boolean isOnCallback) {

    }

    @Override
    public void onCancelled(CancelledException cex) {

    }

    @Override
    public void onFinished() {
        LoadDialog.CancelDialog();
    }

    @OnClick({R.id.rl_today_top, R.id.rl_week_peo, R.id.rl_month_peo, R.id.rl_week_hot, R.id.rl_month_hot})
    public void onViewClicked(View view) {
        Intent intent = new Intent(getActivity(), CaseByTYpeActivty.class);
        switch (view.getId()) {
            case R.id.rl_today_top:
                intent.putExtra("type", 1);
                break;
            case R.id.rl_week_peo:
                intent.putExtra("type", 2);
                break;
            case R.id.rl_month_peo:
                intent.putExtra("type", 3);
                break;
            case R.id.rl_week_hot:
                intent.putExtra("type", 4);
                break;
            case R.id.rl_month_hot:
                intent.putExtra("type", 5);
                break;
        }
        startActivity(intent);
    }

    //关注商家
    private void addCare(final int id, final int postion) {
        LoadDialog.showDialog(getActivity());
        new ApiManager().isCarUser("" + id, "" + SPUtil.get("token", SPUtil.Type.STR), "" + SPUtil.get("userid", SPUtil.Type.INT), new CommonCallback<String>() {
            @Override
            public void onSuccess(String result) {
                NToast.log("TAG-------关注结果", result + "   TAG-------案例id" + id);
                BaseBean base = JSONObject.parseObject(result, BaseBean.class);
                if (base.getCode() == 0) {
                    mAdapter.refreshCare(postion, 1);
                }

            }

            @Override
            public void onError(Throwable ex, boolean isOnCallback) {

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

    //取消关注商家
    private void delCare(final int id, final int postion) {
        LoadDialog.showDialog(getActivity());
        new ApiManager().cancelCarUser("" + id, "" + SPUtil.get("token", SPUtil.Type.STR), "" + SPUtil.get("userid", SPUtil.Type.INT), new CommonCallback<String>() {
            @Override
            public void onSuccess(String result) {

                NToast.log("TAG-------取关结果", result + "   TAG-------案例id" + id);
                BaseBean base = JSONObject.parseObject(result, BaseBean.class);
                if (base.getCode() == 0) {
                    mAdapter.refreshCare(postion, 0);
                }
            }

            @Override
            public void onError(Throwable ex, boolean isOnCallback) {

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

    @Subscribe(threadMode = ThreadMode.MAIN)
    public void receiveEvent(Event entity) {
        if (entity == null)
            return;
        try {
            int code = entity.getCode();
            switch (code) {
                case EventCode.CITY_SELECT:
                    getData();
                    break;
            }
        } catch (Exception e) {
        }

    }

}
