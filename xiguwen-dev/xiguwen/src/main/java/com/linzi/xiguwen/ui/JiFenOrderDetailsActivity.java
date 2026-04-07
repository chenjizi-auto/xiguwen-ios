package com.linzi.xiguwen.ui;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;
import android.view.View;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.base.adapter.BaseAdapter;
import com.linzi.xiguwen.base.adapter.BaseViewHolder;
import com.linzi.xiguwen.base.adapter.CreateHolderDelegate;
import com.linzi.xiguwen.bean.JiFenOrderDetailsBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.TimeUtils;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;
import com.linzi.xiguwen.view.AskDialog;
import com.linzi.xiguwen.view.MyRefreshHeader;
import com.scwang.smartrefresh.layout.SmartRefreshLayout;
import com.scwang.smartrefresh.layout.api.RefreshLayout;
import com.scwang.smartrefresh.layout.listener.OnRefreshListener;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by pc on 2018/5/28.
 */

public class JiFenOrderDetailsActivity extends BaseActivity {
    @BindView(R.id.recycleview)
    RecyclerView recycleview;
    @BindView(R.id.refresh_layout)
    SmartRefreshLayout refreshLayout;
    @BindView(R.id.order_bt_1)
    TextView orderBt1;
    @BindView(R.id.order_bt_2)
    TextView orderBt2;
    @BindView(R.id.order_bt_3)
    TextView orderBt3;
    @BindView(R.id.bottombar)
    RelativeLayout bottombar;

    private int id;
    private int type;//0商品兑换 1红包兑换

    private BaseAdapter baseAdapter;

    private boolean isShowTime;//是否显示倒计时
    private String title;
    private int time;//倒计时
    private Handler mHandler;//控制倒计时


    private JiFenOrderDetailsBean jiFenOrderDetailsBean;

    @Override
    protected void initData() {

    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.jifen_order_details_layout);
        ButterKnife.bind(this);
        initView();
    }

    private void initView() {
        setBack();
        setTitle("订单详情");

        if (type == -1) {
            exitWithParm();
        } else {
            refreshLayout.autoRefresh();
        }

        refreshLayout.setRefreshHeader(new MyRefreshHeader(mContext));
        refreshLayout.setEnableLoadMore(false);

        refreshLayout.setOnRefreshListener(new OnRefreshListener() {
            @Override
            public void onRefresh(@NonNull RefreshLayout refreshLayout) {
                if (type == 0) {
                    getGoodsData();
                } else {
                    getHongBaoData();
                }
            }
        });

        id = getIntent().getIntExtra("id", -1);
        type = getIntent().getIntExtra("type", -1);
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
         
    }

    //传递参数异常退出
    private void exitWithParm() {
        finish();
        NToast.show("跳转失败，请重试！");
    }

    //商品订单详情
    private void getGoodsData() {
        if (id != -1) {
            ApiManager.getJiFenOrderDetails(id, new OnRequestFinish<BaseBean<JiFenOrderDetailsBean>>() {
                @Override
                public void onFinished() {
                    refreshLayout.finishRefresh();
                }

                @Override
                public void onSuccess(BaseBean<JiFenOrderDetailsBean> data) {
                    jiFenOrderDetailsBean = data.getData();
                    id = jiFenOrderDetailsBean.getData().getId();
                    ctrlViewByType(jiFenOrderDetailsBean.getData().getStatus(), id);
                    baseAdapter = BaseAdapter.createBaseAdapter();
                    baseAdapter.injectHolderDelegate(new CreateHolderDelegate<String>() {

                        @Override
                        protected int onSpanSize() {
                            return 2;
                        }

                        @Override
                        protected int getLayoutRes() {
                            return R.layout.new_order_details_head;
                        }

                        @Override
                        protected BaseViewHolder onCreateHolder(View itemView) {
                            return new HeadTitleHolder(itemView);
                        }
                    }.cleanAfterAddData(title))
                            .injectHolderDelegate(new CreateHolderDelegate<JiFenOrderDetailsBean.DataBean>() {
                                @Override
                                protected int onSpanSize() {
                                    return 2;
                                }

                                @Override
                                protected int getLayoutRes() {
                                    return R.layout.jifen_order_details_item;
                                }

                                @Override
                                protected BaseViewHolder onCreateHolder(View itemView) {
                                    return new ItemHolder(itemView);
                                }
                            }.cleanAfterAddData(jiFenOrderDetailsBean.getData()))
                            .injectHolderDelegate(new TitleDelegate().addData(R.mipmap.icon_guess_love))
                            .injectHolderDelegate(new CreateHolderDelegate<JiFenOrderDetailsBean.YoulikeBean>() {

                                @Override
                                protected int onSpanSize() {
                                    return 1;
                                }

                                @Override
                                protected int getLayoutRes() {
                                    return R.layout.item_mall_index_works_layout;
                                }

                                @Override
                                protected BaseViewHolder onCreateHolder(View itemView) {
                                    return new WeddingGuessYouLikeHolder(itemView);
                                }
                            }.cleanAfterAddAllData(jiFenOrderDetailsBean.getYoulike()))
                    ;
                    baseAdapter.setLayoutManager(recycleview);
                    recycleview.setAdapter(baseAdapter);
                }

                @Override
                public void onError(Exception ex) {

                }
            });
        } else {
            exitWithParm();
        }
    }

    //红包订单详情
    private void getHongBaoData() {

    }

    private void ctrlViewByType(int status, final int id) {
        switch (status) {//1待付款2待发货3待收货4交易成功5交易关闭
            case 1:
                title = "等待买家付款";
                isShowTime = true;
                if (jiFenOrderDetailsBean != null) {
                    time = jiFenOrderDetailsBean.getData().getFukuantime();
                }
                bottombar.setVisibility(View.VISIBLE);
                orderBt1.setText("立即支付");
                orderBt2.setText("取消订单");
                orderBt3.setVisibility(View.GONE);

                orderBt1.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        Intent intent = new Intent(mContext, ToPayActivity.class);
                        intent.putExtra("intentType", 6);
                        intent.putExtra("id", jiFenOrderDetailsBean.getData().getOrder_sn());
                        intent.putExtra("price", jiFenOrderDetailsBean.getData().getJine());
                        mContext.startActivity(intent);
                    }
                });
                orderBt2.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        createDel("温馨提示", "确认取消订单吗？", "点错了", "确认", id, 0);
                    }
                });

                break;
            case 2:
                isShowTime = false;
                title = "等待商家发货";
                bottombar.setVisibility(View.GONE);
                break;
            case 3:
                isShowTime = false;
                title = "等待收货";
                bottombar.setVisibility(View.VISIBLE);
                orderBt3.setVisibility(View.GONE);
                orderBt1.setText("确认收货");
                orderBt2.setText("查看物流");

                orderBt1.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        //确认收货
                        createDel("温馨提示", "确认该订单已收货？", "点错了", "确认", id, 1);
                    }
                });

                orderBt2.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        //查看物流
                        Intent intent = new Intent(mContext, ViewWuLiuActivity.class);
                        intent.putExtra("isJiFenMall",true);
                        intent.putExtra("order_id", id);
                        mContext.startActivity(intent);
                    }
                });
                break;
            case 4:
                title = "交易成功";
                isShowTime = false;
                bottombar.setVisibility(View.VISIBLE);
                orderBt1.setText("查看物流");
                orderBt2.setVisibility(View.GONE);
                orderBt3.setVisibility(View.GONE);

                orderBt1.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        Intent intent = new Intent(mContext, ViewWuLiuActivity.class);
                        intent.putExtra("isJiFenMall",true);
                        intent.putExtra("order_id", id);
                        mContext.startActivity(intent);
                    }
                });
                break;
            case 5:
                title = "交易关闭";
                isShowTime = false;
                bottombar.setVisibility(View.GONE);
                break;
        }
    }

    class HeadTitleHolder extends BaseViewHolder<String> {
        @BindView(R.id.tv_status)
        TextView tvStatus;
        @BindView(R.id.tv_time)
        TextView tvTime;

        public HeadTitleHolder(View itemView) {
            super(itemView);
        }

        @Override
        protected void bindView(String s) {
            tvStatus.setText(s + "");
            if (isShowTime) {
                if (mHandler != null) {
                    mHandler.removeCallbacksAndMessages(null);
                }
                mHandler = TimeUtils.getReturnTime(time, tvTime);
            } else {
                tvTime.setVisibility(View.GONE);
            }
        }
    }

    //商城订单address holder
    class AdddressHolder extends BaseViewHolder<JiFenOrderDetailsBean.DataBean> {
        @BindView(R.id.tv_get_name)
        TextView tv_get_name;
        @BindView(R.id.tv_address)
        TextView tv_address;
        @BindView(R.id.tv_phone)
        TextView tv_phone;

        public AdddressHolder(View itemView) {
            super(itemView);
        }

        @Override
        protected void bindView(JiFenOrderDetailsBean.DataBean dataBean) {
            tv_phone.setText(dataBean.getPostmobile() + "");
            tv_address.setText(dataBean.getPostaddress());
            tv_get_name.setText(dataBean.getPostname());
        }
    }

    //婚庆订单 item holder
    class ItemHolder extends BaseViewHolder<JiFenOrderDetailsBean.DataBean> {
        @BindView(R.id.tv_name)
        TextView tvName;
        @BindView(R.id.iv_img)
        ImageView ivImg;
        @BindView(R.id.tv_title)
        TextView tvTitle;
        @BindView(R.id.tv_time)
        TextView tvTime;
        @BindView(R.id.tv_order_status)
        TextView tvOrderStatus;
        @BindView(R.id.tv_num)
        TextView tvNum;
        @BindView(R.id.tv_tuikuanbtn)
        TextView tvTuikuanbtn;
        @BindView(R.id.tv_goods_num)
        TextView tvGoodsNum;
        @BindView(R.id.ll_tongji)
        RelativeLayout llTongji;
        @BindView(R.id.tv_order_id)
        TextView tvOrderId;
        @BindView(R.id.tv_order_time)
        TextView tvOrderTime;
        @BindView(R.id.true_money)
        TextView true_money;

        public ItemHolder(View itemView) {
            super(itemView);
        }

        @Override
        protected void bindView(JiFenOrderDetailsBean.DataBean bean) {
            tvName.setText("喜顾问");
            GlideLoad.GlideLoadImg2(bean.getShop_tupian(), ivImg);
            tvTitle.setText(bean.getShop_name() + "");
            if (bean.getJine() != null && !bean.getJine().equals("0") && !bean.getJine().equals("0.00")) {
                tvTime.setText(bean.getJifen() + "积分+" + bean.getJine() + "元");
            } else {
                tvTime.setText(bean.getJifen() + "积分");
            }

            tvNum.setText("" + 1);
            true_money.setText("￥" + bean.getPaidmoney());
            tvOrderId.setText("订单编号：" + bean.getOrder_sn());
            tvOrderTime.setText("下单时间：" + bean.getPaixiashijian());
        }

    }

    //为你推荐title Holder
    class TiltleHolder extends BaseViewHolder<Integer> {
        @BindView(R.id.iv_title)
        ImageView tiltle;

        public TiltleHolder(View itemView) {
            super(itemView);
        }

        @Override
        protected void bindView(Integer s) {
            itemView.setBackgroundColor(getResources().getColor(R.color.f0f0f0));
            tiltle.setBackgroundResource(s.intValue());
        }
    }

    //为你推荐title Delegate
    class TitleDelegate extends CreateHolderDelegate<Integer> {
        @Override
        protected int onSpanSize() {
            return 2;
        }

        @Override
        protected int getLayoutRes() {
            return R.layout.new_mall_title_layout;
        }

        @Override
        protected BaseViewHolder onCreateHolder(View itemView) {
            return new TiltleHolder(itemView);
        }
    }

    //订单 猜你喜欢 Holder
    class WeddingGuessYouLikeHolder extends BaseViewHolder<JiFenOrderDetailsBean.YoulikeBean> {
        @BindView(R.id.iv_img)
        ImageView ivImg;
        @BindView(R.id.tv_title)
        TextView tvTitle;
        @BindView(R.id.tv_context)
        TextView tvContext;
        @BindView(R.id.tv_price)
        TextView tvPrice;
        @BindView(R.id.tv_sale_count)
        TextView tvSaleCount;
        @BindView(R.id.tv_see_count)
        TextView tvSeeCount;
        private int id;//报价id

        public WeddingGuessYouLikeHolder(View itemView) {
            super(itemView);
            itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Intent intent = new Intent(mContext, JiFenGoodsDetailActivity.class);
                    intent.putExtra("goods_id", id);
                    intent.putExtra("type", type);
                    mContext.startActivity(intent);
                }
            });
        }

        @Override
        protected void bindView(JiFenOrderDetailsBean.YoulikeBean baojiaBean) {
            id = baojiaBean.getId();
            tvContext.setVisibility(View.GONE);
            tvSaleCount.setVisibility(View.VISIBLE);
            tvSeeCount.setVisibility(View.GONE);
            tvSaleCount.setText("已兑 " + baojiaBean.getYiduinum());

            if (baojiaBean.getJiage() != null && !baojiaBean.getJiage().equals("") && !baojiaBean.getJiage().equals("0") && !baojiaBean.getJiage().equals("0.00")) {
                tvPrice.setText(baojiaBean.getJifen() + "积分+" + baojiaBean.getJiage() + "元");
            } else {
                tvPrice.setText(baojiaBean.getJifen() + "积分");
            }
            tvTitle.setText("" + baojiaBean.getName());
            GlideLoad.GlideLoadImg2(baojiaBean.getTupian(), ivImg);
        }
    }

    //订单dialog   type: 0:取消订单 1:确认收货
    private void createDel(String title, String content, String canleNam, String sureName, final int id, final int type) {
        final AskDialog dialog = new AskDialog(mContext, JiFenOrderDetailsActivity.this);
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
                        sureGet(id);
                        break;
                }

                dialog.dismiss();
            }
        });
        dialog.show();
    }

    //取消订单
    private void cancelWeddingOrder(int id) {
        LoadDialog.showDialog(mContext);
        ApiManager.canalJiFenOrder(id, new OnRequestFinish<BaseBean>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean data) {
                NToast.show(data.getMessage());
                refreshLayout.autoRefresh();
                EventBusUtil.sendEvent(new Event(EventCode.REFRESH_JIFEN_ORDER_LIST));
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
            }
        });
    }

    //确认收货
    private void sureGet(int id) {
        LoadDialog.showDialog(mContext);
        ApiManager.suerGetGoodsJiFen(id, new OnRequestFinish<BaseBean>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean data) {
                NToast.show(data.getMessage());
                refreshLayout.autoRefresh();
                EventBusUtil.sendEvent(new Event(EventCode.REFRESH_JIFEN_ORDER_LIST));
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
            }
        });
    }

}
