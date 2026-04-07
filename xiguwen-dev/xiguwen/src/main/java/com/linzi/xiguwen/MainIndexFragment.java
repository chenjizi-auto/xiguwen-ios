package com.linzi.xiguwen;

import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;

import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.viewpager.widget.ViewPager;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.baidu.location.BDLocation;
import com.linzi.xiguwen.adapter.PagerAdapter;
import com.linzi.xiguwen.bean.CityEntity;
import com.linzi.xiguwen.bean.OnLineBean;
import com.linzi.xiguwen.component.magicindicator.MagicIndicator;
import com.linzi.xiguwen.component.magicindicator.ViewPagerHelper;
import com.linzi.xiguwen.component.magicindicator.buildins.commonnavigator.CommonNavigator;
import com.linzi.xiguwen.component.magicindicator.buildins.commonnavigator.abs.CommonNavigatorAdapter;
import com.linzi.xiguwen.component.magicindicator.buildins.commonnavigator.abs.IPagerIndicator;
import com.linzi.xiguwen.component.magicindicator.buildins.commonnavigator.abs.IPagerTitleView;
import com.linzi.xiguwen.component.magicindicator.buildins.commonnavigator.indicators.LinePagerIndicator;
import com.linzi.xiguwen.component.magicindicator.buildins.commonnavigator.titles.ColorTransitionPagerTitleView;
import com.linzi.xiguwen.component.magicindicator.buildins.commonnavigator.titles.SimplePagerTitleView;
import com.linzi.xiguwen.fragment.ClubFragment;
import com.linzi.xiguwen.fragment.NewExampleFragment;
import com.linzi.xiguwen.fragment.NewIndexFragment;
import com.linzi.xiguwen.fragment.city.CityListActivity;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.OnRequestSubscribe;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.ui.HistoryActivity;
import com.linzi.xiguwen.ui.SearchActivity;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.StatusBarUtil;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;
import com.linzi.xiguwen.utils.location.CustomLocationListener;
import com.linzi.xiguwen.utils.location.LocationHelper;
import com.linzi.xiguwen.utils.yixin.preference.Preferences;

import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class MainIndexFragment extends Fragment {

    @BindView(R.id.ll_bar)
    LinearLayout llBar;
    @BindView(R.id.ed_search)
    EditText edSearch;
    @BindView(R.id.tv_location)
    public TextView tvLocation;
    @BindView(R.id.iv_icon)
    TextView ivIcon;
    @BindView(R.id.magic_indicator)
    MagicIndicator magicIndicator;
    @BindView(R.id.view_pager)
    ViewPager viewPager;

    //private static final String[] CHANNELS = new String[]{"婚庆", "商城", "社团", "案例"};
    private static final String[] CHANNELS = new String[]{"婚庆", "社团", "案例"};
    private List<String> mDataList = Arrays.asList(CHANNELS);

    private List<Fragment> mFragmentList;

    public int city_code = 0;
    public static MainIndexFragment instence;

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = LayoutInflater.from(getActivity()).inflate(R.layout.activity_main, null);
        ButterKnife.bind(this, view);
        instence = this;
        //获得状态栏高度
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, StatusBarUtil.getStatusBarHeight(getActivity()));
        llBar.setLayoutParams(params);
        llBar.setBackgroundColor(getActivity().getResources().getColor(R.color.white));
        //ViewCompat.setAlpha(llBar, 0);

        initData();
        return view;
    }

    private void initData() {
        EventBusUtil.register(this);

        edSearch.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(getActivity(), SearchActivity.class);
                startActivity(intent);
            }
        });
        initMagicIndicator();
        viewPager.setAdapter(new PagerAdapter(MainIndexFragment.this.getChildFragmentManager(), getFragment()));
        viewPager.setCurrentItem(0);
        requestCity();
    }

    private List<Fragment> getFragment() {
        if (mFragmentList != null) {
            mFragmentList.clear();
        } else {
            mFragmentList = new ArrayList<>();
        }
        // mFragmentList.add(new IndexFragment());
        mFragmentList.add(NewIndexFragment.createFragment());
        //mFragmentList.add(NewMallFragment.create(city_code));
        //mFragmentList.add(NewHotFragment.createFragment());
        mFragmentList.add(new ClubFragment());
        mFragmentList.add(new NewExampleFragment());
        return mFragmentList;
    }

    private void initMagicIndicator() {
        magicIndicator.setBackgroundColor(Color.WHITE);
        CommonNavigator commonNavigator = new CommonNavigator(getActivity());
        commonNavigator.setAdjustMode(true);
        commonNavigator.setAdapter(new CommonNavigatorAdapter() {
            @Override
            public int getCount() {
                return mDataList == null ? 0 : mDataList.size();
            }

            @Override
            public IPagerTitleView getTitleView(Context context, final int index) {
                SimplePagerTitleView simplePagerTitleView = new ColorTransitionPagerTitleView(context);
                simplePagerTitleView.setText(mDataList.get(index));
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

    /* @Override
     public void onActivityResult(int requestCode, int resultCode, Intent data) {
 //        super.onActivityResult(requestCode, resultCode, data);
         if (data != null) {
             switch (resultCode) {
                 case 121:
                     tvLocation.setText(data.getStringExtra("city_name"));
                     city_code = data.getIntExtra("city_code", 0);
                     NToast.log("city_id", "" + city_code);
                     if (IndexFragment.instence != null) {
                         IndexFragment.instence.getIndex();
                     }
                     break;
             }
         }
     }
 */
    @OnClick({R.id.tv_location, R.id.iv_icon})
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.tv_location:
//                Intent intent = new Intent(getActivity(), SelectCityActivity.class);
//                this.startActivityForResult(intent, 121);

                Intent intent = new Intent(getActivity(), CityListActivity.class);
                startActivity(intent);
                break;
            case R.id.iv_icon:
                Intent intent2 = new Intent(getActivity(), HistoryActivity.class);
                this.startActivity(intent2);
                break;
        }
    }

    @Subscribe(threadMode = ThreadMode.MAIN)
    public void receiveEvent(Event entity) {
        if (entity == null)
            return;
        try {
            int code = entity.getCode();
            switch (code) {
                case EventCode.CITY_SELECT:
                    CityEntity cityEntity = (CityEntity) entity.getData();
                    tvLocation.setText(cityEntity.getName());
                    city_code = cityEntity.getId();
                    Preferences.saveCity(cityEntity);
                    break;
            }
        } catch (Exception e) {
        }

    }


    /**
     * 获取当前城市, 及当前城市的区县信息
     */
    private void requestCity() {
        LocationHelper.requestLocation(new CustomLocationListener.ReceiveLocation() {
            @Override
            public void onLocation(BDLocation bdLocation) {
                String city;
                if (bdLocation == null || bdLocation.getLocType() == BDLocation.TypeServerError || bdLocation.getCity() == null) {
                    city = "成都市";
                } else {
                    city = bdLocation.getCity();
                }
                tvLocation.setText(city);
                com.linzi.xiguwen.utils.LogUtil.e("===city-location======", city);
//                ApiManager.getCityIdNew(city, new OnRequestSubscribe<com.linzi.bytc_new.net.base.BaseBean<CityEntity>>() {
//                    @Override
//                    public void onSuccess(com.linzi.bytc_new.net.base.BaseBean<CityEntity> data) {
//                        Preferences.saveCity(data.getData());
//                        initMagicIndicator();
//                        viewPager.setAdapter(new PagerAdapter(MainIndexFragment.this.getChildFragmentManager(), getFragment()));
//                        viewPager.setCurrentItem(0);
//
//                    }
//
//                    @Override
//                    public void onError(Exception ex) {
//
//                    }
//                });
                httpCity(city);
            }
        });
    }

    private void httpCity(String city) {
        ApiManager.getCityIdNew(city, new OnRequestSubscribe<com.linzi.xiguwen.net.base.BaseBean<CityEntity>>() {
            @Override
            public void onSuccess(final com.linzi.xiguwen.net.base.BaseBean<CityEntity> data) {
                Preferences.saveCity(data.getData());
//                initMagicIndicator();
//                viewPager.setAdapter(new PagerAdapter(MainIndexFragment.this.getChildFragmentManager(), getFragment()));
//                viewPager.setCurrentItem(0);

                //请在此执行刷新数据的方法
                new Timer().schedule(new TimerTask() {
                    @Override
                    public void run() {
                        EventBusUtil.sendEvent(new Event(EventCode.CITY_SELECT, data.getData()));
                    }
                }, 1000);

            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }

    /**
     * 商家店铺是否上线
     */
    public void isOnLine() {
        ApiManager.shopIsOnLine(new OnRequestFinish<BaseBean<OnLineBean>>() {
            @Override
            public void onFinished() {

            }

            @Override
            public void onSuccess(BaseBean<OnLineBean> data) {
                if (data.getData().getOnlinestatus() == 2) {
                    new AlertDialog.Builder(getActivity())
                            .setTitle("请注意")
                            .setMessage("尊敬的商家，您的店铺当前处于下线状态，是否上线店铺？")
                            .setNegativeButton("取消", null)
                            .setPositiveButton("上线", new DialogInterface.OnClickListener() {
                                @Override
                                public void onClick(DialogInterface dialogInterface, int i) {
                                    onLine();
                                }
                            })
                            .show();
                }

            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }

    /**
     * 上线店铺
     */
    private void onLine() {
        ApiManager.shopOnLine(1, new OnRequestFinish<BaseBean>() {
            @Override
            public void onFinished() {

            }

            @Override
            public void onSuccess(BaseBean data) {
                NToast.show(data.getMessage());
            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }

    @Override
    public void onResume() {
        super.onResume();
        isOnLine();
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
        EventBusUtil.unregister(this);
    }
}
