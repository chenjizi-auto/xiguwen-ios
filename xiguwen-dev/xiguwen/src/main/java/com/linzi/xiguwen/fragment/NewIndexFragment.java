package com.linzi.xiguwen.fragment;

import android.content.Intent;
import android.os.Bundle;
import android.os.SystemClock;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.viewpager.widget.ViewPager;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.OrientationHelper;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.GridView;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RadioButton;
import android.widget.TextView;

import com.linzi.xiguwen.MainIndexFragment;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.HotMallListAdapter;
import com.linzi.xiguwen.adapter.MenuAdapter;
import com.linzi.xiguwen.adapter.MenuPagerAdapter;
import com.linzi.xiguwen.base.BaseLazyFragment;
import com.linzi.xiguwen.base.adapter.BaseAdapter;
import com.linzi.xiguwen.base.adapter.BaseViewHolder;
import com.linzi.xiguwen.base.adapter.CreateHolderDelegate;
import com.linzi.xiguwen.bean.IndexWeddingTypeBean;
import com.linzi.xiguwen.bean.MenuBean;
import com.linzi.xiguwen.bean.NewIndexBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.network.Constans;
import com.linzi.xiguwen.ui.AllClassicActivity;
import com.linzi.xiguwen.ui.ForNeedActivity;
import com.linzi.xiguwen.ui.GetSuggestActivity;
import com.linzi.xiguwen.ui.HistoryActivity;
import com.linzi.xiguwen.ui.LoginActivity;
import com.linzi.xiguwen.ui.MallListActivity;
import com.linzi.xiguwen.ui.MineChakanNeed2Activity;
import com.linzi.xiguwen.ui.MineDangqiActivity;
import com.linzi.xiguwen.ui.NewBaijiaDetailsActivity;
import com.linzi.xiguwen.ui.NewElectronicinvitationActivity;
import com.linzi.xiguwen.ui.NewExampleDetailsActivity;
import com.linzi.xiguwen.ui.NewMallDetailsActivity;
import com.linzi.xiguwen.ui.SearchExampleActivty;
import com.linzi.xiguwen.ui.SpecialRecommendedActivity;
import com.linzi.xiguwen.utils.CallBack;
import com.linzi.xiguwen.utils.FullScreenUtil;
import com.linzi.xiguwen.utils.GlideImageLoader;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.LoginUtil;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;
import com.linzi.xiguwen.utils.location.JumpUtil;
import com.linzi.xiguwen.utils.yixin.preference.Preferences;
import com.linzi.xiguwen.view.MyRefreshHeader;
import com.linzi.xiguwen.webview.WebViewVideoActivity;
import com.scwang.smartrefresh.layout.SmartRefreshLayout;
import com.scwang.smartrefresh.layout.api.RefreshLayout;
import com.scwang.smartrefresh.layout.listener.OnRefreshListener;
import com.youth.banner.Banner;
import com.youth.banner.BannerConfig;
import com.youth.banner.listener.OnBannerListener;
import com.youth.banner.view.BannerViewPager;

import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;
import fm.jiecao.jcvideoplayer_lib.JCFullScreenActivity;
import fm.jiecao.jcvideoplayer_lib.JCVideoPlayerStandard;

/**
 * Created by pc on 2018/4/1.
 */

public class NewIndexFragment extends BaseLazyFragment {
    @BindView(R.id.recycle)
    RecyclerView recycle;
    @BindView(R.id.refresh_layout)
    SmartRefreshLayout refreshLayout;

    private BaseAdapter mAdapter;
    private NewIndexBean bean;
    private int cityid;
    private ArrayList<IndexWeddingTypeBean> typeBean;

    private boolean isInitView;
    private boolean isRefreshing = false;
    private long lastAutoRefreshAt = 0L;

    public static NewIndexFragment createFragment() {
        NewIndexFragment fragment = new NewIndexFragment();
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
        EventBusUtil.register(this);
        initView();
    }

    private void initView() {
        refreshLayout.setRefreshHeader(new MyRefreshHeader(getActivity()));
        refreshLayout.setEnableLoadMore(false);
        refreshLayout.setOnRefreshListener(new OnRefreshListener() {
            @Override
            public void onRefresh(@NonNull RefreshLayout refreshLayout) {
                triggerSilentRefresh();
            }
        });
        isInitView = true;
        triggerSilentRefresh();
    }

    private void afterView(NewIndexBean bean, ArrayList<IndexWeddingTypeBean> typeBean) {
        mAdapter = createAdapter(bean, typeBean);
        recycle.setAdapter(mAdapter);
    }

    private void getData() {
        cityid = Preferences.getCity().getId();
        ApiManager.getIndex(cityid + "", new OnRequestFinish<BaseBean<NewIndexBean>>() {
            @Override
            public void onFinished() {
            }

            @Override
            public void onSuccess(BaseBean<NewIndexBean> data) {
                bean = data.getData();
                afterView(bean, typeBean);
            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }

    private void getSecData() {
        ApiManager.getIndexWeddingType(new OnRequestFinish<BaseBean<ArrayList<IndexWeddingTypeBean>>>() {
            @Override
            public void onFinished() {
                refreshLayout.finishRefresh();
                isRefreshing = false;
            }

            @Override
            public void onSuccess(BaseBean<ArrayList<IndexWeddingTypeBean>> data) {
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
         
        EventBusUtil.unregister(this);
    }

    //bannerHolder
    class BannerHolder extends BaseViewHolder<NewIndexBean> {
        @BindView(R.id.banner)
        Banner banner;

        public BannerHolder(View itemView) {
            super(itemView);
        }

        @Override
        protected void bindView(final NewIndexBean bean) {
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
    class SecBannerHolder extends BaseViewHolder<ArrayList<IndexWeddingTypeBean>> {
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
        protected void bindView(ArrayList<IndexWeddingTypeBean> indexShopTypeBean) {
            setMenuPager(indexShopTypeBean);
        }

        private void setMenuPager(ArrayList<IndexWeddingTypeBean> indexShopTypeBean) {
            setMenuIcon(indexShopTypeBean);
            int menu_page_size = 0;//分页 10个一页
            if ((mIcon.getMenus().size() % 10) == 0) {
                menu_page_size = (mIcon.getMenus().size() / 10);
            } else {
                menu_page_size = ((int) (mIcon.getMenus().size() / 10)) + 1;
            }

            menu_pager = new ArrayList<>();

            final List<RadioButton> point_list = new ArrayList<>();

            llPoint.removeAllViews();//清除所有的子view

            for (int x = 0; x < menu_page_size; x++) {
                View view = LayoutInflater.from(getActivity()).inflate(R.layout.item_main_menu_pager, null);
                GridView grid = (GridView) view.findViewById(R.id.gridview);
                final List<MenuBean.Menu> mData = new ArrayList<>();
                int menu_size = 0;
                if (mIcon != null) {
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
                            intent = new Intent(getActivity(), AllClassicActivity.class);
                        } else {
                            intent = new Intent(getActivity(), MallListActivity.class);
                            intent.putExtra("city", MainIndexFragment.instence.city_code);
                            intent.putExtra("id", position);
                            intent.putExtra("name", name);
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
        private void setMenuIcon(ArrayList<IndexWeddingTypeBean> indexShopTypeBean) {
            List<MenuBean.Menu> list = new ArrayList<>();
            MenuBean.Menu menuall = new MenuBean.Menu();
            menuall.setId(-1);
            menuall.setTitle("全部");
            list.add(menuall);
            for (int x = 0; x < indexShopTypeBean.size(); x++) {
                MenuBean.Menu menu = new MenuBean.Menu();
                menu.setId(indexShopTypeBean.get(x).getOccupationid());
                menu.setIcon(indexShopTypeBean.get(x).getWapimg());
                menu.setTitle(indexShopTypeBean.get(x).getProname());
                list.add(menu);
            }
            mIcon.setMenus(list);
        }
    }

    //thr holder
    class ThrHolder extends BaseViewHolder<NewIndexBean.XiaoguanggaoyiBean> {
        @BindView(R.id.iv_activities)
        ImageView ivActivities;

        public ThrHolder(View itemView) {
            super(itemView);

        }

        @Override
        protected void bindView(final NewIndexBean.XiaoguanggaoyiBean xiaoguanggaoyiBean) {
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

    //tiltle2 holder
    class TiltleHolder2 extends BaseViewHolder<String> {
        @BindView(R.id.tv_title)
        TextView textView;

        public TiltleHolder2(View itemView) {
            super(itemView);
        }

        @Override
        protected void bindView(String s) {
            textView.setText(s);
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

    //标题2Delegate
    class TitleDelegate2 extends CreateHolderDelegate<String> {
        @Override
        protected int onSpanSize() {
            return 60;
        }

        @Override
        protected int getLayoutRes() {
            return R.layout.new_index_wedding_title_layout;
        }

        @Override
        protected BaseViewHolder onCreateHolder(View itemView) {
            return new TiltleHolder2(itemView);
        }
    }

    //热门团队商家
    class HotTeamShopHolder extends BaseViewHolder<NewIndexBean> {
        @BindView(R.id.recycleview)
        RecyclerView recycle;
        private HotMallListAdapter adapter;

        public HotTeamShopHolder(View itemView) {
            super(itemView);
        }

        @Override
        protected void bindView(final NewIndexBean bean) {
            LinearLayoutManager manager = new LinearLayoutManager(getActivity(), OrientationHelper.HORIZONTAL, false);
            adapter = new HotMallListAdapter(getActivity(), bean, 0);
            recycle.setLayoutManager(manager);
            recycle.setAdapter(adapter);
        }


    }

    //热门个人商家
    class HotShopHolder extends BaseViewHolder<NewIndexBean> {
        @BindView(R.id.recycleview)
        RecyclerView recycle;
        private HotMallListAdapter adapter;

        public HotShopHolder(View itemView) {
            super(itemView);
        }

        @Override
        protected void bindView(final NewIndexBean bean) {
            LinearLayoutManager manager = new LinearLayoutManager(getActivity(), OrientationHelper.HORIZONTAL, false);
            adapter = new HotMallListAdapter(getActivity(), bean, 1);
            recycle.setLayoutManager(manager);
            recycle.setAdapter(adapter);
        }
    }

    //5个广告Holder
    class FiveHolder extends BaseViewHolder<NewIndexBean.RemenhuodongBean> {
        @BindView(R.id.iv_activity_1)
        ImageView ivActivity1;
        @BindView(R.id.iv_activity_2)
        ImageView ivActivity2;
        @BindView(R.id.iv_activity_3)
        ImageView ivActivity3;
        @BindView(R.id.iv_activity_4)
        ImageView ivActivity4;
        @BindView(R.id.iv_activity_5)
        ImageView ivActivity5;
        private NewIndexBean.RemenhuodongBean remenhuodongBean;

        public FiveHolder(View itemView) {
            super(itemView);
        }

        @OnClick({R.id.iv_activity_1, R.id.iv_activity_2, R.id.iv_activity_3, R.id.iv_activity_4, R.id.iv_activity_5})
        public void onViewClicked(View view) {
            switch (view.getId()) {
                case R.id.iv_activity_1:
                    JumpUtil.judgeJump(getActivity(), remenhuodongBean.getRmhd1().getAdid(), remenhuodongBean.getRmhd1().getSrc(), SpecialRecommendedActivity.class, "#ffffff", remenhuodongBean.getRmhd1().getTitle(), 1);
                    break;
                case R.id.iv_activity_2:
                    JumpUtil.judgeJump(getActivity(), remenhuodongBean.getRmhd2().getAdid(), remenhuodongBean.getRmhd2().getSrc(), SpecialRecommendedActivity.class, "#FFA9C1", remenhuodongBean.getRmhd2().getTitle(), 2);
                    break;
                case R.id.iv_activity_3:
                    JumpUtil.judgeJump(getActivity(), remenhuodongBean.getRmhd3().getAdid(), remenhuodongBean.getRmhd3().getSrc(), SpecialRecommendedActivity.class, "#ffffff", remenhuodongBean.getRmhd3().getTitle(), 3);
                    break;
                case R.id.iv_activity_4:
                    JumpUtil.judgeJump(getActivity(), remenhuodongBean.getRmhd4().getAdid(), remenhuodongBean.getRmhd4().getSrc(), SpecialRecommendedActivity.class, "#ffffff", remenhuodongBean.getRmhd4().getTitle(), 4);
                    break;
                case R.id.iv_activity_5:
                    JumpUtil.judgeJump(getActivity(), remenhuodongBean.getRmhd5().getAdid(), remenhuodongBean.getRmhd5().getSrc(), SpecialRecommendedActivity.class, "#ffffff", remenhuodongBean.getRmhd5().getTitle(), 5);
                    break;

            }
        }

        @Override
        protected void bindView(final NewIndexBean.RemenhuodongBean remenhuodongBean) {
            this.remenhuodongBean = remenhuodongBean;
            GlideLoad.GlideLoadImg(getActivity(), remenhuodongBean.getRmhd1().getWapimg(), ivActivity1);
            GlideLoad.GlideLoadImg(getActivity(), remenhuodongBean.getRmhd2().getWapimg(), ivActivity2);
            GlideLoad.GlideLoadImg(getActivity(), remenhuodongBean.getRmhd3().getWapimg(), ivActivity3);
            GlideLoad.GlideLoadImg(getActivity(), remenhuodongBean.getRmhd4().getWapimg(), ivActivity4);
            GlideLoad.GlideLoadImg(getActivity(), remenhuodongBean.getRmhd5().getWapimg(), ivActivity5);
        }
    }

    //猜你喜欢Holder
    class GuessULike extends BaseViewHolder<NewIndexBean.YoulikeBean> {
        @BindView(R.id.iv_head_img)
        ImageView ivHeadImg;
        @BindView(R.id.tv_mall_name)
        TextView tvMallName;
        @BindView(R.id.tv_mall_sign)
        TextView tvMallSign;
        @BindView(R.id.bt_care)
        Button btCare;
        @BindView(R.id.iv_img_1)
        ImageView ivImg1;
        @BindView(R.id.iv_img_2)
        ImageView ivImg2;
        @BindView(R.id.iv_img_3)
        ImageView ivImg3;
        @BindView(R.id.tv_img_more)
        TextView tvImgMore;
        @BindView(R.id.ll_much_img)
        LinearLayout llMuchImg;
        @BindView(R.id.tv_goods_name)
        TextView tvGoodsName;
        @BindView(R.id.tv_goods_price)
        TextView tvGoodsPrice;
        @BindView(R.id.tv_goods_contruduction)
        TextView tvGoodsContruduction;
        @BindView(R.id.tv_see_count)
        TextView tvSeeCount;
        @BindView(R.id.tv_care_count)
        TextView tvCareCount;
        @BindView(R.id.tv_pingjia_count)
        TextView tvPingjiaCount;
        @BindView(R.id.iv_video)
        JCVideoPlayerStandard ivVideo;
        @BindView(R.id.video_icon)
        ImageView videoIcon;

        private String type;
        private int caseid;
        private int offoer_id;
        private List<String> url;
        private int shop_id;
        private boolean isCare;
        private String video_type;
        private String video_url;
        private String video_name;

        public GuessULike(View itemView) {
            super(itemView);
            itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Intent intent = null;
                    switch (type) {
                        case "1":
                            intent = new Intent(getActivity(), NewExampleDetailsActivity.class);
                            intent.putExtra("caseid", caseid);
                            break;
                        case "2":
                            FullScreenUtil.showFullScreenDialog(getActivity(),0,url);
                            break;
                        case "3":
                            if (!video_type.equals("h5")) {
                                WebViewVideoActivity.startAction(getActivity(), video_url);
                            } else {
                                JCFullScreenActivity.startActivity(getActivity(),
                                        video_url,
                                        JCVideoPlayerStandard.class, video_name
                                );
                            }
                            break;
                        case "4":
                            intent = new Intent(getActivity(), NewBaijiaDetailsActivity.class);
                            intent.putExtra("offoer_id", offoer_id);
                            break;
                    }
                    if (intent != null)
                        getActivity().startActivity(intent);
                }
            });
        }

        @Override
        protected void bindView(NewIndexBean.YoulikeBean youlikeBean) {
            shop_id = youlikeBean.getUserid();
            ivHeadImg.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Intent intent = new Intent(getActivity(), NewMallDetailsActivity.class);
                    intent.putExtra("shop_id", shop_id);
                    getActivity().startActivity(intent);
                }
            });
            tvMallName.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Intent intent = new Intent(getActivity(), NewMallDetailsActivity.class);
                    intent.putExtra("shop_id", shop_id);
                    getActivity().startActivity(intent);
                }
            });

            if (youlikeBean.getFollow() == 1) {
                isCare = true;
                btCare.setBackgroundResource(R.mipmap.icon_close_care);
            } else {
                isCare = false;
                btCare.setBackgroundResource(R.mipmap.icon_add_care);
            }
            btCare.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    if (isCare) {
                        cancelCare(btCare);
                    } else {
                        careShop(btCare);
                    }
                }
            });
            GlideLoad.GlideLoadCircle(youlikeBean.getHead(), ivHeadImg);
            tvMallName.setText(youlikeBean.getNickname());
            tvMallSign.setText(youlikeBean.getOccupationid());
            tvSeeCount.setText("" + youlikeBean.getClicked());
            tvCareCount.setText("" + youlikeBean.getFollowed());
            type = youlikeBean.getTypee();
            if (type.equals("2")) {//图册
                url = new ArrayList<>();
                for (int i = 0; i < youlikeBean.getPhotourl().size(); i++) {
                    url.add(youlikeBean.getPhotourl().get(i).getPhoto());
                }
                videoIcon.setVisibility(View.GONE);
                tvGoodsContruduction.setVisibility(View.GONE);
                ivImg1.setVisibility(View.VISIBLE);
                ivVideo.setVisibility(View.GONE);
                tvGoodsPrice.setVisibility(View.GONE);
                tvPingjiaCount.setVisibility(View.GONE);
                tvGoodsName.setText(youlikeBean.getName());
                if (youlikeBean.getPhotourl() != null) {
                    if (youlikeBean.getPhotourl().size() >= 3) {
                        GlideLoad.GlideLoadImg2(youlikeBean.getPhotourl().get(0).getPhoto(), ivImg1);
                        llMuchImg.setVisibility(View.VISIBLE);
                        tvImgMore.setVisibility(View.VISIBLE);
                        ivImg2.setVisibility(View.VISIBLE);
                        ivImg3.setVisibility(View.VISIBLE);
                        tvImgMore.setText("+" + youlikeBean.getPhotourl().size());
                        GlideLoad.GlideLoadImg2(youlikeBean.getPhotourl().get(1).getPhoto(), ivImg2);
                        GlideLoad.GlideLoadImg2(youlikeBean.getPhotourl().get(2).getPhoto(), ivImg3);
                    } else if (youlikeBean.getPhotourl().size() == 2) {
                        GlideLoad.GlideLoadImg2(youlikeBean.getPhotourl().get(0).getPhoto(), ivImg1);
                        llMuchImg.setVisibility(View.GONE);
                        tvImgMore.setVisibility(View.GONE);
                        ivImg2.setVisibility(View.VISIBLE);
                        ivImg3.setVisibility(View.INVISIBLE);
                        tvImgMore.setText("+" + youlikeBean.getPhotourl().size());
                        GlideLoad.GlideLoadImg2(youlikeBean.getPhotourl().get(1).getPhoto(), ivImg2);
                    } else if (youlikeBean.getPhotourl().size() == 1) {
                        GlideLoad.GlideLoadImg2(youlikeBean.getPhotourl().get(0).getPhoto(), ivImg1);
                        llMuchImg.setVisibility(View.GONE);
                        tvImgMore.setVisibility(View.GONE);
                    }
                }
            } else if (type.equals("3")) {//视频
                tvGoodsName.setText(youlikeBean.getTitle());
                videoIcon.setVisibility(View.VISIBLE);
                tvGoodsPrice.setVisibility(View.GONE);
                tvGoodsContruduction.setVisibility(View.GONE);
                tvImgMore.setVisibility(View.GONE);
                llMuchImg.setVisibility(View.GONE);
                //ivImg1.setVisibility(View.GONE);
                ivImg1.setVisibility(View.VISIBLE);
                ivImg2.setVisibility(View.GONE);
                ivImg3.setVisibility(View.GONE);
                ivVideo.setVisibility(View.GONE);
                tvPingjiaCount.setVisibility(View.GONE);
                video_type = youlikeBean.getVideo_type();
                video_url = youlikeBean.getVideo_url();
                video_name = youlikeBean.getTitle();
                //ivVideo.setUp(video_url, "");
                //GlideLoad.GlideLoadImg2(youlikeBean.getCover(), ivVideo.thumbImageView);
                GlideLoad.GlideLoadImg2(youlikeBean.getCover(), ivImg1);
            } else if (type.equals("1")) {//案例
                caseid = youlikeBean.getId();
                tvGoodsName.setText(youlikeBean.getTitle());
                videoIcon.setVisibility(View.GONE);
                tvGoodsContruduction.setVisibility(View.VISIBLE);
                tvImgMore.setVisibility(View.GONE);
                llMuchImg.setVisibility(View.GONE);
                ivImg1.setVisibility(View.VISIBLE);
                ivImg2.setVisibility(View.GONE);
                ivImg3.setVisibility(View.GONE);
                ivVideo.setVisibility(View.GONE);
                tvPingjiaCount.setVisibility(View.VISIBLE);
                tvGoodsPrice.setVisibility(View.VISIBLE);
                GlideLoad.GlideLoadImg2(youlikeBean.getWeddingcover(), ivImg1);
                tvPingjiaCount.setText("" + youlikeBean.getPinluns());
                tvGoodsContruduction.setText(youlikeBean.getWeddingdescribe() + "");
                tvGoodsPrice.setText(Constans.RMB + youlikeBean.getWeddingexpenses());
            } else if (type.equals("4")) {//报价
                offoer_id = youlikeBean.getShopid();
                tvGoodsName.setText(youlikeBean.getShopname());
                videoIcon.setVisibility(View.GONE);
                tvGoodsContruduction.setVisibility(View.GONE);
                tvImgMore.setVisibility(View.GONE);
                llMuchImg.setVisibility(View.GONE);
                ivImg1.setVisibility(View.VISIBLE);
                ivImg2.setVisibility(View.GONE);
                ivImg3.setVisibility(View.GONE);
                ivVideo.setVisibility(View.GONE);
                tvPingjiaCount.setVisibility(View.GONE);
                tvGoodsPrice.setVisibility(View.VISIBLE);
                GlideLoad.GlideLoadImg2(youlikeBean.getShopimg(), ivImg1);
                tvGoodsPrice.setText(Constans.RMB + youlikeBean.getPrice());
            }

        }

        //关注商家
        private void careShop(final Button view) {
            LoadDialog.showDialog(getActivity());
            ApiManager.addSJCare(shop_id + "", new OnRequestFinish<BaseBean>() {
                @Override
                public void onFinished() {
                    LoadDialog.CancelDialog();
                }

                @Override
                public void onSuccess(BaseBean data) {
                    if (data.getCode() == 0) {
                        isCare = true;
                        view.setBackgroundResource(R.mipmap.icon_close_care);
                    }
                }

                @Override
                public void onError(Exception ex) {

                }
            });
        }

        //取消关注商家
        private void cancelCare(final Button view) {
            LoadDialog.showDialog(getActivity());
            ApiManager.delSJCare(shop_id + "", new OnRequestFinish<BaseBean>() {
                @Override
                public void onFinished() {
                    LoadDialog.CancelDialog();
                }

                @Override
                public void onSuccess(BaseBean data) {
                    if (data.getCode() == 0) {
                        isCare = false;
                        view.setBackgroundResource(R.mipmap.icon_add_care);
                    }
                }

                @Override
                public void onError(Exception ex) {

                }
            });
        }
    }

    private BaseAdapter createAdapter(NewIndexBean bean, ArrayList<IndexWeddingTypeBean> typeBean) {
        BaseAdapter baseAdapter = BaseAdapter.createBaseAdapter();
        baseAdapter
                .injectHolderDelegate(new CreateHolderDelegate<NewIndexBean>() {
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
                .injectHolderDelegate(new CreateHolderDelegate<ArrayList<IndexWeddingTypeBean>>() {
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
                .injectHolderDelegate(new CreateHolderDelegate<String>() {
                    @Override
                    protected int onSpanSize() {
                        return 60;
                    }

                    @Override
                    protected int getLayoutRes() {
                        return R.layout.new_index_wedding_thr_ad_layout;
                    }

                    @Override
                    protected BaseViewHolder onCreateHolder(View itemView) {
                        return new BaseViewHolder<String>(itemView) {
                            @Override
                            protected void bindView(String o) {
                                itemView.findViewById(R.id.rl_getcase).setOnClickListener(new View.OnClickListener() {
                                    @Override
                                    public void onClick(View view) {
                                        startActivity(new Intent(getActivity(), SearchExampleActivty.class));
                                    }
                                });
                                itemView.findViewById(R.id.rl_wedding).setOnClickListener(new View.OnClickListener() {
                                    @Override
                                    public void onClick(View view) {
                                        if (!LoginUtil.isLogin()) {
                                            LoginActivity.startAction(getActivity());
                                            return;
                                        }
                                        startActivity(new Intent(getActivity(), GetSuggestActivity.class));//免费获取方案
                                    }
                                });
                            }
                        };
                    }
                }.addData(""))
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
                .injectHolderDelegate(new TitleDelegate2().addData("常用工具"))
                .injectHolderDelegate(new CreateHolderDelegate<String>() {
                    @Override
                    protected int onSpanSize() {
                        return 60;
                    }

                    @Override
                    protected int getLayoutRes() {
                        return R.layout.new_index_wedding_tools_layout;
                    }

                    @Override
                    protected BaseViewHolder onCreateHolder(View itemView) {
                        return new BaseViewHolder<String>(itemView) {
                            @Override
                            protected void bindView(String o) {
                                itemView.findViewById(R.id.fabuxuqiu).setOnClickListener(new View.OnClickListener() {
                                    @Override
                                    public void onClick(View view) {
                                        if (!LoginUtil.isLogin()) {
                                            LoginActivity.startAction(getActivity());
                                        } else {
                                            Intent intent;
                                            intent = new Intent(getActivity(), ForNeedActivity.class);
                                            startActivity(intent);
                                        }
                                    }
                                });
                                itemView.findViewById(R.id.huangdaojiri).setOnClickListener(new View.OnClickListener() {
                                    @Override
                                    public void onClick(View view) {
                                        if (!LoginUtil.isLogin()) {
                                            LoginActivity.startAction(getActivity());
                                        } else {
                                            Intent intent;
//                                            intent = new Intent(getActivity(), GoodDayActivity.class);
//                                            startActivity(intent);
                                            intent = new Intent(getActivity(), MineDangqiActivity.class);
                                            startActivity(intent);
                                        }
                                    }
                                });
                                itemView.findViewById(R.id.dianziqingjian).setOnClickListener(new View.OnClickListener() {
                                    @Override
                                    public void onClick(View view) {
                                        if (!LoginUtil.isLogin()) {
                                            LoginActivity.startAction(getActivity());
                                        } else {
                                            Intent intent;
                                            intent = new Intent(getActivity(), NewElectronicinvitationActivity.class);
                                            //intent = new Intent(getActivity(), NewCreateElectronicinvitationActivity.class);
                                            //intent = new Intent(getActivity(), QingJianActivity.class);
                                            startActivity(intent);
                                        }
                                    }
                                });
                                itemView.findViewById(R.id.richenganpai).setOnClickListener(new View.OnClickListener() {
                                    @Override
                                    public void onClick(View view) {
                                        if (!LoginUtil.isLogin()) {
                                            LoginActivity.startAction(getActivity());
                                        } else {
                                            Intent intent;
//                                            intent = new Intent(getActivity(), MineJizhangzhushouActivity.class);
//                                            startActivity(intent);
                                            intent = new Intent(getActivity(), HistoryActivity.class);
                                            startActivity(intent);
                                        }
                                    }
                                });
                                itemView.findViewById(R.id.fayangao).setOnClickListener(new View.OnClickListener() {
                                    @Override
                                    public void onClick(View view) {
                                        if (!LoginUtil.isLogin()) {
                                            LoginActivity.startAction(getActivity());
                                        } else {
//                                            Intent intent;
//                                            intent = new Intent(getActivity(), FayanListActivity.class);
//                                            startActivity(intent);

                                            Intent   intent = new Intent(getActivity(), MineChakanNeed2Activity.class);
                                            startActivity(intent);
                                        }
                                    }
                                });
                            }
                        };
                    }
                }.addData(""))
                //华为上架隐藏
                /*.injectHolderDelegate(new TitleDelegate2().addData("特别推荐"))
                .injectHolderDelegate(new CreateHolderDelegate<NewIndexBean>() {
                    @Override
                    protected int onSpanSize() {
                        return 60;
                    }

                    @Override
                    protected int getLayoutRes() {
                        return R.layout.new_wedding_hot_layout;
                    }

                    @Override
                    protected BaseViewHolder onCreateHolder(View itemView) {
                        return new HotShopHolder(itemView);
                    }
                }.cleanAfterAddData(bean))*/
                .injectHolderDelegate(new TitleDelegate2().addData("热门活动"))
                .injectHolderDelegate(new CreateHolderDelegate<NewIndexBean>() {
                    @Override
                    protected int onSpanSize() {
                        return 60;
                    }

                    @Override
                    protected int getLayoutRes() {
                        return R.layout.new_wedding_hot_layout;
                    }

                    @Override
                    protected BaseViewHolder onCreateHolder(View itemView) {
                        return new HotTeamShopHolder(itemView);
                    }
                }.cleanAfterAddData(bean))
                .injectHolderDelegate(new CreateHolderDelegate<NewIndexBean.XiaoguanggaoyiBean>() {
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
                .injectHolderDelegate(new TitleDelegate().addData(R.mipmap.icon_hot_activities))
                .injectHolderDelegate(new CreateHolderDelegate<NewIndexBean.RemenhuodongBean>() {
                    @Override
                    protected int onSpanSize() {
                        return 60;
                    }

                    @Override
                    protected int getLayoutRes() {
                        return R.layout.new_index_wedding_five_layout;
                    }

                    @Override
                    protected BaseViewHolder onCreateHolder(View itemView) {
                        return new FiveHolder(itemView);
                    }
                }.cleanAfterAddData(bean.getRemenhuodong()))
//                .injectHolderDelegate(new CreateHolderDelegate<String>() {
//                    @Override
//                    protected int onSpanSize() {
//                        return 60;
//                    }
//
//                    @Override
//                    protected int getLayoutRes() {
//                        return R.layout.item_dev;
//                    }
//
//                    @Override
//                    protected BaseViewHolder onCreateHolder(View itemView) {
//                        return new BaseViewHolder<String>(itemView) {
//                            @Override
//                            protected void bindView(String o) {
//
//                            }
//                        };
//                    }
//                }.addData(""))//分割线View
                .injectHolderDelegate(new TitleDelegate().addData(R.mipmap.icon_guess_shangjia))
                .injectHolderDelegate(new CreateHolderDelegate<NewIndexBean.YoulikeBean>() {
                    @Override
                    protected int onSpanSize() {
                        return 60;
                    }

                    @Override
                    protected int getLayoutRes() {
                        return R.layout.new_index_wedding_guess_layout;
                    }

                    @Override
                    protected BaseViewHolder onCreateHolder(View itemView) {
                        return new GuessULike(itemView);
                    }
                }.cleanAfterAddAllData(bean.getYoulike()))
        ;
        baseAdapter.setLayoutManager(recycle);
        return baseAdapter;
    }

    private void refreshView() {
        if (isInitView) {
            triggerSilentRefresh();
        } else {
            initView();
        }
    }

    private void triggerSilentRefresh() {
        if (isRefreshing) {
            return;
        }
        if (SystemClock.elapsedRealtime() - lastAutoRefreshAt < 1500) {
            return;
        }
        isRefreshing = true;
        lastAutoRefreshAt = SystemClock.elapsedRealtime();
        getSecData();
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

}
