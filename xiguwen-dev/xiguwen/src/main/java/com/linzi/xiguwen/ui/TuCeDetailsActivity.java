package com.linzi.xiguwen.ui;

import android.content.Intent;
import android.os.Bundle;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.widget.ImageView;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.MineImageAdapter;
import com.linzi.xiguwen.bean.AtlasBean;
import com.linzi.xiguwen.bean.AtlasDetailBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.CallBack;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.view.MineDetailControlView;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

public class TuCeDetailsActivity extends BaseDetailActivity {

    @BindView(R.id.tv_name)
    TextView tvName;
    @BindView(R.id.tv_weight)
    TextView tvWeight;
    @BindView(R.id.tv_description)
    TextView tvDescription;
    @BindView(R.id.iv_fengmian)
    ImageView ivFengmian;
    @BindView(R.id.recycle)
    RecyclerView recycle;

    @BindView(R.id.control_view)
    MineDetailControlView mControlView;

    private MineImageAdapter mAdapter;

    private AtlasBean mData;
    private AtlasDetailBean mDetailData;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_tuce_details);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        setTitle("图册详情");
        setBack();
        mData = (AtlasBean) getIntent().getSerializableExtra("data");

        GridLayoutManager manager = new GridLayoutManager(mContext, 3) {
            @Override
            public boolean canScrollVertically() {
                return false;
            }
        };
        recycle.setLayoutManager(manager);
        mAdapter = new MineImageAdapter(this, new CallBack.ImgClickListener() {
            @Override
            public void imgListener(int id) {

            }
        });
        recycle.setAdapter(mAdapter);
        refreshView(mData);
    }

    private void refreshView(AtlasBean data){
        if(data == null){
            NToast.log("TuCeDetailsActivity", "数据为空！");
            return;
        }
        tvName.setText(data.getName());
        tvWeight.setText(data.getWeight() + "");
        tvDescription.setText(data.getSynopsis());
        GlideLoad.GlideLoadImg(this, data.getCover(), ivFengmian);
        requestAtlasDetails();

        mControlView.setData(data);
        mControlView.setOnControlListener(this);
    }

    private void refreshView(AtlasDetailBean data){
        if(data == null){
            NToast.log("TuCeDetailsActivity", "数据为空！");
            return;
        }
        tvName.setText(data.getName());
        tvWeight.setText(data.getWeight() + "");
        tvDescription.setText(data.getSynopsis());
        GlideLoad.GlideLoadImg(this, data.getCover(), ivFengmian);

        List<String> photos = new ArrayList<>();
        for (AtlasDetailBean.PhotoBean photoBean : data.getPhotourl()) {
            photos.add(photoBean.getPhoto());
        }
        mAdapter.setData(photos);
        mControlView.setData(data);
    }

    //请求图册详情
    private void requestAtlasDetails() {
        LoadDialog.showDialog(this);
        ApiManager.getAtlasDetail(mData.getId(), new OnRequestFinish<BaseBean<AtlasDetailBean>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<AtlasDetailBean> data) {
                mDetailData = data.getData();
                refreshView(mDetailData);
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
            }
        });
    }

    @Override
    protected int getPageType() {
        return MineListActivity.TYPE_TUCE;
    }

    @Override
    protected int getDataId() {
        return mData == null ? 0 : mData.getId();
    }

    @Override
    public void onEdit() {
        Intent intent = new Intent(this, AddTuCeActivity.class);
        intent.putExtra("data", mDetailData);
        startActivityForResult(intent, 100);
    }

    @Override
    protected void refreshData() {
        setResult(RESULT_OK);
        requestAtlasDetails();
    }
}
