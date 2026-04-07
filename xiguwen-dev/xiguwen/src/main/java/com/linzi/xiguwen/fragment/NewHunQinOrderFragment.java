package com.linzi.xiguwen.fragment;

import android.content.Intent;
import android.graphics.drawable.Drawable;
import android.os.Bundle;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseLazyFragment;
import com.linzi.xiguwen.base.adapter.BaseAdapter;
import com.linzi.xiguwen.base.adapter.BaseViewHolder;
import com.linzi.xiguwen.base.adapter.CreateHolderDelegate;
import com.linzi.xiguwen.bean.MallJieDanOrderList;
import com.linzi.xiguwen.bean.MallOrderListBean;
import com.linzi.xiguwen.bean.WeddingJieDanOrderList;
import com.linzi.xiguwen.bean.WeddingOrderListBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.network.Constans;
import com.linzi.xiguwen.ui.EditPriceActivity;
import com.linzi.xiguwen.ui.EditWuLiuMsgActivity;
import com.linzi.xiguwen.ui.NewOrderDetailsActivity;
import com.linzi.xiguwen.ui.NewRefundDetailsActivity;
import com.linzi.xiguwen.ui.PingjiaAdapterActivity;
import com.linzi.xiguwen.ui.RefuseReasonActivity;
import com.linzi.xiguwen.ui.ShenQingTuikuanActivity;
import com.linzi.xiguwen.ui.ToPayActivity;
import com.linzi.xiguwen.ui.ViewWuLiuActivity;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.view.AskDialog;
import com.linzi.xiguwen.view.MyRefreshFooter;
import com.linzi.xiguwen.view.MyRefreshHeader;
import com.linzi.xiguwen.view.dialog.ChoosePayDialog;
import com.linzi.xiguwen.widget.GetPayPop;
import com.scwang.smartrefresh.layout.SmartRefreshLayout;
import com.scwang.smartrefresh.layout.api.RefreshLayout;
import com.scwang.smartrefresh.layout.listener.OnLoadMoreListener;
import com.scwang.smartrefresh.layout.listener.OnRefreshListener;


import java.util.ArrayList;

import java.util.List;


import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by pc on 2018/4/16.
 */

public class NewHunQinOrderFragment extends BaseLazyFragment {
    private final String TAG = getClass().getSimpleName();
    @BindView(R.id.recycle)
    RecyclerView recycle;
    @BindView(R.id.no_data)
    TextView noData;
    @BindView(R.id.refresh_layout)
    SmartRefreshLayout refreshLayout;

    private int page = 1;
    private int limit = 10;

    private boolean isCanLoadMore;

    private WeddingOrderListBean mWeddingOrderListBean;
    private MallOrderListBean mMallOrderListBean;
    private WeddingJieDanOrderList mWeddingJieDanOrderList;
    private MallJieDanOrderList mMallJieDanOrderList;

    private BaseAdapter mAdapter;

    private int intentType;
    private String type;

    private boolean isInitView;//记录是否初始化view 用于刷新

    public static NewHunQinOrderFragment createFragment(int type, int intentType) {
        NewHunQinOrderFragment fragment = new NewHunQinOrderFragment();
        switch (intentType) {
            case 0://婚庆订单
                switch (type) {
                    case 0:
                        type = -1;//全部
                        break;
                    case 1:
                        type = 10;//待付款
                        break;
                    case 2:
                        type = 60;//待接单
                        break;
                    case 3:
                        type = 70;//待服务
                        break;
                    case 4:
                        type = 79;//已服务
                        break;
                    case 5:
                        type = 80;//待评价
                        break;
                    case 6:
                        type = 90;//已完成
                        break;
                }
                break;
            case 1://商城订单
                switch (type) {
                    case 0:
                        type = -1;//全部
                        break;
                    case 1:
                        type = 10;//待付款
                        break;
                    case 2:
                        type = 60;//待发货
                        break;
                    case 3:
                        type = 70;//待收货
                        break;
                    case 4:
                        type = 80;//待评价
                        break;
                }
                break;
            case 2://婚庆接单
                switch (type) {
                    case 0:
                        type = -1;//全部
                        break;
                    case 1:
                        type = 10;//待付款
                        break;
                    case 2:
                        type = 60;//待接单
                        break;
                    case 3:
                        type = 70;//待服务
                        break;
                    case 4:
                        type = 79;//已服务
                        break;
                    case 5:
                        type = 80;//待评价
                        break;
                    case 6:
                        type = 90;//已完成
                        break;
                    case 7:
                        type = 20;//已关闭
                        break;
                    case 8:
                        type = 100;//退款单
                        break;
                }
                break;
            case 3://商场接单
                switch (type) {
                    case 0:
                        type = -1;//全部
                        break;
                    case 1:
                        type = 10;//待付款
                        break;
                    case 2:
                        type = 60;//待发货
                        break;
                    case 3:
                        type = 70;//待收货
                        break;
                    case 4:
                        type = 80;//待评价
                        break;
                    case 5:
                        type = 90;//已完成
                        break;
                    case 6:
                        type = 20;//已关闭
                        break;
                    case 7:
                        type = 100;//退款单
                        break;
                }
                break;
        }

        Bundle bundle = new Bundle();
        bundle.putInt("type", type);
        bundle.putInt("intentType", intentType);
        fragment.setArguments(bundle);
        return fragment;
    }

    @Override
    public void onLazyLoad() {
    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.new_wedding_order_fra_layout, null);
        ButterKnife.bind(this, view);
        return view;
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        type = getArguments().getInt("type") + "";
        NToast.log(TAG,"onViewCreated type is "+type);
        intentType = getArguments().getInt("intentType");
        isCanLoadMore = true;
        initView();
        refreshLayout.autoRefresh();
    }

    private void initView() {
        refreshLayout.setRefreshHeader(new MyRefreshHeader(getActivity()));
        refreshLayout.setRefreshFooter(new MyRefreshFooter(getActivity()));

        //控制请求
        refreshLayout.setOnRefreshListener(new OnRefreshListener() {
            @Override
            public void onRefresh(@NonNull RefreshLayout refreshLayout) {
                com.linzi.xiguwen.utils.LogUtil.e(TAG,"getWeddingJieDanData type: "+type +" intentType "+intentType);
                switch (intentType) {
                    case 0:
                        getWeddingData(false);
                        break;
                    case 1:
                        getMallData(false);
                        break;
                    case 2:
                        getWeddingJieDanData(false);
                        break;
                    case 3:
                        getMallJieDanData(false);
                        break;
                }

            }
        });

        refreshLayout.setOnLoadMoreListener(new OnLoadMoreListener() {
            @Override
            public void onLoadMore(@NonNull RefreshLayout refreshLayout) {
                if (isCanLoadMore) {
                    switch (intentType) {
                        case 0:
                            getWeddingData(true);
                            break;
                        case 1:
                            getMallData(true);
                            break;
                        case 2:
                            getWeddingJieDanData(true);
                            break;
                        case 3:
                            getMallJieDanData(true);
                            break;
                    }
                }
            }
        });

        isInitView = true;
    }

    //获取婚庆订单
    private void getWeddingData(final boolean isLoadMore) {
        ctrlPublicParms(isLoadMore);
        ApiManager.getWeddingOrderList(type, null, page, limit, new OnRequestFinish<BaseBean<WeddingOrderListBean>>() {
            @Override
            public void onFinished() {
                closeLoadingDialog(isLoadMore);
            }

            @Override
            public void onSuccess(BaseBean<WeddingOrderListBean> data) {
                WeddingOrderListBean weddingOrderListBean = data.getData();
                if (weddingOrderListBean.getData() != null && weddingOrderListBean.getData().size() > 0) {
                    if (isLoadMore) {
                        mWeddingOrderListBean.getData().addAll(weddingOrderListBean.getData());
                        weddingDelegate.addAllData(weddingOrderListBean.getData());
                        mAdapter.notifyDataSetChanged();
                    } else {
                        mWeddingOrderListBean = weddingOrderListBean;
                        afterView();
                        isCanLoadMore = true;
                    }
                    noData.setVisibility(View.GONE);
                } else {
                    if (!isLoadMore) {
                        if (mWeddingOrderListBean != null) {
                            mWeddingOrderListBean = null;
                            weddingDelegate.clearAll();
                            mAdapter.notifyDataSetChanged();
                        }
                    }
                    addNoDataView(isLoadMore);

                }
                refreshLayout.setEnableLoadMore(isCanLoadMore);
            }

            @Override
            public void onError(Exception ex) {
                if (isLoadMore)
                    page--;
            }
        });
    }

    //获取商城订单
    private void getMallData(final boolean isLoadMore) {
        ctrlPublicParms(isLoadMore);
        ApiManager.getMallOrderList(type, page, limit, new OnRequestFinish<BaseBean<MallOrderListBean>>() {
            @Override
            public void onFinished() {
                closeLoadingDialog(isLoadMore);
            }

            @Override
            public void onSuccess(BaseBean<MallOrderListBean> data) {
                MallOrderListBean mallOrderListBean = data.getData();
                if (mallOrderListBean.getData() != null && mallOrderListBean.getData().size() > 0) {
                    if (isLoadMore) {
                        mMallOrderListBean.getData().addAll(mallOrderListBean.getData());
                        mallDelegate.addAllData(mallOrderListBean.getData());
                        mAdapter.notifyDataSetChanged();
                    } else {
                        mMallOrderListBean = mallOrderListBean;
                        afterView();
                        isCanLoadMore = true;
                    }
                    noData.setVisibility(View.GONE);
                } else {
                    if (!isLoadMore) {
                        if (mMallOrderListBean != null) {
                            mMallOrderListBean = null;
                            mallDelegate.clearAll();
                            mAdapter.notifyDataSetChanged();
                        }
                    }
                    addNoDataView(isLoadMore);
                }
                refreshLayout.setEnableLoadMore(isCanLoadMore);
            }

            @Override
            public void onError(Exception ex) {
                if (isLoadMore)
                    page--;
            }
        });
    }

    //获取婚庆接单
    private void getWeddingJieDanData(final boolean isLoadMore) {
        ctrlPublicParms(isLoadMore);
        ApiManager.getWeddingJieDanOrderList(type, null, page, limit, new OnRequestFinish<BaseBean<WeddingJieDanOrderList>>() {
            @Override
            public void onFinished() {
                closeLoadingDialog(isLoadMore);
            }

            @Override
            public void onSuccess(BaseBean<WeddingJieDanOrderList> data) {
                WeddingJieDanOrderList weddingJieDanOrderList = data.getData();
                if (weddingJieDanOrderList.getData() != null && weddingJieDanOrderList.getData().size() > 0) {
                    if (isLoadMore) {
                        mWeddingJieDanOrderList.getData().addAll(weddingJieDanOrderList.getData());
                        weddingJieDanDelegate.addAllData(weddingJieDanOrderList.getData());
                        mAdapter.notifyDataSetChanged();
                    } else {
                        mWeddingJieDanOrderList = weddingJieDanOrderList;
                        afterView();
                        isCanLoadMore = true;
                    }
                    noData.setVisibility(View.GONE);
                } else {
                    if (!isLoadMore) {
                        if (mWeddingJieDanOrderList != null) {
                            mWeddingJieDanOrderList = null;
                            weddingJieDanDelegate.clearAll();
                            mAdapter.notifyDataSetChanged();
                        }
                    }
                    addNoDataView(isLoadMore);
                }
                refreshLayout.setEnableLoadMore(isCanLoadMore);
            }

            @Override
            public void onError(Exception ex) {
                if (isLoadMore)
                    page--;
            }
        });
    }

    //获取商城接单
    private void getMallJieDanData(final boolean isLoadMore) {
        ctrlPublicParms(isLoadMore);
        ApiManager.getMallJieDanOrderList(type, page, limit, new OnRequestFinish<BaseBean<MallJieDanOrderList>>() {
            @Override
            public void onFinished() {
                closeLoadingDialog(isLoadMore);
            }

            @Override
            public void onSuccess(BaseBean<MallJieDanOrderList> data) {
                MallJieDanOrderList mallJieDanOrderList = data.getData();
                if (mallJieDanOrderList.getData() != null && mallJieDanOrderList.getData().size() > 0) {
                    if (isLoadMore) {
                        mMallJieDanOrderList.getData().addAll(mallJieDanOrderList.getData());
                        mallJieDanDelegate.addAllData(mallJieDanOrderList.getData());
                        mAdapter.notifyDataSetChanged();
                    } else {
                        mMallJieDanOrderList = mallJieDanOrderList;
                        afterView();
                        isCanLoadMore = true;
                    }
                    noData.setVisibility(View.GONE);
                } else {
                    if (!isLoadMore) {
                        if (mMallJieDanOrderList != null) {
                            mMallJieDanOrderList = null;
                            mallJieDanDelegate.clearAll();
                            mAdapter.notifyDataSetChanged();
                        }
                    }
                    addNoDataView(isLoadMore);
                }
                refreshLayout.setEnableLoadMore(isCanLoadMore);
            }

            @Override
            public void onError(Exception ex) {
                if (isLoadMore)
                    page--;
            }
        });
    }

    //婚庆订单 Delegate
    CreateHolderDelegate<WeddingOrderListBean.DataBean> weddingDelegate = new CreateHolderDelegate<WeddingOrderListBean.DataBean>() {
        @Override
        protected int getLayoutRes() {
            return R.layout.wedding_order_list_item_new;
        }

        @Override
        protected BaseViewHolder onCreateHolder(View itemView) {
            return new WeddingItemHolder(itemView);
        }
    };

    //商城订单 Delegate
    CreateHolderDelegate<MallOrderListBean.DataBean> mallDelegate = new CreateHolderDelegate<MallOrderListBean.DataBean>() {
        @Override
        protected int getLayoutRes() {
            return R.layout.mall_order_list_item;
        }

        @Override
        protected BaseViewHolder onCreateHolder(View itemView) {
            return new MallItemHolder(itemView);
        }
    };

    //婚庆接单 Delegate
    CreateHolderDelegate<WeddingJieDanOrderList.DataBean> weddingJieDanDelegate = new CreateHolderDelegate<WeddingJieDanOrderList.DataBean>() {
        @Override
        protected int getLayoutRes() {
            return R.layout.wedding_order_list_item_new;
        }

        @Override
        protected BaseViewHolder onCreateHolder(View itemView) {
            return new WeddingJieDanItemHolder(itemView);
        }
    };

    //商城接单 Delegate
    CreateHolderDelegate<MallJieDanOrderList.DataBean> mallJieDanDelegate = new CreateHolderDelegate<MallJieDanOrderList.DataBean>() {
        @Override
        protected int getLayoutRes() {
            return R.layout.mall_order_list_item;
        }

        @Override
        protected BaseViewHolder onCreateHolder(View itemView) {
            return new MallJieDanItemHolder(itemView);
        }
    };

    //婚庆订单 holder
    class WeddingItemHolder extends BaseViewHolder<WeddingOrderListBean.DataBean> {
        //        @BindView(R.id.tv_name)
//        TextView tvName;
        @BindView(R.id.tv_status_tip)
        TextView tvStatusTip;
        @BindView(R.id.iv_img)
        ImageView ivImg;
        @BindView(R.id.tv_title)
        TextView tvTitle;
        @BindView(R.id.tv_time)
        TextView tvTime;
        @BindView(R.id.tv_pay_type)
        TextView tvPayType;
        //        @BindView(R.id.line)
//        View line;
        @BindView(R.id.qq)
        TextView qq;
        @BindView(R.id.time)
        TextView time;
        @BindView(R.id.tv_status)
        TextView tvStatus;
        @BindView(R.id.thr_btn)
        TextView thrBtn;
        @BindView(R.id.cancelbtn)
        TextView cancelbtn;
        @BindView(R.id.surebtn)
        TextView surebtn;
        @BindView(R.id.rl_button)
        RelativeLayout rlButton;


        private int type;
        private int id;


        public WeddingItemHolder(View itemView) {
            super(itemView);
            itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Intent intent = new Intent(getActivity(), NewOrderDetailsActivity.class);
                    intent.putExtra("intentType", 0);
                    intent.putExtra("type", type);
                    intent.putExtra("order_id", id);
                    startActivity(intent);
                }
            });
        }

        @Override
        protected void bindView(final WeddingOrderListBean.DataBean bean) {
            id = bean.getOrder_id();
            type = bean.getStatus();

            switch (type) {
                case 10://待付款
//                    ivStatus.setBackgroundResource(R.mipmap.icon_daifukuan);
                    tvStatusTip.setText("待付款");
                    //llTruePrice.setVisibility(View.GONE);
//                    rlButton.setVisibility(View.VISIBLE);
                    cancelbtn.setVisibility(View.VISIBLE);
                    surebtn.setVisibility(View.VISIBLE);
//                    line.setVisibility(View.VISIBLE);
                    surebtn.setText("立即支付");
                    cancelbtn.setText("取消订单");
                    surebtn.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            Intent intent = new Intent(getActivity(), ToPayActivity.class);
                            intent.putExtra("intentType", intentType);
                            intent.putExtra("id", bean.getPid());
                            bean.getPaytype();
                            intent.putExtra("price", bean.getPayjine());
                            getActivity().startActivity(intent);
                        }
                    });
                    cancelbtn.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            createDel("温馨提示", "确认取消订单吗？", "点错了", "确认", id, 0);
                        }
                    });
                    break;
                case 60://待接单
//                    ivStatus.setBackgroundResource(R.mipmap.icon_daijiedan);
                    tvStatusTip.setText("待接单");
                    cancelbtn.setVisibility(View.GONE);
                    if (!bean.getAmount_balance().equals("0") && !bean.getAmount_balance().equals("0.00")) {
//                        rlButton.setVisibility(View.VISIBLE);
                        surebtn.setVisibility(View.VISIBLE);
//                        line.setVisibility(View.VISIBLE);
                        surebtn.setText("立即付款");
                        surebtn.setOnClickListener(new View.OnClickListener() {
                            @Override
                            public void onClick(View view) {
                                GetPayPop getPayPop = new GetPayPop(getActivity(), new GetPayPop.GetPriceCallBack() {
                                    @Override
                                    public void onResult(String price) {
                                        Intent intent = new Intent(getActivity(), ToPayActivity.class);
                                        intent.putExtra("intentType", intentType);
                                        intent.putExtra("id", bean.getPid());
                                        intent.putExtra("order_id", id);
                                        intent.putExtra("price", price);
                                        intent.putExtra("isWeiKuan", true);
                                        getActivity().startActivity(intent);
                                    }
                                }, bean.getAmount_balance());
                                getPayPop.show();
                            }
                        });
                    } else {
//                        line.setVisibility(View.GONE);
//                        rlButton.setVisibility(View.GONE);
                        surebtn.setVisibility(View.GONE);
                    }
                    break;
                case 70://待服务
//                    ivStatus.setBackgroundResource(R.mipmap.icon_daifuwu);
                    tvStatusTip.setText("待服务");
                    surebtn.setVisibility(View.VISIBLE);
                    rlButton.setVisibility(View.VISIBLE);
//                    line.setVisibility(View.VISIBLE);
                    if (!bean.getAmount_balance().equals("0") && !bean.getAmount_balance().equals("0.00")) {
                        cancelbtn.setVisibility(View.VISIBLE);
                        cancelbtn.setText("立即付款");
                        cancelbtn.setOnClickListener(new View.OnClickListener() {
                            @Override
                            public void onClick(View view) {
                                GetPayPop getPayPop = new GetPayPop(getActivity(), new GetPayPop.GetPriceCallBack() {
                                    @Override
                                    public void onResult(String price) {
                                        Intent intent = new Intent(getActivity(), ToPayActivity.class);
                                        intent.putExtra("intentType", intentType);
                                        intent.putExtra("id", bean.getPid());
                                        intent.putExtra("price", price);
                                        intent.putExtra("order_id", id);
                                        intent.putExtra("isWeiKuan", true);
                                        getActivity().startActivity(intent);
                                    }
                                }, bean.getAmount_balance());
                                getPayPop.show();
                            }
                        });
                    } else {
                        cancelbtn.setVisibility(View.GONE);
                    }
                    switch (bean.getTuihuo()) {
                        case 1://用户可以申请退款
                            surebtn.setText("申请退款");
                            surebtn.setOnClickListener(new View.OnClickListener() {
                                @Override
                                public void onClick(View view) {
                                    Intent intent = new Intent(getActivity(), ShenQingTuikuanActivity.class);
                                    intent.putExtra("listbean", bean);
                                    intent.putExtra("type", 0);
                                    intent.putExtra("intentType", intentType);
                                    getActivity().startActivity(intent);
                                }
                            });
                            break;
                        case 2://用户已申请退款
                            surebtn.setText("退款详情");
                            surebtn.setOnClickListener(new View.OnClickListener() {
                                @Override
                                public void onClick(View view) {
                                    Intent intent = new Intent(getActivity(), NewRefundDetailsActivity.class);
                                    intent.putExtra("id", bean.getOrder_id());//订单id
                                    intent.putExtra("intentType", intentType);
                                    getActivity().startActivity(intent);
                                }
                            });
                            break;
                        case 3://同意退款
                            surebtn.setText("退款详情");
                            surebtn.setOnClickListener(view -> {
                                Intent intent = new Intent(getActivity(), NewRefundDetailsActivity.class);
                                intent.putExtra("id", bean.getOrder_id());//订单id
                                intent.putExtra("intentType", intentType);
                                getActivity().startActivity(intent);
                            });
                            break;
                        case 4://拒绝退款
                            surebtn.setText("退款详情");
                            surebtn.setOnClickListener(view -> {
                                Intent intent = new Intent(getActivity(), NewRefundDetailsActivity.class);
                                intent.putExtra("id", bean.getOrder_id());//订单id
                                intent.putExtra("intentType", intentType);
                                getActivity().startActivity(intent);
                            });
                            break;
                    }
                    break;
//                case 71://已服务(未付尾款)
//                    ivStatus.setBackgroundResource(R.mipmap.icon_yifuwu);
//                    surebtn.setVisibility(View.VISIBLE);
//                    rlButton.setVisibility(View.VISIBLE);
//                    line.setVisibility(View.VISIBLE);
//                    surebtn.setText("确认完成");
//                    if (!bean.getAmount_balance().equals("0") && !bean.getAmount_balance().equals("0.00")) {
//                        cancelbtn.setVisibility(View.VISIBLE);
//                        cancelbtn.setText("立即付款");
//                        cancelbtn.setOnClickListener(new View.OnClickListener() {
//                            @Override
//                            public void onClick(View view) {
//                                createFinishOrderServerDialog(id, bean.getPid(), bean.getAmount_balance());
//                            }
//                        });
//                    } else {
//                        cancelbtn.setVisibility(View.GONE);
//                    }
//                    surebtn.setOnClickListener(new View.OnClickListener() {
//                        @Override
//                        public void onClick(View view) {
//                            createDel("温馨提示", "该订单需要支付尾款才能完成，快去支付吧！", "取消", "确认", bean.getPid(), id, bean.getAmount_balance());
//                        }
//                    });
//                    break;
                case 79://已服务(已付尾款)
//                    ivStatus.setBackgroundResource(R.mipmap.icon_yifuwu);
                    com.linzi.xiguwen.utils.LogUtil.e(TAG,"---------79-----");
                    tvStatusTip.setText("已服务");
                    cancelbtn.setVisibility(View.VISIBLE);
                    surebtn.setVisibility(View.VISIBLE);
//                    rlButton.setVisibility(View.VISIBLE);
//                    line.setVisibility(View.VISIBLE);
                    surebtn.setText("确认完成");
//                    if (bean.getPayment_dis() == 2) {
//                        cancelbtn.setVisibility(View.VISIBLE);
//                        cancelbtn.setText("立即付款");
//                        cancelbtn.setOnClickListener(new View.OnClickListener() {
//                            @Override
//                            public void onClick(View view) {
//                                GetPayPop getPayPop = new GetPayPop(getActivity(), new GetPayPop.GetPriceCallBack() {
//                                    @Override
//                                    public void onResult(String price) {
//                                        Intent intent = new Intent(getActivity(), ToPayActivity.class);
//                                        intent.putExtra("intentType", intentType);
//                                        intent.putExtra("id", bean.getPid());
//                                        intent.putExtra("price", price);
//                                        intent.putExtra("order_id", id);
//                                        intent.putExtra("isWeiKuan", true);
//                                        getActivity().startActivity(intent);
//                                    }
//                                }, bean.getAmount_balance());
//                                getPayPop.show();
//                            }
//                        });
//                        surebtn.setOnClickListener(new View.OnClickListener() {
//                            @Override
//                            public void onClick(View view) {
//                                createDel("温馨提示", "该订单需要支付尾款才能完成，快去支付吧！", "取消", "确认", bean.getPid(), id, bean.getAmount_balance());
//                            }
//                        });
//                    } else
                        if (bean.getPayment_dis() == 3) {
                        cancelbtn.setVisibility(View.VISIBLE);
                        cancelbtn.setText("立即付款");
                        cancelbtn.setOnClickListener(new View.OnClickListener() {
                            @Override
                            public void onClick(View view) {
                                createFinishOrderServerDialog(id, bean.getPid(), bean.getAmount_balance());
                            }
                        });
                        surebtn.setVisibility(View.VISIBLE);
                        surebtn.setOnClickListener(new View.OnClickListener() {
                            @Override
                            public void onClick(View view) {
                                createDel("温馨提示", "该订单需要支付尾款才能完成，快去支付吧！", "取消", "确认", bean.getPid(), id, bean.getAmount_balance());
                            }
                        });
                    } else if (bean.getPayment_dis() == 4) {
                        cancelbtn.setVisibility(View.GONE);
                        surebtn.setOnClickListener(new View.OnClickListener() {
                            @Override
                            public void onClick(View view) {
                                createDel("温馨提示", "确认完成订单吗？", "点错了", "确认", id, 1);
                            }
                        });
                    }
                    break;
                case 80://待评价
//                    ivStatus.setBackgroundResource(R.mipmap.icon_daipingjia);
                    tvStatusTip.setText("待评价");
                    cancelbtn.setVisibility(View.GONE);
                    surebtn.setVisibility(View.VISIBLE);
//                    rlButton.setVisibility(View.VISIBLE);
//                    line.setVisibility(View.VISIBLE);

                    surebtn.setText("立即评价");

                    surebtn.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            //跳转评价activity
                            Intent intent = new Intent(getActivity(), PingjiaAdapterActivity.class);
                            intent.putExtra("intentType", intentType);
                            intent.putExtra("order_id", id);
                            getActivity().startActivity(intent);
                        }
                    });
                    break;
                case 90://交易成功 已评价
                    tvStatusTip.setText("交易成功");
//                    ivStatus.setBackgroundResource(R.mipmap.icon_jiaoyichenggong);
//                    rlButton.setVisibility(View.GONE);
//                    line.setVisibility(View.GONE);
                    break;
                case 20://交易关闭
//                    ivStatus.setBackgroundResource(R.mipmap.icon_jiaoyiguanbi);
                    tvStatusTip.setText("交易关闭");
//                    rlButton.setVisibility(View.GONE);
//                    line.setVisibility(View.GONE);
                    break;
            }

            //标记商品是否处于退款状态
            switch (bean.getTuihuo()) {
                case 1://用户可以申请退款
                    tvStatus.setVisibility(View.GONE);
                    break;
                case 2://2是退款中
                    tvStatus.setVisibility(View.VISIBLE);
                    tvStatus.setText("退款中");
                    break;
                case 3://3同意退款
                    tvStatus.setVisibility(View.VISIBLE);
                    tvStatus.setText("同意退款");
                    break;
                case 4://4拒绝退款
                    tvStatus.setVisibility(View.VISIBLE);
                    tvStatus.setText("拒绝退款");
                    break;
            }

//            tvTitle.setText(bean.getSeller_info().getNickname() + "");
            //tvPeice.setText("￥" + bean.getZongjine());
            //tvTruePrice.setText("￥" + bean.getShifukuan());
            tvPayType.setText("￥" + bean.getZongjine());
            GlideLoad.GlideLoadCircle(bean.getBaojia_image(), ivImg);
            tvTitle.setText(bean.getBaojia_name() + "");
            tvTime.setText(bean.getSpecification() + "");
            //tvDanjia.setText(Constans.RMB + bean.getPrice());
            //tvNum.setText("" + bean.getQuantity());

//            switch (bean.getPaytype()) {
//                case 1:
//                    tvDingjin.setVisibility(View.GONE);
//                    dingjintx.setVisibility(View.GONE);
//                    tvPayType.setText("全款");
//                    break;
//                case 2:
//                    tvDingjin.setVisibility(View.VISIBLE);
//                    dingjintx.setVisibility(View.VISIBLE);
//                    tvDingjin.setText(Constans.RMB + bean.getYuandingjin());
//                    tvPayType.setText("定金+尾款");
//                    break;
//                case 3:
//                    tvDingjin.setVisibility(View.VISIBLE);
//                    dingjintx.setVisibility(View.VISIBLE);
//                    tvDingjin.setText(Constans.RMB + bean.getYuandingjin());
//                    tvPayType.setText("定金+线下");
//                    break;
//            }

//            if (bean.getDeductible() != null && !bean.getDeductible().equals("")) {
//                dikoutext.setVisibility(View.VISIBLE);
//                tvDiKou.setText("￥" + bean.getDeductible());
//            } else {
//                dikoutext.setVisibility(View.GONE);
//            }
        }
    }

    //商城订单 holder
    class MallItemHolder extends BaseViewHolder<MallOrderListBean.DataBean> {
        @BindView(R.id.tv_name)
        TextView tvName;
        @BindView(R.id.tv_peice)
        TextView tvPeice;
        @BindView(R.id.tv_true_price)
        TextView tvTruePrice;
        @BindView(R.id.time)
        TextView time;
        @BindView(R.id.cancelbtn)
        TextView cancelbtn;
        @BindView(R.id.surebtn)
        TextView surebtn;
        @BindView(R.id.iv_status)
        ImageView ivStatus;
        @BindView(R.id.rl_button)
        RelativeLayout rlButton;
        @BindView(R.id.line)
        View line;
        @BindView(R.id.recycleview)
        RecyclerView recyclerView;
        @BindView(R.id.tv_goods_num)
        TextView tv_goods_num;

        private int type;
        private int id;


        public MallItemHolder(View itemView) {
            super(itemView);
            itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Intent intent = new Intent(getActivity(), NewOrderDetailsActivity.class);
                    intent.putExtra("intentType", 1);
                    intent.putExtra("type", type);
                    intent.putExtra("order_id", id);
                    startActivity(intent);
                }
            });
        }

        @Override
        protected void bindView(final MallOrderListBean.DataBean bean) {
            id = bean.getOrder_id();
            type = bean.getStatus();

            switch (type) {
                case 10://待付款
                    ivStatus.setBackgroundResource(R.mipmap.icon_daifukuan);
                    rlButton.setVisibility(View.VISIBLE);
                    cancelbtn.setVisibility(View.VISIBLE);
                    surebtn.setVisibility(View.VISIBLE);
                    line.setVisibility(View.VISIBLE);

                    surebtn.setText("立即支付");
                    cancelbtn.setText("取消订单");

                    surebtn.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            Intent intent = new Intent(getActivity(), ToPayActivity.class);
                            intent.putExtra("intentType", intentType);
                            intent.putExtra("id", bean.getPid());
                            intent.putExtra("price", bean.getZongjine());
                            getActivity().startActivity(intent);
                        }
                    });
                    cancelbtn.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            createDel("温馨提示", "确认取消订单吗？", "点错了", "确认", id, 7);
                        }
                    });
                    break;
                case 60://待发货
                    ivStatus.setBackgroundResource(R.mipmap.ivon_daifahuo);
                    rlButton.setVisibility(View.GONE);
                    line.setVisibility(View.GONE);
                    break;
                case 70://待收货
                    ivStatus.setBackgroundResource(R.mipmap.icon_daishouhuo);
                    cancelbtn.setVisibility(View.VISIBLE);
                    surebtn.setVisibility(View.VISIBLE);
                    rlButton.setVisibility(View.VISIBLE);
                    line.setVisibility(View.VISIBLE);

                    surebtn.setText("确认收货");
                    cancelbtn.setText("查看物流");

                    surebtn.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            //确认收货
                            createDel("温馨提示", "确认该订单已收货？", "点错了", "确认", id, 8);
                        }
                    });
                    cancelbtn.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            //查看物流
                            Intent intent = new Intent(getActivity(), ViewWuLiuActivity.class);
                            intent.putExtra("order_id", id);
                            getActivity().startActivity(intent);
                        }
                    });
                    break;
                case 80://交易成功 未评价
                    ivStatus.setBackgroundResource(R.mipmap.icon_jiaoyichenggong);
                    cancelbtn.setVisibility(View.VISIBLE);
                    surebtn.setVisibility(View.VISIBLE);
                    rlButton.setVisibility(View.VISIBLE);
                    line.setVisibility(View.VISIBLE);

                    surebtn.setText("立即评价");
                    cancelbtn.setText("查看物流");

                    surebtn.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            //立即评价
                            //跳转评价activity
                            Intent intent = new Intent(getActivity(), PingjiaAdapterActivity.class);
                            intent.putExtra("intentType", intentType);
                            intent.putExtra("order_id", id);
                            getActivity().startActivity(intent);
                        }
                    });
                    cancelbtn.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            //查看物流
                            Intent intent = new Intent(getActivity(), ViewWuLiuActivity.class);
                            intent.putExtra("order_id", id);
                            getActivity().startActivity(intent);
                        }
                    });
                    break;
                case 90://交易成功 已评价
                    ivStatus.setBackgroundResource(R.mipmap.icon_jiaoyichenggong);
                    cancelbtn.setVisibility(View.VISIBLE);
                    surebtn.setVisibility(View.VISIBLE);
                    rlButton.setVisibility(View.VISIBLE);
                    line.setVisibility(View.VISIBLE);

                    cancelbtn.setText("查看物流");

                    cancelbtn.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            //查看物流
                            Intent intent = new Intent(getActivity(), ViewWuLiuActivity.class);
                            intent.putExtra("order_id", id);
                            getActivity().startActivity(intent);
                        }
                    });
                    break;
                case 20://交易关闭
                    ivStatus.setBackgroundResource(R.mipmap.icon_jiaoyiguanbi);
                    rlButton.setVisibility(View.GONE);
                    line.setVisibility(View.GONE);
                    break;
            }

            tvName.setText(bean.getSeller_info().getNickname() + "");
            tvPeice.setText("￥" + bean.getZongjine());
            tvTruePrice.setText("￥" + bean.getShifukuan());
            tv_goods_num.setText("共" + bean.getZquantity() + "件商品");

            LinearLayoutManager manager = new LinearLayoutManager(getActivity()) {
                @Override
                public boolean canScrollVertically() {
                    return false;
                }
            };
            recyclerView.setLayoutManager(manager);
            GoodsAdapter goodsAdapter = new GoodsAdapter();
            recyclerView.setAdapter(goodsAdapter);
            goodsAdapter.setList(bean.getGoods());
        }

        public class GoodsAdapter extends RecyclerView.Adapter<GoodsAdapter.VH> {
            private List<MallOrderListBean.DataBean.GoodsBean> list;

            public void setList(List<MallOrderListBean.DataBean.GoodsBean> list) {
                this.list = list;
                notifyDataSetChanged();
            }

            @Override
            public GoodsAdapter.VH onCreateViewHolder(ViewGroup parent, int viewType) {
                View view = LayoutInflater.from(getActivity()).inflate(R.layout.item_sure_item_layout, parent, false);
                return new VH(view);
            }

            @Override
            public void onBindViewHolder(GoodsAdapter.VH vh, int position) {

                GlideLoad.GlideLoadImg2(list.get(position).getGoods_image(), vh.ivImg);
                vh.tvTitle.setText(list.get(position).getGoods_name() + "");
                vh.tvTime.setText(list.get(position).getSpecification() + "");
                vh.tvDanjia.setText(Constans.RMB + list.get(position).getYuandanjia());
                vh.tvDingjin.setVisibility(View.GONE);
                vh.dingjintx.setVisibility(View.GONE);
                vh.tvPayType.setVisibility(View.GONE);
                vh.payyypetext.setVisibility(View.GONE);
                vh.tvNum.setText("" + list.get(position).getQuantity());

                switch (list.get(position).getEvaluation()) {
                    case 10://退款中
                        vh.tvOrderStatus.setVisibility(View.VISIBLE);
                        vh.tvOrderStatus.setText("退款中");
                        break;
                    case 20://已退款
                        vh.tvOrderStatus.setVisibility(View.VISIBLE);
                        vh.tvOrderStatus.setText("退款成功");
                        break;
                    case 30://拒绝退款
                        vh.tvOrderStatus.setVisibility(View.VISIBLE);
                        vh.tvOrderStatus.setText("拒绝退款");
                        break;
                    case 60://提交退货退款
                        vh.tvOrderStatus.setVisibility(View.VISIBLE);
                        vh.tvOrderStatus.setText("退款中");
                        break;
                    case 70://卖家同意退款，买家发货同意
                        vh.tvOrderStatus.setVisibility(View.VISIBLE);
                        vh.tvOrderStatus.setText("退货中");
                        break;
                    case 80://买家发货后商家确认收货
                        vh.tvOrderStatus.setVisibility(View.VISIBLE);
                        vh.tvOrderStatus.setText("退款成功");
                        break;
                    case 90://买家发货后商家拒绝收货
                        vh.tvOrderStatus.setVisibility(View.VISIBLE);
                        vh.tvOrderStatus.setText("拒绝退款");
                        break;
                    default:
                        vh.tvOrderStatus.setVisibility(View.GONE);
                        break;

                }

//                if (list.get(position).getDeductible() != null && !list.get(position).getDeductible().equals("")) {
//                    vh.dikoutext.setVisibility(View.VISIBLE);
//                    vh.tvDiKou.setVisibility(View.VISIBLE);
//
//                    vh.tvDiKou.setText("￥" + list.get(position).getDeductible());
//                } else {
//                    vh.dikoutext.setVisibility(View.GONE);
//                    vh.tvDiKou.setVisibility(View.GONE);
//                }
            }

            @Override
            public int getItemCount() {
                return list == null ? 0 : list.size();
            }

            class VH extends RecyclerView.ViewHolder {
                @BindView(R.id.iv_img)
                ImageView ivImg;
                @BindView(R.id.tv_title)
                TextView tvTitle;
                @BindView(R.id.tv_time)
                TextView tvTime;
                @BindView(R.id.tv_danjia)
                TextView tvDanjia;
                @BindView(R.id.dingjintx)
                TextView dingjintx;
                @BindView(R.id.tv_dingjin)
                TextView tvDingjin;
                @BindView(R.id.tv_dikou)
                TextView tvDiKou;
                @BindView(R.id.dikoutext)
                TextView dikoutext;
                @BindView(R.id.tv_pay_type)
                TextView tvPayType;
                @BindView(R.id.tv_num)
                TextView tvNum;
                @BindView(R.id.tv_order_status)
                TextView tvOrderStatus;
                @BindView(R.id.payyypetext)
                TextView payyypetext;


                VH(View view) {
                    super(view);
                    ButterKnife.bind(this, view);
                    view.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            Intent intent = new Intent(getActivity(), NewOrderDetailsActivity.class);
                            intent.putExtra("intentType", 1);
                            intent.putExtra("type", type);
                            intent.putExtra("order_id", id);
                            startActivity(intent);
                        }
                    });
                }
            }
        }

    }

    //婚庆接单 holder
    class WeddingJieDanItemHolder extends BaseViewHolder<WeddingJieDanOrderList.DataBean> {
//        @BindView(R.id.tv_name)
//        TextView tvName;
        @BindView(R.id.tv_status_tip)
        TextView tvStatusTip;
        @BindView(R.id.iv_img)
        ImageView ivImg;
        @BindView(R.id.tv_title)
        TextView tvTitle;
        @BindView(R.id.tv_time)
        TextView tvTime;
        @BindView(R.id.tv_pay_type)
        TextView tvPayType;
//        @BindView(R.id.line)
//        View line;
        @BindView(R.id.qq)
        TextView qq;
        @BindView(R.id.time)
        TextView time;
        @BindView(R.id.tv_status)
        TextView tvStatus;
        @BindView(R.id.thr_btn)
        TextView thrBtn;
        @BindView(R.id.cancelbtn)
        TextView cancelbtn;
        @BindView(R.id.surebtn)
        TextView surebtn;
        @BindView(R.id.rl_button)
        RelativeLayout rlButton;

        private int type;
        private int id;


        public WeddingJieDanItemHolder(View itemView) {
            super(itemView);
            itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Intent intent = new Intent(getActivity(), NewOrderDetailsActivity.class);
                    intent.putExtra("intentType", 2);
                    intent.putExtra("type", type);
                    intent.putExtra("order_id", id);
                    startActivity(intent);
                }
            });
        }

        @Override
        protected void bindView(final WeddingJieDanOrderList.DataBean bean) {
            id = bean.getOrder_id();
            type = bean.getStatus();

            switch (type) {
                case 10://待付款
//                    ivStatus.setBackgroundResource(R.mipmap.icon_daifukuan);
                    tvStatusTip.setText("待付款");
                    rlButton.setVisibility(View.VISIBLE);
                    cancelbtn.setVisibility(View.GONE);
                    surebtn.setVisibility(View.VISIBLE);
//                    line.setVisibility(View.VISIBLE);

                    surebtn.setText("修改价格");

                    surebtn.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            //修改价格的操作
                            Intent intent = new Intent(getActivity(), EditPriceActivity.class);
                            intent.putExtra("intentType", intentType);
                            intent.putExtra("weddingBean", bean);
                            intent.putExtra("type", 0);
                            getActivity().startActivity(intent);
                        }
                    });
                    break;
                case 60://待接单
//                    ivStatus.setBackgroundResource(R.mipmap.icon_daijiedan);
                    tvStatusTip.setText("待接单");
                    rlButton.setVisibility(View.VISIBLE);
                    cancelbtn.setVisibility(View.VISIBLE);
                    surebtn.setVisibility(View.VISIBLE);
//                    line.setVisibility(View.VISIBLE);

                    surebtn.setText("立即接单");
                    cancelbtn.setText("拒绝接单");

                    surebtn.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            createDel("温馨提示", "确认接单吗？", "点错了", "确认", id, 2);
                        }
                    });
                    cancelbtn.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            createDel("温馨提示", "确认拒绝接单吗？", "点错了", "确认", id, 3);
                        }
                    });
                    break;
                case 70://待服务
//                    ivStatus.setBackgroundResource(R.mipmap.icon_daifuwu);
                    tvStatusTip.setText("待服务");
                    cancelbtn.setVisibility(View.GONE);
                    rlButton.setVisibility(View.VISIBLE);
//                    line.setVisibility(View.VISIBLE);

                    if (bean.getTuihuo() == 1) {
                        surebtn.setVisibility(View.VISIBLE);
                        surebtn.setText("订单完成");
                        surebtn.setOnClickListener(new View.OnClickListener() {
                            @Override
                            public void onClick(View view) {
                                //订单完成操作
//                                if (bean.getPaytype() == 2) {
//                                    createFinishOrderServerDialog(id);
//                                } else {
                                createDel("温馨提示", "确认已完成该订单服务？", "点错了", "确认", id, 4);
                                //}
                            }
                        });
                    } else {
                        surebtn.setVisibility(View.GONE);
                    }


                    break;
                case 80://待评价
//                    ivStatus.setBackgroundResource(R.mipmap.icon_daipingjia);
                    tvStatusTip.setText("待评价");

//                    rlButton.setVisibility(View.GONE);
//                    line.setVisibility(View.GONE);
                    break;
                case 90://交易成功 已评价
//                    ivStatus.setBackgroundResource(R.mipmap.icon_jiaoyichenggong);
                    tvStatusTip.setText("已评价");
//                    rlButton.setVisibility(View.GONE);
//                    line.setVisibility(View.GONE);
                    break;
                case 79://已服务已付尾款
//                    ivStatus.setBackgroundResource(R.mipmap.icon_yifuwu);
                    tvStatusTip.setText("已服务已付尾款");
//                    rlButton.setVisibility(View.GONE);
//                    line.setVisibility(View.GONE);
                    break;
                case 71://已服务未付尾款
//                    ivStatus.setBackgroundResource(R.mipmap.icon_yifuwu);
                    tvStatusTip.setText("已服务未付尾款");
//                    rlButton.setVisibility(View.GONE);
//                    line.setVisibility(View.GONE);
                    break;
                case 20://交易关闭
//                    ivStatus.setBackgroundResource(R.mipmap.icon_jiaoyiguanbi);
                    tvStatusTip.setText("交易关闭");
//                    rlButton.setVisibility(View.GONE);
//                    line.setVisibility(View.GONE);
                    break;
            }

            //标记商品是否处于退款状态
            switch (bean.getTuihuo()) {
                case 1://用户可以申请退款
                    tvStatus.setVisibility(View.GONE);
                    break;
                case 2://2是退款中
                    rlButton.setVisibility(View.VISIBLE);
                    thrBtn.setVisibility(View.VISIBLE);
                    surebtn.setVisibility(View.GONE);
                    cancelbtn.setVisibility(View.VISIBLE);
                    tvStatus.setVisibility(View.VISIBLE);

                    tvStatus.setText("退款中");
                    cancelbtn.setText("同意退款");
                    thrBtn.setText("拒绝退款");

                    cancelbtn.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            createDel("温馨提示", "确认同意该订单的退款请求？", "点错了", "确认", id, 5);
                        }
                    });
                    thrBtn.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            Intent intent = new Intent(getActivity(), RefuseReasonActivity.class);
                            intent.putExtra("order_id", id);
                            getActivity().startActivity(intent);
                        }
                    });
                    break;
                case 3:
                    tvStatus.setVisibility(View.VISIBLE);
                    tvStatus.setText("同意退款");
                    break;
                case 4://4拒绝退款
                    tvStatus.setVisibility(View.VISIBLE);
                    tvStatus.setText("拒绝退款");
                    break;
            }

//            cancelbtn.setVisibility(View.VISIBLE);
//            surebtn.setVisibility(View.GONE);
//            cancelbtn.setText("1234");
//            surebtn.setText("1234");
//            tvName.setText(bean.getSeller_info().getNickname() + "");
            //tvPeice.setText("￥" + bean.getZongjine());
            //tvTruePrice.setText("￥" + bean.getShifukuan());
            tvPayType.setText("￥" + bean.getZongjine());
            GlideLoad.GlideLoadCircle(bean.getBaojia_image(), ivImg);
            tvTitle.setText(bean.getBaojia_name() + "");
            tvTime.setText(bean.getSpecification() + "");
            //tvDanjia.setText(Constans.RMB + bean.getPrice());
            //tvNum.setText("" + bean.getQuantity());


//            switch (bean.getPaytype()) {
//                case 1:
//                    tvDingjin.setVisibility(View.GONE);
//                    dingjintx.setVisibility(View.GONE);
//                    tvPayType.setText("全款");
//                    break;
//                case 2:
//                    tvDingjin.setVisibility(View.VISIBLE);
//                    dingjintx.setVisibility(View.VISIBLE);
//                    tvDingjin.setText(Constans.RMB + bean.getYuandingjin());
//                    tvPayType.setText("定金+尾款");
//                    break;
//                case 3:
//                    tvDingjin.setVisibility(View.VISIBLE);
//                    dingjintx.setVisibility(View.VISIBLE);
//                    tvDingjin.setText(Constans.RMB + bean.getYuandingjin());
//                    tvPayType.setText("定金+线下");
//                    break;
//            }
//            if (bean.getDeductible() != null && !bean.getDeductible().equals("")) {
//                dikoutext.setVisibility(View.VISIBLE);
//                tvDiKou.setText("￥" + bean.getDeductible());
//            } else {
//                dikoutext.setVisibility(View.GONE);
//            }
        }

    }

    //商城接单 holder
    class MallJieDanItemHolder extends BaseViewHolder<MallJieDanOrderList.DataBean> {
        @BindView(R.id.tv_name)
        TextView tvName;
        @BindView(R.id.tv_peice)
        TextView tvPeice;
        @BindView(R.id.tv_true_price)
        TextView tvTruePrice;
        @BindView(R.id.time)
        TextView time;
        @BindView(R.id.cancelbtn)
        TextView cancelbtn;
        @BindView(R.id.surebtn)
        TextView surebtn;
        @BindView(R.id.iv_status)
        ImageView ivStatus;
        @BindView(R.id.rl_button)
        RelativeLayout rlButton;
        @BindView(R.id.line)
        View line;
        @BindView(R.id.recycleview)
        RecyclerView recyclerView;
        @BindView(R.id.tv_goods_num)
        TextView tv_goods_num;

        private int type;
        private int id;


        public MallJieDanItemHolder(View itemView) {
            super(itemView);
            itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Intent intent = new Intent(getActivity(), NewOrderDetailsActivity.class);
                    intent.putExtra("intentType", 3);
                    intent.putExtra("type", type);
                    intent.putExtra("order_id", id);
                    startActivity(intent);
                }
            });
        }

        @Override
        protected void bindView(final MallJieDanOrderList.DataBean bean) {
            id = bean.getOrder_id();
            type = bean.getStatus();

            switch (type) {
                case 10://待付款
                    ivStatus.setBackgroundResource(R.mipmap.icon_daifukuan);
                    rlButton.setVisibility(View.VISIBLE);
                    cancelbtn.setVisibility(View.GONE);
                    surebtn.setVisibility(View.VISIBLE);
                    line.setVisibility(View.VISIBLE);

                    surebtn.setText("修改价格");

                    surebtn.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            //修改价格的操作
                            Intent intent = new Intent(getActivity(), EditPriceActivity.class);
                            intent.putParcelableArrayListExtra("bean", (ArrayList<MallJieDanOrderList.DataBean.GoodsBean>) bean.getGoods());
                            intent.putExtra("order_id", id);
                            intent.putExtra("intentType", intentType);
                            intent.putExtra("type", 0);
                            getActivity().startActivity(intent);
                        }
                    });
                    break;
                case 60://待发货
                    ivStatus.setBackgroundResource(R.mipmap.ivon_daifahuo);
                    rlButton.setVisibility(View.VISIBLE);
                    cancelbtn.setVisibility(View.GONE);
                    surebtn.setVisibility(View.VISIBLE);
                    line.setVisibility(View.VISIBLE);

                    surebtn.setText("立即发货");

                    surebtn.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            //立即发货
                            Intent intent = new Intent(getActivity(), EditWuLiuMsgActivity.class);
                            intent.putExtra("order_id", id);
                            getActivity().startActivity(intent);
                        }
                    });
                    break;
                case 70://待收货
                    ivStatus.setBackgroundResource(R.mipmap.icon_daishouhuo);
                    cancelbtn.setVisibility(View.GONE);
                    surebtn.setVisibility(View.VISIBLE);
                    rlButton.setVisibility(View.VISIBLE);
                    line.setVisibility(View.VISIBLE);

                    surebtn.setText("查看物流");

                    surebtn.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            Intent intent = new Intent(getActivity(), ViewWuLiuActivity.class);
                            intent.putExtra("order_id", id);
                            getActivity().startActivity(intent);
                        }
                    });
                    break;
                case 80://交易成功 未评价
                    ivStatus.setBackgroundResource(R.mipmap.icon_jiaoyichenggong);
                    rlButton.setVisibility(View.VISIBLE);
                    surebtn.setVisibility(View.VISIBLE);
                    cancelbtn.setVisibility(View.GONE);
                    line.setVisibility(View.VISIBLE);

                    surebtn.setText("查看物流");

                    surebtn.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            Intent intent = new Intent(getActivity(), ViewWuLiuActivity.class);
                            intent.putExtra("order_id", id);
                            getActivity().startActivity(intent);
                        }
                    });
                    break;
                case 90://交易成功 已评价
                    ivStatus.setBackgroundResource(R.mipmap.icon_jiaoyichenggong);
                    rlButton.setVisibility(View.VISIBLE);
                    surebtn.setVisibility(View.VISIBLE);
                    cancelbtn.setVisibility(View.GONE);
                    line.setVisibility(View.VISIBLE);

                    surebtn.setText("查看物流");

                    surebtn.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            Intent intent = new Intent(getActivity(), ViewWuLiuActivity.class);
                            intent.putExtra("order_id", id);
                            getActivity().startActivity(intent);
                        }
                    });
                    break;
                case 20://交易关闭
                    ivStatus.setBackgroundResource(R.mipmap.icon_jiaoyiguanbi);
                    rlButton.setVisibility(View.GONE);
                    line.setVisibility(View.GONE);
                    break;
            }

            tvName.setText(bean.getSeller_info().getNickname() + "");
            Drawable drawableLeft = getResources().getDrawable(
                    R.mipmap.icon_login);
            tvName.setCompoundDrawablesWithIntrinsicBounds(drawableLeft,
                    null, null, null);
            tvName.setCompoundDrawablePadding(16);

            tvPeice.setText("￥" + bean.getZongjine());
            tvTruePrice.setText("￥" + bean.getShifukuan());
            tv_goods_num.setText("共" + bean.getZquantity() + "件商品");

            LinearLayoutManager manager = new LinearLayoutManager(getActivity()) {
                @Override
                public boolean canScrollVertically() {
                    return false;
                }
            };
            recyclerView.setLayoutManager(manager);
            GoodsAdapter goodsAdapter = new GoodsAdapter();
            recyclerView.setAdapter(goodsAdapter);
            goodsAdapter.setList(bean.getGoods());
        }

        public class GoodsAdapter extends RecyclerView.Adapter<GoodsAdapter.VH> {
            private List<MallJieDanOrderList.DataBean.GoodsBean> list;

            public void setList(List<MallJieDanOrderList.DataBean.GoodsBean> list) {
                this.list = list;
                notifyDataSetChanged();
            }

            @Override
            public GoodsAdapter.VH onCreateViewHolder(ViewGroup parent, int viewType) {
                View view = LayoutInflater.from(getActivity()).inflate(R.layout.item_sure_item_layout, parent, false);
                return new VH(view);
            }

            @Override
            public void onBindViewHolder(GoodsAdapter.VH vh, int position) {

                GlideLoad.GlideLoadImg2(list.get(position).getGoods_image(), vh.ivImg);
                vh.tvTitle.setText(list.get(position).getGoods_name() + "");
                vh.tvTime.setText(list.get(position).getSpecification() + "");
                vh.tvDanjia.setText(Constans.RMB + list.get(position).getYuandanjia());
                vh.tvDingjin.setVisibility(View.GONE);
                vh.dingjintx.setVisibility(View.GONE);
                vh.tvPayType.setVisibility(View.GONE);
                vh.tvNum.setText("" + list.get(position).getQuantity());
                vh.payyypetext.setVisibility(View.GONE);

                switch (list.get(position).getEvaluation()) {
                    case 10://退款中
                        vh.tvOrderStatus.setVisibility(View.VISIBLE);
                        vh.tvOrderStatus.setText("退款中");
                        break;
                    case 20://已退款
                        vh.tvOrderStatus.setVisibility(View.VISIBLE);
                        vh.tvOrderStatus.setText("退款成功");
                        break;
                    case 30://拒绝退款
                        vh.tvOrderStatus.setVisibility(View.VISIBLE);
                        vh.tvOrderStatus.setText("拒绝退款");
                        break;
                    case 60://提交退货退款
                        vh.tvOrderStatus.setVisibility(View.VISIBLE);
                        vh.tvOrderStatus.setText("退款中");
                        break;
                    case 70://卖家同意退款，买家发货同意
                        vh.tvOrderStatus.setVisibility(View.VISIBLE);
                        vh.tvOrderStatus.setText("退货中");
                        break;
                    case 80://买家发货后商家确认收货
                        vh.tvOrderStatus.setVisibility(View.VISIBLE);
                        vh.tvOrderStatus.setText("退款成功");
                        break;
                    case 90://买家发货后商家拒绝收货
                        vh.tvOrderStatus.setVisibility(View.VISIBLE);
                        vh.tvOrderStatus.setText("拒绝退款");
                        break;
                    default:
                        vh.tvOrderStatus.setVisibility(View.GONE);
                        break;

                }

//                if (list.get(position).getDeductible() != null && !list.get(position).getDeductible().equals("")) {
//                    vh.dikoutext.setVisibility(View.VISIBLE);
//                    vh.tvDiKou.setVisibility(View.VISIBLE);
//
//                    vh.tvDiKou.setText("￥" + list.get(position).getDeductible());
//                } else {
//                    vh.dikoutext.setVisibility(View.GONE);
//                    vh.tvDiKou.setVisibility(View.GONE);
//                }
            }

            @Override
            public int getItemCount() {
                return list == null ? 0 : list.size();
            }

            class VH extends RecyclerView.ViewHolder {
                @BindView(R.id.iv_img)
                ImageView ivImg;
                @BindView(R.id.tv_title)
                TextView tvTitle;
                @BindView(R.id.tv_time)
                TextView tvTime;
                @BindView(R.id.tv_danjia)
                TextView tvDanjia;
                @BindView(R.id.dingjintx)
                TextView dingjintx;
                @BindView(R.id.tv_dingjin)
                TextView tvDingjin;
                @BindView(R.id.tv_dikou)
                TextView tvDiKou;
                @BindView(R.id.dikoutext)
                TextView dikoutext;
                @BindView(R.id.tv_pay_type)
                TextView tvPayType;
                @BindView(R.id.tv_num)
                TextView tvNum;
                @BindView(R.id.tv_order_status)
                TextView tvOrderStatus;
                @BindView(R.id.payyypetext)
                TextView payyypetext;

                VH(View view) {
                    super(view);
                    ButterKnife.bind(this, view);
                    view.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            Intent intent = new Intent(getActivity(), NewOrderDetailsActivity.class);
                            intent.putExtra("intentType", 3);
                            intent.putExtra("type", type);
                            intent.putExtra("order_id", id);
                            startActivity(intent);
                        }
                    });
                }
            }
        }

    }

    //婚庆订单adapter
    private BaseAdapter createWeddingAdapter(WeddingOrderListBean bean) {
        BaseAdapter baseAdapter = BaseAdapter.createBaseAdapter();
        baseAdapter.injectHolderDelegate(weddingDelegate.cleanAfterAddAllData(bean.getData()));
        baseAdapter.setLayoutManager(recycle);
        return baseAdapter;
    }

    //商城订单adapter
    private BaseAdapter createMallAdapter(MallOrderListBean bean) {
        BaseAdapter baseAdapter = BaseAdapter.createBaseAdapter();
        baseAdapter.injectHolderDelegate(mallDelegate.cleanAfterAddAllData(bean.getData()));
        baseAdapter.setLayoutManager(recycle);
        return baseAdapter;
    }

    //婚庆接单adapter
    private BaseAdapter createWeddingJieDanAdapter(WeddingJieDanOrderList bean) {
        BaseAdapter baseAdapter = BaseAdapter.createBaseAdapter();
        baseAdapter.injectHolderDelegate(weddingJieDanDelegate.cleanAfterAddAllData(bean.getData()));
        baseAdapter.setLayoutManager(recycle);
        return baseAdapter;
    }

    //商城接单adapter
    private BaseAdapter createMallJieDanAdapter(MallJieDanOrderList bean) {
        BaseAdapter baseAdapter = BaseAdapter.createBaseAdapter();
        baseAdapter.injectHolderDelegate(mallJieDanDelegate.cleanAfterAddAllData(bean.getData()));
        baseAdapter.setLayoutManager(recycle);
        return baseAdapter;
    }

    //创建不同的适配器
    private void afterView() {
        switch (intentType) {
            case 0:
                mAdapter = createWeddingAdapter(mWeddingOrderListBean);
                break;
            case 1:
                mAdapter = createMallAdapter(mMallOrderListBean);
                break;
            case 2:
                mAdapter = createWeddingJieDanAdapter(mWeddingJieDanOrderList);
                break;
            case 3:
                mAdapter = createMallJieDanAdapter(mMallJieDanOrderList);
                break;
        }
        recycle.setAdapter(mAdapter);
    }

    //控制公用的请求参数 page status
    private void ctrlPublicParms(boolean isLoadMore) {
        if (isLoadMore) {
            page++;
        } else {
            page = 1;
        }
        if (type.equals("-1")) {
            type = "";
        }
    }

    //关闭刷新加载View
    private void closeLoadingDialog(boolean isLoadMore) {
        if (isLoadMore) {
            refreshLayout.finishLoadMore();
        } else {
            refreshLayout.finishRefresh();
        }
    }

    //请求无数据 为adapter添加没有更多数据Holder 是否能加载更多
    private void addNoDataView(boolean isLoadMore) {
        if (isLoadMore) {
            isCanLoadMore = false;
            page--;
            mAdapter.injectHolderDelegate(new CreateHolderDelegate<String>() {

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
            }.addData(""));//分割线View
            mAdapter.notifyDataSetChanged();
        } else {
            isCanLoadMore = true;
            noData.setVisibility(View.VISIBLE);
        }
    }

    //婚庆订单dialog   type: 0:取消订单 1:确认完成服务 2:确认接单 3:拒绝接单 4:接单 完成服务 5:同意退款  7:取消商城订单 8:商城用户确认收货
    private void createDel(String title, String content, String canleNam, String sureName, final int id, final int type) {
        final AskDialog dialog = new AskDialog(getActivity(), getActivity());
        dialog.setTitle(title);
        dialog.setMessage(content);
        dialog.setCancleListener(canleNam, new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dialog.dismiss();
            }
        });
        dialog.setSubmitListener(sureName, new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                switch (type) {
                    case 0:
                        cancelWeddingOrder(id);
                        break;
                    case 1:
                        sureFinishWeddingOrder(id);
                        break;
                    case 2:
                        sureAcceptWeddingOrder(id);
                        break;
                    case 3:
                        refusedWeddingOrder(id);
                        break;
                    case 4:
                        finishWeddingOrder(id);
                        break;
                    case 5:
                        agreedWeddingTuiKuan(id);
                        break;
                    case 7:
                        cancelMallOrder(id);
                        break;
                    case 8:
                        sureGetGoods(id);
                        break;
                }

                dialog.dismiss();
            }
        });
        dialog.show();
    }

    //提醒dialog
    private void createDel(String title, String content, String canleNam, String sureName, final String pid, final int order_id, final String price) {
        final AskDialog dialog = new AskDialog(getActivity(), getActivity());
        dialog.setTitle(title);
        dialog.setMessage(content);
        dialog.setCancleListener(canleNam, new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dialog.dismiss();
            }
        });
        dialog.setSubmitListener(sureName, new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                //支付
                dialog.dismiss();

                GetPayPop getPayPop = new GetPayPop(getActivity(), new GetPayPop.GetPriceCallBack() {
                    @Override
                    public void onResult(String price) {
                        Intent intent = new Intent(getActivity(), ToPayActivity.class);
                        intent.putExtra("order_id", order_id);
                        intent.putExtra("id", pid);
                        intent.putExtra("intentType", intentType);
                        intent.putExtra("price", price);
                        intent.putExtra("isWeiKuan", true);
                        getActivity().startActivity(intent);
                    }
                }, price);
                getPayPop.show();
            }
        });
        dialog.show();
    }

    //取消婚庆订单
    private void cancelWeddingOrder(int id) {
        LoadDialog.showDialog(getActivity());
        ApiManager.cancelWeddingOrder(id, new OnRequestFinish<BaseBean>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean data) {
                NToast.show(data.getMessage());
                refreshLayout.autoRefresh();
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
            }
        });
    }

    //确认完成婚庆订单服务
    private void sureFinishWeddingOrder(int id) {
        LoadDialog.showDialog(getActivity());
        ApiManager.finishWeddingOrder(id, new OnRequestFinish<BaseBean>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean data) {
                NToast.show(data.getMessage());
                refreshLayout.autoRefresh();
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
            }
        });
    }

    //确认接单
    private void sureAcceptWeddingOrder(int id) {
        LoadDialog.showDialog(getActivity());
        ApiManager.agreeWeddingOrder(id, new OnRequestFinish<BaseBean>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean data) {
                NToast.show(data.getMessage());
                refreshLayout.autoRefresh();
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
            }
        });
    }

    //拒绝接单
    private void refusedWeddingOrder(int id) {
        LoadDialog.showDialog(getActivity());
        ApiManager.refusedWeddingOrder(id, new OnRequestFinish<BaseBean>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean data) {
                NToast.show(data.getMessage());
                refreshLayout.autoRefresh();
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
            }
        });
    }

    //婚庆定单线下支付
    private void weedingUserUserUnderLine(int id) {
        LoadDialog.showDialog(getActivity());
        ApiManager.weedingUserUserUnderLine(id, new OnRequestFinish<BaseBean>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean data) {
                NToast.show(data.getMessage());
                refreshLayout.autoRefresh();
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
            }
        });
    }

    //婚庆定单完成服务
    private void finishWeddingOrder(int id) {
        LoadDialog.showDialog(getActivity());
        ApiManager.finishWeddingOrderShop(id, new OnRequestFinish<BaseBean>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean data) {
                NToast.show(data.getMessage());
                refreshLayout.autoRefresh();
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
            }
        });
    }

    //婚庆接单单完成服务
    private void finishWeddingOrderByUser(int id) {
        LoadDialog.showDialog(getActivity());
        ApiManager.finishWeddingOrderShop(id, new OnRequestFinish<BaseBean>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean data) {
                NToast.show(data.getMessage());
                refreshLayout.autoRefresh();
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
            }
        });
    }

    //婚庆接单完成服务dialog
    private void createFinishOrderServerDialog(final int id, final String pid, final String price) {
        final ChoosePayDialog choosePayDialog = new ChoosePayDialog(getActivity(), getActivity());
        choosePayDialog.setCancleListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                choosePayDialog.dismiss();
            }
        });
        choosePayDialog.setSubmitListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (choosePayDialog.getClickButtonIndex() == 0) {
                    GetPayPop getPayPop = new GetPayPop(getActivity(), new GetPayPop.GetPriceCallBack() {
                        @Override
                        public void onResult(String price) {
                            Intent intent = new Intent(getActivity(), ToPayActivity.class);
                            intent.putExtra("intentType", intentType);
                            intent.putExtra("id", pid);
                            intent.putExtra("price", price);
                            intent.putExtra("isWeiKuan", true);
                            intent.putExtra("order_id", id);
                            getActivity().startActivity(intent);
                        }
                    }, price);
                    getPayPop.show();
                } else {
                    weedingUserUserUnderLine(id);
                }
                choosePayDialog.dismiss();


            }
        });
        choosePayDialog.show();
    }

    //同意退款
    private void agreedWeddingTuiKuan(int id) {
        LoadDialog.showDialog(getActivity());
        ApiManager.agreeWeddingOrderTuiKuan(id, new OnRequestFinish<BaseBean>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean data) {
                NToast.show(data.getMessage());
                refreshLayout.autoRefresh();
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
            }
        });
    }

    //取消商城订单
    private void cancelMallOrder(int id) {
        LoadDialog.showDialog(getActivity());
        ApiManager.canelMallOrder(id, new OnRequestFinish<BaseBean>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean data) {
                NToast.show(data.getMessage());
                refreshLayout.autoRefresh();
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
            }
        });
    }

    //确认收货
    private void sureGetGoods(int id) {
        LoadDialog.showDialog(getActivity());
        ApiManager.sureGetMallGoods(id, new OnRequestFinish<BaseBean>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean data) {
                NToast.show(data.getMessage());
                refreshLayout.autoRefresh();
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
            }
        });
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
         
    }

    public void refreshView() {
        if (!isInitView) {
            initView();
        }
        refreshLayout.autoRefresh();
    }
}
