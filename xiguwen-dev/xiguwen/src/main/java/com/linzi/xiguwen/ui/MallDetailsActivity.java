package com.linzi.xiguwen.ui;

import android.content.Context;
import android.content.Intent;
import android.graphics.Color;
import android.net.Uri;
import android.os.Build;
import android.os.Bundle;
import androidx.fragment.app.Fragment;
import androidx.core.view.ViewCompat;
import androidx.viewpager.widget.ViewPager;
import androidx.appcompat.app.AppCompatActivity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.PagerAdapter;
import com.linzi.xiguwen.bean.ShopUserDetailsBean;
import com.linzi.xiguwen.component.magicindicator.MagicIndicator;
import com.linzi.xiguwen.component.magicindicator.ViewPagerHelper;
import com.linzi.xiguwen.component.magicindicator.buildins.commonnavigator.CommonNavigator;
import com.linzi.xiguwen.component.magicindicator.buildins.commonnavigator.abs.CommonNavigatorAdapter;
import com.linzi.xiguwen.component.magicindicator.buildins.commonnavigator.abs.IPagerIndicator;
import com.linzi.xiguwen.component.magicindicator.buildins.commonnavigator.abs.IPagerTitleView;
import com.linzi.xiguwen.component.magicindicator.buildins.commonnavigator.indicators.LinePagerIndicator;
import com.linzi.xiguwen.component.magicindicator.buildins.commonnavigator.titles.ColorTransitionPagerTitleView;
import com.linzi.xiguwen.component.magicindicator.buildins.commonnavigator.titles.SimplePagerTitleView;
import com.linzi.xiguwen.fragment.MallActivitiesFragment;
import com.linzi.xiguwen.fragment.MallBaojiaFragment;
import com.linzi.xiguwen.fragment.MallDangqiFragment;
import com.linzi.xiguwen.fragment.MallIndexFragment;
import com.linzi.xiguwen.fragment.MallMsgFragment;
import com.linzi.xiguwen.fragment.MallPingjiaFragment;
import com.linzi.xiguwen.fragment.MallWorksFragment;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.network.Constans;
import com.linzi.xiguwen.utils.ArcImageView;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.StatusBarUtil;
import com.linzi.xiguwen.view.CusScrollView;
import com.linzi.xiguwen.view.CustomViewPager;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

//商家用户详情
public class MallDetailsActivity extends AppCompatActivity {

    @BindView(R.id.aiv_img)
    ArcImageView aivImg;
    @BindView(R.id.iv_head_img)
    ImageView ivHeadImg;
    @BindView(R.id.ll_head)
    LinearLayout llHead;
    @BindView(R.id.ll_bar)
    LinearLayout llBar;
    @BindView(R.id.tv_title)
    TextView tvTitle;
    @BindView(R.id.ll_title)
    RelativeLayout llTitle;
    @BindView(R.id.ll_back)
    LinearLayout llBack;
    @BindView(R.id.ll_right)
    LinearLayout llRight;
    @BindView(R.id.iv_to_top)
    ImageView ivToTop;
    @BindView(R.id.tv_cart_num)
    TextView tvCartNum;
    @BindView(R.id.iv_cart)
    RelativeLayout ivCart;
    @BindView(R.id.scrollView)
    CusScrollView scrollView;
    @BindView(R.id.tv_name)
    TextView tvName;
    @BindView(R.id.iv_rz_cx)
    ImageView ivRzCx;
    @BindView(R.id.iv_rz_pt)
    ImageView ivRzPt;
    @BindView(R.id.iv_rz_xy)
    ImageView ivRzXy;
    @BindView(R.id.tv_team_name)
    TextView tvTeamName;
    @BindView(R.id.iv_zz)
    ImageView ivZz;
    @BindView(R.id.iv_hg)
    ImageView ivHg;
    @BindView(R.id.iv_zs)
    ImageView ivZs;
    @BindView(R.id.iv_xx)
    ImageView ivXx;
    @BindView(R.id.iv_hq)
    ImageView ivHq;
    @BindView(R.id.tv_see)
    TextView tvSee;
    @BindView(R.id.tv_chengjiao)
    TextView tvChengjiao;
    @BindView(R.id.tv_haoping)
    TextView tvHaoping;
    @BindView(R.id.tv_location)
    TextView tvLocation;
    @BindView(R.id.iv_call)
    ImageView ivCall;
    @BindView(R.id.ll_chat_container)
    LinearLayout llChatContainer;
    @BindView(R.id.magic_indicator)
    MagicIndicator magicIndicator;
    @BindView(R.id.view_pager)
    CustomViewPager viewPager;

    Context mContext;

    private static final String[] CHANNELS = new String[]{"首页", "报价", "作品", "评价", "动态", "档期", "资料"};
    @BindView(R.id.iv_care)
    ImageView ivCare;
    private List<String> mDataList = Arrays.asList(CHANNELS);

    private List<Fragment> mFragmentList;
    private int shop_id;
    private Intent intent;
    private BaseBean<ShopUserDetailsBean> bean;
    private List<ImageView> imageViewList;//控制信誉图标等级
    private int isCare;//是否关注商家 1关注


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //改变为白色背景黑色字体的状态栏
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
            StatusBarUtil.setStatusBarColor(MallDetailsActivity.this, R.color.trans);
        }
        setContentView(R.layout.activity_mall_details);
        ButterKnife.bind(this);
        mContext = this;
        if (intent == null) {
            intent = getIntent();
            shop_id = intent.getIntExtra("shop_id", -1);
            NToast.log(mContext, shop_id + "");

        }
        if (shop_id != -1) {
            initViews();
            getData();
        } else {
            NToast.show("跳转错误请重试！");
            finish();
        }
    }

    private void initViews() {
        //获得状态栏高度
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, StatusBarUtil.getStatusBarHeight(MallDetailsActivity.this));
        llBar.setLayoutParams(params);

        ViewCompat.setAlpha(llTitle, 0);
        ViewCompat.setAlpha(llBar, 0);
        scrollView.setScrollViewListener(new CusScrollView.ScrollViewListener() {
            @Override
            public void onScrollChanged(CusScrollView scrollView, int x, int y, int oldx, int oldy) {
                float percent = Float.valueOf("" + y) / Float.valueOf("" + dip2px(mContext, 200));
                if ((1 - percent) < 0.1) {
                    percent = 1;
                }
                if (percent > 1) {
                    percent = 1;
                }
                ViewCompat.setAlpha(llBar, percent);
                ViewCompat.setAlpha(llTitle, percent);

                if (y > 0) {
                    ivToTop.setVisibility(View.VISIBLE);
                } else {
                    ivToTop.setVisibility(View.GONE);
                }
            }
        });

        ivToTop.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
//                scrollView.fullScroll(ScrollView.FOCUS_UP);
                scrollView.scrollTo(0, 0);
                scrollView.setFocusable(true);
            }
        });

        llBack.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                finish();
            }
        });

        if (!Constans.SHOW_MESSAGE_ENTRY) {
            llChatContainer.setVisibility(View.GONE);
        }


        initMagicIndicator();

        viewPager.setAdapter(new PagerAdapter(this.getSupportFragmentManager(), getFragment()));
        viewPager.setCurrentItem(0);
        viewPager.resetHeight(0);
        viewPager.addOnPageChangeListener(new ViewPager.OnPageChangeListener() {
            @Override
            public void onPageScrolled(int position, float positionOffset, int positionOffsetPixels) {
            }

            @Override
            public void onPageSelected(int position) {
                viewPager.resetHeight(position);
            }

            @Override
            public void onPageScrollStateChanged(int state) {

            }
        });
        imageViewList = new ArrayList<>();
        imageViewList.add(ivZz);
        imageViewList.add(ivHg);
        imageViewList.add(ivZs);
        imageViewList.add(ivXx);
        imageViewList.add(ivHq);
    }

    private List<Fragment> getFragment() {
        if (mFragmentList != null) {
            mFragmentList.clear();
        } else {
            mFragmentList = new ArrayList<>();
        }

        mFragmentList.add(MallIndexFragment.newInstance(shop_id));
        mFragmentList.add(MallBaojiaFragment.newInstance(shop_id));
        mFragmentList.add(MallWorksFragment.newInstance(shop_id));
        mFragmentList.add(MallPingjiaFragment.newInstance(shop_id));
        mFragmentList.add(MallActivitiesFragment.newInstance(shop_id));
        mFragmentList.add(MallDangqiFragment.newInstance(shop_id));
        mFragmentList.add(MallMsgFragment.newInstance(shop_id));

        return mFragmentList;
    }

    private void initMagicIndicator() {
        magicIndicator.setBackgroundColor(Color.WHITE);
        CommonNavigator commonNavigator = new CommonNavigator(this);
        commonNavigator.setAdjustMode(true);
        commonNavigator.setLeftPadding(8);
        commonNavigator.setRightPadding(8);
        commonNavigator.setAdapter(new CommonNavigatorAdapter() {
            @Override
            public int getCount() {
                return mDataList == null ? 0 : mDataList.size();
            }

            @Override
            public IPagerTitleView getTitleView(Context context, final int index) {
                SimplePagerTitleView simplePagerTitleView = new ColorTransitionPagerTitleView(context);
                simplePagerTitleView.setText(mDataList.get(index));
                simplePagerTitleView.setTextSize(15);
                simplePagerTitleView.setNormalColor(Color.parseColor("#666666"));
                simplePagerTitleView.setSelectedColor(Color.parseColor("#ff5384"));
                simplePagerTitleView.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        viewPager.setCurrentItem(index);//响应点击
                    }
                });
                return simplePagerTitleView;
            }

            @Override
            public IPagerIndicator getIndicator(Context context) {
                LinePagerIndicator indicator = new LinePagerIndicator(context);
                indicator.setColors(Color.parseColor("#ff5384"));
                return indicator;
            }
        });
        magicIndicator.setNavigator(commonNavigator);
        ViewPagerHelper.bind(magicIndicator, viewPager);
    }

    //将dp转换为px
    public int dip2px(Context context, float dpValue) {
        final float scale = context.getResources().getDisplayMetrics().density;
        return (int) (dpValue * scale + 0.5f);
    }

    @OnClick({R.id.iv_chat, R.id.iv_call_phone, R.id.iv_care, R.id.iv_call, R.id.ll_yuyue})
    public void onViewClicked(View view) {
        switch (view.getId()) {
            case R.id.iv_chat:
                NToast.show("即将上线，敬请期待！");
                break;
            case R.id.iv_call_phone:
                callUser();
                break;
            case R.id.iv_care:
                if (isCare == 1) {
                    cancelCare();
                } else {
                    careShop();
                }
                break;
            case R.id.iv_call:
                callUser();
                break;
            case R.id.ll_yuyue:
                Intent intent = new Intent(mContext, GetSuggestActivity.class);//免费获取方案
                startActivity(intent);
                break;
        }
    }

    //初始化数据
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
                refreshView();
            }

            @Override
            public void onError(Exception ex) {
                NToast.log(mContext, ex.toString());
            }
        });
    }

    //刷新布局数据
    private void refreshView() {
        tvTitle.setText("商家详情");
        ShopUserDetailsBean userDetailsBean = bean.getData();
        GlideLoad.GlideLoadImg(mContext, userDetailsBean.getUserinfo().getBackground(), aivImg);
        GlideLoad.GlideLoadCircle(mContext, userDetailsBean.getUser().getHead(), ivHeadImg);
        tvName.setText(userDetailsBean.getUser().getNickname() + "");
        if (userDetailsBean.getUserinfo().getCollege() == 1) {
            ivRzXy.setVisibility(View.VISIBLE);
        } else {
            ivRzXy.setVisibility(View.GONE);
        }
        if (userDetailsBean.getUserinfo().getPlatform() == 1) {
            ivRzXy.setVisibility(View.VISIBLE);
        } else {
            ivRzXy.setVisibility(View.GONE);
        }
        if (userDetailsBean.getUserinfo().getSincerity() == 1) {
            ivRzXy.setVisibility(View.VISIBLE);
        } else {
            ivRzXy.setVisibility(View.GONE);
        }
        if (userDetailsBean.getUserinfo().getAssociation() != null) {
            tvTeamName.setText("" + userDetailsBean.getUserinfo().getAssociation());
        } else {
            tvTeamName.setText("");
        }


        switch (userDetailsBean.getUser().getXinyu().getB()) {
            case "1":
                ctrlCredibility(1, userDetailsBean.getUser().getXinyu().getA());
                break;
            case "2":
                ctrlCredibility(2, userDetailsBean.getUser().getXinyu().getA());
                break;
            case "3":
                ctrlCredibility(3, userDetailsBean.getUser().getXinyu().getA());
                break;
            case "4":
                ctrlCredibility(4, userDetailsBean.getUser().getXinyu().getA());
                break;
            case "5":
                ctrlCredibility(5, userDetailsBean.getUser().getXinyu().getA());
                break;
        }

        tvSee.setText("浏览 " + userDetailsBean.getUser().getPv());
        tvSee.setText("成交 " + userDetailsBean.getUser().getNum());
        tvSee.setText("好评 " + userDetailsBean.getUser().getGoodscore());
        tvLocation.setText("" + userDetailsBean.getUser().getSite());
        if (userDetailsBean.getUserf() == 1) {
            ivCare.setBackgroundResource(R.mipmap.icon_cared2);
            isCare = 1;
        } else {
            ivCare.setBackgroundResource(R.mipmap.icon_care2);
            isCare = 0;
        }
    }

    //控制显示信誉等级
    private void ctrlCredibility(int index, String type) {
        int img = 0;
        switch (type) {
            case "q":
                img = R.mipmap.icon_hq;
                break;
            case "x":
                img = R.mipmap.icon_xx;
                break;
            case "z":
                img = R.mipmap.icon_zs;
                break;
            case "h":
                img = R.mipmap.icon_hg;
                break;
            case "j":
                img = R.mipmap.icon_zz;
                break;
        }
        for (int i = 0; i < index; i++) {
            imageViewList.get(i).setBackgroundResource(img);
            imageViewList.get(i).setVisibility(View.VISIBLE);
        }
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
    protected void onDestroy() {
        super.onDestroy();
         
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
                    isCare = 1;
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
                    isCare = 0;
                    ivCare.setBackgroundResource(R.mipmap.icon_care2);
                    NToast.show(data.getMessage());
                }
            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }

}
