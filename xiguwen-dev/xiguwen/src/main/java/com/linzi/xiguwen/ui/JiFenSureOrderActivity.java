package com.linzi.xiguwen.ui;

import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import androidx.annotation.Nullable;
import androidx.recyclerview.widget.RecyclerView;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.View;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.base.adapter.BaseAdapter;
import com.linzi.xiguwen.base.adapter.BaseViewHolder;
import com.linzi.xiguwen.base.adapter.CreateHolderDelegate;
import com.linzi.xiguwen.bean.AddressEntity;
import com.linzi.xiguwen.bean.JiFenOrderBean;
import com.linzi.xiguwen.bean.JiFenPostOrderBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.OnRequestSubscribe;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.LoginUtil;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;
import com.linzi.xiguwen.view.dialog.InputPassWordDialog;
import com.luck.picture.lib.utils.ToastUtils;

import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by pc on 2018/5/25.
 */

public class JiFenSureOrderActivity extends BaseActivity {
    @BindView(R.id.tv_get_name)
    TextView tv_get_name;
    @BindView(R.id.tv_phone)
    TextView tvPhone;
    @BindView(R.id.tv_address)
    TextView tvAddress;
    @BindView(R.id.ll_address)
    LinearLayout llAddress;
    @BindView(R.id.recycleview)
    RecyclerView recycleview;
    @BindView(R.id.tv_price)
    TextView tvPrice;
    @BindView(R.id.tv_submit)
    TextView tvSubmit;
    @BindView(R.id.bottombar)
    LinearLayout bottombar;
    @BindView(R.id.ll_price)
    LinearLayout llPrice;

    private String addressid;
    private Context context;
    private BaseAdapter baseAdapter;
    private int rec_id;
    private String id;//提交成功后的编号

    private JiFenOrderBean jiFenOrderBean;

    private InputPassWordDialog dialog;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.sure_order_layout);
        ButterKnife.bind(this);
        EventBusUtil.register(this);
        context = this;
        rec_id = getIntent().getIntExtra("rec_id", -1);
        initView();

    }

    @Override
    protected void initData() {

    }

    private void initView() {
        setBack();
        setTitle("确认订单");
        tvSubmit.setText("确认兑换");
        llPrice.setVisibility(View.GONE);

        if (rec_id != -1) {
            llAddress.setVisibility(View.VISIBLE);

            llAddress.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Intent intent = new Intent(mContext, AddressManagerActivity.class);
                    mContext.startActivity(intent);
                }
            });
            httpData();
            getData();
        } else {
            finish();
            NToast.show("跳转失败，请重试！");
        }

        afterView();

        tvSubmit.setEnabled(false);
    }

    private void afterView() {
        baseAdapter = createAdapter();
        recycleview.setAdapter(baseAdapter);
    }

    private void getData() {
        LoadDialog.showDialog(context);
        ApiManager.getJiFenOrder(rec_id, new OnRequestFinish<BaseBean<JiFenOrderBean>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<JiFenOrderBean> data) {
                jiFenOrderBean = data.getData();
                itemdel.cleanAfterAddData(jiFenOrderBean);
                baseAdapter.notifyDataSetChanged();

                tvSubmit.setEnabled(true);
                tvSubmit.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        if (!LoginUtil.isLogin()) {
                            LoginActivity.startAction(context);
                            return;
                        }
                        if (addressid != null && !addressid.equals("")) {
                            postData();
                        } else {
                            NToast.show("请先选择收货地址，再提交订单哦~");
                        }
                    }
                });
            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }

    private BaseAdapter createAdapter() {
        BaseAdapter baseAdapter = BaseAdapter.createBaseAdapter();
        baseAdapter.injectHolderDelegate(itemdel);
        baseAdapter.setLayoutManager(recycleview);
        return baseAdapter;
    }

    CreateHolderDelegate<JiFenOrderBean> itemdel = new CreateHolderDelegate<JiFenOrderBean>() {
        @Override
        protected int getLayoutRes() {
            return R.layout.jifen_sure_order_item;
        }

        @Override
        protected BaseViewHolder onCreateHolder(View itemView) {
            return new MallItemHolder(itemView);
        }
    };

    class MallItemHolder extends BaseViewHolder<JiFenOrderBean> {
        @BindView(R.id.tv_name)
        TextView tvName;
        @BindView(R.id.iv_img)
        ImageView ivImg;
        @BindView(R.id.tv_title)
        TextView tvTitle;
        @BindView(R.id.tv_time)
        TextView tvTime;
        @BindView(R.id.tv_order_status)
        TextView tvOrderStatus;
        @BindView(R.id.tv_num)
        TextView tvNum;
        @BindView(R.id.tv_tuikuanbtn)
        TextView tvTuikuanbtn;
        @BindView(R.id.ed_liuyan)
        EditText edLiuyan;


        public MallItemHolder(View itemView) {
            super(itemView);
        }

        @Override
        protected void bindView(final JiFenOrderBean bean) {
            edLiuyan.setHint("请在此填写留言");
            tvName.setText("喜顾问");
            GlideLoad.GlideLoadImg2(bean.getTupian(), ivImg);
            tvTitle.setText(bean.getName());

            if (bean.getJiage() != null && !bean.getJiage().equals("0") && !bean.getJiage().equals("0.00")) {
                tvTime.setText(bean.getJifen() + "积分+" + bean.getJiage() + "元");
            } else {
                tvTime.setText(bean.getJifen() + "积分");
            }

            tvNum.setText("1");

            edLiuyan.addTextChangedListener(new TextWatcher() {
                @Override
                public void beforeTextChanged(CharSequence charSequence, int i, int i1, int i2) {

                }

                @Override
                public void onTextChanged(CharSequence charSequence, int i, int i1, int i2) {
                    String str = charSequence.toString();
                    bean.setLiuyan(str);
                }

                @Override
                public void afterTextChanged(Editable editable) {

                }
            });
        }


    }


    @Override
    protected void onDestroy() {
        super.onDestroy();
         
        EventBusUtil.unregister(this);
    }

    @Subscribe(threadMode = ThreadMode.MAIN)
    public void receiveEvent(Event entity) {
        if (entity == null)
            return;
        try {
            AddressEntity addressEntity = (AddressEntity) entity.getData();
            int code = entity.getCode();
            switch (code) {
                case EventCode.SELECT_ADDRESS:
                    addressid = addressEntity.getId();
                    tv_get_name.setText("" + addressEntity.getUsername());
                    tvAddress.setText("" + addressEntity.getSite());
                    tvPhone.setText("" + addressEntity.getMobile());
                    break;
            }
        } catch (Exception e) {
        }

    }

    private void httpData() {
        ApiManager.deaftaddressList(1, new OnRequestSubscribe<BaseBean<List<AddressEntity>>>() {
            @Override
            public void onSuccess(BaseBean<List<AddressEntity>> data) {
                if (data.getData() != null && data.getData().size() > 0) {
                    addressid = data.getData().get(0).getId();
                    tv_get_name.setText("" + data.getData().get(0).getUsername());
                    tvAddress.setText("" + data.getData().get(0).getSite());
                    tvPhone.setText("" + data.getData().get(0).getMobile());
                }
            }

            @Override
            public void onError(Exception ex) {
                ToastUtils.showToast(mContext, ex.getMessage());
            }
        });
    }

    //提交订单
    private void postData() {
        LoadDialog.showDialog(context);
        ApiManager.postJiFenOrder(rec_id, jiFenOrderBean.getLiuyan(), addressid, new OnRequestFinish<BaseBean<JiFenPostOrderBean>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<JiFenPostOrderBean> data) {
                if (data.getData().getJine() != null && !data.getData().getJine().equals("0") && !data.getData().getJine().equals("0.00")) {
                    Intent intent = new Intent(context, ToPayActivity.class);
                    intent.putExtra("intentType", 6);
                    intent.putExtra("price", data.getData().getJine());
                    intent.putExtra("id", data.getData().getOrdersn());
                    context.startActivity(intent);
                } else {
                    if (dialog == null) {
                        dialog = createDialog(false);
                        dialog.setId(data.getData().getOrdersn());
                        dialog.setJiFen(true);
                        dialog.setPrice(data.getData().getJifen() + "");
                        dialog.isShow();
                    } else {
                        dialog.clearInput();
                        dialog.setId(data.getData().getOrdersn());
                        dialog.setJiFen(true);
                        dialog.setPrice(data.getData().getJifen() + "");
                        dialog.isShow();
                    }
                }
                finish();
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
            }
        });
    }

    //初始化余额支付对话框
    private InputPassWordDialog createDialog(boolean isWeiKuan) {
        dialog = new InputPassWordDialog(context, R.style.MyDialog, isWeiKuan, 7);
        dialog.setRefreshNum(new InputPassWordDialog.RefreshNum() {
            @Override
            public void onRefresh() {
                finish();
                EventBusUtil.sendEvent(new Event(EventCode.PAY_SUCCRSS));
            }
        });
        dialog.setOnDismissListener(new DialogInterface.OnDismissListener() {
            @Override
            public void onDismiss(DialogInterface dialogInterface) {
                // NToast.show("订单生成后已扣除对应积分，请尽快完成兑换订单哦~");
                finish();
            }
        });
        return dialog;
    }
}
