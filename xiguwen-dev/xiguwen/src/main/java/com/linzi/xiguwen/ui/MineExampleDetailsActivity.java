package com.linzi.xiguwen.ui;

import android.content.Intent;
import android.os.Bundle;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.MineImageAdapter;
import com.linzi.xiguwen.bean.MyExampleBean;
import com.linzi.xiguwen.bean.MyExampleDetailBean;
import com.linzi.xiguwen.bean.WeddingEnvironmentBean;
import com.linzi.xiguwen.bean.WeddingTypsBean;
import com.linzi.xiguwen.cache.OnCacheRequestFinish;
import com.linzi.xiguwen.cache.repository.WeddingDictionaryRepository;
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

public class MineExampleDetailsActivity extends BaseDetailActivity {

    @BindView(R.id.tv_name)
    TextView tvName;
    @BindView(R.id.tv_time)
    TextView tvTime;
    @BindView(R.id.tv_changdi)
    TextView tvChangdi;
    @BindView(R.id.tv_price)
    TextView tvPrice;
    @BindView(R.id.tv_type)
    TextView tvType;
    @BindView(R.id.tv_huanjing)
    TextView tvHuanjing;
    @BindView(R.id.tv_weight)
    TextView tvWeight;
    @BindView(R.id.iv_fengmian)
    ImageView ivFengmian;
    @BindView(R.id.ll_choose_fengmian)
    LinearLayout llChooseFengmian;
    @BindView(R.id.tv_wmiaoshu)
    TextView tvWmiaoshu;
    @BindView(R.id.recycle)
    RecyclerView recycle;

    @BindView(R.id.control_view)
    MineDetailControlView mControlView;

    private MineImageAdapter mAdapter;
    private MyExampleBean mData;
    private MyExampleDetailBean mDetailData;

    private List<WeddingEnvironmentBean> mEnvironments; // 婚礼环境列表
    private List<WeddingTypsBean> mTypes;               // 婚礼类型列表

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_mine_example_details);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        setTitle("案例详情");
        setBack();
        mData = (MyExampleBean) getIntent().getSerializableExtra("data");

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

    private void refreshView(MyExampleBean data) {
        if(data == null){
            NToast.show("数据异常，请重试!");
            return;
        }
        tvName.setText(data.getTitle());
        tvTime.setText(data.getWeddingtime());
        tvChangdi.setText(data.getWeddingplace());
        tvPrice.setText(data.getWeddingexpenses() + "");
        tvWeight.setText(data.getWeigh() + "");
        GlideLoad.GlideLoadImg(this, data.getWeddingcover(), ivFengmian);
        tvWmiaoshu.setText(data.getWeddingdescribe());


        mControlView.setData(data);
        mControlView.setOnControlListener(this);
        requestExampleDetail();
    }

    private void refreshView(MyExampleDetailBean data) {
        if(data != null){
            tvName.setText(data.getTitle());
            tvTime.setText(data.getWeddingtime());
            tvChangdi.setText(data.getWeddingplace());
            tvPrice.setText(data.getWeddingexpenses() + "");
//            tvType.setText(data.getWeddingtypeid());
//            tvHuanjing.setText(data.getWeddingenvironmentid());
            tvWeight.setText(data.getWeigh() + "");
            GlideLoad.GlideLoadImg(this, data.getWeddingcover(), ivFengmian);
            tvWmiaoshu.setText(data.getWeddingdescribe());
            List<String> imgPaths = new ArrayList<>();
            if(data.getPhtupian() != null){
                for (MyExampleDetailBean.Photo photo : data.getPhtupian()) {
                    imgPaths.add(photo.getPhotourl());
                }
            }
            mAdapter.setData(imgPaths);
            mControlView.setData(data);
            tvHuanjing.setText("");
            tvType.setText("");

            if(mTypes != null){
                for (WeddingTypsBean mType : mTypes) {
                    if(mType.getId() == data.getWeddingtypeid()){
                        tvType.setText(mType.getTitle());
                    }
                }
            }else{
                requestWeddingTypes();
            }

            if(mEnvironments != null){
                for (WeddingEnvironmentBean mEnvironment : mEnvironments) {
                    if(mEnvironment.getId() == data.getWeddingenvironmentid()){
                        tvHuanjing.setText(mEnvironment.getTitle());
                    }
                }
            }else{
                requestWeddingEnvironments();
            }
        }
    }

    /**
     * 请求案例详情
     */
    private void requestExampleDetail() {
        LoadDialog.showDialog(this);
        ApiManager.getMyExampleDetail(mData.getId(), new OnRequestFinish<BaseBean<MyExampleDetailBean>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<MyExampleDetailBean> data) {
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

    private void requestWeddingTypes(){
        LoadDialog.showDialog(this);
        WeddingDictionaryRepository.getInstance(this).getWeddingTypes(new OnCacheRequestFinish<List<WeddingTypsBean>>() {
            @Override
            public void onSuccess(List<WeddingTypsBean> data, boolean fromCache) {
                mTypes = data;
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
            }

            @Override
            public void onFinished() {
                if(mEnvironments != null){
                    LoadDialog.CancelDialog();
                }
                for (WeddingTypsBean mType : mTypes) {
                    if(mType.getId() == mDetailData.getWeddingtypeid()){
                        tvType.setText(mType.getTitle());
                    }
                }
            }
        });
    }

    private void requestWeddingEnvironments(){
        LoadDialog.showDialog(this);
        WeddingDictionaryRepository.getInstance(this).getWeddingEnvironments(new OnCacheRequestFinish<List<WeddingEnvironmentBean>>() {
            @Override
            public void onSuccess(List<WeddingEnvironmentBean> data, boolean fromCache) {
                mEnvironments = data;
            }

            @Override
            public void onError(Exception ex) {
                NToast.show(ex.getMessage());
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
            }

            @Override
            public void onFinished() {
                if(mTypes != null){
                    LoadDialog.CancelDialog();
                }
                for (WeddingEnvironmentBean mEnvironment : mEnvironments) {
                    if(mEnvironment.getId() == mDetailData.getWeddingenvironmentid()){
                        tvHuanjing.setText(mEnvironment.getTitle());
                    }
                }
            }
        });
    }



    @Override
    protected int getPageType() {
        return MineListActivity.TYPE_ANLI;
    }

    @Override
    protected int getDataId() {
        return mData == null ? 0 : mData.getId();
    }

    @Override
    protected void refreshData() {
        setResult(RESULT_OK);
        requestExampleDetail();
    }

    @Override
    public void onEdit() {
        Intent intent = new Intent(this, AddExampleActivity.class);
        intent.putExtra("data", mDetailData);
        startActivityForResult(intent, 100);
    }
}
