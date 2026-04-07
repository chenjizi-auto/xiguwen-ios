package com.linzi.xiguwen.ui;

import android.content.Context;
import android.os.Bundle;
import androidx.recyclerview.widget.RecyclerView;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.View;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.base.adapter.BaseAdapter;
import com.linzi.xiguwen.base.adapter.BaseViewHolder;
import com.linzi.xiguwen.base.adapter.CreateHolderDelegate;
import com.linzi.xiguwen.bean.MallJieDanOrderList;
import com.linzi.xiguwen.bean.MallOrderDetailsBean;
import com.linzi.xiguwen.bean.WeddingJieDanOrderList;
import com.linzi.xiguwen.bean.WeddingOrderDetailsBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.network.Constans;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;
import com.linzi.xiguwen.view.AskDialog;

import java.util.ArrayList;

import butterknife.BindView;
import butterknife.ButterKnife;

public class EditPriceActivity extends BaseActivity {

    @BindView(R.id.recycleview)
    RecyclerView recycleview;

    private int intentType;
    private Context context;
    private ArrayList<MallOrderDetailsBean.DataBean.GoodsBean> mallJieDanOrderList;
    private WeddingJieDanOrderList.DataBean weddingBean;
    private WeddingOrderDetailsBean weddingOrderDetailsBean;
    private ArrayList<MallJieDanOrderList.DataBean.GoodsBean> mallBean;
    private BaseAdapter baseAdapter;

    private String weddingPrice;
    private String dingjinPrice;
    private String weikuanPrice;

    private int order_id;

    private int type;//标记是来自列表还是详情 0列表 1详情

    private int paytype;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_edit_price);
        ButterKnife.bind(this);
        context = this;
        intentType = getIntent().getIntExtra("intentType", -1);
        type = getIntent().getIntExtra("type", -1);
        initView();
    }

    @Override
    protected void initData() {

    }

    private void initView() {
        setTitle("修改价格");
        setBack();

        setRight("提交", new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (intentType == 2) {
                    if (paytype == 1) {
                        if (weddingPrice != null && !weddingPrice.equals("")) {
                            createDel("温馨提示", "确认订单金额修改为：[ ￥ " + weddingPrice + " ]", "取消", "确认");
                        } else {
                            NToast.show("请输入要修改的价格再提交哦！~");
                        }
                    } else {
                        if (dingjinPrice != null && !dingjinPrice.equals("") && weikuanPrice != null && !weikuanPrice.equals("")) {
                            createDel("温馨提示", "确认定金修改为：[ ￥ " + dingjinPrice + " ]\n    尾款修改为：[ ￥ " + weikuanPrice + " ]", "取消", "确认");
                        } else {
                            NToast.show("请输入要修改的价格再提交哦！~");
                        }
                    }
                } else {
                    if (weddingPrice != null && !weddingPrice.equals(""))
                        createDel("温馨提示", "确认订单金额修改为：[ ￥ " + weddingPrice + " ]", "取消", "确认");
                    else {
                        NToast.show("请输入要修改的价格再提交哦！~");
                    }
                }
            }
        });

        switch (intentType) {
            case 2:
                if (type == 1) {
                    weddingOrderDetailsBean = getIntent().getParcelableExtra("weddingBean");
                    order_id = weddingOrderDetailsBean.getOrder_id();
                    paytype = weddingOrderDetailsBean.getPaytype();
                    baseAdapter = createWeddingDetailsdapter(weddingOrderDetailsBean);
                } else {
                    weddingBean = getIntent().getParcelableExtra("weddingBean");
                    order_id = weddingBean.getOrder_id();
                    paytype = weddingBean.getPaytype();
                    baseAdapter = createWeddingAdapter(weddingBean);
                }
                break;
            case 3:
                if (type == 1) {
                    mallJieDanOrderList = getIntent().getParcelableArrayListExtra("bean");
                    order_id = getIntent().getIntExtra("order_id", -1);
                    baseAdapter = createMallJieDanAdapter(mallJieDanOrderList);
                } else {
                    mallBean = getIntent().getParcelableArrayListExtra("bean");
                    order_id = getIntent().getIntExtra("order_id", -1);
                    baseAdapter = createMallAdapter(mallBean);
                }
                break;
        }
        recycleview.setAdapter(baseAdapter);
    }

    //item holder
    class WeddingItemHolder extends BaseViewHolder<WeddingJieDanOrderList.DataBean> {
        @BindView(R.id.iv_img)
        ImageView ivImg;
        @BindView(R.id.tv_title)
        TextView tvTitle;
        @BindView(R.id.tv_time)
        TextView tvTime;
        @BindView(R.id.tv_danjia)
        TextView tvDanjia;
        @BindView(R.id.tv_dingjin)
        TextView tvDingjin;
        @BindView(R.id.tv_pay_type)
        TextView tvPayType;
        @BindView(R.id.tv_num)
        TextView tvNum;
        @BindView(R.id.dingjintx)
        TextView dingjintx;
        @BindView(R.id.tv_dikou)
        TextView tvDiKou;
        @BindView(R.id.dikoutext)
        TextView dikoutext;

        public WeddingItemHolder(View itemView) {
            super(itemView);
        }

        @Override
        protected void bindView(WeddingJieDanOrderList.DataBean bean) {
            GlideLoad.GlideLoadRoundedImg(bean.getBaojia_image(), ivImg, 8);
            tvTitle.setText(bean.getBaojia_name() + "");
            tvTime.setText(bean.getSpecification() + "");
            tvDanjia.setText(Constans.RMB + bean.getPrice());
            tvNum.setText("" + bean.getQuantity());
            if (bean.getPaytype() == 2) {
                tvDingjin.setVisibility(View.VISIBLE);
                dingjintx.setVisibility(View.VISIBLE);
                tvDingjin.setText(Constans.RMB + bean.getYuandingjin());
                tvPayType.setText("定金");
            } else {
                tvDingjin.setVisibility(View.GONE);
                dingjintx.setVisibility(View.GONE);
                tvPayType.setText("全款");
            }

            if (bean.getDeductible() != null && !bean.getDeductible().equals("")) {
                dikoutext.setVisibility(View.VISIBLE);
                tvDiKou.setText("￥" + bean.getDeductible());
            } else {
                dikoutext.setVisibility(View.GONE);
            }
        }
    }

    //item holder
    class WeddingDetailsItemHolder extends BaseViewHolder<WeddingOrderDetailsBean> {
        @BindView(R.id.iv_img)
        ImageView ivImg;
        @BindView(R.id.tv_title)
        TextView tvTitle;
        @BindView(R.id.tv_time)
        TextView tvTime;
        @BindView(R.id.tv_danjia)
        TextView tvDanjia;
        @BindView(R.id.tv_dingjin)
        TextView tvDingjin;
        @BindView(R.id.tv_pay_type)
        TextView tvPayType;
        @BindView(R.id.tv_num)
        TextView tvNum;
        @BindView(R.id.dingjintx)
        TextView dingjintx;
        @BindView(R.id.tv_dikou)
        TextView tvDiKou;
        @BindView(R.id.dikoutext)
        TextView dikoutext;

        public WeddingDetailsItemHolder(View itemView) {
            super(itemView);
        }

        @Override
        protected void bindView(WeddingOrderDetailsBean bean) {
            GlideLoad.GlideLoadRoundedImg(bean.getBaojia_image(), ivImg, 8);
            tvTitle.setText(bean.getBaojia_name() + "");
            tvTime.setText(bean.getSpecification() + "");
            tvDanjia.setText(Constans.RMB + bean.getPrice());
            tvNum.setText("" + bean.getQuantity());
            if (bean.getPaytype() == 2) {
                tvDingjin.setVisibility(View.VISIBLE);
                dingjintx.setVisibility(View.VISIBLE);
                tvDingjin.setText(Constans.RMB + bean.getYuandingjin());
                tvPayType.setText("定金");
            } else {
                tvDingjin.setVisibility(View.GONE);
                dingjintx.setVisibility(View.GONE);
                tvPayType.setText("全款");
            }

            if (bean.getDeductible() != null && !bean.getDeductible().equals("")) {
                dikoutext.setVisibility(View.VISIBLE);
                tvDiKou.setText("￥" + bean.getDeductible());
            } else {
                dikoutext.setVisibility(View.GONE);
            }
        }
    }

    //item holder
    class MallItemHolder extends BaseViewHolder<MallJieDanOrderList.DataBean.GoodsBean> {
        @BindView(R.id.iv_img)
        ImageView ivImg;
        @BindView(R.id.tv_title)
        TextView tvTitle;
        @BindView(R.id.tv_time)
        TextView tvTime;
        @BindView(R.id.tv_danjia)
        TextView tvDanjia;
        @BindView(R.id.tv_dingjin)
        TextView tvDingjin;
        @BindView(R.id.tv_pay_type)
        TextView tvPayType;
        @BindView(R.id.tv_num)
        TextView tvNum;
        @BindView(R.id.dingjintx)
        TextView dingjintx;
        @BindView(R.id.tv_dikou)
        TextView tvDiKou;
        @BindView(R.id.dikoutext)
        TextView dikoutext;
        @BindView(R.id.dingjintext)
        TextView dingjintext;

        public MallItemHolder(View itemView) {
            super(itemView);
        }

        @Override
        protected void bindView(MallJieDanOrderList.DataBean.GoodsBean bean) {
            GlideLoad.GlideLoadRoundedImg(bean.getGoods_image(), ivImg, 8);
            tvTitle.setText(bean.getGoods_name() + "");
            tvTime.setText(bean.getSpecification() + "");
            tvDanjia.setText(Constans.RMB + bean.getYuandanjia());
            tvDingjin.setVisibility(View.GONE);
            dingjintext.setVisibility(View.GONE);
            dingjintx.setVisibility(View.GONE);
            tvPayType.setVisibility(View.GONE);
            tvNum.setText("" + bean.getQuantity());
//            if (bean.getDeductible() != null && !bean.getDeductible().equals("")) {
//                dikoutext.setVisibility(View.VISIBLE);
//                tvDiKou.setVisibility(View.VISIBLE);
//
//                tvDiKou.setText("￥" + bean.getDeductible());
//            } else {
            dikoutext.setVisibility(View.GONE);
            tvDiKou.setVisibility(View.GONE);
            // }
        }
    }

    //item holder
    class MallJieDanItemHolder extends BaseViewHolder<MallOrderDetailsBean.DataBean.GoodsBean> {
        @BindView(R.id.iv_img)
        ImageView ivImg;
        @BindView(R.id.tv_title)
        TextView tvTitle;
        @BindView(R.id.tv_time)
        TextView tvTime;
        @BindView(R.id.tv_danjia)
        TextView tvDanjia;
        @BindView(R.id.tv_dingjin)
        TextView tvDingjin;
        @BindView(R.id.tv_pay_type)
        TextView tvPayType;
        @BindView(R.id.tv_num)
        TextView tvNum;
        @BindView(R.id.dingjintx)
        TextView dingjintx;
        @BindView(R.id.tv_dikou)
        TextView tvDiKou;
        @BindView(R.id.dikoutext)
        TextView dikoutext;
        @BindView(R.id.dingjintext)
        TextView dingjintext;

        public MallJieDanItemHolder(View itemView) {
            super(itemView);
        }

        @Override
        protected void bindView(MallOrderDetailsBean.DataBean.GoodsBean bean) {
            GlideLoad.GlideLoadRoundedImg(bean.getGoods_image(), ivImg, 8);
            tvTitle.setText(bean.getGoods_name() + "");
            tvTime.setText(bean.getSpecification() + "");
            tvDanjia.setText(Constans.RMB + bean.getPrice());
            tvDingjin.setVisibility(View.GONE);
            dingjintx.setVisibility(View.GONE);
            dingjintext.setVisibility(View.GONE);
            tvPayType.setVisibility(View.GONE);
            tvNum.setText("" + bean.getQuantity());
//            if (bean.getDeductible() != null && !bean.getDeductible().equals("")) {
//                dikoutext.setVisibility(View.VISIBLE);
//                tvDiKou.setVisibility(View.VISIBLE);
//
//                tvDiKou.setText("￥" + bean.getDeductible());
//            } else {
            dikoutext.setVisibility(View.GONE);
            tvDiKou.setVisibility(View.GONE);
            // }
        }
    }

    //wedding holder
    class weddingEdtHolder extends BaseViewHolder<String> {
        @BindView(R.id.tv_title)
        TextView tvTitle;
        @BindView(R.id.ed_order_price)
        EditText edOrderPrice;
        @BindView(R.id.ll_order)
        LinearLayout llOrder;
        @BindView(R.id.ed_dingjing_price)
        EditText edDingjingPrice;
        @BindView(R.id.ll_dingjin)
        LinearLayout llDingjin;
        @BindView(R.id.ed_weikuan_price)
        EditText edWeikuanPrice;
        @BindView(R.id.ll_weikuan)
        LinearLayout llWeikuan;

        public weddingEdtHolder(View itemView) {
            super(itemView);
        }

        @Override
        protected void bindView(String type) {
            if (intentType == 2) {
                switch (type) {
                    case "2":
                        llOrder.setVisibility(View.GONE);
                        llDingjin.setVisibility(View.VISIBLE);
                        llWeikuan.setVisibility(View.VISIBLE);
                        edDingjingPrice.addTextChangedListener(new TextWatcher() {

                            @Override
                            public void onTextChanged(CharSequence s, int start, int before,
                                                      int count) {
                                if (s.toString().contains(".")) {
                                    if (s.length() - 1 - s.toString().indexOf(".") > 2) {
                                        s = s.toString().subSequence(0,
                                                s.toString().indexOf(".") + 3);
                                        edDingjingPrice.setText(s);
                                        edDingjingPrice.setSelection(s.length());

                                    }
                                }
                                if (s.toString().trim().substring(0).equals(".")) {
                                    s = "0" + s;
                                    edDingjingPrice.setText(s);
                                    edDingjingPrice.setSelection(2);
                                }

                                if (s.toString().startsWith("0")
                                        && s.toString().trim().length() > 1) {
                                    if (!s.toString().substring(1, 2).equals(".")) {
                                        edDingjingPrice.setText(s.subSequence(0, 1));
                                        edDingjingPrice.setSelection(1);
                                        return;
                                    }
                                }
                                dingjinPrice = edDingjingPrice.getText().toString();
                            }

                            @Override
                            public void beforeTextChanged(CharSequence s, int start, int count,
                                                          int after) {

                            }

                            @Override
                            public void afterTextChanged(Editable s) {
                            }

                        });
                        edWeikuanPrice.addTextChangedListener(new TextWatcher() {

                            @Override
                            public void onTextChanged(CharSequence s, int start, int before,
                                                      int count) {
                                if (s.toString().contains(".")) {
                                    if (s.length() - 1 - s.toString().indexOf(".") > 2) {
                                        s = s.toString().subSequence(0,
                                                s.toString().indexOf(".") + 3);
                                        edWeikuanPrice.setText(s);
                                        edWeikuanPrice.setSelection(s.length());
                                    }
                                }
                                if (s.toString().trim().substring(0).equals(".")) {
                                    s = "0" + s;
                                    edWeikuanPrice.setText(s);
                                    edWeikuanPrice.setSelection(2);
                                }

                                if (s.toString().startsWith("0")
                                        && s.toString().trim().length() > 1) {
                                    if (!s.toString().substring(1, 2).equals(".")) {
                                        edWeikuanPrice.setText(s.subSequence(0, 1));
                                        edWeikuanPrice.setSelection(1);
                                        return;
                                    }
                                }
                                weikuanPrice = edWeikuanPrice.getText().toString();
                            }

                            @Override
                            public void beforeTextChanged(CharSequence s, int start, int count,
                                                          int after) {

                            }

                            @Override
                            public void afterTextChanged(Editable s) {
                                weddingPrice = edDingjingPrice.getText().toString();
                            }

                        });
                        break;
                    case "1":
                        llOrder.setVisibility(View.VISIBLE);
                        llDingjin.setVisibility(View.GONE);
                        llWeikuan.setVisibility(View.GONE);
                        edOrderPrice.addTextChangedListener(new TextWatcher() {

                            @Override
                            public void onTextChanged(CharSequence s, int start, int before,
                                                      int count) {
                                if (s.toString().contains(".")) {
                                    if (s.length() - 1 - s.toString().indexOf(".") > 2) {
                                        s = s.toString().subSequence(0,
                                                s.toString().indexOf(".") + 3);
                                        edOrderPrice.setText(s);
                                        edOrderPrice.setSelection(s.length());
                                    }
                                }
                                if (s.toString().trim().substring(0).equals(".")) {
                                    s = "0" + s;
                                    edOrderPrice.setText(s);
                                    edOrderPrice.setSelection(2);
                                }

                                if (s.toString().startsWith("0")
                                        && s.toString().trim().length() > 1) {
                                    if (!s.toString().substring(1, 2).equals(".")) {
                                        edOrderPrice.setText(s.subSequence(0, 1));
                                        edOrderPrice.setSelection(1);
                                        return;
                                    }
                                }
                                weddingPrice = edOrderPrice.getText().toString();

                            }

                            @Override
                            public void beforeTextChanged(CharSequence s, int start, int count,
                                                          int after) {

                            }

                            @Override
                            public void afterTextChanged(Editable s) {
                            }

                        });
                        break;
                }
            } else {
                llOrder.setVisibility(View.VISIBLE);
                llDingjin.setVisibility(View.GONE);
                llWeikuan.setVisibility(View.GONE);
                edOrderPrice.addTextChangedListener(new TextWatcher() {

                    @Override
                    public void onTextChanged(CharSequence s, int start, int before,
                                              int count) {
                        if (s.toString().contains(".")) {
                            if (s.length() - 1 - s.toString().indexOf(".") > 2) {
                                s = s.toString().subSequence(0,
                                        s.toString().indexOf(".") + 3);
                                edOrderPrice.setText(s);
                                edOrderPrice.setSelection(s.length());
                            }
                        }
                        if (s.toString().trim().substring(0).equals(".")) {
                            s = "0" + s;
                            edOrderPrice.setText(s);
                            edOrderPrice.setSelection(2);
                        }

                        if (s.toString().startsWith("0")
                                && s.toString().trim().length() > 1) {
                            if (!s.toString().substring(1, 2).equals(".")) {
                                edOrderPrice.setText(s.subSequence(0, 1));
                                edOrderPrice.setSelection(1);
                                return;
                            }
                        }
                        weddingPrice = edOrderPrice.getText().toString();

                    }

                    @Override
                    public void beforeTextChanged(CharSequence s, int start, int count,
                                                  int after) {

                    }

                    @Override
                    public void afterTextChanged(Editable s) {
                    }

                });
            }
        }
    }

    private BaseAdapter createWeddingAdapter(WeddingJieDanOrderList.DataBean bean) {

        BaseAdapter baseAdapter = BaseAdapter.createBaseAdapter();
        baseAdapter.injectHolderDelegate(new CreateHolderDelegate<WeddingJieDanOrderList.DataBean>() {
            @Override
            protected int getLayoutRes() {
                return R.layout.item_sure_item_layout_white;
            }

            @Override
            protected BaseViewHolder onCreateHolder(View itemView) {
                return new WeddingItemHolder(itemView);
            }
        }.cleanAfterAddData(bean))
                .injectHolderDelegate(new CreateHolderDelegate<String>() {
                    @Override
                    protected int getLayoutRes() {
                        return R.layout.editprice_item;
                    }

                    @Override
                    protected BaseViewHolder onCreateHolder(View itemView) {
                        return new weddingEdtHolder(itemView);
                    }
                }.cleanAfterAddData(bean.getPaytype() + ""))
        ;
        baseAdapter.setLayoutManager(recycleview);
        return baseAdapter;
    }

    private BaseAdapter createWeddingDetailsdapter(WeddingOrderDetailsBean bean) {

        BaseAdapter baseAdapter = BaseAdapter.createBaseAdapter();
        baseAdapter.injectHolderDelegate(new CreateHolderDelegate<WeddingOrderDetailsBean>() {
            @Override
            protected int getLayoutRes() {
                return R.layout.item_sure_item_layout_white;
            }

            @Override
            protected BaseViewHolder onCreateHolder(View itemView) {
                return new WeddingDetailsItemHolder(itemView);
            }
        }.cleanAfterAddData(bean))
                .injectHolderDelegate(new CreateHolderDelegate<String>() {
                    @Override
                    protected int getLayoutRes() {
                        return R.layout.editprice_item;
                    }

                    @Override
                    protected BaseViewHolder onCreateHolder(View itemView) {
                        return new weddingEdtHolder(itemView);
                    }
                }.cleanAfterAddData(bean.getPaytype() + ""))
        ;
        baseAdapter.setLayoutManager(recycleview);
        return baseAdapter;
    }

    private BaseAdapter createMallAdapter(ArrayList<MallJieDanOrderList.DataBean.GoodsBean> bean) {

        BaseAdapter baseAdapter = BaseAdapter.createBaseAdapter();
        baseAdapter.injectHolderDelegate(new CreateHolderDelegate<MallJieDanOrderList.DataBean.GoodsBean>() {
            @Override
            protected int getLayoutRes() {
                return R.layout.item_sure_item_layout_white;
            }

            @Override
            protected BaseViewHolder onCreateHolder(View itemView) {
                return new MallItemHolder(itemView);
            }
        }.cleanAfterAddAllData(bean))
                .injectHolderDelegate(new CreateHolderDelegate<String>() {
                    @Override
                    protected int getLayoutRes() {
                        return R.layout.editprice_item;
                    }

                    @Override
                    protected BaseViewHolder onCreateHolder(View itemView) {
                        return new weddingEdtHolder(itemView);
                    }
                }.cleanAfterAddData(""))
        ;
        baseAdapter.setLayoutManager(recycleview);
        return baseAdapter;
    }

    private BaseAdapter createMallJieDanAdapter(ArrayList<MallOrderDetailsBean.DataBean.GoodsBean> bean) {

        BaseAdapter baseAdapter = BaseAdapter.createBaseAdapter();
        baseAdapter.injectHolderDelegate(new CreateHolderDelegate<MallOrderDetailsBean.DataBean.GoodsBean>() {
            @Override
            protected int getLayoutRes() {
                return R.layout.item_sure_item_layout_white;
            }

            @Override
            protected BaseViewHolder onCreateHolder(View itemView) {
                return new MallJieDanItemHolder(itemView);
            }
        }.cleanAfterAddAllData(bean))
                .injectHolderDelegate(new CreateHolderDelegate<String>() {
                    @Override
                    protected int getLayoutRes() {
                        return R.layout.editprice_item;
                    }

                    @Override
                    protected BaseViewHolder onCreateHolder(View itemView) {
                        return new weddingEdtHolder(itemView);
                    }
                }.cleanAfterAddData(""))
        ;
        baseAdapter.setLayoutManager(recycleview);
        return baseAdapter;
    }

    //修改婚庆接单价格
    private void submitWeddingPrice() {
        LoadDialog.showDialog(context);
        if (paytype == 1) {
            ApiManager.modiWeddingPrice(order_id, weddingPrice, null, new OnRequestFinish<BaseBean>() {
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
        } else {
            ApiManager.modiWeddingPrice(order_id, dingjinPrice, weikuanPrice, new OnRequestFinish<BaseBean>() {
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

    //修改商场接单价格
    private void submitMallPrice() {
        LoadDialog.showDialog(context);
        ApiManager.modiMallPrice(order_id, weddingPrice, new OnRequestFinish<BaseBean>() {
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

    //提醒dialog
    private void createDel(String title, String content, String canleNam, String sureName) {
        final AskDialog dialog = new AskDialog(context, EditPriceActivity.this);
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
                    case 2:
                        submitWeddingPrice();
                        break;
                    case 3:
                        submitMallPrice();
                        break;
                }
                dialog.dismiss();
            }
        });
        dialog.show();
    }
}
