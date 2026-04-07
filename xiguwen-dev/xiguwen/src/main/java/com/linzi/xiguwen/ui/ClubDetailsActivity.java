package com.linzi.xiguwen.ui;

import android.content.Context;
import android.graphics.Color;
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
import com.linzi.xiguwen.bean.ShetuanIndexBean;
import com.linzi.xiguwen.component.magicindicator.MagicIndicator;
import com.linzi.xiguwen.component.magicindicator.ViewPagerHelper;
import com.linzi.xiguwen.component.magicindicator.buildins.commonnavigator.CommonNavigator;
import com.linzi.xiguwen.component.magicindicator.buildins.commonnavigator.abs.CommonNavigatorAdapter;
import com.linzi.xiguwen.component.magicindicator.buildins.commonnavigator.abs.IPagerIndicator;
import com.linzi.xiguwen.component.magicindicator.buildins.commonnavigator.abs.IPagerTitleView;
import com.linzi.xiguwen.component.magicindicator.buildins.commonnavigator.indicators.LinePagerIndicator;
import com.linzi.xiguwen.component.magicindicator.buildins.commonnavigator.titles.ColorTransitionPagerTitleView;
import com.linzi.xiguwen.component.magicindicator.buildins.commonnavigator.titles.SimplePagerTitleView;
import com.linzi.xiguwen.fragment.ClubActivitiesFragment;
import com.linzi.xiguwen.fragment.ClubContactFragment;
import com.linzi.xiguwen.fragment.ClubSomeOneFragment;
import com.linzi.xiguwen.fragment.ClubWorksFragment;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
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

public class ClubDetailsActivity extends AppCompatActivity {

    @BindView(R.id.iv_img)
    ImageView ivImg;
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
    @BindView(R.id.scrollView)
    CusScrollView scrollView;
    @BindView(R.id.iv_head_img)
    ImageView ivHeadImg;
    @BindView(R.id.ll_head)
    LinearLayout llHead;
    @BindView(R.id.tv_name)
    TextView tvName;
    @BindView(R.id.tv_location)
    TextView tvLocation;
    @BindView(R.id.magic_indicator)
    MagicIndicator magicIndicator;
    @BindView(R.id.view_pager)
    CustomViewPager viewPager;
    @BindView(R.id.iv_to_top)
    ImageView ivToTop;
    @BindView(R.id.tv_cart_num)
    TextView tvCartNum;
    @BindView(R.id.iv_cart)
    RelativeLayout ivCart;
    @BindView(R.id.tv_look)
    TextView tvLook;
    Context mContext;
    private static final String[] CHANNELS = new String[]{"动态", "成员", "作品", "联系"};
    private List<String> mDataList = Arrays.asList(CHANNELS);
    public static final String BEAN_KEY = "bean";
    public static final String ID_KEY = "bean";
    private List<Fragment> mFragmentList;
    private String id;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //改变为白色背景黑色字体的状态栏
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
            StatusBarUtil.setStatusBarColor(ClubDetailsActivity.this, R.color.trans);
        }
        setContentView(R.layout.activity_club_details);
        ButterKnife.bind(this);
        mContext = this;
        id = getIntent().getIntExtra(ID_KEY, -1) + "";
        initViews();
    }

    private void initViews() {
        //---------------------------绑定传递过来的对象---------------------------------
//        tvName.setText(mBean.getName());//名字
//        GlideLoad.GlideLoadImg(mBean.getAppphotourl(), ivImg);//背景大图
//        GlideLoad.GlideLoadImg(mBean.getLogourl(), ivHeadImg);//头像
//        tvLocation.setText(mBean.getAddress());//地址
        //获得状态栏高度
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, StatusBarUtil.getStatusBarHeight(ClubDetailsActivity.this));
        llBar.setLayoutParams(params);
        ViewCompat.setAlpha(llTitle, 0);
        ViewCompat.setAlpha(llBar, 0);
        scrollView.setScrollViewListener(new CusScrollView.ScrollViewListener() {
            @Override
            public void onScrollChanged(CusScrollView scrollView, int x, int y, int oldx, int oldy) {
                float percent = Float.valueOf("" + y) / Float.valueOf("" + dip2px(mContext, 265));
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
                scrollView.setFocusable(true);
                scrollView.scrollTo(0, 0);
            }
        });

        llBack.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                finish();
            }
        });

        initMagicIndicator();
        mFragmentList = getFragment();
        LoadDialog.showDialog(this);
        ApiManager.getShetuanIndex(id, "1", "30", new OnRequestFinish<BaseBean<ShetuanIndexBean>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<ShetuanIndexBean> data) {
                mData = data;
                ((ClubActivitiesFragment) mFragmentList.get(0)).setArrayList(data.getData().getDynamiclist());
                afterConfigView();
            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }

    private BaseBean<ShetuanIndexBean> mData = null;

    public BaseBean<ShetuanIndexBean> getData() {
        return mData;
    }

    /**
     * 先把数据请求到了再来配置Fragment
     */
    private void afterConfigView() {

        viewPager.setAdapter(new PagerAdapter(this.getSupportFragmentManager(), getFragment()));
        viewPager.setCurrentItem(0);
        viewPager.addOnPageChangeListener(new ViewPager.OnPageChangeListener() {
            @Override
            public void onPageScrolled(int position, float positionOffset, int positionOffsetPixels) {

            }

            @Override
            public void onPageSelected(int position) {
                NToast.log("position", "" + position);
                viewPager.resetHeight(position);
            }

            @Override
            public void onPageScrollStateChanged(int state) {

            }
        });
        viewPager.resetHeight(0);
    }

    private List<Fragment> getFragment() {
        if (mFragmentList != null) {
            mFragmentList.clear();
        } else {
            mFragmentList = new ArrayList<>();
        }
        mFragmentList.add(new ClubActivitiesFragment(viewPager));
        mFragmentList.add(new ClubSomeOneFragment(viewPager));
        mFragmentList.add(new ClubWorksFragment(viewPager));
        mFragmentList.add(new ClubContactFragment(viewPager));

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
                        viewPager.setCurrentItem(index);
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
}
