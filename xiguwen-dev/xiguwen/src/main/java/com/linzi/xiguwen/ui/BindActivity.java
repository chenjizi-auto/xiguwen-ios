package com.linzi.xiguwen.ui;

import android.content.Intent;
import android.os.Bundle;
import android.text.SpannableString;
import android.view.View;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.net.OnRequestSubscribe;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.AppUtil;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.SPUtil;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;
import com.linzi.xiguwen.utils.yixin.LogoutHelper;
import com.linzi.xiguwen.utils.yixin.preference.Preferences;
import com.linzi.xiguwen.widget.AskDialog;
import com.umeng.socialize.UMAuthListener;
import com.umeng.socialize.UMShareAPI;
import com.umeng.socialize.bean.SHARE_MEDIA;

import org.xutils.common.Callback;

import java.util.Map;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

/**
 * Created by devin on 2018/4/18 11:27
 * Description
 */

public class BindActivity extends BaseActivity {
    @BindView(R.id.bind_phone)
    TextView bindPhone;
    @BindView(R.id.bind_phone_type)
    TextView bindPhoneType;
    @BindView(R.id.bind_phone_item)
    RelativeLayout bindPhoneItem;
    @BindView(R.id.bind_wechart)
    TextView bindWechart;
    @BindView(R.id.bind_wechart_type)
    TextView bindWechartType;
    @BindView(R.id.bind_wechart_item)
    RelativeLayout bindWechartItem;
    UMShareAPI mShareAPI;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_bind);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        setTitle("设置");
        setBack();
        if (AppUtil.isEmpty(Preferences.getString(Preferences.WACHAT_OPENID))) {
            bindWechartType.setText("未绑定");
        } else {
            bindWechartType.setText("已绑定");
        }
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        UMShareAPI.get(this).onActivityResult(requestCode, resultCode, data);

    }

    @OnClick({R.id.bind_phone_item, R.id.bind_wechart_item,R.id.account_cancel_item})
    public void onViewClicked(View view) {
        switch (view.getId()) {
            case R.id.bind_phone_item:
                Intent intent2 = new Intent(mContext, BindPhoneActivity.class);
                startActivity(intent2);
                break;
            case R.id.bind_wechart_item:
                if (mShareAPI == null) {
                    mShareAPI = UMShareAPI.get(this);
                }
                mShareAPI.getPlatformInfo(this, SHARE_MEDIA.WEIXIN, umAuthListener);
                break;
            case R.id.account_cancel_item:
                showCancelDialog();
                break;
        }
    }

    private void showCancelDialog() {
        final AskDialog  askDialog = new AskDialog(this);

        askDialog.setSubmitListener("取消", "已清楚，确定注销", new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                requestUserCancel();
                askDialog.dismiss();
            }
        }, new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                askDialog.dismiss();

            }
        });
        String tilte = "注销喜顾问账号";
        String builder = "账号注销后不可恢复，请您谨慎操作。注销成功后，您将无法登录或使用原账号，账号内的信息和权益将无法找回。";
        SpannableString sr = new SpannableString(builder);
        askDialog.setMessage(tilte);
        askDialog.setContent(sr);
        askDialog.show();
    }

    private void requestUserCancel() {
        int userid = (int) SPUtil.get("userid", SPUtil.Type.INT);
        ApiManager.userCancel(""+userid, "2", new Callback.CommonCallback<String>() {
            @Override
            public void onSuccess(String result) {
                com.linzi.xiguwen.utils.LogUtil.e("requestUserCancel","requestUserCancel "+result);
                NToast.show("账号注销成功！");
                Intent intent4 = new Intent(mContext, LoginActivity.class);
                SPUtil.clear();
                LogoutHelper.logout();
                startActivity(intent4);
                EventBusUtil.sendEvent(new Event(EventCode.FINISH, null));
                finish();
            }

            @Override
            public void onError(Throwable ex, boolean isOnCallback) {
                com.linzi.xiguwen.utils.LogUtil.e("requestUserCancel","requestUserCancel "+isOnCallback);
                NToast.show("账号注销失败！");
            }

            @Override
            public void onCancelled(CancelledException cex) {

            }

            @Override
            public void onFinished() {

            }
        });
    }

    private String wachat_openid;

    private void httpBind(final String openid) {
        ApiManager.bindOther(openid, "3", new OnRequestSubscribe<BaseBean>() {
            @Override
            public void onSuccess(BaseBean data) {
                LoadDialog.CancelDialog();
                Preferences.saveString(Preferences.WACHAT_OPENID, openid);
                bindWechartType.setText("已绑定");
                NToast.show(data.getMessage());
            }

            @Override
            public void onError(Exception ex) {
                LoadDialog.CancelDialog();
                NToast.show(ex.getMessage());
            }
        });
    }

    UMAuthListener umAuthListener = new UMAuthListener() {
        @Override
        public void onStart(SHARE_MEDIA share_media) {
            LoadDialog.showDialog(mContext);
        }

        @Override
        public void onComplete(SHARE_MEDIA share_media, int i, Map<String, String> map) {
            wachat_openid = map.get("uid");
            httpBind(wachat_openid);

        }

        @Override
        public void onError(SHARE_MEDIA share_media, int i, Throwable throwable) {
//            LoadDialog.CancelDialog();
            if (throwable != null)
                NToast.show(throwable.getMessage());
            LoadDialog.CancelDialog();
        }

        @Override
        public void onCancel(SHARE_MEDIA share_media, int i) {
//            LoadDialog.CancelDialog();
//            NToast.show("请输入密码");
            LoadDialog.CancelDialog();
        }
    };
}
