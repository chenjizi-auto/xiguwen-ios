package com.linzi.xiguwen.ui;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.MyGradeBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.MsgLoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.view.AskDialog;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class DangQiDetailsActivity extends BaseActivity {

    @BindView(R.id.ll_notice_caipai)
    LinearLayout mLlNoticeCaiPai;     // 提醒时间的
    @BindView(R.id.tv_notice_caipai)
    TextView tvNoticeCaiPai;          // 提醒时间
    @BindView(R.id.ll_notice_yuejian)
    LinearLayout mLlNoticeYueJian;
    @BindView(R.id.tv_notice_yuejian)
    TextView tvNoticeYueJian;
    @BindView(R.id.ll_notice_qita)
    LinearLayout mLlNoticeQiTa;
    @BindView(R.id.tv_notice_qita)
    TextView tvNoticeQiTa;

    @BindView(R.id.tv_time)
    TextView tvTime;                // 档期时间
    @BindView(R.id.tv_name)
    TextView tvName;                // 联系人姓名
    @BindView(R.id.tv_phone)
    TextView tvPhone;               // 联系人电话
    @BindView(R.id.tv_beizhu)
    TextView tvBeizhu;              //备注
    @BindView(R.id.ll_del)
    LinearLayout llDel;             // 删除

    private MyGradeBean.Grade mData;

    public static void startActivityForResult(Activity activity, MyGradeBean.Grade data, int requestCode){
        Intent intent = new Intent(activity, DangQiDetailsActivity.class);
        intent.putExtra("data", data);
        activity.startActivityForResult(intent, requestCode);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_dang_qi_details);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        mData = (MyGradeBean.Grade) getIntent().getSerializableExtra("data");
        setTitle("查看档期");
        setBack();
        if(mData != null && !mData.isXiTong()){
            setRight("编辑", new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    Intent intent = new Intent(DangQiDetailsActivity.this, MineAddDangQiActivity.class);
                    intent.putExtra("data", mData);
                    startActivityForResult(intent, 100);
                }
            });
        }

        refreshView(mData);
    }

    private void refreshView(MyGradeBean.Grade grade) {
        mLlNoticeYueJian.setVisibility(View.GONE);
        mLlNoticeCaiPai.setVisibility(View.GONE);
        mLlNoticeQiTa.setVisibility(View.GONE);

        if(grade != null){
            //判断如果是自己手动添加的则可以删除
            llDel.setVisibility(grade.isXiTong() ? View.GONE : View.VISIBLE);
            if(grade.isRemind()){
                //如果提醒
                List<MyGradeBean.Grade.RemindData> tixing = grade.getTixing();
                if(tixing != null){
                    for (MyGradeBean.Grade.RemindData remindData : tixing) {
                        switch (remindData.getType()){
                            case MyGradeBean.Grade.RemindData.TYPE_CAIPAI:
                                mLlNoticeCaiPai.setVisibility(View.VISIBLE);
                                tvNoticeCaiPai.setText(remindData.getShijian());
                                break;
                            case MyGradeBean.Grade.RemindData.TYPE_YUEJIAN:
                                mLlNoticeYueJian.setVisibility(View.VISIBLE);
                                tvNoticeYueJian.setText(remindData.getShijian());
                                break;
                            case MyGradeBean.Grade.RemindData.TYPE_QITA:
                                mLlNoticeQiTa.setVisibility(View.VISIBLE);
                                tvNoticeQiTa.setText(remindData.getHunlishijian());
                                break;
                        }
                    }
                }
            }

            tvTime.setText(String.format("%s %s", grade.getDate(), grade.getTimeslot()));
            tvName.setText(grade.getContacts());
            tvPhone.setText(grade.getContactnumber());
            tvBeizhu.setText(grade.getRemarks());

        }
    }

    // 删除确认
    private void delQuery(){
        final AskDialog dialog = new AskDialog(this, this);
        dialog.setTitle("提示");
        dialog.setMessage("是否确认删除该档期？");
        dialog.setCancleListener("取消", new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                dialog.dismiss();
            }
        });
        dialog.setSubmitListener("确认删除", new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                dialog.dismiss();
                del();
            }
        });
        dialog.show();
    }

    private void del(){
        MsgLoadDialog.showDialog(this, "删除中...");
        ApiManager.delGrade(mData.getId(), new OnRequestFinish<BaseBean<String>>() {
            @Override
            public void onFinished() {
                MsgLoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<String> data) {
                NToast.show("删除成功");
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


    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if(requestCode == 100 && resultCode == RESULT_OK){
            setResult(RESULT_OK);
            //已经修改,刷新数据
            if(data != null && data.hasExtra("data")){
                mData = (MyGradeBean.Grade) data.getSerializableExtra("data");
                refreshView(mData);
            }
        }
    }

    @OnClick(R.id.ll_del)
    public void onClick(View view) {
        switch (view.getId()){
            case R.id.ll_del:
                delQuery();
                break;
        }
    }
}
