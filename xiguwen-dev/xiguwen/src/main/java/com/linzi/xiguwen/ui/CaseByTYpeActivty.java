package com.linzi.xiguwen.ui;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.View;
import android.widget.ImageView;

import com.alibaba.fastjson.JSONObject;
import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.NewExampleFragmentAdapter;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.BaseBean;
import com.linzi.xiguwen.bean.CaseListBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.CallBack;
import com.linzi.xiguwen.utils.GetShareContentUtil;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.SPUtil;
import com.linzi.xiguwen.utils.yixin.preference.Preferences;
import com.linzi.xiguwen.view.MyRefreshFooter;
import com.linzi.xiguwen.view.MyRefreshHeader;
import com.scwang.smartrefresh.layout.SmartRefreshLayout;
import com.scwang.smartrefresh.layout.api.RefreshLayout;
import com.scwang.smartrefresh.layout.listener.OnLoadMoreListener;
import com.scwang.smartrefresh.layout.listener.OnRefreshListener;

import org.xutils.common.Callback;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by pc on 2018/3/20.
 * <p>
 * 案例按分类显示列表activity
 * <p>
 * type1今日推荐2本周人气3本月人气4本周热门5本月热门
 */

public class CaseByTYpeActivty extends BaseActivity {

    @BindView(R.id.recycle)
    RecyclerView recycle;
    @BindView(R.id.refreshLayout)
    SmartRefreshLayout refreshLayout;
    @BindView(R.id.no_data_view)
    ImageView noDataView;
    private Context mContext;
    private int type;
    private Intent intent;
    private NewExampleFragmentAdapter mAdapter;
    private int page = 1;
    private int limit = 10;
    private List<CaseListBean.DataBean> caseBean;

    private boolean isCanLoadMore = true;

    private int cityid;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.casebytype_layout);
        ButterKnife.bind(this);
        mContext = this;
        if (intent == null) {
            intent = getIntent();
            type = intent.getIntExtra("type", -1);
        }
        if (type != -1) {//拦截type是否传递正确
            initView();
            initlistener();
            refreshLayout.autoRefresh();
        } else {
            NToast.show("跳转出错,请重试！");
            finish();
        }
    }

    @Override
    protected void initData() {

    }

    private void getData(final boolean isLoadMore) {
        if (isLoadMore) {
            page++;
        } else {
            page = 1;
        }

        cityid = Preferences.getCity().getId();

        ApiManager.getCase(cityid, page, limit, type, new OnRequestFinish<com.linzi.xiguwen.net.base.BaseBean<CaseListBean>>() {
            @Override
            public void onFinished() {
                if (isLoadMore) {
                    refreshLayout.finishLoadMore();
                } else {
                    refreshLayout.finishRefresh();
                }
            }

            @Override
            public void onSuccess(com.linzi.xiguwen.net.base.BaseBean<CaseListBean> data) {
                CaseListBean listBaseBean = data.getData();

                if (listBaseBean.getData() != null && listBaseBean.getData().size() > 0) {
                    if (isLoadMore) {
                        mAdapter.addData(listBaseBean.getData());
                        caseBean.addAll(listBaseBean.getData());
                    } else {
                        mAdapter.setData(listBaseBean.getData());
                        caseBean = listBaseBean.getData();
                    }
                    noDataView.setVisibility(View.GONE);
                } else {
                    if (isLoadMore) {
                        isCanLoadMore = false;
                        refreshLayout.setEnableLoadMore(false);
                        page--;
                    } else {
                        noDataView.setVisibility(View.VISIBLE);
                    }
                }
                mAdapter.notifyDataSetChanged();

            }

            @Override
            public void onError(Exception ex) {
                if (isLoadMore)
                    page--;
            }
        });
    }

    private void initView() {
        setBack();
        setRightAdd(R.mipmap.icon_share, new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                GetShareContentUtil.getContent(CaseByTYpeActivty.this, -1, 12, type);
            }
        });

        switch (type) {
            case 1:
                setTitle("今日推荐");
                break;
            case 2:
                setTitle("本周人气");
                break;
            case 3:
                setTitle("本月人气");
                break;
            case 4:
                setTitle("本周热门");
                break;
            case 5:
                setTitle("本月热门");
                break;
        }
        LinearLayoutManager manager = new LinearLayoutManager(mContext) {
            @Override
            public boolean canScrollVertically() {
                // 直接禁止垂直滑动
                return true;
            }
        };
        recycle.setLayoutManager(manager);
        mAdapter = new NewExampleFragmentAdapter(mContext, new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int postion) {
                Intent intent = new Intent(mContext, NewExampleDetailsActivity.class);
                intent.putExtra("caseid", mAdapter.getData().get(postion).getId());//传递案例id
                startActivity(intent);
            }
        });
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
        recycle.setAdapter(mAdapter);
        refreshLayout.setRefreshHeader(new MyRefreshHeader(mContext));
        refreshLayout.setRefreshFooter(new MyRefreshFooter(mContext));
    }


    @Override
    protected void onDestroy() {
        super.onDestroy();
         
    }

    private void initlistener() {
        refreshLayout.setOnRefreshListener(new OnRefreshListener() {
            @Override
            public void onRefresh(@NonNull RefreshLayout refreshLayout) {
                isCanLoadMore = true;
                refreshLayout.setEnableLoadMore(true);
                getData(false);
            }
        });
        refreshLayout.setOnLoadMoreListener(new OnLoadMoreListener() {
            @Override
            public void onLoadMore(@NonNull RefreshLayout refreshLayout) {
                if (isCanLoadMore) {
                    getData(true);
                }
            }
        });
    }

    //关注商家
    private void addCare(final int id, final int postion) {
        LoadDialog.showDialog(mContext);
        new ApiManager().isCarUser("" + id, "" + SPUtil.get("token", SPUtil.Type.STR), "" + SPUtil.get("userid", SPUtil.Type.INT), new Callback.CommonCallback<String>() {
            @Override
            public void onSuccess(String result) {
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
        LoadDialog.showDialog(mContext);
        new ApiManager().cancelCarUser("" + id, "" + SPUtil.get("token", SPUtil.Type.STR), "" + SPUtil.get("userid", SPUtil.Type.INT), new Callback.CommonCallback<String>() {
            @Override
            public void onSuccess(String result) {

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
}
