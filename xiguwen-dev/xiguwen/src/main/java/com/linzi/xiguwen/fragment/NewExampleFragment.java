package com.linzi.xiguwen.fragment;

import android.content.Intent;
import android.os.Bundle;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.alibaba.fastjson.JSONObject;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseLazyFragment;
import com.linzi.xiguwen.base.adapter.BaseAdapter;
import com.linzi.xiguwen.base.adapter.BaseViewHolder;
import com.linzi.xiguwen.base.adapter.CreateHolderDelegate;
import com.linzi.xiguwen.bean.CaseListBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.network.Constans;
import com.linzi.xiguwen.ui.CaseByTYpeActivty;
import com.linzi.xiguwen.ui.NewExampleDetailsActivity;
import com.linzi.xiguwen.utils.GlideLoad;
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

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

/**
 * Created by pc on 2018/4/25.
 */

public class NewExampleFragment extends BaseLazyFragment {
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
    @BindView(R.id.refreshLayout)
    SmartRefreshLayout refreshLayout;
    @BindView(R.id.no_data_view)
    ImageView noDataView;

    private int page = 1;
    private int limit = 10;
    private int type = 1;//1今日推荐2本周人气3本月人气4本周热门5本月热门
    private int cityid;

    private boolean isInitView;
    private BaseAdapter mAdapter;

    private CaseListBean caseBean;
    private boolean isCanLoadMore;

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = LayoutInflater.from(getActivity()).inflate(R.layout.fragment_example_layout, null);
        return view;
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        ButterKnife.bind(this, view);
        EventBusUtil.register(this);
        isCanLoadMore = true;
        initView();
        refreshLayout.autoRefresh();
    }

    private void initView() {
        refreshLayout.setRefreshHeader(new MyRefreshHeader(getActivity()));
        refreshLayout.setRefreshFooter(new MyRefreshFooter(getActivity()));
        refreshLayout.setOnRefreshListener(new OnRefreshListener() {
            @Override
            public void onRefresh(@NonNull RefreshLayout refreshLayout) {
                isCanLoadMore = true;
                refreshLayout.setEnableLoadMore(true);
                nodataDelegate.clearAll();
                getData(false);
            }
        });
        refreshLayout.setOnLoadMoreListener(new OnLoadMoreListener() {
            @Override
            public void onLoadMore(@NonNull RefreshLayout refreshLayout) {
                if (isCanLoadMore) {
                    nodataDelegate.clearAll();
                    getData(true);
                }
            }
        });
        afterView();
        noDataView.setVisibility(View.VISIBLE);
        isInitView = true;
    }

    private void afterView() {
        mAdapter = createAdapter();
        recycleView.setAdapter(mAdapter);
    }

    //noDataView delegate
    CreateHolderDelegate<String> nodataDelegate = new CreateHolderDelegate<String>() {

        @Override
        protected int getLayoutRes() {
            return R.layout.nodata_text_layout;
        }

        @Override
        protected BaseViewHolder onCreateHolder(View itemView) {
            return new BaseViewHolder<String>(itemView) {
                @Override
                protected void bindView(String o) {

                }
            };
        }
    };

    CreateHolderDelegate<CaseListBean.DataBean> itemDelegate = new CreateHolderDelegate<CaseListBean.DataBean>() {
        @Override
        protected int getLayoutRes() {
            return R.layout.item_example_layout;
        }

        @Override
        protected BaseViewHolder onCreateHolder(View itemView) {
            return new ItemHolder(itemView);
        }
    };

    class ItemHolder extends BaseViewHolder<CaseListBean.DataBean> {
        @BindView(R.id.iv_img)
        ImageView ivImg;
        @BindView(R.id.iv_header)
        ImageView ivHeader;
        @BindView(R.id.tv_name)
        TextView tvName;
        @BindView(R.id.bt_care)
        Button btCare;
        @BindView(R.id.tv_title)
        TextView tvTitle;
        @BindView(R.id.tv_price)
        TextView tvPrice;
        @BindView(R.id.tv_sign)
        TextView tvSign;
        @BindView(R.id.tv_see_count)
        TextView tvSeeCount;
        @BindView(R.id.tv_care_count)
        TextView tvCareCount;
        @BindView(R.id.tv_pingjia_count)
        TextView tvPingjiaCount;
        private int caseid;

        public ItemHolder(View itemView) {
            super(itemView);
            itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Intent intent = new Intent(getActivity(), NewExampleDetailsActivity.class);
                    intent.putExtra("caseid", caseid);//传递案例id
                    getActivity().startActivity(intent);
                }
            });
        }

        @Override
        protected void bindView(final CaseListBean.DataBean dataBean) {
            caseid = dataBean.getId();
            GlideLoad.GlideLoadImg(dataBean.getWeddingcover(), ivImg);
            GlideLoad.GlideLoadCircle(dataBean.getHead(), ivHeader);
            tvName.setText(dataBean.getNickname());
            tvTitle.setText(dataBean.getTitle());
            tvPrice.setText(Constans.RMB + dataBean.getWeddingexpenses());
            tvSign.setText(dataBean.getWeddingdescribe());
            tvSeeCount.setText(dataBean.getClicked() + "");
            tvCareCount.setText(dataBean.getGoodscore() + "");
            tvPingjiaCount.setText(dataBean.getCommented() + "");
            if (dataBean.getAfollow() == 1) {
                btCare.setBackgroundResource(R.mipmap.icon_close_care);
            } else if (dataBean.getAfollow() == 0) {
                btCare.setBackgroundResource(R.mipmap.icon_add_care);
            }
            btCare.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    if (dataBean.getAfollow() == 1) {
                        delCare(dataBean.getId(), getPosition());
                    } else {
                        addCare(dataBean.getId(), getPosition());
                    }
                }
            });
        }
    }

    private BaseAdapter createAdapter() {
        BaseAdapter baseAdapter = BaseAdapter.createBaseAdapter();
        baseAdapter
                .injectHolderDelegate(itemDelegate.cleanAfterAddAllData(null))
                .injectHolderDelegate(nodataDelegate.cleanAfterAddData(""))
        ;
        nodataDelegate.clearAll();
        baseAdapter.setLayoutManager(recycleView);
        return baseAdapter;
    }

    @Override
    public void onLazyLoad() {

    }

    private void getData(final boolean isLoadMore) {
        if (isLoadMore) {
            page++;
        } else {
            page = 1;
        }
        int cityid = 273;
        if(Preferences.getCity()!=null &&  ((Integer) Preferences.getCity().getId()) != null) {
            cityid = Preferences.getCity().getId();
        }else{
            cityid=273;
        }
        //cityid = Preferences.getCity().getId();
        NToast.log("APPTAG", cityid + "\n" + page + "\n" + limit + "\n" + type);

        ApiManager.getCase(cityid, page, limit, type, new OnRequestFinish<BaseBean<CaseListBean>>() {
            @Override
            public void onFinished() {
                if (isLoadMore) {
                    refreshLayout.finishLoadMore();
                } else {
                    refreshLayout.finishRefresh();
                }
            }

            @Override
            public void onSuccess(BaseBean<CaseListBean> data) {
                CaseListBean listBaseBean = data.getData();

                if (listBaseBean.getData() != null && listBaseBean.getData().size() > 0) {
                    if (isLoadMore) {
                        caseBean.getData().addAll(listBaseBean.getData());
                        itemDelegate.addAllData(listBaseBean.getData());
                    } else {
                        caseBean = listBaseBean;
                        itemDelegate.cleanAfterAddAllData(caseBean.getData());
                    }
                    nodataDelegate.clearAll();
                } else {
                    nodataDelegate.addData("");
                    if (isLoadMore) {
                        isCanLoadMore = false;
                        refreshLayout.setEnableLoadMore(false);
                        page--;
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

    private void refreshView() {
        itemDelegate.clearAll();
        nodataDelegate.clearAll();
        if (isInitView) {
            refreshLayout.autoRefresh();
        } else {
            initView();
        }
    }

    @Subscribe(threadMode = ThreadMode.MAIN)
    public void receiveEvent(Event entity) {
        if (entity == null)
            return;
        try {
            int code = entity.getCode();
            switch (code) {
                case EventCode.CITY_SELECT:
                    refreshView();
                    break;
                case EventCode.LOGIN_SUCCESS:
                    refreshView();
                    break;
            }
        } catch (Exception e) {
        }
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
         
        EventBusUtil.unregister(this);
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
        new ApiManager().isCarUser("" + id, "" + SPUtil.get("token", SPUtil.Type.STR), "" + SPUtil.get("userid", SPUtil.Type.INT), new Callback.CommonCallback<String>() {
            @Override
            public void onSuccess(String result) {
                com.linzi.xiguwen.bean.BaseBean base = JSONObject.parseObject(result, com.linzi.xiguwen.bean.BaseBean.class);
                if (base.getCode() == 0) {
                    caseBean.getData().get(postion).setAfollow(1);
                    mAdapter.notifyDataSetChanged();
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
        new ApiManager().cancelCarUser("" + id, "" + SPUtil.get("token", SPUtil.Type.STR), "" + SPUtil.get("userid", SPUtil.Type.INT), new Callback.CommonCallback<String>() {
            @Override
            public void onSuccess(String result) {
                com.linzi.xiguwen.bean.BaseBean base = JSONObject.parseObject(result, com.linzi.xiguwen.bean.BaseBean.class);
                if (base.getCode() == 0) {
                    caseBean.getData().get(postion).setAfollow(0);
                    mAdapter.notifyDataSetChanged();
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
