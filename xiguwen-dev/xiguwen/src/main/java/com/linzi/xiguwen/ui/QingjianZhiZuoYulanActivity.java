package com.linzi.xiguwen.ui;

import android.app.Activity;
import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import androidx.appcompat.app.AppCompatActivity;

import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.InvitationsTemplateBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.StatusBarUtil;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;

import java.text.SimpleDateFormat;
import java.util.Date;

import butterknife.BindView;

/**
 * 请柬制作预览
 */
public class QingjianZhiZuoYulanActivity extends BaseWebViewActivity {

    @BindView(R.id.ll_bar)
    LinearLayout llBar;
    @BindView(R.id.iv_back)
    ImageView ivBack;
    @BindView(R.id.bt_create)
    Button btCreate;

    public static final int REQUEST_OPEN_MAKE = 1001;// 打开制作页面

    private InvitationsTemplateBean.DataBean mTemp; //模板
    private String mUrl;

    public static void startActivityForResult(Activity context, InvitationsTemplateBean.DataBean temp, int resultCode) {
        Intent intent = new Intent(context, QingjianZhiZuoYulanActivity.class);
        intent.putExtra("temp", temp);
        context.startActivityForResult(intent, resultCode);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //改变为白色背景黑色字体的状态栏
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
            StatusBarUtil.setStatusBarColor(QingjianZhiZuoYulanActivity.this, R.color.trans);
            StatusBarUtil.setNavigationBarColor(QingjianZhiZuoYulanActivity.this, R.color.white);
        }
        mTemp = (InvitationsTemplateBean.DataBean) getIntent().getSerializableExtra("temp");
        initView();
//        getUrl();
        loadUrl(mTemp.getUrl());
    }

    @Override
    public int getContentView() {
        return R.layout.activity_qingjian_yulan;
    }

    private void initView() {
        //获得状态栏高度
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, StatusBarUtil.getStatusBarHeight(QingjianZhiZuoYulanActivity.this));
        llBar.setLayoutParams(params);
        ivBack.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                finish();
            }
        });
        btCreate.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                // ZhizuoQingjianActivity.startActivityForResult(QingjianZhiZuoYulanActivity.this, mTemp, REQUEST_OPEN_MAKE);
                QingjianEditActivity.ShareBean shareBean = new QingjianEditActivity.ShareBean();
                shareBean.setUrl(mTemp.getUrl());
                shareBean.setInvitationsId(mTemp.getId());
                shareBean.setCover(mTemp.getCover());

//                shareBean.setGirlName(data.getXinniang());
//                shareBean.setBoyName(data.getXinlang());

                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy年MM月dd日");// HH:mm:ss
//获取当前时间
                Date date = new Date(System.currentTimeMillis());
                shareBean.setTime(simpleDateFormat.format(date));
//                shareBean.setHotle(data.getHotel());
//                shareBean.setAddress(data.getHunlidizhi());
                Intent intent = new Intent(QingjianZhiZuoYulanActivity.this, NewCreateElectronicinvitationActivity.class);
                intent.putExtra("intentType", 1);
                intent.putExtra("data", shareBean);
                startActivity(intent);
                finish();
                EventBusUtil.sendEvent(new Event(EventCode.REFRESH_QINGJIAN_LIST));
            }
        });
    }


    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        switch (requestCode) {
            case REQUEST_OPEN_MAKE:
                if (resultCode == RESULT_OK) {
                    setResult(RESULT_OK);
                    finish();
                }
                break;
        }
    }

    private void getUrl() {
        LoadDialog.showDialog(this);
        ApiManager.getMakeInvitationsShow(mTemp.getId(), new OnRequestFinish<BaseBean<String>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<String> data) {
                mUrl = data.getData();
                loadUrl(mUrl);
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
            }
        });
    }
}
