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

import butterknife.BindView;
import butterknife.ButterKnife;

public class SureOrderActivity extends BaseActivity {

    @BindView(R.id.tv_name)
    TextView tvName;
    @BindView(R.id.tv_phone)
    TextView tvPhone;
    @BindView(R.id.tv_address)
    TextView tvAddress;
    @BindView(R.id.ll_address)
    LinearLayout llAddress;
    @BindView(R.id.recycle)
    RecyclerView recycle;
    @BindView(R.id.tv_price)
    TextView tvPrice;
    @BindView(R.id.tv_submit)
    TextView tvSubmit;

    SureOrderAdapter mAdapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_sure_order);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        setTitle("确认订单");
        setBack();

        LinearLayoutManager manager=new LinearLayoutManager(mContext){
            @Override
            public boolean canScrollVertically() {
                return false;
            }
        };
        recycle.setLayoutManager(manager);

        mAdapter=new SureOrderAdapter(mContext);
        recycle.setAdapter(mAdapter);

        tvSubmit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent=new Intent(mContext,ToPayActivity.class);
                startActivity(intent);
            }
        });

        llAddress.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent=new Intent(mContext,AddressManagerActivity.class);
                startActivity(intent);
            }
        });
    }
}
