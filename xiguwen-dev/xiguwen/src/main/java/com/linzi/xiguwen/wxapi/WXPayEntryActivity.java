package com.linzi.xiguwen.wxapi;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Intent;
import android.os.Bundle;
import android.view.Gravity;
import android.view.Window;
import android.view.WindowManager;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;
import com.tencent.mm.opensdk.constants.ConstantsAPI;
import com.tencent.mm.opensdk.modelbase.BaseReq;
import com.tencent.mm.opensdk.modelbase.BaseResp;
import com.tencent.mm.opensdk.openapi.IWXAPI;
import com.tencent.mm.opensdk.openapi.IWXAPIEventHandler;
import com.tencent.mm.opensdk.openapi.WXAPIFactory;

public class WXPayEntryActivity extends Activity implements IWXAPIEventHandler {

    private static final String TAG = "MicroMsg.SDKSample.WXPayEntryActivity";

    private IWXAPI api;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.pay_result);
        api = WXAPIFactory.createWXAPI(this, "wx9d4329a0f1007c7c");
        api.registerApp("wx9d4329a0f1007c7c");
        boolean handleResult = api.handleIntent(getIntent(), this);
        NToast.log("WX_PAY", "WXPayEntryActivity onCreate handleIntent=" + handleResult);

//        Window window = getWindow();
//        window.setBackgroundDrawableResource(android.R.color.transparent);
//
//        WindowManager.LayoutParams lp = window.getAttributes();
//        lp.gravity = Gravity.CENTER;
//        window.setAttributes(lp);
    }

    @Override
    protected void onNewIntent(Intent intent) {
        super.onNewIntent(intent);
        setIntent(intent);
        boolean handleResult = api.handleIntent(intent, this);
        NToast.log("WX_PAY", "WXPayEntryActivity onNewIntent handleIntent=" + handleResult);
    }

    @Override
    public void onReq(BaseReq req) {
    }

    @Override
    public void onResp(BaseResp resp) {
        com.linzi.xiguwen.utils.LogUtil.d("APPTAG", "onPayFinish, errCode = " + resp.errCode + ", errStr=" + resp.errStr);
        NToast.log("WX_PAY", "onResp type=" + resp.getType() + ", errCode=" + resp.errCode + ", errStr=" + resp.errStr);
        if (resp.getType() == ConstantsAPI.COMMAND_PAY_BY_WX) {
//            AlertDialog.Builder builder = new AlertDialog.Builder(this);
//            builder.setTitle("结果");
//            builder.setMessage(getString(R.string.pay_result_callback_msg, String.valueOf(resp.errCode)));
//            builder.show();
            if (resp.errCode == 0) {
                EventBusUtil.sendEvent(new Event(EventCode.WEIXINPAY));
            } else if (resp.errCode == -2) {
                NToast.show("已取消微信支付");
            } else {
                NToast.show("微信支付失败，错误码：" + resp.errCode);
            }
            finish();
        } else {
            finish();
        }
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
    }
}
