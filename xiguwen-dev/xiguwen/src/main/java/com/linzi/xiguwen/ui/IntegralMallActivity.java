package com.linzi.xiguwen.ui;

import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Color;
import android.os.Build;
import android.os.Bundle;
import androidx.core.view.ViewCompat;
import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.adapter.BaseAdapter;
import com.linzi.xiguwen.base.adapter.BaseViewHolder;
import com.linzi.xiguwen.base.adapter.CreateHolderDelegate;
import com.linzi.xiguwen.bean.JiFenIndexBean;
import com.linzi.xiguwen.bean.SignInBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.GlideImageLoader;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.LoginUtil;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.NumberUtil;
import com.linzi.xiguwen.utils.StatusBarUtil;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;
import com.linzi.xiguwen.utils.location.JumpUtil;
import com.linzi.xiguwen.view.AskDialog;
import com.linzi.xiguwen.view.dialog.InputPassWordDialog;
import com.linzi.xiguwen.view.dialog.SignInDialog;
import com.wx.goodview.GoodView;
import com.youth.banner.Banner;
import com.youth.banner.BannerConfig;
import com.youth.banner.listener.OnBannerListener;

import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * 积分商城
 * Created by pc on 2018/5/22.
 */

public class IntegralMallActivity extends AppCompatActivity {
    @BindView(R.id.recycleview)
    RecyclerView recycleview;
    @BindView(R.id.ll_bar)
    LinearLayout llBar;
    @BindView(R.id.tv_title)
    TextView tvTitle;
    @BindView(R.id.ll_title)
    RelativeLayout llTitle;
    @BindView(R.id.ll_back)
    LinearLayout llBack;
    @BindView(R.id.ll_right)
    LinearLayout llRight;
    @BindView(R.id.iv_back)
    ImageView ivBack;
    @BindView(R.id.tv_right)
    TextView tvRight;

    private BaseAdapter baseAdapter;
    private Context context;
    private JiFenIndexBean bean;

    private SignInDialog signInDialog;

    private InputPassWordDialog inputPassWordDialog;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
            StatusBarUtil.setStatusBarColor(IntegralMallActivity.this, R.color.trans);
            StatusBarUtil.setNavigationBarColor(IntegralMallActivity.this, R.color.white);
        }
        setContentView(R.layout.integralmall_layout);
        ButterKnife.bind(this);
        EventBusUtil.register(this);
        context = this;
        getData();
        initView();
    }

    private void initView() {
        //获得状态栏高度
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, StatusBarUtil.getStatusBarHeight(IntegralMallActivity.this));
        llBar.setLayoutParams(params);

        ViewCompat.setAlpha(llBar, 0);

        llBack.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                finish();
            }
        });

        llRight.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View view) {
                if (!LoginUtil.isLogin()) {
                    LoginActivity.startAction(context);
                    return;
                }
                startActivity(new Intent(context, JiFenDetailsActivity.class));
            }
        });

        recycleview.addOnScrollListener(new RecyclerView.OnScrollListener() {
            @Override
            public void onScrolled(RecyclerView recyclerView, int dx, int dy) {
                super.onScrolled(recyclerView, dx, dy);


                int position = ((LinearLayoutManager) recyclerView.getLayoutManager()).findFirstVisibleItemPosition();
                if (position > 0) {
                    llBar.setAlpha(1); // 显示
                    llTitle.setAlpha(1); // 显示
                    tvTitle.setTextColor(context.getResources().getColor(R.color.colorTitle));
                    ivBack.setBackgroundResource(R.mipmap.icon_back);
                    tvRight.setTextColor(context.getResources().getColor(R.color.colorTitle));
                    return;
                } else {
                    int top = recyclerView.getChildAt(0).getTop();
                    float v = -(top * 1.0f / recyclerView.getChildAt(0).getHeight());
                    if (v > 1) {
                        v = 1;
                    } else if (v < 0) {
                        v = 0;
                    } else {
                        if (v < 0.5) {
                            tvTitle.setTextColor(context.getResources().getColor(R.color.white));
                            tvRight.setTextColor(context.getResources().getColor(R.color.white));
                            ivBack.setBackgroundResource(R.mipmap.icon_back_white);
                        } else {
                            tvTitle.setTextColor(context.getResources().getColor(R.color.colorTitle));
                            ivBack.setBackgroundResource(R.mipmap.icon_back);
                            tvRight.setTextColor(context.getResources().getColor(R.color.colorTitle));
                        }
                    }
                    llBar.setAlpha(v);
//                    tvTitle.setTextColor(context.getResources().getColor(R.color.white));
//                    tvRight.setTextColor(context.getResources().getColor(R.color.white));
//                    ivBack.setBackgroundResource(R.mipmap.icon_back_white);
                    llTitle.setAlpha(v);
                }
            }
        });
    }

    private void afterView(JiFenIndexBean bean) {
        baseAdapter = createAdapter(bean);
        recycleview.setAdapter(baseAdapter);
    }

    private void getData() {
        LoadDialog.showDialog(context);
        ApiManager.getJiFenIndex(new OnRequestFinish<BaseBean<JiFenIndexBean>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<JiFenIndexBean> data) {
                bean = data.getData();
                afterView(bean);
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
            }
        });
    }

    //标题Delegate
    class TitleDelegate extends CreateHolderDelegate<String> {

        @Override
        protected int getLayoutRes() {
            return R.layout.item_mall_title;
        }

        @Override
        protected BaseViewHolder onCreateHolder(View itemView) {
            return new TitleHolder(itemView);
        }
    }

    //标题Holder
    class TitleHolder extends BaseViewHolder<String> {

        public TitleHolder(View itemView) {
            super(itemView);
        }

        @BindView(R.id.tv_name)
        TextView tvName;
        @BindView(R.id.tv_more)
        TextView tvMore;
        @BindView(R.id.line)
        View line;

        @Override
        protected void bindView(final String s) {
            final String str = s;
            line.setVisibility(View.VISIBLE);
            tvName.setText(s);
            tvMore.setVisibility(View.VISIBLE);
            tvMore.setText("查看全部");
            tvMore.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Intent intent = new Intent(context, HotDuiHuanGoodsActivity.class);
                    if (str.equals("热兑商品")) {
                        intent.putExtra("type", 1);
                    } else {
                        intent.putExtra("type", 0);
                    }
                    startActivity(intent);
                }
            });
        }

    }


    //bannerHolder
    class BannerHolder extends BaseViewHolder<JiFenIndexBean> {
        @BindView(R.id.banner)
        Banner banner;
        @BindView(R.id.topline)
        View topline;
        @BindView(R.id.botomline)
        View botomline;

        public BannerHolder(View itemView) {
            super(itemView);
        }

        @Override
        protected void bindView(final JiFenIndexBean bean) {
            topline.setVisibility(View.VISIBLE);
            botomline.setVisibility(View.VISIBLE);

            List<String> url;
            if (bean.getGanggao() != null && bean.getGanggao().size() > 0) {
                url = new ArrayList<>();//bannerurl
                for (int i = 0; i < bean.getGanggao().size(); i++) {
                    url.add(bean.getGanggao().get(i).getWapimg());
                }
            } else {
                url = new ArrayList<>();
            }
            banner.setImages(url)
                    .setImageLoader(new GlideImageLoader())
                    .setIndicatorGravity(BannerConfig.CENTER)
                    .setDelayTime(2000)
                    .start();
            banner.setOnBannerListener(new OnBannerListener() {
                @Override
                public void OnBannerClick(int position) {
                    JumpUtil.judgeJump(context, bean.getGanggao().get(position).getAptid(), bean.getGanggao().get(position).getAptype(), bean.getGanggao().get(position).getSrc());
                }
            });
        }
    }

    //热兑商品holder
    class HotDuiHolder extends BaseViewHolder<JiFenIndexBean.ShopBean> {
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
                    Intent intent = new Intent(context, JiFenGoodsDetailActivity.class);
                    intent.putExtra("goods_id", id);
                    intent.putExtra("type", 0);
                    context.startActivity(intent);
                }
            });
        }

        @Override
        protected void bindView(final JiFenIndexBean.ShopBean shopBean) {
            id = shopBean.getId();
            GlideLoad.GlideLoadImg2(shopBean.getTupian(), goods_img);
            goodsJifen.setText("" + shopBean.getJifen());
            final String price = shopBean.getJiage();
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
                        LoginActivity.startAction(context);
                        return;
                    }
                    Intent intent = new Intent(context, JiFenSureOrderActivity.class);
                    intent.putExtra("rec_id", id);
                    context.startActivity(intent);
                }
            });
        }
    }

    //兑换红包holder
    class RedBaoHolder extends BaseViewHolder<JiFenIndexBean.HongbaoBean> {
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
                    Intent intent = new Intent(context, JiFenGoodsDetailActivity.class);
                    intent.putExtra("goods_id", id);
                    intent.putExtra("type", 1);
                    context.startActivity(intent);
                }
            });
        }

        @Override
        protected void bindView(JiFenIndexBean.HongbaoBean hongbaoBean) {
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
                        LoginActivity.startAction(context);
                        return;
                    }
                    createDel("提示", "请确认是否使用[ " + jifen + " ]积分兑换[" + goodsname + "]", "点错了", "确认", id, jifen + "");

                }
            });
        }
    }

    private BaseAdapter createAdapter(final JiFenIndexBean bean) {
        BaseAdapter baseAdapter = BaseAdapter.createBaseAdapter();
        baseAdapter.injectHolderDelegate(new CreateHolderDelegate<JiFenIndexBean>() {
            @Override
            protected int onSpanSize() {
                return 2;
            }

            @Override
            protected int getLayoutRes() {
                return R.layout.integralmall_head_layout;
            }

            @Override
            protected BaseViewHolder onCreateHolder(View itemView) {
                return new BaseViewHolder<JiFenIndexBean>(itemView) {
                    @Override
                    protected void bindView(JiFenIndexBean indexBean) {
//                        LinearLayout llBar = itemView.findViewById(R.id.ll_bar);
//                        RelativeLayout llTitle = itemView.findViewById(R.id.ll_title);
//                        //获得状态栏高度
//                        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, StatusBarUtil.getStatusBarHeight(IntegralMallActivity.this));
//                        llBar.setLayoutParams(params);
//
//                        ViewCompat.setAlpha(llBar, 0);
//
//                        LinearLayout ll_back = itemView.findViewById(R.id.ll_back);
//                        ll_back.setOnClickListener(new View.OnClickListener() {
//                            @Override
//                            public void onClick(View view) {
//                                finish();
//                            }
//                        });
//
//
//                        LinearLayout ll_right = itemView.findViewById(R.id.ll_right);
//                        ll_right.setOnClickListener(new View.OnClickListener() {
//                            @Override
//                            public void onClick(View view) {
//
//                            }
//                        });

                        final LinearLayout ll_show_pop = itemView.findViewById(R.id.ll_show_pop);
                        ll_show_pop.setOnClickListener(new View.OnClickListener() {
                            @Override
                            public void onClick(View view) {
                                if (!LoginUtil.isLogin()) {
                                    LoginActivity.startAction(context);
                                    return;
                                }
                                startActivity(new Intent(context, JiFenDetailsActivity.class));
                            }
                        });

                        LinearLayout ll_duihuanjilv = itemView.findViewById(R.id.ll_duihuanjilv);
                        ll_duihuanjilv.setOnClickListener(new View.OnClickListener() {
                            @Override
                            public void onClick(View view) {
                                if (!LoginUtil.isLogin()) {
                                    LoginActivity.startAction(context);
                                    return;
                                }
                                startActivity(new Intent(context, ExchangeJiFenActivity.class));
                            }
                        });

                        TextView tv_sign_in_day = itemView.findViewById(R.id.tv_sign_in_day);
                        tv_sign_in_day.setText("已经连续签到" + indexBean.getLianxutianshu() + "天");

                        final TextView tv_jifen_num = itemView.findViewById(R.id.tv_jifen_num);
                        tv_jifen_num.setText(indexBean.getJifen() + "");

                        TextView tv_duihuan_num = itemView.findViewById(R.id.tv_duihuan_num);
                        tv_duihuan_num.setText(indexBean.getDuihuanjilushu() + "");

                        TextView sign_in_button = itemView.findViewById(R.id.sign_in_button);

                        if (bean.getShifouqiandao() != 0) {
                            sign_in_button.setText("已签到");
                            sign_in_button.setEnabled(false);
                        } else {
                            sign_in_button.setEnabled(true);
                            sign_in_button.setOnClickListener(new View.OnClickListener() {
                                @Override
                                public void onClick(View view) {
                                    if (!LoginUtil.isLogin()) {
                                        LoginActivity.startAction(context);
                                        return;
                                    }
                                    signin(tv_jifen_num, ll_show_pop);
                                }
                            });
                        }
                    }
                };
            }
        }.cleanAfterAddData(bean))

                .injectHolderDelegate(new CreateHolderDelegate<JiFenIndexBean>() {
                    @Override
                    protected int onSpanSize() {
                        return 2;
                    }

                    @Override
                    protected int getLayoutRes() {
                        return R.layout.new_mall_index_banner_layout;
                    }

                    @Override
                    protected BaseViewHolder onCreateHolder(View itemView) {
                        return new BannerHolder(itemView);
                    }
                }.cleanAfterAddData(bean))
                .injectHolderDelegate(new TitleDelegate() {
                    @Override
                    protected int onSpanSize() {
                        return 2;
                    }
                }.cleanAfterAddData("热兑商品"))
                .injectHolderDelegate(new CreateHolderDelegate<JiFenIndexBean.ShopBean>() {

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
                }.cleanAfterAddAllData(bean.getShop()))
                .injectHolderDelegate(new TitleDelegate() {
                    @Override
                    protected int onSpanSize() {
                        return 2;
                    }
                }.cleanAfterAddData("兑换红包"))
                .injectHolderDelegate(new CreateHolderDelegate<JiFenIndexBean.HongbaoBean>() {
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
                }.cleanAfterAddAllData(bean.getHongbao()))
        ;
        baseAdapter.setLayoutManager(recycleview);
        return baseAdapter;
    }

    //签到
    private void signin(final TextView view, final View showView) {
        LoadDialog.showDialog(context);
        ApiManager.signIn(new OnRequestFinish<BaseBean<SignInBean>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(final BaseBean<SignInBean> data) {
                final SignInBean signInBean = data.getData();
                signInDialog = new SignInDialog(context, signInBean);
                signInDialog.show();
                signInDialog.setOnDismissListener(new DialogInterface.OnDismissListener() {
                    @Override
                    public void onDismiss(DialogInterface dialogInterface) {
                        GoodView goodView = new GoodView(context);
                        goodView.setTextInfo("+" + signInBean.getHuodejifen() + "积分", Color.parseColor("#ff8d02"), 20);
                        goodView.show(showView);
                        view.setText(NumberUtil.add(view.getText().toString(), signInBean.getHuodejifen() + ""));
                    }
                });
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
            }
        });
    }

    //提醒dialog
    private void createDel(String title, String content, String canleNam, String sureName, final int order_id, final String price) {
        final AskDialog dialog = new AskDialog(context, IntegralMallActivity.this);
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
        inputPassWordDialog = new InputPassWordDialog(context, R.style.MyDialog, isWeiKuan, 8);
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

    @Override
    protected void onDestroy() {
        super.onDestroy();
         
        EventBusUtil.unregister(this);
    }

    @Subscribe(threadMode = ThreadMode.MAIN)
    public void receiveEvent(Event entity) {
        if (entity == null)
            return;
        try {
            int code = entity.getCode();
            switch (code) {
                case EventCode.PAY_SUCCRSS:
                    getData();
                    break;
            }
        } catch (Exception e) {
        }

    }
}
