package com.linzi.xiguwen.fragment;

import android.content.Intent;
import android.os.Bundle;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.viewpager.widget.ViewPager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.GridView;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RadioButton;
import android.widget.TextView;

import com.linzi.xiguwen.MainIndexFragment;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.MenuAdapter;
import com.linzi.xiguwen.adapter.MenuPagerAdapter;
import com.linzi.xiguwen.base.BaseLazyFragment;
import com.linzi.xiguwen.base.adapter.BaseAdapter;
import com.linzi.xiguwen.base.adapter.BaseViewHolder;
import com.linzi.xiguwen.base.adapter.CreateHolderDelegate;
import com.linzi.xiguwen.bean.IndexShopTypeBean;
import com.linzi.xiguwen.bean.MenuBean;
import com.linzi.xiguwen.bean.ShopIndexBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.network.Constans;
import com.linzi.xiguwen.ui.MallAdGoodsListActivity;
import com.linzi.xiguwen.ui.NewGoodsDetailsActivity;
import com.linzi.xiguwen.ui.NewShopMallDetailsActivity;
import com.linzi.xiguwen.ui.ShopAllMenuActivity;
import com.linzi.xiguwen.ui.ShopMenuListActivity;
import com.linzi.xiguwen.ui.WenzhangDetailsActivity;
import com.linzi.xiguwen.utils.CallBack;
import com.linzi.xiguwen.utils.GlideImageLoader;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.location.JumpUtil;
import com.linzi.xiguwen.utils.yixin.ViewUtil;
import com.linzi.xiguwen.view.MyRefreshHeader;
import com.scwang.smartrefresh.layout.SmartRefreshLayout;
import com.scwang.smartrefresh.layout.api.RefreshLayout;
import com.scwang.smartrefresh.layout.listener.OnRefreshListener;
import com.youth.banner.Banner;
import com.youth.banner.BannerConfig;
import com.youth.banner.listener.OnBannerListener;
import com.youth.banner.view.BannerViewPager;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

/**
 * Created by pc on 2018/4/1.
 */

public class NewMallFragment extends BaseLazyFragment {
    @BindView(R.id.recycle)
    RecyclerView recycle;
    @BindView(R.id.refresh_layout)
    SmartRefreshLayout refreshLayout;

    private ArrayList<IndexShopTypeBean> typeBean;
    private ShopIndexBean bean;
    private BaseAdapter mAdapter;
    private int cityid = 0;

    private boolean isInitView;


    public static NewMallFragment create(int cityid) {
        NewMallFragment fragment = new NewMallFragment();
        Bundle bundle = new Bundle();
        bundle.putInt("cityid", cityid);
        fragment.setArguments(bundle);
        return fragment;
    }

    @Override
    public void onLazyLoad() {

    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.new_mall_index_layout, null);
        ButterKnife.bind(this, view);
        return view;
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        cityid = getArguments().getInt("cityid");
        initView();
    }

    private void initView() {
        refreshLayout.setRefreshHeader(new MyRefreshHeader(getActivity()));
        refreshLayout.setEnableLoadMore(false);
        refreshLayout.setOnRefreshListener(new OnRefreshListener() {
            @Override
            public void onRefresh(@NonNull RefreshLayout refreshLayout) {
                getSecData();
            }
        });
        isInitView = true;
        refreshLayout.autoRefresh();
    }

    private void afterView(ShopIndexBean bean) {
        mAdapter = createAdapter(bean, typeBean);
        recycle.setAdapter(mAdapter);
    }

    private void getData() {
        ApiManager.getIndexShop(cityid, new OnRequestFinish<BaseBean<ShopIndexBean>>() {
            @Override
            public void onFinished() {
            }

            @Override
            public void onSuccess(BaseBean<ShopIndexBean> data) {
                bean = data.getData();
                afterView(bean);
            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }

    private void getSecData() {
        ApiManager.getIndexShopType(new OnRequestFinish<BaseBean<ArrayList<IndexShopTypeBean>>>() {
            @Override
            public void onFinished() {
                refreshLayout.finishRefresh();
            }

            @Override
            public void onSuccess(BaseBean<ArrayList<IndexShopTypeBean>> data) {
                typeBean = data.getData();
                getData();
            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
         
    }

    //bannerHolder
    class BannerHolder extends BaseViewHolder<ShopIndexBean> {
        @BindView(R.id.banner)
        Banner banner;

        public BannerHolder(View itemView) {
            super(itemView);
        }

        @Override
        protected void bindView(final ShopIndexBean bean) {
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

    //sec bannerHolder
    class SecBannerHolder extends BaseViewHolder<ArrayList<IndexShopTypeBean>> {
        @BindView(R.id.menu_pager)
        BannerViewPager menuPager;
        @BindView(R.id.ll_point)
        LinearLayout llPoint;
        private MenuBean mIcon = new MenuBean();
        private List<View> menu_pager;
        private MenuAdapter mAdapter;

        public SecBannerHolder(View itemView) {
            super(itemView);
        }

        @Override
        protected void bindView(ArrayList<IndexShopTypeBean> indexShopTypeBean) {
            setMenuPager(indexShopTypeBean);
        }

        private void setMenuPager(ArrayList<IndexShopTypeBean> indexShopTypeBean) {
            setMenuIcon(indexShopTypeBean);
            int menu_page_size = 0;//分页 10个一页
            if ((mIcon.getMenus().size() % 10) == 0) {
                menu_page_size = (mIcon.getMenus().size() / 10);
            } else {
                menu_page_size = ((int) (mIcon.getMenus().size() / 10)) + 1;
            }

            List<MenuBean.Menu> mData;

            menu_pager = new ArrayList<>();

            final List<RadioButton> point_list = new ArrayList<>();

            llPoint.removeAllViews();//清除所有的子view

            for (int x = 0; x < menu_page_size; x++) {
                View view = LayoutInflater.from(getActivity()).inflate(R.layout.item_main_menu_pager, null);
                GridView grid = (GridView) view.findViewById(R.id.gridview);
                mData = new ArrayList<>();
                int menu_size = 0;
                if (mIcon != null) {
                    NToast.log("本页菜单==========", "" + mIcon.getMenus().size());
                    if (((x + 1) * 10) <= mIcon.getMenus().size()) {
                        menu_size = (Integer.valueOf(x) + 1) * 10;
                    } else {
                        menu_size = mIcon.getMenus().size();
                    }
                    for (int i = (10 * x); i < menu_size; i++) {
                        mData.add(mIcon.getMenus().get(i));
                    }
                }
                mAdapter = new MenuAdapter(getActivity(), mData, new CallBack.OnMenuItemClickListener() {
                    @Override
                    public void itemClick(int position) {

                    }

                    @Override
                    public void itemClick(int position, String name) {
                        Intent intent;
                        if (position == -1) {//全部分类
                            intent = new Intent(getActivity(), ShopAllMenuActivity.class);
                        } else {
                            intent = new Intent(getActivity(), ShopMenuListActivity.class);
                            intent.putExtra("city", MainIndexFragment.instence.city_code);
                            intent.putExtra("id", position);
                        }
                        startActivity(intent);
                    }
                });
                grid.setAdapter(mAdapter);
                menu_pager.add(view);

                View point_view = LayoutInflater.from(getActivity()).inflate(R.layout.index_point_rb, null);
                RadioButton rb = (RadioButton) point_view.findViewById(R.id.rb);
                point_list.add(rb);
                llPoint.addView(point_view);
            }
            menuPager.setAdapter(new MenuPagerAdapter(getActivity(), menu_pager));
            point_list.get(0).setChecked(true);
            menuPager.setOnPageChangeListener(new ViewPager.OnPageChangeListener() {
                @Override
                public void onPageScrolled(int position, float positionOffset, int positionOffsetPixels) {

                }

                @Override
                public void onPageSelected(int position) {
                    for (int x = 0; x < point_list.size(); x++) {
                        if (x == position) {
                            point_list.get(x).setChecked(true);
                        } else {
                            point_list.get(x).setChecked(false);
                        }
                    }
                }

                @Override
                public void onPageScrollStateChanged(int state) {

                }
            });
        }

        //设置分类图标
        private void setMenuIcon(ArrayList<IndexShopTypeBean> indexShopTypeBean) {
            List<MenuBean.Menu> list = new ArrayList<>();
            MenuBean.Menu menuall = new MenuBean.Menu();
            menuall.setId(-1);
            menuall.setTitle("分类");
            list.add(menuall);
            for (int x = 0; x < indexShopTypeBean.size(); x++) {
                MenuBean.Menu menu = new MenuBean.Menu();
                menu.setId(indexShopTypeBean.get(x).getId());
                menu.setIcon(indexShopTypeBean.get(x).getWapimg());
                menu.setTitle(indexShopTypeBean.get(x).getWapname());
                list.add(menu);
                NToast.log(getContext(), menu.toString());
            }
            mIcon.setMenus(list);
        }
    }

    //6个广告Holder
    class SixHolder extends BaseViewHolder<ShopIndexBean> {
        @BindView(R.id.iv_haohuo)
        ImageView ivHaohuo;
        @BindView(R.id.iv_qingdan)
        ImageView ivQingdan;
        @BindView(R.id.iv_aiguang)
        ImageView ivAiguang;
        @BindView(R.id.iv_xianshi)
        ImageView ivXianshi;
        @BindView(R.id.iv_baokuan)
        ImageView ivBaokuan;
        @BindView(R.id.iv_nanshi)
        ImageView ivNanshi;
        private ShopIndexBean remenhuodongBean;

        public SixHolder(View itemView) {
            super(itemView);
        }

        @OnClick({R.id.iv_haohuo, R.id.iv_qingdan, R.id.iv_aiguang, R.id.iv_xianshi, R.id.iv_baokuan, R.id.iv_nanshi})
        public void onClick(View view) {
            switch (view.getId()) {
                case R.id.iv_haohuo:
                    JumpUtil.judgeJump(getActivity(), remenhuodongBean.getYouhaohuo().getAdid(), remenhuodongBean.getYouhaohuo().getSrc(), MallAdGoodsListActivity.class, "有好货", 1);
                    break;
                case R.id.iv_qingdan:
                    JumpUtil.judgeJump(getActivity(), remenhuodongBean.getBimai().getRmhd1().getAdid(), remenhuodongBean.getBimai().getRmhd1().getSrc(), MallAdGoodsListActivity.class, "必买清单", 2);
                    break;
                case R.id.iv_aiguang:
                    JumpUtil.judgeJump(getActivity(), remenhuodongBean.getBimai().getRmhd2().getAdid(), remenhuodongBean.getBimai().getRmhd2().getSrc(), MallAdGoodsListActivity.class, "爱逛街", 3);
                    break;
                case R.id.iv_xianshi:
                    JumpUtil.judgeJump(getActivity(), remenhuodongBean.getBimai().getRmhd3().getAdid(), remenhuodongBean.getBimai().getRmhd3().getSrc(), MallAdGoodsListActivity.class, "限时抢购", 4);
                    break;
                case R.id.iv_baokuan:
                    JumpUtil.judgeJump(getActivity(), remenhuodongBean.getBimai().getRmhd4().getAdid(), remenhuodongBean.getBimai().getRmhd4().getSrc(), MallAdGoodsListActivity.class, "抢爆款", 5);
                    break;
                case R.id.iv_nanshi:
                    JumpUtil.judgeJump(getActivity(), remenhuodongBean.getBimai().getRmhd5().getAdid(), remenhuodongBean.getBimai().getRmhd5().getSrc(), MallAdGoodsListActivity.class, "男士专区", 6);
                    break;
            }
        }


        @Override
        protected void bindView(ShopIndexBean bean) {
            this.remenhuodongBean = bean;
            GlideLoad.GlideLoadImg2(bean.getYouhaohuo().getWapimg(), ivHaohuo);
            GlideLoad.GlideLoadImg2(bean.getBimai().getRmhd1().getWapimg(), ivQingdan);
            GlideLoad.GlideLoadImg2(bean.getBimai().getRmhd2().getWapimg(), ivAiguang);
            GlideLoad.GlideLoadImg2(bean.getBimai().getRmhd3().getWapimg(), ivXianshi);
            GlideLoad.GlideLoadImg2(bean.getBimai().getRmhd4().getWapimg(), ivBaokuan);
            GlideLoad.GlideLoadImg2(bean.getBimai().getRmhd5().getWapimg(), ivNanshi);
        }
    }

    //thr holder
    class ThrHolder extends BaseViewHolder<ShopIndexBean.XiaoguanggaoyiBean> {
        @BindView(R.id.iv_activities)
        ImageView ivActivities;

        public ThrHolder(View itemView) {
            super(itemView);
        }

        @Override
        protected void bindView(final ShopIndexBean.XiaoguanggaoyiBean xiaoguanggaoyiBean) {
            GlideLoad.GlideLoadImg2(xiaoguanggaoyiBean.getWapimg(), ivActivities);
            itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    JumpUtil.judgeJump(getActivity(), xiaoguanggaoyiBean.getAptid(), xiaoguanggaoyiBean.getAptype(), xiaoguanggaoyiBean.getSrc());
                }
            });
        }
    }

    //tiltle holder
    class TiltleHolder extends BaseViewHolder<Integer> {
        @BindView(R.id.iv_title)
        ImageView tiltle;

        public TiltleHolder(View itemView) {
            super(itemView);
        }

        @Override
        protected void bindView(Integer s) {
            tiltle.setBackgroundResource(s.intValue());
        }
    }

    //标题Delegate
    class TitleDelegate extends CreateHolderDelegate<Integer> {
        @Override
        protected int onSpanSize() {
            return 60;
        }

        @Override
        protected int getLayoutRes() {
            return R.layout.new_mall_title_layout;
        }

        @Override
        protected BaseViewHolder onCreateHolder(View itemView) {
            return new TiltleHolder(itemView);
        }
    }

    //热销品牌Holder
    class HotSellPinPaiHolder extends BaseViewHolder<ShopIndexBean.RenmenpinpaiBean> {
        @BindView(R.id.tv_rexiaopingpai)
        ImageView tv_rexiaopingpai;
        private int adid;
        private int aptype;
        private String src;

        public HotSellPinPaiHolder(View itemView) {
            super(itemView);
            itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    JumpUtil.judgeJump(getActivity(), adid, aptype, src);
                }
            });
        }

        @Override
        protected void bindView(final ShopIndexBean.RenmenpinpaiBean renmenpinpaiBean) {
            adid = renmenpinpaiBean.getAptid();
            aptype = renmenpinpaiBean.getAptype();
            src = renmenpinpaiBean.getSrc();
            NToast.log("APPTAG", adid + "\n" + aptype + "\n" + src);
            GlideLoad.GlideLoadImg2(renmenpinpaiBean.getWapimg(), tv_rexiaopingpai);

        }
    }

    //热销商品Holder
    class HotSellGoodsHolder extends BaseViewHolder<ShopIndexBean.RemenshangpinBean> {
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
        protected void bindView(ShopIndexBean.RemenshangpinBean remenshangpinBean) {
            ViewUtil.setNumOfScreenWidth(getActivity(), ivImg, 2);

            id = remenshangpinBean.getShopid();
            tvContext.setVisibility(View.GONE);
            tvSaleCount.setVisibility(View.VISIBLE);
            tvSeeCount.setVisibility(View.GONE);
            tvSaleCount.setText(remenshangpinBean.getFollows() + "人喜欢");
            tvPrice.setText(Constans.RMB + remenshangpinBean.getPrice());
            tvTitle.setText("" + remenshangpinBean.getShopname());
            GlideLoad.GlideLoadImg2(remenshangpinBean.getShopimg().get(0), ivImg);
        }
    }

    //猜你喜欢Holder
    class GussULikeHolder extends BaseViewHolder<ShopIndexBean.YouloveBean> {
        @BindView(R.id.iv_img)
        ImageView ivImg;
        @BindView(R.id.tv_goods_name)
        TextView tvGoodsName;
        @BindView(R.id.tv_price)
        TextView tvPrice;
        @BindView(R.id.tv_num_love)
        TextView tvNumLove;
        @BindView(R.id.tv_location)
        TextView tvLocation;
        @BindView(R.id.tv_into_mall)
        TextView tvintomall;
        private int shop_id;
        private int goods_id;

        public GussULikeHolder(View itemView) {
            super(itemView);
            itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Intent intent = new Intent(getActivity(), NewGoodsDetailsActivity.class);
                    intent.putExtra("goods_id", goods_id);
                    startActivity(intent);
                }
            });
        }

        @Override
        protected void bindView(ShopIndexBean.YouloveBean youloveBean) {
            tvintomall.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Intent intent = new Intent(getActivity(), NewShopMallDetailsActivity.class);
                    intent.putExtra("shop_id", shop_id);
                    startActivity(intent);
                }
            });
            shop_id = youloveBean.getUserid();
            goods_id = youloveBean.getShopid();
            GlideLoad.GlideLoadImg2(youloveBean.getShopimg(), ivImg);
            tvGoodsName.setText(youloveBean.getShopname());
            tvPrice.setText(Constans.RMB + youloveBean.getPrice());
            tvNumLove.setText(youloveBean.getFollows() + "人喜欢");
            tvLocation.setText(youloveBean.getCity());
        }
    }

    private BaseAdapter createAdapter(ShopIndexBean bean, ArrayList<IndexShopTypeBean> typeBean) {
        BaseAdapter baseAdapter = BaseAdapter.createBaseAdapter();
        baseAdapter
                .injectHolderDelegate(new CreateHolderDelegate<ShopIndexBean>() {
                    @Override
                    protected int onSpanSize() {
                        return 60;
                    }

                    @Override
                    protected int getLayoutRes() {
                        return R.layout.new_mall_index_banner_layout;
                    }

                    @Override
                    protected BaseViewHolder onCreateHolder(View itemView) {
                        return new BannerHolder(itemView);
                    }
                }.cleanAfterAddData(bean))

                .injectHolderDelegate(new CreateHolderDelegate<ArrayList<IndexShopTypeBean>>() {
                    @Override
                    protected int onSpanSize() {
                        return 60;
                    }

                    @Override
                    protected int getLayoutRes() {
                        return R.layout.new_mall_index_sec_ad_layout;
                    }

                    @Override
                    protected BaseViewHolder onCreateHolder(View itemView) {
                        return new SecBannerHolder(itemView);
                    }
                }.cleanAfterAddData(typeBean))
                .injectHolderDelegate(new CreateHolderDelegate<String>() {
                    @Override
                    protected int onSpanSize() {
                        return 60;
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

                            }
                        };
                    }
                }.addData(""))//分割线View
                .injectHolderDelegate(new CreateHolderDelegate<ShopIndexBean>() {
                    @Override
                    protected int onSpanSize() {
                        return 60;
                    }

                    @Override
                    protected int getLayoutRes() {
                        return R.layout.new_mall_index_six_layout;
                    }

                    @Override
                    protected BaseViewHolder onCreateHolder(View itemView) {
                        return new SixHolder(itemView);
                    }
                }.cleanAfterAddData(bean))
                .injectHolderDelegate(new CreateHolderDelegate<String>() {
                    @Override
                    protected int onSpanSize() {
                        return 60;
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

                            }
                        };
                    }
                }.addData(""))//分割线View
                .injectHolderDelegate(new CreateHolderDelegate<ShopIndexBean.XiaoguanggaoyiBean>() {
                    @Override
                    protected int onSpanSize() {
                        return 60;
                    }

                    @Override
                    protected int getLayoutRes() {
                        return R.layout.new_mall_thr_ad_layout;
                    }

                    @Override
                    protected BaseViewHolder onCreateHolder(View itemView) {
                        return new ThrHolder(itemView);
                    }
                }.cleanAfterAddAllData(bean.getXiaoguanggaoyi()))
                .injectHolderDelegate(new CreateHolderDelegate<String>() {
                    @Override
                    protected int onSpanSize() {
                        return 60;
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

                            }
                        };
                    }
                }.addData(""))//分割线View
                .injectHolderDelegate(new TitleDelegate().addData(R.mipmap.img_hot_pinpai))
                .injectHolderDelegate(new CreateHolderDelegate<ShopIndexBean.RenmenpinpaiBean>() {
                    @Override
                    protected int onSpanSize() {
                        return 20;
                    }

                    @Override
                    protected int getLayoutRes() {
                        return R.layout.new_mall_hotsell_layout;
                    }

                    @Override
                    protected BaseViewHolder onCreateHolder(View itemView) {
                        return new HotSellPinPaiHolder(itemView);
                    }
                }.cleanAfterAddAllData(bean.getRenmenpinpai()))
                .injectHolderDelegate(new CreateHolderDelegate<String>() {
                    @Override
                    protected int onSpanSize() {
                        return 60;
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

                            }
                        };
                    }
                }.addData(""))//分割线View
                .injectHolderDelegate(new TitleDelegate().addData(R.mipmap.img_hot_goods))

                .injectHolderDelegate(new CreateHolderDelegate<ShopIndexBean.RemenshangpinBean>() {
                    @Override
                    protected int onSpanSize() {
                        return 30;
                    }

                    @Override
                    protected int getLayoutRes() {
                        return R.layout.item_mall_index_works_layout;
                    }

                    @Override
                    protected BaseViewHolder onCreateHolder(View itemView) {
                        return new HotSellGoodsHolder(itemView);
                    }
                }.cleanAfterAddAllData(bean.getRemenshangpin()))
                .injectHolderDelegate(new CreateHolderDelegate<String>() {
                    @Override
                    protected int onSpanSize() {
                        return 60;
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

                            }
                        };
                    }
                }.addData(""))//分割线View
                .injectHolderDelegate(new TitleDelegate().addData(R.mipmap.icon_guess_shangjia))
                .injectHolderDelegate(new CreateHolderDelegate<ShopIndexBean.YouloveBean>() {
                    @Override
                    protected int onSpanSize() {
                        return 60;
                    }

                    @Override
                    protected int getLayoutRes() {
                        return R.layout.new_mall_gussulike_layout;
                    }

                    @Override
                    protected BaseViewHolder onCreateHolder(View itemView) {
                        return new GussULikeHolder(itemView);
                    }
                }.cleanAfterAddAllData(bean.getYoulove()))
        ;
        baseAdapter.setLayoutManager(recycle);
        return baseAdapter;
    }

    //跳转H5
    private void intentH5(String url, String title) {
        Intent intent = new Intent(getActivity(), WenzhangDetailsActivity.class);
        intent.putExtra("url", url);
        intent.putExtra("title", title);
        startActivity(intent);
    }

}
