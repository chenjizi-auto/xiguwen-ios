package com.linzi.xiguwen.ui;

import android.os.Bundle;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.View;
import android.widget.TextView;

import com.baidu.mapapi.search.sug.OnGetSuggestionResultListener;
import com.baidu.mapapi.search.sug.SuggestionResult;
import com.baidu.mapapi.search.sug.SuggestionSearch;
import com.baidu.mapapi.search.sug.SuggestionSearchOption;
import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.DengjichuAdapter;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.utils.NToast;
import com.lljjcoder.Interface.OnCityItemClickListener;
import com.lljjcoder.bean.DistrictBean;
import com.lljjcoder.bean.ProvinceBean;
import com.lljjcoder.citywheel.CityConfig;
import com.lljjcoder.style.citypickerview.CityPickerView;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class HunYinDengjiChuActivity extends BaseActivity {

    @BindView(R.id.tv_select_city)
    TextView tvSelectCity;
    @BindView(R.id.recycle)
    RecyclerView recycle;

    SuggestionSearch mSuggestionSearch;

    DengjichuAdapter adapter;

    List<SuggestionResult.SuggestionInfo> info;
    private final CityPickerView mPicker=new CityPickerView();
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        mPicker.init(this);
        setContentView(R.layout.activity_hun_yin_dengji_chu);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        setTitle("婚礼登记处");
        setBack();

        mSuggestionSearch = SuggestionSearch.newInstance();
        mSuggestionSearch.setOnGetSuggestionResultListener(listener);

        LinearLayoutManager manager=new LinearLayoutManager(mContext);
        recycle.setLayoutManager(manager);
    }

    OnGetSuggestionResultListener listener = new OnGetSuggestionResultListener() {
        public void onGetSuggestionResult(SuggestionResult res) {

            if (res == null || res.getAllSuggestions() == null) {
                NToast.show("暂无相关结果");

                return;
                //未找到相关结果
            } else {
                //获取在线建议检索结果
                if(info==null){
                    info=new ArrayList<>();
                }else{
                    info.clear();
                }
                info .addAll(res.getAllSuggestions());
                if(adapter==null) {
                    adapter = new DengjichuAdapter(mContext, new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
                        @Override
                        public void onItemClick(View view, int postion) {

                            if (info.get(postion).pt != null) {
                                NToast.log("位置信息", info.get(postion).pt.latitude + "," + info.get(postion).pt.longitude);

                            } else {
                                NToast.show("没有地理位置信息");
                            }
                        }
                    }, info);
                    recycle.setAdapter(adapter);
                }else{
                    adapter.notifyDataSetChanged();
                }
            }
        }
    };

    private void selectCity() {
        CityConfig cityConfig = new CityConfig.Builder()
                .setCityWheelType(CityConfig.WheelType.PRO_CITY_DIS)
                .build();
        cityConfig.setDefaultProvinceName("四川省");
        cityConfig.setDefaultCityName("成都市");
        mPicker.setConfig(cityConfig);

//监听选择点击事件及返回结果
        mPicker.setOnCityItemClickListener(new OnCityItemClickListener() {
            @Override
            public void onSelected(ProvinceBean province, com.lljjcoder.bean.CityBean cityBean, DistrictBean district) {
                tvSelectCity.setText(cityBean.getName()+"/"+district.getName());
                mSuggestionSearch.requestSuggestion((new SuggestionSearchOption())
                        .keyword("婚姻登记处")
                        .city(district.getName()));
            }

            @Override
            public void onCancel() {
                com.lljjcoder.style.citylist.Toast.ToastUtils.showLongToast(mContext, "已取消");
            }
        });

        //显示
        mPicker.showCityPicker( );

    }


    @OnClick(R.id.tv_select_city)
    public void onClick() {
        selectCity();
    }
}
