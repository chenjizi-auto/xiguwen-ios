package com.linzi.xiguwen.fragment.shopmall;

import android.content.Intent;
import android.os.Bundle;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.RadioGroup;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseLazyFragment;
import com.linzi.xiguwen.base.adapter.BaseAdapter;
import com.linzi.xiguwen.base.adapter.BaseViewHolder;
import com.linzi.xiguwen.base.adapter.CreateHolderDelegate;
import com.linzi.xiguwen.base.listener.OnRcvScrollListener;
import com.linzi.xiguwen.bean.ShopMallDetailsBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.network.Constans;
import com.linzi.xiguwen.ui.NewGoodsDetailsActivity;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.yixin.ViewUtil;
import com.linzi.xiguwen.view.CusRadioButton;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by pc on 2018/4/7.
 */

public class HotFragment extends BaseLazyFragment {

    @BindView(R.id.recycle)
    RecyclerView recycle;
    @BindView(R.id.no_data)
    TextView noData;
    @BindView(R.id.rb_price)
    CusRadioButton rbPrice;
    @BindView(R.id.rb_all)
    CusRadioButton rbAll;
    @BindView(R.id.rb_salenum)
    CusRadioButton rbSalenum;
    @BindView(R.id.radiogroup)
    RadioGroup radiogroup;

    private int shop_id;//商城商家id
    private int page = 1;
    private int limit = 10;
    private int comprehensive = -1;
    private int salesvolume = -1;
    private String price = "";
    private ShopMallDetailsBean bean;
    private BaseAdapter mAdapter;
    private boolean isCanLoadMore = false;


    public static Fragment create(int shop_id) {
        HotFragment fragment = new HotFragment();
        Bundle bundle = new Bundle();
        bundle.putInt("shop_id", shop_id);
        fragment.setArguments(bundle);
        return fragment;
    }

    @Override
    public void onLazyLoad() {

    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.shopmall_tab_fr_layout, null);
        ButterKnife.bind(this, view);
        return view;
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        shop_id = getArguments().getInt("shop_id");
        isCanLoadMore = true;
        getData(false);
        recycle.addOnScrollListener(new OnRcvScrollListener() {
            @Override
            public void onBottom() {
                super.onBottom();
                if (isCanLoadMore)
                    getData(true);
            }
        });
        radiogroup.setVisibility(View.GONE);
    }

    private void afterView(ShopMallDetailsBean bean, boolean isLoadMore) {
        if (isLoadMore) {
            mAdapter.injectHolderDelegate(new CreateHolderDelegate<ShopMallDetailsBean.ShopBean>() {
                @Override
                protected int getLayoutRes() {
                    return R.layout.item_mall_index_works_layout;
                }

                @Override
                protected BaseViewHolder onCreateHolder(View itemView) {
                    return new HotSellGoodsHolder(itemView);
                }
            }.addAllData(bean.getShop()));
            mAdapter.notifyDataSetChanged();
        } else {
            mAdapter = createAdapter(bean);
            recycle.setAdapter(mAdapter);
        }
    }


    private void getData(final boolean isLoadMore) {
        if (rbSalenum.isChecked()) {
            salesvolume = 1;
        } else {
            salesvolume = -1;
        }
        if (rbAll.isChecked()) {
            comprehensive = 1;
        } else {
            comprehensive = -1;
        }
        if (isLoadMore) {
            page++;
        } else {
            isCanLoadMore = true;
            page = 1;
        }
        //LoadDialog.showDialog(getActivity());
        ApiManager.getHotGoods(shop_id, page, limit, salesvolume, price, comprehensive, new OnRequestFinish<BaseBean<ShopMallDetailsBean>>() {
            @Override
            public void onFinished() {
                //LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<ShopMallDetailsBean> data) {
                ShopMallDetailsBean shopMallDetailsBean = data.getData();
                if (shopMallDetailsBean != null && shopMallDetailsBean.getShop().size() > 0) {
                    if (isLoadMore) {
                        bean.getShop().addAll(shopMallDetailsBean.getShop());
                        afterView(shopMallDetailsBean, true);
                    } else {
                        bean = shopMallDetailsBean;
                        afterView(bean, false);
                    }
                    noData.setVisibility(View.GONE);
                } else {
                    if (isLoadMore) {
                        isCanLoadMore = false;
                        page--;
                        mAdapter.injectHolderDelegate(new CreateHolderDelegate<String>() {
                            @Override
                            protected int onSpanSize() {
                                return 2;
                            }

                            @Override
                            protected int getLayoutRes() {
                                return R.layout.nodata_text_layout;
                            }

                            @Override
                            protected BaseViewHolder onCreateHolder(View itemView) {
                                return new BaseViewHolder<String>(itemView) {
                                    @Override
                                    protected void bindView(String o) {

                                    }
                                };
                            }
                        }.addData(""));//分割线View
                        mAdapter.notifyDataSetChanged();
                    } else {
                        noData.setVisibility(View.VISIBLE);
                    }
                }

            }

            @Override
            public void onError(Exception ex) {
                if (isLoadMore)
                    page--;
            }
        });
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
         
    }

//    @OnClick({R.id.rb_all, R.id.rb_salenum, R.id.rb_price})
//    public void onViewClicked(View view) {
//        switch (view.getId()) {
//            case R.id.rb_all:
//                getData(false);
//                break;
//            case R.id.rb_salenum:
//                getData(false);
//                break;
//            case R.id.rb_price:
//                getData(false);
//                break;
//        }
//    }

    //商品Holder
    class HotSellGoodsHolder extends BaseViewHolder<ShopMallDetailsBean.ShopBean> {
        @BindView(R.id.iv_img)
        ImageView ivImg;
        @BindView(R.id.tv_title)
        TextView tvTitle;
        @BindView(R.id.tv_context)
        TextView tvContext;
        @BindView(R.id.tv_price)
        TextView tvPrice;
        @BindView(R.id.tv_sale_count)
        TextView tvSaleCount;
        @BindView(R.id.tv_see_count)
        TextView tvSeeCount;
        private int id;

        public HotSellGoodsHolder(View itemView) {
            super(itemView);

            itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Intent intent = new Intent(getActivity(), NewGoodsDetailsActivity.class);
                    intent.putExtra("goods_id", id);
                    startActivity(intent);
                }
            });
        }

        @Override
        protected void bindView(ShopMallDetailsBean.ShopBean remenshangpinBean) {
            ViewUtil.setNumOfScreenWidth(getActivity(),ivImg,2);

            id = remenshangpinBean.getShopid();
            tvContext.setVisibility(View.GONE);
            tvSaleCount.setVisibility(View.VISIBLE);
            tvSeeCount.setVisibility(View.GONE);
            tvSaleCount.setText("已售" + remenshangpinBean.getNum());
            tvPrice.setText(Constans.RMB + remenshangpinBean.getPrice());
            tvTitle.setText("" + remenshangpinBean.getShopname());
            GlideLoad.GlideLoadImg2(remenshangpinBean.getShopimg().get(0), ivImg);
        }
    }

    private BaseAdapter createAdapter(ShopMallDetailsBean bean) {
        BaseAdapter baseAdapter = BaseAdapter.createBaseAdapter();
        baseAdapter
                .injectHolderDelegate(new CreateHolderDelegate<String>() {
                    @Override
                    protected int onSpanSize() {
                        return 2;
                    }

                    @Override
                    protected int getLayoutRes() {
                        return R.layout.item_dev;
                    }

                    @Override
                    protected BaseViewHolder onCreateHolder(View itemView) {
                        return new BaseViewHolder<String>(itemView) {
                            @Override
                            protected void bindView(String o) {
                                itemView.setVisibility(View.GONE);
                            }
                        };
                    }
                }.addData(""))
                .injectHolderDelegate(new CreateHolderDelegate<ShopMallDetailsBean.ShopBean>() {
                    @Override
                    protected int onSpanSize() {
                        return 1;
                    }

                    @Override
                    protected int getLayoutRes() {
                        return R.layout.item_mall_index_works_layout;
                    }

                    @Override
                    protected BaseViewHolder onCreateHolder(View itemView) {
                        return new HotSellGoodsHolder(itemView);
                    }
                }.cleanAfterAddAllData(bean.getShop()));
        baseAdapter.setLayoutManager(recycle);
        return baseAdapter;
    }

}
