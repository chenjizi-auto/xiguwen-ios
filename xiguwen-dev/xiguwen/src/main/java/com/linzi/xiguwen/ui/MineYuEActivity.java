package com.linzi.xiguwen.ui;

import android.content.Intent;
import android.os.Bundle;
import androidx.appcompat.app.AppCompatActivity;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.net.OnRequestSubscribe;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

public class MineYuEActivity extends AppCompatActivity {

    @BindView(R.id.iv_back)
    ImageView ivBack;
    @BindView(R.id.tv_title)
    TextView tvTitle;
    @BindView(R.id.tv_details)
    TextView tvDetails;
    @BindView(R.id.tv_yue)
    TextView tvYue;
    @BindView(R.id.ll_tixian)
    LinearLayout llTixian;
    @BindView(R.id.ll_bank_card)
    LinearLayout llBankCard;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_mine_yu_e);
        ButterKnife.bind(this);
    }

    @Override
    protected void onResume() {
        super.onResume();
        httpData();
    }

    private void httpData() {
        ApiManager.bankBalance(new OnRequestSubscribe<BaseBean<String>>() {
            @Override
            public void onSuccess(BaseBean<String> data) {
                tvYue.setText("￥" + data.getData());
            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }

    @OnClick({R.id.iv_back, R.id.tv_details, R.id.ll_tixian, R.id.ll_bank_card})
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.iv_back:
                finish();
                break;
            case R.id.tv_details:
                Intent intent = new Intent(this, YuEDetailsActivity.class);
                startActivity(intent);
                break;
            case R.id.ll_tixian:
                Intent intent2 = new Intent(this, TXStep1Activity.class);
                startActivity(intent2);
                break;
            case R.id.ll_bank_card:
                Intent intent3 = new Intent(this, ChooseBankCardActivity.class);
                startActivity(intent3);
                break;
        }
    }
}
