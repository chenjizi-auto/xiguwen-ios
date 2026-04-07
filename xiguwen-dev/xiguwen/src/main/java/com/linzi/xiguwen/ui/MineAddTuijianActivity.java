package com.linzi.xiguwen.ui;

import android.os.Bundle;
import android.text.TextUtils;
import android.view.View;
import android.widget.EditText;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.MsgLoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.view.AskDialog;

import butterknife.BindView;
import butterknife.ButterKnife;

public class MineAddTuijianActivity extends BaseActivity {

    @BindView(R.id.ed_dianpu_num)
    EditText edDianpuNum;
    @BindView(R.id.ed_weight)
    EditText edWeight;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_mine_add_tuijian);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        setTitle("添加推荐");
        setBack();
        setRight("保存", new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if(check()){
                    addRecommendedTeam();
                }
            }
        });
    }

    private boolean check(){
        if(TextUtils.isEmpty(edDianpuNum.getText().toString().trim())){
            NToast.show("店铺编号不能为空");
            return false;
        }
        if(TextUtils.isEmpty(edWeight.getText().toString().trim())){
            NToast.show("排序不能为空");
            return false;
        }else{
            try {
                Float.parseFloat(edWeight.getText().toString().trim());
            } catch (Exception e) {
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(e);
                NToast.show("排序格式有误");
                return false;
            }
        }
        return true;
    }

    /**
     * 添加推荐团队
     */
    private void addRecommendedTeam(){
        MsgLoadDialog.showDialog(this, "请稍候...");
        ApiManager.addRecommendedTeam(edDianpuNum.getText().toString().trim(), edWeight.getText().toString(), new OnRequestFinish<BaseBean<String>>() {
            @Override
            public void onFinished() {
                MsgLoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<String> data) {
                showDialog("添加成功");
                setResult(RESULT_OK);
                finish();
            }

            @Override
            public void onError(Exception ex) {
                showDialog(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
                setResult(RESULT_CANCELED);
            }
        });
    }

    private void showDialog(String msg){
        final AskDialog dialog = new AskDialog(this, this);
        dialog.setTitle("提示");
        dialog.setMessage(msg);
        dialog.setSignButton("我知道了", new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dialog.dismiss();
            }
        });
        dialog.show();
    }
}
