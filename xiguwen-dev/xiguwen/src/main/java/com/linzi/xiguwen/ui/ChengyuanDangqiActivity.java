package com.linzi.xiguwen.ui;

import android.os.Bundle;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.ChengyuanDangqiAdapter;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.CommunityScheduleEntity;
import com.linzi.xiguwen.net.OnRequestSubscribe;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

public class ChengyuanDangqiActivity extends BaseActivity {

    @BindView(R.id.tv_all)
    TextView tvAll;
    @BindView(R.id.recycle)
    RecyclerView recycle;

    private ChengyuanDangqiAdapter mAdapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_chengyuan_dangqi);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        setTitle("成员档期");
        setBack();
        id = getIntent().getStringExtra("id");
        LinearLayoutManager manager = new LinearLayoutManager(mContext);
        recycle.setLayoutManager(manager);
        mAdapter = new ChengyuanDangqiAdapter(mContext);

        tvAll.setText("全部成员(" + mAdapter.getItemCount() + ")");
        recycle.setAdapter(mAdapter);
        LoadDialog.showDialog(this);
        httpData();
    }

    private String id;

    private void httpData() {
        ApiManager.communityScheduleList(id, new OnRequestSubscribe<BaseBean<List<CommunityScheduleEntity>>>() {
            @Override
            public void onSuccess(BaseBean<List<CommunityScheduleEntity>> data) {
                LoadDialog.CancelDialog();
                List<CommunityScheduleEntity> entities = data.getData();
                mAdapter.addData(entities);
                if (entities != null) {
                    tvAll.setText("全部成员(" + entities.size() + ")");
                }

            }

            @Override
            public void onError(Exception ex) {
                LoadDialog.CancelDialog();
                NToast.show(ex.getMessage());
            }
        });
    }
}
