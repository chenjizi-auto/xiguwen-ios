package com.linzi.xiguwen.fragment;

import android.content.Intent;
import android.os.Bundle;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.base.BaseLazyFragment;
import com.linzi.xiguwen.base.adapter.BaseAdapter;
import com.linzi.xiguwen.base.adapter.BaseViewHolder;
import com.linzi.xiguwen.base.adapter.CreateHolderDelegate;
import com.linzi.xiguwen.bean.HotBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.network.Constans;
import com.linzi.xiguwen.ui.HotByTypeActivty;
import com.linzi.xiguwen.ui.NewMallDetailsActivity;
import com.linzi.xiguwen.utils.GlideImageLoader;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;
import com.linzi.xiguwen.utils.location.JumpUtil;
import com.linzi.xiguwen.utils.yixin.preference.Preferences;
import com.linzi.xiguwen.view.MyRefreshFooter;
import com.linzi.xiguwen.view.MyRefreshHeader;
import com.scwang.smartrefresh.layout.SmartRefreshLayout;
import com.scwang.smartrefresh.layout.api.RefreshLayout;
import com.scwang.smartrefresh.layout.listener.OnLoadMoreListener;
import com.scwang.smartrefresh.layout.listener.OnRefreshListener;
import com.youth.banner.Banner;
import com.youth.banner.BannerConfig;
import com.youth.banner.listener.OnBannerListener;

import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

/**
 * Created by pc on 2018/4/1.
 */

public class NewHotFragment extends BaseLazyFragment {

    @BindView(R.id.recycle)
    RecyclerView recycle;
    @BindView(R.id.ll_group2)
    LinearLayout llGroup2;
    @BindView(R.id.no_data_view)
    ImageView noDataView;
    @BindView(R.id.refresh_layout)
    SmartRefreshLayout refreshLayout;

    private int page = 1;
    private int rows = 10;
    private boolean isCanLoadMore;
    private HotBean bean;
    private BaseAdapter mAdapter;

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
    private int types = 1;//	1今日推荐2本周人气3本月人气4本周热门5本月热门
    private int cityid = -1;//城市id

    private boolean isInitView;


    public static NewHotFragment createFragment() {
        return new NewHotFragment();
    }

    @Override
    public void onLazyLoad() {

    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.new_index_hot_fra_layout, null);
        ButterKnife.bind(this, view);
        return view;
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        EventBusUtil.register(this);
        initView();
        isCanLoadMore = true;
    }

    private void initView() {
        refreshLayout.setRefreshHeader(new MyRefreshHeader(getActivity()));
        refreshLayout.setRefreshFooter(new MyRefreshFooter(getActivity()));

        refreshLayout.setOnRefreshListener(new OnRefreshListener() {
            @Override
            public void onRefresh(@NonNull RefreshLayout refreshLayout) {
                isCanLoadMore = true;
                nodataDelegate.clearAll();
                refreshLayout.setEnableLoadMore(true);
                getData(false);
            }
        });

        refreshLayout.setOnLoadMoreListener(new OnLoadMoreListener() {
            @Override
            public void onLoadMore(@NonNull RefreshLayout refreshLayout) {
                if (isCanLoadMore) {
                    nodataDelegate.clearAll();
                    getData(true);
                }
            }
        });

        noDataView.setVisibility(View.GONE);
//        recycle.addOnScrollListener(new OnRcvScrollListener() {
//            @Override
//            public void onBottom() {
//                super.onBottom();
//                if (isCanLoadMore) {
//                    nodataDelegate.clearAll();
//                    getData(true);
//                }
//            }

//            @Override
//            public void onScrolled(RecyclerView recyclerView, int dx, int dy) {
//                super.onScrolled(recyclerView, dx, dy);
//
//                int position = ((LinearLayoutManager) recyclerView.getLayoutManager()).findFirstVisibleItemPosition();
//                if (position > 0) {
//                    llGroup2.setVisibility(View.VISIBLE);
//                    return;
//                } else {
//                    llGroup2.setVisibility(View.GONE);
//                }
//            }
// });

        afterView();
        isInitView = true;
        refreshLayout.autoRefresh();
    }

    private void afterView() {
        mAdapter = createAdapter();
        recycle.setAdapter(mAdapter);
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

                if (hotBean.getGuanggaolunbo() != null && hotBean.getGuanggaolunbo().size() > 0) {
                    headDelegate.cleanAfterAddData(hotBean);
                } else {
                    headDelegate.clearAll();
                }

                if (hotBean.getRemensj() != null && hotBean.getRemensj().size() > 0) {
                    if (isLoadMore) {
                        bean.getRemensj().addAll(hotBean.getRemensj());
                        itemDelegate.addAllData(hotBean.getRemensj());
                    } else {
                        bean = hotBean;
                        itemDelegate.cleanAfterAddAllData(bean.getRemensj());
                    }
                    nodataDelegate.clearAll();
                } else {
                    nodataDelegate.addData("");
                    if (isLoadMore) {
                        isCanLoadMore = false;
                        refreshLayout.setEnableLoadMore(false);
                        page--;
                    }
                }

                mAdapter.notifyDataSetChanged();
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
         
        EventBusUtil.unregister(this);
    }

    //noDataView delegate
    CreateHolderDelegate<String> nodataDelegate = new CreateHolderDelegate<String>() {

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
    };

    //headview delegate
    CreateHolderDelegate<HotBean> headDelegate = new CreateHolderDelegate<HotBean>() {
        @Override
        protected int getLayoutRes() {
            return R.layout.hot_head_layout;
        }

        @Override
        protected BaseViewHolder onCreateHolder(View itemView) {
            return new HeadHolder(itemView);
        }
    };

    //item delegate
    CreateHolderDelegate<HotBean.RemensjBean> itemDelegate = new CreateHolderDelegate<HotBean.RemensjBean>() {
        @Override
        protected int getLayoutRes() {
            return R.layout.item_hot_fragment_layout;
        }

        @Override
        protected BaseViewHolder onCreateHolder(View itemView) {
            return new ItemHolder(itemView);
        }
    };

    //分类holder
    class TypeHolder extends BaseViewHolder<String> {
        @BindView(R.id.ll_group)
        LinearLayout llGroup;

        private int type;//	1今日推荐2本周人气3本月人气4本周热门5本月热门

        public TypeHolder(View itemView) {
            super(itemView);
        }

        @Override
        protected void bindView(String s) {

        }

        @OnClick({R.id.rl_today_top, R.id.rl_week_peo, R.id.rl_month_peo, R.id.rl_week_hot, R.id.rl_month_hot, R.id.rb_all, R.id.rb_sort, R.id.rb_location, R.id.rb_saixuan})
        public void onClick(View view) {
            switch (view.getId()) {
                case R.id.rl_today_top:
                    intentByType(1);
                    break;
                case R.id.rl_week_peo:
                    intentByType(2);
                    break;
                case R.id.rl_month_peo:
                    intentByType(3);
                    break;
                case R.id.rl_week_hot:
                    intentByType(4);
                    break;
                case R.id.rl_month_hot:
                    intentByType(5);
                    break;
                case R.id.rb_all:

                    break;
                case R.id.rb_sort:
                    comprehensive = 1;
                    break;
                case R.id.rb_location:

                    break;
                case R.id.rb_saixuan:

                    break;

            }
        }

        private void intentByType(int type) {
            Intent intent = new Intent(getActivity(), HotByTypeActivty.class);
            intent.putExtra("hot_type", type);
            getActivity().startActivity(intent);
        }

    }

    //headview Holder
    class HeadHolder extends BaseViewHolder<HotBean> {
        @BindView(R.id.banner)
        Banner banner;

        public HeadHolder(View itemView) {
            super(itemView);

        }

        @Override
        protected void bindView(final HotBean bean) {
            List<String> url;
            if (bean.getGuanggaolunbo() != null && bean.getGuanggaolunbo().size() > 0) {
                url = new ArrayList<>();//bannerurl
                for (int i = 0; i < bean.getGuanggaolunbo().size(); i++) {
                    url.add(bean.getGuanggaolunbo().get(i).getWapimg());
                }
            } else {
                url = new ArrayList<>();
            }
            banner.setImages(url)
                    .setImageLoader(new GlideImageLoader())
                    .setIndicatorGravity(BannerConfig.CENTER)
                    .setDelayTime(2000)
                    .start();
            banner.setOnBannerListener(new OnBannerListener() {
                @Override
                public void OnBannerClick(int position) {
                    JumpUtil.judgeJump(getActivity(), bean.getGuanggaolunbo().get(position).getAptid(), bean.getGuanggaolunbo().get(position).getAptype(), bean.getGuanggaolunbo().get(position).getSrc());
                }
            });
        }
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
                    Intent intent = new Intent(getActivity(), NewMallDetailsActivity.class);
                    intent.putExtra("shop_id", shop_id);
                    getActivity().startActivity(intent);
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

    private BaseAdapter createAdapter() {
        BaseAdapter baseAdapter = BaseAdapter.createBaseAdapter();
        baseAdapter
                .injectHolderDelegate(headDelegate.cleanAfterAddData(null))
                .injectHolderDelegate(new CreateHolderDelegate<String>() {
                    @Override
                    protected int getLayoutRes() {
                        return R.layout.hot_type_layout;
                    }

                    @Override
                    protected BaseViewHolder onCreateHolder(View itemView) {
                        return new TypeHolder(itemView);
                    }
                }.addData(""))
                .injectHolderDelegate(itemDelegate.cleanAfterAddAllData(null))
                .injectHolderDelegate(nodataDelegate.cleanAfterAddData(""))
        ;
        nodataDelegate.clearAll();
        baseAdapter.setLayoutManager(recycle);
        return baseAdapter;
    }

    @Subscribe(threadMode = ThreadMode.MAIN)
    public void receiveEvent(Event entity) {
        if (entity == null)
            return;
        try {
            int code = entity.getCode();
            switch (code) {
                case EventCode.CITY_SELECT:
                    refreshView();
                    break;
                case EventCode.LOGIN_SUCCESS:
                    refreshView();
                    break;
            }
        } catch (Exception e) {
        }

    }

    private void refreshView() {
        if (isInitView) {
            refreshLayout.autoRefresh();
        } else {
            initView();
        }
    }
}
