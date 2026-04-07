package com.linzi.xiguwen.ui;

import android.os.Bundle;
import android.text.TextUtils;
import android.view.View;
import android.widget.EditText;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.FaYanGaoBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.MsgLoadDialog;
import com.linzi.xiguwen.utils.NToast;

import butterknife.BindView;
import butterknife.ButterKnife;

public class EditFayangaoActivity extends BaseActivity {

    @BindView(R.id.ed_title)
    EditText edTitle;
    @BindView(R.id.ed_context)
    EditText edContext;

    private FaYanGaoBean mData;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_edit_fayangao);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        mData = (FaYanGaoBean) getIntent().getSerializableExtra("data");
        setBack();
        setTitle("婚礼宝典");
        setRight("保存", new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if(check()){
                    submitOrder();
                }
            }
        });

        refreshView(mData);
    }

    private void refreshView(FaYanGaoBean data) {
        if(data != null){
            edTitle.setText(data.getTitle());
            edContext.setText(data.getContent());
        }
    }

    private boolean check(){
        if(TextUtils.isEmpty(edTitle.getText().toString().trim())){
            NToast.show("请输入标题");
            return false;
        }else{
            if(edTitle.getText().toString().trim().length() > 9){
                NToast.show("标题最多只能9个汉字");
                return false;
            }
        }
        if(TextUtils.isEmpty(edContext.getText().toString().trim())){
            NToast.show("请输入内容");
            return false;
        }

        return true;
    }

    private void submitOrder(){
        MsgLoadDialog.showDialog(this, "保存中...");
        if(mData == null){
            // 添加
            ApiManager.addFaYanGao(edTitle.getText().toString().trim(), edContext.getText().toString().trim(), new OnRequestFinish<BaseBean<String>>() {
                @Override
                public void onFinished() {
                    MsgLoadDialog.CancelDialog();
                }

                @Override
                public void onSuccess(BaseBean<String> data) {
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
            // 修改
            ApiManager.editFaYanGao(mData.getId(), edTitle.getText().toString().trim(), edContext.getText().toString().trim(), new OnRequestFinish<BaseBean<String>>() {
                @Override
                public void onFinished() {
                    MsgLoadDialog.CancelDialog();
                }

                @Override
                public void onSuccess(BaseBean<String> data) {
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
}
