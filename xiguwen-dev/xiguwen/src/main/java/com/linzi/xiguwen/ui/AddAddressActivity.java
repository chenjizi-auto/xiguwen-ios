package com.linzi.xiguwen.ui;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.TextView;

import com.alibaba.fastjson.JSONObject;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.AddressEntity;
import com.linzi.xiguwen.net.OnRequestSubscribe;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.AppUtil;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;
import com.linzi.xiguwen.view.UISwitchButton;
import com.lljjcoder.Interface.OnCityItemClickListener;
import com.lljjcoder.bean.DistrictBean;
import com.lljjcoder.bean.ProvinceBean;
import com.lljjcoder.citywheel.CityConfig;
import com.lljjcoder.style.citypickerview.CityPickerView;
import com.lljjcoder.style.citythreelist.CityBean;
import com.lljjcoder.style.citythreelist.ProvinceActivity;
import com.luck.picture.lib.utils.ToastUtils;
import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class AddAddressActivity extends BaseActivity {

    @BindView(R.id.ed_name)
    EditText edName;
    @BindView(R.id.ed_phone)
    EditText edPhone;
    @BindView(R.id.ed_area)
    TextView edArea;
    @BindView(R.id.ed_details_address)
    EditText edDetailsAddress;
    @BindView(R.id.sb_button)
    UISwitchButton sbButton;


    private String provence = "";
    private String city = "";
    private String county = "";

    private String userName;
    private String mobile;
    private int hot;
    private String site;

    private int type;
    private String id;
    private final CityPickerView mPicker=new CityPickerView();
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        mPicker.init(this);
        setContentView(R.layout.activity_add_address);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        String data = getIntent().getStringExtra("data");
        if (data != null) {
            type = 1;
            setTitle("修改收货地址");
            AddressEntity addressEntity = JSONObject.parseObject(data, AddressEntity.class);

            id = addressEntity.getId();
            if (addressEntity.getUsername() != null) {
                edName.setText(addressEntity.getUsername());
            }
            if (addressEntity.getMobile() != null) {
                edPhone.setText(addressEntity.getMobile());
            }

            if (addressEntity.getProvince() != null)
                provence = addressEntity.getProvince();

            if (addressEntity.getCounty() != null) {
                county = addressEntity.getCounty();
            }
            if (addressEntity.getCity() != null) {
                city = addressEntity.getCity();
            }
            edArea.setText(provence + " " + city + " " + county);

            if (addressEntity.getHot() == 1) {
                sbButton.setChecked(true);
            }


            if (addressEntity.getSite()!=null){
                edDetailsAddress.setText(addressEntity.getSite());
            }
        }else {
            setTitle("新增收货地址");
        }



        setBack();
        setRight("保存", new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                userName = edName.getText().toString().trim();
                mobile = edPhone.getText().toString().trim();
                site = edDetailsAddress.getText().toString().trim();
                hot = sbButton.isChecked() ? 1 : 0;
                if (AppUtil.isEmpty(userName) || AppUtil.isEmpty(mobile) || AppUtil.isEmpty(site) || AppUtil.isEmpty(provence)) {
                    ToastUtils.showToast(mContext, "请填写完整数据");
                    return;
                }
                if (type == 1) {
                    httpUpdate();
                } else {
                    httpAdd();
                }

            }
        });
    }

    private void selectCity() {
        CityConfig cityConfig = new CityConfig.Builder().build();
        mPicker.setConfig(cityConfig);

//监听选择点击事件及返回结果
        mPicker.setOnCityItemClickListener(new OnCityItemClickListener() {
            @Override
            public void onSelected(ProvinceBean province, com.lljjcoder.bean.CityBean cityBean, DistrictBean district) {
                provence = province.getName();
                city = cityBean.getName();
                county = district.getName();
//                edLocation.setText(citySelected[0] + citySelected[1] + citySelected[2]);
                edArea.setText(provence + " " + city + " " + county);
            }

            @Override
            public void onCancel() {
                com.lljjcoder.style.citylist.Toast.ToastUtils.showLongToast(mContext, "已取消");
            }
        });

        //显示
        mPicker.showCityPicker( );

    }


    @OnClick({R.id.ed_area})
    public void onViewClicked(View view) {
        switch (view.getId()) {
            case R.id.ed_area:
                selectCity();
                break;
        }
    }


    private void httpAdd() {
        LoadDialog.showDialog(this);
        ApiManager.addressAdd(city, county, hot + "", mobile, provence, site, userName, new OnRequestSubscribe<BaseBean>() {
            @Override
            public void onSuccess(BaseBean data) {
                LoadDialog.CancelDialog();
                ToastUtils.showToast(mContext, "添加成功");
                finish();
                EventBusUtil.sendEvent(new Event(EventCode.ADDRESS_ADD, 0));
            }

            @Override
            public void onError(Exception ex) {
                LoadDialog.CancelDialog();
                ToastUtils.showToast(mContext, ex.getMessage());
            }
        });
    }

    private void httpUpdate() {
        ApiManager.addressUpdate(id, city, county, hot + "", mobile, provence, site, userName, new OnRequestSubscribe<BaseBean>() {
            @Override
            public void onSuccess(BaseBean data) {
                LoadDialog.CancelDialog();
                ToastUtils.showToast(mContext, "修改成功");
                finish();
                EventBusUtil.sendEvent(new Event(EventCode.ADDRESS_ADD, 0));
            }

            @Override
            public void onError(Exception ex) {
                LoadDialog.CancelDialog();
                ToastUtils.showToast(mContext, ex.getMessage());
            }
        });
    }
}
