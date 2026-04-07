package com.linzi.xiguwen.ui;

import android.os.Bundle;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.View;
import android.widget.TextView;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.Dengjichu2Adapter;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.RegistryOfMarriageBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.MsgLoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.lljjcoder.Interface.OnCityItemClickListener;
import com.lljjcoder.bean.DistrictBean;
import com.lljjcoder.bean.ProvinceBean;
import com.lljjcoder.citywheel.CityConfig;
import com.lljjcoder.style.citypickerview.CityPickerView;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class HunYinDengjiChu2Activity extends BaseActivity {

    @BindView(R.id.tv_select_city)
    TextView tvSelectCity;
    @BindView(R.id.recycle)
    RecyclerView recycle;

    Dengjichu2Adapter adapter;
    private String mProvince;
    private String mCity;
    private List<RegistryOfMarriageBean> mDatas;
    private final CityPickerView mPicker=new CityPickerView();
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_hun_yin_dengji_chu2);
        ButterKnife.bind(this);
        mPicker.init(this);
    }

    @Override
    protected void initData() {
        setTitle("婚礼登记处");
        setBack();
        LinearLayoutManager manager=new LinearLayoutManager(mContext);
        recycle.setLayoutManager(manager);
        adapter = new Dengjichu2Adapter(this, new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int postion) {
            }
        });
        adapter.setOnMapClickListener(new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int postion) {
                RegistryOfMarriageBean data = mDatas.get(postion);
                MapActivity.startActivity(HunYinDengjiChu2Activity.this, data.getTitle(), mCity, data.getAddress());
            }
        });
        recycle.setAdapter(adapter);
    }

    private void requestNetData(String province, String city){
        MsgLoadDialog.showDialog(this, "查询中...");
        ApiManager.getRegistryOfMarriage(province, city, new OnRequestFinish<BaseBean<List<RegistryOfMarriageBean>>>() {
            @Override
            public void onFinished() {
                MsgLoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<List<RegistryOfMarriageBean>> data) {
                mDatas = data.getData();
                adapter.setData(data.getData());
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
                adapter.setData(null);
            }
        });
    }


    @OnClick({R.id.tv_select_city, R.id.btn_search})
    public void onClick(View view) {
        switch (view.getId()){
            case R.id.tv_select_city:
                selectCity();
                break;
            case R.id.btn_search:
                if(mProvince == null || mCity == null){
                    NToast.show("请先选择地区");
                    return;
                }
                requestNetData(mProvince, mCity);
                break;
        }
    }


    private void selectCity() {
        CityConfig cityConfig = new CityConfig.Builder().build();
        mPicker.setConfig(cityConfig);

//监听选择点击事件及返回结果
        mPicker.setOnCityItemClickListener(new OnCityItemClickListener() {
            @Override
            public void onSelected(ProvinceBean province, com.lljjcoder.bean.CityBean cityBean, DistrictBean district) {
                mProvince = province.getName();
                mCity = cityBean.getName();
                tvSelectCity.setText(mProvince+"/" + mCity);
            }

            @Override
            public void onCancel() {
                com.lljjcoder.style.citylist.Toast.ToastUtils.showLongToast(mContext, "已取消");
            }
        });

        //显示
        mPicker.showCityPicker( );

    }
}
