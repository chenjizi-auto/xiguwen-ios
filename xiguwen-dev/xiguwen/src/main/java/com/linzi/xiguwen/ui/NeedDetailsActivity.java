package com.linzi.xiguwen.ui;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.View;
import android.widget.TextView;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.NeedJoinAdapter;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.bean.MineNeedBean;
import com.linzi.xiguwen.bean.MineNeedDetailBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.network.Constans;
import com.linzi.xiguwen.utils.GetShareContentUtil;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.TimeUtils;

import butterknife.BindView;
import butterknife.ButterKnife;

public class NeedDetailsActivity extends BaseActivity {

    @BindView(R.id.tv_shengyushijian)
    TextView tvShengyushijian;
    @BindView(R.id.tv_title)
    TextView tvTitle;
    @BindView(R.id.tv_price)
    TextView tvPrice;
    @BindView(R.id.tv_date)
    TextView tvDate;
    @BindView(R.id.tv_see_num)
    TextView tvSeeNum;
    @BindView(R.id.tv_jion_num)
    TextView tvJionNum;
    @BindView(R.id.tv_details)
    TextView tvDetails;
    @BindView(R.id.recycle)
    RecyclerView recycle;

    NeedJoinAdapter mAdapter;
    private MineNeedBean mData;
    private MineNeedDetailBean mDetailData;

    private int need_id;//需求Id

    private Handler mHandler;

    public static void startActivity(Context context, MineNeedBean needBean) {
        Intent intent = new Intent(context, NeedDetailsActivity.class);
        intent.putExtra("data", needBean);
        context.startActivity(intent);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_need_details);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        mData = (MineNeedBean) getIntent().getSerializableExtra("data");
        setTitle("需求详情");
        setBack();
        setRightAdd(R.mipmap.icon_share, new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                GetShareContentUtil.getContent(NeedDetailsActivity.this, need_id, 6, -1);
            }
        });

        //TimeUtils.getReturnTime2("30小时30分00秒",tvShengyushijian);

        GridLayoutManager manger = new GridLayoutManager(mContext, 3) {
            @Override
            public boolean canScrollVertically() {
                return false;
            }
        };
        recycle.setLayoutManager(manger);

        mAdapter = new NeedJoinAdapter(mContext);
        mAdapter.setItemClickListener(new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int postion) {
                NeedJoinDetailsActivity.startActivityForResult(NeedDetailsActivity.this, mDetailData.getJiedanren().get(postion), mDetailData.getXuquxiangqing().getCountdown() > 0, 100);
            }
        });
        recycle.setAdapter(mAdapter);

        refreshView(mData);
    }

    private void requestDetail(MineNeedBean data) {
        LoadDialog.showDialog(this);
        ApiManager.getMineNeedDetail(data.getId(), new OnRequestFinish<BaseBean<MineNeedDetailBean>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<MineNeedDetailBean> data) {
                mDetailData = data.getData();
                refreshView(mDetailData);
                need_id = mDetailData.getXuquxiangqing().getId();
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
            }
        });
    }

    private void refreshView(MineNeedDetailBean data) {
        if (data != null) {
            tvDetails.setText(data.getXuquxiangqing().getDetails());
            if (mHandler != null) {
                mHandler.removeCallbacksAndMessages(null);
            }
            mHandler = TimeUtils.getReturnTime(data.getXuquxiangqing().getCountdown(), tvShengyushijian);
            mAdapter.setData(data.getJiedanren());
        }
    }

    private void refreshView(MineNeedBean data) {
        if (data != null) {
            tvTitle.setText(data.getTitle());
            tvPrice.setText(Constans.RMB + data.getPrice());
            int length = data.getCreate_ti().length();
            tvDate.setText("发布时间：" + data.getCreate_ti().substring(0, length == 19 ? 16 : length));
            tvSeeNum.setText("浏览：" + data.getBrowsingvolume() + "");
            tvJionNum.setText("参与：" + data.getRenshu() + "");
            requestDetail(mData);
        } else {
            NToast.show("数据异常");
        }
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (resultCode == RESULT_OK) {
            requestDetail(mData);
        }
    }

    @Override
    protected void onDestroy() {
        if (mHandler != null) {
            mHandler.removeCallbacksAndMessages(null);
            mHandler = null;
        }
        super.onDestroy();
    }
}
