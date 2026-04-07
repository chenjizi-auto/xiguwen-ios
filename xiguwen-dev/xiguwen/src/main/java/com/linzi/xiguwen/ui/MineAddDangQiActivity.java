package com.linzi.xiguwen.ui;

import android.content.Intent;
import android.os.Bundle;
import android.text.TextUtils;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.google.gson.Gson;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.MyGradeBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.MsgLoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.TimeFormatter;
import com.linzi.xiguwen.utils.TimeSeletctUtil;
import com.linzi.xiguwen.view.MyDatePickerView;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Set;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class MineAddDangQiActivity extends BaseActivity {

//    @BindView(R.id.tv_date)
//    TextView tvDate;
//    @BindView(R.id.ll_date)
//    LinearLayout llDate;
    @BindView(R.id.ed_name)
    EditText edName;
    @BindView(R.id.ed_phone)
    EditText edPhone;
    @BindView(R.id.ed_beizhu)
    EditText edBeizhu;
    @BindView(R.id.tv_tixing)
    TextView tvTixing;
    @BindView(R.id.ll_choose_notice)
    LinearLayout llChooseNotice;
    @BindView(R.id.bt_submit)
    Button btSubmit;
    @BindView(R.id.ll_parent)
    LinearLayout llParent;
    @BindView(R.id.date_picker)
    MyDatePickerView mDatePicker;

    private MyGradeBean.Grade mData;
    private List<MyGradeBean.Grade.RemindData> mRemindDatas;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_mine_add_dang_qi);
        ButterKnife.bind(this);

    }

    @Override
    protected void initData() {
        mData = (MyGradeBean.Grade) getIntent().getSerializableExtra("data");
        if(mData != null){
            setTitle("编辑档期");
        }else {
            setTitle("添加档期");
        }
        setBack();

        refreshView(mData);

    }

    private void refreshView(MyGradeBean.Grade data) {
        if(data != null){
            edName.setText(data.getContacts());
            edPhone.setText(data.getContactnumber());
            edBeizhu.setText(data.getRemarks());
            mDatePicker.setDate(data.getDate());
            mDatePicker.setWhen(data.getTimeslot());
            mRemindDatas = data.getTixing();
        }else{
            mRemindDatas = new ArrayList<>();
            mDatePicker.setWhen(2);
        }
    }

    public boolean check(){
//        if(TextUtils.isEmpty(edName.getText().toString().trim())){
//            NToast.show("联系人不能为空");
//            return false;
//        }

        return true;
    }

    //添加档期
    public void addGrade(){
        MsgLoadDialog.showDialog(this, "提交中...");
        Gson gson = new Gson();
        String formatDate = new TimeFormatter(mDatePicker.getYear(), mDatePicker.getMonth(), mDatePicker.getDay()).getFormatDate();
        com.linzi.xiguwen.utils.LogUtil.e("formatDate","formatDate "+formatDate);
        ApiManager.addGrade(edPhone.getText().toString().trim(), edName.getText().toString().trim(),
                formatDate, edBeizhu.getText().toString().trim(), mDatePicker.getWhen(), gson.toJson(mRemindDatas)
                    , new OnRequestFinish<BaseBean<String>>() {
                    @Override
                    public void onFinished() {
                        MsgLoadDialog.CancelDialog();
                    }

                    @Override
                    public void onSuccess(BaseBean<String> data) {
                        NToast.show("添加成功");
                        setResult(RESULT_OK);
                        finish();
                    }

                    @Override
                    public void onError(Exception ex) {
                        NToast.show(ex.getMessage());
                        com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
                    }
                });
    }

    // 编辑档期
    public void editGrade(){
        MsgLoadDialog.showDialog(this, "保存中...");
        Gson gson = new Gson();
        String formatDate = new TimeFormatter(mDatePicker.getYear(), mDatePicker.getMonth(), mDatePicker.getDay()).getFormatDate();

        com.linzi.xiguwen.utils.LogUtil.e("formatDate","formatDate "+formatDate);
        ApiManager.editGrade(mData.getId(), edPhone.getText().toString().trim(), edName.getText().toString().trim(),
                formatDate, edBeizhu.getText().toString().trim(), mDatePicker.getWhen(), gson.toJson(mRemindDatas)
                , new OnRequestFinish<BaseBean<String>>() {
                    @Override
                    public void onFinished() {
                        MsgLoadDialog.CancelDialog();
                    }

                    @Override
                    public void onSuccess(BaseBean<String> data) {
                        NToast.show("修改成功");
                        Intent result = new Intent();
                        mData.setContactnumber(edPhone.getText().toString().trim());
                        mData.setContacts(edName.getText().toString().trim());
                        mData.setDate(new TimeFormatter(mDatePicker.getYear(), mDatePicker.getMonth(), mDatePicker.getDay()).getFormatDate());
                        mData.setTimeslot(mDatePicker.getWhenStr());
                        mData.setRemarks(edBeizhu.getText().toString().trim());
                        mData.setTixing(mRemindDatas);
                        result.putExtra("data", mData);
                        setResult(RESULT_OK, result);
                        finish();
                    }

                    @Override
                    public void onError(Exception ex) {
                        NToast.show(ex.getMessage());
                        com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
                    }
                });
    }

    @OnClick({ R.id.ll_choose_notice, R.id.bt_submit})
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.ll_choose_notice:
                Intent intent=new Intent(this,MineDangqiChooseNoticeActivity.class);
                if(mRemindDatas != null){
                    HashMap<Integer, MyGradeBean.Grade.RemindData> data = new HashMap<>();
                    for (MyGradeBean.Grade.RemindData remindData : mRemindDatas) {
                        data.put(remindData.getType(), remindData);
                    }
                    intent.putExtra("data", data);
                }
                startActivityForResult(intent, 100);
                break;
            case R.id.bt_submit:
                if(check()){
                    if(mData == null){
                        addGrade();
                    }else{
                        editGrade();
                    }
                }
                break;
        }
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if(requestCode == 100 && resultCode == RESULT_OK){
            mRemindDatas.clear();
            HashMap<Integer, MyGradeBean.Grade.RemindData> remindMap = (HashMap<Integer, MyGradeBean.Grade.RemindData>) data.getSerializableExtra("data");
            Set<Integer> keys = remindMap.keySet();
            for (Integer key : keys) {
                mRemindDatas.add(remindMap.get(key));
            }
        }
    }
}
