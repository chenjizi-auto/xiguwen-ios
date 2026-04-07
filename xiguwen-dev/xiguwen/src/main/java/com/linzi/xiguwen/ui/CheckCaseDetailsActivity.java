package com.linzi.xiguwen.ui;

import android.content.Context;
import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.View;
import android.widget.TextView;

import com.alibaba.fastjson.JSONObject;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.CheckCaseDetailsAdapter;
import com.linzi.xiguwen.bean.CheckCaseDetailsBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.StatusBarUtil;

import org.xutils.common.Callback;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

/**
 * Created by pc on 2018/3/22.
 * 案例查看明细
 */

public class CheckCaseDetailsActivity extends AppCompatActivity implements Callback.CommonCallback<String> {

    @BindView(R.id.tv_title)
    TextView tvTitle;
    @BindView(R.id.tv_price)
    TextView tvPrice;
    @BindView(R.id.recycleview)
    RecyclerView recycleview;
    @BindView(R.id.no_data)
    TextView noData;
    private int case_id;
    private Context mContext;
    private CheckCaseDetailsAdapter adapter;
    private Intent intent;
    private List<CheckCaseDetailsBean.DataBeanX> mlist;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
            StatusBarUtil.setStatusBarColor(CheckCaseDetailsActivity.this, R.color.white);
        }
        setContentView(R.layout.checkcasedetails_layout);
        ButterKnife.bind(this);
        mContext = this;
        if (intent == null) {
            intent = getIntent();
            case_id = intent.getIntExtra("case_id", -1);
            NToast.log(mContext, case_id + "");
        }
        if (case_id != -1) {
            initview();
            getData();
        } else {
            NToast.show("跳转错误请重试！");
            finish();
        }
    }

    private void initview() {
        tvTitle.setText("查看明细");
        adapter = new CheckCaseDetailsAdapter(mContext);
        LinearLayoutManager manager2 = new LinearLayoutManager(mContext) {
            @Override
            public boolean canScrollVertically() {
                return true;
            }
        };
        recycleview.setLayoutManager(manager2);
        recycleview.setAdapter(adapter);

    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
         
    }

    @Override
    public void onSuccess(String result) {
        NToast.log(mContext, result.toString());
        CheckCaseDetailsBean bean = JSONObject.parseObject(result, CheckCaseDetailsBean.class);
        mlist = bean.getData();
        if (bean.getZongji() != 0) {
            tvPrice.setText("婚礼总价：￥" + bean.getZongji());
            noData.setVisibility(View.GONE);
        } else {
            tvPrice.setVisibility(View.GONE);
            noData.setVisibility(View.VISIBLE);
        }

        adapter.setTitleData(mlist);
    }

    @Override
    public void onError(Throwable ex, boolean isOnCallback) {
        NToast.log(mContext, ex.toString());
    }

    @Override
    public void onCancelled(CancelledException cex) {

    }

    @Override
    public void onFinished() {
        LoadDialog.CancelDialog();
    }

    @OnClick(R.id.ll_back)
    public void onViewClicked(View view) {
        switch (view.getId()) {
            case R.id.ll_back:
                finish();
                break;
        }
    }

    private void getData() {
        LoadDialog.showDialog(mContext);
        new ApiManager().getDetails(case_id + "", this);
    }
}
