package com.linzi.xiguwen.ui;

import android.content.Intent;
import android.view.View;

import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.MsgLoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.view.AlertDialog;
import com.linzi.xiguwen.view.AskDialog;
import com.linzi.xiguwen.view.MineDetailControlView;

/**
 * Created by PC on 2018-03-29.
 */

public abstract class BaseDetailActivity extends BaseActivity implements  MineDetailControlView.OnControlListener{

    protected abstract int getPageType();
    protected abstract int getDataId();
    protected abstract void refreshData();

    @Override
    public void onPreview() {
        //TODO 预览
    }

    @Override
    public void onDelete() {
        MsgLoadDialog.showDialog(this,"删除中...");
        ApiManager.mineDel(getPageType(), getDataId(), new OnRequestFinish<BaseBean<String>>() {
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
    public void onSubmit() {
        MsgLoadDialog.showDialog(this,"提交中...");
        ApiManager.mineSubmit(getPageType(), getDataId(), new OnRequestFinish<BaseBean<String>>() {
            @Override
            public void onFinished() {
                MsgLoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<String> data) {
                NToast.show("提交成功");
                refreshData();
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
            }
        });
    }

    @Override
    public void onPutOnShelves() {
        MsgLoadDialog.showDialog(this,"上架中...");
        ApiManager.minePutOnOffShelves(getPageType(), getDataId(), 1, new OnRequestFinish<BaseBean<String>>() {
            @Override
            public void onFinished() {
                MsgLoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<String> data) {
                NToast.show("上架成功");
                refreshData();
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
            }
        });
    }

    @Override
    public void onPutOffShelves() {
        MsgLoadDialog.showDialog(this,"下架中...");
        ApiManager.minePutOnOffShelves(getPageType(), getDataId(), 0, new OnRequestFinish<BaseBean<String>>() {
            @Override
            public void onFinished() {
                MsgLoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<String> data) {
                NToast.show("下架成功");
                refreshData();
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
            }
        });
    }

    @Override
    public void onShowReason() {
        MsgLoadDialog.showDialog(this, "请稍候...");
        ApiManager.mineGetFailedReason(getPageType(), getDataId(), new OnRequestFinish<BaseBean<String>>() {
            @Override
            public void onFinished() {
                MsgLoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<String> data) {
                final AskDialog dialog = new AskDialog(BaseDetailActivity.this, BaseDetailActivity.this);
                dialog.setTitle("审核失败原因");
                dialog.setMessage(data.getData());
                dialog.setCancleListener("取消", new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        dialog.dismiss();
                    }
                });
                dialog.setSubmitListener("确定", new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        dialog.dismiss();
                    }
                });
                dialog.show();
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
        if(resultCode == RESULT_OK){
            refreshData();
        }
    }
}
