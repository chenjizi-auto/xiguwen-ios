package com.linzi.xiguwen.ui;

import android.os.Bundle;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.AgreementEntity;
import com.linzi.xiguwen.net.OnRequestSubscribe;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by devin on 2018/4/20 11:17
 * Description
 */

public class AgreementActivity extends BaseActivity {
    @BindView(R.id.title)
    TextView title;
    @BindView(R.id.content)
    TextView content;

    @Override
    protected void initData() {
        setTitle("用户协议");
        setBack();
        httpData();
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_agreement);
        ButterKnife.bind(this);
    }

    private void httpData() {
        LoadDialog.showDialog(this);
        ApiManager.agreement(new OnRequestSubscribe<BaseBean<AgreementEntity>>() {
            @Override
            public void onSuccess(BaseBean<AgreementEntity> data) {
                LoadDialog.CancelDialog();
                title.setText(data.getData().getTitle());
                content.setText(data.getData().getContent());
                NToast.show(data.getMessage());
            }

            @Override
            public void onError(Exception ex) {
                LoadDialog.CancelDialog();
                NToast.show(ex.getMessage());
            }
        });
    }
}
