package com.linzi.xiguwen.ui;

import android.graphics.drawable.ColorDrawable;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.PopupWindow;
import android.widget.TextView;

import com.google.gson.Gson;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.CalendarAdapter;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.CalendarBean;
import com.linzi.xiguwen.bean.MyDateBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.CallBack;
import com.linzi.xiguwen.utils.Lunar;
import com.linzi.xiguwen.utils.MsgLoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.TimeSeletctUtil;
import com.linzi.xiguwen.view.MyGridView;
import com.linzi.xiguwen.view.ScrollerDatePicker;
import com.linzi.xiguwen.view.dateview.ChooseDatePop;

import org.xutils.common.Callback;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

public class GoodDayActivity extends BaseActivity implements CallBack.MainMenuClick {

    @BindView(R.id.tv_day)
    TextView tvDay;
    @BindView(R.id.iv_choose)
    ImageView ivChoose;
    @BindView(R.id.gv_date)
    MyGridView gvDate;
    @BindView(R.id.ll_parent)
    LinearLayout llParent;

    int year = 0000, month = 00, day = 00;
    int toyear = 0000, tomonth = 00, today = 00;
    List<CalendarBean> mCalendarList;
    CalendarBean mCalendarBean;
    CalendarAdapter mCalendarAdapter;

    SimpleDateFormat chineseDateFormat = new SimpleDateFormat(
            "yyyy年MM月dd日");

    Handler mHandler = new Handler() {
        @Override
        public void handleMessage(Message msg) {
            super.handleMessage(msg);
            switch (msg.what) {
                case 0:
                    tvDay.setText(year + "年" + (month + 1) + "月");
                    tvData.setText(year + "年" + (month + 1) + "月" + day + "日");
                    Calendar today = Calendar.getInstance();
                    try {
                        today.setTime(chineseDateFormat.parse(year + "年" + (month + 1) + "月" + day + "日"));
                        Lunar lunar = new Lunar(today);
                        tvLj.setText("农历  " + lunar.toDays() + "  " + getDayOfWeekByDate(year + "-" + (month + 1) + "-" + day));
                    } catch (ParseException e) {
                        com.linzi.xiguwen.utils.LogUtil.printStackTrace(e);
                    }

                    setMonthData();
                    break;
            }
        }
    };
    @BindView(R.id.tv_data)
    TextView tvData;
    @BindView(R.id.tv_lj)
    TextView tvLj;
    @BindView(R.id.tv_jiri)
    TextView tvJiri;
    @BindView(R.id.tv_jinji)
    TextView tvJinji;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_good_day);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        setTitle("黄道吉日");
        setBack();

        Calendar calendar = Calendar.getInstance();
        toyear = calendar.get(Calendar.YEAR);
        tomonth = calendar.get(Calendar.MONTH);
        today = calendar.get(Calendar.DAY_OF_MONTH);
        year = toyear;
        month = tomonth;
        day = today;

        setCalendar();
        requestNetData();
        ivChoose.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
//                choosedate();
                showDate();
            }
        });
    }

    private void requestNetData() {
        MsgLoadDialog.showDialog(this, "加载中...");
        ApiManager.getLuckDayList(year + "-" + (month + 1) + "-" + day, new Callback.CommonCallback<String>() {
            @Override
            public void onSuccess(String result) {
                Gson gson = new Gson();
                LuckDay luckDay = gson.fromJson(result, LuckDay.class);
                if (luckDay != null) {
                    if (luckDay.getError_code() == 0) {
                        //请求成功
                        tvJiri.setText(luckDay.getResult().getData().getSuit().replace(".", "  "));
                        tvJinji.setText(luckDay.getResult().getData().getAvoid().replace(".", "  "));
                    } else {
                        NToast.show(luckDay.getReason());
                    }
                }
            }

            @Override
            public void onError(Throwable ex, boolean isOnCallback) {
                NToast.show("网络请求失败！");
            }

            @Override
            public void onCancelled(CancelledException cex) {

            }

            @Override
            public void onFinished() {
                MsgLoadDialog.CancelDialog();
            }
        });
    }


    private void setCalendar() {

        if (mCalendarList == null) {
            mCalendarList = new ArrayList<>();
        }
        if (mCalendarAdapter == null) {
            mCalendarAdapter = new CalendarAdapter(mContext, mCalendarList, this, year, month);
            gvDate.setAdapter(mCalendarAdapter);
        } else {
            mCalendarAdapter.setData(mCalendarList, year, month);
        }

        mHandler.sendEmptyMessage(0);
    }

    private void setMonthData() {
        int day_num = getDaysByYearMonth(year, (month + 1));
        String fir_day_week = getDayOfWeekByDate(year + "-" + (month + 1) + "-1");
        NToast.log("本月天数", "" + day_num);
        NToast.log("本月天数", "" + day_num);
        NToast.log("本月第一天是星期", fir_day_week);
        String[] weeks = {"日", "一", "二", "三", "四", "五", "六"};
        int index_no_num = 0;
        for (int x = 0; x < weeks.length; x++) {
            if (fir_day_week.contains(weeks[x])) {
                index_no_num = x;
            }
        }
        mCalendarList.clear();
        int index_date = 0;
        for (int j = 0; j < (day_num + index_no_num); j++) {
            if (j < index_no_num) {
                mCalendarBean = new CalendarBean();
                mCalendarBean.setId(j);
                mCalendarBean.setData("");
                mCalendarList.add(mCalendarBean);
            } else {
                mCalendarBean = new CalendarBean();
                mCalendarBean.setId(j);
                int calendar_day = (j - index_no_num + 1);
                mCalendarBean.setData("" + calendar_day);
                if (toyear == year && tomonth == month && today == calendar_day) {
                    mCalendarBean.setChecked(true);
                } else {
                    mCalendarBean.setChecked(false);
                }
                mCalendarList.add(mCalendarBean);
            }
        }
        mCalendarAdapter.notifyDataSetChanged();
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

    /**
     * 根据日期 找到对应日期的 星期
     */
    public static String getDayOfWeekByDate(String date) {
        String dayOfweek = "-1";
        try {
            SimpleDateFormat myFormatter = new SimpleDateFormat("yyyy-MM-dd");
            Date myDate = myFormatter.parse(date);
            SimpleDateFormat formatter = new SimpleDateFormat("E");
            String str = formatter.format(myDate);
            dayOfweek = str;

        } catch (Exception e) {
            com.linzi.xiguwen.utils.LogUtil.i("SystemOut", String.valueOf("错误!"));
        }
        return dayOfweek;
    }


    private void showDate() {
//        new TimeSeletctUtil(this).isDay(false).setListener(new TimeSeletctUtil.getDataListener() {
//            @Override
//            public void getData(int y, int m, int d, String w) {
//                year = y;
//                month = m;
//                setCalendar();
//            }
//
//            @Override
//            public void getToday(int toyear, int tomonth, int today) {
//
//            }
//
//            @Override
//            public void getHous(int hour, int m) {
//
//            }
//        }).selectDate(llParent);
        createChooseTimePop(llParent);
    }

    private void choosedate() {
        ArrayList<MyDateBean> year_list = new ArrayList<>();
        ArrayList<MyDateBean> month_list = new ArrayList<>();
        MyDateBean mBean;
        int years = 0;
        int year_tag = 0;
        int month_tag = 0;
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
            if ((x) == month) {
                month_tag = x;
            }
        }
        final PopupWindow pop = new PopupWindow(mContext);
        View view = LayoutInflater.from(mContext).inflate(R.layout.pop_date_picker, null);
        final ViewHolder vh = new ViewHolder(view);

        vh.pickYear.setData(year_list);
        vh.pickMonth.setData(month_list);

        vh.pickYear.setDefault(year_tag);
        vh.pickMonth.setDefault(month_tag);

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
                month = (Integer.valueOf(vh.pickMonth.getSelectedText()) - 1);

                setCalendar();

                pop.dismiss();
            }
        });

        // 设置弹出窗体可点击
        pop.setFocusable(true);
        int w = this.getWindowManager().getDefaultDisplay().getWidth();
        pop.setWidth(w);
        // 实例化一个ColorDrawable颜色为半透明
        ColorDrawable dw = new ColorDrawable(0xb0000000);
        // 设置弹出窗体的背景
        pop.setBackgroundDrawable(dw);
        // 设置弹出窗体显示时的动画，从底部向上弹出
        pop.setAnimationStyle(R.style.AnimationPreview);
        pop.setContentView(view);
        pop.showAtLocation(llParent, Gravity.BOTTOM | Gravity.CENTER_HORIZONTAL, 0, 0);
        lightoff(true);
        pop.setOnDismissListener(new PopupWindow.OnDismissListener() {
            @Override
            public void onDismiss() {
                lightoff(false);
            }
        });
    }

    class ViewHolder {
        @BindView(R.id.tv_close)
        TextView tvClose;
        @BindView(R.id.tv_submit)
        TextView tvSubmit;
        @BindView(R.id.pick_year)
        ScrollerDatePicker pickYear;
        @BindView(R.id.pick_month)
        ScrollerDatePicker pickMonth;

        ViewHolder(View view) {
            ButterKnife.bind(this, view);
        }
    }

    @Override
    public void itemClick(int id) {
        if (mCalendarList != null) {

            for (int x = 0; x < mCalendarList.size(); x++) {
                if (id == mCalendarList.get(x).getId()) {
                    mCalendarList.get(x).setChecked(true);
                    day = Integer.valueOf(mCalendarList.get(x).getData());
//                    NToast.show("点击了" + mCalendarList.get(x).getData());

                    tvData.setText(year + "年" + (month + 1) + "月" + day + "日");
                    Calendar today = Calendar.getInstance();
                    try {
                        today.setTime(chineseDateFormat.parse(year + "年" + (month + 1) + "月" + day + "日"));
                        Lunar lunar = new Lunar(today);
                        tvLj.setText("农历  " + lunar.toDays() + "  " + getDayOfWeekByDate(year + "-" + (month + 1) + "-" + day));
                    } catch (ParseException e) {
                        com.linzi.xiguwen.utils.LogUtil.printStackTrace(e);
                    }
                    requestNetData();
                } else {
                    mCalendarList.get(x).setChecked(false);
                }
            }
            mCalendarAdapter.notifyDataSetChanged();
        }
    }


    class LuckDay {
        private int error_code;
        private String reason;
        private LuckData result;

        public int getError_code() {
            return error_code;
        }

        public void setError_code(int error_code) {
            this.error_code = error_code;
        }

        public String getReason() {
            return reason;
        }

        public void setReason(String reason) {
            this.reason = reason;
        }

        public LuckData getResult() {
            return result;
        }

        public void setResult(LuckData result) {
            this.result = result;
        }

        class LuckData {
            private Data data;

            public Data getData() {
                return data;
            }

            public void setData(Data data) {
                this.data = data;
            }

            class Data {
                /**
                 * {
                 * "date": "2018-4-12",
                 * "weekday": "星期四",
                 * "animalsYear": "狗",
                 * "suit": "祭祀.沐浴.解除.求医.治病.破屋.坏垣.余事勿取.",
                 * "avoid": "祈福.斋醮.开市.安葬.",
                 * "year-month": "2018-4",
                 * "lunar": "二月廿七",
                 * "lunarYear": "戊戌年"
                 * }
                 */
                private String date;
                private String weekday;
                private String animalsYear;
                private String suit;
                private String avoid;
                //private String year-month;
                private String lunar;
                private String lunarYear;

                public String getDate() {
                    return date;
                }

                public void setDate(String date) {
                    this.date = date;
                }

                public String getWeekday() {
                    return weekday;
                }

                public void setWeekday(String weekday) {
                    this.weekday = weekday;
                }

                public String getAnimalsYear() {
                    return animalsYear;
                }

                public void setAnimalsYear(String animalsYear) {
                    this.animalsYear = animalsYear;
                }

                public String getSuit() {
                    return suit;
                }

                public void setSuit(String suit) {
                    this.suit = suit;
                }

                public String getAvoid() {
                    return avoid;
                }

                public void setAvoid(String avoid) {
                    this.avoid = avoid;
                }

                public String getLunar() {
                    return lunar;
                }

                public void setLunar(String lunar) {
                    this.lunar = lunar;
                }

                public String getLunarYear() {
                    return lunarYear;
                }

                public void setLunarYear(String lunarYear) {
                    this.lunarYear = lunarYear;
                }
            }
        }
    }

    //创建时间选择器
    private void createChooseTimePop(View llParent) {
        ChooseDatePop chooseDatePop = new ChooseDatePop(mContext, null, true, false);
        chooseDatePop.setShowWithView(llParent);
        chooseDatePop.setListener(new ChooseDatePop.ReturnTimeStr() {
            @Override
            public void onSubmit(String string, String date, int whenid) {
                // setShowWithView(showView);
                //tvDay.setText(string);

                year = Integer.parseInt(date.split("-")[0]);
                month = Integer.parseInt(date.split("-")[1]) - 1;
                setCalendar();
                //httpDot();
            }
        });
    }
}
