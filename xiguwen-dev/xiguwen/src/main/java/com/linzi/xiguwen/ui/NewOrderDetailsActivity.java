package com.linzi.xiguwen.ui;

import android.content.ClipboardManager;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.os.Handler;
import androidx.annotation.NonNull;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.base.adapter.BaseAdapter;
import com.linzi.xiguwen.base.adapter.BaseViewHolder;
import com.linzi.xiguwen.base.adapter.CreateHolderDelegate;
import com.linzi.xiguwen.bean.MallOrderDetailsBean;
import com.linzi.xiguwen.bean.WeddingOrderDetailsBean;
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
import com.linzi.xiguwen.utils.yixin.ViewUtil;
import com.linzi.xiguwen.utils.yixin.preference.Preferences;
import com.linzi.xiguwen.view.AskDialog;
import com.linzi.xiguwen.view.MyRefreshHeader;
import com.linzi.xiguwen.view.dialog.ChoosePayDialog;
import com.scwang.smartrefresh.layout.SmartRefreshLayout;
import com.scwang.smartrefresh.layout.api.RefreshLayout;
import com.scwang.smartrefresh.layout.listener.OnRefreshListener;

import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

public class NewOrderDetailsActivity extends BaseActivity implements LoginHeplerListener {
    @BindView(R.id.recycleview)
    RecyclerView recycleview;
    @BindView(R.id.order_bt_1)
    TextView orderBt1;
    @BindView(R.id.order_bt_2)
    TextView orderBt2;
    @BindView(R.id.bottombar)
    RelativeLayout bottombar;
    @BindView(R.id.order_bt_3)
    TextView orderBt3;
    @BindView(R.id.refresh_layout)
    SmartRefreshLayout refreshLayout;

    private Context context;
    private BaseAdapter baseAdapter;
    private int intentType;//0婚庆订单，1商城订单.2婚庆接单，3商城接单
    private WeddingOrderDetailsBean weddingOrderDetailsBean;
    private MallOrderDetailsBean mallOrderDetailsBean;

    private int order_id;//订单号
    //private int type;//跳转来源
    private boolean isShowTime;//是否显示倒计时
    private String title;
    private int time;//倒计时
    private String phoneNum;
    private String order_sn;
    private String orderPrice;
    private Handler mHandler;//控制倒计时
    private int status;//退款单需要传该参数

    private boolean isOperationOrder;//标记用户是否操作订单，用于返回列表通知是否刷新
    private boolean isInitView;//记录是否初始化view 用于刷新
    private boolean isShowTuikuanBtn;//标记是否商城订单详情是否显示退款按钮；
    private boolean isShowTuiHuo;//区分是否显示退货退款

    private int shifoutuikuan;//是否满足7天退款条件

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.new_order_details_layout);
        ButterKnife.bind(this);
        EventBusUtil.register(this);
        context = this;
        intentType = getIntent().getIntExtra("intentType", -1);
        order_id = getIntent().getIntExtra("order_id", -1);
        //type = getIntent().getIntExtra("type", -1);
        status = getIntent().getIntExtra("status", -1);
        initView();
        Preferences.removeTradeId(order_id + "");//消息里边判断已读未读的
    }

    private void initView() {
        setBack();
        setTitle("订单详情");

        refreshLayout.setRefreshHeader(new MyRefreshHeader(context));
        refreshLayout.setEnableLoadMore(false);

        refreshLayout.setOnRefreshListener(new OnRefreshListener() {
            @Override
            public void onRefresh(@NonNull RefreshLayout refreshLayout) {
                switch (intentType) {
                    case 0:
                        getWeddingOrderData();
                        break;
                    case 1:
                        getMallOrderData(status);
                        break;
                    case 2:
                        getWeddingJieDanOrderData();
                        break;
                    case 3:
                        getMallJieDanOrderData(status);
                        break;
                }
            }
        });

        if (intentType == -1) {
            exitWithParm();
        } else {
            refreshLayout.autoRefresh();
        }

        isInitView = true;
    }

    private void ctrlViewByType(int type, int tuihuo, final int order_id) {
        switch (type) {
            case 10://待付款
                title = "等待买家付款";
                isShowTime = true;
                switch (intentType) {
                    case 0://0婚庆订单，1商城订单.2婚庆接单，3商城接单
                        bottombar.setVisibility(View.VISIBLE);
                        orderBt1.setText("立即支付");
                        orderBt2.setText("取消订单");
                        orderBt3.setVisibility(View.GONE);
                        if (weddingOrderDetailsBean != null) {
                            time = weddingOrderDetailsBean.getFukuantime();
                        }
                        orderBt1.setOnClickListener(new View.OnClickListener() {
                            @Override
                            public void onClick(View view) {
                                Intent intent = new Intent(context, ToPayActivity.class);
                                intent.putExtra("intentType", intentType);
                                intent.putExtra("id", order_sn);
                                intent.putExtra("price", weddingOrderDetailsBean.getPayjine());
                                context.startActivity(intent);
                            }
                        });
                        orderBt2.setOnClickListener(new View.OnClickListener() {
                            @Override
                            public void onClick(View view) {
                                createDel("温馨提示", "确认取消订单吗？", "点错了", "确认", order_id, 0);
                            }
                        });

                        break;
                    case 1:
                        bottombar.setVisibility(View.VISIBLE);
                        orderBt1.setText("立即付款");
                        orderBt2.setText("取消订单");
                        orderBt3.setVisibility(View.GONE);
                        if (mallOrderDetailsBean != null) {
                            time = mallOrderDetailsBean.getData().getFukuantime();
                        }

                        orderBt1.setOnClickListener(new View.OnClickListener() {
                            @Override
                            public void onClick(View view) {
                                Intent intent = new Intent(context, ToPayActivity.class);
                                intent.putExtra("intentType", intentType);
                                intent.putExtra("id", order_sn);
                                intent.putExtra("price", orderPrice);
                                context.startActivity(intent);
                            }
                        });
                        orderBt2.setOnClickListener(new View.OnClickListener() {
                            @Override
                            public void onClick(View view) {
                                createDel("温馨提示", "确认取消订单吗？", "点错了", "确认", order_id, 7);
                            }
                        });
                        break;
                    case 2:
                        bottombar.setVisibility(View.VISIBLE);
                        orderBt1.setText("修改价格");
                        orderBt2.setVisibility(View.GONE);
                        orderBt3.setVisibility(View.GONE);
                        if (weddingOrderDetailsBean != null) {
                            time = weddingOrderDetailsBean.getFukuantime();
                        }

                        orderBt1.setOnClickListener(new View.OnClickListener() {
                            @Override
                            public void onClick(View view) {
                                //修改价格的操作
                                Intent intent = new Intent(mContext, EditPriceActivity.class);
                                intent.putExtra("intentType", intentType);
                                intent.putExtra("type", 1);
                                intent.putExtra("weddingBean", weddingOrderDetailsBean);
                                mContext.startActivity(intent);
                            }
                        });
                        break;
                    case 3:
                        bottombar.setVisibility(View.VISIBLE);
                        orderBt1.setText("修改价格");
                        orderBt2.setVisibility(View.GONE);
                        orderBt3.setVisibility(View.GONE);

                        orderBt1.setOnClickListener(new View.OnClickListener() {
                            @Override
                            public void onClick(View view) {
                                //修改价格的操作
                                Intent intent = new Intent(mContext, EditPriceActivity.class);
                                intent.putParcelableArrayListExtra("bean", (ArrayList<MallOrderDetailsBean.DataBean.GoodsBean>) mallOrderDetailsBean.getData().getGoods());
                                intent.putExtra("order_id", order_id);
                                intent.putExtra("intentType", intentType);
                                intent.putExtra("type", 1);
                                mContext.startActivity(intent);
                            }
                        });
                        break;
                }
                break;
            case 60://待接单 待发货 已付款
                switch (intentType) {
                    case 0://0婚庆订单，1商城订单.2婚庆接单，3商城接单
                        isShowTime = true;
                        title = "等待商家接单";
                        if (weddingOrderDetailsBean != null) {
                            time = weddingOrderDetailsBean.getJiedantime();
                        }
                        bottombar.setVisibility(View.GONE);
                        break;
                    case 1:
                        title = "等待商家发货";
                        isShowTuikuanBtn = true;
                        bottombar.setVisibility(View.GONE);
                        break;
                    case 2:
                        title = "等待商家接单";
                        bottombar.setVisibility(View.VISIBLE);
                        orderBt1.setText("立即接单");
                        orderBt2.setText("拒绝接单");
                        orderBt3.setVisibility(View.GONE);

                        orderBt1.setOnClickListener(new View.OnClickListener() {
                            @Override
                            public void onClick(View view) {
                                createDel("温馨提示", "确认接单吗？", "点错了", "确认", order_id, 2);
                            }
                        });

                        orderBt2.setOnClickListener(new View.OnClickListener() {
                            @Override
                            public void onClick(View view) {
                                createDel("温馨提示", "确认拒绝接单吗？", "点错了", "确认", order_id, 3);
                            }
                        });
                        break;
                    case 3:
                        isShowTuikuanBtn = true;
                        title = "等待商家发货";
                        bottombar.setVisibility(View.VISIBLE);
                        orderBt1.setText("立即发货");
                        orderBt2.setVisibility(View.GONE);
                        orderBt3.setVisibility(View.GONE);

                        orderBt1.setOnClickListener(new View.OnClickListener() {
                            @Override
                            public void onClick(View view) {
                                Intent intent = new Intent(mContext, EditWuLiuMsgActivity.class);
                                intent.putExtra("order_id", order_id);
                                mContext.startActivity(intent);
                            }
                        });
                        break;
                }
                break;
            case 70://待服务 已发货 待收货
                isShowTime = false;
                switch (intentType) {
                    case 0://0婚庆订单，1商城订单.2婚庆接单，3商城接单
                        title = "等待商家服务";
                        switch (tuihuo) {
                            case 1://用户可以申请退款
                                bottombar.setVisibility(View.VISIBLE);
                                orderBt2.setVisibility(View.GONE);
                                orderBt3.setVisibility(View.GONE);

                                orderBt1.setText("申请退款");
                                orderBt1.setOnClickListener(new View.OnClickListener() {
                                    @Override
                                    public void onClick(View view) {
                                        Intent intent = new Intent(context, ShenQingTuikuanActivity.class);
                                        intent.putExtra("bean", weddingOrderDetailsBean);
                                        intent.putExtra("type", 1);
                                        context.startActivity(intent);
                                    }
                                });
                                break;
                            case 2://用户已申请退款
                                bottombar.setVisibility(View.VISIBLE);
                                orderBt2.setVisibility(View.GONE);
                                orderBt3.setVisibility(View.GONE);

                                orderBt1.setText("退款详情");
                                orderBt1.setOnClickListener(new View.OnClickListener() {
                                    @Override
                                    public void onClick(View view) {
                                        Intent intent = new Intent(context, NewRefundDetailsActivity.class);
                                        intent.putExtra("id", order_id);//订单id
                                        intent.putExtra("intentType", intentType);
                                        context.startActivity(intent);
                                    }
                                });
                                break;
                            case 3://同意退款
                                bottombar.setVisibility(View.VISIBLE);
                                orderBt2.setVisibility(View.GONE);
                                orderBt3.setVisibility(View.GONE);

                                orderBt1.setText("退款详情");
                                orderBt1.setOnClickListener(new View.OnClickListener() {
                                    @Override
                                    public void onClick(View view) {
                                        Intent intent = new Intent(context, NewRefundDetailsActivity.class);
                                        intent.putExtra("id", order_id);//订单id
                                        intent.putExtra("intentType", intentType);
                                        context.startActivity(intent);
                                    }
                                });
                                break;
                            case 4://拒绝退款
                                bottombar.setVisibility(View.VISIBLE);
                                orderBt2.setVisibility(View.GONE);
                                orderBt3.setVisibility(View.GONE);

                                orderBt1.setText("退款详情");
                                orderBt1.setOnClickListener(new View.OnClickListener() {
                                    @Override
                                    public void onClick(View view) {
                                        Intent intent = new Intent(context, NewRefundDetailsActivity.class);
                                        intent.putExtra("id", order_id);//订单id
                                        intent.putExtra("intentType", intentType);
                                        context.startActivity(intent);
                                    }
                                });
                                break;
                        }
                        break;
                    case 1:
                        title = "等待收货";
                        bottombar.setVisibility(View.VISIBLE);
                        orderBt3.setVisibility(View.GONE);
                        orderBt1.setText("确认收货");
                        orderBt2.setText("查看物流");

                        orderBt1.setOnClickListener(new View.OnClickListener() {
                            @Override
                            public void onClick(View view) {
                                //确认收货
                                createDel("温馨提示", "确认该订单已收货？", "点错了", "确认", order_id, 8);
                            }
                        });

                        orderBt2.setOnClickListener(new View.OnClickListener() {
                            @Override
                            public void onClick(View view) {
                                //查看物流
                                Intent intent = new Intent(mContext, ViewWuLiuActivity.class);
                                intent.putExtra("order_id", order_id);
                                mContext.startActivity(intent);
                            }
                        });

                        break;
                    case 2:
                        title = "等待商家服务";
                        bottombar.setVisibility(View.VISIBLE);
                        orderBt2.setVisibility(View.GONE);
                        orderBt3.setVisibility(View.GONE);
                        if (weddingOrderDetailsBean.getTuihuo() == 1) {
                            orderBt1.setText("订单完成");
                            orderBt1.setOnClickListener(new View.OnClickListener() {
                                @Override
                                public void onClick(View view) {
                                    //订单完成操作
                                    if (weddingOrderDetailsBean.getPaytype() == 2) {
                                        createFinishOrderServerDialog(order_id);
                                    } else {
                                        createDel("温馨提示", "确认已完成该订单服务？", "点错了", "确认", order_id, 4);
                                    }
                                }
                            });
                        } else {
                            orderBt1.setVisibility(View.GONE);
                            bottombar.setVisibility(View.GONE);
                        }
                        break;
                    case 3:
                        title = "等待收货";
                        bottombar.setVisibility(View.VISIBLE);
                        orderBt1.setText("查看物流");
                        orderBt2.setVisibility(View.GONE);
                        orderBt3.setVisibility(View.GONE);

                        orderBt1.setOnClickListener(new View.OnClickListener() {
                            @Override
                            public void onClick(View view) {
                                Intent intent = new Intent(mContext, ViewWuLiuActivity.class);
                                intent.putExtra("order_id", order_id);
                                mContext.startActivity(intent);
                            }
                        });
                        break;
                }
                break;

            case 71://已服务未付尾款
                isShowTime = false;
                switch (intentType) {
                    case 0:
                        title = "商家已服务";
                        bottombar.setVisibility(View.VISIBLE);
                        orderBt1.setText("确认完成");
                        orderBt2.setVisibility(View.GONE);
                        orderBt3.setVisibility(View.GONE);

                        orderBt1.setOnClickListener(new View.OnClickListener() {
                            @Override
                            public void onClick(View view) {
                                createDel("温馨提示", "该订单需要支付尾款才能完成，快去支付吧！", "取消", "确认", weddingOrderDetailsBean.getPid(), weddingOrderDetailsBean.getOrder_lastamount());
                            }
                        });
                        break;
                    case 1:
                        break;
                    case 2:
                        title = "商家已服务";
                        bottombar.setVisibility(View.GONE);
                        break;
                    case 3:
                        break;
                }
                break;
            case 79://已服务已付尾款
                isShowTime = false;
                switch (intentType) {
                    case 0://0婚庆订单，1商城订单.2婚庆接单，3商城接单
                        title = "商家已服务";
                        bottombar.setVisibility(View.VISIBLE);
                        orderBt1.setText("确认完成");
                        orderBt2.setVisibility(View.GONE);
                        orderBt3.setVisibility(View.GONE);

                        orderBt1.setOnClickListener(new View.OnClickListener() {
                            @Override
                            public void onClick(View view) {
                                createDel("温馨提示", "确认完成订单吗？", "点错了", "确认", order_id, 1);
                            }
                        });
                        break;
                    case 1:
                        break;
                    case 2:
                        title = "商家已服务";
                        bottombar.setVisibility(View.GONE);
                        break;
                    case 3:
                        break;
                }
                break;
            case 80://交易成功 未评价
                title = "交易成功";
                isShowTime = false;
                switch (intentType) {
                    case 0://0婚庆订单，1商城订单.2婚庆接单，3商城接单
                        bottombar.setVisibility(View.VISIBLE);
                        orderBt1.setText("立即评价");
                        orderBt2.setVisibility(View.GONE);
                        orderBt3.setVisibility(View.GONE);

                        orderBt1.setOnClickListener(new View.OnClickListener() {
                            @Override
                            public void onClick(View view) {
                                //跳转评价activity
                                Intent intent = new Intent(context, PingjiaAdapterActivity.class);
                                intent.putExtra("intentType", intentType);
                                intent.putExtra("order_id", order_id);
                                context.startActivity(intent);
                            }
                        });
                        break;
                    case 1:
                        bottombar.setVisibility(View.VISIBLE);
                        if (shifoutuikuan == 1) {
                            isShowTuikuanBtn = true;
                            isShowTuiHuo = true;
                        }
                        orderBt3.setVisibility(View.GONE);
                        orderBt1.setText("立即评价");
                        orderBt2.setText("查看物流");

                        orderBt1.setOnClickListener(new View.OnClickListener() {
                            @Override
                            public void onClick(View view) {
                                //立即评价
                                //跳转评价activity
                                Intent intent = new Intent(mContext, PingjiaAdapterActivity.class);
                                intent.putExtra("intentType", intentType);
                                intent.putExtra("order_id", order_id);
                                mContext.startActivity(intent);
                            }
                        });
                        orderBt2.setOnClickListener(new View.OnClickListener() {
                            @Override
                            public void onClick(View view) {
                                //查看物流
                                Intent intent = new Intent(mContext, ViewWuLiuActivity.class);
                                intent.putExtra("order_id", order_id);
                                mContext.startActivity(intent);
                            }
                        });

                        break;
                    case 2:
                        bottombar.setVisibility(View.GONE);
                        break;
                    case 3:
                        isShowTuikuanBtn = true;
                        bottombar.setVisibility(View.VISIBLE);
                        orderBt1.setText("查看物流");
                        orderBt2.setVisibility(View.GONE);
                        orderBt3.setVisibility(View.GONE);

                        orderBt1.setOnClickListener(new View.OnClickListener() {
                            @Override
                            public void onClick(View view) {
                                Intent intent = new Intent(mContext, ViewWuLiuActivity.class);
                                intent.putExtra("order_id", order_id);
                                mContext.startActivity(intent);
                            }
                        });
                        break;
                }
                break;
            case 90://交易成功 已评价
                title = "交易成功";
                isShowTime = false;
                switch (intentType) {
                    case 0://0婚庆订单，1商城订单.2婚庆接单，3商城接单
                        bottombar.setVisibility(View.GONE);
                        break;
                    case 1:
                        bottombar.setVisibility(View.VISIBLE);
                        if (shifoutuikuan == 1) {
                            isShowTuikuanBtn = true;
                            isShowTuiHuo = true;
                        }
                        orderBt3.setVisibility(View.GONE);
                        orderBt2.setVisibility(View.GONE);
                        orderBt1.setText("查看物流");

                        orderBt1.setOnClickListener(new View.OnClickListener() {
                            @Override
                            public void onClick(View view) {
                                //查看物流
                                Intent intent = new Intent(mContext, ViewWuLiuActivity.class);
                                intent.putExtra("order_id", order_id);
                                mContext.startActivity(intent);
                            }
                        });
                        break;
                    case 2:
                        bottombar.setVisibility(View.GONE);
                        break;
                    case 3:
                        isShowTuikuanBtn = true;

                        bottombar.setVisibility(View.VISIBLE);
                        orderBt1.setText("查看物流");
                        orderBt2.setVisibility(View.GONE);
                        orderBt3.setVisibility(View.GONE);

                        orderBt1.setOnClickListener(new View.OnClickListener() {
                            @Override
                            public void onClick(View view) {
                                Intent intent = new Intent(mContext, ViewWuLiuActivity.class);
                                intent.putExtra("order_id", order_id);
                                mContext.startActivity(intent);
                            }
                        });
                        break;
                }
                break;
            case 20://交易关闭
                title = "交易关闭";
                isShowTime = false;
                bottombar.setVisibility(View.GONE);
                switch (intentType) {
                    case 0://0婚庆订单，1商城订单.2婚庆接单，3商城接单
                        bottombar.setVisibility(View.GONE);
                        break;
                    case 1:
                        bottombar.setVisibility(View.GONE);
                        break;
                    case 2:
                        bottombar.setVisibility(View.GONE);
                        break;
                    case 3:
                        bottombar.setVisibility(View.GONE);
                        break;
                }
                break;
//            case 100://退款中
//                title = "申请退款中";
//                isShowTime = false;
//                switch (intentType) {
//                    case 0://0婚庆订单，1商城订单.2婚庆接单，3商城接单
//                        orderBt1.setText("撤销退款");
//                        orderBt2.setVisibility(View.GONE);
//                        orderBt3.setText(View.GONE);
//                        break;
//                    case 1:
//                        orderBt1.setText("撤销退款");
//                        orderBt2.setVisibility(View.GONE);
//                        orderBt3.setText(View.GONE);
//                        break;
//                    case 2:
//                        orderBt1.setText("同意退款");
//                        orderBt2.setText("拒绝退款");
//                        orderBt3.setText(View.GONE);
//                        break;
//                    case 3:
//                        orderBt1.setText("同意退款");
//                        orderBt2.setText("拒绝退款");
//                        orderBt3.setText(View.GONE);
//                        break;
//                }
//                break;

            case -1://异常
                exitWithParm();
                break;
        }
    }

    @Override
    public void loginOpinion(int code) {
        switch (code) {
            case 666:
                switch (intentType) {
                    case 0:
//                        NimUIKit.startP2PSession(this, weddingOrderDetailsBean.getShop_im());
                        break;
                    case 1:
//                        NimUIKit.startP2PSession(this, mallOrderDetailsBean.getData().getShop_im());
                        break;
                    case 2:
//                        NimUIKit.startP2PSession(this, weddingOrderDetailsBean.getUser_im());
                        break;
                    case 3:
//                        NimUIKit.startP2PSession(this, mallOrderDetailsBean.getData().getUser_im());
                        break;
                }
                break;
        }
    }


    //--------------------------------------------------------------------Holder------------------------------------------------------------------------------------
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
    class AdddressHolder extends BaseViewHolder<MallOrderDetailsBean.DataBean> {
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
        protected void bindView(MallOrderDetailsBean.DataBean dataBean) {
            tv_phone.setText(dataBean.getPostmobile() + "");
            tv_address.setText(dataBean.getPostaddress());
            tv_get_name.setText(dataBean.getPostname());
        }
    }

    //婚庆订单 item holder
    class ItemHolder extends BaseViewHolder<WeddingOrderDetailsBean> {
        @BindView(R.id.tv_name)
        TextView tvName;
        @BindView(R.id.iv_status)
        ImageView ivStatus;
        @BindView(R.id.iv_img)
        ImageView ivImg;
        @BindView(R.id.tv_title)
        TextView tvTitle;
        @BindView(R.id.tv_time)
        TextView tvTime;
        @BindView(R.id.tv_pay_type)
        TextView tvPayType;
        @BindView(R.id.line)
        View line;
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

        public ItemHolder(View itemView) {
            super(itemView);
        }

        @Override
        protected void bindView(final WeddingOrderDetailsBean bean) {
            line.setVisibility(View.GONE);
            tvName.setText(bean.getSeller_name() + "");
            tvPayType.setText("￥" + bean.getDindanzongge());
            //tvPeice.setText("￥" + bean.getBaojia_price());
            //tvTruePrice.setText("￥" + bean.getOrder_amount());
            GlideLoad.GlideLoadImg2(bean.getBaojia_image(), ivImg);
            tvTitle.setText(bean.getBaojia_name() + "");
            tvTime.setText(bean.getSpecification() + "");
            //tvDanjia.setText(Constans.RMB + bean.getPrice());
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
            //dikoutext.setVisibility(View.GONE);
            //tvDiKou.setVisibility(View.GONE);
//            if (bean.getDiscount() != null && !bean.getDiscount().equals("")) {
//                dikoutext.setVisibility(View.VISIBLE);
//                tvDiKou.setText("￥" + bean.getDiscount());
//            } else {
//                dikoutext.setVisibility(View.GONE);
//            }
            //tvNum.setText("" + bean.getQuantity());
            //llTongji.setVisibility(View.GONE);
            rlButton.setVisibility(View.GONE);
            ivStatus.setVisibility(View.GONE);

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

            itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Intent intent = new Intent(NewOrderDetailsActivity.this, NewBaijiaDetailsActivity.class);
                    intent.putExtra("offoer_id", bean.getBaojia_id());
                    startActivity(intent);
                }
            });
        }

    }

    //婚庆订单 info holder
    class InfoHolder extends BaseViewHolder<WeddingOrderDetailsBean> {
        @BindView(R.id.tv_all_price)
        TextView tv_all_price;
        @BindView(R.id.tv_dikou)
        TextView tv_dikou;
        @BindView(R.id.tv_all_dingjin)
        TextView tv_all_dingjin;
        @BindView(R.id.tv_fanxain)
        TextView tv_fanxain;
        @BindView(R.id.tv_all_pay_price)
        TextView tv_all_pay_price;
        @BindView(R.id.tv_pay_price)
        TextView tv_pay_price;
        @BindView(R.id.tv_payed_price)
        TextView tv_payed_price;
        @BindView(R.id.tv_order_id)
        TextView tv_order_id;
        @BindView(R.id.tv_order_create_time)
        TextView tv_order_create_time;
        @BindView(R.id.tv_first_pay_time)
        TextView tv_first_pay_time;
        @BindView(R.id.tv_end_pay_time)
        TextView tv_end_pay_time;
        @BindView(R.id.tv_finish_time)
        TextView tv_finish_time;
        @BindView(R.id.ll_contact)
        LinearLayout ll_contact;
        @BindView(R.id.ll_call)
        LinearLayout ll_call;
        @BindView(R.id.order_bt_copy)
        TextView order_bt_copy;

        public InfoHolder(View itemView) {
            super(itemView);
            ll_call.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    if (phoneNum != null) {
                        Intent intent = new Intent(Intent.ACTION_DIAL, Uri.parse("tel:" + phoneNum));
                        intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                        startActivity(intent);
                    } else {
                        NToast.show("抱歉，暂时没有该商家的联系方式！");
                    }
                }
            });
            ll_contact.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    LoginHepler.LoginHepler(mContext, 666, true, NewOrderDetailsActivity.this);
                }
            });
            order_bt_copy.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    ClipboardManager clip = (ClipboardManager) context.getSystemService(Context.CLIPBOARD_SERVICE);
                    clip.setText(tv_order_id.getText()); // 复制
                    NToast.show("复制成功！");
                }
            });
        }

        @Override
        protected void bindView(WeddingOrderDetailsBean weddingOrderDetailsBean) {
            tv_all_price.setText("￥" + weddingOrderDetailsBean.getShangpingjongjia());
            tv_dikou.setText("￥" + weddingOrderDetailsBean.getDikouzongge());
            tv_all_dingjin.setText("￥" + weddingOrderDetailsBean.getDindanzongge());
            tv_fanxain.setText(weddingOrderDetailsBean.getFanjifen() + "积分");
            tv_all_pay_price.setText("￥" + weddingOrderDetailsBean.getYingfuzonge());
            tv_pay_price.setText("￥" + weddingOrderDetailsBean.getYingfujine());
            tv_payed_price.setText("￥" + weddingOrderDetailsBean.getYifuzonge());
            tv_order_id.setText("订单编号：" + weddingOrderDetailsBean.getPid());
            tv_order_create_time.setText("下单时间：" + weddingOrderDetailsBean.getPublished());
            tv_first_pay_time.setText("初次付款时间：" + weddingOrderDetailsBean.getPay_time());
            tv_end_pay_time.setText("尾款付款时间：" + weddingOrderDetailsBean.getWkpay_time());
            tv_finish_time.setText("完成时间：" + weddingOrderDetailsBean.getSureok_time());
        }
    }

    //商城订单 item holder
    class MallItemHolder extends BaseViewHolder<MallOrderDetailsBean> {
        @BindView(R.id.tv_name)
        TextView tvName;
        @BindView(R.id.iv_status)
        ImageView ivStatus;
        @BindView(R.id.recycleview)
        RecyclerView recycleview;
        @BindView(R.id.tv_goods_num)
        TextView tvGoodsNum;
        @BindView(R.id.tv_peice)
        TextView tvPeice;
        @BindView(R.id.tv_true_price)
        TextView tvTruePrice;
        @BindView(R.id.ll_true_price)
        LinearLayout llTruePrice;
        @BindView(R.id.ll_tongji)
        LinearLayout llTongji;
        @BindView(R.id.line)
        View line;
        @BindView(R.id.qq)
        TextView qq;
        @BindView(R.id.time)
        TextView time;
        @BindView(R.id.cancelbtn)
        TextView cancelbtn;
        @BindView(R.id.surebtn)
        TextView surebtn;
        @BindView(R.id.rl_button)
        RelativeLayout rlButton;

        public MallItemHolder(View itemView) {
            super(itemView);
        }

        @Override
        protected void bindView(MallOrderDetailsBean bean) {
            line.setVisibility(View.GONE);
            llTongji.setVisibility(View.GONE);
            rlButton.setVisibility(View.GONE);
            ivStatus.setVisibility(View.GONE);
            tvName.setText(bean.getData().getSeller_name() + "");
            tvPeice.setText("￥" + bean.getData().getShangpingjongjia());
            tvTruePrice.setText("￥" + bean.getData().getOrder_amount());
            LinearLayoutManager manager = new LinearLayoutManager(mContext) {
                @Override
                public boolean canScrollVertically() {
                    return false;
                }
            };
            recycleview.setLayoutManager(manager);
            GoodsAdapter goodsAdapter = new GoodsAdapter();
            recycleview.setAdapter(goodsAdapter);
            goodsAdapter.setList(bean.getData().getGoods());
        }

        public class GoodsAdapter extends RecyclerView.Adapter<GoodsAdapter.VH> {
            private List<MallOrderDetailsBean.DataBean.GoodsBean> list;

            public void setList(List<MallOrderDetailsBean.DataBean.GoodsBean> list) {
                this.list = list;
                notifyDataSetChanged();
            }

            @Override
            public GoodsAdapter.VH onCreateViewHolder(ViewGroup parent, int viewType) {
                View view = LayoutInflater.from(mContext).inflate(R.layout.item_sure_item_layout, parent, false);
                return new VH(view);
            }

            @Override
            public void onBindViewHolder(GoodsAdapter.VH vh, final int position) {

                if (isShowTuikuanBtn) {
                    vh.tvTuikuanbtn.setVisibility(View.VISIBLE);
                    vh.tvTuikuanbtn.setText("退款详情");
                    vh.tvTuikuanbtn.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            Intent intent = new Intent(mContext, NewRefundDetailsActivity.class);
                            intent.putExtra("intentType", intentType);
                            intent.putExtra("id", list.get(position).getRec_id());
                            mContext.startActivity(intent);
                        }
                    });
                }

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
                        vh.tvTuikuanbtn.setText("退款");
                        vh.tvTuikuanbtn.setOnClickListener(new View.OnClickListener() {
                            @Override
                            public void onClick(View view) {
//                                Intent intent = new Intent(mContext, ShenQingTuikuanActivity.class);
//                                intent.putExtra("bean", mallOrderDetailsBean.getData().getGoods());
//                                intent.putExtra("intentType", intentType);
//                                intent.putExtra("type", 1);
//                                mContext.startActivity(intent);
                                Intent intent = new Intent(mContext, TuikuanTypeActivity.class);
                                intent.putExtra("bean", list.get(position));
                                intent.putExtra("isShowTuiHuo", isShowTuiHuo);
                                intent.putExtra("intentType", intentType);
                                mContext.startActivity(intent);
                            }
                        });
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
                @BindView(R.id.tv_tuikuanbtn)
                TextView tvTuikuanbtn;

                VH(View view) {
                    super(view);
                    ButterKnife.bind(this, view);
                }
            }
        }
    }

    //商城订单 info holder
    class MallInfoHolder extends BaseViewHolder<MallOrderDetailsBean> {
        @BindView(R.id.tv_all_price)
        TextView tv_all_price;
        @BindView(R.id.tv_dikou)
        TextView tv_dikou;
        @BindView(R.id.tv_all_pay_price)
        TextView tv_all_pay_price;
        @BindView(R.id.tv_payed_price)
        TextView tv_payed_price;
        @BindView(R.id.tv_order_id)
        TextView tv_order_id;
        @BindView(R.id.tv_order_create_time)
        TextView tv_order_create_time;
        @BindView(R.id.tv_first_pay_time)
        TextView tv_first_pay_time;
        @BindView(R.id.tv_finish_time)
        TextView tv_finish_time;
        @BindView(R.id.ll_contact)
        LinearLayout ll_contact;
        @BindView(R.id.ll_call)
        LinearLayout ll_call;
        @BindView(R.id.order_bt_copy)
        TextView order_bt_copy;
        @BindView(R.id.tv_jifen)
        TextView tv_jifen;

        public MallInfoHolder(View itemView) {
            super(itemView);
            ll_call.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    if (phoneNum != null) {
                        Intent intent = new Intent(Intent.ACTION_DIAL, Uri.parse("tel:" + phoneNum));
                        intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                        startActivity(intent);
                    } else {
                        NToast.show("抱歉，暂时没有该商家的联系方式！");
                    }
                }
            });
            ll_contact.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    LoginHepler.LoginHepler(mContext, 666, true, NewOrderDetailsActivity.this);
                }
            });
            order_bt_copy.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    ClipboardManager clip = (ClipboardManager) context.getSystemService(Context.CLIPBOARD_SERVICE);
                    clip.setText(tv_order_id.getText()); // 复制
                    NToast.show("复制成功！");
                }
            });
        }

        @Override
        protected void bindView(MallOrderDetailsBean weddingOrderDetailsBean) {
            tv_all_price.setText("￥" + weddingOrderDetailsBean.getData().getShangpingjongjia());
            tv_dikou.setText("￥" + weddingOrderDetailsBean.getData().getDikouzongge());
            tv_jifen.setText(weddingOrderDetailsBean.getData().getFanjifen() + "积分");
            tv_all_pay_price.setText("￥" + weddingOrderDetailsBean.getData().getYingfuzonge());
            tv_payed_price.setText("￥" + weddingOrderDetailsBean.getData().getYifuzonge());
            tv_order_id.setText("订单编号：" + weddingOrderDetailsBean.getData().getPid());
            tv_order_create_time.setText("下单时间：" + weddingOrderDetailsBean.getData().getPublished());
            tv_first_pay_time.setText("付款时间：" + weddingOrderDetailsBean.getData().getPay_time());
            tv_finish_time.setText("完成时间：" + weddingOrderDetailsBean.getData().getReceived_time());
        }
    }

    //婚庆接单 item holder
    class ItemJieDanHolder extends BaseViewHolder<WeddingOrderDetailsBean> {
        @BindView(R.id.tv_name)
        TextView tvName;
        @BindView(R.id.iv_status)
        ImageView ivStatus;
        @BindView(R.id.iv_img)
        ImageView ivImg;
        @BindView(R.id.tv_title)
        TextView tvTitle;
        @BindView(R.id.tv_time)
        TextView tvTime;
        @BindView(R.id.tv_pay_type)
        TextView tvPayType;
        @BindView(R.id.line)
        View line;
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

        public ItemJieDanHolder(View itemView) {
            super(itemView);
        }

        @Override
        protected void bindView(final WeddingOrderDetailsBean bean) {
            line.setVisibility(View.GONE);
            tvName.setText(bean.getSeller_name() + "");
            //tvPeice.setText("￥" + bean.getBaojia_price());
            //tvTruePrice.setText("￥" + bean.getOrder_amount());
            tvPayType.setText("￥" + bean.getDindanzongge());
            GlideLoad.GlideLoadImg2(bean.getBaojia_image(), ivImg);
            tvTitle.setText(bean.getBaojia_name() + "");
            tvTime.setText(bean.getSpecification() + "");
            //tvDanjia.setText(Constans.RMB + bean.getPrice());

            //dikoutext.setVisibility(View.GONE);
            //tvDiKou.setVisibility(View.GONE);
//            if (bean.getDiscount() != null && !bean.getDiscount().equals("")) {
//                dikoutext.setVisibility(View.VISIBLE);
//                tvDiKou.setText("￥" + bean.getDiscount());
//            } else {
//                dikoutext.setVisibility(View.GONE);
//            }
            //tvNum.setText("" + bean.getQuantity());
            //llTongji.setVisibility(View.GONE);
            rlButton.setVisibility(View.GONE);
            ivStatus.setVisibility(View.GONE);

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

            //标记商品是否处于退款状态
            switch (bean.getTuihuo()) {
                case 1://用户可以申请退款
                    tvStatus.setVisibility(View.GONE);
                    break;
                case 2://2是退款中
                    bottombar.setVisibility(View.VISIBLE);
                    orderBt2.setVisibility(View.VISIBLE);
                    orderBt3.setVisibility(View.VISIBLE);
                    tvStatus.setVisibility(View.VISIBLE);

                    tvStatus.setText("退款中");
                    orderBt2.setText("同意退款");
                    orderBt3.setText("拒绝退款");

                    orderBt2.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            createDel("温馨提示", "确认同意该订单的退款请求？", "点错了", "确认", order_id, 5);
                        }
                    });
                    orderBt3.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            Intent intent = new Intent(mContext, RefuseReasonActivity.class);
                            intent.putExtra("order_id", order_id);
                            mContext.startActivity(intent);
                        }
                    });
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

            itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Intent intent = new Intent(NewOrderDetailsActivity.this, NewBaijiaDetailsActivity.class);
                    intent.putExtra("offoer_id", bean.getBaojia_id());
                    startActivity(intent);
                }
            });
        }

    }

    //婚庆接单 info holder
    class InfoJieDanHolder extends BaseViewHolder<WeddingOrderDetailsBean> {
        @BindView(R.id.tv_all_price)
        TextView tv_all_price;
        @BindView(R.id.tv_dikou)
        TextView tv_dikou;
        @BindView(R.id.tv_all_dingjin)
        TextView tv_all_dingjin;
        @BindView(R.id.tv_fanxain)
        TextView tv_fanxain;
        @BindView(R.id.tv_all_pay_price)
        TextView tv_all_pay_price;
        @BindView(R.id.tv_pay_price)
        TextView tv_pay_price;
        @BindView(R.id.tv_payed_price)
        TextView tv_payed_price;
        @BindView(R.id.tv_order_id)
        TextView tv_order_id;
        @BindView(R.id.tv_order_create_time)
        TextView tv_order_create_time;
        @BindView(R.id.tv_first_pay_time)
        TextView tv_first_pay_time;
        @BindView(R.id.tv_end_pay_time)
        TextView tv_end_pay_time;
        @BindView(R.id.tv_finish_time)
        TextView tv_finish_time;
        @BindView(R.id.ll_contact)
        LinearLayout ll_contact;
        @BindView(R.id.ll_call)
        LinearLayout ll_call;
        @BindView(R.id.order_bt_copy)
        TextView order_bt_copy;
        @BindView(R.id.im_text)
        TextView im_text;
        @BindView(R.id.ll_jifen)
        LinearLayout ll_jifen;

        public InfoJieDanHolder(View itemView) {
            super(itemView);
            ll_call.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    if (phoneNum != null) {
                        Intent intent = new Intent(Intent.ACTION_DIAL, Uri.parse("tel:" + phoneNum));
                        intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                        startActivity(intent);
                    } else {
                        NToast.show("抱歉，暂时没有该买家的联系方式！");
                    }
                }
            });
            ll_contact.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    LoginHepler.LoginHepler(mContext, 666, true, NewOrderDetailsActivity.this);
                }
            });
            order_bt_copy.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    ClipboardManager clip = (ClipboardManager) context.getSystemService(Context.CLIPBOARD_SERVICE);
                    clip.setText(tv_order_id.getText()); // 复制
                    NToast.show("复制成功！");
                }
            });
        }

        @Override
        protected void bindView(WeddingOrderDetailsBean weddingOrderDetailsBean) {
            ll_jifen.setVisibility(View.GONE);
            im_text.setText("联系买家");
            tv_all_price.setText("￥" + weddingOrderDetailsBean.getShangpingjongjia());
            tv_dikou.setText("￥" + weddingOrderDetailsBean.getDikouzongge());
            tv_all_dingjin.setText("￥" + weddingOrderDetailsBean.getDindanzongge());
            tv_fanxain.setText(weddingOrderDetailsBean.getFanjifen() + "积分");
            tv_all_pay_price.setText("￥" + weddingOrderDetailsBean.getYingfuzonge());
            tv_pay_price.setText("￥" + weddingOrderDetailsBean.getYingfujine());
            tv_payed_price.setText("￥" + weddingOrderDetailsBean.getYifuzonge());
            tv_order_id.setText("订单编号：" + weddingOrderDetailsBean.getPid());
            tv_order_create_time.setText("下单时间：" + weddingOrderDetailsBean.getPublished());
            tv_first_pay_time.setText("初次付款时间：" + weddingOrderDetailsBean.getPay_time());
            tv_end_pay_time.setText("尾款付款时间：" + weddingOrderDetailsBean.getWkpay_time());
            tv_finish_time.setText("完成时间：" + weddingOrderDetailsBean.getSureok_time());
        }
    }

    //商城接单 item holder
    class MallItemJieDanHolder extends BaseViewHolder<MallOrderDetailsBean> {
        @BindView(R.id.tv_name)
        TextView tvName;
        @BindView(R.id.iv_status)
        ImageView ivStatus;
        @BindView(R.id.recycleview)
        RecyclerView recycleview;
        @BindView(R.id.tv_goods_num)
        TextView tvGoodsNum;
        @BindView(R.id.tv_peice)
        TextView tvPeice;
        @BindView(R.id.tv_true_price)
        TextView tvTruePrice;
        @BindView(R.id.ll_true_price)
        LinearLayout llTruePrice;
        @BindView(R.id.ll_tongji)
        LinearLayout llTongji;
        @BindView(R.id.line)
        View line;
        @BindView(R.id.qq)
        TextView qq;
        @BindView(R.id.time)
        TextView time;
        @BindView(R.id.cancelbtn)
        TextView cancelbtn;
        @BindView(R.id.surebtn)
        TextView surebtn;
        @BindView(R.id.rl_button)
        RelativeLayout rlButton;

        public MallItemJieDanHolder(View itemView) {
            super(itemView);
        }

        @Override
        protected void bindView(MallOrderDetailsBean bean) {
            line.setVisibility(View.GONE);
            llTongji.setVisibility(View.GONE);
            rlButton.setVisibility(View.GONE);
            ivStatus.setVisibility(View.GONE);
            tvName.setText(bean.getData().getSeller_name() + "");
            tvPeice.setText("￥" + bean.getData().getShangpingjongjia());
            tvTruePrice.setText("￥" + bean.getData().getOrder_amount());
            LinearLayoutManager manager = new LinearLayoutManager(mContext) {
                @Override
                public boolean canScrollVertically() {
                    return false;
                }
            };
            recycleview.setLayoutManager(manager);
            GoodsAdapter goodsAdapter = new GoodsAdapter();
            recycleview.setAdapter(goodsAdapter);
            goodsAdapter.setList(bean.getData().getGoods());
        }

        public class GoodsAdapter extends RecyclerView.Adapter<GoodsAdapter.VH> {
            private List<MallOrderDetailsBean.DataBean.GoodsBean> list;

            public void setList(List<MallOrderDetailsBean.DataBean.GoodsBean> list) {
                this.list = list;
                notifyDataSetChanged();
            }

            @Override
            public GoodsAdapter.VH onCreateViewHolder(ViewGroup parent, int viewType) {
                View view = LayoutInflater.from(mContext).inflate(R.layout.item_sure_item_layout, parent, false);
                return new VH(view);
            }

            @Override
            public void onBindViewHolder(GoodsAdapter.VH vh, final int position) {

                if (isShowTuikuanBtn) {
                    vh.tvTuikuanbtn.setVisibility(View.VISIBLE);
                    vh.tvTuikuanbtn.setText("退款详情");
                    vh.tvTuikuanbtn.setOnClickListener(new View.OnClickListener() {
                        @Override
                        public void onClick(View view) {
                            Intent intent = new Intent(mContext, NewRefundDetailsActivity.class);
                            intent.putExtra("intentType", intentType);
                            intent.putExtra("id", list.get(position).getRec_id());
                            mContext.startActivity(intent);
                        }
                    });
                }

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
                        vh.tvTuikuanbtn.setVisibility(View.GONE);
//                        vh.tvTuikuanbtn.setText("退款");
//                        vh.tvTuikuanbtn.setOnClickListener(new View.OnClickListener() {
//                            @Override
//                            public void onClick(View view) {
//
//
//                            }
//                        });
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
                @BindView(R.id.tv_tuikuanbtn)
                TextView tvTuikuanbtn;

                VH(View view) {
                    super(view);
                    ButterKnife.bind(this, view);
                }
            }
        }
    }

    //商城接单 info holder
    class MallInfoJieDanHolder extends BaseViewHolder<MallOrderDetailsBean> {
        @BindView(R.id.tv_all_price)
        TextView tv_all_price;
        @BindView(R.id.tv_dikou)
        TextView tv_dikou;
        @BindView(R.id.tv_all_pay_price)
        TextView tv_all_pay_price;
        @BindView(R.id.tv_payed_price)
        TextView tv_payed_price;
        @BindView(R.id.tv_order_id)
        TextView tv_order_id;
        @BindView(R.id.tv_order_create_time)
        TextView tv_order_create_time;
        @BindView(R.id.tv_first_pay_time)
        TextView tv_first_pay_time;
        @BindView(R.id.tv_finish_time)
        TextView tv_finish_time;
        @BindView(R.id.ll_contact)
        LinearLayout ll_contact;
        @BindView(R.id.ll_call)
        LinearLayout ll_call;
        @BindView(R.id.order_bt_copy)
        TextView order_bt_copy;
        @BindView(R.id.im_text)
        TextView im_text;
        @BindView(R.id.tv_jifen)
        TextView tv_jifen;

        public MallInfoJieDanHolder(View itemView) {
            super(itemView);
            ll_call.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    if (phoneNum != null) {
                        Intent intent = new Intent(Intent.ACTION_DIAL, Uri.parse("tel:" + phoneNum));
                        intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                        startActivity(intent);
                    } else {
                        NToast.show("抱歉，暂时没有该买家的联系方式！");
                    }
                }
            });
            ll_contact.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    LoginHepler.LoginHepler(mContext, 666, true, NewOrderDetailsActivity.this);
                }
            });
            order_bt_copy.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    ClipboardManager clip = (ClipboardManager) context.getSystemService(Context.CLIPBOARD_SERVICE);
                    clip.setText(tv_order_id.getText()); // 复制
                    NToast.show("复制成功！");
                }
            });
        }

        @Override
        protected void bindView(MallOrderDetailsBean weddingOrderDetailsBean) {
            im_text.setText("联系买家");
            tv_all_price.setText("￥" + weddingOrderDetailsBean.getData().getShangpingjongjia());
            tv_jifen.setText(weddingOrderDetailsBean.getData().getFanjifen() + "积分");
            tv_dikou.setText("￥" + weddingOrderDetailsBean.getData().getDikouzongge());
            tv_all_pay_price.setText("￥" + weddingOrderDetailsBean.getData().getYingfuzonge());
            tv_payed_price.setText("￥" + weddingOrderDetailsBean.getData().getYifuzonge());
            tv_order_id.setText("订单编号：" + weddingOrderDetailsBean.getData().getPid());
            tv_order_create_time.setText("下单时间：" + weddingOrderDetailsBean.getData().getPublished());
            tv_first_pay_time.setText("付款时间：" + weddingOrderDetailsBean.getData().getPay_time());
            tv_finish_time.setText("完成时间：" + weddingOrderDetailsBean.getData().getReceived_time());
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

    //婚庆订单 猜你喜欢 Holder
    class WeddingGuessYouLikeHolder extends BaseViewHolder<WeddingOrderDetailsBean.YoulikeBean> {
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
                    Intent intent = new Intent(context, NewBaijiaDetailsActivity.class);
                    intent.putExtra("offoer_id", id);
                    context.startActivity(intent);
                }
            });
        }

        @Override
        protected void bindView(WeddingOrderDetailsBean.YoulikeBean baojiaBean) {
            id = baojiaBean.getQuotationid();
            tvContext.setVisibility(View.GONE);
            tvSaleCount.setVisibility(View.VISIBLE);
            tvSeeCount.setVisibility(View.GONE);
            tvSaleCount.setText("已售 " + baojiaBean.getNum());
            tvPrice.setText(Constans.RMB + baojiaBean.getPrice());
            tvTitle.setText("" + baojiaBean.getName());
            GlideLoad.GlideLoadImg2(baojiaBean.getImglist().get(0), ivImg);
        }
    }

    //商城订单 猜你喜欢 Holder
    class MallGuessYouLikeHolder extends BaseViewHolder<MallOrderDetailsBean.YoulikeBean> {
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
        private int id;//商品id

        public MallGuessYouLikeHolder(View itemView) {
            super(itemView);
            itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Intent intent = new Intent(context, NewGoodsDetailsActivity.class);
                    intent.putExtra("goods_id", id);
                    context.startActivity(intent);
                }
            });
        }

        @Override
        protected void bindView(MallOrderDetailsBean.YoulikeBean youlikeBean) {
            ViewUtil.setNumOfScreenWidth(mContext, ivImg, 2);

            id = youlikeBean.getGoods_id();
            tvContext.setVisibility(View.GONE);
            tvSaleCount.setVisibility(View.VISIBLE);
            tvSeeCount.setVisibility(View.GONE);
            tvSaleCount.setText("已售 " + youlikeBean.getNum());
            tvPrice.setText(Constans.RMB + youlikeBean.getPrice());
            tvTitle.setText("" + youlikeBean.getPcolumnname());
            GlideLoad.GlideLoadImg2(youlikeBean.getShopimg().get(0), ivImg);
        }
    }

    private void getWeddingOrderData() {
        if (order_id != -1) {
            ApiManager.getWeddingOrderDetails(order_id, new OnRequestFinish<BaseBean<WeddingOrderDetailsBean>>() {
                @Override
                public void onFinished() {
                    refreshLayout.finishRefresh();
                }

                @Override
                public void onSuccess(BaseBean<WeddingOrderDetailsBean> data) {
                    weddingOrderDetailsBean = data.getData();
                    order_sn = weddingOrderDetailsBean.getPid();
                    phoneNum = weddingOrderDetailsBean.getMobile();
                    orderPrice = weddingOrderDetailsBean.getYingfujine();
                    ctrlViewByType(weddingOrderDetailsBean.getStatus(), weddingOrderDetailsBean.getTuihuo(), weddingOrderDetailsBean.getOrder_id());
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
                            .injectHolderDelegate(new CreateHolderDelegate<WeddingOrderDetailsBean>() {
                                @Override
                                protected int onSpanSize() {
                                    return 2;
                                }

                                @Override
                                protected int getLayoutRes() {
                                    return R.layout.wedding_order_list_item;
                                }

                                @Override
                                protected BaseViewHolder onCreateHolder(View itemView) {
                                    return new ItemHolder(itemView);
                                }
                            }.cleanAfterAddData(weddingOrderDetailsBean))
                            .injectHolderDelegate(new CreateHolderDelegate<WeddingOrderDetailsBean>() {
                                @Override
                                protected int onSpanSize() {
                                    return 2;
                                }

                                @Override
                                protected int getLayoutRes() {
                                    return R.layout.new_order_details_info;
                                }

                                @Override
                                protected BaseViewHolder onCreateHolder(View itemView) {
                                    return new InfoHolder(itemView);
                                }
                            }.cleanAfterAddData(weddingOrderDetailsBean))

                            .injectHolderDelegate(new TitleDelegate().addData(R.mipmap.icon_guess_love))
                            .injectHolderDelegate(new CreateHolderDelegate<WeddingOrderDetailsBean.YoulikeBean>() {

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
                            }.cleanAfterAddAllData(weddingOrderDetailsBean.getYoulike()))
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

    private void getMallOrderData(int status) {
        if (order_id != -1) {
            ApiManager.getMallOrderDetails(order_id, status, new OnRequestFinish<BaseBean<MallOrderDetailsBean>>() {
                @Override
                public void onFinished() {
                    refreshLayout.finishRefresh();
                }

                @Override
                public void onSuccess(BaseBean<MallOrderDetailsBean> data) {
                    mallOrderDetailsBean = data.getData();
                    order_sn = mallOrderDetailsBean.getData().getPid();
                    phoneNum = mallOrderDetailsBean.getData().getShop_mobile();
                    shifoutuikuan = mallOrderDetailsBean.getData().getShifoutuikuan();
                    orderPrice = mallOrderDetailsBean.getData().getYingfujine();
                    ctrlViewByType(mallOrderDetailsBean.getData().getStatus(), mallOrderDetailsBean.getData().getTuihuo(), mallOrderDetailsBean.getData().getOrder_id());
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
                            .injectHolderDelegate(new CreateHolderDelegate<MallOrderDetailsBean.DataBean>() {
                                @Override
                                protected int onSpanSize() {
                                    return 2;
                                }

                                @Override
                                protected int getLayoutRes() {
                                    return R.layout.order_details_address_layout;
                                }

                                @Override
                                protected BaseViewHolder onCreateHolder(View itemView) {
                                    return new AdddressHolder(itemView);
                                }
                            }.addData(mallOrderDetailsBean.getData()))
                            .injectHolderDelegate(new CreateHolderDelegate<MallOrderDetailsBean>() {
                                @Override
                                protected int onSpanSize() {
                                    return 2;
                                }

                                @Override
                                protected int getLayoutRes() {
                                    return R.layout.new_mall_order_details_layout;
                                }

                                @Override
                                protected BaseViewHolder onCreateHolder(View itemView) {
                                    return new MallItemHolder(itemView);
                                }
                            }.cleanAfterAddData(mallOrderDetailsBean))
                            .injectHolderDelegate(new CreateHolderDelegate<MallOrderDetailsBean>() {
                                @Override
                                protected int onSpanSize() {
                                    return 2;
                                }

                                @Override
                                protected int getLayoutRes() {
                                    return R.layout.new_order_mall_details_info;
                                }

                                @Override
                                protected BaseViewHolder onCreateHolder(View itemView) {
                                    return new MallInfoHolder(itemView);
                                }
                            }.cleanAfterAddData(mallOrderDetailsBean))

                            .injectHolderDelegate(new TitleDelegate().addData(R.mipmap.icon_guess_love))
                            .injectHolderDelegate(new CreateHolderDelegate<MallOrderDetailsBean.YoulikeBean>() {

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
                                    return new MallGuessYouLikeHolder(itemView);
                                }
                            }.cleanAfterAddAllData(mallOrderDetailsBean.getYoulike()))
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

    private void getWeddingJieDanOrderData() {
        if (order_id != -1) {
            ApiManager.getWeddingOrderDetails(order_id, new OnRequestFinish<BaseBean<WeddingOrderDetailsBean>>() {
                @Override
                public void onFinished() {
                    refreshLayout.finishRefresh();
                }

                @Override
                public void onSuccess(BaseBean<WeddingOrderDetailsBean> data) {
                    weddingOrderDetailsBean = data.getData();
                    order_sn = weddingOrderDetailsBean.getPid();
                    phoneNum = weddingOrderDetailsBean.getMobile();
                    orderPrice = weddingOrderDetailsBean.getYingfujine();
                    ctrlViewByType(weddingOrderDetailsBean.getStatus(), weddingOrderDetailsBean.getTuihuo(), weddingOrderDetailsBean.getOrder_id());
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
                            .injectHolderDelegate(new CreateHolderDelegate<WeddingOrderDetailsBean>() {
                                @Override
                                protected int onSpanSize() {
                                    return 2;
                                }

                                @Override
                                protected int getLayoutRes() {
                                    return R.layout.wedding_order_list_item;
                                }

                                @Override
                                protected BaseViewHolder onCreateHolder(View itemView) {
                                    return new ItemJieDanHolder(itemView);
                                }
                            }.cleanAfterAddData(weddingOrderDetailsBean))
                            .injectHolderDelegate(new CreateHolderDelegate<WeddingOrderDetailsBean>() {
                                @Override
                                protected int onSpanSize() {
                                    return 2;
                                }

                                @Override
                                protected int getLayoutRes() {
                                    return R.layout.new_order_details_info;
                                }

                                @Override
                                protected BaseViewHolder onCreateHolder(View itemView) {
                                    return new InfoJieDanHolder(itemView);
                                }
                            }.cleanAfterAddData(weddingOrderDetailsBean))

                            .injectHolderDelegate(new TitleDelegate().addData(R.mipmap.icon_guess_love))
                            .injectHolderDelegate(new CreateHolderDelegate<WeddingOrderDetailsBean.YoulikeBean>() {

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
                            }.cleanAfterAddAllData(weddingOrderDetailsBean.getYoulike()))
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

    private void getMallJieDanOrderData(int status) {
        if (order_id != -1) {
            ApiManager.getMallOrderDetails(order_id, status, new OnRequestFinish<BaseBean<MallOrderDetailsBean>>() {
                @Override
                public void onFinished() {
                    refreshLayout.finishRefresh();
                }

                @Override
                public void onSuccess(BaseBean<MallOrderDetailsBean> data) {
                    mallOrderDetailsBean = data.getData();
                    order_sn = mallOrderDetailsBean.getData().getPid();
                    phoneNum = mallOrderDetailsBean.getData().getShop_mobile();
                    orderPrice = mallOrderDetailsBean.getData().getYingfujine();
                    ctrlViewByType(mallOrderDetailsBean.getData().getStatus(), mallOrderDetailsBean.getData().getTuihuo(), mallOrderDetailsBean.getData().getOrder_id());
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
                            .injectHolderDelegate(new CreateHolderDelegate<MallOrderDetailsBean.DataBean>() {
                                @Override
                                protected int onSpanSize() {
                                    return 2;
                                }

                                @Override
                                protected int getLayoutRes() {
                                    return R.layout.order_details_address_layout;
                                }

                                @Override
                                protected BaseViewHolder onCreateHolder(View itemView) {
                                    return new AdddressHolder(itemView);
                                }
                            }.addData(mallOrderDetailsBean.getData()))
                            .injectHolderDelegate(new CreateHolderDelegate<MallOrderDetailsBean>() {
                                @Override
                                protected int onSpanSize() {
                                    return 2;
                                }

                                @Override
                                protected int getLayoutRes() {
                                    return R.layout.new_mall_order_details_layout;
                                }

                                @Override
                                protected BaseViewHolder onCreateHolder(View itemView) {
                                    return new MallItemJieDanHolder(itemView);
                                }
                            }.cleanAfterAddData(mallOrderDetailsBean))
                            .injectHolderDelegate(new CreateHolderDelegate<MallOrderDetailsBean>() {
                                @Override
                                protected int onSpanSize() {
                                    return 2;
                                }

                                @Override
                                protected int getLayoutRes() {
                                    return R.layout.new_order_mall_details_info;
                                }

                                @Override
                                protected BaseViewHolder onCreateHolder(View itemView) {
                                    return new MallInfoJieDanHolder(itemView);
                                }
                            }.cleanAfterAddData(mallOrderDetailsBean))

                            .injectHolderDelegate(new TitleDelegate().addData(R.mipmap.icon_guess_love))
                            .injectHolderDelegate(new CreateHolderDelegate<MallOrderDetailsBean.YoulikeBean>() {

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
                                    return new MallGuessYouLikeHolder(itemView);
                                }
                            }.cleanAfterAddAllData(mallOrderDetailsBean.getYoulike()))
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

    //传递参数异常退出
    private void exitWithParm() {
        finish();
        NToast.show("跳转失败，请重试！");
    }

    //婚庆订单dialog   type: 0:取消订单 1:确认完成服务 2:确认接单 3:拒绝接单 4:接单 完成服务 5:同意退款  7:取消商城订单 8:商城用户确认收货
    private void createDel(String title, String content, String canleNam, String sureName, final int id, final int type) {
        final AskDialog dialog = new AskDialog(context, NewOrderDetailsActivity.this);
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
                        finishWeddingOrder(id, -1);
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
    private void createDel(String title, String content, String canleNam, String sureName, final String id, final String price) {
        final AskDialog dialog = new AskDialog(context, NewOrderDetailsActivity.this);
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
                Intent intent = new Intent(context, ToPayActivity.class);
                intent.putExtra("intentType", intentType);
                intent.putExtra("id", id);
                intent.putExtra("price", price);
                intent.putExtra("isWeiKuan", true);
                intent.putExtra("order_id", order_id);
                context.startActivity(intent);
                dialog.dismiss();
            }
        });
        dialog.show();
    }

    //取消婚庆订单
    private void cancelWeddingOrder(int id) {
        LoadDialog.showDialog(context);
        ApiManager.cancelWeddingOrder(id, new OnRequestFinish<BaseBean>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean data) {
                NToast.show(data.getMessage());
                refreshLayout.autoRefresh();
                isOperationOrder = true;
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
            }
        });
    }

    //确认完成婚庆订单服务
    private void sureFinishWeddingOrder(int id) {
        LoadDialog.showDialog(context);
        ApiManager.finishWeddingOrder(id, new OnRequestFinish<BaseBean>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean data) {
                NToast.show(data.getMessage());
                refreshLayout.autoRefresh();
                isOperationOrder = true;
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
            }
        });
    }

    //确认接单
    private void sureAcceptWeddingOrder(int id) {
        LoadDialog.showDialog(context);
        ApiManager.agreeWeddingOrder(id, new OnRequestFinish<BaseBean>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean data) {
                NToast.show(data.getMessage());
                refreshLayout.autoRefresh();
                isOperationOrder = true;
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
            }
        });
    }

    //拒绝接单
    private void refusedWeddingOrder(int id) {
        LoadDialog.showDialog(context);
        ApiManager.refusedWeddingOrder(id, new OnRequestFinish<BaseBean>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean data) {
                NToast.show(data.getMessage());
                refreshLayout.autoRefresh();
                isOperationOrder = true;
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
            }
        });
    }

    //婚庆接单完成服务
    private void finishWeddingOrder(int id, int paymethod) {
        LoadDialog.showDialog(context);
        ApiManager.finishWeddingOrderShop(id, paymethod, new OnRequestFinish<BaseBean>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean data) {
                NToast.show(data.getMessage());
                refreshLayout.autoRefresh();
                isOperationOrder = true;
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
            }
        });
    }

    //婚庆接单完成服务dialog
    private void createFinishOrderServerDialog(final int id) {
        final ChoosePayDialog choosePayDialog = new ChoosePayDialog(context, NewOrderDetailsActivity.this);
        choosePayDialog.setCancleListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                choosePayDialog.dismiss();
            }
        });
        choosePayDialog.setSubmitListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                finishWeddingOrder(id, (choosePayDialog.getClickButtonIndex() + 1));
                choosePayDialog.dismiss();
            }
        });
        choosePayDialog.show();
    }

    //同意退款
    private void agreedWeddingTuiKuan(int id) {
        LoadDialog.showDialog(context);
        ApiManager.agreeWeddingOrderTuiKuan(id, new OnRequestFinish<BaseBean>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean data) {
                NToast.show(data.getMessage());
                refreshLayout.autoRefresh();
                isOperationOrder = true;
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
            }
        });
    }

    //取消商城订单
    private void cancelMallOrder(int id) {
        LoadDialog.showDialog(context);
        ApiManager.canelMallOrder(id, new OnRequestFinish<BaseBean>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean data) {
                NToast.show(data.getMessage());
                refreshLayout.autoRefresh();
                isOperationOrder = true;
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
            }
        });
    }

    //确认收货
    private void sureGetGoods(int id) {
        LoadDialog.showDialog(context);
        ApiManager.sureGetMallGoods(id, new OnRequestFinish<BaseBean>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean data) {
                NToast.show(data.getMessage());
                refreshLayout.autoRefresh();
                isOperationOrder = true;
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
            }
        });
    }


    @Override
    protected void initData() {

    }

    @Subscribe(threadMode = ThreadMode.MAIN)
    public void receiveEvent(Event event) {
        if (event == null)
            return;
        try {
            int code = event.getCode();
            switch (code) {
                case EventCode.RE_GET_ORDER_DETAILS:
                    initView();
                    isOperationOrder = true;
                    break;
                case EventCode.REFRESH:
                    initView();
                    isOperationOrder = true;
                    break;
                case EventCode.PAY_SUCCRSS:
                    initView();
                    isOperationOrder = true;
                    break;
            }
        } catch (Exception e) {

        }
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        EventBusUtil.unregister(this);
        if (isOperationOrder) {//订单被操作需要返回列表进行刷新
            EventBusUtil.sendEvent(new Event(EventCode.REFRESH));
        }
    }

    public void refreshView() {
        if (!isInitView) {
            initView();
        }
        refreshLayout.autoRefresh();
    }
}
