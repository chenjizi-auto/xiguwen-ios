package com.linzi.xiguwen.ui;

import android.os.Bundle;
import android.text.TextUtils;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.TakingOrderNumBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.MsgLoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.TimeFormatter;
import com.linzi.xiguwen.utils.TimeSeletctUtil;
import com.linzi.xiguwen.view.MyDatePickerView;

import org.xutils.common.Callback;

import java.text.SimpleDateFormat;
import java.util.Calendar;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class MineDangqiJiedanNumActivity extends BaseActivity implements MyDatePickerView.OnDateChanged {

    @BindView(R.id.ed_num)
    EditText edNum;
    @BindView(R.id.bt_submit)
    Button btSubmit;
    @BindView(R.id.ll_parent)
    LinearLayout llParent;
    @BindView(R.id.date_picker)
    MyDatePickerView datePicker;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_mine_dangqi_jiedan_num);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        setTitle("接单数量");
        setBack();
        datePicker.setHasWhen(false);
        datePicker.setOnDateChangeListener(this);
        getTakingOrderNum(datePicker.getCalendar());
    }

    // 回显接单数量
    Callback.Cancelable mRequest;
    private void getTakingOrderNum(Calendar calendar){
        if(mRequest != null){
            mRequest.cancel();
            mRequest = null;
        }
        LoadDialog.CancelDialog();
        LoadDialog.showDialog(this);
        mRequest = ApiManager.getTakingOrderNum(calendar.getTimeInMillis() / 1000, new OnRequestFinish<BaseBean<TakingOrderNumBean>>() {
            @Override
            public void onFinished() {
                mRequest = null;
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<TakingOrderNumBean> data) {
                edNum.setText(data.getData().getSetnumber() + "");
            }

            @Override
            public void onError(Exception ex) {
                edNum.setText("0");
//                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
            }
        });
    }

    private boolean check(){
        if(TextUtils.isEmpty(edNum.getText().toString().trim())){
            NToast.show("请输入接单数量");
            return false;
        }else{
            try {
                int num = Integer.parseInt(edNum.getText().toString().trim());
                if(num < 0){
                    NToast.show("接单数量应该大于等于0");
                    return false;
                }
            } catch (Exception e) {
                NToast.show("输入接单数量格式有误");
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(e);
                return false;
            }
        }

        return true;
    }

    private void submitOrder(){
        MsgLoadDialog.showDialog(this, "提交中...");
        TimeFormatter time = new TimeFormatter(datePicker.getYear(), datePicker.getMonth(), datePicker.getDay());
        ApiManager.setTakingOrderNum(Integer.parseInt(edNum.getText().toString().trim()), time.getFormatDate(), new OnRequestFinish<BaseBean<String>>() {
            @Override
            public void onFinished() {
                MsgLoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<String> data) {
                NToast.show("添加成功");
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
            }
        });
    }

    @OnClick({ R.id.bt_submit})
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.bt_submit:
                if(check()){
                    submitOrder();
                }
                break;
        }
    }

    @Override
    public void onChanged(final MyDatePickerView view) {
        runOnUiThread(new Runnable() {
            @Override
            public void run() {
                getTakingOrderNum(view.getCalendar());
            }
        });
    }
}
