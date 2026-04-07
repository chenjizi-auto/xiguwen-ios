package com.linzi.xiguwen.ui;

import android.content.Context;
import android.os.Bundle;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.widget.ImageView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.TebieTuijianAdapter;
import com.linzi.xiguwen.base.BaseActivity;

import butterknife.BindView;
import butterknife.ButterKnife;

public class TebieTuijianActivity extends BaseActivity {

    @BindView(R.id.iv_head_img)
    ImageView ivHeadImg;
    @BindView(R.id.iv_zhongshi)
    ImageView ivZhongshi;
    @BindView(R.id.iv_xishi)
    ImageView ivXishi;
    @BindView(R.id.iv_caoping)
    ImageView ivCaoping;
    @BindView(R.id.iv_shishang)
    ImageView ivShishang;
    @BindView(R.id.recycle)
    RecyclerView recycle;

    private Context mContext;
    private TebieTuijianAdapter mAdpater;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_tebie_tuijian);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        mContext=this;
        setBack();
        setTitle("特别推荐");
        LinearLayoutManager manager=new LinearLayoutManager(mContext){
            @Override
            public boolean canScrollVertically() {
                return false;
            }
        };
        recycle.setLayoutManager(manager);
        mAdpater=new TebieTuijianAdapter(mContext);
        recycle.setAdapter(mAdpater);
    }
}
