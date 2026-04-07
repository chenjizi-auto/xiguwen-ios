package com.linzi.xiguwen.ui;

import android.content.Intent;
import android.os.Bundle;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.MineImageAdapter;
import com.linzi.xiguwen.bean.BaoJiaBean;
import com.linzi.xiguwen.bean.BaoJiaDetailBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.CallBack;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.view.MineDetailControlView;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

public class BaojiaDetails2Activity extends BaseDetailActivity {

    @BindView(R.id.tv_name)
    TextView tvName;
    @BindView(R.id.tv_price)
    TextView tvPrice;
    @BindView(R.id.tv_dingjing)
    TextView tvDingjing;
    @BindView(R.id.tv_zhekouquan)
    TextView tvZhekouquan;
    @BindView(R.id.tv_weight)
    TextView tvWeight;
    @BindView(R.id.recycle)
    RecyclerView recycle;

    @BindView(R.id.control_view)
    MineDetailControlView mControlView;

    private MineImageAdapter mAdapter;

    BaoJiaBean mData;
    BaoJiaDetailBean mDetailBean;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_baojia_details);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        setTitle("报价详情");
        setBack();
        mData = (BaoJiaBean) getIntent().getSerializableExtra("data");

        GridLayoutManager manager=new GridLayoutManager(mContext,3){
            @Override
            public boolean canScrollVertically() {
                return false;
            }
        };
        recycle.setLayoutManager(manager);
        mAdapter=new MineImageAdapter(this, new CallBack.ImgClickListener() {
            @Override
            public void imgListener(int id) {

            }
        });
        recycle.setAdapter(mAdapter);

        refreshView(mData);
    }

    private void refreshView(BaoJiaBean data){
        tvName.setText(data.getName());
        tvPrice.setText(data.getPrice());
        tvWeight.setText(data.getWeigh() + "");
        mAdapter.setData(data.getImglist());
        mControlView.setData(data);
        mControlView.setOnControlListener(this);

        requestBaojiaDetail();
    }

    private void requestBaojiaDetail(){
        LoadDialog.showDialog(mContext);
        ApiManager.getBaoJiaDetail(mData.getQuotationid(), new OnRequestFinish<BaseBean<BaoJiaDetailBean>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<BaoJiaDetailBean> data) {
                mDetailBean = data.getData();
                refreshView(mDetailBean);
            }

            @Override
            public void onError(Exception ex) {
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
                NToast.show(ex.getMessage());
            }
        });
    }

    private void refreshView(BaoJiaDetailBean data){
        if(data == null){
            NToast.log("TuCeDetailsActivity", "数据为空！");
            return;
        }
        // 订金
        // 抵扣券
        tvName.setText(mDetailBean.getName());
        tvPrice.setText(mDetailBean.getPrice());
        tvWeight.setText(mDetailBean.getWeigh() + "");
        tvDingjing.setText(mDetailBean.getTemporarypay());
        tvZhekouquan.setText(mDetailBean.getDeductible());
        List<String> imgs = new ArrayList<>();
        if(mDetailBean.getImglist() != null){
            for (BaoJiaDetailBean.Photo photo : mDetailBean.getImglist()) {
                imgs.add(photo.getPhoto());
            }
        }
        mAdapter.setData(imgs);
        mControlView.setData(data);
    }

    @Override
    protected int getPageType() {
        return MineListActivity.TYPE_BAOJIA;
    }

    @Override
    protected int getDataId() {
        return mData == null ? 0 : mData.getQuotationid();
    }

    @Override
    protected void refreshData() {
        setResult(RESULT_OK);
        requestBaojiaDetail();
    }

    @Override
    public void onEdit() {
        Intent intent = new Intent(this, AddBaojiaActivity.class);
        intent.putExtra("data", mDetailBean);
        startActivityForResult(intent, 100);
    }
}
