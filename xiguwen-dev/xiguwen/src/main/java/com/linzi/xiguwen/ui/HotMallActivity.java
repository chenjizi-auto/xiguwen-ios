package com.linzi.xiguwen.ui;

import android.os.Bundle;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.widget.ImageView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.HotMallAcAdapter;
import com.linzi.xiguwen.base.BaseActivity;

import butterknife.BindView;
import butterknife.ButterKnife;

public class HotMallActivity extends BaseActivity {

    @BindView(R.id.iv_head_img)
    ImageView ivHeadImg;
    @BindView(R.id.iv_notice)
    ImageView ivNotice;
    @BindView(R.id.recycle)
    RecyclerView recycle;
    HotMallAcAdapter mAdapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_hot_mall);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        setBack();
        setTitle("热门个人商家");

        LinearLayoutManager manager=new LinearLayoutManager(mContext){
            @Override
            public boolean canScrollVertically() {
                return false;
            }
        };
        recycle.setLayoutManager(manager);
        mAdapter=new HotMallAcAdapter(mContext);
        recycle.setAdapter(mAdapter);
    }
}
