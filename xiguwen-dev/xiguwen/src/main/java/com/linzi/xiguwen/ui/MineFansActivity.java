package com.linzi.xiguwen.ui;

import android.os.Bundle;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.FansAdapter;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.FensEntity;
import com.linzi.xiguwen.net.OnRequestSubscribe;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.CallBack;
import com.linzi.xiguwen.utils.LoadDialog;
import com.luck.picture.lib.utils.ToastUtils;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

public class MineFansActivity extends BaseActivity {

    @BindView(R.id.tv_all_fens_num)
    TextView tvAllFensNum;
    @BindView(R.id.recycle)
    RecyclerView recycle;

    FansAdapter mAdapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_mine_fans);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        setBack();
        setTitle("粉丝");

        final LinearLayoutManager manager = new LinearLayoutManager(mContext);
        recycle.setLayoutManager(manager);
        mAdapter = new FansAdapter(mContext);

//        tvAllFensNum.setText("全部粉丝(" + mAdapter.getItemCount() + ")");
        recycle.setAdapter(mAdapter);
        LoadDialog.showDialog(this);
        httpData();

        mAdapter.setCareClikListener(new CallBack.CaseCareClikListener() {
            @Override
            public void CaseCareClik(int postion) {
                try {
                    LoadDialog.showDialog(MineFansActivity.this);
                    FensEntity bean = mAdapter.getDatas().get(postion);
                    if (bean.getFollow() == 1) {
                        attentionCancel(bean.getUserid(), postion);
                    } else {
                        attention(bean.getUserid(), postion);
                    }
                } catch (Exception e) {
                    LoadDialog.showDialog(MineFansActivity.this);
                    ToastUtils.showToast(MineFansActivity.this, "操作失败");
                }

            }
        });
    }

    private void attention(int id, final int position) {

        ApiManager.discoverAttention(id + "", new OnRequestSubscribe<BaseBean>() {
            @Override
            public void onSuccess(BaseBean data) {
                LoadDialog.CancelDialog();
                try {
                    mAdapter.getDatas().get(position).setFollow(1);
                    mAdapter.notifyDataSetChanged();
                } catch (Exception e) {

                }
            }

            @Override
            public void onError(Exception ex) {
                LoadDialog.CancelDialog();
                ToastUtils.showToast(MineFansActivity.this, ex.getMessage());
            }
        });
    }

    private void attentionCancel(int id, final int position) {
        ApiManager.discoverAttentionCancel(id + "", new OnRequestSubscribe<BaseBean>() {
            @Override
            public void onSuccess(BaseBean data) {
                LoadDialog.CancelDialog();
                try {
                    mAdapter.getDatas().get(position).setFollow(0);
                    mAdapter.notifyDataSetChanged();
                } catch (Exception e) {

                }

            }

            @Override
            public void onError(Exception ex) {
                ToastUtils.showToast(MineFansActivity.this, ex.getMessage());
                LoadDialog.CancelDialog();
            }
        });
    }

    private void httpData() {
        ApiManager.fens(new OnRequestSubscribe<BaseBean<List<FensEntity>>>() {
            @Override
            public void onSuccess(BaseBean<List<FensEntity>> data) {
                LoadDialog.CancelDialog();
                List<FensEntity> fensEntities = data.getData();
                mAdapter.addFirst(fensEntities);
                if (fensEntities != null) {
                    tvAllFensNum.setText("全部粉丝(" + fensEntities.size() + ")");
                } else {
                    tvAllFensNum.setText("全部粉丝(" + 0 + ")");
                }

            }

            @Override
            public void onError(Exception ex) {
                LoadDialog.CancelDialog();
                ToastUtils.showToast(MineFansActivity.this, ex.getMessage());
            }
        });
    }
}
