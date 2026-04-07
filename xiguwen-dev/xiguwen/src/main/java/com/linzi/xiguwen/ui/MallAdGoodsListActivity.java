package com.linzi.xiguwen.ui;

import android.os.Bundle;
import androidx.recyclerview.widget.RecyclerView;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.base.adapter.BaseAdapter;
import com.linzi.xiguwen.base.adapter.BaseViewHolder;
import com.linzi.xiguwen.base.adapter.CreateHolderDelegate;
import com.linzi.xiguwen.bean.SpecialRecommendBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.GetShareContentUtil;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.location.JumpUtil;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by pc on 2018/4/25.
 */

public class MallAdGoodsListActivity extends BaseActivity {
    @BindView(R.id.recycleview)
    RecyclerView recycleview;
    @BindView(R.id.no_data_view)
    ImageView noDataView;

    private BaseAdapter baseAdapter;

    private String title;
    private int adid;
    private List<SpecialRecommendBean> list;
    private int types;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.mallad_goods_list_layout);
        ButterKnife.bind(this);
        title = getIntent().getStringExtra("title");
        adid = getIntent().getIntExtra("adid", -1);
        types = getIntent().getIntExtra("types", -1);
        initView();
        getData();
    }

    @Override
    protected void initData() {

    }

    private void initView() {
        setBack();
        setTitle(title);
        setRightAdd(R.mipmap.icon_share, new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                GetShareContentUtil.getContent(MallAdGoodsListActivity.this, adid, 10, types);
            }
        });
    }

    class ItemHolder extends BaseViewHolder<SpecialRecommendBean> {
        @BindView(R.id.iv_img)
        ImageView ivImg;
        @BindView(R.id.tv_goods_name)
        TextView tvGoodsName;
        @BindView(R.id.tv_price)
        TextView tvPrice;

        public ItemHolder(View itemView) {
            super(itemView);
            itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    JumpUtil.judgeJump(mContext, list.get(getPosition()).getAptid(), list.get(getPosition()).getAptype(), list.get(getPosition()).getSrc());
                }
            });
        }

        @Override
        protected void bindView(SpecialRecommendBean specialRecommendBean) {
            GlideLoad.GlideLoadImg2(specialRecommendBean.getWapimg(), ivImg);
            tvGoodsName.setText(specialRecommendBean.getTitle());
            tvPrice.setText(specialRecommendBean.getPrice());
        }
    }

    private void getData() {
        LoadDialog.showDialog(mContext);
        ApiManager.getAdSecData(adid, new OnRequestFinish<BaseBean<ArrayList<SpecialRecommendBean>>>() {
            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<ArrayList<SpecialRecommendBean>> data) {
                list = data.getData();
                if (list != null && list.size() > 0) {
                    baseAdapter = BaseAdapter.createBaseAdapter();
                    baseAdapter.injectHolderDelegate(new CreateHolderDelegate<SpecialRecommendBean>() {
                        @Override
                        protected int getLayoutRes() {
                            return R.layout.mall_ad_goods_list_item;
                        }

                        @Override
                        protected BaseViewHolder onCreateHolder(View itemView) {
                            return new ItemHolder(itemView);
                        }
                    }.cleanAfterAddAllData(list));
                    baseAdapter.setLayoutManager(recycleview);
                    recycleview.setAdapter(baseAdapter);
                    noDataView.setVisibility(View.GONE);
                } else {
                    noDataView.setVisibility(View.VISIBLE);

                }
            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }
}
