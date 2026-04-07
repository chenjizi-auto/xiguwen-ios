package com.linzi.xiguwen.fragment.jifen;

import android.content.Intent;
import android.os.Bundle;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseLazyFragment;
import com.linzi.xiguwen.base.adapter.BaseAdapter;
import com.linzi.xiguwen.base.adapter.BaseViewHolder;
import com.linzi.xiguwen.base.adapter.CreateHolderDelegate;
import com.linzi.xiguwen.bean.ExchangeJiFenBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.ui.JiFenOrderDetailsActivity;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;
import com.linzi.xiguwen.view.MyRefreshFooter;
import com.linzi.xiguwen.view.MyRefreshHeader;
import com.scwang.smartrefresh.layout.SmartRefreshLayout;
import com.scwang.smartrefresh.layout.api.RefreshLayout;
import com.scwang.smartrefresh.layout.listener.OnLoadMoreListener;
import com.scwang.smartrefresh.layout.listener.OnRefreshListener;

import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by pc on 2018/5/23.
 */

public class GoodsJiFenFragment extends BaseLazyFragment {

    @BindView(R.id.recycleview)
    RecyclerView recycleview;
    @BindView(R.id.refresh_layout)
    SmartRefreshLayout refreshLayout;

    private BaseAdapter baseAdapter;

    private int flag;//0商品兑换 1红包兑换

    private ExchangeJiFenBean exchangeJiFenBean;

    private int page = 1;
    private int limit = 10;

    public static GoodsJiFenFragment newInstance(int FLAG) {
        Bundle args = new Bundle();
        args.putInt("type", FLAG);
        GoodsJiFenFragment fragment = new GoodsJiFenFragment();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onLazyLoad() {

    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.jifen_mall_goods_layout, null);
        ButterKnife.bind(this, view);
        EventBusUtil.register(this);
        return view;

    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        flag = getArguments().getInt("type", flag);
        initView();
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
         
        EventBusUtil.unregister(this);
    }

    private void initView() {
        refreshLayout.setRefreshHeader(new MyRefreshHeader(getActivity()));
        refreshLayout.setRefreshFooter(new MyRefreshFooter(getActivity()));


        refreshLayout.setOnRefreshListener(new OnRefreshListener() {
            @Override
            public void onRefresh(@NonNull RefreshLayout refreshLayout) {
                resetDel();
                getDataGoods(false);
                refreshLayout.setEnableLoadMore(true);
            }
        });

        refreshLayout.setOnLoadMoreListener(new OnLoadMoreListener() {
            @Override
            public void onLoadMore(@NonNull RefreshLayout refreshLayout) {
                getDataGoods(true);

            }
        });

        afterView();

        refreshLayout.autoRefresh();
    }


    private void afterView() {
        if (flag == 1) {
            baseAdapter = createGoodsAdapter();
        } else {
            baseAdapter = createHongBaoAdapter();
        }
        recycleview.setAdapter(baseAdapter);
    }

    private void getDataGoods(final boolean isLoadMore) {
        if (isLoadMore) {
            page++;
        } else {
            page = 1;
        }
        ApiManager.getDuiHuanJiLu(page, limit, flag + 1, new OnRequestFinish<BaseBean<ExchangeJiFenBean>>() {
            @Override
            public void onFinished() {
                if (isLoadMore) {
                    refreshLayout.finishLoadMore();
                } else {
                    refreshLayout.finishRefresh();
                }
            }

            @Override
            public void onSuccess(BaseBean<ExchangeJiFenBean> data) {
                ExchangeJiFenBean bean = data.getData();
                if (!isLoadMore)
                    exchangeJiFenBean = bean;
                else
                    exchangeJiFenBean.getData().addAll(bean.getData());
                if (bean.getData() != null && bean.getData().size() > 0) {
                    noData.clearAll();
                    if (flag == 0) {
                        goodsDel.cleanAfterAddAllData(exchangeJiFenBean.getData());
                    } else {
                        hongBaoDel.cleanAfterAddAllData(exchangeJiFenBean.getData());
                    }
                } else {
                    refreshLayout.setEnableLoadMore(false);
                    if (isLoadMore) {
                        baseAdapter.injectHolderDelegate(new CreateHolderDelegate<String>() {

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
                        }.addData(""));
                    }
                }
                baseAdapter.notifyDataSetChanged();
            }

            @Override
            public void onError(Exception ex) {
                if (isLoadMore)
                    page--;
            }
        });
    }

    private BaseAdapter createGoodsAdapter() {
        BaseAdapter baseAdapter = BaseAdapter.createBaseAdapter();
        baseAdapter.injectHolderDelegate(noData);
        baseAdapter.injectHolderDelegate(goodsDel);
        baseAdapter.setLayoutManager(recycleview);
        return baseAdapter;
    }

    private BaseAdapter createHongBaoAdapter() {
        BaseAdapter baseAdapter = BaseAdapter.createBaseAdapter();
        baseAdapter.injectHolderDelegate(noData)
                .injectHolderDelegate(hongBaoDel);
        baseAdapter.setLayoutManager(recycleview);
        return baseAdapter;
    }

    CreateHolderDelegate<String> noData = new CreateHolderDelegate<String>() {

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
    }.addData("");

    CreateHolderDelegate<ExchangeJiFenBean.DataBean> goodsDel = new CreateHolderDelegate<ExchangeJiFenBean.DataBean>() {

        @Override
        protected int getLayoutRes() {
            return R.layout.goods_jifen_item;
        }

        @Override
        protected BaseViewHolder onCreateHolder(View itemView) {
            return new HotDuiHolder(itemView);
        }
    };

    CreateHolderDelegate<ExchangeJiFenBean.DataBean> hongBaoDel = new CreateHolderDelegate<ExchangeJiFenBean.DataBean>() {

        @Override
        protected int getLayoutRes() {
            return R.layout.hongbao_jifen_item;
        }

        @Override
        protected BaseViewHolder onCreateHolder(View itemView) {
            return new RedBaoHolder(itemView);
        }
    };

    //热兑商品holder
    class HotDuiHolder extends BaseViewHolder<ExchangeJiFenBean.DataBean> {
        @BindView(R.id.goods_img)
        ImageView goodsImg;
        @BindView(R.id.tv_title)
        TextView tvTitle;
        @BindView(R.id.tv_type)
        TextView tvType;

        private int id;

        public HotDuiHolder(View itemView) {
            super(itemView);
            itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Intent intent = new Intent(getActivity(), JiFenOrderDetailsActivity.class);
                    intent.putExtra("type", flag);
                    intent.putExtra("id", id);
                    getActivity().startActivity(intent);
                }
            });

        }

        @Override
        protected void bindView(ExchangeJiFenBean.DataBean shopBean) {
            id = shopBean.getId();
            GlideLoad.GlideLoadImg2(shopBean.getImg(), goodsImg);
            tvTitle.setText("" + shopBean.getName());
            int stutas = shopBean.getStatus();
            switch (stutas) {
                case 1:
                    tvType.setTextColor(getActivity().getResources().getColor(R.color.red));
                    tvType.setText("待付款");
                    break;
                case 2:
                    tvType.setTextColor(getActivity().getResources().getColor(R.color.red));
                    tvType.setText("待发货");
                    break;
                case 3:
                    tvType.setTextColor(getActivity().getResources().getColor(R.color.red));
                    tvType.setText("待收货");
                    break;
                case 4:
                    tvType.setTextColor(getActivity().getResources().getColor(R.color.color_green_00d3a9));
                    tvType.setText("交易成功");
                    break;
                case 5:
                    tvType.setTextColor(getActivity().getResources().getColor(R.color.red));
                    tvType.setText("交易关闭");
                    break;

            }
        }
    }

    //兑换红包holder
    class RedBaoHolder extends BaseViewHolder<ExchangeJiFenBean.DataBean> {
        @BindView(R.id.goods_img)
        ImageView goodsImg;
        @BindView(R.id.tv_title)
        TextView tvTitle;
        @BindView(R.id.tv_num)
        TextView tvNum;
        @BindView(R.id.tv_time)
        TextView tvTime;
        @BindView(R.id.tv_type)
        TextView tvType;
        private int id;

        public RedBaoHolder(View itemView) {
            super(itemView);
//            Intent intent = new Intent(getActivity(), JiFenOrderDetailsActivity.class);
//            intent.putExtra("type", flag);
//            intent.putExtra("id", id);
//            getActivity().startActivity(intent);
        }

        @Override
        protected void bindView(ExchangeJiFenBean.DataBean hongbaoBean) {
            id = hongbaoBean.getId();
            GlideLoad.GlideLoadImg2(hongbaoBean.getImg(), goodsImg);
            tvTitle.setText("" + hongbaoBean.getName());
            tvTime.setText(hongbaoBean.getDate());
            tvNum.setText(hongbaoBean.getJifen() + "积分");
            tvType.setText("兑换成功");
        }
    }

    //重置adapter代理
    private void resetDel() {
        baseAdapter.clearAllDelegate();
        baseAdapter.injectHolderDelegate(noData);
        if (flag == 0) {
            baseAdapter.injectHolderDelegate(goodsDel);
        } else {
            baseAdapter.injectHolderDelegate(hongBaoDel);
        }
    }

    @Subscribe(threadMode = ThreadMode.MAIN)
    public void receiveEvent(Event event) {
        if (event == null)
            return;
        try {
            int code = event.getCode();
            switch (code) {
                case EventCode.REFRESH_JIFEN_ORDER_LIST:
                    refreshLayout.autoRefresh();
                    break;
            }
        } catch (Exception e) {

        }
    }
}
