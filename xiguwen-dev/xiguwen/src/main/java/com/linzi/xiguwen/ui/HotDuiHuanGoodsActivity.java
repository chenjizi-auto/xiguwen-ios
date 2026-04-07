package com.linzi.xiguwen.ui;

import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.base.adapter.BaseAdapter;
import com.linzi.xiguwen.base.adapter.BaseViewHolder;
import com.linzi.xiguwen.base.adapter.CreateHolderDelegate;
import com.linzi.xiguwen.bean.JiFenGoodsBean;
import com.linzi.xiguwen.bean.JiFenHongBaoBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.LoginUtil;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;
import com.linzi.xiguwen.view.AskDialog;
import com.linzi.xiguwen.view.MyRefreshFooter;
import com.linzi.xiguwen.view.MyRefreshHeader;
import com.linzi.xiguwen.view.dialog.InputPassWordDialog;
import com.scwang.smartrefresh.layout.SmartRefreshLayout;
import com.scwang.smartrefresh.layout.api.RefreshLayout;
import com.scwang.smartrefresh.layout.listener.OnLoadMoreListener;
import com.scwang.smartrefresh.layout.listener.OnRefreshListener;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by pc on 2018/5/23.
 */

public class HotDuiHuanGoodsActivity extends BaseActivity {
    @BindView(R.id.recycleview)
    RecyclerView recycleview;
    @BindView(R.id.refresh_layout)
    SmartRefreshLayout refreshLayout;

    private int type;//1热兑商品 0兑换红包
    private int page = 1;
    private int limit = 10;

    private JiFenGoodsBean jiFenGoodsBean;
    private JiFenHongBaoBean jiFenHongBaoBean;

    private BaseAdapter baseAdapter;

    private InputPassWordDialog inputPassWordDialog;

    @Override
    protected void initData() {

    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.jifen_mall_goods_layout);
        ButterKnife.bind(this);
        type = getIntent().getIntExtra("type", -1);
        initView();

    }

    private void initView() {
        setBack();
        if (type != -1) {
            setTitle(type == 1 ? "热兑商品" : "兑换红包");
        } else {
            finish();
            NToast.show("跳转失败，请重试！");
        }
        refreshLayout.setRefreshHeader(new MyRefreshHeader(mContext));
        refreshLayout.setRefreshFooter(new MyRefreshFooter(mContext));

        refreshLayout.setOnRefreshListener(new OnRefreshListener() {
            @Override
            public void onRefresh(@NonNull RefreshLayout refreshLayout) {
                resetDel();
                if (type == 1) {
                    getDataGoods(false);
                } else {
                    getDataHongBao(false);
                }
                refreshLayout.setEnableLoadMore(true);
            }
        });

        refreshLayout.setOnLoadMoreListener(new OnLoadMoreListener() {
            @Override
            public void onLoadMore(@NonNull RefreshLayout refreshLayout) {
                if (type == 1) {
                    getDataGoods(true);
                } else {
                    getDataHongBao(true);
                }
            }
        });

        refreshLayout.autoRefresh();
        afterView();
    }

    private void getDataGoods(final boolean isLoadMore) {
        if (isLoadMore) {
            page++;
        } else {
            page = 1;
        }
        ApiManager.getJiFenGoods(page, limit, new OnRequestFinish<BaseBean<JiFenGoodsBean>>() {
            @Override
            public void onFinished() {
                if (isLoadMore) {
                    refreshLayout.finishLoadMore();
                } else {
                    refreshLayout.finishRefresh();
                }
            }

            @Override
            public void onSuccess(BaseBean<JiFenGoodsBean> data) {
                JiFenGoodsBean bean = data.getData();
                if (!isLoadMore)
                    jiFenGoodsBean = bean;
                else
                    jiFenGoodsBean.getData().addAll(bean.getData());
                if (bean.getData() != null && bean.getData().size() > 0) {
                    noData.clearAll();
                    goodsDel.cleanAfterAddAllData(jiFenGoodsBean.getData());
                } else {
                    baseAdapter.injectHolderDelegate(new CreateHolderDelegate<String>() {
                        @Override
                        protected int onSpanSize() {
                            return 2;
                        }

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
                    if (isLoadMore) {
                        refreshLayout.setEnableLoadMore(false);
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

    private void getDataHongBao(final boolean isLoadMore) {
        if (isLoadMore) {
            page++;
        } else {
            page = 1;
        }
        ApiManager.getJiFenHongBao(page, limit, new OnRequestFinish<BaseBean<JiFenHongBaoBean>>() {
            @Override
            public void onFinished() {
                if (isLoadMore) {
                    refreshLayout.finishLoadMore();
                } else {
                    refreshLayout.finishRefresh();
                }
            }

            @Override
            public void onSuccess(BaseBean<JiFenHongBaoBean> data) {
                JiFenHongBaoBean bean = data.getData();
                if (!isLoadMore)
                    jiFenHongBaoBean = bean;
                else
                    jiFenHongBaoBean.getData().addAll(bean.getData());
                if (bean.getData() != null && bean.getData().size() > 0) {
                    noData.clearAll();
                    hongBaoDel.cleanAfterAddAllData(jiFenHongBaoBean.getData());
                } else {
                    baseAdapter.injectHolderDelegate(new CreateHolderDelegate<String>() {
                        @Override
                        protected int onSpanSize() {
                            return 2;
                        }

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
                    if (isLoadMore) {
                        refreshLayout.setEnableLoadMore(false);
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


    private void afterView() {
        if (type == 1) {
            baseAdapter = createGoodsAdapter();
        } else {
            baseAdapter = createHongBaoAdapter();
        }
        recycleview.setAdapter(baseAdapter);
    }

    private BaseAdapter createGoodsAdapter() {
        BaseAdapter baseAdapter = BaseAdapter.createBaseAdapter();
        baseAdapter.injectHolderDelegate(noData)
                .injectHolderDelegate(goodsDel);
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
        protected int onSpanSize() {
            return 2;
        }

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

    CreateHolderDelegate<JiFenGoodsBean.DataBean> goodsDel = new CreateHolderDelegate<JiFenGoodsBean.DataBean>() {
        @Override
        protected int onSpanSize() {
            return 1;
        }

        @Override
        protected int getLayoutRes() {
            return R.layout.jifen_mall_item;
        }

        @Override
        protected BaseViewHolder onCreateHolder(View itemView) {
            return new HotDuiHolder(itemView);
        }
    };

    CreateHolderDelegate<JiFenHongBaoBean.DataBean> hongBaoDel = new CreateHolderDelegate<JiFenHongBaoBean.DataBean>() {
        @Override
        protected int onSpanSize() {
            return 1;
        }

        @Override
        protected int getLayoutRes() {
            return R.layout.jifen_mall_item;
        }

        @Override
        protected BaseViewHolder onCreateHolder(View itemView) {
            return new RedBaoHolder(itemView);
        }
    };

    //热兑商品holder
    class HotDuiHolder extends BaseViewHolder<JiFenGoodsBean.DataBean> {
        @BindView(R.id.goods_jifen)
        TextView goodsJifen;
        @BindView(R.id.tv_price)
        TextView tvPrice;
        @BindView(R.id.tv_yuan)
        TextView tvYuan;
        @BindView(R.id.goods_img)
        ImageView goods_img;
        @BindView(R.id.goods_name)
        TextView goods_name;
        @BindView(R.id.tv_submit)
        TextView tv_submit;
        private int id;

        public HotDuiHolder(View itemView) {
            super(itemView);
            itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Intent intent = new Intent(mContext, JiFenGoodsDetailActivity.class);
                    intent.putExtra("goods_id", id);
                    intent.putExtra("type", 0);
                    mContext.startActivity(intent);
                }
            });
        }

        @Override
        protected void bindView(JiFenGoodsBean.DataBean shopBean) {
            id = shopBean.getId();
            GlideLoad.GlideLoadImg2(shopBean.getTupian(), goods_img);
            goodsJifen.setText("" + shopBean.getJifen());
            if (shopBean.getJiage() != null && !shopBean.getJiage().equals("") && !shopBean.getJiage().equals("0") && !shopBean.getJiage().equals("0.00")) {
                tvPrice.setText("+" + shopBean.getJiage());
                tvPrice.setVisibility(View.VISIBLE);
                tvYuan.setVisibility(View.VISIBLE);
            } else {
                tvPrice.setVisibility(View.GONE);
                tvYuan.setVisibility(View.GONE);
            }

            goods_name.setText(shopBean.getName());

            tv_submit.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    if (!LoginUtil.isLogin()) {
                        LoginActivity.startAction(mContext);
                        return;
                    }
                    Intent intent = new Intent(mContext, JiFenSureOrderActivity.class);
                    intent.putExtra("rec_id", id);
                    mContext.startActivity(intent);
                }
            });
        }
    }

    //兑换红包holder
    class RedBaoHolder extends BaseViewHolder<JiFenHongBaoBean.DataBean> {
        @BindView(R.id.goods_jifen)
        TextView goodsJifen;
        @BindView(R.id.tv_price)
        TextView tvPrice;
        @BindView(R.id.tv_yuan)
        TextView tvYuan;
        @BindView(R.id.goods_img)
        ImageView goods_img;
        @BindView(R.id.goods_name)
        TextView goods_name;
        @BindView(R.id.tv_submit)
        TextView tv_submit;
        private int id;

        public RedBaoHolder(View itemView) {
            super(itemView);
            itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Intent intent = new Intent(mContext, JiFenGoodsDetailActivity.class);
                    intent.putExtra("goods_id", id);
                    intent.putExtra("type", 1);
                    mContext.startActivity(intent);
                }
            });
        }

        @Override
        protected void bindView(JiFenHongBaoBean.DataBean hongbaoBean) {
            id = hongbaoBean.getId();

            GlideLoad.GlideLoadImg2(hongbaoBean.getImg(), goods_img);
            final int jifen = hongbaoBean.getXuyaojifen();
            final String goodsname = hongbaoBean.getName();
            goodsJifen.setText("" + jifen);
            tvPrice.setVisibility(View.GONE);
            tvYuan.setVisibility(View.GONE);


            goods_name.setText(goodsname);

            tv_submit.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    if (!LoginUtil.isLogin()) {
                        LoginActivity.startAction(mContext);
                        return;
                    }
                    createDel("提示", "请确认是否使用[ " + jifen + " ]积分兑换[" + goodsname + "]", "点错了", "确认", id, jifen + "");
                }
            });
        }
    }

    //重置adapter代理
    private void resetDel() {
        baseAdapter.clearAllDelegate();
        baseAdapter.injectHolderDelegate(noData);
        if (type == 1) {
            baseAdapter.injectHolderDelegate(goodsDel);
        } else {
            baseAdapter.injectHolderDelegate(hongBaoDel);
        }
    }

    //提醒dialog
    private void createDel(String title, String content, String canleNam, String sureName, final int order_id, final String price) {
        final AskDialog dialog = new AskDialog(mContext, HotDuiHuanGoodsActivity.this);
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
                if (inputPassWordDialog == null) {
                    inputPassWordDialog = createDialog(false);
                    inputPassWordDialog.setOrder_id(order_id);
                    inputPassWordDialog.setJiFen(true);
                    inputPassWordDialog.setPrice(price);
                    inputPassWordDialog.isShow();
                } else {
                    inputPassWordDialog.clearInput();
                    inputPassWordDialog.setOrder_id(order_id);
                    inputPassWordDialog.setJiFen(true);
                    inputPassWordDialog.setPrice(price);
                    inputPassWordDialog.isShow();
                }

            }
        });
        dialog.show();
    }

    //初始化余额支付对话框
    private InputPassWordDialog createDialog(boolean isWeiKuan) {
        inputPassWordDialog = new InputPassWordDialog(mContext, R.style.MyDialog, isWeiKuan, 8);
        inputPassWordDialog.setRefreshNum(new InputPassWordDialog.RefreshNum() {
            @Override
            public void onRefresh() {
                finish();
                EventBusUtil.sendEvent(new Event(EventCode.PAY_SUCCRSS));
            }
        });
        inputPassWordDialog.setOnDismissListener(new DialogInterface.OnDismissListener() {
            @Override
            public void onDismiss(DialogInterface dialogInterface) {
                // NToast.show("订单生成后已扣除对应积分，请尽快完成兑换订单哦~");
                //finish();
            }
        });
        return inputPassWordDialog;
    }
}
