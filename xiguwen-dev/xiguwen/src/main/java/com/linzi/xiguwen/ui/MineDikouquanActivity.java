package com.linzi.xiguwen.ui;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.ZhekouquanAdapter;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.utils.AppUtil;

import butterknife.BindView;
import butterknife.ButterKnife;

public class MineDikouquanActivity extends BaseActivity {

    @BindView(R.id.recycle)
    RecyclerView recycle;

    ZhekouquanAdapter mAapter;

    private String price;

    public static void startAction(Context context,String price){
        Intent intent=new Intent(context,MineDikouquanActivity.class);
        intent.putExtra("price",price);
        context.startActivity(intent);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_mine_dikouquan);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        setTitle("现金抵扣券");
        setBack();

        LinearLayoutManager manager = new LinearLayoutManager(mContext);
        recycle.setLayoutManager(manager);

        mAapter = new ZhekouquanAdapter(mContext);
        recycle.setAdapter(mAapter);
        price = getIntent().getStringExtra("price");
        if (AppUtil.isEmpty(price)){
            price="0";
        }
        mAapter.addPrice(price);
    }
}
