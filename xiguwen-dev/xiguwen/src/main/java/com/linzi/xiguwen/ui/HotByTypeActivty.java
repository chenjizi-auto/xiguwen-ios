package com.linzi.xiguwen.ui;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.recyclerview.widget.RecyclerView;
import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseActivity;
import com.linzi.xiguwen.base.adapter.BaseAdapter;
import com.linzi.xiguwen.base.adapter.BaseViewHolder;
import com.linzi.xiguwen.base.adapter.CreateHolderDelegate;
import com.linzi.xiguwen.bean.HotBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.network.Constans;
import com.linzi.xiguwen.utils.GetShareContentUtil;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.yixin.preference.Preferences;
import com.linzi.xiguwen.view.MyRefreshFooter;
import com.linzi.xiguwen.view.MyRefreshHeader;
import com.scwang.smartrefresh.layout.SmartRefreshLayout;
import com.scwang.smartrefresh.layout.api.RefreshLayout;
import com.scwang.smartrefresh.layout.listener.OnLoadMoreListener;
import com.scwang.smartrefresh.layout.listener.OnRefreshListener;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by pc on 2018/4/1.
 */

public class HotByTypeActivty extends BaseActivity {
    @BindView(R.id.recycle)
    RecyclerView recycle;
    @BindView(R.id.no_data_view)
    ImageView noDataView;
    @BindView(R.id.refresh_layout)
    SmartRefreshLayout refreshLayout;
    private int page = 1;
    private int rows = 10;
    private Context mContext;
    private boolean isCanLoadMore;
    private BaseAdapter mAdapter;
    private HotBean bean;

    private int ceilingprice = -1;//最高价
    private int college = -1;//是否学院认证1是 2不是
    private int comprehensive = -1;//		综合排序值 1
    private int countyid = -1;//	区域id查询
    private int floorprice = -1;//	最低价
    private int isshopvip = -1;//	是否会员商家1是2否
    private int platform = -1;//	是否平台认证1是 2不是
    private int sincerity = -1;//	是否诚信认证1是 2不是
    private int team = -1;//商家类型，1个人，2团队
    private int type = -1;//	全部（职业类型）
    private int types = -1;//	1今日推荐2本周人气3本月人气4本周热门5本月热门
    private int cityid;//城市id

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.new_index_hot_fra_layout);
        ButterKnife.bind(this);
        mContext = this;
        types = getIntent().getIntExtra("hot_type", -1);
        isCanLoadMore = true;
        initView();
        if (types == -1) {
            NToast.show("跳转错误，请重新尝试！");
            finish();
        } else {
            getData(false);
        }
    }

    @Override
    protected void initData() {

    }

    private void initView() {
        refreshLayout.setRefreshHeader(new MyRefreshHeader(mContext));
        refreshLayout.setRefreshFooter(new MyRefreshFooter(mContext));

        refreshLayout.setOnRefreshListener(new OnRefreshListener() {
            @Override
            public void onRefresh(@NonNull RefreshLayout refreshLayout) {
                getData(false);
            }
        });

        refreshLayout.setOnLoadMoreListener(new OnLoadMoreListener() {
            @Override
            public void onLoadMore(@NonNull RefreshLayout refreshLayout) {
                getData(true);
            }
        });

        setBack();
        setRightAdd(R.mipmap.icon_share, new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                GetShareContentUtil.getContent(HotByTypeActivty.this, -1, 11, types);
            }
        });

        switch (types) {
            case 1:
                setTitle("今日推荐");
                break;
            case 2:
                setTitle("本周人气");
                break;
            case 3:
                setTitle("本月人气");
                break;
            case 4:
                setTitle("本周热门");
                break;
            case 5:
                setTitle("本月热门");
                break;
        }

//        recycle.addOnScrollListener(new OnRcvScrollListener() {
//            @Override
//            public void onBottom() {
//                super.onBottom();
//                if (isCanLoadMore) {
//                    getData(true);
//                }
//            }
//
////            @Override
////            public void onScrolled(RecyclerView recyclerView, int dx, int dy) {
////                super.onScrolled(recyclerView, dx, dy);
////
////                int position = ((LinearLayoutManager) recyclerView.getLayoutManager()).findFirstVisibleItemPosition();
////                if (position > 0) {
////                    llGroup2.setVisibility(View.VISIBLE);
////                    return;
////                } else {
////                    llGroup2.setVisibility(View.GONE);
////                }
////            }
//        });
    }


    @Override
    protected void onDestroy() {
        super.onDestroy();
         
    }

    private void afterView(HotBean bean, boolean isLoadMore) {
        if (isLoadMore) {
            mAdapter.injectHolderDelegate(new CreateHolderDelegate<HotBean.RemensjBean>() {
                @Override
                protected int getLayoutRes() {
                    return R.layout.item_hot_fragment_layout;
                }

                @Override
                protected BaseViewHolder onCreateHolder(View itemView) {
                    return new ItemHolder(itemView);
                }
            }.addAllData(bean.getRemensj()));
            mAdapter.notifyDataSetChanged();
        } else {
            mAdapter = createAdapter(bean);
            recycle.setAdapter(mAdapter);
        }
    }

    private void getData(final boolean isLoadMore) {
        if (isLoadMore) {
            page++;
        } else {
            page = 1;
        }
        cityid = Preferences.getCity().getId();
        ApiManager.getIndexHot(ceilingprice, college, comprehensive, cityid, countyid, floorprice, isshopvip, page, platform, rows, sincerity, team, type, types, new OnRequestFinish<BaseBean<HotBean>>() {
            @Override
            public void onFinished() {
                if (isLoadMore) {
                    refreshLayout.finishLoadMore();
                } else {
                    refreshLayout.finishRefresh();
                }
            }

            @Override
            public void onSuccess(BaseBean<HotBean> data) {
                HotBean hotBean = data.getData();

                if (hotBean.getRemensj() != null && hotBean.getRemensj().size() > 0) {
                    if (isLoadMore) {
                        bean.getRemensj().addAll(hotBean.getRemensj());
                        afterView(hotBean, true);
                    } else {
                        bean = hotBean;
                        afterView(bean, false);
                    }
                    noDataView.setVisibility(View.GONE);
                } else {
                    if (isLoadMore) {
                        isCanLoadMore = false;
                        mAdapter.injectHolderDelegate(new CreateHolderDelegate<String>() {
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
                        noDataView.setVisibility(View.VISIBLE);
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

    //itemview Holder
    class ItemHolder extends BaseViewHolder<HotBean.RemensjBean> {
        @BindView(R.id.iv_img)
        ImageView ivImg;
        @BindView(R.id.iv_rz)
        ImageView ivRz;
        @BindView(R.id.tv_name)
        TextView tvName;
        @BindView(R.id.tv_zhiwu)
        TextView tvZhiwu;
        @BindView(R.id.tv_price)
        TextView tvPrice;
        @BindView(R.id.iv_rz_cx)
        ImageView ivRzCx;
        @BindView(R.id.iv_rz_pt)
        ImageView ivRzPt;
        @BindView(R.id.iv_rz_xy)
        ImageView ivRzXy;
        @BindView(R.id.tv_hp)
        TextView tvHp;
        @BindView(R.id.tv_pl)
        TextView tvPl;
        @BindView(R.id.tv_fens)
        TextView tvFens;
        private int shop_id;

        public ItemHolder(View itemView) {
            super(itemView);
            itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Intent intent = new Intent(mContext, NewMallDetailsActivity.class);
                    intent.putExtra("shop_id", shop_id);
                    startActivity(intent);
                }
            });
        }

        @Override
        protected void bindView(HotBean.RemensjBean remensjBean) {
            shop_id = remensjBean.getUserid();
            GlideLoad.GlideLoadImg2(remensjBean.getHead(), ivImg);
            tvName.setText(remensjBean.getNickname() + "");
            tvZhiwu.setText(remensjBean.getOccupationid() + "");
            tvPrice.setText(Constans.RMB + remensjBean.getZuidijia() + "起");
            tvHp.setText("商品  " + remensjBean.getShopnum() + "");
            tvPl.setText("案例  " + remensjBean.getAnlinum());
            tvFens.setText("评价  " + remensjBean.getEvaluate());
            if (remensjBean.getIsshopvip() == 1) {
                ivRz.setVisibility(View.VISIBLE);
            } else {
                ivRz.setVisibility(View.GONE);
            }
            if (remensjBean.getPlatform() == 1) {
                ivRzPt.setVisibility(View.VISIBLE);
            } else {
                ivRzPt.setVisibility(View.GONE);
            }
            if (remensjBean.getCollege() == 1) {
                ivRzXy.setVisibility(View.VISIBLE);
            } else {
                ivRzXy.setVisibility(View.GONE);
            }
            if (remensjBean.getSincerity() == 1) {
                ivRzCx.setVisibility(View.VISIBLE);
            } else {
                ivRzCx.setVisibility(View.GONE);
            }
        }
    }

    private BaseAdapter createAdapter(HotBean bean) {
        BaseAdapter baseAdapter = BaseAdapter.createBaseAdapter();
        baseAdapter
                .injectHolderDelegate(new CreateHolderDelegate<HotBean.RemensjBean>() {
                    @Override
                    protected int getLayoutRes() {
                        return R.layout.item_hot_fragment_layout;
                    }

                    @Override
                    protected BaseViewHolder onCreateHolder(View itemView) {
                        return new ItemHolder(itemView);
                    }
                }.cleanAfterAddAllData(bean.getRemensj()))
        ;
        baseAdapter.setLayoutManager(recycle);
        return baseAdapter;
    }
}
