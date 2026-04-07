package com.linzi.xiguwen.fragment.city;

import android.Manifest;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import android.text.Editable;
import android.text.TextUtils;
import android.text.TextWatcher;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.TextView;

import com.baidu.location.BDLocation;
import com.baidu.location.BDLocationListener;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.discover.SortAdapter;
import com.linzi.xiguwen.bean.CityData;
import com.linzi.xiguwen.bean.CityEntity;
import com.linzi.xiguwen.cache.OnCacheRequestFinish;
import com.linzi.xiguwen.cache.repository.CityDictionaryRepository;
import com.linzi.xiguwen.utils.AppUtil;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.LocationService;
import com.linzi.xiguwen.utils.StatusBarUtil;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;
import com.linzi.xiguwen.widget.SideBar;
import com.yanzhenjie.permission.AndPermission;
import com.yanzhenjie.permission.PermissionListener;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

/**
 * Created by devin on 2018/4/13 16:04
 * Description
 */

public class CityListActivity extends AppCompatActivity {

    @BindView(R.id.tv_title)
    TextView tvTitle;
    @BindView(R.id.ed_search)
    EditText edSearch;
    @BindView(R.id.main_lv)
    ListView mListview;
    @BindView(R.id.dialog)
    TextView txToast;
    @BindView(R.id.side_bar)
    SideBar mSideBar;
    @BindView(R.id.ll_bar)
    LinearLayout llBar;

    private CityHeaderView mHeaderView;
    private SortAdapter sortAdapter;

    private List<CityEntity> cityEntities = new ArrayList<>();

    private List<CityEntity> searchEntities = new ArrayList<>();
    private LocationService mLocClient;
    private MyLocationListenner mLoactionListener = new MyLocationListenner();
    private boolean isLocation = false;
    private String locationCity = "";

    private int type;

    /**
     * @param context
     * @param type    0.首页选择城市  1.个人资料选择城市
     */
    public static void startAction(Context context, int type) {
        Intent intent = new Intent(context, CityListActivity.class);
        intent.putExtra("type", type);
        context.startActivity(intent);
    }

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //改变为白色背景黑色字体的状态栏
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
            StatusBarUtil.setStatusBarColor(CityListActivity.this, R.color.white);
            StatusBarUtil.setNavigationBarColor(CityListActivity.this, R.color.white);
        }
        setContentView(R.layout.activity_citylist);
        ButterKnife.bind(this);
        type = getIntent().getIntExtra("type", 0);
        initView();
        httpData();

        if (!AndPermission.hasPermission(this,Manifest.permission.ACCESS_COARSE_LOCATION) ){
            AndPermission.with(this)
                    .requestCode(102)
                    .callback(permissionlistener)
                    .permission(Manifest.permission.ACCESS_COARSE_LOCATION//定位相关权限
                            , Manifest.permission.ACCESS_FINE_LOCATION).start();
        }else {
            initLocationClient();
        }

    }

    /**
     * 权限申请回调的监听
     */
    private PermissionListener permissionlistener = new PermissionListener() {
        @Override
        public void onSucceed(int requestCode, List<String> grantedPermissions) {
            // 权限申请成功回调。
            if (requestCode == 102) {
                // TODO 相应代码。
                initLocationClient();
            }
        }

        @Override
        public void onFailed(int requestCode, List<String> deniedPermissions) {
            // 权限申请失败回调。

            // 用户否勾选了不再提示并且拒绝了权限，那么提示用户到设置中授权。
            if (AndPermission.hasAlwaysDeniedPermission(CityListActivity.this, deniedPermissions)) {
                // 第一种：用默认的提示语。
//                AndPermission.defaultSettingDialog(this, REQUEST_CODE_SETTING).show();

                //第二种：用自定义的提示语。
                AndPermission.defaultSettingDialog(CityListActivity.this, 102)
                        .setTitle("权限申请失败")
                        .setMessage("我们需要的定位权限被您拒绝或者系统发生错误申请失败，请您到设置页面手动授权，否则功能无法正常使用！")
                        .setPositiveButton("好，去设置")
                        .show();
            }
        }
    };


    private void initView() {
        //获得状态栏高度
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, StatusBarUtil.getStatusBarHeight(CityListActivity.this));
        llBar.setLayoutParams(params);
        // ViewCompat.setAlpha(llBar, 0);
        llBar.setBackgroundColor(CityListActivity.this.getResources().getColor(R.color.white));

        mHeaderView = new CityHeaderView(this);
        mListview.addHeaderView(mHeaderView);
        mHeaderView.setType(type);
        sortAdapter = new SortAdapter(this);
        sortAdapter.setType(type);
        mListview.setAdapter(sortAdapter);
        mSideBar.setTextView(txToast);
        tvTitle.setText("选择城市");
        mHeaderView.setLocationOnclick(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                select();
            }
        });
        event();
    }

    private void select() {
        if (isLocation) {
            for (CityEntity cityEntity : cityEntities) {
                if (cityEntity.getName().equals(locationCity)) {
                    if (type == 1) {
                        EventBusUtil.sendEvent(new Event(EventCode.USER_UPTATE_CITY, cityEntity));
                    } else {
                        EventBusUtil.sendEvent(new Event(EventCode.CITY_SELECT, cityEntity));
                    }

                    break;
                }
            }
            finish();
        }
    }

    private void event() {
        mSideBar.setOnTouchingLetterChangedListener(new SideBar.OnTouchingLetterChangedListener() {
            @Override
            public void onTouchingLetterChanged(String s, int index) {
                txToast.setText(s + "");
                if (s.equals("当前") || s.equals("热门")) {
                    mListview.setSelection(0);
                } else {
                    int position = sortAdapter.getPositionForSection(s.charAt(0));
                    if (position != -1) {
                        mListview.setSelection(position + 1);
                    }
                }

            }
        });


        edSearch.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {

            }

            @Override
            public void afterTextChanged(Editable s) {

                String conent = edSearch.getText().toString();
                if (!AppUtil.isEmpty(conent)) {
                    mListview.removeHeaderView(mHeaderView);
                    search(conent);
                } else {
                    mListview.removeHeaderView(mHeaderView);
                    mListview.addHeaderView(mHeaderView);
                    sortAdapter.updateListView(cityEntities);
                }

            }
        });
    }


    private void search(String content) {
        searchEntities.clear();
        for (CityEntity entity : cityEntities) {
            if (entity.getName().contains(content) || entity.getPinyin().contains(content.toLowerCase())) {
                searchEntities.add(entity);
            }
        }
        sortAdapter.updateListView(searchEntities);
    }

    private void httpData() {
        LoadDialog.showDialog(this);
        CityDictionaryRepository.getInstance(this).getCityList(new OnCacheRequestFinish<CityData>() {
            @Override
            public void onSuccess(CityData data, boolean fromCache) {
                mHeaderView.setData(data.getNewsite());
                setData(data.getSite());
                sortAdapter.updateListView(cityEntities);
            }

            @Override
            public void onError(Exception ex) {
            }

            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }
        });

    }


    private void setData(List<CityEntity> allgroup) {
        CityEntity cr;
        String letter = "";
        for (int i = 0; i < allgroup.size(); i++) {
            CityEntity cityEntity = allgroup.get(i);
            String myLeeter = cityEntity.getInitial();
            String pinying = cityEntity.getPinyin().replaceAll(" ", "").toLowerCase();
            cityEntity.setPinyin(pinying);
            if (!letter.equals(myLeeter)) {
                cr = new CityEntity();
                cr.setName(myLeeter);
                cr.setMyType(1);
                cr.setInitial(myLeeter);
                cr.setPinyin("0");
                cityEntities.add(cr);
                letter = myLeeter;
            }
            cityEntities.add(cityEntity);
        }
    }


    @OnClick(R.id.ll_back)
    public void onViewClicked() {

        finish();
    }

    public class MyLocationListenner implements BDLocationListener {

        @Override
        public void onReceiveLocation(final BDLocation location) {
            if (location == null || location.getLocType() == BDLocation.TypeServerError) {
                mHeaderView.setLocation("定位失败");
                return;
            }
            if (!TextUtils.isEmpty(location.getCity())) {
                String city = location.getCity();
//                city = city.replace("市", "");
//                        cityEntity = AppUtil.getCity(city);
//                        if (cityEntity != null) {
//                            cityEntity.setAddre(location.getAddrStr());
//                            cityEntity.setLat(String.valueOf(location.getLatitude()));
//                            cityEntity.setLng(String.valueOf(location.getLongitude()));
//                        }
                locationCity = city;
                isLocation = true;
                mHeaderView.setLocation(city);
            } else {
                mHeaderView.setLocation("定位失败");
            }
            mLocClient.stop();

        }

    }

    private void initLocationClient() {

        mLocClient = new LocationService(getApplicationContext());
        mLocClient.registerListener(mLoactionListener);
        mLocClient.start();
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        if (mLocClient != null) {
            mLocClient.unregisterListener(mLoactionListener);
            mLocClient.stop();
        }

    }

}
