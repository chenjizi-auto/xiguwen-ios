package com.linzi.xiguwen.ui;

import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import com.google.android.material.tabs.TabLayout;
import androidx.fragment.app.Fragment;
import androidx.viewpager.widget.ViewPager;
import androidx.appcompat.app.AppCompatActivity;

import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.ViewPagerAdapter;
import com.linzi.xiguwen.bean.InvitationsTemplateTypeBean;
import com.linzi.xiguwen.fragment.ChooseMobanFragment;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.StatusBarUtil;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

public class ChooseMobanActivity extends AppCompatActivity {

    @BindView(R.id.ll_bar)
    LinearLayout llBar;
    @BindView(R.id.iv_back)
    ImageView ivBack;
    @BindView(R.id.tv_title)
    TextView tvTitle;
    @BindView(R.id.nodata_layout)
    View mNodataLayout;
    @BindView(R.id.ll_content)
    View mContent;

    @BindView(R.id.tab_title)
    TabLayout mIndicator;
    @BindView(R.id.view_pager)
    ViewPager viewPager;

    private List<InvitationsTemplateTypeBean> mTypes; // 我的类别集合

    private List<Fragment> mFragmentList;
    private List<String> mTitleList;
//    private TitleAdapter mTitleAdapter;     //标题栏的适配器
    private ViewPagerAdapter mPagerAdapter; // viewpager的适配器

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
            StatusBarUtil.setStatusBarColor(ChooseMobanActivity.this, R.color.trans);
            StatusBarUtil.setNavigationBarColor(ChooseMobanActivity.this, R.color.white);
        }
        setContentView(R.layout.activity_moban);
        ButterKnife.bind(this);
        initViews();
    }
    private void initViews(){
        //获得状态栏高度
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, StatusBarUtil.getStatusBarHeight(this));
        llBar.setLayoutParams(params);

        tvTitle.setText("选择模板");
        ivBack.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                finish();
            }
        });


        mFragmentList = new ArrayList<>();
        mTypes = new ArrayList<>();

//        initMagicIndicator();
        mIndicator.setupWithViewPager(viewPager);
        mTitleList = new ArrayList<>();
        mPagerAdapter = new ViewPagerAdapter(getSupportFragmentManager(), mFragmentList, mTitleList);
        viewPager.setAdapter(mPagerAdapter);
        viewPager.setCurrentItem(getIntent().getIntExtra("tag", 0));
        requestTemplateTypes();
    }

    // 请求模板类型列表
    private void requestTemplateTypes(){
        LoadDialog.showDialog(this);
        ApiManager.getInvitationsTemplateTypeList(new OnRequestFinish<BaseBean<List<InvitationsTemplateTypeBean>>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<List<InvitationsTemplateTypeBean>> data) {
                // 请求成功，那么刷新界面
                mTypes.clear();
                mTypes.addAll(data.getData());
                mFragmentList.clear();
                mTitleList.clear();
                for (InvitationsTemplateTypeBean typeBean : mTypes) {
                    mFragmentList.add(ChooseMobanFragment.newInstance(typeBean));
                    mTitleList.add(typeBean.getTitle());
                }
                if(mTitleList.size() <= 4){
                    mIndicator.setTabMode(TabLayout.MODE_FIXED);
                }else{
                    mIndicator.setTabMode(TabLayout.MODE_SCROLLABLE);
                }
                mPagerAdapter.notifyDataSetChanged();
                if(mTypes.size() > 0){
                    mContent.setVisibility(View.VISIBLE);
                    mNodataLayout.setVisibility(View.GONE);
                }
                initFristTab();
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
            }
        });
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        setResult(resultCode);
    }

    private void initFristTab() {
        for (int i = 0; i < mTitleList.size(); i++) {
            TabLayout.Tab tab = mIndicator.getTabAt(i);
            tab.setCustomView(R.layout.jifen_tab);
            TextView textView = (TextView) tab.getCustomView().findViewById(R.id.tv_title);
            textView.setText(mTitleList.get(i));//设置tab上的文字
            textView.setTextSize(16);
        }
        //setIndicator(getActivity(), tabTitle, 70, 70);
    }
}
