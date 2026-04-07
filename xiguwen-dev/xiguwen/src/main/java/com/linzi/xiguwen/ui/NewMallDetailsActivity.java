package com.linzi.xiguwen.ui;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.ShopUserDetailsBean;
import com.linzi.xiguwen.fragment.multistage.bean.FragmentAndNavigationBean;
import com.linzi.xiguwen.fragment.multistage.bean.HeadTitleFragmentAndListenerBean;
import com.linzi.xiguwen.fragment.multistage.bean.MultistageTandemBean;
import com.linzi.xiguwen.fragment.multistage.fragment.MultistageTandemFragment;
import com.linzi.xiguwen.fragment.shop.BaoJiaFragment;
import com.linzi.xiguwen.fragment.shop.DangQiFragment;
import com.linzi.xiguwen.fragment.shop.DongTaiFragment;
import com.linzi.xiguwen.fragment.shop.HeadFragment;
import com.linzi.xiguwen.fragment.shop.IndexFragment;
import com.linzi.xiguwen.fragment.shop.PingJiaFragment;
import com.linzi.xiguwen.fragment.shop.TitleFragment;
import com.linzi.xiguwen.fragment.shop.ZiLiaoFragment;
import com.linzi.xiguwen.fragment.shop.ZuoPingFragment;
import com.linzi.xiguwen.fragment.shop.model.ShopUserDetailModel;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.GetShareContentUtil;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.LoginHepler;
import com.linzi.xiguwen.utils.LoginHeplerListener;
import com.linzi.xiguwen.utils.LoginUtil;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.StatusBarUtil;

import java.util.ArrayList;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

/**
 * Created by pc on 2018/3/28.
 */

public class NewMallDetailsActivity extends AppCompatActivity implements ShopUserDetailModel, LoginHeplerListener {
    @BindView(R.id.iv_care)
    ImageView ivCare;
    @BindView(R.id.ll_bar)
    LinearLayout llBar;

    private Context mContext;
    private int shop_id;
    private BaseBean<ShopUserDetailsBean> bean;
    private boolean isCare = false;
    private MultistageTandemFragment multistageTandemFragment;
    private int current;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        NToast.log("oncreate",getClass().getCanonicalName());
        //改变为白色背景黑色字体的状态栏
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
            StatusBarUtil.setStatusBarColor(NewMallDetailsActivity.this, R.color.trans);
            StatusBarUtil.setNavigationBarColor(NewMallDetailsActivity.this, R.color.white);
        }
        setContentView(R.layout.new_mall_details_layout);
        ButterKnife.bind(this);
//        //获得状态栏高度
//        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, StatusBarUtil.getStatusBarHeight(NewMallDetailsActivity.this));
//        llBar.setLayoutParams(params);
//        ViewCompat.setAlpha(llBar, 0);
        mContext = this;
        shop_id = getIntent().getIntExtra("shop_id", -1);
        current = getIntent().getIntExtra("current", 0);
        getData();
    }

    private void getData() {
        LoadDialog.showDialog(mContext);
        ApiManager.getUserDetails(shop_id + "", new OnRequestFinish<BaseBean<ShopUserDetailsBean>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();

            }

            @Override
            public void onSuccess(BaseBean<ShopUserDetailsBean> data) {
                bean = data;
                afterBindView();
            }

            @Override
            public void onError(Exception ex) {
                NToast.log(mContext, ex.toString());
            }
        });
    }

    private void afterBindView() {
        if (bean.getData().getUserf() == 1) {
            ivCare.setBackgroundResource(R.mipmap.icon_cared2);
            isCare = true;
        } else {
            ivCare.setBackgroundResource(R.mipmap.icon_care2);
            isCare = false;
        }

        ArrayList<FragmentAndNavigationBean> navigationBeans = new ArrayList<>();
        navigationBeans.add(FragmentAndNavigationBean.create("首页", IndexFragment.create(shop_id)));
        navigationBeans.add(FragmentAndNavigationBean.create("报价", BaoJiaFragment.create(shop_id)));
        navigationBeans.add(FragmentAndNavigationBean.create("作品", ZuoPingFragment.create(shop_id)));
        navigationBeans.add(FragmentAndNavigationBean.create("评价", PingJiaFragment.create(shop_id)));
        navigationBeans.add(FragmentAndNavigationBean.create("动态", DongTaiFragment.create(shop_id)));
        navigationBeans.add(FragmentAndNavigationBean.create("档期", DangQiFragment.create(shop_id)));
        navigationBeans.add(FragmentAndNavigationBean.create("资料", ZiLiaoFragment.create(shop_id)));
        //topbar
        TitleFragment title = (TitleFragment) TitleFragment.create(true, "商家详情");
        title.setRightOnClick(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                GetShareContentUtil.getContent(NewMallDetailsActivity.this, shop_id, 3, -1);
            }
        });

        MultistageTandemBean tandemBean = new MultistageTandemBean().setTitleBean(HeadTitleFragmentAndListenerBean.create(HeadFragment.create(), title, title.getOnHeadOffsetListener())).setNavigationBeans(navigationBeans);
        multistageTandemFragment = MultistageTandemFragment.create(tandemBean);
        getSupportFragmentManager()
                .beginTransaction()
                .add(R.id.frame, multistageTandemFragment, MultistageTandemFragment.class.toString())
                .commit();

        if (current > 0 && multistageTandemFragment != null) {
            new Handler().postDelayed(new Runnable() {
                @Override
                public void run() {
                    multistageTandemFragment.selectTab(current);
                }
            }, 1000);

        }
    }

    @Override
    public ShopUserDetailsBean.UserBean getUserBean() {
        return bean.getData().getUser();
    }

    @Override
    public ShopUserDetailsBean.UserinfoBean getUserinfoBean() {
        return bean.getData().getUserinfo();
    }

    @Override
    public int getUserf() {
        return bean.getData().getUserf();
    }

    @Override
    public MultistageTandemFragment getBean() {
        return multistageTandemFragment;
    }

    @OnClick({R.id.iv_chat, R.id.iv_call_phone, R.id.iv_care, R.id.ll_yuyue})
    public void onViewClicked(View view) {
        switch (view.getId()) {
            case R.id.iv_chat:
                LoginHepler.LoginHepler(mContext, 666, true, this);
                break;
            case R.id.iv_call_phone:
                if (!LoginUtil.isLogin()) {
                    LoginActivity.startAction(mContext);
                    break;
                }
                callUser();
                break;
            case R.id.iv_care:
                if (!LoginUtil.isLogin()) {
                    LoginActivity.startAction(mContext);
                    return;
                }
                if (isCare) {
                    cancelCare();
                } else {
                    careShop();
                }
                break;
            case R.id.ll_yuyue:
                if (!LoginUtil.isLogin()) {
                    LoginActivity.startAction(mContext);
                    return;
                }
                Intent intent = new Intent(mContext, GetSuggestActivity.class);//免费获取方案
                startActivity(intent);
                break;
        }
    }

    //关注商家
    private void careShop() {
        LoadDialog.showDialog(mContext);
        ApiManager.addSJCare(shop_id + "", new OnRequestFinish<BaseBean>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean data) {
                if (data.getCode() == 0) {
                    isCare = true;
                    ivCare.setBackgroundResource(R.mipmap.icon_cared2);
                    NToast.show(data.getMessage());
                }
            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }

    //取消关注商家
    private void cancelCare() {
        LoadDialog.showDialog(mContext);
        ApiManager.delSJCare(shop_id + "", new OnRequestFinish<BaseBean>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean data) {
                if (data.getCode() == 0) {
                    isCare = false;
                    ivCare.setBackgroundResource(R.mipmap.icon_care2);
                    NToast.show(data.getMessage());
                }
            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }

    //联系商家
    private void callUser() {
        if (bean.getData().getUser().getMobile() != null) {
            Intent intent = new Intent(Intent.ACTION_DIAL, Uri.parse("tel:" + bean.getData().getUser().getMobile()));
            intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
            startActivity(intent);
        } else {
            NToast.show("抱歉，暂时没有该商家的联系方式！");
        }
    }

    @Override
    public void loginOpinion(int code) {
        switch (code) {
            case 666:
//                NimUIKit.startP2PSession(this, "user" + bean.getData().getUser().getUserid());
                break;
        }
    }
}
