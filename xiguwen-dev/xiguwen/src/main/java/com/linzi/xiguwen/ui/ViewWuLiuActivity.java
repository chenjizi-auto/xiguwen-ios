package com.linzi.xiguwen.ui;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import androidx.recyclerview.widget.RecyclerView;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.base.adapter.BaseAdapter;
import com.linzi.xiguwen.base.adapter.BaseViewHolder;
import com.linzi.xiguwen.base.adapter.CreateHolderDelegate;
import com.linzi.xiguwen.bean.ChaKanWuLiuBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by pc on 2018/4/23.
 */

public class ViewWuLiuActivity extends BaseActivity {
    @BindView(R.id.iv_head)
    ImageView ivHead;
    @BindView(R.id.tv_status)
    TextView tvStatus;
    @BindView(R.id.tv_sn)
    TextView tvSn;
    @BindView(R.id.recycleview)
    RecyclerView recycleview;

    private Context context;
    private int order_id;
    private BaseAdapter baseAdapter;
    private ChaKanWuLiuBean bean;

    private boolean isJiFenMall;//标记是否入口是否为积分商城

    @Override
    protected void initData() {

    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.view_wuliu_layout);
        ButterKnife.bind(this);
        context = this;
        Intent intent = getIntent();
        order_id = getIntent().getIntExtra("order_id", -1);
        isJiFenMall = getIntent().getBooleanExtra("isJiFenMall", false);
        initView();

    }

    private void initView() {
        setBack();
        setTitle("查看物流信息");

        if (order_id != -1) {
            if (isJiFenMall) {
                getDataByJiFen();
            } else {
                getData();
            }
        } else {
            finish();
            NToast.show("跳转异常，请重试！");
        }
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
         
    }

    private void getData() {
        LoadDialog.showDialog(context);
        ApiManager.chaKanWuLiu(order_id, new OnRequestFinish<BaseBean<ChaKanWuLiuBean>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<ChaKanWuLiuBean> data) {
                bean = data.getData();
                GlideLoad.GlideLoadImg2(bean.getImgurl(), ivHead);
                switch (bean.getState()) {
                    case "3":
                        tvStatus.setText("已签收");
                        break;
                    case "4":
                        tvStatus.setText("问题件");
                        break;
                    case "2":
                        tvStatus.setText("在途中");
                        break;
                    default:
                        tvStatus.setText("暂无物流信息");
                        break;
                }
                tvSn.setText("[" + bean.getKuaidiname() + "]快递编号:" + bean.getLogisticCode());
                afterView(bean);
            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }

    private void getDataByJiFen() {
        LoadDialog.showDialog(context);
        ApiManager.chaKanWuLiuByJiFEN(order_id, new OnRequestFinish<BaseBean<ChaKanWuLiuBean>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<ChaKanWuLiuBean> data) {
                bean = data.getData();
                GlideLoad.GlideLoadImg2(bean.getImgurl(), ivHead);
                switch (bean.getState()) {
                    case "3":
                        tvStatus.setText("已签收");
                        break;
                    case "4":
                        tvStatus.setText("问题件");
                        break;
                    case "2":
                        tvStatus.setText("在途中");
                        break;
                    default:
                        tvStatus.setText("暂无物流信息");
                        break;
                }
                tvSn.setText("[" + bean.getKuaidiname() + "]快递编号:" + bean.getLogisticCode());
                afterView(bean);
            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }

    //itemHOLDER
    class ItemHolder extends BaseViewHolder<ChaKanWuLiuBean.TracesBean> {
        @BindView(R.id.tv_time)
        TextView tvTime;
        @BindView(R.id.icon)
        ImageView icon;
        @BindView(R.id.tv_content)
        TextView tvContent;

        public ItemHolder(View itemView) {
            super(itemView);
        }

        @Override
        protected void bindView(ChaKanWuLiuBean.TracesBean bean) {
            if (getPosition() == 0) {
                icon.setBackgroundResource(R.mipmap.chakanwuliu_line1);
            } else {
                icon.setBackgroundResource(R.mipmap.chakanwuliu_line2);
            }
            tvTime.setText(bean.getAcceptTime());
            tvContent.setText(bean.getAcceptStation());
        }
    }

    private void afterView(ChaKanWuLiuBean bean) {
        baseAdapter = createAdapter(bean);
        recycleview.setAdapter(baseAdapter);
    }

    private BaseAdapter createAdapter(ChaKanWuLiuBean bean) {
        BaseAdapter baseAdapter = BaseAdapter.createBaseAdapter();
        baseAdapter.injectHolderDelegate(new CreateHolderDelegate<ChaKanWuLiuBean.TracesBean>() {
            @Override
            protected int getLayoutRes() {
                return R.layout.view_wuliu_item;
            }

            @Override
            protected BaseViewHolder onCreateHolder(View itemView) {
                return new ItemHolder(itemView);
            }
        }.addAllData(bean.getTraces()));
        baseAdapter.setLayoutManager(recycleview);
        return baseAdapter;
    }
}
