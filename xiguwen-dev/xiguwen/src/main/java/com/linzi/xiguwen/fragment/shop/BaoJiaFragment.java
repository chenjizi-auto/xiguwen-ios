package com.linzi.xiguwen.fragment.shop;

import android.content.Intent;
import android.os.Bundle;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseLazyFragment;
import com.linzi.xiguwen.base.adapter.BaseAdapter;
import com.linzi.xiguwen.base.adapter.BaseViewHolder;
import com.linzi.xiguwen.base.adapter.CreateHolderDelegate;
import com.linzi.xiguwen.base.listener.OnRcvScrollListener;
import com.linzi.xiguwen.bean.ShopUserDetailsBean;
import com.linzi.xiguwen.fragment.club.dele.AllNumberDele;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.network.Constans;
import com.linzi.xiguwen.ui.NewBaijiaDetailsActivity;
import com.linzi.xiguwen.utils.GlideLoad;


import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by pc on 2018/3/28.
 */

public class BaoJiaFragment extends BaseLazyFragment {
    @BindView(R.id.recycle)
    RecyclerView recycle;
    @BindView(R.id.no_data)
    TextView noData;
    private int shop_id;
    private int page = 1;
    private int limit = 10;
    private BaseAdapter mAdapter;
    private ShopUserDetailsBean.BaojiaBeanX bean;
    private boolean isCanLoadMore;//是否能加载更多

    public static Fragment create(int shop_id) {
        BaoJiaFragment fragment = new BaoJiaFragment();
        Bundle bundle = new Bundle();
        bundle.putInt("shop_id", shop_id);
        fragment.setArguments(bundle);
        return fragment;
    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_mall_index_layout, null);
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
    }

    private void afterView(ShopUserDetailsBean.BaojiaBeanX bean, boolean isLoadMore) {
        if (isLoadMore) {
            mAdapter.injectHolderDelegate(new CreateHolderDelegate<ShopUserDetailsBean.BaojiaBeanX.BaojiaBean>() {
                @Override
                protected int getLayoutRes() {
                    return R.layout.item_mall_index_works_layout;
                }

                @Override
                protected BaseViewHolder onCreateHolder(View itemView) {
                    return new BaoJiaHolder(itemView);
                }
            }.addAllData(bean.getBaojia()));
            mAdapter.notifyDataSetChanged();
        } else {
            mAdapter = createAdapter(bean);
            recycle.setAdapter(mAdapter);
        }
    }


    @Override
    public void onLazyLoad() {

    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
         
    }

    //初始化数据
    private void getData(final boolean isLoadMore) {
        if (isLoadMore) {
            page++;
        } else {
            page = 1;
        }
        //LoadDialog.showDialog(getActivity());
        ApiManager.getOffer(shop_id + "", page + "", limit + "", new OnRequestFinish<BaseBean<ShopUserDetailsBean.BaojiaBeanX>>() {
            @Override
            public void onFinished() {
               // LoadDialog.CancelDialog();
            }

            @Override
            public void onSuccess(BaseBean<ShopUserDetailsBean.BaojiaBeanX> data) {
                ShopUserDetailsBean.BaojiaBeanX baojiaBeanX = data.getData();
                if (baojiaBeanX.getBaojia() != null && baojiaBeanX.getBaojia().size() > 0) {
                    if (isLoadMore) {
                        bean.getBaojia().addAll(baojiaBeanX.getBaojia());
                        afterView(baojiaBeanX, true);
                    } else {
                        bean = baojiaBeanX;
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


    //报价Holder
    class BaoJiaHolder extends BaseViewHolder<ShopUserDetailsBean.BaojiaBeanX.BaojiaBean> {
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
        private int id;//报价id

        public BaoJiaHolder(View itemView) {
            super(itemView);
            itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Intent intent = new Intent(getActivity(), NewBaijiaDetailsActivity.class);
                    intent.putExtra("offoer_id", id);
                    getActivity().startActivity(intent);
                }
            });
        }

        @Override
        protected void bindView(ShopUserDetailsBean.BaojiaBeanX.BaojiaBean baojiaBean) {
            id = baojiaBean.getQuotationid();
            tvContext.setVisibility(View.GONE);
            tvSaleCount.setVisibility(View.VISIBLE);
            tvSeeCount.setVisibility(View.GONE);
            tvSaleCount.setText("已售 " + baojiaBean.getNum());
            tvPrice.setText(Constans.RMB + baojiaBean.getPrice());
            tvTitle.setText("" + baojiaBean.getName());
            GlideLoad.GlideLoadImg2(baojiaBean.getImglist(), ivImg);
            tvTitle.setText("" + baojiaBean.getName());
            tvPrice.setText(Constans.RMB + baojiaBean.getPrice() + "");
        }

    }

    //全局view Adapter
    private BaseAdapter createAdapter(ShopUserDetailsBean.BaojiaBeanX bean) {
        BaseAdapter baseAdapter = BaseAdapter.createBaseAdapter().
                injectHolderDelegate(new AllNumberDele() {
                    @Override
                    protected int onSpanSize() {
                        return 2;
                    }
                }.cleanAfterAddData("全部报价(" + bean.getZongshu() + ")"))//统计view
                .injectHolderDelegate(new CreateHolderDelegate<ShopUserDetailsBean.BaojiaBeanX.BaojiaBean>() {
                    @Override
                    protected int getLayoutRes() {
                        return R.layout.item_mall_index_works_layout;
                    }

                    @Override
                    protected BaseViewHolder onCreateHolder(View itemView) {
                        return new BaoJiaHolder(itemView);
                    }
                }.addAllData(bean.getBaojia()));

        baseAdapter.setLayoutManager(recycle);

        return baseAdapter;
    }
}
