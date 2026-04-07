package com.linzi.xiguwen.view.dialog;

import android.app.Dialog;
import android.content.Context;
import android.os.Bundle;
import androidx.annotation.NonNull;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import com.jungly.gridpasswordview.GridPasswordView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.PayBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;

/**
 * Created by pc on 2018/4/15.
 */

public class InputPassWordDialog extends Dialog {
    private TextView tv_price, tag;
    private GridPasswordView passwordView;
    private ImageView iv_close;
    private Context context;
    private String price;
    private String id;
    private int order_id;
    private String order_id_str;
    private RefreshNum refreshNum;
    private boolean isWeiKuan;//标记是否为尾款支付
    private int intentType;
    private String longtime;
    private boolean isJiFen;//标记是否为积分支付

    public void setJiFen(boolean jiFen) {
        isJiFen = jiFen;
    }

    public void setLongtime(String longtime) {
        this.longtime = longtime;
    }

    public void setRefreshNum(RefreshNum refreshNum) {
        this.refreshNum = refreshNum;
    }

    public interface RefreshNum {
        void onRefresh();
    }

    public void setOrder_id_str(String order_id_str) {
        this.order_id_str = order_id_str;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public void setId(String id) {
        this.id = id;
    }

    public void setOrder_id(int order_id) {
        this.order_id = order_id;
    }

    //清空内容
    public void clearInput() {
        if (passwordView.getPassWord() != null && !passwordView.getPassWord().equals("")) {
            passwordView.clearPassword();
        }
    }

    public InputPassWordDialog(@NonNull Context context, int themeResId, boolean isWeiKuan, int intentType) {
        super(context, themeResId);
        this.context = context;
        this.isWeiKuan = isWeiKuan;
        this.intentType = intentType;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.pay_inputpassword_layout);
        //按空白处取消动画
        setCanceledOnTouchOutside(true);

        initView();
    }

    private void initView() {

        tv_price = findViewById(R.id.tv_price);
        passwordView = findViewById(R.id.pswView);
        iv_close = findViewById(R.id.iv_close);
        tag = findViewById(R.id.tag);
        iv_close.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                dismiss();
            }
        });
        passwordView.setOnPasswordChangedListener(new GridPasswordView.OnPasswordChangedListener() {
            @Override
            public void onTextChanged(String psw) {
                if (psw.length() == 6) {//6位密码自动支付
                    switch (intentType) {
                        case 0:
                            if (isWeiKuan) {
                                blancePayWeikuan(psw,price);
                            } else {
                                blancePay(psw);
                            }
                            break;
                        case 1:
                            mallBlancePay(psw);
                            break;
                        case 2:
                            payDianPuRenZheng(psw);
                            break;
                        case 3:
                            robPopularize(psw);
                            break;
                        case 4:
                            payUserVip(psw);
                            break;
                        case 5:
                            payShopVip(psw);
                            break;
                        case 6:
                            payJiFen(psw);
                            break;
                        case 7:
                            payByJiFen(psw);
                            break;
                        case 8:
                            payByHongBao(psw);
                            break;
                    }

                }
            }

            @Override
            public void onInputFinish(String psw) {

            }
        });


        if (isJiFen) {
            tag.setText("积分支付");
            tv_price.setText(price + "积分");
        } else {
            tag.setText("余额支付");
            tv_price.setText("￥" + price);
        }
    }

    public void isShow() {
        if (this.isShowing()) {
            dismiss();
        } else {
            show();
        }
    }

    //兑换红包积分支付
    private void payByHongBao(String pwd) {
        LoadDialog.showDialog(context);
        ApiManager.getJiFenHongBaoPay(order_id, pwd, new OnRequestFinish<BaseBean>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean data) {
                NToast.show(data.getMessage());
                dismiss();
                refreshNum.onRefresh();
                EventBusUtil.sendEvent(new Event(EventCode.PAY_SUCCRSS));
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
            }
        });
    }

    //余额支付积分商城
    private void payJiFen(String pwd) {
        LoadDialog.showDialog(context);
        ApiManager.payJiFenOrederByYue(id, pwd, new OnRequestFinish<BaseBean>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean data) {
                NToast.show(data.getMessage());
                dismiss();
                refreshNum.onRefresh();
                EventBusUtil.sendEvent(new Event(EventCode.PAY_SUCCRSS));
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
            }
        });
    }

    //单积分支付
    private void payByJiFen(String pwd) {
        LoadDialog.showDialog(context);
        ApiManager.payJiFenOrederByJiFen(id, pwd, new OnRequestFinish<BaseBean>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean data) {
                NToast.show(data.getMessage());
                dismiss();
                refreshNum.onRefresh();
                EventBusUtil.sendEvent(new Event(EventCode.PAY_SUCCRSS));
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
            }
        });
    }


    //余额支付 婚庆
    private void blancePay(String pwd) {
        LoadDialog.showDialog(context);
        ApiManager.weddingBlancePay(id, pwd, new OnRequestFinish<BaseBean>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean data) {
                NToast.show(data.getMessage());
                dismiss();
                refreshNum.onRefresh();
                EventBusUtil.sendEvent(new Event(EventCode.PAY_SUCCRSS));
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
            }
        });
    }

    //余额支付 商城
    private void mallBlancePay(String pwd) {
        LoadDialog.showDialog(context);
        ApiManager.mallBlancePay(id, pwd, new OnRequestFinish<BaseBean>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean data) {
                NToast.show(data.getMessage());
                dismiss();
                refreshNum.onRefresh();
                EventBusUtil.sendEvent(new Event(EventCode.PAY_SUCCRSS));
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
            }
        });
    }

    //余额支付 尾款
    private void blancePayWeikuan(String pwd,String price) {
        LoadDialog.showDialog(context);
        ApiManager.payWeiKuanByBlance(order_id, pwd,price, new OnRequestFinish<BaseBean>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean data) {
                NToast.show(data.getMessage());
                dismiss();
                refreshNum.onRefresh();
                EventBusUtil.sendEvent(new Event(EventCode.PAY_SUCCRSS));
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
            }
        });
    }

    //店铺认证支付
    private void payDianPuRenZheng(String pwd) {
        LoadDialog.showDialog(context);
        ApiManager.payDianPuRenZheng(order_id_str, "yue", pwd, new OnRequestFinish<BaseBean<PayBean>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<PayBean> data) {
                NToast.show(data.getMessage());
                dismiss();
                refreshNum.onRefresh();
                EventBusUtil.sendEvent(new Event(EventCode.PAY_SUCCRSS));
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
            }
        });
    }

    //推广助手
    private void robPopularize(String pwd) {
        LoadDialog.showDialog(context);
        ApiManager.robPopularizePay("yue", pwd, new OnRequestFinish<BaseBean<PayBean>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<PayBean> data) {
                NToast.show(data.getMessage());
                dismiss();
                refreshNum.onRefresh();
                EventBusUtil.sendEvent(new Event(EventCode.PAY_SUCCRSS));
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
            }
        });
    }

    //用户VIP
    private void payUserVip(String pwd) {
        LoadDialog.showDialog(context);
        ApiManager.payOpenUserVip(price, "yue", pwd, new OnRequestFinish<BaseBean<PayBean>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<PayBean> data) {
                NToast.show(data.getMessage());
                dismiss();
                refreshNum.onRefresh();
                EventBusUtil.sendEvent(new Event(EventCode.PAY_SUCCRSS));
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
            }
        });
    }

    //商户VIP
    private void payShopVip(String pwd) {
        LoadDialog.showDialog(context);
        ApiManager.payOpenShopVip(price, longtime, "yue", pwd, new OnRequestFinish<BaseBean<PayBean>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<PayBean> data) {
                NToast.show(data.getMessage());
                dismiss();
                refreshNum.onRefresh();
                EventBusUtil.sendEvent(new Event(EventCode.PAY_SUCCRSS));
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
            }
        });
    }
}
