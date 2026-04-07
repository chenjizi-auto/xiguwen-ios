package com.linzi.xiguwen.ui;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.text.TextUtils;
import android.view.View;
import android.widget.Button;
import android.widget.CompoundButton;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.MyGradeBean;
import com.linzi.xiguwen.utils.CalendarUtils;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.TimeSeletctUtil;
import com.linzi.xiguwen.utils.TimeUtils;
import com.linzi.xiguwen.view.UISwitchButton;

import java.text.SimpleDateFormat;
import java.util.Calendar;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class CaiPaiTixingActivity extends BaseActivity {

    @BindView(R.id.ed_hunli_time)
    TextView tvHunliTime;
    @BindView(R.id.ed_address)
    EditText edAddress;
    @BindView(R.id.tv_date)
    TextView tvDate;
    @BindView(R.id.ll_date)
    LinearLayout llDate;
    @BindView(R.id.ed_beizhu)
    EditText edBeizhu;
    @BindView(R.id.tv_notice_time_1)
    TextView tvNoticeTime1;
    @BindView(R.id.sb_notice_1)
    UISwitchButton sbNotice1;
    @BindView(R.id.tv_notice_time_2)
    TextView tvNoticeTime2;
    @BindView(R.id.sb_notice_2)
    UISwitchButton sbNotice2;
    @BindView(R.id.bt_submit)
    Button btSubmit;
    @BindView(R.id.ll_parent)
    LinearLayout llParent;

    int year =0,month =0,day =0,hours =0,m =0; // 时间
    int hyear=0,hmonth=0,hday=0,hhours=0,hm=0; // 婚礼时间
    int year1=0,month1=0,day1=0,hours1=0,m1=0; // 提醒时间1
    int year2=0,month2=0,day2=0,hours2=0,m2=0; // 提醒时间2

    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
    private MyGradeBean.Grade.RemindData mData;

    Handler mHandler=new Handler(){
        @Override
        public void handleMessage(Message msg) {
            super.handleMessage(msg);
//            if(msg.what==0){
//                new TimeSeletctUtil(CaiPaiTixingActivity.this)
//                        .isWhen(true)
//                        .setListener(new TimeSeletctUtil.getDataListener() {
//                            @Override
//                            public void getData(int y, int m, int d, String when) {
//
//                            }
//
//                            @Override
//                            public void getToday(int toyear, int tomonth, int today) {
//
//                            }
//
//                            @Override
//                            public void getHous(int h, int m) {
//                                hours1=h;
//                                m1=m;
//                                if(mContext!=null) {
//                                    new CalendarUtils(mContext).addCalendarEvent(year1+"-"+(month1+1)+"-"+day1+" "+hours1+":"+m1,"彩排提醒", Long.valueOf(TimeUtils.getTime2(year1+"-"+(month1+1)+"-"+day1+" "+hours1+":"+m1)));
//                                    tvNoticeTime1.setText((month1 + 1) + "月" + day1 + "日  " + hours1 + ":" + m1);
//                                }
//                            }
//                        }).getTime(llParent);
//            }else{
//
//            }
            final int what = msg.what;
            new TimeSeletctUtil(CaiPaiTixingActivity.this)
                    .isWhen(true)
                    .setOnCancelListener(new TimeSeletctUtil.OnCancelListener() {
                        @Override
                        public void onCancel(TimeSeletctUtil utils) {
                            if(what == 0){
                                Calendar calendar = Calendar.getInstance();
                                calendar.set(year1, month1, day1, hours1, m1);
                                tvNoticeTime1.setText(formatDate(calendar));
                            }else if(what == 1){
                                Calendar calendar = Calendar.getInstance();
                                calendar.set(year2, month2, day2, hours2, m2);
                                tvNoticeTime2.setText(formatDate(calendar));
                            }
                        }
                    })
                    .setListener(new TimeSeletctUtil.getDataListener() {
                        @Override
                        public void getData(int y, int m, int d, String when) {

                        }

                        @Override
                        public void getToday(int toyear, int tomonth, int today) {

                        }

                        @Override
                        public void getHous(int h, int m) {
                            Calendar calendar;
                            switch (what){
                                case 0: // 提醒时间1
                                    hours1=h;
                                    m1 = m;
                                    calendar = Calendar.getInstance();
                                    calendar.set(year1, month1, day1, hours1, m1);
                                    tvNoticeTime1.setText(formatDate(calendar));
                                    break;
                                case 1: // 提醒时间2
                                    hours2=h;
                                    m2=m;
                                    calendar = Calendar.getInstance();
                                    calendar.set(year2, month2, day2, hours2, m2);
                                    tvNoticeTime2.setText(formatDate(calendar));
                                    break;
                                case 2: // 婚礼时间
                                    hhours = h;
                                    hm = m;
                                    calendar = Calendar.getInstance();
                                    calendar.set(hyear, hmonth, hday, hhours, hm);
                                    tvHunliTime.setText(formatDate(calendar));
                                    break;
                                case 3: // 彩排时间
                                    hours = h;
                                    CaiPaiTixingActivity.this.m = m;
                                    calendar = Calendar.getInstance();
                                    calendar.set(year, month, day, hours, m);
                                    tvDate.setText(formatDate(calendar));
                                    break;
                            }

                        }
                    }).getTime(llParent);
        }
    };
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_cai_pai_tixing);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        setTitle("彩排提醒");
        setBack();
        mData = (MyGradeBean.Grade.RemindData) getIntent().getSerializableExtra("data");

        Calendar calendar = Calendar.getInstance();
        year = calendar.get(Calendar.YEAR);
        month = calendar.get(Calendar.MONTH);
        day = calendar.get(Calendar.DAY_OF_MONTH);
        hours = calendar.get(Calendar.HOUR_OF_DAY);
        m = calendar.get(Calendar.MINUTE);

        tvDate.setText(formatDate(calendar));

        refreshView(mData);
        sbNotice1.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                if(isChecked){
                    new TimeSeletctUtil(CaiPaiTixingActivity.this)
                            .isWhen(false)
                            .setOnCancelListener(new TimeSeletctUtil.OnCancelListener() {
                                @Override
                                public void onCancel(TimeSeletctUtil utils) {
                                    if(year1 == 0){
                                        //未选择日期
                                        sbNotice1.setChecked(false);
                                    }
                                }
                            })
                            .setListener(new TimeSeletctUtil.getDataListener() {
                                @Override
                                public void getData(int y, int m, int d, String when) {
                                    year1=y;
                                    month1=m;
                                    day1=d;
                                    mHandler.sendEmptyMessage(0);
                                }

                                @Override
                                public void getToday(int toyear, int tomonth, int today) {

                                }

                                @Override
                                public void getHous(int hour, int m) {

                                }
                            }).selectDate(llParent);
                }
            }
        });

        sbNotice2.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
                if(isChecked){
                    new TimeSeletctUtil(CaiPaiTixingActivity.this)
                            .isWhen(false)
                            .setOnCancelListener(new TimeSeletctUtil.OnCancelListener() {
                                @Override
                                public void onCancel(TimeSeletctUtil utils) {
                                    if(year2 == 0){
                                        //未选择日期
                                        sbNotice2.setChecked(false);
                                    }
                                }
                            })
                            .setListener(new TimeSeletctUtil.getDataListener() {
                                @Override
                                public void getData(int y, int m, int d, String when) {
                                    year2=y;
                                    month2=m;
                                    day2=d;
                                    mHandler.sendEmptyMessage(1);
                                }

                                @Override
                                public void getToday(int toyear, int tomonth, int today) {

                                }

                                @Override
                                public void getHous(int hour, int m) {

                                }
                            }).selectDate(llParent);
                }
            }
        });

    }

    private void refreshView(MyGradeBean.Grade.RemindData data){
        if(data != null){
            tvDate.setText(data.getShijian());
            tvHunliTime.setText(data.getHunlishijian());
            edAddress.setText(data.getDidian());
            edBeizhu.setText(data.getBeizhu());
            if(!TextUtils.isEmpty(data.getTixinshijian1())){
                tvNoticeTime1.setText(data.getTixinshijian1());
                sbNotice1.setChecked(true);
            }
            if(!TextUtils.isEmpty(data.getTixinshijian2())){
                tvNoticeTime2.setText(data.getTixinshijian2());
                sbNotice2.setChecked(true);
            }
        }
    }

    private String formatDate(Calendar calendar){
        // 获取周几
        String week = "";
        switch (calendar.get(Calendar.DAY_OF_WEEK)){
            case Calendar.SUNDAY:
                week = "周日";
                break;
            case Calendar.MONDAY:
                week = "周一";
                break;
            case Calendar.TUESDAY:
                week = "周二";
                break;
            case Calendar.WEDNESDAY:
                week = "周三";
                break;
            case Calendar.THURSDAY:
                week = "周四";
                break;
            case Calendar.FRIDAY:
                week = "周五";
                break;
            case Calendar.SATURDAY:
                week = "周六";
                break;
        }
//        return dateFormat.format(calendar.getTime()) + " " + week;
        return dateFormat.format(calendar.getTime());
    }


    @OnClick({R.id.ll_date, R.id.bt_submit, R.id.ll_hl_date})
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.ll_hl_date:
                new TimeSeletctUtil(CaiPaiTixingActivity.this)
                        .isWhen(false)
                        .setListener(new TimeSeletctUtil.getDataListener() {
                            @Override
                            public void getData(int y, int m, int d, String when) {
                                hyear=y;
                                hmonth=m;
                                hday=d;
                                mHandler.sendEmptyMessage(2);
//                                tvDate.setText(year+"年"+(month+1)+"月"+day+"日");
                            }

                            @Override
                            public void getToday(int toyear, int tomonth, int today) {

                            }

                            @Override
                            public void getHous(int hour, int m) {

                            }
                        }).selectDate(llParent);
                // 婚礼时间
                break;
            case R.id.ll_date:
                new TimeSeletctUtil(CaiPaiTixingActivity.this)
                        .isWhen(false)
                        .setListener(new TimeSeletctUtil.getDataListener() {
                            @Override
                            public void getData(int y, int m, int d, String when) {
                                year=y;
                                month=m;
                                day=d;
                                mHandler.sendEmptyMessage(3);
//                                tvDate.setText(year+"年"+(month+1)+"月"+day+"日");
                            }

                            @Override
                            public void getToday(int toyear, int tomonth, int today) {

                            }

                            @Override
                            public void getHous(int hour, int m) {

                            }
                        }).selectDate(llParent);
                break;
            case R.id.bt_submit:
                if(check()){
                    if(mData == null){
                        mData = new MyGradeBean.Grade.RemindData();
                        mData.setType(MyGradeBean.Grade.RemindData.TYPE_CAIPAI);
                    }
                    mData.setBeizhu(edBeizhu.getText().toString().trim());
                    mData.setDidian(edAddress.getText().toString().trim());
                    mData.setHunlishijian(tvHunliTime.getText().toString().trim());
                    mData.setShijian(tvDate.getText().toString().trim());
                    if(sbNotice1.isChecked()){
                        mData.setTixinshijian1(tvNoticeTime1.getText().toString().trim());
                    }else{
                        mData.setTixinshijian1("");
                    }
                    if(sbNotice2.isChecked()){
                        mData.setTixinshijian2(tvNoticeTime2.getText().toString().trim());
                    }else{
                        mData.setTixinshijian2("");
                    }

                    Intent intent = new Intent();
                    intent.putExtra("data", mData);
                    setResult(RESULT_OK, intent);
                    finish();
                }
                break;
        }
    }

    private boolean check(){
//        if(TextUtils.isEmpty(tvDate.getText().toString().trim())){
//            NToast.show("婚礼时间不能为空");
//            return false;
//        }
//        if(TextUtils.isEmpty(edAddress.getText().toString().trim())){
//            NToast.show("婚礼地点不能为空");
//            return false;
//        }
//        if(TextUtils.isEmpty(edBeizhu.getText().toString().trim())){
//
//        }
        return true;
    }
}
