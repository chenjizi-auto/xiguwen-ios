package com.linzi.xiguwen.ui;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.TextView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.MineNeedBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.AppUtil;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.view.ScrollerDatePicker;
import com.lljjcoder.Interface.OnCityItemClickListener;
import com.lljjcoder.bean.DistrictBean;
import com.lljjcoder.bean.ProvinceBean;
import com.lljjcoder.citywheel.CityConfig;
import com.lljjcoder.style.citypickerview.CityPickerView;
import com.lljjcoder.style.citythreelist.CityBean;
import com.lljjcoder.style.citythreelist.ProvinceActivity;
import butterknife.BindView;
import butterknife.ButterKnife;

public class ForNeedActivity extends BaseActivity {

    Context mContext;

    String provence, city, county;
    @BindView(R.id.ed_data)
    EditText edData;
    @BindView(R.id.ed_need_title)
    EditText edNeedTitle;
    @BindView(R.id.ed_price)
    EditText edPrice;
    @BindView(R.id.ed_location)
    TextView edLocation;
    @BindView(R.id.ed_ps)
    EditText edPs;
    @BindView(R.id.cb_phone)
    CheckBox cbPhone;
    @BindView(R.id.cb_chat)
    CheckBox cbChat;
    @BindView(R.id.bt_submit)
    Button btSubmit;
    @BindView(R.id.ll_parent)
    LinearLayout llParent;

    int type=1;//  需求类型 1.婚庆  2.商城

    private MineNeedBean mData;
    private final CityPickerView mPicker=new CityPickerView();
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_for_need);
        ButterKnife.bind(this);
        mContext = this;
        mPicker.init(this);
    }

    @Override
    protected void initData() {
        mData = (MineNeedBean) getIntent().getSerializableExtra("data");
        if(mData == null){
            setTitle("发布需求");
        }else{
            setTitle("编辑需求");
        }
        setBack();

        edLocation.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                AppUtil.clearInputMethod(view);
                selectCity();
            }
        });
//        edData.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View v) {
//                AppUtil.clearInputMethod(v);
//                new PopChooserUtils(ForNeedActivity.this)
//                        .setChooseData(new String[]{"婚庆","商城"})
//                        .setListenner(new PopChooserUtils.ItemClickListener() {
//                            @Override
//                            public void popItemClick(View view, int position) {
//                                type=position+1;
//                                switch(position){
//                                    case 0:
//                                        edData.setText("婚庆");
//                                    break;
//                                    case 1:
//                                        edData.setText("商城");
//                                    break;
//                                }
//                            }
//                        })
//                        .show(llParent);
//            }
//        });
        btSubmit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if(type==0){
                    NToast.show("请选择类型");
                    return;
                }
                if(edNeedTitle.getText().toString().isEmpty()){
                    NToast.show("请输入标题");
                    return;
                }
                if(provence==null){
                    NToast.show("请选择城市");
                    return;
                }
                if(edPrice.getText().toString().isEmpty()){
                    NToast.show("请输入价格");
                    return;
                }
                /*if(edPs.getText().toString().isEmpty()){
                    NToast.show("请输入其他介绍");
                    return;
                }*/
                addNeed();
            }
        });

        refreshView(mData);
    }

    private void refreshView(MineNeedBean data) {
        if(data != null){
            edNeedTitle.setText(data.getTitle());
            type = data.getType();
            if(type == 1){
                edData.setText("婚庆");
            }else{
                edData.setText("商城");
            }
            edPrice.setText(data.getPrice() + "");
            provence = data.getProvinceid();
            city = data.getCityid();
            county = data.getCountyid();
            if(provence != null && city != null && county != null){
                edLocation.setText(provence + city + county);
            }
            edPs.setText(data.getDetails());
            cbChat.setChecked(data.getOpenmessage() == 1);
            cbPhone.setChecked(data.getOpenphone() == 1);
        }
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
                edLocation.setText(provence + city + county);
            }

            @Override
            public void onCancel() {
                com.lljjcoder.style.citylist.Toast.ToastUtils.showLongToast(mContext, "已取消");
            }
        });

        //显示
        mPicker.showCityPicker( );

    }




    /**
     * 发布需求
     */
    private void addNeed(){
        LoadDialog.showDialog(mContext);
        if(mData == null){

            ApiManager.addNeed(type, edNeedTitle.getText().toString().trim(), edPrice.getText().toString().trim(), edPs.getText().toString().trim(), provence, city, county, cbChat.isChecked(), cbPhone.isChecked(), new OnRequestFinish<com.linzi.xiguwen.net.base.BaseBean<String>>() {
                @Override
                public void onFinished() {
                    LoadDialog.CancelDialog();
                }

                @Override
                public void onSuccess(com.linzi.xiguwen.net.base.BaseBean<String> data) {
                    NToast.show("发布成功");
                    finish();
                }

                @Override
                public void onError(Exception ex) {
                    NToast.show("发布失败，请重试");
                }
            });
        }else{
            ApiManager.editNeed(mData.getId(), type, edNeedTitle.getText().toString().trim(), edPrice.getText().toString().trim(), edPs.getText().toString().trim(), provence, city, county, cbChat.isChecked(), cbPhone.isChecked(), new OnRequestFinish<com.linzi.xiguwen.net.base.BaseBean<String>>() {
                @Override
                public void onFinished() {
                    LoadDialog.CancelDialog();
                }

                @Override
                public void onSuccess(com.linzi.xiguwen.net.base.BaseBean<String> data) {
                    NToast.show("修改成功");
                    setResult(RESULT_OK);
                    finish();
                }

                @Override
                public void onError(Exception ex) {
                    NToast.show("修改失败，请重试");
                }
            });
        }
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
}
