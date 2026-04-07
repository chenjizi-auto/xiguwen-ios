package com.linzi.xiguwen.ui;

import android.os.Bundle;
import android.text.TextUtils;
import android.view.View;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.WeddingFlowBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.OnRequestSubscribe;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.MsgLoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.TimeSeletctUtil;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class AddLiuchengActivity extends BaseActivity {

    @BindView(R.id.ed_type)
    EditText edType;
    @BindView(R.id.tv_time)
    TextView tvTime;
    @BindView(R.id.ll_choose_time)
    LinearLayout llChooseTime;
    @BindView(R.id.ed_peo)
    EditText edPeo;
    @BindView(R.id.ed_context)
    EditText edContext;
    @BindView(R.id.ll_parent)
    LinearLayout llParent;
    private WeddingFlowBean mData;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_add_liucheng);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        mData = (WeddingFlowBean) getIntent().getSerializableExtra("data");
        if(mData == null){
            setTitle("添加流程");
        }else{
            setTitle("编辑流程");
        }
        setBack();
        setRight("保存", new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if(check()){
                    submitOrder();
                }
            }
        });
        refreshView(mData);
    }

    private void refreshView(WeddingFlowBean data) {
        if(data != null){
            edType.setText(data.getTitle());
            tvTime.setText(data.getShijian());
            edPeo.setText(data.getRenyuan());
            edContext.setText(data.getShixiang());
        }
    }

    private boolean check(){
        if(TextUtils.isEmpty(edType.getText().toString().trim())){
            NToast.show("请输入流程类型");
            return false;
        }else if(edType.getText().toString().trim().length() > 12){
            NToast.show("流程类型最多只能12个汉字");
            return false;
        }
        if(TextUtils.isEmpty(edPeo.getText().toString().trim())){
        }
        if(TextUtils.isEmpty(edContext.getText().toString().trim())){

        }
        if(TextUtils.isEmpty(tvTime.getText().toString())){
            NToast.show("请选择时间");
            return false;
        }
        return true;
    }

    private void submitOrder(){
        MsgLoadDialog.showDialog(this, "保存中...");
        if(mData == null){
            ApiManager.addWeddingFlow(edType.getText().toString().trim(), edPeo.getText().toString().trim(), tvTime.getText().toString().trim(),
                    edContext.getText().toString().trim(), new OnRequestFinish<BaseBean<String>>() {
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
        }else{
            ApiManager.editWeddingFlow(mData.getId(), edType.getText().toString().trim(), edPeo.getText().toString().trim(), tvTime.getText().toString().trim(),
                    edContext.getText().toString().trim(), new OnRequestFinish<BaseBean<String>>() {
                        @Override
                        public void onFinished() {
                            MsgLoadDialog.CancelDialog();
                        }

                        @Override
                        public void onSuccess(BaseBean<String> data) {
                            NToast.show("修改成功");
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
    }

    @OnClick(R.id.ll_choose_time)
    public void onClick() {
        new TimeSeletctUtil(AddLiuchengActivity.this)
                .isWhen(false)
                .setListener(new TimeSeletctUtil.getDataListener() {
                    @Override
                    public void getData(int year, int month, int day, String when) {

                    }

                    @Override
                    public void getToday(int toyear, int tomonth, int today) {

                    }

                    @Override
                    public void getHous(int hour, int m) {
                        tvTime.setText((hour > 9 ? hour : "0" + hour) + ":" + (m > 9 ? m : "0" + m));
                    }
                }).getTime(llParent);
    }
}
