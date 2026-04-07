package com.linzi.xiguwen.utils;

import android.app.Activity;
import android.app.ActivityManager;
import android.app.ActivityManager.RunningServiceInfo;
import android.app.ActivityManager.RunningTaskInfo;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.graphics.Color;
import android.media.MediaMetadataRetriever;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.net.ParseException;
import android.net.Uri;
import android.os.Build;
import android.os.PowerManager;
import android.text.Spannable;
import android.text.SpannableString;
import android.text.SpannableStringBuilder;
import android.text.method.LinkMovementMethod;
import android.text.style.ForegroundColorSpan;
import android.util.DisplayMetrics;
import android.view.Display;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.view.inputmethod.InputMethodManager;
import android.widget.RatingBar;
import android.widget.ScrollView;
import android.widget.TextView;
import com.linzi.xiguwen.ui.MainActivity;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;

import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * app工具类
 */
public class AppUtil {

    /**
     * 根据手机的分辨率从 dp 的单位 转成为 px(像素)
     */
    public static int dip2px(Context context, float dpValue) {
        final float scale = context.getResources().getDisplayMetrics().density;
        return (int) (dpValue * scale + 0.5f);
    }

    /**
     * 根据手机的分辨率从 px(像素) 的单位 转成为 dp
     */
    public static int px2dip(Context context, float pxValue) {
        final float scale = context.getResources().getDisplayMetrics().density;
        return (int) (pxValue / scale + 0.5f);
    }

    /**
     * 屏幕宽度
     *
     * @param context
     * @return
     */


    public static int getWidth(Context context) {
        // 屏幕宽度（像素）

        WindowManager wm = (WindowManager) context.getSystemService(Context.WINDOW_SERVICE);
        int width = wm.getDefaultDisplay().getWidth();//
        // return context.getResources().getDisplayMetrics().widthPixels;
        return width;
    }

    /**
     * 屏幕高度
     *
     * @param context
     * @return
     */
    public static int getHeight(Context context) {
        DisplayMetrics dm = new DisplayMetrics();
        WindowManager wm = (WindowManager) context.getSystemService(Context.WINDOW_SERVICE);
        wm.getDefaultDisplay().getMetrics(dm);

        return dm.heightPixels;
    }

    /**
     * 时间戳转换为时间
     *
     * @param dateString 时间戳
     * @param xxx        需要返回格式
     * @return 时间
     */
    public static String long2Date(String dateString, String xxx) {
        if (dateString == null) {
            return "";
        }
        try {
            long date = Long.parseLong(dateString);
            SimpleDateFormat formatter = new SimpleDateFormat(xxx);
            String dateS = formatter.format(date);
            return dateS;
        } catch (NumberFormatException e) {

        }
        return dateString;
    }

    /**
     * 时间转换为时间戳
     *
     * @param time 时间
     * @param xxx  时间格式
     * @return php时间戳
     * @throws ParseException
     */
    public static String timeToLong(String time, String xxx) throws ParseException {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(xxx);
        Date date;
        String timeStemp = null;
        try {
            date = simpleDateFormat.parse(time);
            timeStemp = date.getTime() / 1000 + "";
        } catch (java.text.ParseException e) {
            com.linzi.xiguwen.utils.LogUtil.printStackTrace(e);
        }
        return timeStemp;

    }

    /**
     * 获取当前时间
     *
     * @param dateformat
     * @return
     */
    public static String getNowTime(String dateformat) {

        Date now = new Date();
        SimpleDateFormat dateFormat = new SimpleDateFormat(dateformat);// 可以方便地修改日期格式
        String hehe = dateFormat.format(now);
        return hehe;
    }

    public static String getWeekOfDate() {
        Date now = new Date();
        String[] weekDays = {"周日", "周一", "周二", "周三", "周四", "周五", "周六"};
        Calendar cal = Calendar.getInstance();
        cal.setTime(now);
        int w = cal.get(Calendar.DAY_OF_WEEK) - 1;
        if (w < 0)
            w = 0;
        return weekDays[w];
    }



    /**
     * 将一个时间戳转换成提示性时间字符串，如刚刚，1秒前
     *
     * @param timeStamp
     * @return
     */
    public static String convertTimeToFormat(long timeStamp) {
        long curTime = System.currentTimeMillis() / (long) 1000;// 系统当前时间
        long time = 0;
        String showtime = null;
        try {
            long datetime = Long.parseLong(timeToLong(getNowTime("yyyy/MM/dd"), "yyyy/MM/dd"));// 当天时间戳

            time = curTime - timeStamp;

            if (timeStamp - datetime >= 0) {
                if (time < 60 && time >= 0) {
                    showtime = "刚刚";
                } else if (time >= 60 && time < 3600) {

                    showtime = time / 60 + "分钟前";
                } else {
                    showtime = "今天" + longcDate(timeStamp + "", "HH:mm");
                }

            } else {

                showtime = longcDate(timeStamp + "", "yyyy/MM/dd HH:mm");

            }

        } catch (NumberFormatException e) {
            com.linzi.xiguwen.utils.LogUtil.printStackTrace(e);
        } catch (ParseException e) {
            com.linzi.xiguwen.utils.LogUtil.printStackTrace(e);
        }

        return showtime;
        // if (time < 60 && time >= 0) {
        // return "刚刚";
        // } else if (time >= 60 && time < 3600) {
        // // return time / 60 + "分钟前";
        // return "今天" + long2Date(timeStamp + "", "HH:mm");
        // }else {
        // return long2Date(timeStamp + "", "yyyy/MM/dd HH:mm");
        // }

        // if (time < 60 && time >= 0) {
        // return "刚刚";
        // } else if (time >= 60 && time < 3600) {
        // // return time / 60 + "分钟前";
        // return "今天" + long2Date(timeStamp + "", "HH:mm");
        // } else if (time >= 3600 && time < 3600 * 24) {
        // // return time / 3600 + "小时前";
        // return long2Date(timeStamp + "", "yyyy/MM/dd HH:mm");
        // } else if (time >= 3600 * 24 && time < 3600 * 24 * 2) {
        // // return time / 3600 / 24 + "天前";
        // return "昨天：" + long2Date(timeStamp + "", "HH:mm");
        //
        // } else if (time >= 3600 * 24 * 2 && time < 3600 * 24 * 30 * 12) {
        // // return time / 3600 / 24 / 30 + "个月前";
        //
        // return long2Date(timeStamp + "", "yyyy/MM/dd HH:mm");
        // } else if (time >= 3600 * 24 * 30 * 12) {
        // // return time / 3600 / 24 / 30 / 12 + "年前";
        // return long2Date(timeStamp + "", "yyyy/MM/dd HH:mm");
        // } else {
        // return "刚刚";
        // }

    }

    public static String longcDate(String dateString, String xxx) {
        long date = Long.parseLong(dateString + "000");
        SimpleDateFormat formatter = new SimpleDateFormat(xxx);
        String dateS = formatter.format(date);

        return dateS;
    }

    /**
     * 拨打电话
     *
     * @param context
     * @param tel
     */
    public static void tel(Context context, String tel) {
        Intent intent = new Intent(Intent.ACTION_DIAL);
        Uri data = Uri.parse("tel:" + tel);
        intent.setData(data);
        context.startActivity(intent);
    }

    /**
     * 将一个时间戳转换成提示性时间字符串，如刚刚，1秒前换行
     *
     * @param timeStamp
     * @return
     */
    public static String convertTimeToFormatt(long timeStamp) {
        long curTime = System.currentTimeMillis() / (long) 1000;// 系统当前时间
        long time = 0;
        String showtime = null;
        try {
            long datetime = Long.parseLong(timeToLong(getNowTime("yyyy/MM/dd"), "yyyy/MM/dd"));// 当天时间戳

            time = curTime - timeStamp;

            if (timeStamp - datetime >= 0) {
                if (time < 60 && time >= 0) {
                    showtime = "刚刚";
                } else if (time >= 60 && time < 3600) {

                    showtime = time / 60 + "分钟前";
                } else {
                    showtime = "今天\n" + long2Date(timeStamp + "", "HH:mm");
                }

            } else {

                showtime = long2Date(timeStamp + "", "yyyy/MM/dd \nHH:mm");

            }

        } catch (NumberFormatException e) {
            com.linzi.xiguwen.utils.LogUtil.printStackTrace(e);
        } catch (ParseException e) {
            com.linzi.xiguwen.utils.LogUtil.printStackTrace(e);
        }

        return showtime;

    }

    /**
     * 将毫秒数换算成x天x时x分x秒
     *
     * @param ms
     * @return x天x时x分x秒
     */
    public static String format(long ms) {
        int ss = 1;// ss=1时传入秒单位 =1000时
        int mi = ss * 60;
        int hh = mi * 60;
        int dd = hh * 24;

        long day = ms / dd;
        long hour = (ms - day * dd) / hh;
        long minute = (ms - day * dd - hour * hh) / mi;
        long second = (ms - day * dd - hour * hh - minute * mi) / ss;
        long milliSecond = ms - day * dd - hour * hh - minute * mi - second * ss;

        // String strDay = day < 10 ? "0" + day : "" + day;
        // String strHour = hour < 10 ? "0" + hour : "" + hour;

        String strDay = day < 1 ? "" : "" + day + "天";
        String strHour = hour < 1 ? "" : "" + hour + "小时";

        String strMinute = minute < 10 ? "0" + minute : "" + minute;
        String strSecond = second < 10 ? "0" + second : "" + second;
        String strMilliSecond = milliSecond < 10 ? "0" + milliSecond : "" + milliSecond;
        strMilliSecond = milliSecond < 100 ? "0" + strMilliSecond : "" + strMilliSecond;// 毫秒
        // return strDay + strHour + strMinute + "分" + strSecond + "秒";
        return strDay + strHour + strMinute + "分";
    }

    // 是否是手机号码
    public static boolean isMobileNO(String mobile) {
        Pattern p = Pattern.compile("^[1][3-8]+\\d{9}$");
        Matcher m = p.matcher(mobile);
        return m.matches();
    }

    // 是否是身份证号码
    public static boolean isIdcard(String mobile) {
        Pattern p = Pattern.compile("(\\d{14}[0-9a-zA-Z])|(\\d{17}[0-9a-zA-Z])");
        Matcher m = p.matcher(mobile);
        return m.matches();
    }

    public static boolean isEmpty(List<?> list) {
        return (list == null || list.size() == 0);
    }

    public static boolean isEmpty(File file) {
        return file == null;
    }

    public static <T> boolean isEmpty(T[] array) {
        return ((array == null) || (array.length) == 0);
    }

    public static boolean isEmpty(String val) {
        if (val == null || val.matches("\\s") || val.length() == 0 || "null".equalsIgnoreCase(val) || "".equals(val)) {
            return true;
        }
        return false;
    }

    public static boolean isApi(String val) {
        if (!isEmpty(val) && val.startsWith("http")) {
            return true;
        }
        return false;
    }

    public static int BigDecimaltoInt(BigDecimal bigDecimal) {

        if (bigDecimal != null) {
            int b = bigDecimal.intValue();
            return b;
        }

        return 0;

    }

    /**
     * 关闭输入法
     */
    public static void clearInputMethod(View v) {

        InputMethodManager imm = (InputMethodManager) v.getContext().getSystemService(Context.INPUT_METHOD_SERVICE);
        imm.hideSoftInputFromWindow(v.getWindowToken(), 0);
    }

    /**
     * 打开输入法
     *
     * @param v
     */
    public static void openInputMethoe(View v) {
        InputMethodManager inputMethodManager = (InputMethodManager) v.getContext()
                .getSystemService(Context.INPUT_METHOD_SERVICE);
        // 接受软键盘输入的编辑文本或其它视图
        inputMethodManager.showSoftInput(v, InputMethodManager.SHOW_FORCED);
    }

    /**
     * ScrollView中EditText导致自动滚动问题
     *
     * @param activity
     * @param ScrollViewId
     */
    public static void initScrollview(Activity activity, int ScrollViewId) {
        ScrollView view = (ScrollView) activity.findViewById(ScrollViewId);
        view.setDescendantFocusability(ViewGroup.FOCUS_BEFORE_DESCENDANTS);
        view.setFocusable(true);
        view.setFocusableInTouchMode(true);
        view.setOnTouchListener(new View.OnTouchListener() {
            @Override
            public boolean onTouch(View v, MotionEvent event) {
                v.requestFocusFromTouch();
                return false;
            }
        });
    }

    /**
     * 检测当的网络（WLAN、3G/2G）状态
     *
     * @param context Context
     * @return true 表示网络可用
     */
    public static boolean isNetworkAvailable(Context context) {
        ConnectivityManager connectivity = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);
        if (connectivity != null) {
            NetworkInfo info = connectivity.getActiveNetworkInfo();
            if (info != null && info.isConnected()) {
                // 当前网络是连接的
                if (info.getState() == NetworkInfo.State.CONNECTED) {
                    // 当前所连接的网络可用
                    return true;
                }
            }
        }
        return false;
    }

    /**
     * textView设置不同颜色
     *
     * @param activity
     * @param colorID  不同颜色
     * @param str      整段String
     * @param colorStr 需要改变颜色的的string
     * @return SpannableStringBuilder
     */
    public static void setTextColorStyle(Activity activity, TextView textView, int colorID, String str,
                                         String... colorStr) {

        SpannableStringBuilder style = new SpannableStringBuilder(str);
        for (int i = 0; i < colorStr.length; i++) {

            int fstart = str.indexOf(colorStr[i]);
            int fend = fstart + colorStr[i].length();
            style.setSpan(new ForegroundColorSpan(activity.getResources().getColor(colorID)), fstart, fend,
                    Spannable.SPAN_EXCLUSIVE_INCLUSIVE);
        }

        textView.setText(style);
    }

    /**
     * @param context
     * @param tv
     * @param str
     * @param color
     */
    public static void setText(Context context, TextView tv, ArrayList<String> str, ArrayList<Integer> color) {
        // 累加数组所有的字符串为一个字符串
        StringBuffer long_str = new StringBuffer();
        for (int i = 0; i < str.size(); i++) {
            long_str.append(str.get(i));
        }
        SpannableString builder = new SpannableString(long_str.toString());

        ArrayList<ForegroundColorSpan> foregroundColorSpans = new ArrayList<ForegroundColorSpan>();
        for (int i = 0; i < color.size(); i++) {
            foregroundColorSpans.add(new ForegroundColorSpan(color.get(i)));
        }
        for (int i = 0; i < str.size(); i++) {
            // long_str.toString().contains(str.get(i));
            int star = long_str.toString().indexOf(str.get(i));
            int end = star + str.get(i).length();
            builder.setSpan(foregroundColorSpans.get(i), star, end, Spannable.SPAN_EXCLUSIVE_EXCLUSIVE);
        }

        tv.setHighlightColor(Color.TRANSPARENT);
        tv.setClickable(true);
        tv.setMovementMethod(LinkMovementMethod.getInstance());
        tv.setText(builder);
    }



    /**
     * 判断是否为数字
     *
     * @param str
     * @return
     */
    public static boolean isNumeric(String str) {
        Pattern pattern = Pattern.compile("[0-9]*");
        Matcher isNum = pattern.matcher(str);
        if (!isNum.matches()) {
            return false;
        }
        return true;
    }

    /***
     * 获取版本号
     *
     * @param context
     * @return 版本号
     * @throws Exception
     */
    public static int getVersionCode(Activity context) throws Exception {
        // 获取packagemanager的实例
        PackageManager packageManager = context.getPackageManager();
        // getPackageName()是你当前类的包名，0代表是获取版本信息
        PackageInfo packInfo = packageManager.getPackageInfo(context.getPackageName(), 0);
        int version = packInfo.versionCode;
        return version;
    }

    /**
     * 获取版本名称
     *
     * @param context
     * @return
     * @throws Exception
     */
    public static String getVersionName(Context context) throws Exception {
        // 获取packagemanager的实例
        PackageManager packageManager = context.getPackageManager();
        // getPackageName()是你当前类的包名，0代表是获取版本信息
        PackageInfo packInfo = packageManager.getPackageInfo(context.getPackageName(), 0);
        String versionName = packInfo.versionName;
        return versionName;
    }

    /**
     * 判断mainTabActivity是否在栈顶
     *
     * @param activity
     * @return
     */
    public static boolean isAppOnForeground(Context activity) {

        ActivityManager mActivityManager = ((ActivityManager) activity.getSystemService(Context.ACTIVITY_SERVICE));
        String mPackageName = MainActivity.class.getName();

        List<RunningTaskInfo> tasksInfo = mActivityManager.getRunningTasks(1);

        if (tasksInfo.size() > 0) {
            // 应用程序位于堆栈的顶层
            if (mPackageName.equals(tasksInfo.get(0).topActivity.getClassName())) {
                return true;
            }
        }
        return false;
    }

    /***
     * 判断是否打开MainTabActivity
     *
     * @param activity
     * @return
     */
    public static boolean isHasMainTabActivity(Context activity) {

        ActivityManager mActivityManager = ((ActivityManager) activity.getSystemService(Context.ACTIVITY_SERVICE));
        String mPackageName = MainActivity.class.getName();

        List<RunningTaskInfo> tasksInfo = mActivityManager.getRunningTasks(1);

        for (int i = 0; i < tasksInfo.size(); i++) {

            if (mPackageName.equals(tasksInfo.get(i).topActivity.getClassName())) {

                return true;
            }
        }

        return false;
    }

    /**
     * 得到屏幕真实高度包含NavigationBar
     *
     * @param activity
     * @return
     */
    public static int getScreentHeight(Activity activity) {
        int heightPixels;
        WindowManager w = activity.getWindowManager();
        Display d = w.getDefaultDisplay();
        DisplayMetrics metrics = new DisplayMetrics();
        d.getMetrics(metrics);
        // since SDK_INT = 1;
        heightPixels = metrics.heightPixels;
        // includes window decorations (statusbar bar/navigation bar)
        if (Build.VERSION.SDK_INT >= 14 && Build.VERSION.SDK_INT < 17)
            try {
                heightPixels = (Integer) Display.class.getMethod("getRawHeight").invoke(d);
            } catch (Exception ignored) {
            }
            // includes window decorations (statusbar bar/navigation bar)
        else if (Build.VERSION.SDK_INT >= 17)
            try {
                android.graphics.Point realSize = new android.graphics.Point();
                Display.class.getMethod("getRealSize", android.graphics.Point.class).invoke(d, realSize);
                heightPixels = realSize.y;
            } catch (Exception ignored) {
            }
        return heightPixels;
    }

    public String[] getCpuInfo() {
        String str1 = "/proc/cpuinfo";
        String str2 = "";
        String[] cpuInfo = {"", ""};
        String[] arrayOfString;
        try {
            FileReader fr = new FileReader(str1);
            BufferedReader localBufferedReader = new BufferedReader(fr, 8192);
            str2 = localBufferedReader.readLine();
            arrayOfString = str2.split("\\s+");
            for (int i = 2; i < arrayOfString.length; i++) {
                cpuInfo[0] = cpuInfo[0] + arrayOfString[i] + " ";
            }
            str2 = localBufferedReader.readLine();
            arrayOfString = str2.split("\\s+");
            cpuInfo[1] += arrayOfString[2];
            localBufferedReader.close();
        } catch (IOException e) {
        }
        return cpuInfo;
    }

    public String[] getVersion() {
        String[] version = {"null", "null", "null", "null"};
        String str1 = "/proc/version";
        String str2;
        String[] arrayOfString;
        try {
            FileReader localFileReader = new FileReader(str1);
            BufferedReader localBufferedReader = new BufferedReader(localFileReader, 8192);
            str2 = localBufferedReader.readLine();
            arrayOfString = str2.split("\\s+");
            version[0] = arrayOfString[2];// KernelVersion
            localBufferedReader.close();
        } catch (IOException e) {
        }
        version[1] = Build.VERSION.RELEASE;// firmware version
        version[2] = Build.MODEL;// model
        version[3] = Build.DISPLAY;// system version
        return version;
    }

    public static String getRandomString(int length) { // length表示生成字符串的长度
        String base = "abcdefghijklmnopqrstuvwxyz0123456789";
        Random random = new Random();
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < length; i++) {
            int number = random.nextInt(base.length());
            sb.append(base.charAt(number));
        }
        return sb.toString();
    }

    /**
     * 判断 用户是否安装QQ客户端
     */
    public static boolean isApkInstalledQQ(Context context) {
        final PackageManager packageManager = context.getPackageManager();
        List<PackageInfo> pinfo = packageManager.getInstalledPackages(0);
        if (pinfo != null) {
            for (int i = 0; i < pinfo.size(); i++) {
                String pn = pinfo.get(i).packageName;
                if (pn.equalsIgnoreCase("com.tencent.qqlite") || pn.equalsIgnoreCase("com.tencent.mobileqq")) {
                    return true;
                }
            }
        }
        return false;
    }

    /**
     * 启动qq
     *
     * @param context
     * @param QQCode  qq号码
     */
    public static void startQQ(Context context, String QQCode) {
        String url = "mqqwpa://im/chat?chat_type=wpa&uin=" + QQCode;
        context.startActivity(new Intent(Intent.ACTION_VIEW, Uri.parse(url)));
    }

    /***
     * 清除webview缓存
     *
     * @param dir
     * @param numDays
     * @return
     */
    public static int clearCacheFolder(File dir, long numDays) {
        int deletedFiles = 0;
        if (dir != null && dir.isDirectory()) {
            try {
                for (File child : dir.listFiles()) {
                    if (child.isDirectory()) {
                        deletedFiles += clearCacheFolder(child, numDays);
                    }
                    if (child.lastModified() < numDays) {
                        if (child.delete()) {
                            deletedFiles++;
                        }
                    }
                }
            } catch (Exception e) {
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(e);
            }
        }
        return deletedFiles;
    }

    public static String ll(String ssotoken) {
        // ssotoken.replace(oldChar, newChar)
        return ssotoken;
    }

    /**
     * 判断当前应用程序处于前台还是后台
     */
    public static boolean isApplicationBroughtToBackground(final Context context) {
        ActivityManager am = (ActivityManager) context.getSystemService(Context.ACTIVITY_SERVICE);
        List<RunningTaskInfo> tasks = am.getRunningTasks(1);
        if (!tasks.isEmpty()) {
            ComponentName topActivity = tasks.get(0).topActivity;
            if (!topActivity.getPackageName().equals(context.getPackageName())) {
                return true;
            }
        }
        return false;
    }

    /**
     * 判断是否锁屏
     *
     * @param context
     * @return 如果为true，则表示屏幕“亮”了，否则屏幕“暗”了。
     */
    public static boolean isScreeOn(Context context) {
        PowerManager pm = (PowerManager) context.getSystemService(Context.POWER_SERVICE);
        boolean isScreenOn = pm.isScreenOn();
        return isScreenOn;
    }

    /**
     * 判断某个服务是否正在运行的方法
     *
     * @param mContext
     * @param serviceName 是包名+服务的类名（例如：net.loonggg.testbackstage.TestService）
     * @return true代表正在运行，false代表服务没有正在运行
     */
    public boolean isServiceWork(Context mContext, String serviceName) {
        boolean isWork = false;
        ActivityManager myAM = (ActivityManager) mContext.getSystemService(Context.ACTIVITY_SERVICE);
        List<RunningServiceInfo> myList = myAM.getRunningServices(40);
        if (myList.size() <= 0) {
            return false;
        }
        for (int i = 0; i < myList.size(); i++) {
            String mName = myList.get(i).service.getClassName().toString();
            if (mName.equals(serviceName)) {
                isWork = true;
                break;
            }
        }
        return isWork;
    }




    /**
     * 获取视频缩略图
     *
     * @param filePath
     * @return
     */
    public static Bitmap getVideoThumbnail(String filePath) {
        Bitmap bitmap = null;
        MediaMetadataRetriever retriever = new MediaMetadataRetriever();
        try {
            retriever.setDataSource(filePath);
            bitmap = retriever.getFrameAtTime();
        } catch (IllegalArgumentException e) {
            com.linzi.xiguwen.utils.LogUtil.printStackTrace(e);
        } catch (Exception e) {
            com.linzi.xiguwen.utils.LogUtil.printStackTrace(e);
        } finally {
            try {
                retriever.release();
            } catch (Exception e) {
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(e);
            }
        }
        return bitmap;
    }

    /**
     * 取出URl中的参数
     *
     * @param data
     * @return
     */
    public static Map<String, Object> urlSplit(String data) {
        if (AppUtil.isEmpty(data)) {
            return null;
        }
        try {
            int startIndext = data.lastIndexOf("?") + 1;
            data = data.substring(startIndext);
            StringBuffer strbuf = new StringBuffer();
            StringBuffer strbuf2 = new StringBuffer();
            Map<String, Object> map = new HashMap<String, Object>();
            if (AppUtil.isEmpty(data)) {
                return null;
            }
            for (int i = 0; i < data.length(); i++) {

                if (data.substring(i, i + 1).equals("=")) {

                    for (int n = i + 1; n < data.length(); n++) {
                        String str = data.substring(n, n + 1);
                        if ("&".equals(str) || n == data.length() - 1) {
                            map.put(strbuf.toString(), strbuf2);
                            strbuf = new StringBuffer("");
                            strbuf2 = new StringBuffer("");
                            i = n;
                            break;
                        }
                        strbuf2.append(data.substring(n, n + 1));
                    }
                    continue;
                }
                strbuf.append(data.substring(i, i + 1));
            }

            return map;
        } catch (Exception e) {
            com.linzi.xiguwen.utils.LogUtil.printStackTrace(e);
            return null;
        }

    }

    public static boolean isInstallByread(String packageName) {
        return new File("/data/data/" + packageName).exists();
    }



    /**
     * 检测是否安装了微信
     *
     * @param context
     * @return
     */
    public static boolean isWeixinAvilible(Context context) {
        final PackageManager packageManager = context.getPackageManager();// 获取packagemanager
        List<PackageInfo> pinfo = packageManager.getInstalledPackages(0);// 获取所有已安装程序的包信息
        if (pinfo != null) {
            for (int i = 0; i < pinfo.size(); i++) {
                String pn = pinfo.get(i).packageName;
                if (pn.equals("com.tencent.mm")) {
                    return true;
                }
            }
        }

        return false;
    }




    public static String getTime(Date date, String fromat) {
        try {
            SimpleDateFormat format = new SimpleDateFormat(fromat);
            return format.format(date);
        } catch (Exception e) {
            return "";
        }

    }

    public static Date getDate(String dateString, String fromat) {

        try {
            SimpleDateFormat sdf = new SimpleDateFormat(fromat);
            return sdf.parse(dateString);
        } catch (java.text.ParseException e) {
            // TODO Auto-generated catch block
            com.linzi.xiguwen.utils.LogUtil.printStackTrace(e);
            return new Date();
        }

    }



    /**
     * 时间格式化
     *
     * @param dateString   时间
     * @param sourceFormat 将要转化的格式
     * @param toFromat     格式化后的 格式
     * @return
     */
    public static String timeConversion(String dateString, String sourceFormat, String toFromat) {
        String t = "";
        Date date = getDate(dateString, sourceFormat);
        t = getTime(date, toFromat);
        return t;

    }

    public static void setRatingBar(RatingBar bar, float rat) {
        if (rat > 0) {
            bar.setVisibility(View.VISIBLE);
        } else {
            bar.setVisibility(View.GONE);
        }
        bar.setNumStars(Math.round(rat));
        bar.setRating(rat);

    }


}
