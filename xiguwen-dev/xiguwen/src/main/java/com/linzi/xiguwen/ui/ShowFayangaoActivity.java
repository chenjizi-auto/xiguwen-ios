package com.linzi.xiguwen.ui;

import android.os.Bundle;
import android.view.View;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.FaYanGaoBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.GetShareContentUtil;
import com.linzi.xiguwen.utils.MsgLoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.SPUtil;
import com.linzi.xiguwen.view.AskDialog;

import butterknife.BindView;
import butterknife.ButterKnife;

public class ShowFayangaoActivity extends BaseActivity {

    @BindView(R.id.tv_context)
    TextView tvContext;
    @BindView(R.id.tv_title)
    TextView tvTitle;
    private FaYanGaoBean mData;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_show_fayangao);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        mData = (FaYanGaoBean) getIntent().getSerializableExtra("data");
        if (mData == null) {
            NToast.show("数据出错");
            finish();
            return;
        }
        setBack();
        setTitle("婚礼宝典详情");
//        setRight("删除", new View.OnClickListener() {
//            @Override
//            public void onClick(View view) {
//                delFaYanGao();
//            }
//        });
        setRightAdd(R.mipmap.icon_share, new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                GetShareContentUtil.getContent(ShowFayangaoActivity.this, mData.getId(), 15, -1);
            }
        });
        tvTitle.setText(mData.getTitle());
        tvContext.setText(mData.getContent());
    }

    private void delFaYanGao() {
        final AskDialog dialog = new AskDialog(mContext, this);
        dialog.setTitle("确定要删除吗？");
        dialog.setMessage("删除后将不能恢复哦~");
        dialog.setCancleListener("我点错了", new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                dialog.dismiss();
            }
        });
        dialog.setSubmitListener("确认删除", new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                dialog.dismiss();
                del(mData);
            }
        });
        dialog.show();
    }

    private void del(FaYanGaoBean data) {
        if (data != null) {
            MsgLoadDialog.showDialog(this, "删除中...");
            ApiManager.delFaYanGao(data.getId(), new OnRequestFinish<BaseBean<String>>() {
                @Override
                public void onFinished() {
                    MsgLoadDialog.CancelDialog();
                }

                @Override
                public void onSuccess(BaseBean<String> result) {
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
    }
}
