package com.linzi.xiguwen.view.dateview;

import android.app.Activity;
import android.content.Context;
import android.graphics.drawable.ColorDrawable;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewTreeObserver;
import android.view.WindowManager;
import android.widget.LinearLayout;
import android.widget.PopupWindow;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.MyDateBean;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.view.ScrollerDatePicker;

import java.util.ArrayList;
import java.util.Calendar;

/**
 * Created by pc on 2018/3/31.
 */

public class ChooseDatePop extends PopupWindow implements View.OnClickListener {
    ReturnTimeStr returnTimeStr;

    private TextView tvClose;//关闭
    private TextView tvSubmit;//提交
    private ScrollerDatePicker pickYear;//年
    private ScrollerDatePicker pickMonth;//月
    private ScrollerDatePicker pickDay;//日
    private ScrollerDatePicker pickWhen;//时间段
    private LinearLayout llWhen;//时间段linerlayout

    private int limit = 10;//如：10 == 2010-2020
    private int startYear = 2017;//开始年

    private View view;
    private Context context;

    private boolean isShowDay;//是否显示日

    int year = 0, month = 0, day = 0;

    int tomonth = 0;
    int toyear = 0;
    int today = 0;

    int yearIndex;//今年的位置
    int monthIndex;//今月的位置
    int dayIndex;//今日的位置
    int whenIndex;//现在时间段位置

    private String chooseTimeStr = null;//选择的时间
    private ArrayList<MyDateBean> when_list = new ArrayList<>();//滚动view 时间段
    private boolean canChooseAgo;

    public ChooseDatePop(Context context, ArrayList<MyDateBean> when_list, boolean canChooseAgo) {
        super(context);
        this.when_list = when_list;
        this.context = context;
        this.canChooseAgo = canChooseAgo;
        this.isShowDay = true;
        view = LayoutInflater.from(context).inflate(R.layout.pop_richeng_select_date_layout, null);
        initView();
    }

    public ChooseDatePop(Context context, ArrayList<MyDateBean> when_list, boolean canChooseAgo, boolean isShowDay) {
        super(context);
        this.when_list = when_list;
        this.context = context;
        this.canChooseAgo = canChooseAgo;
        this.isShowDay = isShowDay;
        view = LayoutInflater.from(context).inflate(R.layout.pop_richeng_select_date_layout, null);
        initView();
    }


    public interface ReturnTimeStr {
        abstract void onSubmit(String string, String date, int whenid);
    }

    public void setListener(ReturnTimeStr returnTimeStr) {
        this.returnTimeStr = returnTimeStr;
    }

    private void initView() {
        tvClose = (TextView) view.findViewById(R.id.tv_close);
        tvSubmit = (TextView) view.findViewById(R.id.tv_submit);
        pickYear = (ScrollerDatePicker) view.findViewById(R.id.pick_year);
        pickMonth = (ScrollerDatePicker) view.findViewById(R.id.pick_month);
        pickDay = (ScrollerDatePicker) view.findViewById(R.id.pick_day);
        pickWhen = (ScrollerDatePicker) view.findViewById(R.id.pick_when);
        ViewTreeObserver viewTreeObserver = pickYear.getViewTreeObserver();
        viewTreeObserver.addOnGlobalLayoutListener(new ViewTreeObserver.OnGlobalLayoutListener() {
            @Override
            public void onGlobalLayout() {
                pickYear.getViewTreeObserver().removeGlobalOnLayoutListener(this);
                pickYear.setControlWidth(pickYear.getWidth(), pickYear.getHeight());
                pickMonth.setControlWidth(pickYear.getWidth(), pickYear.getHeight());
                if (isShowDay) {
                    pickDay.setControlWidth(pickYear.getWidth(), pickYear.getHeight());
                }
                if (when_list != null && when_list.size() > 0) {
                    pickWhen.setControlWidth(pickYear.getWidth(), pickYear.getHeight());
                }
            }
        });

        llWhen = (LinearLayout) view.findViewById(R.id.ll_when);

        tvClose.setOnClickListener(this);
        tvSubmit.setOnClickListener(this);

        //时间段是否可见
        if (when_list != null && when_list.size() > 0) {
            llWhen.setVisibility(View.VISIBLE);
        } else {
            llWhen.setVisibility(View.GONE);
        }

        //日是否可见
        if (isShowDay) {
            pickDay.setVisibility(View.VISIBLE);
        } else {
            pickDay.setVisibility(View.GONE);
        }

        initDate();
        // 设置弹出窗体可点击
        setFocusable(true);
        int w = ((Activity) context).getWindowManager().getDefaultDisplay().getWidth();
        int h = (((Activity) context).getWindowManager().getDefaultDisplay().getHeight() / 3);
        setWidth(w);
        setHeight(h);
        // 实例化一个ColorDrawable颜色为半透明
        ColorDrawable dw = new ColorDrawable(0xffff0000);
        // 设置弹出窗体的背景
        setBackgroundDrawable(dw);
        // 设置弹出窗体显示时的动画，从底部向上弹出
        setAnimationStyle(R.style.AnimationPreview);
        setContentView(view);
        update();
        setOnDismissListener(new PopupWindow.OnDismissListener() {
            @Override
            public void onDismiss() {
                lightoff(false);
            }
        });

    }

    public void setShowWithView(View view) {
        showAtLocation(view, Gravity.BOTTOM | Gravity.CENTER_HORIZONTAL, 0, 0);
        lightoff(true);
    }

    //初始化时间
    private void initDate() {
        Calendar calendar = Calendar.getInstance();
        year = calendar.get(Calendar.YEAR);
        month = (calendar.get(Calendar.MONTH) + 1);
        day = calendar.get(Calendar.DAY_OF_MONTH);
        tomonth = month;//今月
        toyear = year;//今年
        today = day;//今日

        ArrayList<MyDateBean> year_list = new ArrayList<>();//滚动view 年
        ArrayList<MyDateBean> month_list = new ArrayList<>();//滚动view 月
        ArrayList<MyDateBean> day_list = new ArrayList<>();//滚动view 日
        MyDateBean mBean;
        //------------------------- 设置年 ------------------
        for (int i = 0; i < limit; i++) {
            int year = startYear + i;
            mBean = new MyDateBean();
            mBean.setId(i);
            mBean.setDate("" + year + "年");
            year_list.add(mBean);
            if (year == toyear) {
                yearIndex = i;//标记位置
            }
        }

        pickYear.setData(year_list);
        pickYear.setDefault(yearIndex);//设置默认显示

        pickYear.setOnSelectListener(new ScrollerDatePicker.OnSelectListener() {
            @Override
            public void endSelect(int id, String text) {
                year = Integer.valueOf(text.replace("年", ""));
                month = Integer.valueOf(pickMonth.getSelectedText().replace("月", ""));
                ArrayList<MyDateBean> list = setDay(year, month);
                pickDay.setData(list);
                pickDay.setDefault(0);
                pickMonth.setDefault(0);
            }

            @Override
            public void selecting(int id, String text) {
            }
        });
        //------------------------- 设置月 ------------------
        for (int x = 0; x < 12; x++) {
            int month = x + 1;
            mBean = new MyDateBean();
            mBean.setId(x);
            mBean.setDate("" + month + "月");
            month_list.add(mBean);
            if (month == tomonth) {
                monthIndex = mBean.getId();//标记位置
            }
        }

        pickMonth.setData(month_list);
        pickMonth.setDefault(monthIndex);//设置默认显示

        pickMonth.setOnSelectListener(new ScrollerDatePicker.OnSelectListener() {
            @Override
            public void endSelect(int id, String text) {
                month = Integer.valueOf(text.replace("月", ""));
                year = Integer.valueOf(pickYear.getSelectedText().replace("年", ""));
                ArrayList<MyDateBean> list = setDay(year, month);
                pickDay.setData(list);
                if (month == tomonth && year == toyear) {
                    pickDay.setDefault(dayIndex);
                } else {
                    pickDay.setDefault(0);
                }
            }

            @Override
            public void selecting(int id, String text) {
            }
        });

        //------------------------- 设置日 ------------------
        int maxDay = getDaysByYearMonth(toyear, tomonth);
        for (int x = 0; x < maxDay; x++) {
            int day = x + 1;
            mBean = new MyDateBean();
            mBean.setId(x);
            mBean.setDate("" + day + "日");
            day_list.add(mBean);
            if (day == today) {
                dayIndex = mBean.getId();//标记位置
            }
        }
        pickDay.setData(day_list);
        pickDay.setDefault(dayIndex);//设置默认显示

        //------------------------- 设置时间段 ------------------
        if (when_list != null && when_list.size() > 0) {
            pickWhen.setData(when_list);
        }
        if (when_list != null && when_list.size() > 2){
            pickWhen.setDefault(1);
        }
    }

    private ArrayList<MyDateBean> setDay(int year, int month) {
        ArrayList<MyDateBean> list = new ArrayList<>();
        int max_day_num = getDaysByYearMonth(year, month);
        MyDateBean mBean;
        for (int x = 0; x < max_day_num; x++) {
            mBean = new MyDateBean();
            mBean.setId(x);
            mBean.setDate("" + (x + 1) + "日");
            list.add(mBean);
        }
        return list;
    }

    private ArrayList<MyDateBean> setMonth() {
        ArrayList<MyDateBean> list = new ArrayList<>();
        MyDateBean mBean;
        for (int x = 0; x < 12; x++) {
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

    //显示消失动画
    public void lightoff(boolean isoff) {
        WindowManager.LayoutParams lp = ((Activity) context).getWindow().getAttributes();
        if (isoff) {
            lp.alpha = 0.3f;
        } else {
            lp.alpha = 1f;
        }
        ((Activity) context).getWindow().setAttributes(lp);
    }

    //选择时间
    private void chooseTime() {
        year = Integer.valueOf(pickYear.getSelectedText().replace("年", ""));
        month = Integer.valueOf(pickMonth.getSelectedText().replace("月", ""));
        day = Integer.valueOf(pickDay.getSelectedText().replace("日", ""));
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

        if (!canChooseAgo) {
            int y = Integer.valueOf(pickYear.getSelectedText().replace("年", ""));
            int m = Integer.valueOf(pickMonth.getSelectedText().replace("月", ""));
            int d = Integer.valueOf(pickDay.getSelectedText().replace("日", ""));
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
        }
        if (isShowDay) {
            chooseTimeStr = year + "-" + mm + "-" + dd + "  " + pickWhen.getSelectedText();
            returnTimeStr.onSubmit(chooseTimeStr, year + "-" + mm + "-" + dd, (pickWhen.getSelectedID() + 1));
        } else {
            chooseTimeStr = year + "-" + mm + "  " + pickWhen.getSelectedText();
            returnTimeStr.onSubmit(chooseTimeStr, year + "-" + mm, (pickWhen.getSelectedID() + 1));
        }
        dismiss();

    }

    @Override
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.tv_close:
                dismiss();
                break;
            case R.id.tv_submit:
                chooseTime();
                break;
        }
    }

}



