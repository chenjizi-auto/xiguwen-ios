package com.linzi.xiguwen.ui;

import android.content.Intent;
import android.os.Bundle;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.SureOrderAdapter;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.utils.TimeUtils;

import butterknife.BindView;
import butterknife.ButterKnife;

public class HQJieDanTuikuanDetailsActivity extends BaseActivity {

    @BindView(R.id.tv_status)
    TextView tvStatus;
    @BindView(R.id.tv_time)
    TextView tvTime;
    @BindView(R.id.tv_status2)
    TextView tvStatus2;
    @BindView(R.id.ll_history)
    LinearLayout llHistory;
    @BindView(R.id.goods_list)
    RecyclerView goodsList;
    @BindView(R.id.tv_tuikuan_id)
    TextView tvTuikuanId;
    @BindView(R.id.tv_tuikuan_create_time)
    TextView tvTuikuanCreateTime;
    @BindView(R.id.tv_pay_money)
    TextView tvPayMoney;
    @BindView(R.id.tv_goods_size)
    TextView tvGoodsSize;
    @BindView(R.id.tv_tuikuan_reason)
    TextView tvTuikuanReason;
    @BindView(R.id.ll_contact)
    LinearLayout llContact;
    @BindView(R.id.ll_call)
    LinearLayout llCall;
    @BindView(R.id.ll_zhengchang)
    LinearLayout llZhengchang;
    @BindView(R.id.ll_all)
    LinearLayout llAll;

    SureOrderAdapter.GoodsAdapter mGoodsAdapter;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_hunqin_jiedan_tuikuan_details);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        setTitle("退款详情");
        setBack();

        LinearLayoutManager manager = new LinearLayoutManager(mContext) {
            @Override
            public boolean canScrollVertically() {
                return false;
            }
        };
        goodsList.setLayoutManager(manager);
        mGoodsAdapter = new SureOrderAdapter(mContext).new GoodsAdapter();
        goodsList.setAdapter(mGoodsAdapter);

        TimeUtils.getReturnTime3("2天20小时30分00秒", tvTime);


        llHistory.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(mContext, XIeShangHistoryActivity.class);
                startActivity(intent);
            }
        });
    }
}
