package com.linzi.xiguwen.utils;

/**
 * Created by jiang on 2016/11/30.
 */

import android.os.Handler;
import android.widget.TextView;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Locale;
import java.util.TimeZone;

public class TimeUtils {
    //字符串转时间戳
    public static String getTime(String timeString){
        String timeStamp = null;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日");
        Date d;
        try{
            d = sdf.parse(timeString);
            long l = d.getTime();
            timeStamp = String.valueOf(l);
        } catch(ParseException e){
            com.linzi.xiguwen.utils.LogUtil.printStackTrace(e);
        }
        return timeStamp;
    }
    //字符串转时间戳
    public static String getTime2(String timeString){
        String timeStamp = null;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm");
        Date d;
        try{
            d = sdf.parse(timeString);
            long l = d.getTime();
            timeStamp = String.valueOf(l);
        } catch(ParseException e){
            com.linzi.xiguwen.utils.LogUtil.printStackTrace(e);
        }
        return timeStamp;
    }
    //字符串转时间戳
    public static String getTime3(String timeString){
        String timeStamp = null;
        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
        Date d;
        try{
            d = sdf.parse(timeString);
            long l = d.getTime();
            timeStamp = String.valueOf(l);
        } catch(ParseException e){
            com.linzi.xiguwen.utils.LogUtil.printStackTrace(e);
        }
        return timeStamp;
    }
    //字符串转时间戳
    public static String getTime4(String timeString){
        String timeStamp = null;
        SimpleDateFormat sdf = new SimpleDateFormat("HH小时mm分ss秒");
        Date d;
        try{
            d = sdf.parse(timeString);
            long l = d.getTime();
            timeStamp = String.valueOf(l);
        } catch(ParseException e){
            com.linzi.xiguwen.utils.LogUtil.printStackTrace(e);
        }
        return timeStamp;
    }
    //字符串转时间戳
    public static String getTime5(String timeString){
        String timeStamp = null;
        SimpleDateFormat sdf = new SimpleDateFormat("dd天HH小时mm分ss秒");
        Date d;
        try{
            d = sdf.parse(timeString);
            long l = d.getTime();
            timeStamp = String.valueOf(l);
        } catch(ParseException e){
            com.linzi.xiguwen.utils.LogUtil.printStackTrace(e);
        }
        return timeStamp;
    }

    //时间戳转字符串
    public static String getStrTime(String timeStamp){
        String timeString = null;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日 hh:mm:ss");
        long  l = Long.valueOf(timeStamp);
        timeString = sdf.format(l);//单位秒
        return timeString;
    }

    //时间戳转字符串
    public static String getStr2Time(String timeStamp){
        String timeString = null;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        long  l = Long.valueOf(timeStamp);
        timeString = sdf.format(l);//单位秒
        return timeString;

    }
    //时间戳转字符串
    public static String getStr2Times(String timeStamp){
        String timeString = null;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        long  l = Long.valueOf(timeStamp);
        Date date=new Date(l);
        timeString = sdf.format(date);//单位秒
        return timeString;
    }
    //时间戳转字符串
    public static String getStr2HourTimes(String timeStamp){
        String timeString = null;
        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
        long  l = Long.valueOf(timeStamp);
        timeString = sdf.format(l);//单位秒
        return timeString;
    }
    //时间戳转字符串
    public static String getStr2HourTimes2(String timeStamp){
        String timeString = null;
        SimpleDateFormat sdf = new SimpleDateFormat("HH小时mm分ss秒");
        long  l = Long.valueOf(timeStamp);
        timeString = sdf.format(l);//单位秒
        return timeString;
    }
    //时间戳转字符串
    public static String getStr2HourTimes3(String timeStamp){
        String timeString = null;
        SimpleDateFormat sdf = new SimpleDateFormat("dd天HH小时mm分ss秒");
        long  l = Long.valueOf(timeStamp);
        timeString = sdf.format(l);//单位秒
        return timeString;
    }
    //计算时间差，保留到s
    public static double getdataUp(String nowTime,String upTime){
        double secends=(double)(Long.valueOf(nowTime)-(Long.valueOf(upTime)))/60/1000;
        return secends;
    }

    //计算天数
    public static double getdaynum(String start,String end){
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");//输入日期的格式
        Date date1 = null;
        try {
            date1 = simpleDateFormat.parse(start);
        } catch (ParseException e) {
            com.linzi.xiguwen.utils.LogUtil.printStackTrace(e);
        }
        Date date2 = null;
        try {
            date2 = simpleDateFormat.parse(end);
        } catch (ParseException e) {
            com.linzi.xiguwen.utils.LogUtil.printStackTrace(e);
        }
        GregorianCalendar cal1 = new GregorianCalendar();
        GregorianCalendar cal2 = new GregorianCalendar();
        cal1.setTime(date1);
        cal2.setTime(date2);
        double dayCount = (cal2.getTimeInMillis()-cal1.getTimeInMillis())/(1000*3600*24);//从间隔毫秒变成间隔天数
        return dayCount;
    }

    public static void getReturnTime(String time, final TextView tv){
        final String[] timeStamp = {getTime3(time)};
        final Handler handler = new Handler();
        Runnable runnable = new Runnable() {
            @Override
            public void run() {
                timeStamp[0] =""+(Integer.valueOf(timeStamp[0])-1000);
                tv.setText("" + getStr2HourTimes(timeStamp[0]));
                handler.postDelayed(this, 1000);
            }
        };
        handler.postDelayed(runnable, 1000);
    }

    public static Handler getReturnTime2(String time, final TextView tv){
        final String[] timeStamp = {getTime4(time)};
        final Handler handler = new Handler();
        Runnable runnable = new Runnable() {
            @Override
            public void run() {
                timeStamp[0] =""+(Integer.valueOf(timeStamp[0])-1000);
                tv.setText("" + getStr2HourTimes2(timeStamp[0]));
                handler.postDelayed(this, 1000);
            }
        };
        handler.postDelayed(runnable, 1000);
        return handler;
    }
    public static void getReturnTime3(String time, final TextView tv){
        final String[] timeStamp = {getTime5(time)};
        final Handler handler = new Handler();
        Runnable runnable = new Runnable() {
            @Override
            public void run() {
                timeStamp[0] =""+(Integer.valueOf(timeStamp[0])-1000);
                tv.setText("" + getStr2HourTimes3(timeStamp[0]));
                handler.postDelayed(this, 1000);
            }
        };
        handler.postDelayed(runnable, 1000);
    }

    // 显示倒计时， 单位秒
    public static Handler getReturnTime(final long time, final TextView tv){
        final Handler handler = new Handler();
        final Long[] timeStamp = new Long[]{time};
        Runnable runnable = new Runnable() {
            @Override
            public void run() {
                if(timeStamp[0] <= 0){
                    tv.setText("00小时00分00秒");
                    return ;
                }
                tv.setText(getStr2HourTimes(timeStamp[0]));
                timeStamp[0] = timeStamp[0] - 1;
                handler.postDelayed(this, 1000);
            }
        };
        handler.post(runnable);
        return handler;
    }

    //时间戳转字符串， 单位秒
    public static String getStr2HourTimes(long timeStamp){
        SimpleDateFormat sdf = new SimpleDateFormat("HH小时mm分ss秒", Locale.ROOT);
        sdf.setTimeZone(TimeZone.getTimeZone("GMT"));  // 0时区
        Date date = new Date(timeStamp * 1000);
        return sdf.format(date);//单位秒
    }
}