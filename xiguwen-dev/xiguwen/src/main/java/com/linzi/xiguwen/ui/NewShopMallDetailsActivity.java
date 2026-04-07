package com.linzi.xiguwen.ui;

import android.content.Context;
import android.os.Build;
import android.os.Bundle;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.ShopMallDetailsBean;
import com.linzi.xiguwen.fragment.multistage.bean.FragmentAndNavigationBean;
import com.linzi.xiguwen.fragment.multistage.bean.HeadTitleFragmentAndListenerBean;
import com.linzi.xiguwen.fragment.multistage.bean.MultistageTandemBean;
import com.linzi.xiguwen.fragment.multistage.fragment.MultistageTandemFragment;
import com.linzi.xiguwen.fragment.shop.TitleFragment;
import com.linzi.xiguwen.fragment.shopmall.AllFragment;
import com.linzi.xiguwen.fragment.shopmall.DongTaiFragment;
import com.linzi.xiguwen.fragment.shopmall.HeadFragment;
import com.linzi.xiguwen.fragment.shopmall.HotFragment;
import com.linzi.xiguwen.fragment.shopmall.NewGoodsFragment;
import com.linzi.xiguwen.fragment.shopmall.PingJiaFragment;
import com.linzi.xiguwen.fragment.shopmall.model.ShopMallDetailModel;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.GetShareContentUtil;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.StatusBarUtil;

import java.util.ArrayList;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by pc on 2018/4/7.
 */

public class NewShopMallDetailsActivity extends AppCompatActivity implements ShopMallDetailModel {
    @BindView(R.id.iv_care)
    ImageView ivCare;
    @BindView(R.id.bottombar)
    LinearLayout bottombar;
    @BindView(R.id.ll_bar)
    LinearLayout llBar;

    private Context mContext;
    private MultistageTandemFragment multistageTandemFragment;
    private int shop_id;//商城商家id
    private int page = 1;
    private int limit = 0;
    private int comprehensive = -1;
    private int salesvolume = -1;
    private String price = "";
    private ShopMallDetailsBean bean;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //改变为白色背景黑色字体的状态栏
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
            StatusBarUtil.setStatusBarColor(NewShopMallDetailsActivity.this, R.color.trans);
            StatusBarUtil.setNavigationBarColor(NewShopMallDetailsActivity.this, R.color.white);
        }
        setContentView(R.layout.new_mall_details_layout);
        ButterKnife.bind(this);
        mContext = this;
        shop_id = getIntent().getIntExtra("shop_id", -1);
        if (shop_id != -1) {
            initView();
            getData();
        } else {
            NToast.show("跳转错误，请重试！");
            finish();
        }
    }

    private void initView() {
        //获得状态栏高度
//        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, StatusBarUtil.getStatusBarHeight(NewShopMallDetailsActivity.this));
//        llBar.setLayoutParams(params);
//        llBar.setBackgroundColor(NewShopMallDetailsActivity.this.getResources().getColor(R.color.white));
        //ViewCompat.setAlpha(llBar, 0);

        bottombar.setVisibility(View.GONE);
    }

    private void getData() {
        LoadDialog.showDialog(mContext);
        ApiManager.getMallShopDetails(shop_id, page, limit, salesvolume, price, comprehensive, new OnRequestFinish<BaseBean<ShopMallDetailsBean>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<ShopMallDetailsBean> data) {
                bean = data.getData();
                afterView();
            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }

    private void afterView() {
        ArrayList<FragmentAndNavigationBean> navigationBeans = new ArrayList<>();
        navigationBeans.add(FragmentAndNavigationBean.create("新品", NewGoodsFragment.create(shop_id)));
        navigationBeans.add(FragmentAndNavigationBean.create("热门", HotFragment.create(shop_id)));
        navigationBeans.add(FragmentAndNavigationBean.create("全部", AllFragment.create(shop_id)));
        navigationBeans.add(FragmentAndNavigationBean.create("评价", PingJiaFragment.create(shop_id)));
        navigationBeans.add(FragmentAndNavigationBean.create("动态", DongTaiFragment.create(shop_id)));
        //topbar
        TitleFragment title = (TitleFragment) TitleFragment.create(true, "商家主页");
        title.setRightOnClick(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                GetShareContentUtil.getContent(NewShopMallDetailsActivity.this, shop_id, 7, -1);
            }
        });
        MultistageTandemBean tandemBean = new MultistageTandemBean()
                .setTitleBean(HeadTitleFragmentAndListenerBean.create(HeadFragment.create(), title, title.getOnHeadOffsetListener())).setNavigationBeans(navigationBeans);
        multistageTandemFragment = MultistageTandemFragment.create(tandemBean);
        getSupportFragmentManager()
                .beginTransaction()
                .add(R.id.frame, multistageTandemFragment, MultistageTandemFragment.class.toString())
                .commit();
    }

    @Override
    public ShopMallDetailsBean.UserBean getUserBean() {
        return bean.getUser();
    }

}
