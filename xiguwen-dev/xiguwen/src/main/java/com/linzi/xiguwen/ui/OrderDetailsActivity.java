package com.linzi.xiguwen.ui;

import android.os.Bundle;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.MallIndexAdapter;
import com.linzi.xiguwen.adapter.SureOrderAdapter;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.utils.TimeUtils;

import butterknife.BindView;
import butterknife.ButterKnife;

public class OrderDetailsActivity extends BaseActivity {

    @BindView(R.id.tv_status)
    TextView tvStatus;
    @BindView(R.id.tv_time)
    TextView tvTime;
    @BindView(R.id.tv_name)
    TextView tvName;
    @BindView(R.id.tv_phone)
    TextView tvPhone;
    @BindView(R.id.tv_address)
    TextView tvAddress;
    @BindView(R.id.ll_address)
    LinearLayout llAddress;
    @BindView(R.id.tv_mall_name)
    TextView tvMallName;
    @BindView(R.id.goods_list)
    RecyclerView goodsList;
    @BindView(R.id.order_bt_del)
    Button orderBtDel;
    @BindView(R.id.tv_all_price)
    TextView tvAllPrice;
    @BindView(R.id.tv_dikou)
    TextView tvDikou;
    @BindView(R.id.tv_all_dingjin)
    TextView tvAllDingjin;
    @BindView(R.id.tv_fanxain)
    TextView tvFanxain;
    @BindView(R.id.tv_all_pay_price)
    TextView tvAllPayPrice;
    @BindView(R.id.tv_pay_price)
    TextView tvPayPrice;
    @BindView(R.id.tv_payed_price)
    TextView tvPayedPrice;
    @BindView(R.id.ll_contact)
    LinearLayout llContact;
    @BindView(R.id.ll_call)
    LinearLayout llCall;
    @BindView(R.id.tv_order_id)
    TextView tvOrderId;
    @BindView(R.id.tv_order_create_time)
    TextView tvOrderCreateTime;
    @BindView(R.id.tv_first_pay_time)
    TextView tvFirstPayTime;
    @BindView(R.id.tv_end_pay_time)
    TextView tvEndPayTime;
    @BindView(R.id.tv_finish_time)
    TextView tvFinishTime;
    @BindView(R.id.order_bt_copy)
    Button orderBtCopy;
    @BindView(R.id.guerss_recycle)
    RecyclerView guerssRecycle;
    @BindView(R.id.order_bt_1)
    Button orderBt1;
    @BindView(R.id.order_bt_2)
    Button orderBt2;

    SureOrderAdapter.GoodsAdapter mGoodsAdapter;
    MallIndexAdapter.BaojiaAdapter mGuessAdapter;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_order_details_adaptivity);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        setTitle("订单详情");
        setBack();

        LinearLayoutManager manager_goods=new LinearLayoutManager(mContext){
            @Override
            public boolean canScrollVertically() {
                return false;
            }
        };
        goodsList.setLayoutManager(manager_goods);
        GridLayoutManager manager_guess=new GridLayoutManager(mContext,2){
            @Override
            public boolean canScrollVertically() {
                return false;
            }
        };
        guerssRecycle.setLayoutManager(manager_guess);

        mGoodsAdapter=new SureOrderAdapter(mContext).new GoodsAdapter();
        goodsList.setAdapter(mGoodsAdapter);

        mGuessAdapter=new MallIndexAdapter(mContext).new BaojiaAdapter();
        guerssRecycle.setAdapter(mGuessAdapter);

        TimeUtils.getReturnTime2("20小时30分00秒",tvTime);
    }
}
