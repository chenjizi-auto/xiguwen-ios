package com.linzi.xiguwen.ui;

import android.content.Context;
import android.content.Intent;
import android.graphics.drawable.ColorDrawable;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.CompoundButton;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.PopupWindow;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.MyDateBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.view.ScrollerDatePicker;
import com.linzi.xiguwen.view.dateview.ChooseDatePop;
import com.lljjcoder.Interface.OnCityItemClickListener;
import com.lljjcoder.bean.CityBean;
import com.lljjcoder.bean.DistrictBean;
import com.lljjcoder.bean.ProvinceBean;
import com.lljjcoder.citywheel.CityConfig;
import com.lljjcoder.style.citylist.Toast.ToastUtils;
import com.lljjcoder.style.citypickerview.CityPickerView;
import com.lljjcoder.style.citythreelist.ProvinceActivity;

import org.json.JSONException;
import org.json.JSONObject;
import org.xutils.common.Callback;

import java.util.ArrayList;
import java.util.Calendar;

import butterknife.BindView;
import butterknife.ButterKnife;

public class GetSuggestActivity extends BaseActivity implements Callback.CommonCallback<String> {

    @BindView(R.id.tv_num)
    TextView tvNum;
    @BindView(R.id.ed_data)
    EditText edData;
    @BindView(R.id.cb_nodate)
    CheckBox cbNodate;
    @BindView(R.id.ed_price)
    EditText edPrice;
    @BindView(R.id.ed_location)
    TextView edLocation;
    @BindView(R.id.ed_phone)
    EditText edPhone;
    @BindView(R.id.ed_ps)
    EditText edPs;
    @BindView(R.id.bt_submit)
    Button btSubmit;
    @BindView(R.id.ll_parent)
    LinearLayout llParent;

    int year = 0, month = 0, day = 0;
    int tomonth = 0;
    int toyear = 0;
    int today = 0;
    private String cityid;
    private String contenta;
    private String countyid;
    private String datepicker = null;
    private String mobile;
    private String price;
    private String provinceid;
    private final CityPickerView mPicker=new CityPickerView();
    Context mContext;

    String provence, city, county;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        mPicker.init(this);
        setContentView(R.layout.activity_get_suggest);
        ButterKnife.bind(this);
        mContext = this;
        getpeoplenum();
    }

    @Override
    protected void initData() {
        setTitle("免费获取方案");
        setBack();

        Calendar calendar = Calendar.getInstance();
        year = calendar.get(Calendar.YEAR);
        month = (calendar.get(Calendar.MONTH) + 1);
        day = calendar.get(Calendar.DAY_OF_MONTH);
        tomonth = month;
        toyear = year;
        today = day;

        edData.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                //selectDate();
                createChooseTimePop(llParent);
            }
        });
        btSubmit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (!isNull()) {
                    submitPost();
                } else {
                    NToast.show("请完善所有信息再提交！");
                }
            }
        });
        edLocation.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                selectCity();
            }
        });
        cbNodate.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton compoundButton, boolean b) {
                if (b) {
                    datepicker = null;
                    edData.setText("请选择婚礼时间");
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
            public void onSelected(ProvinceBean province, CityBean city, DistrictBean district) {
                provence = province.getName();
                GetSuggestActivity.this.city = city.getName();
                county = district.getName();
                edLocation.setText(provence + city.getName() +district.getName());
                provinceid = province.getId();
                cityid = city.getId();
                countyid = district.getId();
            }

            @Override
            public void onCancel() {
                ToastUtils.showLongToast(mContext, "已取消");
            }
        });

        //显示
        mPicker.showCityPicker( );

    }

    private void selectDate() {
        ArrayList<MyDateBean> year_list = new ArrayList<>();
        ArrayList<MyDateBean> month_list = new ArrayList<>();
        final ArrayList<MyDateBean> day_list = new ArrayList<>();
        //final ArrayList<MyDateBean> when_list = new ArrayList<>();
        MyDateBean mBean;
        int years = 0;
        int year_tag = 0;
        int month_tag = 0;
        int day_tag = 0;
        for (int x = 0; x < 50; x++) {
            years = 2000 + x;
            mBean = new MyDateBean();
            mBean.setId(x);
            mBean.setDate("" + years);
            year_list.add(mBean);
            if (years == year) {
                year_tag = x;
            }
        }
        for (int x = 0; x < 12; x++) {
            mBean = new MyDateBean();
            mBean.setId(x);
            mBean.setDate("" + (x + 1));
            month_list.add(mBean);
            if ((x + 1) == month) {
                month_tag = x;
            }
        }

        int max_day_num = getDaysByYearMonth(year, month);
        for (int x = 0; x < max_day_num; x++) {
            mBean = new MyDateBean();
            mBean.setId(x);
            mBean.setDate("" + (x + 1));
            day_list.add(mBean);
            if ((x + 1) == day) {
                day_tag = x;
            }
        }
//        for (int x = 0; x < 4; x++) {
//            mBean = new MyDateBean();
//            mBean.setId(x);
//            switch (x) {
//                case 0:
//                    mBean.setDate("上午");
//                    break;
//                case 1:
//                    mBean.setDate("中午");
//                    break;
//                case 2:
//                    mBean.setDate("下午");
//                    break;
//                case 3:
//                    mBean.setDate("晚上");
//                    break;
//            }
//            when_list.add(mBean);
//        }
        final PopupWindow pop = new PopupWindow(mContext);
        View view = LayoutInflater.from(mContext).inflate(R.layout.pop_richeng_select_date_layout, null);
        final ViewHolder vh = new ViewHolder(view);
        vh.llWhen.setVisibility(View.GONE);
        vh.tvClose.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                pop.dismiss();
            }
        });
        vh.tvSubmit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                year = Integer.valueOf(vh.pickYear.getSelectedText());
                month = Integer.valueOf(vh.pickMonth.getSelectedText());
                day = Integer.valueOf(vh.pickDay.getSelectedText());
                String mm = "";
                String dd = "";
                if (month < 10) {
                    mm = "0" + month;
                } else {
                    mm = "" + month;
                }
                if (day < 10) {
                    dd = "0" + day;
                } else {
                    dd = "" + day;
                }

                int y = Integer.valueOf(vh.pickYear.getSelectedText());
                int m = Integer.valueOf(vh.pickMonth.getSelectedText());
                int d = Integer.valueOf(vh.pickDay.getSelectedText());
                if (y < toyear) {
                    NToast.show("不能选择过去的日期");
                    return;
                }
                if (m < (tomonth)) {
                    if (y <= toyear) {
                        NToast.show("不能选择过去的日期");
                        return;
                    }
                }
                if (d < today) {
                    if (m <= (tomonth)) {
                        if (y <= toyear) {
                            NToast.show("不能选择过去的日期");
                            return;
                        }
                    }
                }

                edData.setText(year + "-" + mm + "-" + dd);
                datepicker = year + "-" + mm + "-" + dd;
                if (cbNodate.isChecked()) {
                    cbNodate.setChecked(false);
                }
                pop.dismiss();
            }
        });
        vh.pickYear.setData(year_list);
        vh.pickMonth.setData(month_list);
        vh.pickDay.setData(day_list);
        //vh.pickWhen.setData(when_list);

        vh.pickYear.setDefault(year_tag);
        vh.pickMonth.setDefault(month_tag);
        vh.pickDay.setDefault(day_tag);

        vh.pickYear.setOnSelectListener(new ScrollerDatePicker.OnSelectListener() {
            @Override
            public void endSelect(int id, String text) {
                year = Integer.valueOf(text);
            }

            @Override
            public void selecting(int id, String text) {
            }
        });
        final int finalDay_tag = day_tag;
        vh.pickMonth.setOnSelectListener(new ScrollerDatePicker.OnSelectListener() {
            @Override
            public void endSelect(int id, String text) {
                month = Integer.valueOf(text);
                ArrayList<MyDateBean> list = setDay();
                vh.pickDay.setData(list);
                if (month == tomonth) {
                    vh.pickDay.setDefault(finalDay_tag);
                } else {
                    vh.pickDay.setDefault(0);
                }
            }

            @Override
            public void selecting(int id, String text) {
            }
        });

        // 设置弹出窗体可点击
        pop.setFocusable(true);
        int w = this.getWindowManager().getDefaultDisplay().getWidth();
        int h = (this.getWindowManager().getDefaultDisplay().getHeight() / 2);
        pop.setWidth(w);
        pop.setHeight(h);
        // 实例化一个ColorDrawable颜色为半透明
        ColorDrawable dw = new ColorDrawable(0xffff0000);
        // 设置弹出窗体的背景
        pop.setBackgroundDrawable(dw);
        // 设置弹出窗体显示时的动画，从底部向上弹出
        pop.setAnimationStyle(R.style.AnimationPreview);
        pop.setContentView(view);
        pop.update();
        pop.showAtLocation(llParent, Gravity.BOTTOM | Gravity.CENTER_HORIZONTAL, 0, 0);
        lightoff(true);
        pop.setOnDismissListener(new PopupWindow.OnDismissListener() {
            @Override
            public void onDismiss() {
                lightoff(false);
            }
        });
    }

    private ArrayList<MyDateBean> setDay() {
        ArrayList<MyDateBean> list = new ArrayList<>();
        int max_day_num = getDaysByYearMonth(year, month);
        MyDateBean mBean;
        for (int x = 0; x < max_day_num; x++) {
            mBean = new MyDateBean();
            mBean.setId(x);
            mBean.setDate("" + (x + 1));
            list.add(mBean);
        }
        return list;
    }

    /**
     * 根据年 月 获取对应的月份 天数
     */
    public int getDaysByYearMonth(int year, int month) {

        Calendar a = Calendar.getInstance();
        a.set(Calendar.YEAR, year);
        a.set(Calendar.MONTH, month - 1);
        a.set(Calendar.DATE, 1);
        a.roll(Calendar.DATE, -1);
        int maxDate = a.get(Calendar.DATE);
        return maxDate;
    }

    public void lightoff(boolean isoff) {
        WindowManager.LayoutParams lp = getWindow().getAttributes();
        if (isoff) {
            lp.alpha = 0.3f;
        } else {
            lp.alpha = 1f;
        }
        getWindow().setAttributes(lp);
    }

    @Override
    public void onSuccess(String result) {
        NToast.log(mContext, result);
        try {
            JSONObject jsonObject = new JSONObject(result);
            if (!jsonObject.isNull("data")) {
                tvNum.setText(jsonObject.getInt("data") + "位");
            }
        } catch (JSONException e) {
            com.linzi.xiguwen.utils.LogUtil.printStackTrace(e);
        }
    }

    @Override
    public void onError(Throwable ex, boolean isOnCallback) {

    }

    @Override
    public void onCancelled(CancelledException cex) {

    }

    @Override
    public void onFinished() {
        LoadDialog.CancelDialog();
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
        @BindView(R.id.ll_when)
        LinearLayout llWhen;

        ViewHolder(View view) {
            ButterKnife.bind(this, view);
        }
    }

    //初始化人数
    private void getpeoplenum() {
        new ApiManager().getCasePeopleNum(this);
    }

    //判断预算是否为空
    private boolean priceIsNull() {
        if (!TextUtils.isEmpty(edPrice.getText().toString())) {
            price = edPrice.getText().toString();
            return false;
        } else {
            return true;
        }
    }

    //判断联系电话是否为空
    private boolean mobileIsNull() {
        if (!TextUtils.isEmpty(edPhone.getText().toString())) {
            mobile = edPhone.getText().toString();
            return false;
        } else {
            return true;
        }
    }

    //判断地址是否为空
    private boolean addresssIsNull() {
        if (!TextUtils.isEmpty(edLocation.getText().toString())) {
            return false;
        } else {
            return true;
        }
    }

    //提交前校验非空项
    private boolean isNull() {
        if (!priceIsNull() && !mobileIsNull() && !addresssIsNull()) {
            return false;
        } else {
            return true;
        }
    }

    //提交
    private void submitPost() {
        contenta = edPs.getText().toString();
        new ApiManager().postUserCase(cityid, contenta, countyid, datepicker, mobile, price, provence, new CommonCallback<String>() {
            @Override
            public void onSuccess(String result) {
                NToast.log(mContext, result);
                try {
                    JSONObject jsonObject = new JSONObject(result);
                    if (!jsonObject.isNull("message")) {
                        NToast.show(jsonObject.getString("message"));
                        finish();
                    }
                } catch (JSONException e) {
                    com.linzi.xiguwen.utils.LogUtil.printStackTrace(e);
                }
            }

            @Override
            public void onError(Throwable ex, boolean isOnCallback) {

            }

            @Override
            public void onCancelled(CancelledException cex) {

            }

            @Override
            public void onFinished() {

            }
        });
    }

    //创建时间选择器
    private void createChooseTimePop(View llParent) {
        ChooseDatePop chooseDatePop = new ChooseDatePop(mContext, null, false);
        chooseDatePop.setShowWithView(llParent);
        chooseDatePop.setListener(new ChooseDatePop.ReturnTimeStr() {
            @Override
            public void onSubmit(String string, String date, int whenid) {
                // setShowWithView(showView);
                edData.setText(string);
                GetSuggestActivity.this.datepicker = date;
            }
        });
    }

}
