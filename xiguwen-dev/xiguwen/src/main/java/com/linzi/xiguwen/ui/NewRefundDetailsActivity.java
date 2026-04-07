package com.linzi.xiguwen.ui;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.os.Handler;
import androidx.recyclerview.widget.RecyclerView;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.base.adapter.BaseAdapter;
import com.linzi.xiguwen.base.adapter.BaseViewHolder;
import com.linzi.xiguwen.base.adapter.CreateHolderDelegate;
import com.linzi.xiguwen.bean.MallJieDanRefundBean;
import com.linzi.xiguwen.bean.MallRefundBean;
import com.linzi.xiguwen.bean.WeddingJieDanRefundBean;
import com.linzi.xiguwen.bean.WeddingRefundBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.network.Constans;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.LoginHepler;
import com.linzi.xiguwen.utils.LoginHeplerListener;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.TimeUtils;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;
import com.linzi.xiguwen.view.AskDialog;


import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by pc on 2018/4/19.
 */

public class NewRefundDetailsActivity extends BaseActivity implements LoginHeplerListener {

    @BindView(R.id.recycleview)
    RecyclerView recycleview;
    @BindView(R.id.order_bt_1)
    TextView orderBt1;
    @BindView(R.id.order_bt_2)
    TextView orderBt2;
    @BindView(R.id.bottombar)
    LinearLayout bottombar;

    private Context context;
    private BaseAdapter baseAdapter;
    private int intentType;//0婚庆订单，1商城订单.2婚庆接单，3商城接单
    private String phoneNum;
    private String order_sn;
    private Handler mHandler;//控制倒计时
    private int order_id;//订单号

    private HeadBean headBean;
    private WeddingRefundBean mWeddingRefundBean;
    private MallRefundBean mMallRefundBean;
    private WeddingJieDanRefundBean mWeddingJieDanRefundBean;
    private MallJieDanRefundBean mMallJieDanRefundBean;

    @Override
    protected void initData() {

    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.new_refund_details_layout);
        ButterKnife.bind(this);
        context = this;
        intentType = getIntent().getIntExtra("intentType", -1);
        order_id = getIntent().getIntExtra("id", -1);
        initView();
    }

    private void initView() {
        setBack();
        setTitle("退款详情");

        if (intentType == -1) {
            exitWithParm();
        } else {
            switch (intentType) {
                case 0://婚庆订单
                    getWeddingData();
                    break;
                case 1://商城订单
                    getMallData();
                    orderBt1.setText("撤销退款");
                    orderBt1.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            //cancelMallRefund();
                        }
                    });
                    break;
                case 2://婚庆接单
                    getWeddingJieDanData();
                    orderBt1.setText("正常退款");
                    orderBt2.setVisibility(View.VISIBLE);
                    orderBt2.setText("全额退款");
                    orderBt1.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            normalRefund();
                        }
                    });
                    orderBt2.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            allAmountRefund();
                        }
                    });
                    break;
                case 3://商场接单
                    getMallJieDanData();
                    orderBt1.setText("同意退款");
                    orderBt2.setVisibility(View.VISIBLE);
                    orderBt2.setText("拒绝退款");
                    orderBt1.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            agreeRefund();
                        }
                    });
                    orderBt2.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            refuseRefund();
                        }
                    });
                    break;
            }
        }
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
         
    }

    @Override
    public void loginOpinion(int code) {
        switch (code) {
            case 666:
                switch (intentType) {
                    case 0:
//                        NimUIKit.startP2PSession(this, mWeddingRefundBean.getOrderinfo().getShopim());
                        break;
                    case 1:
//                        NimUIKit.startP2PSession(this, mMallRefundBean.getOrderinfo().getShop_im());
                        break;
                    case 2:
//                        NimUIKit.startP2PSession(this, mWeddingJieDanRefundBean.getOrderinfo().getUserim());
                        break;
                    case 3:
//                        NimUIKit.startP2PSession(this, mMallJieDanRefundBean.getOrderinfo().getUser_im());
                        break;
                }
                break;
        }
    }

    private void exitWithParm() {
        finish();
        NToast.show("跳转失败，请重试！");
    }

    //获取婚庆订单退款详情
    private void getWeddingData() {
        LoadDialog.showDialog(context);
        ApiManager.getWeddingRefund(order_id, new OnRequestFinish<BaseBean<WeddingRefundBean>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<WeddingRefundBean> data) {
                mWeddingRefundBean = data.getData();

                headBean = new HeadBean();
                headBean.setId(mWeddingRefundBean.getTuikuan().getFund_id());
                final int stutas = mWeddingRefundBean.getTuikuan().getStatus();
                switch (stutas) {
                    case 1://买家提交处理中
                        headBean.setType("等待商家处理");
                        headBean.setTime(mWeddingRefundBean.getTuikuan().getDaojishi());
                        headBean.setShowTime(true);
                        headBean.setShowPrice(false);
                        bottombar.setVisibility(View.VISIBLE);
                        orderBt1.setText("撤销退款");
                        orderBt1.setOnClickListener(new View.OnClickListener() {
                            @Override
                            public void onClick(View view) {
                                createDel("温馨提示", "确认撤销退款吗？", "点错了", "确认", mWeddingRefundBean.getTuikuan().getFund_id());
                            }
                        });
                        break;
                    case 2://同意退款
                        headBean.setType("退款成功");
                        headBean.setTime(mWeddingRefundBean.getTuikuan().getGcldated_at());
                        headBean.setPrice(mWeddingRefundBean.getTuikuan().getTui_amount());
                        headBean.setShowTime(false);
                        headBean.setShowPrice(true);
                        break;
                    case 3://不同意退款
                        headBean.setType("退款失败");
                        headBean.setTime(mWeddingRefundBean.getTuikuan().getGcldated_at());
                        headBean.setShowTime(false);
                        headBean.setShowPrice(false);
//                        orderBt1.setText("客服仲裁");
//                        orderBt1.setOnClickListener(new View.OnClickListener() {
//                            @Override
//                            public void onClick(View view) {
//                                weddingArbitration();
//                            }
//                        });
                        break;
                    case 4://撤销退款
                        headBean.setType("撤销退款");
                        headBean.setTime("");
                        headBean.setShowTime(false);
                        headBean.setShowPrice(false);
                        break;
                }

                afterView();
            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }

    //获取商城订单退款详情 状态码 60 未发货退款详情
    private void getMallData() {
        LoadDialog.showDialog(context);
        ApiManager.getMallRefund(order_id, new OnRequestFinish<BaseBean<MallRefundBean>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<MallRefundBean> data) {
                mMallRefundBean = data.getData();

                headBean = new HeadBean();
                headBean.setId(mMallRefundBean.getRefundinfo().getFund_id());
                final int stutas = mMallRefundBean.getRefundinfo().getRefund_status();
                switch (stutas) {
                    case 1://买家提交处理中
                        headBean.setType("等待商家处理");
                        headBean.setTime(mMallRefundBean.getRefundinfo().getDaojishi());
                        headBean.setShowTime(true);
                        headBean.setShowPrice(false);
                        bottombar.setVisibility(View.VISIBLE);
                        orderBt1.setText("撤销退款");
                        orderBt1.setOnClickListener(new View.OnClickListener() {
                            @Override
                            public void onClick(View view) {
                                createDel("温馨提示", "确认撤销退款吗？", "点错了", "确认", mMallRefundBean.getRefundinfo().getFund_id());
                            }
                        });
                        break;
                    case 5://买家提交退货退款处理中
                        headBean.setType("等待商家处理");
                        headBean.setTime(mMallRefundBean.getRefundinfo().getDaojishi());
                        headBean.setShowTime(true);
                        headBean.setShowPrice(false);
                        bottombar.setVisibility(View.VISIBLE);
                        orderBt1.setText("撤销退款");
                        orderBt1.setOnClickListener(new View.OnClickListener() {
                            @Override
                            public void onClick(View view) {
                                createDel("温馨提示", "确认撤销退款吗？", "点错了", "确认", mMallRefundBean.getRefundinfo().getFund_id());
                            }
                        });
                        break;
                    case 2://同意退款
                        headBean.setType("退款成功");
                        headBean.setTime(mMallRefundBean.getRefundinfo().getGcldated_at());
                        headBean.setPrice(mMallRefundBean.getRefundinfo().getTui_amount());
                        headBean.setShowTime(false);
                        headBean.setShowPrice(true);
                        break;
                    case 9://同意退货退款商家确认收货
                        headBean.setType("退款成功");
                        headBean.setTime(mMallRefundBean.getRefundinfo().getGcldated_at());
                        headBean.setPrice(mMallRefundBean.getRefundinfo().getTui_amount());
                        headBean.setShowTime(false);
                        headBean.setShowPrice(true);
                        break;
                    case 3://不同意退款
                        headBean.setType("拒绝退款");
                        headBean.setTime(mMallRefundBean.getRefundinfo().getGcldated_at());
                        headBean.setShowTime(false);
                        headBean.setShowPrice(false);
//                        orderBt1.setText("客服仲裁");
//                        orderBt1.setOnClickListener(new View.OnClickListener() {
//                            @Override
//                            public void onClick(View view) {
//                                weddingArbitration();
//                            }
//                        });
                        break;
                    case 10://不同意退货退款 商家拒绝收货
                        headBean.setType("拒绝退款");
                        headBean.setTime(mMallRefundBean.getRefundinfo().getGcldated_at());
                        headBean.setShowTime(false);
                        headBean.setShowPrice(false);
//                        orderBt1.setText("客服仲裁");
//                        orderBt1.setOnClickListener(new View.OnClickListener() {
//                            @Override
//                            public void onClick(View view) {
//                                weddingArbitration();
//                            }
//                        });
                        break;
                    case 6://提交退货退款
                        headBean.setType("等待买家发货");
                        headBean.setTime(mMallRefundBean.getRefundinfo().getDaojishi());
                        headBean.setShowTime(true);
                        headBean.setShowPrice(false);
                        bottombar.setVisibility(View.VISIBLE);
                        orderBt1.setText("填写物流信息");
                        orderBt1.setOnClickListener(new View.OnClickListener() {
                            @Override
                            public void onClick(View view) {
                                Intent intent = new Intent(mContext, EditWuLiuMsgActivity.class);
                                intent.putExtra("order_id", mMallRefundBean.getRefundinfo().getFund_id());
                                intent.putExtra("isTuiHuo", true);
                                mContext.startActivity(intent);
                            }
                        });
                        break;
                    case 8://买家已发货
                        headBean.setType("买家已发货");
                        headBean.setTime(mMallRefundBean.getRefundinfo().getGcldated_at());
                        headBean.setPrice(mMallRefundBean.getRefundinfo().getTui_amount());
                        headBean.setShowTime(false);
                        headBean.setShowPrice(true);
                        break;
                }

                afterView();
            }

            @Override
            public void onError(Exception ex) {
            }
        });
    }

    //获取婚庆接单退款详情
    private void getWeddingJieDanData() {
        LoadDialog.showDialog(context);
        ApiManager.getWeddingJieDanRefund(order_id, new OnRequestFinish<BaseBean<WeddingJieDanRefundBean>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<WeddingJieDanRefundBean> data) {
                mWeddingJieDanRefundBean = data.getData();
                afterView();
            }

            @Override
            public void onError(Exception ex) {
            }
        });
    }

    //获取商城接单退款详情
    private void getMallJieDanData() {
        LoadDialog.showDialog(context);
        ApiManager.getMallJieDanRefund(order_id, new OnRequestFinish<BaseBean<MallJieDanRefundBean>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<MallJieDanRefundBean> data) {
                mMallJieDanRefundBean = data.getData();

                headBean = new HeadBean();
                headBean.setId(mMallJieDanRefundBean.getRefundinfo().getFund_id());
                final int stutas = mMallJieDanRefundBean.getRefundinfo().getRefund_status();
                switch (stutas) {
                    case 1://买家提交处理中
                        headBean.setType("等待商家处理");
                        headBean.setTime(mMallJieDanRefundBean.getRefundinfo().getDaojishi());
                        headBean.setShowTime(true);
                        headBean.setShowPrice(false);
                        bottombar.setVisibility(View.VISIBLE);
                        orderBt2.setVisibility(View.VISIBLE);
                        orderBt2.setText("拒绝退款");
                        orderBt1.setText("同意退款");
                        orderBt1.setOnClickListener(new View.OnClickListener() {
                            @Override
                            public void onClick(View view) {
                                createDel("温馨提示", "确认同意该订单的退款请求？", "点错了", "确认", mMallJieDanRefundBean.getRefundinfo().getFund_id(), 0);
                            }
                        });

                        orderBt2.setOnClickListener(new View.OnClickListener() {
                            @Override
                            public void onClick(View view) {
                                Intent intent = new Intent(context, RefuseReasonActivity.class);
                                intent.putExtra("order_id", headBean.getId());
                                intent.putExtra("type", 0);
                                context.startActivity(intent);
                                finish();
                            }
                        });
                        break;
                    case 5://买家提交退货退款处理中
                        headBean.setType("等待商家处理");
                        headBean.setTime(mMallJieDanRefundBean.getRefundinfo().getDaojishi());
                        headBean.setShowTime(true);
                        headBean.setShowPrice(false);
                        bottombar.setVisibility(View.VISIBLE);
                        orderBt2.setVisibility(View.VISIBLE);
                        orderBt2.setText("拒绝退款");
                        orderBt1.setText("同意退款");
                        orderBt1.setOnClickListener(new View.OnClickListener() {
                            @Override
                            public void onClick(View view) {
                                createDel("温馨提示", "确认同意该订单的退款请求？", "点错了", "确认", mMallJieDanRefundBean.getRefundinfo().getFund_id(), 1);
                            }
                        });

                        orderBt2.setOnClickListener(new View.OnClickListener() {
                            @Override
                            public void onClick(View view) {
                                Intent intent = new Intent(context, RefuseReasonActivity.class);
                                intent.putExtra("order_id", headBean.getId());
                                intent.putExtra("type", 1);
                                context.startActivity(intent);
                                finish();
                            }
                        });
                        break;
                    case 2://同意退款
                        headBean.setType("退款成功");
                        headBean.setTime(mMallJieDanRefundBean.getRefundinfo().getGcldated_at());
                        headBean.setPrice(mMallJieDanRefundBean.getRefundinfo().getTui_amount());
                        headBean.setShowTime(false);
                        headBean.setShowPrice(true);
                        break;
                    case 9://同意退货退款商家确认收货
                        headBean.setType("退款成功");
                        headBean.setTime(mMallJieDanRefundBean.getRefundinfo().getGcldated_at());
                        headBean.setPrice(mMallJieDanRefundBean.getRefundinfo().getTui_amount());
                        headBean.setShowTime(false);
                        headBean.setShowPrice(true);
                        break;
                    case 3://不同意退款
                        headBean.setType("拒绝退款");
                        headBean.setTime(mMallJieDanRefundBean.getRefundinfo().getGcldated_at());
                        headBean.setShowTime(false);
                        headBean.setShowPrice(false);
//                        orderBt1.setText("客服仲裁");
//                        orderBt1.setOnClickListener(new View.OnClickListener() {
//                            @Override
//                            public void onClick(View view) {
//                                weddingArbitration();
//                            }
//                        });
                        break;
                    case 10://不同意退货退款 商家拒绝收货
                        headBean.setType("拒绝退款");
                        headBean.setTime(mMallJieDanRefundBean.getRefundinfo().getGcldated_at());
                        headBean.setShowTime(false);
                        headBean.setShowPrice(false);
//                        orderBt1.setText("客服仲裁");
//                        orderBt1.setOnClickListener(new View.OnClickListener() {
//                            @Override
//                            public void onClick(View view) {
//                                weddingArbitration();
//                            }
//                        });
                        break;
                    case 6://提交退货退款
                        headBean.setType("等待买家发货");
                        headBean.setTime(mMallJieDanRefundBean.getRefundinfo().getDaojishi());
                        headBean.setShowTime(true);
                        headBean.setShowPrice(false);
                        break;
                    case 8://买家已发货
                        headBean.setType("买家已发货");
                        headBean.setTime(mMallJieDanRefundBean.getRefundinfo().getGcldated_at());
                        headBean.setPrice(mMallJieDanRefundBean.getRefundinfo().getTui_amount());
                        headBean.setShowTime(false);
                        headBean.setShowPrice(true);
                        bottombar.setVisibility(View.VISIBLE);
                        orderBt2.setVisibility(View.VISIBLE);
                        orderBt1.setText("确认收货");
                        orderBt2.setText("拒绝收货");
                        orderBt1.setOnClickListener(new View.OnClickListener() {
                            @Override
                            public void onClick(View view) {
                                createDel("温馨提示", "确认已收货？", "点错了", "确认", mMallJieDanRefundBean.getRefundinfo().getFund_id(), 2);
                            }
                        });
                        orderBt2.setOnClickListener(new View.OnClickListener() {
                            @Override
                            public void onClick(View view) {
                                Intent intent = new Intent(context, RefuseReasonActivity.class);
                                intent.putExtra("order_id", headBean.getId());
                                intent.putExtra("type", 2);
                                context.startActivity(intent);
                                finish();
                            }
                        });
                        break;
                }

                afterView();
            }

            @Override
            public void onError(Exception ex) {
            }
        });
    }

    //婚庆订单Delegate
    CreateHolderDelegate<WeddingRefundBean> weddingRefundBeanCreateHolderDelegate = new CreateHolderDelegate<WeddingRefundBean>() {
        @Override
        protected int getLayoutRes() {
            return R.layout.new_refund_item;
        }

        @Override
        protected BaseViewHolder onCreateHolder(View itemView) {
            return new WeddingRefundHolder(itemView);
        }
    };

    //商城订单Delegate
    CreateHolderDelegate<MallRefundBean> mallRefundBeanCreateHolderDelegate = new CreateHolderDelegate<MallRefundBean>() {
        @Override
        protected int getLayoutRes() {
            return R.layout.new_refund_item;
        }

        @Override
        protected BaseViewHolder onCreateHolder(View itemView) {
            return new MallRefundHolder(itemView);
        }
    };

    //婚庆订单Delegate
    CreateHolderDelegate<WeddingJieDanRefundBean.OrderinfoBean> weddingJieDanRefundBeanCreateHolderDelegate = new CreateHolderDelegate<WeddingJieDanRefundBean.OrderinfoBean>() {
        @Override
        protected int getLayoutRes() {
            return 0;
        }

        @Override
        protected BaseViewHolder onCreateHolder(View itemView) {
            return null;
        }
    };

    //商城接单Delegate
    CreateHolderDelegate<MallJieDanRefundBean> mallJieDanRefundBeanCreateHolderDelegate = new CreateHolderDelegate<MallJieDanRefundBean>() {
        @Override
        protected int getLayoutRes() {
            return R.layout.new_refund_item;
        }

        @Override
        protected BaseViewHolder onCreateHolder(View itemView) {
            return new MallJieDanRefundHolder(itemView);
        }
    };

    //Head Delegate
    CreateHolderDelegate<HeadBean> headBeanCreateHolderDelegate = new CreateHolderDelegate<HeadBean>() {
        @Override
        protected int getLayoutRes() {
            return R.layout.order_refund_head_layout;
        }

        @Override
        protected BaseViewHolder onCreateHolder(View itemView) {
            return new HeadTitleHolder(itemView);
        }
    };

    //Head holder
    class HeadTitleHolder extends BaseViewHolder<HeadBean> {
        @BindView(R.id.tv_status)
        TextView tvStatus;
        @BindView(R.id.tv_time)
        TextView tvTime;
        @BindView(R.id.ll_history)
        LinearLayout llHistory;
        @BindView(R.id.ll_price)
        LinearLayout ll_price;
        @BindView(R.id.tv_price)
        TextView tv_price;
        private int id;

        public HeadTitleHolder(View itemView) {
            super(itemView);

            llHistory.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Intent intent = new Intent(context, XIeShangHistoryActivity.class);
                    intent.putExtra("id", id);
                    intent.putExtra("intentType", intentType);
                    context.startActivity(intent);
                }
            });
        }

        @Override
        protected void bindView(HeadBean headBean) {
            id = headBean.getId();
            tvStatus.setText(headBean.getType());
            if (headBean.isShowTime()) {
                if (mHandler != null) {
                    mHandler.removeCallbacksAndMessages(null);
                }
                mHandler = TimeUtils.getReturnTime((Long.valueOf(headBean.getTime())), tvTime);
            } else {
                tvTime.setText(headBean.getTime());
            }
            if (headBean.isShowPrice()) {
                ll_price.setVisibility(View.VISIBLE);
                tv_price.setText("￥" + headBean.getPrice());
            } else {
                ll_price.setVisibility(View.GONE);
            }
        }
    }

    //婚庆订单holder
    class WeddingRefundHolder extends BaseViewHolder<WeddingRefundBean> {
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
        @BindView(R.id.tv_tuikuan_id)
        TextView tv_tuikuan_id;
        @BindView(R.id.tv_tuikuan_create_time)
        TextView tv_tuikuan_create_time;
        @BindView(R.id.tv_pay_money)
        TextView tv_pay_money;
        @BindView(R.id.tv_goods_size)
        TextView tv_goods_size;
        @BindView(R.id.tv_tuikuan_reason)
        TextView tv_tuikuan_reason;
        @BindView(R.id.ll_contact)
        LinearLayout ll_contact;
        @BindView(R.id.ll_call)
        LinearLayout ll_call;


        public WeddingRefundHolder(View itemView) {
            super(itemView);
        }

        @Override
        protected void bindView(WeddingRefundBean bean) {
            ll_contact.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    LoginHepler.LoginHepler(mContext, 666, true, NewRefundDetailsActivity.this);
                }
            });
            ll_call.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    phoneNum = mWeddingRefundBean.getOrderinfo().getShopmobile();
                    callUser(phoneNum);
                }
            });
            tv_tuikuan_reason.setText("退款原因:" + bean.getTuikuan().getTui_yuanyin());
            tv_goods_size.setText("申请件数:" + bean.getOrderinfo().getQuantity());
            tv_pay_money.setText("实付金额：￥" + bean.getOrderinfo().getOrder_amount());
            tv_tuikuan_create_time.setText("退款申请时间：" + bean.getTuikuan().getCreated_at());
            tv_tuikuan_id.setText("退款编号：" + bean.getTuikuan().getFund_id());
            GlideLoad.GlideLoadImg2(bean.getOrderinfo().getBaojia_image(), ivImg);
            tvTitle.setText(bean.getOrderinfo().getBaojia_name() + "");
            tvTime.setText(bean.getOrderinfo().getSpecification() + "");
            tvDanjia.setText(Constans.RMB + bean.getOrderinfo().getOrder_amount());
            if (bean.getOrderinfo().getPaytype() == 2) {
                tvDingjin.setVisibility(View.VISIBLE);
                dingjintx.setVisibility(View.VISIBLE);
                tvDingjin.setText(Constans.RMB + bean.getOrderinfo().getOrder_amount());
                tvPayType.setText("定金");
            } else {
                tvDingjin.setVisibility(View.GONE);
                dingjintx.setVisibility(View.GONE);
                tvPayType.setText("全款");
            }
            if (bean.getOrderinfo().getDiscount() != null && !bean.getOrderinfo().getDiscount().equals("")) {
                dikoutext.setVisibility(View.VISIBLE);
                tvDiKou.setText("￥" + bean.getOrderinfo().getDiscount());
            } else {
                dikoutext.setVisibility(View.GONE);
            }
            tvNum.setText("" + bean.getOrderinfo().getQuantity());
        }
    }

    //商城订单holder
    class MallRefundHolder extends BaseViewHolder<MallRefundBean> {
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
        @BindView(R.id.tv_tuikuan_id)
        TextView tv_tuikuan_id;
        @BindView(R.id.tv_tuikuan_create_time)
        TextView tv_tuikuan_create_time;
        @BindView(R.id.tv_pay_money)
        TextView tv_pay_money;
        @BindView(R.id.tv_goods_size)
        TextView tv_goods_size;
        @BindView(R.id.tv_tuikuan_reason)
        TextView tv_tuikuan_reason;
        @BindView(R.id.ll_contact)
        LinearLayout ll_contact;
        @BindView(R.id.ll_call)
        LinearLayout ll_call;

        public MallRefundHolder(View itemView) {
            super(itemView);
        }

        @Override
        protected void bindView(MallRefundBean bean) {
            ll_contact.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    LoginHepler.LoginHepler(mContext, 666, true, NewRefundDetailsActivity.this);
                }
            });
            ll_call.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    phoneNum = mMallRefundBean.getOrderinfo().getMobile();
                    callUser(phoneNum);
                }
            });
            tv_tuikuan_reason.setText("退款原因:" + bean.getRefundinfo().getTuikuan_yuanyin());
            tv_goods_size.setText("申请件数:" + bean.getGoodsinfo().getQuantity());
            tv_pay_money.setText("实付金额：￥" + bean.getOrderinfo().getOrder_amount());
            tv_tuikuan_create_time.setText("退款申请时间：" + bean.getRefundinfo().getCreated_at());
            tv_tuikuan_id.setText("退款编号：" + bean.getRefundinfo().getFund_id());
            GlideLoad.GlideLoadImg2(bean.getGoodsinfo().getGoods_image(), ivImg);
            tvTitle.setText(bean.getGoodsinfo().getGoods_name() + "");
            tvTime.setText(bean.getGoodsinfo().getSpecification() + "");
            tvDanjia.setText(Constans.RMB + bean.getOrderinfo().getOrder_amount());

            tvDingjin.setVisibility(View.GONE);
            dingjintx.setVisibility(View.GONE);
            dikoutext.setVisibility(View.GONE);


            dikoutext.setVisibility(View.GONE);
            tvNum.setText("" + bean.getGoodsinfo().getQuantity());
        }
    }

    //婚庆接单holder
    class WeddingJieDanRefundHolder extends BaseViewHolder<WeddingJieDanRefundBean> {

        public WeddingJieDanRefundHolder(View itemView) {
            super(itemView);
        }

        @Override
        protected void bindView(WeddingJieDanRefundBean bean) {

        }
    }

    //商城接单holder
    class MallJieDanRefundHolder extends BaseViewHolder<MallJieDanRefundBean> {
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
        @BindView(R.id.tv_tuikuan_id)
        TextView tv_tuikuan_id;
        @BindView(R.id.tv_tuikuan_create_time)
        TextView tv_tuikuan_create_time;
        @BindView(R.id.tv_pay_money)
        TextView tv_pay_money;
        @BindView(R.id.tv_goods_size)
        TextView tv_goods_size;
        @BindView(R.id.tv_tuikuan_reason)
        TextView tv_tuikuan_reason;
        @BindView(R.id.ll_contact)
        LinearLayout ll_contact;
        @BindView(R.id.ll_call)
        LinearLayout ll_call;
        @BindView(R.id.im_text)
        TextView im_text;

        public MallJieDanRefundHolder(View itemView) {
            super(itemView);
        }

        @Override
        protected void bindView(MallJieDanRefundBean bean) {
            im_text.setText("联系买家");
            ll_contact.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    LoginHepler.LoginHepler(mContext, 666, true, NewRefundDetailsActivity.this);
                }
            });
            ll_call.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    phoneNum = mMallRefundBean.getOrderinfo().getMobile();
                    callUser(phoneNum);
                }
            });
            tv_tuikuan_reason.setText("退款原因:" + bean.getRefundinfo().getTuikuan_yuanyin());
            tv_goods_size.setText("申请件数:" + bean.getGoodsinfo().getQuantity());
            tv_pay_money.setText("实付金额：￥" + bean.getOrderinfo().getOrder_amount());
            tv_tuikuan_create_time.setText("退款申请时间：" + bean.getRefundinfo().getCreated_at());
            tv_tuikuan_id.setText("退款编号：" + bean.getRefundinfo().getFund_id());
            GlideLoad.GlideLoadImg2(bean.getGoodsinfo().getGoods_image(), ivImg);
            tvTitle.setText(bean.getGoodsinfo().getGoods_name() + "");
            tvTime.setText(bean.getGoodsinfo().getSpecification() + "");
            tvDanjia.setText(Constans.RMB + bean.getOrderinfo().getOrder_amount());

            tvDingjin.setVisibility(View.GONE);
            dingjintx.setVisibility(View.GONE);
            dikoutext.setVisibility(View.GONE);


            dikoutext.setVisibility(View.GONE);
            tvNum.setText("" + bean.getGoodsinfo().getQuantity());
        }
    }

    //婚庆订单Adapter
    private BaseAdapter createWeddingAdapter(WeddingRefundBean bean) {
        BaseAdapter baseAdapter = BaseAdapter.createBaseAdapter();
        baseAdapter
                .injectHolderDelegate(headBeanCreateHolderDelegate.cleanAfterAddData(headBean))
                .injectHolderDelegate(weddingRefundBeanCreateHolderDelegate.cleanAfterAddData(bean));
        baseAdapter.setLayoutManager(recycleview);
        return baseAdapter;
    }

    //商城订单Adapter
    private BaseAdapter createMallAdapter(MallRefundBean bean) {
        BaseAdapter baseAdapter = BaseAdapter.createBaseAdapter();
        baseAdapter
                .injectHolderDelegate(headBeanCreateHolderDelegate.cleanAfterAddData(headBean))
                .injectHolderDelegate(mallRefundBeanCreateHolderDelegate.cleanAfterAddData(bean));
        baseAdapter.setLayoutManager(recycleview);
        return baseAdapter;
    }

    //婚庆接单Adapter
    private BaseAdapter createWeddingJieDanAdapter(WeddingJieDanRefundBean bean) {
        BaseAdapter baseAdapter = BaseAdapter.createBaseAdapter();
        baseAdapter
                .injectHolderDelegate(headBeanCreateHolderDelegate.cleanAfterAddData(headBean))
                .injectHolderDelegate(weddingJieDanRefundBeanCreateHolderDelegate.cleanAfterAddData(bean.getOrderinfo()));
        baseAdapter.setLayoutManager(recycleview);
        return baseAdapter;
    }

    //商城接单Adapter
    private BaseAdapter createMallJieDanAdapter(MallJieDanRefundBean bean) {
        BaseAdapter baseAdapter = BaseAdapter.createBaseAdapter();
        baseAdapter
                .injectHolderDelegate(headBeanCreateHolderDelegate.cleanAfterAddData(headBean))
                .injectHolderDelegate(mallJieDanRefundBeanCreateHolderDelegate.cleanAfterAddData(bean));
        baseAdapter.setLayoutManager(recycleview);
        return baseAdapter;
    }

    //创建不同的适配器
    private void afterView() {
        switch (intentType) {
            case 0:
                baseAdapter = createWeddingAdapter(mWeddingRefundBean);
                break;
            case 1:
                baseAdapter = createMallAdapter(mMallRefundBean);
                break;
            case 2:
                baseAdapter = createWeddingJieDanAdapter(mWeddingJieDanRefundBean);
                break;
            case 3:
                baseAdapter = createMallJieDanAdapter(mMallJieDanRefundBean);
                break;
        }
        recycleview.setAdapter(baseAdapter);
    }

    //婚庆订单客服仲裁
    private void weddingArbitration() {
    }

    //婚庆订单撤销退款
    private void cancelWeddingRefund(int id) {
        LoadDialog.showDialog(context);
        ApiManager.canelWeddingTuiKuan(id, new OnRequestFinish<BaseBean>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean data) {
                NToast.show(data.getMessage());
                refreshView(1001);
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
            }
        });
    }

    //商城订单撤销退款
    private void cancelMallRefund(int id) {
        LoadDialog.showDialog(context);
        ApiManager.canelMallTuiKuan(id, new OnRequestFinish<BaseBean>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean data) {
                NToast.show(data.getMessage());
                refreshView(1001);
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
            }
        });
    }

    //婚庆接单正常退款
    private void normalRefund() {

    }

    //婚庆接单全额退款
    private void allAmountRefund() {

    }

    //商城接单正常退款
    private void refuseRefund() {

    }

    //商城接单正常退款
    private void agreeRefund() {

    }

    //联系商家
    private void callUser(String phoneNum) {
        if (phoneNum != null) {
            Intent intent = new Intent(Intent.ACTION_DIAL, Uri.parse("tel:" + phoneNum));
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            startActivity(intent);
        } else {
            NToast.show("抱歉，暂时没有该商家的联系方式！");
        }
    }

    //撤销退款对话框
    private void createDel(String title, String content, String canleNam, String sureName, final int id) {
        final AskDialog dialog = new AskDialog(context, NewRefundDetailsActivity.this);
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
                switch (intentType) {
                    case 0:
                        cancelWeddingRefund(id);
                        break;
                    case 1:
                        cancelMallRefund(id);
                        break;
                    case 2:
                        cancelWeddingRefund(id);
                        break;
                    case 3:
                        cancelMallRefund(id);
                        break;

                }
                dialog.dismiss();
            }
        });
        dialog.show();
    }

    @Override
    protected void onResume() {
        super.onResume();
        initView();
    }

    private void refreshView(int code) {
        if (code == 1001) {//撤销成功
            finish();
            EventBusUtil.sendEvent(new Event(EventCode.RE_GET_ORDER_DETAILS));
        } else {
            initView();
        }
    }

    class HeadBean {
        private int id;
        private String type;
        private String time;
        private String price;
        private boolean isShowPrice;
        private boolean isShowTime;

        public int getId() {
            return id;
        }

        public void setId(int id) {
            this.id = id;
        }

        public String getType() {
            return type;
        }

        public void setType(String type) {
            this.type = type;
        }

        public String getTime() {
            return time;
        }

        public void setTime(String time) {
            this.time = time;
        }

        public String getPrice() {
            return price;
        }

        public void setPrice(String price) {
            this.price = price;
        }

        public boolean isShowPrice() {
            return isShowPrice;
        }

        public void setShowPrice(boolean showPrice) {
            isShowPrice = showPrice;
        }

        public boolean isShowTime() {
            return isShowTime;
        }

        public void setShowTime(boolean showTime) {
            isShowTime = showTime;
        }
    }

    //婚庆订单dialog   type: 0:同意未发货退款 1:同意已发货退款 2:确认接单 3:拒绝接单 4:接单 完成服务 5:同意退款  7:取消商城订单 8:商城用户确认收货
    private void createDel(String title, String content, String canleNam, String sureName, final int id, final int type) {
        final AskDialog dialog = new AskDialog(context, NewRefundDetailsActivity.this);
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
                        agreedweifahuoTuiKuan(id);
                        break;
                    case 1:
                        agreedyifahuoTuiKuan(id);
                        break;
                    case 2:
                        agreedshouhuoTuiKuan(id);
                        break;
//                    case 3:
//                        canleshouhuotuikuan(id);
//                        break;
//                    case 4:
//                        finishWeddingOrder(id, -1);
//                        break;
//                    case 5:
//                        agreedWeddingTuiKuan(id);
//                        break;
//                    case 7:
//                        cancelMallOrder(id);
//                        break;
//                    case 8:
//                        sureGetGoods(id);
//                        break;
                }

                dialog.dismiss();
            }
        });
        dialog.show();
    }

    //同意未发货退款
    private void agreedweifahuoTuiKuan(int id) {
        LoadDialog.showDialog(context);
        ApiManager.agreeweifahuotuikuan(id, new OnRequestFinish<BaseBean>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean data) {
                NToast.show(data.getMessage());
                finish();
                EventBusUtil.sendEvent(new Event(EventCode.REFRESH));
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
            }
        });
    }

    //同意已发货退款
    private void agreedyifahuoTuiKuan(int id) {
        LoadDialog.showDialog(context);
        ApiManager.agreeyifahuotuikuan(id, new OnRequestFinish<BaseBean>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean data) {
                NToast.show(data.getMessage());
                finish();
                EventBusUtil.sendEvent(new Event(EventCode.REFRESH));
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
            }
        });
    }

    //同意收货退款
    private void agreedshouhuoTuiKuan(int id) {
        LoadDialog.showDialog(context);
        ApiManager.agreeshouhuotuikuan(id, new OnRequestFinish<BaseBean>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean data) {
                NToast.show(data.getMessage());
                finish();
                EventBusUtil.sendEvent(new Event(EventCode.REFRESH));
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
            }
        });
    }
}
