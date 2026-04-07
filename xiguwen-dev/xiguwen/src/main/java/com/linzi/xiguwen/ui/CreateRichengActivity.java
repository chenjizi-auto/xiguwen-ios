package com.linzi.xiguwen.ui;

import android.os.Bundle;
import android.text.TextUtils;
import android.view.View;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.alibaba.fastjson.JSON;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.MyScheduleBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.MsgLoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.TimeSeletctUtil;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;

import java.util.Calendar;

import butterknife.BindView;
import butterknife.ButterKnife;

public class CreateRichengActivity extends BaseActivity {

    @BindView(R.id.tv_data)
    TextView tvData;
    @BindView(R.id.ll_data)
    LinearLayout llData;
    @BindView(R.id.tv_start_time)
    TextView tvStartTime;
    @BindView(R.id.ll_start_time)
    LinearLayout llStartTime;
    @BindView(R.id.tv_end_time)
    TextView tvEndTime;
    @BindView(R.id.ll_end_time)
    LinearLayout llEndTime;
    @BindView(R.id.tv_context)
    EditText tvContext;
    @BindView(R.id.ll_parent)
    LinearLayout llParent;

    private String time;

    private int id = -1;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_create_richeng);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        setBack();
        setTitle("新建日程");
        setRight("保存  ", new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (check()) {
                    if (id > 0) {
                        updateOrder();
                    } else {
                        submitOrder();
                    }

                }
            }
        });
        time = getIntent().getStringExtra("time");
        Calendar calendar = Calendar.getInstance();
        int toyear = calendar.get(Calendar.YEAR);
        int tomonth = calendar.get(Calendar.MONTH) + 1;
        int today = calendar.get(Calendar.DAY_OF_MONTH);

        tvData.setText(toyear + "-" + tomonth + "-" + today);
        initIntentData();

//        tvData.setText(time + "");

        llData.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                new TimeSeletctUtil(CreateRichengActivity.this).isWhen(false).isPase(false).setListener(new TimeSeletctUtil.getDataListener() {
                    @Override
                    public void getData(int year, int month, int day, String when) {
                        String date = year + "-";
                        if ((month + 1) < 10) {
                            date = date + "0" + (month + 1) + "-";
                        } else {
                            date = date + (month + 1) + "-";
                        }
                        if ((day + 1) < 10) {
                            date = date + "0" + day;
                        } else {
                            date = date + day;
                        }
                        tvData.setText(date);
                    }

                    @Override
                    public void getToday(int toyear, int tomonth, int today) {

                    }

                    @Override
                    public void getHous(int hour, int m) {

                    }
                }).selectDate(llParent);
            }
        });
        llStartTime.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                new TimeSeletctUtil(CreateRichengActivity.this).setListener(new TimeSeletctUtil.getDataListener() {
                    @Override
                    public void getData(int year, int month, int day, String when) {
                    }

                    @Override
                    public void getToday(int toyear, int tomonth, int today) {

                    }

                    @Override
                    public void getHous(int hour, int m) {
                        String date;
                        if (hour < 10) {
                            date = "0" + hour + ":";
                        } else {
                            date = hour + ":";
                        }
                        if (m < 10) {
                            date = date + "0" + m;
                        } else {
                            date = date + m;
                        }
                        tvStartTime.setText(date);
                    }
                }).getTime(llParent);
            }
        });
        llEndTime.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                new TimeSeletctUtil(CreateRichengActivity.this).setListener(new TimeSeletctUtil.getDataListener() {
                    @Override
                    public void getData(int year, int month, int day, String when) {
                    }

                    @Override
                    public void getToday(int toyear, int tomonth, int today) {

                    }

                    @Override
                    public void getHous(int hour, int m) {
                        String date;
                        if (hour < 10) {
                            date = "0" + hour + ":";
                        } else {
                            date = hour + ":";
                        }
                        if (m < 10) {
                            date = date + "0" + m;
                        } else {
                            date = date + m;
                        }
                        tvEndTime.setText(date);
                    }
                }).getTime(llParent);
            }
        });
    }


    private void initIntentData() {
        String data = getIntent().getStringExtra("data");
        if (data == null) {
            return;
        }
        try {
            MyScheduleBean myScheduleBean = JSON.parseObject(data, MyScheduleBean.class);
            tvData.setText(myScheduleBean.getRiqi() + "");
            tvContext.setText(myScheduleBean.getConn() + "");
            tvStartTime.setText(myScheduleBean.getStatime() + "");
            tvEndTime.setText(myScheduleBean.getEndtime() + "");
            id = myScheduleBean.getId();

        } catch (Exception e) {

        }
    }

    private boolean check() {
        if (TextUtils.isEmpty(tvData.getText().toString().trim())) {
            NToast.show("请选择日期！");
            return false;
        }
        String startTime = tvStartTime.getText().toString();
        String[] sTime = startTime.split(":");
        String endTime = tvEndTime.getText().toString();
        String[] eTime = endTime.split(":");
        if (Integer.valueOf(sTime[0]) > Integer.valueOf(eTime[0])) {
            NToast.show("结束时间应该大于等于开始时间");
            return false;
        } else if (Integer.valueOf(sTime[0]) == Integer.valueOf(eTime[0])) {
            if (Integer.valueOf(sTime[1]) == Integer.valueOf(eTime[1])) {
                NToast.show("结束时间应该大于等于开始时间");
                return false;
            }
        }
        if (TextUtils.isEmpty(tvContext.getText().toString().trim())) {
            NToast.show("日程内容不能为空");
            return false;
        }
        return true;
    }

    /**
     * 提交
     */
    private void submitOrder() {
        MsgLoadDialog.showDialog(this, "保存中...");
        ApiManager.addSchedule(tvContext.getText().toString().trim(), tvData.getText().toString(), tvStartTime.getText().toString(), tvEndTime.getText().toString(), new OnRequestFinish<BaseBean<String>>() {
            @Override
            public void onFinished() {
                MsgLoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<String> data) {
                NToast.show("添加成功");
                EventBusUtil.sendEvent(new Event(EventCode.SCHEDULE_ADD_SUCCESS, 0));
                finish();
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
            }
        });
    }

    private void updateOrder() {
        MsgLoadDialog.showDialog(this, "保存中...");
        ApiManager.editSchedule(id, tvContext.getText().toString().trim(), tvData.getText().toString(), tvStartTime.getText().toString(), tvEndTime.getText().toString(), new OnRequestFinish<BaseBean<String>>() {
            @Override
            public void onFinished() {
                MsgLoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<String> data) {
                NToast.show("添加成功");
                EventBusUtil.sendEvent(new Event(EventCode.SCHEDULE_ADD_SUCCESS, 0));
                finish();
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
            }
        });
    }


}
