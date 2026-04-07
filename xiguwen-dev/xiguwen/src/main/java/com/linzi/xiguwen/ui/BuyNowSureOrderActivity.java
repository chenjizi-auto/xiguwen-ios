package com.linzi.xiguwen.ui;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.base.adapter.BaseAdapter;
import com.linzi.xiguwen.base.adapter.BaseViewHolder;
import com.linzi.xiguwen.base.adapter.CreateHolderDelegate;
import com.linzi.xiguwen.bean.AddressEntity;
import com.linzi.xiguwen.bean.MallOrderBean;
import com.linzi.xiguwen.bean.WeddingOrderBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.OnRequestSubscribe;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.network.Constans;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.NumberUtil;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;
import com.luck.picture.lib.utils.ToastUtils;

import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

/**
 * Created by pc on 2018/4/14.
 */

public class BuyNowSureOrderActivity extends BaseActivity {
    @BindView(R.id.tv_get_name)
    TextView tv_get_name;
    @BindView(R.id.tv_phone)
    TextView tvPhone;
    @BindView(R.id.tv_address)
    TextView tvAddress;
    @BindView(R.id.ll_address)
    LinearLayout llAddress;
    @BindView(R.id.recycleview)
    RecyclerView recycleview;
    @BindView(R.id.tv_price)
    TextView tvALLPrice;
    @BindView(R.id.tv_submit)
    TextView tvSubmit;
    @BindView(R.id.bottombar)
    LinearLayout bottombar;

    private int intentType;//0 婚庆 1商城
    private Context context;
    //------------ 商城参数 -----------
    private String number;
    private int skuid;
    //------------ 婚庆参数 -----------
    private String baojiadate;//	报价日期
    private int baojiaid;//报价id
    private int baojiatime;//报价日期上午中午 1上午 2中午3下午4晚上
    private int paytype;//支付类型 1全款支付 2定金支付
    private String quantity;//数量
    private String agreedPrice;//数量

    private WeddingOrderBean weddingOrderBean;
    private MallOrderBean mallOrderBean;

    private HashMap<Integer, List<WeddingOrderBean.CartlistBean>> map;
    private HashMap<Integer, List<MallOrderBean.CartlistBean>> mallMap;

    private BaseAdapter baseAdapter;

    private String allPrice = "0.00";
    private String id;//提交成功后的编号
    private String addressid;

    @Override
    protected void initData() {

    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.sure_order_layout);
        ButterKnife.bind(this);
        EventBusUtil.register(this);
        context = this;
        initView();
    }

    private void initView() {
        setBack();
        setTitle("确认订单");

        intentType = getIntent().getIntExtra("intentType", -1);
        //------------ 商城参数 -----------
        number = getIntent().getStringExtra("number");
        skuid = getIntent().getIntExtra("skuid", -1);
        //------------ 婚庆参数 -----------
        baojiadate = getIntent().getStringExtra("baojiadate");
        baojiaid = getIntent().getIntExtra("baojiaid", -1);
        baojiatime = getIntent().getIntExtra("baojiatime", -1);
        paytype = getIntent().getIntExtra("paytype", -1);
        quantity = getIntent().getStringExtra("quantity");
        agreedPrice = getIntent().getStringExtra("agreedPrice");

        if (intentType == -1) {
            finish();
            NToast.show("跳转失败！请重试！");
        } else {
            if (intentType == 0) {
                llAddress.setVisibility(View.GONE);
                getWeddingData();
            } else {
                llAddress.setVisibility(View.VISIBLE);
                getMallData();
                httpData();
                llAddress.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        Intent intent = new Intent(mContext, AddressManagerActivity.class);
                        mContext.startActivity(intent);
                    }
                });
            }
        }
    }

    @OnClick({R.id.ll_address, R.id.tv_submit})
    public void onViewClicked(View view) {
        switch (view.getId()) {
            case R.id.ll_address:

                break;
            case R.id.tv_submit:
                getRemark(intentType);
                break;
        }
    }

    //--------------------------------------------------------------  婚庆 --------------------------------------------------------------------------------


    private void getWeddingData() {
        LoadDialog.showDialog(context);
        ApiManager.buyNowWedding(baojiadate, baojiaid, baojiatime, paytype, quantity,agreedPrice, new OnRequestFinish<BaseBean<WeddingOrderBean>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<WeddingOrderBean> data) {
                baseAdapter = BaseAdapter.createBaseAdapter();
                weddingOrderBean = data.getData();
                dealWeddingBean(weddingOrderBean);
                recycleview.setAdapter(baseAdapter);
//                for (List<WeddingOrderBean.CartlistBean> bean : map.values()) {
//                    for (int i = 0; i < bean.size(); i++) {
//                        for (int j = 0; j < bean.get(i).getGoods().size(); j++) {
//                            if (bean.get(i).getGoods().get(j).getPaytype() == 1) {
//                                allPrice = NumberUtil.add(allPrice, NumberUtil.AmultiplyB(bean.get(i).getGoods().get(j).getPrice(), bean.get(i).getGoods().get(j).getQuantity() + ""));
//                            } else {
//                                allPrice = NumberUtil.add(allPrice, NumberUtil.AmultiplyB(bean.get(i).getGoods().get(j).getYuandingjin(), bean.get(i).getGoods().get(j).getQuantity() + ""));
//                            }
//                        }
//                    }
//                }
            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }

    private void dealWeddingBean(WeddingOrderBean bean) {
        map = new HashMap<>();
        List<WeddingOrderBean.CartlistBean> list;
        for (int i = 0; i < bean.getCartlist().size(); i++) {
            WeddingOrderBean.CartlistBean bean1 = bean.getCartlist().get(i);
            if (!map.containsKey(bean1.getStore_id())) {
                list = new ArrayList<>();
                list.add(bean1);
                map.put(bean1.getStore_id(), list);
            } else {
                map.get(bean1.getStore_id()).add(bean1);
            }
        }
        for (Integer key : map.keySet()) {
            baseAdapter
                    .injectHolderDelegate(new CreateHolderDelegate<Integer>() {
                        @Override
                        protected int getLayoutRes() {
                            return R.layout.sure_order_item;
                        }

                        @Override
                        protected BaseViewHolder onCreateHolder(View itemView) {
                            return new WeddingItemHolder(itemView);
                        }
                    }.cleanAfterAddData(key));
        }
        baseAdapter.setLayoutManager(recycleview);
    }

    class WeddingItemHolder extends BaseViewHolder<Integer> {
        @BindView(R.id.goods_recycle)
        RecyclerView goodsRecycle;
        @BindView(R.id.tv_peisong_type)
        TextView tvPeisongType;
        @BindView(R.id.ed_liuyan)
        EditText edLiuyan;
        @BindView(R.id.tv_goods_num)
        TextView tvGoodsNum;
        @BindView(R.id.tv_peice)
        TextView tvPeice;
        @BindView(R.id.tv_name)
        TextView tvName;
        @BindView(R.id.ll_distribution)
        LinearLayout llDistribution;
        @BindView(R.id.v_line)
        View line;

        private List<WeddingOrderBean.CartlistBean.GoodsBean> list;

        public WeddingItemHolder(View itemView) {
            super(itemView);
        }

        @Override
        protected void bindView(final Integer key) {
            if (map.get(key) != null) {
                edLiuyan.setHint("请在此填写留言");
                line.setVisibility(View.GONE);
                llDistribution.setVisibility(View.GONE);
                WeddingItemHolder.GoodsAdapter adapter = new WeddingItemHolder.GoodsAdapter();
                tvName.setText(map.get(key).get(0).getSeller().getNickname() + "");

                String price = "0.00";
                String num = "1";
                list = new ArrayList<>();
                for (int i = 0; i < map.get(key).size(); i++) {
                    WeddingOrderBean.CartlistBean.GoodsBean orderBean = map.get(key).get(i).getGoods().get(0);
                    list.add(orderBean);
//                    price = orderBean.getHeji();
                    price = orderBean.getSubtotal();
                    num = orderBean.getZquantity();
                }
                tvPeice.setText(Constans.RMB + price);
                allPrice = price;
                tvALLPrice.setText("￥" + price);
                LinearLayoutManager manager = new LinearLayoutManager(mContext) {
                    @Override
                    public boolean canScrollVertically() {
                        return false;
                    }
                };
                goodsRecycle.setLayoutManager(manager);
                goodsRecycle.setAdapter(adapter);
                adapter.setList(list);
                tvGoodsNum.setText("共" + num + "件商品");
                edLiuyan.addTextChangedListener(new TextWatcher() {
                    @Override
                    public void beforeTextChanged(CharSequence charSequence, int i, int i1, int i2) {

                    }

                    @Override
                    public void onTextChanged(CharSequence charSequence, int i, int i1, int i2) {
                        String str = charSequence.toString();
                        map.get(key).get(0).getGoods().get(0).setRemarkStr(str);
                    }

                    @Override
                    public void afterTextChanged(Editable editable) {

                    }
                });
            }
        }

        public class GoodsAdapter extends RecyclerView.Adapter<WeddingItemHolder.GoodsAdapter.VH> {
            private List<WeddingOrderBean.CartlistBean.GoodsBean> list;

            public void setList(List<WeddingOrderBean.CartlistBean.GoodsBean> list) {
                this.list = list;
                notifyDataSetChanged();
            }

            @Override
            public WeddingItemHolder.GoodsAdapter.VH onCreateViewHolder(ViewGroup parent, int viewType) {
                View view = LayoutInflater.from(mContext).inflate(R.layout.item_sure_item_layout, parent, false);
                return new WeddingItemHolder.GoodsAdapter.VH(view);
            }

            @Override
            public void onBindViewHolder(WeddingItemHolder.GoodsAdapter.VH vh, int position) {

                GlideLoad.GlideLoadImg2(list.get(position).getBaojia_image(), vh.ivImg);
                vh.tvTitle.setText(list.get(position).getBaojia_name() + "");
                vh.tvTime.setText(list.get(position).getSpecification() + "");
                vh.tvDanjia.setText(Constans.RMB + list.get(position).getPrice());
                vh.tvNum.setText("" + list.get(position).getQuantity());
                if (list.get(position).getPaytype() == 2) {
                    vh.tvDingjin.setVisibility(View.VISIBLE);
                    vh.dingjintx.setVisibility(View.VISIBLE);
                    vh.tvDingjin.setText(Constans.RMB + list.get(position).getYuandingjin());
                    vh.tvPayType.setText("定金");
                } else if (list.get(position).getPaytype() == 1){
                    vh.tvDingjin.setVisibility(View.GONE);
                    vh.dingjintx.setVisibility(View.GONE);
                    vh.tvPayType.setText("全款");
                }if (list.get(position).getPaytype() == 3) {
                    vh.tvDingjin.setVisibility(View.GONE);
                    vh.dingjintx.setVisibility(View.GONE);
                    vh.tvPayType.setText("约定全款");
                }if (list.get(position).getPaytype() == 4) {
                    vh.tvDingjin.setVisibility(View.VISIBLE);
                    vh.dingjintx.setVisibility(View.VISIBLE);
                    vh.tvDingjin.setText(Constans.RMB + list.get(position).getYuandingjin());
                    vh.tvPayType.setText("约定定金");
                }
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
                @BindView(R.id.tv_dikou)
                TextView tvDiKou;
                @BindView(R.id.dikoutext)
                TextView dikoutext;
                @BindView(R.id.tv_dingjin)
                TextView tvDingjin;
                @BindView(R.id.tv_pay_type)
                TextView tvPayType;
                @BindView(R.id.tv_num)
                TextView tvNum;

                VH(View view) {
                    super(view);
                    ButterKnife.bind(this, view);
                }
            }
        }
    }

    //拼接留言
    private void getRemark(int intentType) {
        StringBuffer remark = new StringBuffer();
        if (intentType == 0) {
            for (List<WeddingOrderBean.CartlistBean> bean : map.values()) {
                for (int i = 0; i < bean.size(); i++) {
                    for (int j = 0; j < bean.get(i).getGoods().size(); j++) {
                        if (bean.get(i).getGoods().get(j).getRemarkStr() != null && !bean.get(i).getGoods().get(j).getRemarkStr().equals("")) {
                            remark.append((bean.get(i).getGoods().get(j).getRemarkStr()));
                        } else {
                            remark.append("");

                        }
                    }
                }
            }
        } else {
            for (List<MallOrderBean.CartlistBean> bean : mallMap.values()) {
                for (int i = 0; i < bean.size(); i++) {
                    for (int j = 0; j < bean.get(i).getGoods().size(); j++) {
                        if (bean.get(i).getGoods().get(j).getRemarkStr() != null && !bean.get(i).getGoods().get(j).getRemarkStr().equals("")) {
                            remark.append((bean.get(i).getGoods().get(j).getRemarkStr()));
                        } else {
                            remark.append("");
                        }
                    }
                }
            }
        }

        if (intentType == 0) {
            submitWeddingData(remark.toString());
        } else {
            if (addressid != null)
                submitMallData(remark.toString(), addressid);
            else
                NToast.show("请先选择收货地址，再提交订单哦~");
        }
    }

    //提交婚庆
    private void submitWeddingData(String remark) {

        LoadDialog.showDialog(context);
        ApiManager.submitBuyNowWedding(baojiadate, baojiaid, baojiatime, paytype, quantity, remark,agreedPrice, new OnRequestFinish<BaseBean>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean data) {
                id = (String) data.getData();
                Intent intent = new Intent(mContext, ToPayActivity.class);
                intent.putExtra("price", allPrice);
                intent.putExtra("id", id);
                intent.putExtra("intentType", intentType);
                startActivity(intent);
                finish();
            }

            @Override
            public void onError(Exception ex) {
                NToast.show("提交订单失败，请重试！");
            }
        });
    }

    //--------------------------------------------------------------  商城 --------------------------------------------------------------------------------

    class MallItemHolder extends BaseViewHolder<Integer> {
        @BindView(R.id.goods_recycle)
        RecyclerView goodsRecycle;
        @BindView(R.id.tv_peisong_type)
        TextView tvPeisongType;
        @BindView(R.id.ed_liuyan)
        EditText edLiuyan;
        @BindView(R.id.tv_goods_num)
        TextView tvGoodsNum;
        @BindView(R.id.tv_peice)
        TextView tvPeice;
        @BindView(R.id.tv_name)
        TextView tvName;
        @BindView(R.id.ll_distribution)
        LinearLayout llDistribution;
        @BindView(R.id.v_line)
        View line;

        private List<MallOrderBean.CartlistBean.GoodsBean> list;

        public MallItemHolder(View itemView) {
            super(itemView);
        }

        @Override
        protected void bindView(final Integer key) {
            if (mallMap.get(key) != null) {
                edLiuyan.setHint("请在此填写留言");
                line.setVisibility(View.GONE);
                llDistribution.setVisibility(View.GONE);
                MallItemHolder.GoodsAdapter adapter = new MallItemHolder.GoodsAdapter();
                tvName.setText(mallMap.get(key).get(0).getSeller().getNickname() + "");
                String price = "0.00";
                String num = "0";
                list = new ArrayList<>();
                for (int i = 0; i < mallMap.get(key).size(); i++) {
                    MallOrderBean.CartlistBean.GoodsBean orderBean = mallMap.get(key).get(i).getGoods().get(0);
                    list.add(orderBean);
                    num = NumberUtil.addForNum(num, orderBean.getZquantity() + "");
                    price = NumberUtil.add(price, orderBean.getZongjine());
                }
                tvPeice.setText(Constans.RMB + price);
                allPrice = price;
                tvALLPrice.setText("￥" + allPrice);
                LinearLayoutManager manager = new LinearLayoutManager(mContext) {
                    @Override
                    public boolean canScrollVertically() {
                        return false;
                    }
                };
                goodsRecycle.setLayoutManager(manager);
                goodsRecycle.setAdapter(adapter);
                adapter.setList(list);
                tvGoodsNum.setText("共" + num + "件商品");
                edLiuyan.addTextChangedListener(new TextWatcher() {
                    @Override
                    public void beforeTextChanged(CharSequence charSequence, int i, int i1, int i2) {

                    }

                    @Override
                    public void onTextChanged(CharSequence charSequence, int i, int i1, int i2) {
                        String str = charSequence.toString();
                        mallMap.get(key).get(0).getGoods().get(0).setRemarkStr(str);
                    }

                    @Override
                    public void afterTextChanged(Editable editable) {

                    }
                });
            }
        }

        public class GoodsAdapter extends RecyclerView.Adapter<MallItemHolder.GoodsAdapter.VH> {
            private List<MallOrderBean.CartlistBean.GoodsBean> list;

            public void setList(List<MallOrderBean.CartlistBean.GoodsBean> list) {
                this.list = list;
                notifyDataSetChanged();
            }

            @Override
            public MallItemHolder.GoodsAdapter.VH onCreateViewHolder(ViewGroup parent, int viewType) {
                View view = LayoutInflater.from(mContext).inflate(R.layout.item_sure_item_layout, parent, false);
                return new MallItemHolder.GoodsAdapter.VH(view);
            }

            @Override
            public void onBindViewHolder(MallItemHolder.GoodsAdapter.VH vh, int position) {

                GlideLoad.GlideLoadImg2(list.get(position).getGoods_image(), vh.ivImg);
                vh.tvTitle.setText(list.get(position).getGoods_name() + "");
                vh.tvTime.setText(list.get(position).getSpecification() + "");
                vh.tvDanjia.setText(Constans.RMB + list.get(position).getYuandanjia());
                vh.tvNum.setText("" + list.get(position).getQuantity());
                vh.tvDingjin.setVisibility(View.GONE);
                vh.dingjintx.setVisibility(View.GONE);
                vh.payyypetext.setVisibility(View.GONE);
                vh.tvPayType.setVisibility(View.GONE);
//                if (list.get(position).getDikoutotal() != null && !list.get(position).getDikoutotal().equals("")) {
//                    vh.dikoutext.setVisibility(View.VISIBLE);
//                    vh.tvDiKou.setText("￥" + list.get(position).getDikoutotal());
//                } else {
//                    vh.dikoutext.setVisibility(View.GONE);
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
                @BindView(R.id.payyypetext)
                TextView payyypetext;

                VH(View view) {
                    super(view);
                    ButterKnife.bind(this, view);
                }
            }
        }
    }

    private void dealMallBean(MallOrderBean bean) {
        mallMap = new HashMap<>();
        List<MallOrderBean.CartlistBean> list;
        for (int i = 0; i < bean.getCartlist().size(); i++) {
            MallOrderBean.CartlistBean bean1 = bean.getCartlist().get(i);
            if (!mallMap.containsKey(bean1.getStore_id())) {
                list = new ArrayList<>();
                list.add(bean1);
                mallMap.put(bean1.getStore_id(), list);
            } else {
                mallMap.get(bean1.getStore_id()).add(bean1);
            }
        }
        for (Integer key : mallMap.keySet()) {
            baseAdapter
                    .injectHolderDelegate(new CreateHolderDelegate<Integer>() {
                        @Override
                        protected int getLayoutRes() {
                            return R.layout.sure_order_item;
                        }

                        @Override
                        protected BaseViewHolder onCreateHolder(View itemView) {
                            return new MallItemHolder(itemView);
                        }
                    }.cleanAfterAddData(key));
        }
        baseAdapter.setLayoutManager(recycleview);
    }

    private void getMallData() {
        LoadDialog.showDialog(context);
        ApiManager.buyNowMall(skuid, number, new OnRequestFinish<BaseBean<MallOrderBean>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<MallOrderBean> data) {
                baseAdapter = BaseAdapter.createBaseAdapter();
                mallOrderBean = data.getData();
                dealMallBean(mallOrderBean);
                recycleview.setAdapter(baseAdapter);
                for (int i = 0; i < mallOrderBean.getUseradders().size(); i++) {
                    if (mallOrderBean.getUseradders().get(i).getHot() == 1) {
                        tv_get_name.setText(mallOrderBean.getUseradders().get(i).getUsername() + "");
                        tvAddress.setText(mallOrderBean.getUseradders().get(i).getSite() + "");
                        tvPhone.setText(mallOrderBean.getUseradders().get(i).getMobile());
                        addressid = mallOrderBean.getUseradders().get(i).getId() + "";
                    }
                }
            }

            @Override
            public void onError(Exception ex) {
                NToast.log("===app",ex.getMessage());
            }
        });
    }

    //提交商城
    private void submitMallData(String remark, String address) {
        LoadDialog.showDialog(context);
        ApiManager.submitBuyNowMall(remark, number, skuid, address, new OnRequestFinish<BaseBean>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean data) {
                id = (String) data.getData();
                Intent intent = new Intent(mContext, ToPayActivity.class);
                intent.putExtra("price", allPrice);
                intent.putExtra("id", id);
                intent.putExtra("intentType", intentType);
                startActivity(intent);
                finish();
                EventBusUtil.sendEvent(new Event(EventCode.REFRESH_CART));
                EventBusUtil.sendEvent(new Event(EventCode.REFRESH_CART_NUM));
            }

            @Override
            public void onError(Exception ex) {
                NToast.show("提交订单失败，请重试！");
            }
        });
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
            AddressEntity addressEntity = (AddressEntity) entity.getData();
            int code = entity.getCode();
            switch (code) {
                case EventCode.SELECT_ADDRESS:
                    addressid = addressEntity.getId();
                    tv_get_name.setText("" + addressEntity.getUsername());
                    tvAddress.setText("" + addressEntity.getSite());
                    tvPhone.setText("" + addressEntity.getMobile());
                    break;
            }
        } catch (Exception e) {
        }

    }

    private void httpData() {
        ApiManager.deaftaddressList(1, new OnRequestSubscribe<BaseBean<List<AddressEntity>>>() {
            @Override
            public void onSuccess(BaseBean<List<AddressEntity>> data) {
                if (data.getData() != null&&data.getData().size()>0) {
                    addressid = data.getData().get(0).getId();
                    tv_get_name.setText("" + data.getData().get(0).getUsername());
                    tvAddress.setText("" + data.getData().get(0).getSite());
                    tvPhone.setText("" + data.getData().get(0).getMobile());
                }
            }

            @Override
            public void onError(Exception ex) {
                ToastUtils.showToast(mContext, ex.getMessage());
            }
        });
    }
}
