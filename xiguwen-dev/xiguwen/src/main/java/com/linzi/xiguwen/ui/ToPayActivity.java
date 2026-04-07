package com.linzi.xiguwen.ui;

import android.annotation.SuppressLint;
import android.content.Context;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.text.TextUtils;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.alipay.sdk.app.PayTask;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.PayBean;
import com.linzi.xiguwen.bean.PayResult;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;
import com.linzi.xiguwen.view.dialog.InputPassWordDialog;
import com.tencent.mm.opensdk.modelpay.PayReq;
import com.tencent.mm.opensdk.openapi.IWXAPI;
import com.tencent.mm.opensdk.openapi.WXAPIFactory;

import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;

import java.util.Map;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class ToPayActivity extends BaseActivity {

    @BindView(R.id.iv_choose_alipay)
    ImageView ivChooseAlipay;
    LinearLayout llPayAlipay;
    @BindView(R.id.iv_choose_wechat)
    ImageView ivChooseWechat;
    @BindView(R.id.ll_pay_wechat)
    LinearLayout llPayWechat;
    @BindView(R.id.iv_choose_union)
    ImageView ivChooseUnion;
    @BindView(R.id.ll_pay_union)
    LinearLayout llPayUnion;
    @BindView(R.id.iv_choose_yue)
    ImageView ivChooseYue;
    @BindView(R.id.ll_pay_yue)
    LinearLayout llPayYue;
    @BindView(R.id.tv_price)
    TextView tvPrice;
    @BindView(R.id.ll_topay)
    LinearLayout llTopay;

    private String id;//订单编号
    private int order_id;//订单id
    private String order_id_str;//订单id
    private String price;
    private int intentType;//0是婚庆 1是商城 2店铺认证 3推广助手 4用户开通VIP 5商家开通VIP 6积分商城 7充值
    private Context context;

    private boolean isWeiKuan;//标记是否为尾款支付

    private int payWay;//1 支付宝 2微信 3余额

    private String key;

    private InputPassWordDialog dialog;

    private String longtime;

    private static final String PAY_API_TAG = "PAY_API";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_to_pay);
        EventBusUtil.register(this);
        ButterKnife.bind(this);
        context = this;
        id = getIntent().getStringExtra("id");
        price = getIntent().getStringExtra("price");
        intentType = getIntent().getIntExtra("intentType", -1);
        order_id = getIntent().getIntExtra("order_id", -1);
        order_id_str = getIntent().getStringExtra("order_id_str");
        isWeiKuan = getIntent().getBooleanExtra("isWeiKuan", false);
        longtime = getIntent().getStringExtra("longtime");
        tvPrice.setText("￥" + price);
        if (intentType == 7 ){
            llPayYue.setVisibility(View.GONE);
        }
    }

    @Override
    protected void initData() {
        setTitle("收银台");
        setBack();

    }

    @OnClick({R.id.ll_pay_alipay, R.id.ll_pay_wechat, R.id.ll_pay_union, R.id.ll_pay_yue, R.id.ll_topay})
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.ll_pay_alipay:
                ivChooseAlipay.setVisibility(View.VISIBLE);
                ivChooseUnion.setVisibility(View.GONE);
                ivChooseWechat.setVisibility(View.GONE);
                ivChooseYue.setVisibility(View.GONE);
                payWay = 1;

                break;
            case R.id.ll_pay_wechat:
                ivChooseAlipay.setVisibility(View.GONE);
                ivChooseUnion.setVisibility(View.GONE);
                ivChooseWechat.setVisibility(View.VISIBLE);
                ivChooseYue.setVisibility(View.GONE);
                payWay = 2;

                break;
            case R.id.ll_pay_union:
                ivChooseAlipay.setVisibility(View.GONE);
                ivChooseUnion.setVisibility(View.VISIBLE);
                ivChooseWechat.setVisibility(View.GONE);
                ivChooseYue.setVisibility(View.GONE);
                break;
            case R.id.ll_pay_yue:
                ivChooseAlipay.setVisibility(View.GONE);
                ivChooseUnion.setVisibility(View.GONE);
                ivChooseWechat.setVisibility(View.GONE);
                ivChooseYue.setVisibility(View.VISIBLE);
                payWay = 3;
                break;
            case R.id.ll_topay:
                switch (payWay) {
                    case 1:
                        switch (intentType) {
                            case 0:
                                if (isWeiKuan) {
                                    payWeiKuanThr(id, "alipay", price);
                                } else {
                                    payWedding("alipay");
                                }
                                break;
                            case 1:
                                payMall("alipay");
                                break;
                            case 2:
                                payDianPuRenZheng("alipaya");
                                break;
                            case 3:
                                robPopularize("alipay");
                                break;
                            case 4:
                                payUserVip("alipay");
                                break;
                            case 5:
                                payShopVip("alipay");
                                break;
                            case 6:
                                payJiFenmall("alipay");
                                break;
                            case 7:
                                payCharge("alipay");
                                break;
                        }
                        break;
                    case 2:
                        switch (intentType) {
                            case 0:
                                if (isWeiKuan) {
                                    payWeiKuanThr(id, "wxpay", price);
                                } else {
                                    payWedding("wxpay");
                                }
                                break;
                            case 1:
                                payMall("wxpay");
                                break;
                            case 2:
                                payDianPuRenZheng("wxpay");
                                break;
                            case 3:
                                robPopularize("wxpay");
                                break;
                            case 4:
                                payUserVip("wxpay");
                                break;
                            case 5:
                                payShopVip("wxpay");
                                break;
                            case 6:
                                payJiFenmall("wxpay");
                                break;
                            case 7:
                                payCharge("wxpay");
                                break;
                        }
                        break;
                    case 3:
                        if (dialog == null) {
                            dialog = createDialog(isWeiKuan);
                            switch (intentType) {
                                case 0:
                                    if (isWeiKuan) {
                                        dialog.setOrder_id(order_id);
                                    } else {
                                        dialog.setId(id);
                                    }
                                    break;
                                case 1:
                                    dialog.setId(id);
                                    break;
                                case 2:
                                    dialog.setOrder_id_str(order_id_str);
                                    break;
                                case 3:

                                    break;
                                case 4:

                                    break;
                                case 5:
                                    dialog.setLongtime(longtime);
                                    break;
                                case 6:
                                    dialog.setId(id);
                                    break;
                            }

                            dialog.setPrice(price);
                        } else {
                            dialog.clearInput();
                        }
                        dialog.isShow();
                        break;
                }
                break;
        }
    }

    private void logPayApiRequest(String apiName, String type, String params) {
        NToast.log(PAY_API_TAG, "request api=" + apiName + ", type=" + type + ", params=" + params);
    }

    private void logPayApiSuccess(String apiName, BaseBean<PayBean> data) {
        if (data == null) {
            NToast.log(PAY_API_TAG, "success api=" + apiName + ", data=null");
            return;
        }
        PayBean payBean = data.getData();
        String prepayId = payBean == null ? "null" : payBean.getPrepayid();
        NToast.log(PAY_API_TAG, "success api=" + apiName + ", code=" + data.getCode() + ", msg=" + data.getMessage() + ", prepayId=" + prepayId);
    }

    private void logPayApiError(String apiName, Exception exception) {
        String message = exception == null ? "null" : exception.getMessage();
        NToast.log(PAY_API_TAG, "error api=" + apiName + ", msg=" + message);
    }

    //积分商城支付
    private void payJiFenmall(final String type) {
        LoadDialog.showDialog(this);
        logPayApiRequest("payJiFenOreder", type, "id=" + id);
        ApiManager.payJiFenOreder(id, type, new OnRequestFinish<BaseBean<PayBean>>() {
            @Override
            public void onFinished() {
                NToast.log(PAY_API_TAG, "finished api=payJiFenOreder");
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<PayBean> data) {
                logPayApiSuccess("payJiFenOreder", data);
                evokeThrPay(type, data);
            }

            @Override
            public void onError(Exception ex) {
                logPayApiError("payJiFenOreder", ex);
            }
        });
    }

    //商户VIP
    private void payShopVip(final String type) {
        LoadDialog.showDialog(this);
        logPayApiRequest("payOpenShopVip", type, "price=" + price + ", longtime=" + longtime);
        ApiManager.payOpenShopVip(price, longtime, type, null, new OnRequestFinish<BaseBean<PayBean>>() {
            @Override
            public void onFinished() {
                NToast.log(PAY_API_TAG, "finished api=payOpenShopVip");
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<PayBean> data) {
                logPayApiSuccess("payOpenShopVip", data);
                evokeThrPay(type, data);
            }

            @Override
            public void onError(Exception ex) {
                logPayApiError("payOpenShopVip", ex);
            }
        });
    }

    //用户VIP
    private void payUserVip(final String type) {
        LoadDialog.showDialog(this);
        logPayApiRequest("payOpenUserVip", type, "price=" + price);
        ApiManager.payOpenUserVip(price, type, null, new OnRequestFinish<BaseBean<PayBean>>() {
            @Override
            public void onFinished() {
                NToast.log(PAY_API_TAG, "finished api=payOpenUserVip");
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<PayBean> data) {
                logPayApiSuccess("payOpenUserVip", data);
                evokeThrPay(type, data);
            }

            @Override
            public void onError(Exception ex) {
                logPayApiError("payOpenUserVip", ex);
            }
        });
    }


    //推广助手
    private void robPopularize(final String type) {
        LoadDialog.showDialog(this);
        logPayApiRequest("robPopularizePay", type, "");
        ApiManager.robPopularizePay(type, null, new OnRequestFinish<BaseBean<PayBean>>() {
            @Override
            public void onFinished() {
                NToast.log(PAY_API_TAG, "finished api=robPopularizePay");
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<PayBean> data) {
                logPayApiSuccess("robPopularizePay", data);
                evokeThrPay(type, data);
            }

            @Override
            public void onError(Exception ex) {
                logPayApiError("robPopularizePay", ex);
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
            }
        });
    }

    //店铺认证支付
    private void payDianPuRenZheng(final String type) {
        LoadDialog.showDialog(context);
        logPayApiRequest("payDianPuRenZheng", type, "order_id_str=" + order_id_str);
        ApiManager.payDianPuRenZheng(order_id_str, type, null, new OnRequestFinish<BaseBean<PayBean>>() {
            @Override
            public void onFinished() {
                NToast.log(PAY_API_TAG, "finished api=payDianPuRenZheng");
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<PayBean> data) {
                logPayApiSuccess("payDianPuRenZheng", data);
                evokeThrPay(type, data);
            }

            @Override
            public void onError(Exception ex) {
                logPayApiError("payDianPuRenZheng", ex);
            }
        });
    }

    //婚庆订单请求三方支付
    private void payWedding(final String type) {
        LoadDialog.showDialog(context);
        logPayApiRequest("payWeddingOreder", type, "id=" + id + ", isWeiKuan=" + isWeiKuan);
        ApiManager.payWeddingOreder(id, type, new OnRequestFinish<BaseBean<PayBean>>() {
            @Override
            public void onFinished() {
                NToast.log(PAY_API_TAG, "finished api=payWeddingOreder");
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<PayBean> data) {
                logPayApiSuccess("payWeddingOreder", data);
                evokeThrPay(type, data);
            }

            @Override
            public void onError(Exception ex) {
                logPayApiError("payWeddingOreder", ex);
            }
        });
    }

    //商城订单请求三方支付
    private void payMall(final String type) {
        LoadDialog.showDialog(context);
        logPayApiRequest("payMallOreder", type, "id=" + id);
        ApiManager.payMallOreder(id, type, new OnRequestFinish<BaseBean<PayBean>>() {
            @Override
            public void onFinished() {
                NToast.log(PAY_API_TAG, "finished api=payMallOreder");
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<PayBean> data) {
                logPayApiSuccess("payMallOreder", data);
                evokeThrPay(type, data);
            }

            @Override
            public void onError(Exception ex) {
                logPayApiError("payMallOreder", ex);
            }
        });
    }

    //充值
    private void payCharge(final String type) {
        LoadDialog.showDialog(context);
        String beizhu = getIntent().getStringExtra("beizhu");
        logPayApiRequest("charge", type, "price=" + price + ", beizhu=" + beizhu);
        ApiManager.charge(price,beizhu ,type, new OnRequestFinish<BaseBean<PayBean>>() {
            @Override
            public void onFinished() {
                NToast.log(PAY_API_TAG, "finished api=charge");
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<PayBean> data) {
                logPayApiSuccess("charge", data);
                evokeThrPay(type, data);
            }

            @Override
            public void onError(Exception ex) {
                logPayApiError("charge", ex);
            }
        });
    }

    //请求支付尾款 三方
    private void payWeiKuanThr(String pid, final String type, String price) {
        LoadDialog.showDialog(context);
        logPayApiRequest("payWeiKuan", type, "pid=" + pid + ", price=" + price);
        ApiManager.payWeiKuan(pid, type, price, new OnRequestFinish<BaseBean<PayBean>>() {
            @Override
            public void onFinished() {
                NToast.log(PAY_API_TAG, "finished api=payWeiKuan");
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<PayBean> data) {
                logPayApiSuccess("payWeiKuan", data);
                evokeThrPay(type, data);
            }

            @Override
            public void onError(Exception ex) {
                logPayApiError("payWeiKuan", ex);
            }
        });
    }

    //唤起三方支付
    private void evokeThrPay(String type, BaseBean<PayBean> data) {
        if (type.equals("alipay")) {
            final String orderInfo = data.getData().getData();   // 订单信息

            Runnable payRunnable = new Runnable() {

                @Override
                public void run() {
                    PayTask alipay = new PayTask(ToPayActivity.this);
                    Map<String, String> result = alipay.payV2(orderInfo, true);

                    Message msg = new Message();
                    msg.what = 1;
                    msg.obj = result;
                    mHandler.sendMessage(msg);
                }
            };
            // 必须异步调用
            Thread payThread = new Thread(payRunnable);
            payThread.start();
        } else if (type.equals("alipaya")) {
            final String orderInfo = data.getData().getData();   // 订单信息

            Runnable payRunnable = new Runnable() {

                @Override
                public void run() {
                    PayTask alipay = new PayTask(ToPayActivity.this);
                    Map<String, String> result = alipay.payV2(orderInfo, true);

                    Message msg = new Message();
                    msg.what = 1;
                    msg.obj = result;
                    mHandler.sendMessage(msg);
                }
            };
            // 必须异步调用
            Thread payThread = new Thread(payRunnable);
            payThread.start();
        } else {
            PayBean payBean = data.getData();
            if (payBean == null) {
                NToast.show("微信支付参数为空，请稍后重试");
                NToast.log("WX_PAY", "payBean is null");
                return;
            }

            IWXAPI msgApi = WXAPIFactory.createWXAPI(context, payBean.getAppid());
            boolean registerResult = msgApi.registerApp(payBean.getAppid());
            NToast.log("WX_PAY", "registerApp result=" + registerResult + ", appId=" + payBean.getAppid());
            if (!msgApi.isWXAppInstalled()) {
                NToast.show("未检测到微信，请先安装微信");
                NToast.log("WX_PAY", "isWXAppInstalled=false");
                return;
            }
            if (msgApi.getWXAppSupportAPI() < com.tencent.mm.opensdk.constants.Build.PAY_SUPPORTED_SDK_INT) {
                NToast.show("当前微信版本过低，请升级后再试");
                NToast.log("WX_PAY", "wx api unsupported, supportApi=" + msgApi.getWXAppSupportAPI());
                return;
            }

            PayReq request = new PayReq();
            request.appId = payBean.getAppid();
            request.partnerId = payBean.getPartnerid();
            request.prepayId = payBean.getPrepayid();
            request.packageValue = TextUtils.isEmpty(payBean.getPackageX()) ? "Sign=WXPay" : payBean.getPackageX();
            request.nonceStr = payBean.getNoncestr();
            request.timeStamp = payBean.getTimestamp();
            request.sign = payBean.getSign();
            if (TextUtils.isEmpty(request.appId)
                    || TextUtils.isEmpty(request.partnerId)
                    || TextUtils.isEmpty(request.prepayId)
                    || TextUtils.isEmpty(request.nonceStr)
                    || TextUtils.isEmpty(request.timeStamp)
                    || TextUtils.isEmpty(request.sign)) {
                NToast.show("微信支付参数异常，请稍后重试");
                NToast.log("WX_PAY", "invalid request params, prepayId=" + request.prepayId + ", sign=" + request.sign);
                return;
            }
            boolean sendResult = msgApi.sendReq(request);
            NToast.log("WX_PAY", "sendReq result=" + sendResult + ", prepayId=" + request.prepayId + ", timeStamp=" + request.timeStamp);
            if (!sendResult) {
                NToast.show("微信拉起失败，请重试或更新微信");
            }
        }

    }

    //初始化余额支付对话框
    private InputPassWordDialog createDialog(boolean isWeiKuan) {
        dialog = new InputPassWordDialog(context, R.style.MyDialog, isWeiKuan, intentType);
        dialog.setRefreshNum(new InputPassWordDialog.RefreshNum() {
            @Override
            public void onRefresh() {
                finish();
                EventBusUtil.sendEvent(new Event(EventCode.PAY_SUCCRSS));
            }
        });
        return dialog;
    }

    //支付宝
    @SuppressLint("HandlerLeak")
    private Handler mHandler = new Handler() {
        @SuppressWarnings("unused")
        public void handleMessage(Message msg) {
            switch (msg.what) {
                case 1: {
                    @SuppressWarnings("unchecked")
                    PayResult payResult = new PayResult((Map<String, String>) msg.obj);
                    /**
                     对于支付结果，请商户依赖服务端的异步通知结果。同步通知结果，仅作为支付结束的通知。
                     */
                    String resultInfo = payResult.getResult();// 同步返回需要验证的信息
                    String resultStatus = payResult.getResultStatus();
                    // 判断resultStatus 为9000则代表支付成功
                    if (TextUtils.equals(resultStatus, "9000")) {
                        // 该笔订单是否真实支付成功，需要依赖服务端的异步通知。
                        NToast.show("支付成功！");
                        EventBusUtil.sendEvent(new Event(EventCode.PAY_SUCCRSS));
                    } else {
                        // 该笔订单真实的支付结果，需要依赖服务端的异步通知。
                        NToast.show("支付失败！");
                    }
                    break;
                }
            }
        }
    };

    @Override
    protected void onDestroy() {
        super.onDestroy();
        EventBusUtil.unregister(this);
        if (mHandler != null) {
            mHandler.removeCallbacksAndMessages(null);
        }
    }

    @Subscribe(threadMode = ThreadMode.MAIN)
    public void receiveEvent(Event entity) {
        if (entity == null)
            return;
        try {
            int code = entity.getCode();
            switch (code) {
                case EventCode.WEIXINPAY:
                    NToast.show("支付成功！");
                    EventBusUtil.sendEvent(new Event(EventCode.PAY_SUCCRSS));
                    finish();
                    break;
            }
        } catch (Exception e) {
        }

    }
}
