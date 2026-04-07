package com.linzi.xiguwen.ui;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.MallOrderDetailsBean;
import com.linzi.xiguwen.network.Constans;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.NToast;

import butterknife.BindView;
import butterknife.ButterKnife;

public class TuikuanTypeActivity extends BaseActivity {

    @BindView(R.id.ll_only_tuikuan)
    LinearLayout llOnlyTuikuan;
    @BindView(R.id.ll_tuikuantuihuo)
    LinearLayout llTuikuantuihuo;
    @BindView(R.id.iv_img)
    ImageView ivImg;
    @BindView(R.id.tv_titles)
    TextView tvTitles;
    @BindView(R.id.tv_time)
    TextView tvTime;
    @BindView(R.id.tv_order_status)
    TextView tvOrderStatus;
    @BindView(R.id.tv_danjia)
    TextView tvDanjia;
    @BindView(R.id.dingjintx)
    TextView dingjintx;
    @BindView(R.id.tv_dingjin)
    TextView tvDingjin;
    @BindView(R.id.dikoutext)
    TextView dikoutext;
    @BindView(R.id.tv_dikou)
    TextView tvDikou;
    @BindView(R.id.payyypetext)
    TextView payyypetext;
    @BindView(R.id.tv_pay_type)
    TextView tvPayType;
    @BindView(R.id.tv_num)
    TextView tvNum;
    @BindView(R.id.tv_tuikuanbtn)
    TextView tvTuikuanbtn;

    //ShangchengOrderAdapter.GoodsAdapter mAdpater;

    private int intentType;
    private MallOrderDetailsBean.DataBean.GoodsBean bean;
    private boolean isShowTuiHuo;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_tuikuan_type);
        ButterKnife.bind(this);
        bean = getIntent().getParcelableExtra("bean");
        intentType = getIntent().getIntExtra("intentType", -1);
        isShowTuiHuo = getIntent().getBooleanExtra("isShowTuiHuo", false);

        if (bean != null) {
            if (isShowTuiHuo) {
                llTuikuantuihuo.setVisibility(View.VISIBLE);
            }

            GlideLoad.GlideLoadImg2(bean.getGoods_image(), ivImg);
            tvTitles.setText(bean.getGoods_name() + "");
            tvTime.setText(bean.getSpecification() + "");
            tvDanjia.setText(Constans.RMB + bean.getPrice());
            tvDingjin.setVisibility(View.GONE);
            dingjintx.setVisibility(View.GONE);
            tvPayType.setVisibility(View.GONE);
            tvNum.setText("" + bean.getQuantity());
            payyypetext.setVisibility(View.GONE);
        } else {
            finish();
            NToast.show("跳转失败，请重试！");
        }
    }

    @Override
    protected void initData() {
        setTitle("选择退款类型");
        setBack();

//        LinearLayoutManager manager = new LinearLayoutManager(mContext) {
//            @Override
//            public boolean canScrollVertically() {
//                return false;
//            }
//        };

        //goodsList.setLayoutManager(manager);

        //mAdpater = new ShangchengOrderAdapter(mContext).new GoodsAdapter();
        //goodsList.setAdapter(mAdpater);

        llOnlyTuikuan.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(mContext, ShangchengOrderTuikuanActivity.class);
                intent.putExtra("bean", bean);
                if (isShowTuiHuo) {
                    intent.putExtra("isTuiHuo", true);
                    intent.putExtra("type",0);
                }
                startActivity(intent);
                finish();
            }
        });

        llTuikuantuihuo.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(mContext, ShangchengOrderTuikuanActivity.class);
                intent.putExtra("bean", bean);
                intent.putExtra("isTuiHuo", true);
                intent.putExtra("type",1);
                startActivity(intent);
                finish();
            }
        });
    }
}
