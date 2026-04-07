package com.linzi.xiguwen.ui;

import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import androidx.recyclerview.widget.LinearLayoutManager;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.alibaba.fastjson.JSON;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.RichengAdapter;
import com.linzi.xiguwen.adapter.RichengCalAdapter;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.CalendarBean;
import com.linzi.xiguwen.bean.MyScheduleBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.OnRequestSubscribe;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.CallBack;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;
import com.linzi.xiguwen.view.MyGridView;
import com.linzi.xiguwen.view.dateview.ChooseDatePop;
import com.yanzhenjie.recyclerview.swipe.SwipeMenu;
import com.yanzhenjie.recyclerview.swipe.SwipeMenuBridge;
import com.yanzhenjie.recyclerview.swipe.SwipeMenuCreator;
import com.yanzhenjie.recyclerview.swipe.SwipeMenuItem;
import com.yanzhenjie.recyclerview.swipe.SwipeMenuItemClickListener;
import com.yanzhenjie.recyclerview.swipe.SwipeMenuRecyclerView;

import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

public class RichengActivity extends BaseActivity implements CallBack.MainMenuClick {
    @BindView(R.id.tv_day)
    TextView tvDay;
    @BindView(R.id.iv_choose)
    ImageView ivChoose;
    @BindView(R.id.gv_date)
    MyGridView gvDate;
    @BindView(R.id.ll_parent)
    LinearLayout llParent;
    @BindView(R.id.tv_times)
    TextView tvTimes;
    @BindView(R.id.recycle_unComplete)
    SwipeMenuRecyclerView recycleUnComplete;
    @BindView(R.id.ll_uncomplete)
    LinearLayout llUncomplete;
    @BindView(R.id.tv_yiwancheng)
    TextView tvYiwancheng;
    @BindView(R.id.recycle_complete)
    SwipeMenuRecyclerView recycleComplete;
    @BindView(R.id.ll_complete)
    LinearLayout llComplete;
    @BindView(R.id.iv_add)
    ImageView ivAdd;


    int year = 0000, month = 00, day = 00;
    int toyear = 0000, tomonth = 00, today = 00;
    List<CalendarBean> mCalendarList;
    CalendarBean mCalendarBean;
    RichengCalAdapter mCalendarAdapter;

    SimpleDateFormat chineseDateFormat = new SimpleDateFormat(
            "yyyy年MM月dd日");

    Handler mHandler = new Handler() {
        @Override
        public void handleMessage(Message msg) {
            super.handleMessage(msg);
            switch (msg.what) {
                case 0:
                    tvDay.setText(year + "年" + (month + 1) + "月");
                    setMonthData();
                    break;
            }
        }
    };

    RichengAdapter mAdapter_Com;
    RichengAdapter mAdapter_UnCom;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_richeng);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        setTitle("日程安排");
        setBack();
        EventBusUtil.register(this);
        Calendar calendar = Calendar.getInstance();
        toyear = calendar.get(Calendar.YEAR);
        tomonth = calendar.get(Calendar.MONTH);
        today = calendar.get(Calendar.DAY_OF_MONTH);
        year = toyear;
        month = tomonth;
        day = today;

        ivChoose.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
//                new TimeSeletctUtil(RichengActivity.this).isDay(false).setListener(new TimeSeletctUtil.getDataListener() {
//                    @Override
//                    public void getData(int y, int m, int d, String w) {
//                        year = y;
//                        month = m;
//                        setCalendar();
//                        httpDot();
//                    }
//
//                    @Override
//                    public void getToday(int toyear, int tomonth, int today) {
//
//                    }
//
//                    @Override
//                    public void getHous(int hour, int m) {
//
//                    }
//                }).selectDate(llParent);
                createChooseTimePop(llParent);
            }
        });

        mAdapter_Com = new RichengAdapter(mContext, MyScheduleBean.STATE_FINISHED);
        mAdapter_UnCom = new RichengAdapter(mContext, MyScheduleBean.STATE_UNFINISHED);
        LinearLayoutManager manager = new LinearLayoutManager(mContext) {
            @Override
            public boolean canScrollVertically() {
                return false;
            }
        };
        LinearLayoutManager manager1 = new LinearLayoutManager(mContext) {
            @Override
            public boolean canScrollVertically() {
                return false;
            }
        };
        recycleComplete.setLayoutManager(manager);
        recycleUnComplete.setLayoutManager(manager1);
        setSwipeMenu(recycleComplete, mAdapter_Com);
        setSwipeMenu(recycleUnComplete, mAdapter_UnCom);
        recycleComplete.setAdapter(mAdapter_Com);
        recycleUnComplete.setAdapter(mAdapter_UnCom);


        ivAdd.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent = new Intent(mContext, CreateRichengActivity.class);
                String time = year + "" + (month + 1) + "" + day;
                intent.putExtra("time", time);
                startActivity(intent);
            }
        });
        setCalendar();
        requestNetData();
        initEvent();
        httpDot();
    }


    private void initEvent() {
        mAdapter_Com.setmListener(new com.jcodecraeer.xrecyclerview.OnItemClickListener1() {
            @Override
            public void onItemClick(View view, int postion, Object data) {
                MyScheduleBean bean = mAdapter_Com.getDatas().get(postion);
                httpUpdate(bean.getId(), 2);
            }
        });
        mAdapter_UnCom.setmListener(new com.jcodecraeer.xrecyclerview.OnItemClickListener1() {
            @Override
            public void onItemClick(View view, int postion, Object data) {
                MyScheduleBean bean = mAdapter_UnCom.getDatas().get(postion);
                httpUpdate(bean.getId(), 1);
            }
        });

        mAdapter_Com.setmCompileListener(new com.jcodecraeer.xrecyclerview.OnItemClickListener1() {
            @Override
            public void onItemClick(View view, int postion, Object data) {
//                MyScheduleBean bean = mAdapter_Com.getDatas().get(postion);
//                httpUpdate(bean.getId(), 2);
                Intent intent = new Intent(mContext, CreateRichengActivity.class);
                intent.putExtra("data", JSON.toJSONString(data));
                startActivity(intent);
            }
        });
        mAdapter_UnCom.setmCompileListener(new com.jcodecraeer.xrecyclerview.OnItemClickListener1() {
            @Override
            public void onItemClick(View view, int postion, Object data) {
//                MyScheduleBean bean = mAdapter_UnCom.getDatas().get(postion);
//                httpUpdate(bean.getId(), 1);
                Intent intent = new Intent(mContext, CreateRichengActivity.class);
                intent.putExtra("data", JSON.toJSONString(data));
                startActivity(intent);
            }
        });

        mAdapter_Com.setmDeleteListener(new com.jcodecraeer.xrecyclerview.OnItemClickListener1() {
            @Override
            public void onItemClick(View view, int postion, Object data) {
//                MyScheduleBean bean = mAdapter_Com.getDatas().get(postion);
//                httpUpdate(bean.getId(), 2);
                delete(1, mAdapter_Com.getDatas().get(postion).getId(), postion);
            }
        });
        mAdapter_UnCom.setmDeleteListener(new com.jcodecraeer.xrecyclerview.OnItemClickListener1() {
            @Override
            public void onItemClick(View view, int postion, Object data) {
//                MyScheduleBean bean = mAdapter_UnCom.getDatas().get(postion);
//                httpUpdate(bean.getId(), 1);
                delete(2, mAdapter_UnCom.getDatas().get(postion).getId(), postion);
            }
        });
    }

    private void setCalendar() {

//        mCalendarList = new ArrayList<>();
//        mCalendarAdapter = new RichengCalAdapter(mContext, mCalendarList, this, year, month);
//        gvDate.setAdapter(mCalendarAdapter);

        if (mCalendarList == null) {
            mCalendarList = new ArrayList<>();
        }
        if (mCalendarAdapter == null) {
            mCalendarAdapter = new RichengCalAdapter(mContext, mCalendarList, this, year, month);
            gvDate.setAdapter(mCalendarAdapter);
        } else {
            mCalendarAdapter.setData(mCalendarList, year, month);
        }

        mHandler.sendEmptyMessage(0);
//        LoadDialog.showDialog(this);
//        requestNetData();
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


    /**
     * 请求网络数据
     */
    private void requestNetData() {

        // 清空列表
        mAdapter_Com.setDatas(null);
        mAdapter_UnCom.setDatas(null);
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        Calendar calendar = Calendar.getInstance();
        calendar.set(year, month, day);
        ApiManager.getScheduleList(formatter.format(calendar.getTime()), new OnRequestFinish<BaseBean<List<MyScheduleBean>>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<List<MyScheduleBean>> data) {
                // 获取到日程列表
                List<MyScheduleBean> finishDatas = new ArrayList<>();
                List<MyScheduleBean> unfinishDatas = new ArrayList<>();

                for (MyScheduleBean bean : data.getData()) {
                    if (bean.getIsend() == MyScheduleBean.STATE_FINISHED) {
                        // 已完成
                        finishDatas.add(bean);
                    } else {
                        unfinishDatas.add(bean);
                    }
                }

                mAdapter_Com.setDatas(finishDatas);
                mAdapter_UnCom.setDatas(unfinishDatas);
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
            }
        });
    }


    @Override
    public void itemClick(int id) {
        if (mCalendarList != null) {

            for (int x = 0; x < mCalendarList.size(); x++) {
                if (id == mCalendarList.get(x).getId()) {
                    mCalendarList.get(x).setChecked(true);
                    day = Integer.valueOf(mCalendarList.get(x).getData());
                } else {
                    mCalendarList.get(x).setChecked(false);
                }
            }
            mCalendarAdapter.notifyDataSetChanged();
            //日期点击时候的操作。
            LoadDialog.showDialog(this);
            requestNetData();
        }
    }


    private void httpUpdate(int id, int status) {
        LoadDialog.showDialog(this);
        ApiManager.richengUpdatae(id, status, new OnRequestSubscribe<BaseBean<String>>() {
            @Override
            public void onSuccess(BaseBean<String> data) {
                requestNetData();
            }

            @Override
            public void onError(Exception ex) {
                LoadDialog.CancelDialog();
                NToast.show(ex.getMessage());
            }
        });
    }


    private void setSwipeMenu(final SwipeMenuRecyclerView recycle, final RichengAdapter adapter) {
        recycle.setSwipeMenuCreator(new SwipeMenuCreator() {
            @Override
            public void onCreateMenu(SwipeMenu swipeLeftMenu, SwipeMenu swipeRightMenu, int viewType) {
                SwipeMenuItem editItem = new SwipeMenuItem(mContext);
                editItem.setBackgroundColor(Color.parseColor("#A9A9A9"));
                editItem.setText("编辑");
                editItem.setTextColorResource(R.color.colorWhite);
                editItem.setHeight(ViewGroup.LayoutParams.MATCH_PARENT);
                editItem.setWidth((int) (getResources().getDisplayMetrics().density * 80));
                swipeRightMenu.addMenuItem(editItem);

                SwipeMenuItem deleteItem = new SwipeMenuItem(mContext);
                deleteItem.setBackgroundColorResource(R.color.red_color);
                deleteItem.setText("删除");
                deleteItem.setTextColorResource(R.color.colorWhite);
                deleteItem.setHeight(ViewGroup.LayoutParams.MATCH_PARENT);
                deleteItem.setWidth((int) (getResources().getDisplayMetrics().density * 80));
                swipeRightMenu.addMenuItem(deleteItem);
            }
        });
        recycle.setSwipeMenuItemClickListener(new SwipeMenuItemClickListener() {
            @Override
            public void onItemClick(SwipeMenuBridge menuBridge) {
                menuBridge.closeMenu();
                int adapterPosition = menuBridge.getAdapterPosition();
                int menuPosition = menuBridge.getPosition();
                if (adapter.getDatas() == null || adapterPosition < 0 || adapterPosition >= adapter.getDatas().size()) {
                    return;
                }
                if (menuPosition == 0) {
                    if (adapter.getmCompileListener() != null) {
                        adapter.getmCompileListener().onItemClick(recycle, adapterPosition, adapter.getDatas().get(adapterPosition));
                    }
                } else if (menuPosition == 1) {
                    if (adapter.getmDeleteListener() != null) {
                        adapter.getmDeleteListener().onItemClick(recycle, adapterPosition, adapter.getDatas().get(adapterPosition));
                    }
                }
            }
        });
    }

    private void delete(final int type, int id, final int position) {
        LoadDialog.showDialog(this);
        ApiManager.delSchedule(id, new OnRequestSubscribe<BaseBean<String>>() {
            @Override
            public void onSuccess(BaseBean<String> data) {
                LoadDialog.CancelDialog();
                NToast.show(data.getMessage());
                if (type == 2) {
                    mAdapter_UnCom.getDatas().remove(position);
                    mAdapter_UnCom.notifyDataSetChanged();
                } else if (type == 1) {
                    mAdapter_Com.getDatas().remove(position);
                    mAdapter_Com.notifyDataSetChanged();
                }
            }

            @Override
            public void onError(Exception ex) {
                LoadDialog.CancelDialog();
                NToast.show(ex.getMessage());
            }
        });

    }

    private void httpDot() {
        String time = year + "-" + (month+1);
//        AppUtil.timeToLong(time, "yyyy-MM-dd");
        ApiManager.getScheduleLDot(time, new OnRequestSubscribe<BaseBean<List<String>>>() {
            @Override
            public void onSuccess(BaseBean<List<String>> data) {
                List<String> dot = data.getData();
                mCalendarAdapter.setDot(dot);
            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        EventBusUtil.unregister(this);
    }

    @Subscribe(threadMode = ThreadMode.MAIN)
    public void receiveEvent(Event entity) {
        if (entity == null)
            return;
        try {
            int code = entity.getCode();
            switch (code) {
                case EventCode.SCHEDULE_ADD_SUCCESS:
                    httpDot();
                    LoadDialog.showDialog(this);
                    requestNetData();
                    break;

            }
        } catch (Exception e) {
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
                month =  Integer.parseInt(date.split("-")[1])-1;
                setCalendar();
                httpDot();
                // 清空列表
                mAdapter_Com.setDatas(null);
                mAdapter_UnCom.setDatas(null);


            }
        });
    }
}
