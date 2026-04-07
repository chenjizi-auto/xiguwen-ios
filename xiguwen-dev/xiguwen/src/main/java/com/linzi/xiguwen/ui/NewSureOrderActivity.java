package com.linzi.xiguwen.ui;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import androidx.annotation.Nullable;
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
 * Created by pc on 2018/4/12.
 */

public class NewSureOrderActivity extends BaseActivity {
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
    TextView tvPrice;
    @BindView(R.id.tv_submit)
    TextView tvSubmit;
    @BindView(R.id.bottombar)
    LinearLayout bottombar;

    private String addressid;
    private String allPrice = "0.00";
    private Context context;
    private BaseAdapter baseAdapter;
    private String rec_id;
    private int intentType;//0是婚庆 1是商城 控制地址是否显示
    private WeddingOrderBean weddingOrderBean;
    private MallOrderBean mallOrderBean;
    private HashMap<Integer, List<WeddingOrderBean.CartlistBean>> map;
    private HashMap<Integer, List<MallOrderBean.CartlistBean>> mallMap;
    private String id;//提交成功后的编号

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.sure_order_layout);
        ButterKnife.bind(this);
        EventBusUtil.register(this);
        context = this;
        rec_id = getIntent().getStringExtra("rec_id");
        intentType = getIntent().getIntExtra("intentType", -1);
        initView();

    }

    @Override
    protected void initData() {

    }

    private void initView() {
        setBack();
        setTitle("确认订单");
        if (intentType != -1) {
            if (intentType == 1) {
                llAddress.setVisibility(View.VISIBLE);
                httpData();
                getMallDate();
                llAddress.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        Intent intent = new Intent(mContext, AddressManagerActivity.class);
                        mContext.startActivity(intent);
                    }
                });
            } else {
                llAddress.setVisibility(View.GONE);
                getWeddingData();
            }
        } else {
            finish();
            NToast.show("跳转失败，请重试！");
        }
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
                GoodsAdapter adapter = new GoodsAdapter();
                tvName.setText(map.get(key).get(0).getSeller().getNickname() + "");
                String price = "0.00";
                String num = "0";
                list = new ArrayList<>();
                for (int i = 0; i < map.get(key).size(); i++) {
                    WeddingOrderBean.CartlistBean.GoodsBean orderBean = map.get(key).get(i).getGoods().get(0);
                    list.add(orderBean);
                    num = NumberUtil.addForNum(num, orderBean.getZquantity());
                    price = NumberUtil.add(price, orderBean.getZongjine());
                }
                tvPeice.setText(Constans.RMB + price);
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

        public class GoodsAdapter extends RecyclerView.Adapter<GoodsAdapter.VH> {
            private List<WeddingOrderBean.CartlistBean.GoodsBean> list;

            public void setList(List<WeddingOrderBean.CartlistBean.GoodsBean> list) {
                this.list = list;
                notifyDataSetChanged();
            }

            @Override
            public GoodsAdapter.VH onCreateViewHolder(ViewGroup parent, int viewType) {
                View view = LayoutInflater.from(mContext).inflate(R.layout.item_sure_item_layout, parent, false);
                return new VH(view);
            }

            @Override
            public void onBindViewHolder(GoodsAdapter.VH vh, int position) {

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
                } else {
                    vh.tvDingjin.setVisibility(View.GONE);
                    vh.dingjintx.setVisibility(View.GONE);
                    vh.tvPayType.setText("全款");
                }
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

                VH(View view) {
                    super(view);
                    ButterKnife.bind(this, view);
                }
            }
        }
    }

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
                GoodsAdapter adapter = new GoodsAdapter();
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

        public class GoodsAdapter extends RecyclerView.Adapter<GoodsAdapter.VH> {
            private List<MallOrderBean.CartlistBean.GoodsBean> list;

            public void setList(List<MallOrderBean.CartlistBean.GoodsBean> list) {
                this.list = list;
                notifyDataSetChanged();
            }

            @Override
            public GoodsAdapter.VH onCreateViewHolder(ViewGroup parent, int viewType) {
                View view = LayoutInflater.from(mContext).inflate(R.layout.item_sure_item_layout, parent, false);
                return new VH(view);
            }

            @Override
            public void onBindViewHolder(GoodsAdapter.VH vh, int position) {

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

    //婚庆结算
    private void getWeddingData() {
        LoadDialog.showDialog(context);
        ApiManager.getWeddingOreder(rec_id, new OnRequestFinish<BaseBean<WeddingOrderBean>>() {
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
                allPrice = weddingOrderBean.getHeji();
                tvPrice.setText("￥" + allPrice);
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

    //商城结算
    private void getMallDate() {
        LoadDialog.showDialog(context);
        ApiManager.getMallOreder(rec_id, new OnRequestFinish<BaseBean<MallOrderBean>>() {
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
                allPrice = mallOrderBean.getHeji();
                tvPrice.setText("￥" + allPrice);
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
                NToast.log("===app",ex.toString());
            }
        });
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

    @Override
    protected void onDestroy() {
        super.onDestroy();
         
        EventBusUtil.unregister(this);
    }

    //拼接留言
    private void getRemark(int intentType) {
        StringBuffer remark = new StringBuffer();
        StringBuffer liuyanid = new StringBuffer();
        if (intentType == 0) {
            for (List<WeddingOrderBean.CartlistBean> bean : map.values()) {
                for (int i = 0; i < bean.size(); i++) {
                    for (int j = 0; j < bean.get(i).getGoods().size(); j++) {
                        if (bean.get(i).getGoods().get(j).getRemarkStr() != null && !bean.get(i).getGoods().get(j).getRemarkStr().equals("")) {
                            remark.append("_" + (bean.get(i).getGoods().get(j).getRemarkStr()));
                            liuyanid.append("_" + (bean.get(i).getGoods().get(j).getStore_id()));
                        } else {
                            remark.append("");
                            liuyanid.append("");
                        }
                    }
                }
            }
        } else {
            for (List<MallOrderBean.CartlistBean> bean : mallMap.values()) {
                for (int i = 0; i < bean.size(); i++) {
                    for (int j = 0; j < bean.get(i).getGoods().size(); j++) {
                        if (bean.get(i).getGoods().get(j).getRemarkStr() != null && !bean.get(i).getGoods().get(j).getRemarkStr().equals("")) {
                            remark.append("_" + (bean.get(i).getGoods().get(j).getRemarkStr()));
                            liuyanid.append("_" + (bean.get(i).getGoods().get(j).getStore_id()));
                        } else {
                            remark.append("");
                            liuyanid.append("");
                        }
                    }
                }
            }
        }
        if (remark.toString().startsWith("_")) {
            remark.deleteCharAt(0);
        }
        if (liuyanid.toString().startsWith("_")) {
            liuyanid.deleteCharAt(0);
        }
        if (remark.toString().endsWith("_")) {
            remark.deleteCharAt(rec_id.length() - 1);
        }
        if (liuyanid.toString().endsWith("_")) {
            liuyanid.deleteCharAt(liuyanid.length() - 1);
        }
        if (intentType == 1) {
            if (addressid != null)
                submitMallData(remark.toString(), addressid);
            else
                NToast.show("请先选择收货地址，再提交订单哦~");
        } else {
            submitWeddingData(remark.toString(), liuyanid.toString());
        }
    }

    //提交婚庆
    private void submitWeddingData(String remark, String liuyanid) {

        LoadDialog.showDialog(context);
        ApiManager.submitWeddingOreder(rec_id, liuyanid, remark, new OnRequestFinish<BaseBean>() {
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

    //提交商城
    private void submitMallData(String remark, String addressid) {
        LoadDialog.showDialog(context);
        ApiManager.submitMallOreder(rec_id, remark, addressid, new OnRequestFinish<BaseBean>() {
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
