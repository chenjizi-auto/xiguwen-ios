package com.linzi.xiguwen.utils;

import java.text.SimpleDateFormat;
import java.util.Calendar;

/**
 * Created by PC on 2018-03-31.
 */

public class TimeFormatter {
    private int year;
    private int month;
    private int day;

    public TimeFormatter(int year, int month, int day) {
        this.year = year;
        this.month = month;
        this.day = day;
    }

    public int getYear() {
        return year;
    }

    public int getMonth() {
        return month;
    }

    public int getDay() {
        return day;
    }

    public String getFormatDate(){
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        Calendar calendar = Calendar.getInstance();
        calendar.set(year, month, day);
        return format.format(calendar.getTime());
    }

    @Override
    public String toString() {
        return getFormatDate();
    }
}
