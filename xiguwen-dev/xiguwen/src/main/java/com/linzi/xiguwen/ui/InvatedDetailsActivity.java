package com.linzi.xiguwen.ui;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.InvatedDetailsAdapter;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.MineInvitationInfoBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.MsgLoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.TimeSeletctUtil;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class InvatedDetailsActivity extends BaseActivity {

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

    private Calendar mCalendar;
    private SimpleDateFormat mFormat;

    private ArrayList<MineInvitationInfoBean.InvitationDetail> mDatas;
    private InvatedDetailsAdapter mAdapter;

    public static void startActivity(Context context, ArrayList<MineInvitationInfoBean.InvitationDetail> datas, Calendar calendar){
        Intent intent = new Intent(context, InvatedDetailsActivity.class);
        intent.putExtra("data", datas);
        intent.putExtra("calendar", calendar);
        context.startActivity(intent);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_today_add_team);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        mCalendar = (Calendar) getIntent().getSerializableExtra("calendar");
        mDatas = (ArrayList<MineInvitationInfoBean.InvitationDetail>) getIntent().getSerializableExtra("data");
        setTitle("邀请明细");
        setBack();

        if(mCalendar == null){
            mCalendar = Calendar.getInstance();
            mCalendar.set(Calendar.HOUR_OF_DAY, 0);
            mCalendar.set(Calendar.MINUTE, 0);
            mCalendar.set(Calendar.SECOND, 0);
        }
        mFormat = new SimpleDateFormat("yyyy年MM月dd日");
        tvTime.setText(mFormat.format(mCalendar.getTime()));

        LinearLayoutManager manager = new LinearLayoutManager(mContext);
        recycle.setLayoutManager(manager);
        mAdapter = new InvatedDetailsAdapter(mContext);
        recycle.setAdapter(mAdapter);

        mAdapter.setDatas(mDatas);
        if(mDatas == null){
            requestNetData(mCalendar);
        }else{
            if(mDatas.size() > 0){
                llNodata.setVisibility(View.GONE);
            }
        }
    }


    private void requestNetData(final Calendar calendar){
        MsgLoadDialog.showDialog(this, "请稍候...");
        ApiManager.getMineInvitationInfo(calendar.getTimeInMillis() / 1000, new OnRequestFinish<BaseBean<MineInvitationInfoBean>>() {
            @Override
            public void onFinished() {
                MsgLoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<MineInvitationInfoBean> data) {
                mDatas = data.getData().getList();
                mAdapter.setDatas(mDatas);
                mCalendar = calendar;
                tvTime.setText(mFormat.format(calendar.getTime()));
                if (mDatas == null || mDatas.size() == 0){
                    llNodata.setVisibility(View.VISIBLE);
                }else{
                    llNodata.setVisibility(View.GONE);
                }
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
            }
        });
    }

    @OnClick({R.id.bt_last_day, R.id.tv_time, R.id.bt_next_day})
    public void onClick(View view) {
        final Calendar calendar;
        switch (view.getId()) {
            case R.id.bt_last_day:
                calendar = Calendar.getInstance();
                calendar.setTime(mCalendar.getTime());
                calendar.add(Calendar.DAY_OF_MONTH, -1);
                requestNetData(calendar);
                break;
            case R.id.tv_time:
                new TimeSeletctUtil(InvatedDetailsActivity.this)
                        .isWhen(false)
                        .setListener(new TimeSeletctUtil.getDataListener() {
                            @Override
                            public void getData(int y, int m, int d, String when) {
                                Calendar calendar = Calendar.getInstance();
                                calendar.set(y, m, d, 0, 0, 0);
                                requestNetData(calendar);
                            }

                            @Override
                            public void getToday(int toyear, int tomonth, int today) {

                            }

                            @Override
                            public void getHous(int hour, int m) {

                            }
                        }).selectDate(llParent);
                break;
            case R.id.bt_next_day:
                calendar = Calendar.getInstance();
                calendar.setTime(mCalendar.getTime());
                calendar.add(Calendar.DAY_OF_MONTH, 1);
                requestNetData(calendar);
                break;
        }
    }
}
