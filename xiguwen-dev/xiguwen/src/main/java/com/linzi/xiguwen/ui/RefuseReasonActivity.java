package com.linzi.xiguwen.ui;

import android.content.Context;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.View;
import android.widget.EditText;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;

import butterknife.BindView;
import butterknife.ButterKnife;

public class RefuseReasonActivity extends BaseActivity {

    @BindView(R.id.ed_context)
    EditText edContext;

    private Context context;
    private int order_id;
    private int type;//标记是否商城已发货  0未发货，1已发货 2拒绝退货收货

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_refuse_reason);
        ButterKnife.bind(this);
        context = this;
        order_id = getIntent().getIntExtra("order_id", -1);
        type = getIntent().getIntExtra("type", -1);
    }

    @Override
    protected void initData() {
        setTitle("填写拒绝理由");
        setBack();
        setRight("提交", new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (!TextUtils.isEmpty(edContext.getText().toString())) {
                    switch (type) {
                        case 0:
                            refusedweifahuoTuiKuan(order_id, edContext.getText().toString());
                            break;
                        case 1:
                            refusedyifahuoTuiKuan(order_id, edContext.getText().toString());
                            break;
                        case 2:
                            refusedshouhuoTuiKuan(order_id, edContext.getText().toString());
                            break;
                        default:
                            refusedWeddingTuiKuan(order_id, edContext.getText().toString());
                            break;
                    }

                } else {
                    NToast.show("请填写拒绝退款理由");
                }
            }
        });
    }

    //拒绝退款
    private void refusedWeddingTuiKuan(int id, String text) {
        if (order_id != -1) {
            LoadDialog.showDialog(context);
            ApiManager.refusedWeddingOrderTuiKuan(id, text, new OnRequestFinish<BaseBean>() {
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
            finish();
            NToast.show("获取订单号失败，请尝试重试！");
        }
    }

    //拒绝未发货退款
    private void refusedweifahuoTuiKuan(int id, String text) {
        if (order_id != -1) {
            LoadDialog.showDialog(context);
            ApiManager.canlefahuotuikuan(id, text, new OnRequestFinish<BaseBean>() {
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
            finish();
            NToast.show("获取订单号失败，请尝试重试！");
        }
    }

    //拒绝已发货退款
    private void refusedyifahuoTuiKuan(int id, String text) {
        if (order_id != -1) {
            LoadDialog.showDialog(context);
            ApiManager.canleyifahuotuikuan(id, text, new OnRequestFinish<BaseBean>() {
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
            finish();
            NToast.show("获取订单号失败，请尝试重试！");
        }
    }

    //拒绝退货收货
    private void refusedshouhuoTuiKuan(int id, String text) {
        if (order_id != -1) {
            LoadDialog.showDialog(context);
            ApiManager.canleshouhuotuikuan(id, text, new OnRequestFinish<BaseBean>() {
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
            finish();
            NToast.show("获取订单号失败，请尝试重试！");
        }
    }
}
