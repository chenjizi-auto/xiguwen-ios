package com.linzi.xiguwen.view;

import android.content.Context;
import androidx.annotation.Nullable;
import android.util.AttributeSet;
import android.view.View;
import android.widget.FrameLayout;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.MyDateBean;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Iterator;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by PC on 2018-03-31.
 */

public class MyDatePickerView extends FrameLayout{
    /**
     * 月份由0-11, 所以获取显示的时候记得-1哟
     */
    @BindView(R.id.pick_year)
    ScrollerDatePicker pickYear;
    @BindView(R.id.tv_nian)
    TextView tvNian;
    @BindView(R.id.ll_year)
    LinearLayout llYear;
    @BindView(R.id.pick_month)
    ScrollerDatePicker pickMonth;
    @BindView(R.id.tv_yue)
    TextView tvYue;
    @BindView(R.id.ll_month)
    LinearLayout llMonth;
    @BindView(R.id.pick_day)
    ScrollerDatePicker pickDay;
    @BindView(R.id.tv_ri)
    TextView tvRi;
    @BindView(R.id.ll_day)
    LinearLayout llDay;
    @BindView(R.id.pick_when)
    ScrollerDatePicker pickWhen;
    @BindView(R.id.ll_when)
    LinearLayout llWhen;


    private int year = 0000, month = 00, day = 00;  // 选择的日期
    private int toyear = 0000, tomonth = 00, today = 00;  // 今天的日期

    private OnDateChanged mDateChangeListener;


    public MyDatePickerView(Context context) {
        super(context);
        init();
    }

    public MyDatePickerView(Context context, @Nullable AttributeSet attrs) {
        super(context, attrs);
        init();
    }

    public MyDatePickerView(Context context, @Nullable AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);
        init();
    }

    private void init(){
        inflate(getContext(), R.layout.view_date_picker, this);
        ButterKnife.bind(this, this);
        Calendar calendar = Calendar.getInstance();
        toyear = calendar.get(Calendar.YEAR);
        tomonth = calendar.get(Calendar.MONTH);
        today = calendar.get(Calendar.DAY_OF_MONTH);
        year = toyear;
        month = tomonth;
        day = today;

        setupView();
    }
    ArrayList<MyDateBean> year_list = new ArrayList<>();    // 年份列表
    ArrayList<MyDateBean> month_list = new ArrayList<>();   // 月份列表
    final ArrayList<MyDateBean> day_list = new ArrayList<>();   // 天的列表
    final ArrayList<MyDateBean> when_list = new ArrayList<>();  // 时候的列表

    private void setupView(){

        MyDateBean mBean;
        int years;
        int year_tag = 0;
        int month_tag = 0;
        int day_tag = 0;
        for (int x = 0; x < 100; x++) {
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
            if(x < 9) {
                mBean.setDate("0" + (x + 1));
            }else{
                mBean.setDate("" + (x + 1));
            }
            month_list.add(mBean);
            if (x == month) {
                month_tag = x;
            }
        }

        int max_day_num = getDaysByYearMonth(year, month);
        for (int x = 0; x < max_day_num; x++) {
            mBean = new MyDateBean();
            mBean.setId(x);
            if(x < 9) {
                mBean.setDate("0" + (x + 1));
            }else{
                mBean.setDate("" + (x + 1));
            }
            day_list.add(mBean);
            if ((x + 1) == day) {
                day_tag = x;
            }
        }
        //1上午2中午3下午4晚上5全天6不接单
        for (int x = 1; x <= 6; x++) {
            mBean = new MyDateBean();
            mBean.setId(x);
            switch (x) {
                case 1:
                    mBean.setDate("上午");
                    break;
                case 2:
                    mBean.setDate("中午");
                    break;
                case 3:
                    mBean.setDate("下午");
                    break;
                case 4:
                    mBean.setDate("晚上");
                    break;
                case 5:
                    mBean.setDate("全天");
                    break;
                case 6:
                    mBean.setDate("不接单");
                    break;
            }
            when_list.add(mBean);
        }

        pickYear.setData(year_list);
        pickMonth.setData(month_list);
        pickDay.setData(day_list);
        pickWhen.setData(when_list);

        pickYear.setDefault(year_tag);
        pickMonth.setDefault(month_tag);
        pickDay.setDefault(day_tag);

        pickYear.setOnSelectListener(new ScrollerDatePicker.OnSelectListener() {
            @Override
            public void endSelect(int id, String text) {
                year = Integer.valueOf(text);
                int max_day_num = getDaysByYearMonth(year, month);
                pickDay.setData(updateDay());
                if(day <= max_day_num){
                    pickDay.setDefault(day - 1);
                }else{
                    pickDay.setDefault(max_day_num - 1);
                }
                notifyDateChange();
            }

            @Override
            public void selecting(int id, String text) {
            }
        });
        pickMonth.setOnSelectListener(new ScrollerDatePicker.OnSelectListener() {
            @Override
            public void endSelect(int id, String text) {
                month = Integer.valueOf(text) - 1;
                int max_day_num = getDaysByYearMonth(year, month);
                pickDay.setData(updateDay());
                if(day <= max_day_num){
                    pickDay.setDefault(day - 1);
                }else{
                    pickDay.setDefault(max_day_num - 1);
                    day = max_day_num;
                }

                notifyDateChange();
            }

            @Override
            public void selecting(int id, String text) {
            }
        });

        pickDay.setOnSelectListener(new ScrollerDatePicker.OnSelectListener() {
            @Override
            public void endSelect(int id, String text) {
                day = Integer.valueOf(text);
                notifyDateChange();
            }

            @Override
            public void selecting(int id, String text) {

            }
        });
    }

    public void setHasWhen(boolean hasWhen){
        llWhen.setVisibility(hasWhen ? View.VISIBLE : View.GONE);
    }

    private ArrayList<MyDateBean> updateDay(){
        ArrayList<MyDateBean> list = new ArrayList<>();
        int max_day_num = getDaysByYearMonth(year, month);
        MyDateBean mBean;
        for (int x = 0; x < max_day_num; x++) {
            mBean = new MyDateBean();
            mBean.setId(x);
            if((x+1)<10) {
                mBean.setDate("0" + (x + 1));
            }else{
                mBean.setDate("" + (x + 1));
            }
            list.add(mBean);
        }
        return list;
    }

    /**
     * 根据年 月 获取对应的月份 天数
     */
    private int getDaysByYearMonth(int year, int month) {

        Calendar a = Calendar.getInstance();
        a.set(Calendar.YEAR, year);
        a.set(Calendar.MONTH, month);
        a.set(Calendar.DATE, 1);
        //设置为当前月的第一天，-1天则为本月的天数
        a.roll(Calendar.DATE, -1);
        int maxDate = a.get(Calendar.DATE);
        return maxDate;
    }

    //将dp转换为px
    public  int dip2px(Context context, float dpValue) {
        final float scale = context.getResources().getDisplayMetrics().density;
        return (int) (dpValue * scale + 0.5f);
    }

    public int getYear(){
        String selectedText = pickYear.getSelectedText();
        return Integer.valueOf(selectedText);
    }

    /**
     * 月份从0 开始
     * @return
     */
    public int getMonth(){
        return month;
    }

    public int getDay(){
        String selectedText = pickDay.getSelectedText();
        return Integer.valueOf(selectedText);
    }

    public int getWhen(){
        return pickWhen.getSelectedID();
    }

    public String getWhenStr(){
        switch (getWhen()) {
            case 1:
                return "上午";
            case 2:
                return "中午";
            case 3:
                return "下午";
            case 4:
                return "晚上";
            case 5:
                return "全天";
            case 6:
                return "不接单";
        }
        return "";
    }

    public Calendar getCalendar(){
        Calendar calendar = Calendar.getInstance();
        calendar.set(year, month, day, 0, 0);
        return calendar;
    }

    public void setOnDateChangeListener(OnDateChanged listener){
        this.mDateChangeListener = listener;
    }

    private void notifyDateChange(){
        if(mDateChangeListener != null){
            mDateChangeListener.onChanged(this);
        }
    }

    public void setDate(int year, int month, int day){
        if(setYear(year)){
            if(setMonty(month)){
                setDay(day);
            }
        }
    }

    public void setDate(String date){
        if(date != null){
            String[] split = date.split("-");
            if(split.length == 3){
                try {
                    setDate(Integer.valueOf(split[0]), Integer.valueOf(split[1]), Integer.valueOf(split[2]));
                } catch (Exception e) {
                    Toast.makeText(getContext(), "日期格式有误", Toast.LENGTH_SHORT).show();
                    com.linzi.xiguwen.utils.LogUtil.printStackTrace(e);
                }
            }else{
                Toast.makeText(getContext(), "日期格式有误", Toast.LENGTH_SHORT).show();
            }
        }
    }

    public boolean setYear(int year){
        if(year < 2000 || year > 2100){
            Toast.makeText(getContext(), "日期超出范围", Toast.LENGTH_SHORT).show();
            return false;
        }

        this.year = year;
        //更新日
        int max_day_num = getDaysByYearMonth(year, month);
        pickDay.setData(updateDay());
        if(day <= max_day_num){
            pickDay.setDefault(day - 1);
        }else{
            pickDay.setDefault(max_day_num - 1);
        }

        Iterator<MyDateBean> iterator = year_list.iterator();
        while (iterator.hasNext()){
            MyDateBean next = iterator.next();
            String date = next.getDate();
            int index = year_list.indexOf(next);
            pickYear.setDefault(index);
            if ( date.split("-")[0].equals(year+"")){
                break;
            }
        }

        return true;
    }

    public boolean setMonty(int month){
        if(month <= 0 || month > 12){
            Toast.makeText(getContext(), "日期设置有误", Toast.LENGTH_SHORT).show();
            return false;
        }
        month --;
        this.month = month;
        //更新日
        int max_day_num = getDaysByYearMonth(year, month);
        pickDay.setData(updateDay());
        if(day <= max_day_num){
            pickDay.setDefault(day - 1);
        }else{
            pickDay.setDefault(max_day_num - 1);
        }
        Iterator<MyDateBean> iterator = month_list.iterator();
        while (iterator.hasNext()){
            MyDateBean next = iterator.next();
            String date = next.getDate();
            if ( Integer.parseInt(date)== (month+1)){
                int index = month_list.indexOf(next);
                pickMonth.setDefault(index);
                break;
            }
        }
        return true;
    }

    public boolean setDay(int day){
        int max_day_num = getDaysByYearMonth(year, month);
        if(day <= 0 || day > max_day_num){
            Toast.makeText(getContext(), "日期设置有误", Toast.LENGTH_SHORT).show();
            return false;
        }
        pickDay.setDefault(day - 1);
        return true;
    }

    public boolean setWhen(int i){
        if(i <= 0 || i > 6){
            Toast.makeText(getContext(), "日期设置有误", Toast.LENGTH_SHORT).show();
            return false;
        }
        pickWhen.setDefault(i - 1);
        return true;
    }

    public boolean setWhen(String when){
        switch (when){
            case "上午":
            case "1":
                pickWhen.setDefault(0);
                return true;
            case "中午":
            case "2":
                pickWhen.setDefault(1);
                return true;
            case "下午":
            case "3":
                pickWhen.setDefault(2);
                return true;
            case "晚上":
            case "4":
                pickWhen.setDefault(3);
                return true;
            case "全天":
            case "5":
                pickWhen.setDefault(4);
                return true;
            case "不接单":
            case "6":
                pickWhen.setDefault(5);
                return true;
        }
        Toast.makeText(getContext(), "日期设置有误", Toast.LENGTH_SHORT).show();
        return false;
    }

    public interface OnDateChanged{
        void onChanged(MyDatePickerView view);
    }
}
