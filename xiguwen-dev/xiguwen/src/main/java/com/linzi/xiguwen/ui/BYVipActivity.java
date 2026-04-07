package com.linzi.xiguwen.ui;

import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import androidx.appcompat.app.AppCompatActivity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.ShopVipBean;
import com.linzi.xiguwen.bean.UserInfoBean;
import com.linzi.xiguwen.bean.UserVipBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.StatusBarUtil;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;
import com.linzi.xiguwen.view.OpenShopVipPopWindow;

import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class BYVipActivity extends AppCompatActivity {

    @BindView(R.id.ll_bar)
    LinearLayout llBar;
    @BindView(R.id.iv_back)
    ImageView ivBack;
    @BindView(R.id.tv_title)
    TextView tvTitle;
    @BindView(R.id.iv_head)
    ImageView ivHead;
    @BindView(R.id.tv_user_name)
    TextView tvUserName;
    @BindView(R.id.ll_vip_by)
    LinearLayout llVipBy;
    @BindView(R.id.ll_vip_user)
    LinearLayout llVipUser;
    @BindView(R.id.bt_kaitong)
    Button btKaitong;

    private Context mContext;
    private int type = 0;

    private String price;

    private OpenShopVipPopWindow openShopVipPopWindow;
    private ShopVipBean shopVipBean;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //改变为白色背景黑色字体的状态栏
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
            StatusBarUtil.setStatusBarColor(BYVipActivity.this, R.color.trans);
        }
        setContentView(R.layout.activity_byvip);
        ButterKnife.bind(this);
        EventBusUtil.register(this);
        mContext = this;
        initVIews();
        getData();
    }

    private void initVIews() {
        //获得状态栏高度
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, StatusBarUtil.getStatusBarHeight(BYVipActivity.this));
        llBar.setLayoutParams(params);

        type = getIntent().getIntExtra("type", 0);
        if (type == 0) {
            tvTitle.setText("商家VIP");
            llVipBy.setVisibility(View.VISIBLE);
            getShopVipInfo();
        } else {
            tvTitle.setText("用户VIP");
            llVipUser.setVisibility(View.VISIBLE);
            getUserVipInfo();
        }
    }

    @OnClick({R.id.iv_back, R.id.bt_kaitong})
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.iv_back:
                finish();
                break;
            case R.id.bt_kaitong:

                if (type == 0) {
                    openShopVipPopWindow = new OpenShopVipPopWindow(mContext, shopVipBean.getVipsmoney12(), shopVipBean.getVipsmoney24(), shopVipBean.getVipsmoney36());
                    openShopVipPopWindow.setShowWithView(btKaitong);
                } else {
                    Intent intent = new Intent(mContext, ToPayActivity.class);
                    intent.putExtra("price", price);
                    intent.putExtra("intentType", 4);
                    startActivity(intent);
                }

                break;
        }
    }

    private void getData() {
        ApiManager.getUserInfo(new OnRequestFinish<BaseBean<UserInfoBean>>() {
            @Override
            public void onFinished() {
            }

            @Override
            public void onSuccess(BaseBean<UserInfoBean> data) {
                if (data.getData() != null) {
                    refreshView(data.getData());
                } else
                    NToast.show(data.getMessage());
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
            }
        });
    }

    private void refreshView(UserInfoBean bean) {
        GlideLoad.GlideLoadCircle(bean.getHead(), ivHead);
        tvUserName.setText(bean.getNickname());
        if (type == 0) {
            if (bean.getIsshopvip() == 1) {
                btKaitong.setText("已开通会员");
                btKaitong.setEnabled(false);
            } else {
                btKaitong.setText("立即开通会员");
                btKaitong.setEnabled(true);
            }
        } else {
            if (bean.getIsuserivip() == 1) {
                btKaitong.setText("已开通会员");
                btKaitong.setEnabled(false);
            } else {
                btKaitong.setText("立即开通会员");
                btKaitong.setEnabled(true);
            }
        }
    }

    //获取用户开通vip信息
    private void getUserVipInfo() {
        ApiManager.openUserVip(new OnRequestFinish<BaseBean<UserVipBean>>() {
            @Override
            public void onFinished() {

            }

            @Override
            public void onSuccess(BaseBean<UserVipBean> data) {
                price = data.getData().getVipmoney();
            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }

    //获取商家开通vip信息
    private void getShopVipInfo() {
        ApiManager.openShopVip(new OnRequestFinish<BaseBean<ShopVipBean>>() {
            @Override
            public void onFinished() {

            }

            @Override
            public void onSuccess(BaseBean<ShopVipBean> data) {
                shopVipBean = data.getData();
            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
         
        EventBusUtil.unregister(this);
    }

    @Subscribe(threadMode = ThreadMode.MAIN)
    public void receiveEvent(Event event) {
        if (event == null)
            return;
        try {
            int code = event.getCode();
            switch (code) {
                case EventCode.PAY_SUCCRSS:
                    initVIews();
                    break;
            }
        } catch (Exception e) {
        }

    }
}
