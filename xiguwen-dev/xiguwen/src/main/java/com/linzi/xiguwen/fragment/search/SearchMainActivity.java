package com.linzi.xiguwen.fragment.search;

import android.content.Context;
import android.content.Intent;
import android.graphics.Color;
import android.graphics.drawable.ColorDrawable;
import android.os.Build;
import android.os.Bundle;
import androidx.annotation.Nullable;
import com.google.android.material.tabs.TabLayout;
import androidx.fragment.app.Fragment;
import androidx.viewpager.widget.ViewPager;
import androidx.appcompat.app.AppCompatActivity;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.PopupWindow;
import android.widget.RadioButton;
import android.widget.RadioGroup;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.ViewPagerAdapter;
import com.linzi.xiguwen.utils.AppUtil;
import com.linzi.xiguwen.utils.StatusBarUtil;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

/**
 * Created by PC on 2018-04-14.
 */

public class SearchMainActivity extends AppCompatActivity {

    @BindView(R.id.search_city)
    TextView txSearchCity;
    @BindView(R.id.ed_search)
    EditText edSearch;
    @BindView(R.id.tv_close)
    TextView tvClose;
    @BindView(R.id.tabs)
    TabLayout tabs;
    @BindView(R.id.viewpager)
    ViewPager pager;
    @BindView(R.id.ll_bar)
    LinearLayout llBar;

    private List<Fragment> mFragmentList;
    private SearchMerchantsFragment merchantsFragment;
    private SearchCaseFragment caseFragment;
    private SearchPriceFragment priceFragment;
    private SearchGoodsFragment goodsFragment;

    private ViewPagerAdapter pagerAdapter;
    private List<String> titlelist;

    private String city;
    private String content;
    private int cityType;

    private PopupWindow popupWindow;
    private RadioGroup radioGroup;
    private RadioButton radioCity;
    private RadioButton radioCountry;


    public static void startAction(Context context, String city, String content, int cityType) {

        Intent intent = new Intent(context, SearchMainActivity.class);
        intent.putExtra("city", city);
        intent.putExtra("content", content);
        intent.putExtra("cityType", cityType);
        context.startActivity(intent);
    }

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //改变为白色背景黑色字体的状态栏
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
            StatusBarUtil.setStatusBarColor(SearchMainActivity.this, R.color.white);
            StatusBarUtil.setNavigationBarColor(SearchMainActivity.this, R.color.white);
        }

        setContentView(R.layout.activity_search_main);
        ButterKnife.bind(this);
        getIntentData();
        initView();
        initPop();
        event();
        if (cityType == 2) {
            radioCountry.setChecked(true);
        } else {
            radioCity.setChecked(true);
        }

    }

    private void getIntentData() {
        Intent intent = getIntent();
        city = intent.getStringExtra("city");
        content = intent.getStringExtra("content");
        cityType = intent.getIntExtra("cityType", 1);
    }

    private void initView() {
        //获得状态栏高度
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, StatusBarUtil.getStatusBarHeight(SearchMainActivity.this));
        llBar.setLayoutParams(params);
// ViewCompat.setAlpha(llBar, 0);
        llBar.setBackgroundColor(SearchMainActivity.this.getResources().getColor(R.color.white));


        edSearch.setText(content + "");
        titlelist = new ArrayList<>();
        titlelist.add("商家");
        titlelist.add("案例");
        titlelist.add("报价");
        titlelist.add("商品");
        getFragment();
        pagerAdapter = new ViewPagerAdapter(getSupportFragmentManager(), mFragmentList, titlelist);
        pager.setAdapter(pagerAdapter);
        pager.setCurrentItem(0);
        tabs.setupWithViewPager(pager);


    }

    private List<Fragment> getFragment() {
        if (mFragmentList != null) {
            mFragmentList.clear();
        } else {
            mFragmentList = new ArrayList<>();
        }

        merchantsFragment = SearchMerchantsFragment.newInstance(content, cityType);
        caseFragment = SearchCaseFragment.newInstance(content, cityType);
        priceFragment = SearchPriceFragment.newInstance(0, content, cityType);
        goodsFragment = SearchGoodsFragment.newInstance(1, content, cityType);
        mFragmentList.add(merchantsFragment);
        mFragmentList.add(caseFragment);
        mFragmentList.add(priceFragment);
        mFragmentList.add(goodsFragment);
        return mFragmentList;
    }


    private void showPop() {
        //是否展开pop
        if (popupWindow == null) {
            return;
        }
        if (popupWindow.isShowing()) {
            popupWindow.dismiss();
        } else {
            popupWindow.showAsDropDown(txSearchCity);
        }

    }


    private void initPop() {
        View view = LayoutInflater.from(this).inflate(R.layout.pop_view_serarch_city, null);
        popupWindow = new PopupWindow(view, AppUtil.dip2px(this, 360), WindowManager.LayoutParams.WRAP_CONTENT, true);
        radioGroup = view.findViewById(R.id.pop_radiogroup);
        radioCity = view.findViewById(R.id.pop_city);
        radioCountry = view.findViewById(R.id.pop_country);
        popupWindow.setBackgroundDrawable(new ColorDrawable(Color.TRANSPARENT));
        popupWindow.setOutsideTouchable(true);

        // 设置PopupWindow是否能响应点击事件
        popupWindow.setTouchable(true);
    }

    private void event() {

        edSearch.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {

            }

            @Override
            public void afterTextChanged(Editable s) {
                content = edSearch.getText().toString().trim();
                if (!AppUtil.isEmpty(content)) {
                    tvClose.setText("搜索");
                } else {
                    tvClose.setText("取消");
                }
            }
        });

        radioGroup.setOnCheckedChangeListener(new RadioGroup.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(RadioGroup group, int checkedId) {
                if (checkedId == R.id.pop_city) {
                    cityType = 1;
                    txSearchCity.setText("同城");

                } else if (checkedId == R.id.pop_country) {
                    cityType = 2;
                    txSearchCity.setText("全国");
                }
                merchantsFragment.setCityType(cityType);
                caseFragment.setCityType(cityType);
                priceFragment.setCityType(cityType);
                goodsFragment.setCityType(cityType);
                popupWindow.dismiss();
            }
        });
    }

    @OnClick({R.id.search_city, R.id.tv_close})
    public void onViewClicked(View view) {
        switch (view.getId()) {
            case R.id.search_city:
                showPop();
                break;
            case R.id.tv_close:
                AppUtil.clearInputMethod(edSearch);
                if (tvClose.getText().toString().equals("搜索")) {
                    String content = edSearch.getText().toString().trim();
                    merchantsFragment.setSearchContent(content);
                    caseFragment.setSearchContent(content);
                    priceFragment.setSearchContent(content);
                    goodsFragment.setSearchContent(content);

                } else {
                    finish();
                }

                break;
        }
    }

}
