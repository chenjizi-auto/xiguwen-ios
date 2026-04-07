package com.linzi.xiguwen.utils;

import android.app.Activity;
import android.content.Context;
import android.graphics.drawable.ColorDrawable;
import androidx.appcompat.app.AppCompatActivity;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewTreeObserver;
import android.view.WindowManager;
import android.widget.LinearLayout;
import android.widget.PopupWindow;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.MyDateBean;
import com.linzi.xiguwen.view.ScrollerDatePicker;

import java.util.ArrayList;
import java.util.Calendar;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/1/25.
 */

public class TimeSeletctUtil {
    private int year = 0000, month = 00, day = 00;
    private int toyear = 0000, tomonth = 00, today = 00, hour = 00, m = 00;
    private String when = "";
    private Activity mActivity;
    private Context mContext;
    private getDataListener mListener;
    private OnCancelListener mCancelListener;

    private boolean isWhen = false;
    private boolean isPsue = false;
    private boolean isDay = true;
    private boolean isHours = false;

    public interface getDataListener {
        public void getData(int year, int month, int day, String when);

        public void getToday(int toyear, int tomonth, int today);

        public void getHous(int hour, int m);
    }

    public interface OnCancelListener {
        void onCancel(TimeSeletctUtil utils);
    }

    public TimeSeletctUtil(Activity activity) {
        Calendar calendar = Calendar.getInstance();
        toyear = calendar.get(Calendar.YEAR);
        tomonth = calendar.get(Calendar.MONTH);
        today = calendar.get(Calendar.DAY_OF_MONTH);
        year = toyear;
        month = tomonth;
        day = today;
        mActivity = activity;
        mContext = mActivity;
    }

    public TimeSeletctUtil(Activity activity, int year, int month, int day) {
        Calendar calendar = Calendar.getInstance();
        toyear = calendar.get(Calendar.YEAR);
        tomonth = calendar.get(Calendar.MONTH);
        today = calendar.get(Calendar.DAY_OF_MONTH);
        this.year = year;
        this.month = month - 1;
        this.day = day;
        mActivity = activity;
        mContext = mActivity;
    }

    public TimeSeletctUtil setListener(getDataListener listener) {
        mListener = listener;
        return this;
    }

    public TimeSeletctUtil setOnCancelListener(OnCancelListener listener) {
        mCancelListener = listener;
        return this;
    }

    public TimeSeletctUtil isWhen(boolean is) {
        isWhen = is;
        return this;
    }

    public TimeSeletctUtil isPase(boolean is) {
        isPsue = is;
        return this;
    }

    public TimeSeletctUtil isDay(boolean is) {
        isDay = is;
        if (is == false) {
            isWhen = is;
        }
        return this;
    }

    public TimeSeletctUtil selectDate(View llParent) {
        ArrayList<MyDateBean> year_list = new ArrayList<>();
        ArrayList<MyDateBean> month_list = new ArrayList<>();
        final ArrayList<MyDateBean> day_list = new ArrayList<>();
        final ArrayList<MyDateBean> when_list = new ArrayList<>();
        MyDateBean mBean;
        int years = 0;
        int year_tag = 0;
        int month_tag = 0;
        int day_tag = 0;
        for (int x = 0; x < 100; x++) {
            years = 2000 + x;
            mBean = new MyDateBean();
            mBean.setId(x);
            mBean.setDate("" + years+"年");
            year_list.add(mBean);
            if (years == year) {
                year_tag = x;
            }
        }
        for (int x = 0; x < 12; x++) {
            mBean = new MyDateBean();
            mBean.setId(x);
            if ((x + 1) < 10) {
                mBean.setDate("0" + (x + 1)+"月");
            } else {
                mBean.setDate("" + (x + 1)+"月");
            }
            month_list.add(mBean);
            if (x == month) {
                month_tag = x;
            }
        }

        int max_day_num = getDaysByYearMonth(year, month + 1);
        for (int x = 0; x < max_day_num; x++) {
            mBean = new MyDateBean();
            mBean.setId(x);
            if ((x + 1) < 10) {
                mBean.setDate("0" + (x + 1)+"日");
            } else {
                mBean.setDate("" + (x + 1)+"日");
            }
            day_list.add(mBean);
            if ((x + 1) == day) {
                day_tag = x;
            }
        }
        for (int x = 0; x < 4; x++) {
            mBean = new MyDateBean();
            mBean.setId(x);
            switch (x) {
                case 0:
                    mBean.setDate("上午");
                    break;
                case 1:
                    mBean.setDate("中午");
                    break;
                case 2:
                    mBean.setDate("下午");
                    break;
                case 3:
                    mBean.setDate("晚上");
                    break;
            }
            when_list.add(mBean);
        }
        final PopupWindow pop = new PopupWindow(mContext);
        View view = LayoutInflater.from(mContext).inflate(R.layout.pop_richeng_select_date_layout, null);
        final ViewHolder vh = new ViewHolder(view);

        ViewTreeObserver viewTreeObserver = vh.pickYear.getViewTreeObserver();
        viewTreeObserver.addOnGlobalLayoutListener(new ViewTreeObserver.OnGlobalLayoutListener() {
            @Override
            public void onGlobalLayout() {
                vh.pickYear.getViewTreeObserver().removeGlobalOnLayoutListener(this);
                vh.pickYear.setControlWidth(vh.pickYear.getWidth(), vh.pickYear.getHeight());
                vh.pickMonth.setControlWidth(vh.pickYear.getWidth(), vh.pickYear.getHeight());
                vh.pickDay.setControlWidth(vh.pickYear.getWidth(), vh.pickYear.getHeight());
                vh.pickWhen.setControlWidth(vh.pickYear.getWidth(), vh.pickYear.getHeight());
            }
        });

        if (isWhen) {
            vh.llWhen.setVisibility(View.VISIBLE);
            when = vh.pickWhen.getSelectedText();
        } else {
            vh.llWhen.setVisibility(View.GONE);
            when = "";
            if (isDay) {
                LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT);
                params.setMargins(dip2px(mContext, 40), 0, dip2px(mContext, 40), 0);
                vh.llPop.setLayoutParams(params);
            } else {
                LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT);
                params.setMargins(dip2px(mContext, 60), 0, dip2px(mContext, 60), 0);
                vh.llPop.setLayoutParams(params);
            }
        }
        if (isDay) {
            vh.llDay.setVisibility(View.VISIBLE);
        } else {
            vh.llDay.setVisibility(View.GONE);
            LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT);
            params.setMargins(dip2px(mContext, 60), 0, dip2px(mContext, 60), 0);
            vh.llPop.setLayoutParams(params);
        }


        vh.tvClose.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (mCancelListener != null) {
                    mCancelListener.onCancel(TimeSeletctUtil.this);
                }
                pop.dismiss();
            }
        });
        vh.tvSubmit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                year = Integer.valueOf(vh.pickYear.getSelectedText().replace("年",""));
                month = Integer.valueOf(vh.pickMonth.getSelectedText().replace("月","")) - 1;
                day = Integer.valueOf(vh.pickDay.getSelectedText().replace("日",""));
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

                int y = Integer.valueOf(vh.pickYear.getSelectedText().replace("年",""));
                int m = Integer.valueOf(vh.pickMonth.getSelectedText().replace("月",""));
                int d = Integer.valueOf(vh.pickDay.getSelectedText().replace("日",""));
                if (isPsue) {
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
                if (mListener != null) {
                    mListener.getData(year, month, day, when);
                    mListener.getToday(toyear, tomonth, today);
                }
                pop.dismiss();
            }
        });
        vh.pickYear.setData(year_list);
        vh.pickMonth.setData(month_list);
        vh.pickDay.setData(day_list);
        vh.pickWhen.setData(when_list);

        vh.pickYear.setDefault(year_tag);
        vh.pickMonth.setDefault(month_tag);
        vh.pickDay.setDefault(day_tag);

        vh.pickYear.setOnSelectListener(new ScrollerDatePicker.OnSelectListener() {
            @Override
            public void endSelect(int id, String text) {
                year = Integer.valueOf(text.replace("年",""));
            }

            @Override
            public void selecting(int id, String text) {
            }
        });
        final int finalDay_tag = day_tag;
        vh.pickMonth.setOnSelectListener(new ScrollerDatePicker.OnSelectListener() {
            @Override
            public void endSelect(int id, String text) {
                month = Integer.valueOf(text.replace("月","")) - 1;
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
        int w = mActivity.getWindowManager().getDefaultDisplay().getWidth();
        int h = (mActivity.getWindowManager().getDefaultDisplay().getHeight() / 5) * 2;
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

        return this;
    }


    public TimeSeletctUtil selectBirthDate(View llParent) {
        ArrayList<MyDateBean> year_list = new ArrayList<>();
        ArrayList<MyDateBean> month_list = new ArrayList<>();
        final ArrayList<MyDateBean> day_list = new ArrayList<>();
        final ArrayList<MyDateBean> when_list = new ArrayList<>();
        MyDateBean mBean;
        int years = 0;
        int year_tag = 0;
        int month_tag = 0;
        int day_tag = 0;
        for (int x = 0; x < 110; x++) {
            years = toyear - x;
            mBean = new MyDateBean();
            mBean.setId(x);
            mBean.setDate("" + years+"年");
            year_list.add(mBean);
            if (years == year) {
                year_tag = x;
            }
        }
        for (int x = 0; x < 12; x++) {
            mBean = new MyDateBean();
            mBean.setId(x);
            if ((x + 1) < 10) {
                mBean.setDate("0" + (x + 1)+"月");
            } else {
                mBean.setDate("" + (x + 1)+"月");
            }
            month_list.add(mBean);
            if (x == month) {
                month_tag = x;
            }
        }

        int max_day_num = getDaysByYearMonth(year, (month + 1));
        for (int x = 0; x < max_day_num; x++) {
            mBean = new MyDateBean();
            mBean.setId(x);
            if ((x + 1) < 10) {
                mBean.setDate("0" + (x + 1)+"日");
            } else {
                mBean.setDate("" + (x + 1)+"日");
            }
            day_list.add(mBean);
            if ((x + 1) == day) {
                day_tag = x;
            }
        }
        for (int x = 0; x < 4; x++) {
            mBean = new MyDateBean();
            mBean.setId(x);
            switch (x) {
                case 0:
                    mBean.setDate("上午");
                    break;
                case 1:
                    mBean.setDate("中午");
                    break;
                case 2:
                    mBean.setDate("下午");
                    break;
                case 3:
                    mBean.setDate("晚上");
                    break;
            }
            when_list.add(mBean);
        }
        final PopupWindow pop = new PopupWindow(mContext);
        View view = LayoutInflater.from(mContext).inflate(R.layout.pop_richeng_select_date_layout, null);
        final ViewHolder vh = new ViewHolder(view);

        ViewTreeObserver viewTreeObserver = vh.pickYear.getViewTreeObserver();
        viewTreeObserver.addOnGlobalLayoutListener(new ViewTreeObserver.OnGlobalLayoutListener() {
            @Override
            public void onGlobalLayout() {
                vh.pickYear.getViewTreeObserver().removeGlobalOnLayoutListener(this);
                vh.pickYear.setControlWidth(vh.pickYear.getWidth(), vh.pickYear.getHeight());
                vh.pickMonth.setControlWidth(vh.pickYear.getWidth(), vh.pickYear.getHeight());
                vh.pickDay.setControlWidth(vh.pickYear.getWidth(), vh.pickYear.getHeight());
                vh.pickWhen.setControlWidth(vh.pickYear.getWidth(), vh.pickYear.getHeight());
            }
        });

        if (isWhen) {
            vh.llWhen.setVisibility(View.VISIBLE);
            when = vh.pickWhen.getSelectedText();
        } else {
            vh.llWhen.setVisibility(View.GONE);
            when = "";
            if (isDay) {
                LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT);
                params.setMargins(dip2px(mContext, 40), 0, dip2px(mContext, 40), 0);
                vh.llPop.setLayoutParams(params);
            } else {
                LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT);
                params.setMargins(dip2px(mContext, 60), 0, dip2px(mContext, 60), 0);
                vh.llPop.setLayoutParams(params);
            }
        }
        if (isDay) {
            vh.llDay.setVisibility(View.VISIBLE);
        } else {
            vh.llDay.setVisibility(View.GONE);
            LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT);
            params.setMargins(dip2px(mContext, 60), 0, dip2px(mContext, 60), 0);
            vh.llPop.setLayoutParams(params);
        }


        vh.tvClose.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (mCancelListener != null) {
                    mCancelListener.onCancel(TimeSeletctUtil.this);
                }
                pop.dismiss();
            }
        });
        vh.tvSubmit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                year = Integer.valueOf(vh.pickYear.getSelectedText().replace("年",""));
                month = Integer.valueOf(vh.pickMonth.getSelectedText().replace("月","")) - 1;
                day = Integer.valueOf(vh.pickDay.getSelectedText().replace("日",""));
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

                int y = Integer.valueOf(vh.pickYear.getSelectedText().replace("年",""));
                int m = Integer.valueOf(vh.pickMonth.getSelectedText().replace("月","")) - 1;
                int d = Integer.valueOf(vh.pickDay.getSelectedText().replace("日",""));
                if (isPsue) {
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
                if (mListener != null) {
                    mListener.getData(year, month, day, when);
                    mListener.getToday(toyear, tomonth, today);
                }
                pop.dismiss();
            }
        });
        vh.pickYear.setData(year_list);
        vh.pickMonth.setData(month_list);
        vh.pickDay.setData(day_list);
        vh.pickWhen.setData(when_list);

        vh.pickYear.setDefault(year_tag);
        vh.pickMonth.setDefault(month_tag);
        vh.pickDay.setDefault(day_tag);

        vh.pickYear.setOnSelectListener(new ScrollerDatePicker.OnSelectListener() {
            @Override
            public void endSelect(int id, String text) {
                year = Integer.valueOf(text.replace("年",""));
            }

            @Override
            public void selecting(int id, String text) {
            }
        });
        final int finalDay_tag = day_tag;
        vh.pickMonth.setOnSelectListener(new ScrollerDatePicker.OnSelectListener() {
            @Override
            public void endSelect(int id, String text) {
                month = Integer.valueOf(text.replace("月","")) - 1; // 当前月应该为显示月数-1，从0 开始
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
        int w = mActivity.getWindowManager().getDefaultDisplay().getWidth();
        int h = (mActivity.getWindowManager().getDefaultDisplay().getHeight() / 5) * 2;
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

        return this;
    }


    public TimeSeletctUtil getTime(View llParent) {
        ArrayList<MyDateBean> am_list = new ArrayList<>();
        ArrayList<MyDateBean> hour_list = new ArrayList<>();
        ArrayList<MyDateBean> min_list = new ArrayList<>();
        MyDateBean mBean;

        for (int x = 0; x < 2; x++) {
            mBean = new MyDateBean();
            mBean.setId(x);
            if (x == 0) {
                mBean.setDate("上午");
            } else {
                mBean.setDate("下午");
            }
            am_list.add(mBean);

        }
        for (int x = 0; x < 24; x++) {
            mBean = new MyDateBean();
            mBean.setId(x);
            if (x < 10) {
                mBean.setDate("0" + (x)+"时");
            } else {
                mBean.setDate("" + (x)+"时");
            }

            hour_list.add(mBean);
        }
        for (int x = 0; x < 60; x++) {
            mBean = new MyDateBean();
            mBean.setId(x);
            if (x < 10) {
                mBean.setDate("0" + (x)+"分");
            } else {
                mBean.setDate("" + (x)+"分");
            }
            min_list.add(mBean);
        }

        final PopupWindow pop = new PopupWindow(mContext);
        View view = LayoutInflater.from(mContext).inflate(R.layout.pop_richeng_select_date_layout, null);
        final ViewHolder vh = new ViewHolder(view);

        ViewTreeObserver viewTreeObserver = vh.pickMonth.getViewTreeObserver();
        viewTreeObserver.addOnGlobalLayoutListener(new ViewTreeObserver.OnGlobalLayoutListener() {
            @Override
            public void onGlobalLayout() {
                vh.pickMonth.getViewTreeObserver().removeGlobalOnLayoutListener(this);
                //vh.pickYear.setControlWidth(vh.pickYear.getWidth(), vh.pickYear.getHeight());
                vh.pickMonth.setControlWidth(vh.pickMonth.getWidth(), vh.pickYear.getHeight());
                vh.pickDay.setControlWidth(vh.pickMonth.getWidth(), vh.pickYear.getHeight());
                //vh.pickWhen.setControlWidth(vh.pickYear.getWidth(), vh.pickYear.getHeight());
            }
        });

        vh.llYear.setVisibility(View.GONE);
        vh.llWhen.setVisibility(View.GONE);

        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT);
        params.setMargins(dip2px(mContext, 60), 0, dip2px(mContext, 60), 0);
        vh.llPop.setLayoutParams(params);

        vh.tvClose.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (mCancelListener != null) {
                    mCancelListener.onCancel(TimeSeletctUtil.this);
                }
                pop.dismiss();
            }
        });
        vh.tvSubmit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String am = vh.pickYear.getSelectedText();
                hour = Integer.valueOf(vh.pickMonth.getSelectedText().replace("时",""));
                m = Integer.valueOf(vh.pickDay.getSelectedText().replace("分",""));

                if (mListener != null) {
                    mListener.getHous(hour, m);
                }

                pop.dismiss();
            }
        });

        vh.tvNian.setText("   ");
        vh.tvYue.setText(" : ");
        vh.tvRi.setText("   ");

        vh.pickYear.setData(am_list);
        vh.pickMonth.setData(hour_list);
        vh.pickDay.setData(min_list);

        vh.pickYear.setDefault(0);
        vh.pickMonth.setDefault(0);
        vh.pickDay.setDefault(0);

        // 设置弹出窗体可点击
        pop.setFocusable(true);
        int w = mActivity.getWindowManager().getDefaultDisplay().getWidth();
        int h = (mActivity.getWindowManager().getDefaultDisplay().getHeight() / 5) * 2;
        pop.setWidth(w);
        pop.setHeight(h);
        // 实例化一个ColorDrawable颜色为半透明
        ColorDrawable dw = new ColorDrawable(0x00000000);
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
        return this;
    }

    private ArrayList<MyDateBean> setDay() {
        ArrayList<MyDateBean> list = new ArrayList<>();
        int max_day_num = getDaysByYearMonth(year, month + 1);
        MyDateBean mBean;
        for (int x = 0; x < max_day_num; x++) {
            mBean = new MyDateBean();
            mBean.setId(x);
            if ((x + 1) < 10) {
                mBean.setDate("0" + (x + 1)+"日");
            } else {
                mBean.setDate("" + (x + 1)+"日");
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
        a.set(Calendar.MONTH, month - 1);
        a.set(Calendar.DATE, 1);
        a.roll(Calendar.DATE, -1);
        int maxDate = a.get(Calendar.DATE);
        return maxDate;
    }

    //将dp转换为px
    public int dip2px(Context context, float dpValue) {
        final float scale = context.getResources().getDisplayMetrics().density;
        return (int) (dpValue * scale + 0.5f);
    }

    private void lightoff(boolean isoff) {
        WindowManager.LayoutParams lp = mActivity.getWindow().getAttributes();
        if (isoff) {
            lp.alpha = 0.3f;
        } else {
            lp.alpha = 1f;
        }
        mActivity.getWindow().setAttributes(lp);
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
        @BindView(R.id.ll_pop)
        LinearLayout llPop;

        ViewHolder(View view) {
            ButterKnife.bind(this, view);
        }
    }
}
