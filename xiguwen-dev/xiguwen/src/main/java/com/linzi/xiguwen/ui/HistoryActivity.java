package com.linzi.xiguwen.ui;

import android.content.Context;
import android.os.Build;
import android.os.Bundle;
import com.google.android.material.tabs.TabLayout;
import androidx.fragment.app.Fragment;
import androidx.viewpager.widget.ViewPager;
import androidx.appcompat.app.AppCompatActivity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.ViewPagerAdapter;
import com.linzi.xiguwen.bean.ClassificationBean;
import com.linzi.xiguwen.bean.MyDateBean;
import com.linzi.xiguwen.fragment.HistoryFragment;
import com.linzi.xiguwen.net.OnRequestSubscribe;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.StatusBarUtil;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;
import com.linzi.xiguwen.view.ScrollerDatePicker;
import com.linzi.xiguwen.view.dateview.ChooseDatePop;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class HistoryActivity extends AppCompatActivity {

    @BindView(R.id.ll_back)
    LinearLayout llBack;
    @BindView(R.id.ed_search)
    EditText edSearch;
    @BindView(R.id.view_pager)
    ViewPager viewPager;
    @BindView(R.id.ll_bar)
    LinearLayout llBar;

    @BindView(R.id.ll_parent)
    LinearLayout llParent;
    @BindView(R.id.tab_title2)
    TabLayout tabTitle2;

    private List<String> mDataList;
    private BaseBean<ArrayList<ClassificationBean>> bean;
    private List<Fragment> mFragmentList;

    int year = 0, month = 0, day = 0;
    int tomonth = 0;
    int toyear = 0;
    int today = 0;
    private int timeslot = 5;//时间段，1上午2中午3下午4晚上5全天
    private String date = null;//时间

    Context mContext;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //改变为白色背景黑色字体的状态栏
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
            StatusBarUtil.setStatusBarColor(HistoryActivity.this, R.color.white);
            StatusBarUtil.setNavigationBarColor(HistoryActivity.this, R.color.white);
        }
        setContentView(R.layout.activity_history);
        com.linzi.xiguwen.utils.LogUtil.e("onCreate",getClass().getSimpleName());
        ButterKnife.bind(this);
        mContext = this;
        //initData();
        getClassificationlist();
        initView();
    }


    private void initView() {
        //获得状态栏高度
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, StatusBarUtil.getStatusBarHeight(HistoryActivity.this));
        llBar.setLayoutParams(params);
        mDataList = new ArrayList<>();
    }

    //设置tablayout tab
    private void initFristTab() {
        for (int i = 0; i < mDataList.size(); i++) {
            TabLayout.Tab tab = tabTitle2.getTabAt(i);
            tab.setCustomView(R.layout.jifen_tab);
            TextView textView = (TextView) tab.getCustomView().findViewById(R.id.tv_title);
            textView.setText(mDataList.get(i));//设置tab上的文字
            textView.setTextSize(16);
        }
        //setIndicator(getActivity(), tabTitle, 70, 70);
    }


    //创建时间选择器
    private void createChooseTimePop(View llParent) {
        ArrayList<MyDateBean> when_list = new ArrayList<>();
        for (int x = 0; x < 4; x++) {
            MyDateBean mBean = new MyDateBean();
            mBean.setId(x);
            switch (x) {
                case 0:
                    mBean.setDate("上午");
                    break;
                case 1:
                    mBean.setDate("中午");
                    break;
                case 2:
                    mBean.setDate("下午");
                    break;
                case 3:
                    mBean.setDate("晚上");
                    break;
            }
            when_list.add(mBean);
        }
        ChooseDatePop chooseDatePop = new ChooseDatePop(mContext, when_list, false);
        chooseDatePop.setShowWithView(llParent);
        chooseDatePop.setListener(new ChooseDatePop.ReturnTimeStr() {
            @Override
            public void onSubmit(String string, String date, int whenid) {
                // setShowWithView(showView);
                edSearch.setText(string);
                HistoryActivity.this.date = date;
                HistoryActivity.this.timeslot = whenid;
//                com.linzi.xiguwen.utils.LogUtil.e("Test","=============>1");
                EventBusUtil.sendEvent(new Event(EventCode.REFRESH_HISTORY, 0));
            }
        });
//       NewChooseDatePop pop = new NewChooseDatePop(context);
 //       pop.setShowWithView(llParent);
    }


    private List<Fragment> getFragment() {
        if (mFragmentList != null) {
            mFragmentList.clear();
        } else {
            mFragmentList = new ArrayList<>();
        }
        for (int x = 0; x < mDataList.size(); x++) {
            mFragmentList.add(HistoryFragment.newInstance(x, bean.getData().get(x).getOccupationid()));
        }
        return mFragmentList;
    }


    @OnClick({R.id.ll_back, R.id.ed_search})
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.ll_back:
                finish();
                break;
            case R.id.ed_search:
                createChooseTimePop(llParent);
                break;
        }
    }

    public int getTimeslot() {
        return timeslot;
    }

    public String getDate() {
        return date;
    }

    class ViewHolder {
        @BindView(R.id.tv_close)
        TextView tvClose;
        @BindView(R.id.tv_submit)
        TextView tvSubmit;
        @BindView(R.id.pick_year)
        ScrollerDatePicker pickYear;
        @BindView(R.id.tv_nian)
        TextView tvNian;
        @BindView(R.id.pick_month)
        ScrollerDatePicker pickMonth;
        @BindView(R.id.tv_yue)
        TextView tvYue;
        @BindView(R.id.pick_day)
        ScrollerDatePicker pickDay;
        @BindView(R.id.tv_ri)
        TextView tvRi;
        @BindView(R.id.pick_when)
        ScrollerDatePicker pickWhen;

        ViewHolder(View view) {
            ButterKnife.bind(this, view);
        }
    }

    //初始化职业种类
    private void getClassificationlist() {
        ApiManager.getClassification(new OnRequestSubscribe<BaseBean<ArrayList<ClassificationBean>>>() {
            @Override
            public void onSuccess(BaseBean<ArrayList<ClassificationBean>> data) {
                bean = data;
                if (data.getData() != null && data.getData().size() > 0) {
                    for (int i = 0; i < bean.getData().size(); i++) {
                        mDataList.add(bean.getData().get(i).getProname());
                    }
                    viewPager.setAdapter(new ViewPagerAdapter(getSupportFragmentManager(), getFragment(), mDataList));
                    viewPager.setOffscreenPageLimit(1);
                    viewPager.setCurrentItem(0);
                    tabTitle2.setupWithViewPager(viewPager);
                    for (int i = 0; i < tabTitle2.getTabCount(); i++) {
                        tabTitle2.getTabAt(i).setTag(bean.getData().get(i).getOccupationid());
                    }
                    initFristTab();
                }
            }

            @Override
            public void onError(Exception ex) {
            }
        });
    }

}
