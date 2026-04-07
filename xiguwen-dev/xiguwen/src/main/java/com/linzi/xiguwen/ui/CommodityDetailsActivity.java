package com.linzi.xiguwen.ui;

import android.content.Intent;
import android.os.Bundle;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.MineImageAdapter;
import com.linzi.xiguwen.bean.CommodityBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.CallBack;
import com.linzi.xiguwen.utils.MsgLoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.view.MineDetailControlView;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * 2018-4-12 15:06:19
 * 商品详情
 */
public class CommodityDetailsActivity extends BaseDetailActivity {

    @BindView(R.id.tv_type1)
    TextView tvType1;           //商品类目
    @BindView(R.id.tv_type2)
    TextView tvType2;           //商品子类
    @BindView(R.id.tv_name)
    TextView tvName;            //商品名称
    @BindView(R.id.tv_price)
    TextView tvPrice;           //商品价格
    @BindView(R.id.tv_unit)
    TextView tvUnit;            //商品单位
    @BindView(R.id.tv_quan)
    TextView tvQuan;            //优惠券
    @BindView(R.id.tv_weight)
    TextView tvWeight;          //排序
    @BindView(R.id.tv_freight)
    TextView tvFreight;         //运费模板
    @BindView(R.id.tv_path)
    TextView tvPath;            //商品地区
    @BindView(R.id.recycle)
    RecyclerView recycle;       //商品图片

    @BindView(R.id.control_view)
    MineDetailControlView mControlView;

    private MineImageAdapter mAdapter;

    private CommodityBean mData;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_commodity_details);
        ButterKnife.bind(this);
    }

    @Override
    protected void initData() {
        setTitle("商品详情");
        setBack();
        mData = (CommodityBean) getIntent().getSerializableExtra("data");

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

    private void refreshView(CommodityBean data){
        if(data != null){
            tvType1.setText(data.getColumnname());
            tvType2.setText(data.getPcolumnname());
            tvName.setText(data.getShopname());
            tvPrice.setText(data.getPrice());
            tvUnit.setText(data.getCompany());
            tvQuan.setText(data.getCoupons_price());
            tvWeight.setText(data.getWeigh() + "");
            tvFreight.setText(data.getExpressname());
            tvPath.setText(data.getProvince() + data.getCity() + data.getCounty());
            mAdapter.setData(data.getShopimg());
            mControlView.setData(data);
            mControlView.setOnControlListener(this);
        }else{
            NToast.show("参数错误");
        }
    }

    // 商品修改，重新获取数据
    private void requestNetData() {
        MsgLoadDialog.showDialog(this, "请稍候...");
        ApiManager.getMyCommodity(mData.getShopid(), new OnRequestFinish<BaseBean<CommodityBean>>() {
            @Override
            public void onFinished() {
                MsgLoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<CommodityBean> data) {
                mData = data.getData();
                refreshView(mData);
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
        return MineListActivity.TYPE_COMMODITY;
    }

    @Override
    protected int getDataId() {
        return mData == null ? 0 : mData.getShopid();
    }

    @Override
    protected void refreshData() {
        setResult(RESULT_OK);
        requestNetData();
    }


    @Override
    public void onEdit() {
        Intent intent = new Intent(this, AddMineCommodityActivity.class);
        intent.putExtra("data", mData);
        startActivityForResult(intent, 100);
    }
}
