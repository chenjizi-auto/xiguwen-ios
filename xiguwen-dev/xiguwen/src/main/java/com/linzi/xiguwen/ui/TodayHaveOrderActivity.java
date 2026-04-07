package com.linzi.xiguwen.ui;

import android.os.Bundle;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.TodayHaveAdapter;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.CommunityDanEntity;
import com.linzi.xiguwen.net.OnRequestSubscribe;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.network.Constans;
import com.linzi.xiguwen.utils.AppUtil;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.TimeSeletctUtil;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class TodayHaveOrderActivity extends BaseActivity {

    @BindView(R.id.bt_last_day)
    Button btLastDay;
    @BindView(R.id.tv_time)
    TextView tvTime;
    @BindView(R.id.bt_next_day)
    Button btNextDay;
    @BindView(R.id.recycle)
    RecyclerView recycle;
    @BindView(R.id.ll_nodata)
    LinearLayout llNodata;
    @BindView(R.id.ll_parent)
    LinearLayout llParent;
    @BindView(R.id.tv_nodata)
    TextView tvNodata;

    private int year = 0000, month = 00, day = 00;
    private int toyear = 0000, tomonth = 00, today = 00;

    private TodayHaveAdapter mAdapter;

    private int dateIndex;
    private String id;
    private String date;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_today_add_team);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        id = getIntent().getStringExtra("id");
        Calendar calendar = Calendar.getInstance();
        toyear = calendar.get(Calendar.YEAR);
        tomonth = calendar.get(Calendar.MONTH);
        today = calendar.get(Calendar.DAY_OF_MONTH);
        year = toyear;
        month = tomonth + 1;
        day = today;

        setTitle("今日有单");
        setBack();

        tvTime.setText(toyear + "年" + month + "月" + today + "日");
        date = year + "-" + month + "-" + today;

        LinearLayoutManager manager = new LinearLayoutManager(mContext);
        recycle.setLayoutManager(manager);
        mAdapter = new TodayHaveAdapter(mContext);
        recycle.setAdapter(mAdapter);

    }

    @OnClick({R.id.bt_last_day, R.id.tv_time, R.id.bt_next_day})
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.bt_last_day:
                dateIndex--;
                date = getOldDate(date,-1);
//                tvTime.setText(date);
                httpData();
                break;
            case R.id.bt_next_day:
                dateIndex++;
                date = getOldDate(date,1);
//                tvTime.setText(date);
                httpData();
                break;
            case R.id.tv_time:
                new TimeSeletctUtil(TodayHaveOrderActivity.this)
                        .isWhen(false)
                        .setListener(new TimeSeletctUtil.getDataListener() {
                            @Override
                            public void getData(int y, int m, int d, String when) {
                                year = y;
                                month = m + 1;
                                day = d;
                                date = year + "-" + month + "-" + d;
                                tvTime.setText(year + "年" + month + "月" + day + "日");
                                httpData();
                            }

                            @Override
                            public void getToday(int toyear, int tomonth, int today) {

                            }

                            @Override
                            public void getHous(int hour, int m) {

                            }
                        }).selectDate(llParent);
                break;

        }
    }


    private void httpData() {
        LoadDialog.showDialog(this);
        ApiManager.communityDan(id, date, Constans.Action.COMMUNITY_TODAY_ADD_HAOS, new OnRequestSubscribe<BaseBean<List<CommunityDanEntity>>>() {
            @Override
            public void onSuccess(BaseBean<List<CommunityDanEntity>> data) {
                LoadDialog.CancelDialog();
                mAdapter.addData(data.getData());
                if (!AppUtil.isEmpty(data.getData())) {
                    llNodata.setVisibility(View.GONE);
                } else {
                    llNodata.setVisibility(View.VISIBLE);
                    tvNodata.setText("暂无数据");
                }
            }

            @Override
            public void onError(Exception ex) {
                LoadDialog.CancelDialog();
                llNodata.setVisibility(View.VISIBLE);
                tvNodata.setText(ex.getMessage() + "");
            }
        });
    }

    public  String getOldDate(String date, int distanceDay) {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date endDate = null;
        try {
            Date parseDate = simpleDateFormat.parse(date);
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(parseDate);
            calendar.set(Calendar.DATE, calendar.get(Calendar.DATE) + distanceDay);
            toyear = calendar.get(Calendar.YEAR);
            tomonth = calendar.get(Calendar.MONTH)+1;
            today = calendar.get(Calendar.DAY_OF_MONTH);
            tvTime.setText(toyear+"年"+tomonth+"月"+today+"日");
            endDate = simpleDateFormat.parse(simpleDateFormat.format(calendar.getTime()));
        } catch (ParseException e) {
            com.linzi.xiguwen.utils.LogUtil.printStackTrace(e);
        }
        return simpleDateFormat.format(endDate);
    }
}
