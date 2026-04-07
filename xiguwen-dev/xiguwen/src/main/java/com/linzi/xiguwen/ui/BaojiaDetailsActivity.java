package com.linzi.xiguwen.ui;

import android.os.Bundle;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.FindChildAdapter;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.utils.CallBack;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class BaojiaDetailsActivity extends BaseActivity {

    @BindView(R.id.tv_name)
    TextView tvName;
    @BindView(R.id.tv_price)
    TextView tvPrice;
    @BindView(R.id.tv_dingjing)
    TextView tvDingjing;
    @BindView(R.id.tv_zhekouquan)
    TextView tvZhekouquan;
    @BindView(R.id.tv_weight)
    TextView tvWeight;
    @BindView(R.id.recycle)
    RecyclerView recycle;
    @BindView(R.id.ll_weitijiao_yulan)
    LinearLayout llWeitijiaoYulan;
    @BindView(R.id.ll_weitijiao_edit)
    LinearLayout llWeitijiaoEdit;
    @BindView(R.id.ll_weitijiao_del)
    LinearLayout llWeitijiaoDel;
    @BindView(R.id.iv_end_icon)
    ImageView ivEndIcon;
    @BindView(R.id.tv_end_txt)
    TextView tvEndTxt;
    @BindView(R.id.ll_weitijiao_submit)
    LinearLayout llWeitijiaoSubmit;
    @BindView(R.id.ll_weitijiao)
    LinearLayout llWeitijiao;
    private int type=0;
    private FindChildAdapter.ImgAdapter mAdapter;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_baojia_details);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        setTitle("报价详情");
        setBack();
        type=getIntent().getIntExtra("tag",0);

        switch(type){
            case 0:

            break;
            case 1:
                llWeitijiaoSubmit.setVisibility(View.GONE);
            break;
            case 2:
                ivEndIcon.setBackgroundDrawable(mContext.getResources().getDrawable(R.mipmap.icon_baojia_shangjia));
                tvEndTxt.setText("上架");
            break;
            case 3:
                ivEndIcon.setBackgroundDrawable(mContext.getResources().getDrawable(R.mipmap.icon_baojia_chakan));
                tvEndTxt.setText("查看原因");
            break;
            case 4:
                ivEndIcon.setBackgroundDrawable(mContext.getResources().getDrawable(R.mipmap.icon_baojia_xiajia));
                tvEndTxt.setText("下架");
            break;
        }

        GridLayoutManager manager=new GridLayoutManager(mContext,3){
            @Override
            public boolean canScrollVertically() {
                return false;
            }
        };
        recycle.setLayoutManager(manager);
        mAdapter=new FindChildAdapter(mContext).new ImgAdapter(new CallBack.ImgClickListener() {
            @Override
            public void imgListener(int id) {

            }
        });
        recycle.setAdapter(mAdapter);
    }

    @OnClick({R.id.ll_weitijiao_yulan, R.id.ll_weitijiao_edit, R.id.ll_weitijiao_del, R.id.ll_weitijiao_submit, R.id.ll_weitijiao})
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.ll_weitijiao_yulan:
                break;
            case R.id.ll_weitijiao_edit:
                break;
            case R.id.ll_weitijiao_del:
                break;
            case R.id.ll_weitijiao_submit:
                break;
            case R.id.ll_weitijiao:
                break;
        }
    }
}
