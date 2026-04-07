package com.linzi.xiguwen.ui;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import androidx.appcompat.app.AppCompatActivity;

import android.text.TextUtils;
import android.view.View;
import android.view.ViewGroup;
import android.view.inputmethod.InputMethodManager;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.google.gson.Gson;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.InvitationUrlBean;
import com.linzi.xiguwen.bean.InvitationsTemplateBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.MsgLoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.StatusBarUtil;
import com.linzi.xiguwen.utils.TimeSeletctUtil;
import com.linzi.xiguwen.view.ScrollerDatePicker;
import com.linzi.xiguwen.view.dateview.ChooseDatePop;

import org.xutils.common.Callback;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import butterknife.BindView;
import butterknife.ButterKnife;

public class ZhizuoQingjianActivity extends AppCompatActivity {

    private static final int TYPE_CREATE = 1; //创建
    private static final int TYPE_EDIT = 2; //修改


    @BindView(R.id.ll_bar)
    LinearLayout llBar;
    @BindView(R.id.iv_back)
    ImageView ivBack;
    @BindView(R.id.tv_title)
    TextView tvTitle;
    @BindView(R.id.tv_submit)
    TextView tvSubmit;
    @BindView(R.id.ed_nan_name)
    EditText edNanName;
    @BindView(R.id.ed_nv_name)
    EditText edNvName;
    @BindView(R.id.ed_time)
    EditText edTime;
    @BindView(R.id.ed_location)
    EditText edLocation;
    @BindView(R.id.ll_parent)
    LinearLayout llParent;
    @BindView(R.id.ed_hotel)
    EditText edHotel;

    Context mContext;

    private Calendar mCalendar;
    private SimpleDateFormat mFormatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");


    private int mType;
    private InvitationsTemplateBean.DataBean mTemp;// 新建
    private QingjianEditActivity.ShareBean mShareBean; // 修改


    public static void startActivityForResult(Activity activity, InvitationsTemplateBean.DataBean temp, int requestCode) {
        Intent intent = new Intent(activity, ZhizuoQingjianActivity.class);
        intent.putExtra("type", TYPE_CREATE);
        intent.putExtra("temp", temp);
        activity.startActivityForResult(intent, requestCode);
    }

    public static void startActivityForResult(Activity activity, QingjianEditActivity.ShareBean data, int requestCode) {
        Intent intent = new Intent(activity, ZhizuoQingjianActivity.class);
        intent.putExtra("type", TYPE_EDIT);
        intent.putExtra("data", data);
        activity.startActivityForResult(intent, requestCode);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //改变为白色背景黑色字体的状态栏
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
            //StatusBarUtil.setStatusBarColor(ZhizuoQingjianActivity.this, R.color.colorMain);
            StatusBarUtil.setNavigationBarColor(ZhizuoQingjianActivity.this, R.color.white);
        }
        setContentView(R.layout.activity_zhizuo_qingjian);
        ButterKnife.bind(this);
        mContext = this;

        mType = getIntent().getIntExtra("type", -1);
        if (mType == -1) {
            NToast.show("参数异常");
            finish();
            return;
        }

        if (mType == TYPE_CREATE) {
            mTemp = (InvitationsTemplateBean.DataBean) getIntent().getSerializableExtra("temp");
        } else {
            mShareBean = (QingjianEditActivity.ShareBean) getIntent().getSerializableExtra("data");
            if (mShareBean == null) {
                NToast.show("参数异常");
                finish();
                return;
            }
            refreshView(mShareBean);
        }
        initView();
    }

    private void refreshView(QingjianEditActivity.ShareBean data) {
        edNanName.setText(data.getBoyName());
        edNvName.setText(data.getGirlName());
        mCalendar = Calendar.getInstance();
       // mCalendar.setTimeInMillis(data.getTime() * 1000);
        edTime.setText(mFormatter.format(mCalendar.getTime()));
        edHotel.setText(data.getHotle());
        edLocation.setText(data.getAddress());
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
    }

    private void initView() {
        //获得状态栏高度
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, StatusBarUtil.getStatusBarHeight(ZhizuoQingjianActivity.this));
        llBar.setLayoutParams(params);
// ViewCompat.setAlpha(llBar, 0);
        llBar.setBackgroundColor(mContext.getResources().getColor(R.color.colorMain));


        tvTitle.setText("请柬信息");
        ivBack.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                finish();
            }
        });
        tvSubmit.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (check()) {
                    submitOrder();
                }
            }
        });

        mCalendar = Calendar.getInstance();
        mCalendar.set(0, 0, 0, 0, 0, 0);

        edTime.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                //selectDate();
                createChooseTimePop(llParent);
            }
        });

    }

    private boolean check() {
        if (TextUtils.isEmpty(edTime.getText().toString().trim())) {
            NToast.show("请选择婚礼时间");
            return false;
        }
        if (TextUtils.isEmpty(edNanName.getText().toString().trim())) {
            NToast.show("请输入新郎姓名");
            return false;
        }
        if (TextUtils.isEmpty(edNvName.getText().toString().trim())) {
            NToast.show("请输入新娘姓名");
            return false;
        }
        if (TextUtils.isEmpty(edLocation.getText().toString().trim())) {
            NToast.show("请输入婚礼地址");
            return false;
        }
        return true;
    }

    //提交表单
    private void submitOrder() {
        if (mType == TYPE_CREATE) {
            MsgLoadDialog.showDialog(this, "提交中...");
            ApiManager.submitMakeInvitationInfo(mTemp.getId(), edNanName.getText().toString().trim(), edNvName.getText().toString().trim(), (int) (mCalendar.getTimeInMillis() / 1000),
                    edHotel.getText().toString().trim(), edLocation.getText().toString().trim(), new Callback.CommonCallback<String>() {
                        @Override
                        public void onSuccess(String result) {
                            Gson gson = new Gson();
                            InvitationUrlBean urlBean = gson.fromJson(result, InvitationUrlBean.class);
                            if (urlBean.getCode() == 0) {
                                setResult(RESULT_OK);
                                finish();
                                QingjianEditActivity.ShareBean bean = new QingjianEditActivity.ShareBean();
                                bean.setUrl(urlBean.getUrl());
                                bean.setInvitationsId(urlBean.getMid());
                                bean.setAddress(edLocation.getText().toString().trim());
                                bean.setHotle(edHotel.getText().toString().trim());
                                bean.setBoyName(edNanName.getText().toString().trim());
                                bean.setGirlName(edNvName.getText().toString().trim());
                                //bean.setTime(mCalendar.getTimeInMillis() / 1000);
                                QingjianEditActivity.startActivityForResult(ZhizuoQingjianActivity.this, bean, 1, 0);
                            } else {
                                NToast.show(urlBean.getMessage());
                            }
                        }

                        @Override
                        public void onError(Throwable ex, boolean isOnCallback) {
                            NToast.show(ex.getMessage());
                            com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
                        }

                        @Override
                        public void onCancelled(CancelledException cex) {

                        }

                        @Override
                        public void onFinished() {
                            MsgLoadDialog.CancelDialog();
                        }
                    });
        } else {
            //编辑
            MsgLoadDialog.showDialog(this, "修改中...");
            ApiManager.editInvitationInfo(mShareBean.getInvitationsId(), edNanName.getText().toString().trim(), edNvName.getText().toString().trim(), (int) (mCalendar.getTimeInMillis() / 1000),
                    edHotel.getText().toString().trim(), edLocation.getText().toString().trim(), new OnRequestFinish<BaseBean<String>>() {
                        @Override
                        public void onFinished() {
                            MsgLoadDialog.CancelDialog();
                        }

                        @Override
                        public void onSuccess(BaseBean<String> data) {
                            mShareBean.setAddress(edLocation.getText().toString().trim());
                            mShareBean.setHotle(edHotel.getText().toString().trim());
                            mShareBean.setBoyName(edNanName.getText().toString().trim());
                            mShareBean.setGirlName(edNvName.getText().toString().trim());
                           // mShareBean.setTime(mCalendar.getTimeInMillis() / 1000);
                            Intent intent = new Intent();
                            intent.putExtra("data", mShareBean);
                            setResult(RESULT_OK, intent);
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


    private void selectDate() {
        InputMethodManager imm = (InputMethodManager) getSystemService(Context.INPUT_METHOD_SERVICE);
        if (imm.isActive()) {
            imm.hideSoftInputFromWindow(llParent.getApplicationWindowToken(), 0);
        }
        new TimeSeletctUtil(this)
                .isWhen(false)
                .setListener(new TimeSeletctUtil.getDataListener() {
                    @Override
                    public void getData(int y, int m, int d, String when) {
                        mCalendar.set(y, m, d);
                        edTime.setText(mFormatter.format(mCalendar.getTime()));
                        selectTime();
                    }

                    @Override
                    public void getToday(int toyear, int tomonth, int today) {

                    }

                    @Override
                    public void getHous(int hour, int m) {

                    }
                }).selectDate(llParent);
    }

    //选择时间
    private void selectTime() {
        new TimeSeletctUtil(this)
                .isWhen(false)
                .setListener(new TimeSeletctUtil.getDataListener() {
                    @Override
                    public void getData(int y, int m, int d, String when) {

                    }

                    @Override
                    public void getToday(int toyear, int tomonth, int today) {

                    }

                    @Override
                    public void getHous(int h, int m) {
                        mCalendar.set(Calendar.HOUR_OF_DAY, h);
                        mCalendar.set(Calendar.MINUTE, m);
                        edTime.setText(mFormatter.format(mCalendar.getTime()));
                    }
                }).getTime(llParent);
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
        @BindView(R.id.pick_month)
        ScrollerDatePicker pickMonth;
        @BindView(R.id.tv_yue)
        TextView tvYue;
        @BindView(R.id.pick_day)
        ScrollerDatePicker pickDay;
        @BindView(R.id.tv_ri)
        TextView tvRi;
        @BindView(R.id.pick_when)
        ScrollerDatePicker pickWhen;

        ViewHolder(View view) {
            ButterKnife.bind(this, view);
        }
    }

    //创建时间选择器
    private void createChooseTimePop(View llParent) {
        ChooseDatePop chooseDatePop = new ChooseDatePop(mContext, null, false);
        chooseDatePop.setShowWithView(llParent);
        chooseDatePop.setListener(new ChooseDatePop.ReturnTimeStr() {
            @Override
            public void onSubmit(String string, String date, int whenid) {
                // setShowWithView(showView);
                edTime.setText(string);
                //ZhizuoQingjianActivity.this.da = date;
                try {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    Date date2 = null;
                    date2 = sdf.parse(date);
                    mCalendar.setTime(date2);
                } catch (ParseException e) {
                    com.linzi.xiguwen.utils.LogUtil.printStackTrace(e);
                }


            }
        });
    }
}
