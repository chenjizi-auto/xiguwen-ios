package com.linzi.xiguwen.ui;

import android.content.Context;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.View;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.MallOrderDetailsBean;
import com.linzi.xiguwen.bean.MallOrderListBean;
import com.linzi.xiguwen.bean.WeddingOrderDetailsBean;
import com.linzi.xiguwen.bean.WeddingOrderListBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.network.Constans;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;

import butterknife.BindView;
import butterknife.ButterKnife;

public class ShenQingTuikuanActivity extends BaseActivity {

    @BindView(R.id.iv_img)
    ImageView ivImg;
    @BindView(R.id.tv_name)
    TextView tvTitle;
    @BindView(R.id.tv_time)
    TextView tvTime;
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
    @BindView(R.id.tv_pay_type)
    TextView tvPayType;
    @BindView(R.id.tv_num)
    TextView tvNum;
    @BindView(R.id.ed_context)
    EditText edContext;
    @BindView(R.id.tv_price)
    TextView tvPrice;
    @BindView(R.id.et_price)
    EditText etPrice;

    private WeddingOrderDetailsBean weddingOrderDetailsBean;
    private WeddingOrderListBean.DataBean weddingOrderListBean;
    private MallOrderDetailsBean.DataBean.GoodsBean mallOrderDetailsBean;
    private MallOrderListBean.DataBean mallOrderListBean;
    private int type;//0列表跳转 1详情跳转
    private Context context;
    private int order_id;
    private int intentType;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_shen_qing_tuikuan);
        ButterKnife.bind(this);
        context = this;
        type = getIntent().getIntExtra("type", -1);
        intentType = getIntent().getIntExtra("intentType", -1);
        initView();
    }

    private void initView() {
        setTitle("申请退款");
        setBack();
        setRight("提交  ", new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                requstTuiKuan(order_id);
            }
        });
        if (intentType == 0) {
            switch (type) {
                case 0:
                    weddingOrderListBean = getIntent().getParcelableExtra("listbean");
                    order_id = weddingOrderListBean.getOrder_id();
                    GlideLoad.GlideLoadImg2(weddingOrderListBean.getBaojia_image(), ivImg);
                    tvTitle.setText(weddingOrderListBean.getBaojia_name() + "");
                    tvTime.setText(weddingOrderListBean.getSpecification() + "");
                    tvDanjia.setText(Constans.RMB + weddingOrderListBean.getPrice());
                    tvNum.setText("" + weddingOrderListBean.getQuantity());
                    tvPrice.setText("￥" + weddingOrderListBean.getShifukuan());

                    if (weddingOrderListBean.getPaytype() == 2) {
                        tvDingjin.setVisibility(View.VISIBLE);
                        dingjintx.setVisibility(View.VISIBLE);
                        tvDingjin.setText(Constans.RMB + weddingOrderListBean.getYuandingjin());
                        tvPayType.setText("定金");
                    } else {
                        tvDingjin.setVisibility(View.GONE);
                        dingjintx.setVisibility(View.GONE);
                        tvPayType.setText("全款");
                    }
                    if (weddingOrderListBean.getDeductible() != null && !weddingOrderListBean.getDeductible().equals("")) {
                        dikoutext.setVisibility(View.VISIBLE);
                        tvDikou.setText("￥" + weddingOrderListBean.getDeductible());
                    } else {
                        dikoutext.setVisibility(View.GONE);
                    }
                    break;
                case 1:
                    weddingOrderDetailsBean = getIntent().getParcelableExtra("bean");
                    order_id = weddingOrderDetailsBean.getOrder_id();
                    GlideLoad.GlideLoadImg2(weddingOrderDetailsBean.getBaojia_image(), ivImg);
                    tvTitle.setText(weddingOrderDetailsBean.getBaojia_name() + "");
                    tvTime.setText(weddingOrderDetailsBean.getSpecification() + "");
                    tvDanjia.setText(Constans.RMB + weddingOrderDetailsBean.getOrder_amount());
                    if (weddingOrderDetailsBean.getPaytype() == 2) {
                        tvDingjin.setVisibility(View.VISIBLE);
                        dingjintx.setVisibility(View.VISIBLE);
                        tvDingjin.setText(Constans.RMB + weddingOrderDetailsBean.getOrder_amount());
                        tvPayType.setText("定金");
                    } else {
                        tvDingjin.setVisibility(View.GONE);
                        dingjintx.setVisibility(View.GONE);
                        tvPayType.setText("全款");
                    }
                    if (weddingOrderDetailsBean.getDiscount() != null && !weddingOrderDetailsBean.getDiscount().equals("")) {
                        dikoutext.setVisibility(View.VISIBLE);
                        tvDikou.setText("￥" + weddingOrderDetailsBean.getDiscount());
                    } else {
                        dikoutext.setVisibility(View.GONE);
                    }
                    tvNum.setText("" + weddingOrderDetailsBean.getQuantity());
                    tvPrice.setText("￥" + weddingOrderDetailsBean.getOrder_amount());
                    break;
                default:
                    finish();
                    NToast.show("跳转失败，请重试！");
                    break;
            }
        }else {
            switch (type) {
                case 0:
                    mallOrderDetailsBean = getIntent().getParcelableExtra("listbean");
                    order_id = mallOrderDetailsBean.getOrder_id();
                    GlideLoad.GlideLoadImg2(mallOrderDetailsBean.getGoods_image(), ivImg);
                    tvTitle.setText(mallOrderDetailsBean.getGoods_name() + "");
                    tvTime.setText(mallOrderDetailsBean.getSpecification() + "");
                    tvDanjia.setText(Constans.RMB + mallOrderDetailsBean.getPrice());
                    tvNum.setText("" + mallOrderDetailsBean.getQuantity());
                    tvPrice.setText("￥" + mallOrderDetailsBean.getPrice());

                    if (weddingOrderListBean.getPaytype() == 2) {
                        tvDingjin.setVisibility(View.VISIBLE);
                        dingjintx.setVisibility(View.VISIBLE);
                        tvDingjin.setText(Constans.RMB + weddingOrderListBean.getYuandingjin());
                        tvPayType.setText("定金");
                    } else {
                        tvDingjin.setVisibility(View.GONE);
                        dingjintx.setVisibility(View.GONE);
                        tvPayType.setText("全款");
                    }
                    if (weddingOrderListBean.getDeductible() != null && !weddingOrderListBean.getDeductible().equals("")) {
                        dikoutext.setVisibility(View.VISIBLE);
                        tvDikou.setText("￥" + weddingOrderListBean.getDeductible());
                    } else {
                        dikoutext.setVisibility(View.GONE);
                    }
                    break;
                case 1:
                    weddingOrderDetailsBean = getIntent().getParcelableExtra("bean");
                    order_id = weddingOrderDetailsBean.getOrder_id();
                    GlideLoad.GlideLoadImg2(weddingOrderDetailsBean.getBaojia_image(), ivImg);
                    tvTitle.setText(weddingOrderDetailsBean.getBaojia_name() + "");
                    tvTime.setText(weddingOrderDetailsBean.getSpecification() + "");
                    tvDanjia.setText(Constans.RMB + weddingOrderDetailsBean.getOrder_amount());
                    if (weddingOrderDetailsBean.getPaytype() == 2) {
                        tvDingjin.setVisibility(View.VISIBLE);
                        dingjintx.setVisibility(View.VISIBLE);
                        tvDingjin.setText(Constans.RMB + weddingOrderDetailsBean.getOrder_amount());
                        tvPayType.setText("定金");
                    } else {
                        tvDingjin.setVisibility(View.GONE);
                        dingjintx.setVisibility(View.GONE);
                        tvPayType.setText("全款");
                    }
                    if (weddingOrderDetailsBean.getDiscount() != null && !weddingOrderDetailsBean.getDiscount().equals("")) {
                        dikoutext.setVisibility(View.VISIBLE);
                        tvDikou.setText("￥" + weddingOrderDetailsBean.getDiscount());
                    } else {
                        dikoutext.setVisibility(View.GONE);
                    }
                    tvNum.setText("" + weddingOrderDetailsBean.getQuantity());
                    tvPrice.setText("￥" + weddingOrderDetailsBean.getOrder_amount());
                    break;
                default:
                    finish();
                    NToast.show("跳转失败，请重试！");
                    break;
            }
        }

    }

    @Override
    protected void initData() {

    }

    //提交退款请求
    private void requstTuiKuan(int id) {
        if (!TextUtils.isEmpty(edContext.getText().toString()) && !TextUtils.isEmpty(etPrice.getText().toString())) {
            LoadDialog.showDialog(context);
            ApiManager.weddingShenQingTuiKuan(id, edContext.getText().toString(), etPrice.getText().toString(), new OnRequestFinish<BaseBean>() {
                @Override
                public void onFinished() {
                    LoadDialog.CancelDialog();
                }

                @Override
                public void onSuccess(BaseBean data) {
                    NToast.show(data.getMessage());
                    finish();
                    EventBusUtil.sendEvent(new Event(EventCode.REFRESH));
                }

                @Override
                public void onError(Exception ex) {
                    NToast.show(ex.getMessage());
                }
            });
        } else {
            NToast.show("请完善所有退款信息！~");
        }

    }
}
