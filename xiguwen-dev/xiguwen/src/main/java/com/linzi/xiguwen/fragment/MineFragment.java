package com.linzi.xiguwen.fragment;

import android.content.Intent;
import android.os.Bundle;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.core.view.ViewCompat;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.MineLableAdapter;
import com.linzi.xiguwen.bean.MineLableBean;
import com.linzi.xiguwen.bean.UserInfoBean;
import com.linzi.xiguwen.net.OnRequestFinish;
import com.linzi.xiguwen.net.base.BaseBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.ui.AboutUsActivity;
import com.linzi.xiguwen.ui.BYVipActivity;
import com.linzi.xiguwen.ui.ChargeActivity;
import com.linzi.xiguwen.ui.ChooseRZTypeActivity;
import com.linzi.xiguwen.ui.DianPuMsgActivity;
import com.linzi.xiguwen.ui.DianPuRenZhengActivity;
import com.linzi.xiguwen.ui.FayanListActivity;
import com.linzi.xiguwen.ui.ForNeedActivity;
import com.linzi.xiguwen.ui.GoodDayActivity;
import com.linzi.xiguwen.ui.HunYinDengjiChu2Activity;
import com.linzi.xiguwen.ui.IntegralMallActivity;
import com.linzi.xiguwen.ui.LoginActivity;
import com.linzi.xiguwen.ui.MineBYXYActivity;
import com.linzi.xiguwen.ui.MineCityActivity;
import com.linzi.xiguwen.ui.MineDangqiActivity;
import com.linzi.xiguwen.ui.MineDikouquanActivity;
import com.linzi.xiguwen.ui.MineFansActivity;
import com.linzi.xiguwen.ui.MineHistoryActivity;
import com.linzi.xiguwen.ui.MineHunLiLiuChengActivity;
import com.linzi.xiguwen.ui.MineHunLiNewsActivity;
import com.linzi.xiguwen.ui.MineInvatedActivity;
import com.linzi.xiguwen.ui.MineInvatedShopActivity;
import com.linzi.xiguwen.ui.MineJizhangzhushouActivity;
import com.linzi.xiguwen.ui.MineListActivity;
import com.linzi.xiguwen.ui.MineNeedActivity;
import com.linzi.xiguwen.ui.MineTeamActivity;
import com.linzi.xiguwen.ui.MineTuijianActivity;
import com.linzi.xiguwen.ui.MineYuEActivity;
import com.linzi.xiguwen.ui.NewElectronicinvitationActivity;
import com.linzi.xiguwen.ui.NewHunQinOrderActivity;
import com.linzi.xiguwen.ui.NewMallDetailsActivity;
import com.linzi.xiguwen.ui.NewShopMallDetailsActivity;
import com.linzi.xiguwen.ui.RegisterStepActivity;
import com.linzi.xiguwen.ui.RichengActivity;
import com.linzi.xiguwen.ui.SettingActivity;
import com.linzi.xiguwen.ui.TeamCenterActivity;
import com.linzi.xiguwen.ui.WenzhangDetailsActivity;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.LoginUtil;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.SPUtil;
import com.linzi.xiguwen.utils.StatusBarUtil;
import com.linzi.xiguwen.utils.eventbus.Event;
import com.linzi.xiguwen.utils.eventbus.EventBusUtil;
import com.linzi.xiguwen.utils.eventbus.EventCode;
import com.linzi.xiguwen.view.CusScrollView;
import com.linzi.xiguwen.view.MyRefreshHeader;
import com.scwang.smartrefresh.layout.SmartRefreshLayout;
import com.scwang.smartrefresh.layout.api.RefreshLayout;
import com.scwang.smartrefresh.layout.listener.OnRefreshListener;

import org.greenrobot.eventbus.Subscribe;
import org.greenrobot.eventbus.ThreadMode;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

/**
 * Created by jiang on 2018/2/1.
 */

public class MineFragment extends Fragment {
    @BindView(R.id.iv_head_img)
    ImageView ivHeadImg;
    @BindView(R.id.ll_head)
    LinearLayout llHead;
    @BindView(R.id.tv_user_name)
    TextView tvUserName;
    @BindView(R.id.tv_fans_num)
    TextView tvFansNum;
    @BindView(R.id.tv_care_num)
    TextView tvCareNum;
    @BindView(R.id.tv_yue)
    TextView tvYue;
    @BindView(R.id.tv_zekou)
    TextView tvZekou;
    @BindView(R.id.wedding_order_recycle)
    RecyclerView orderRecycle;
    @BindView(R.id.mall_order_recycle)
    RecyclerView mallorderRecycle;
    @BindView(R.id.wedding_jiedan_recycle)
    RecyclerView weddingJiedanRecycle;
    @BindView(R.id.jiedan_recycle)
    RecyclerView jiedanRecycle;
    @BindView(R.id.tools_recycle)
    RecyclerView toolsRecycle;
    @BindView(R.id.manager_recycle)
    RecyclerView managerRecycle;
    @BindView(R.id.user_tools_recycle)
    RecyclerView userToolsRecycle;
    @BindView(R.id.ll_boyixueyuan)
    LinearLayout llBoyixueyuan;
    @BindView(R.id.ll_mall_vip)
    LinearLayout llMallVip;
    @BindView(R.id.ll_user_vip)
    LinearLayout llUserVip;
    @BindView(R.id.ll_mall_charge)
    LinearLayout llMallCharge;
    //@BindView(R.id.ll_invated_fri)
    //LinearLayout llInvatedFri;
    @BindView(R.id.ll_daili_zhaomu)
    LinearLayout llDailiZhaomu;
    @BindView(R.id.ll_show_fri_hunli)
    LinearLayout llShowFriHunli;
    @BindView(R.id.ll_about_us)
    LinearLayout llAboutUs;
    @BindView(R.id.scrollView)
    CusScrollView scrollView;
    @BindView(R.id.ll_fans)
    LinearLayout llFans;
    @BindView(R.id.ll_care)
    LinearLayout llCare;
    @BindView(R.id.ll_yue)
    LinearLayout llYue;
    @BindView(R.id.ll_zhekou)
    LinearLayout llZhekou;


    List<MineLableBean> order_list, mall_order_list, wedding_jiedan_list, jiedan_list, other_tools, dianpu_manager, user_tools;
    GridLayoutManager manager1, mallmanager, weddingmanager, manager2, manager3, manager4, manager5;
    MineLableAdapter weddingAdapter, mallAdapter, weddingjiedanAdapter, mAdapter2, mAdapter3, mAdapter4, mAdapter5;

    @BindView(R.id.tv_team)
    TextView tvTeam;
    @BindView(R.id.ll_wedding_shop_jiedan)
    LinearLayout llWeddingShopJiedan;
    @BindView(R.id.ll_mall_shop_jiedan)
    LinearLayout llMallShopJiedan;
    @BindView(R.id.ll_shop_manage)
    LinearLayout llShopManage;
    @BindView(R.id.ll_invated_shop)
    LinearLayout llInvatedShop;
    @BindView(R.id.ll_post_shop)
    LinearLayout llPostShop;
    @BindView(R.id.refresh_layout)
    SmartRefreshLayout refreshLayout;
    @BindView(R.id.ll_bar)
    LinearLayout llBar;

    private String price = "0";
    private int user_type;

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = LayoutInflater.from(getActivity()).inflate(R.layout.fragment_mine_layout, null);
        ButterKnife.bind(this, view);
        EventBusUtil.register(this);

        //获得状态栏高度
        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, StatusBarUtil.getStatusBarHeight(getActivity()));
        llBar.setLayoutParams(params);
        ViewCompat.setAlpha(llBar, 0);

        setData();
        getData();
        refreshLayout.setEnableLoadMore(false);
        refreshLayout.setRefreshHeader(new MyRefreshHeader(getActivity()));
        refreshLayout.setOnRefreshListener(new OnRefreshListener() {
            @Override
            public void onRefresh(@NonNull RefreshLayout refreshLayout) {
                getData();
                refreshLayout.finishRefresh();
            }
        });
        return view;
    }

    /**
     * 根据用户权限控制VIEW的显示
     */
    private void ctrlViewByUserRule() {
        switch (user_type) {//1是商场商家，2是婚庆商家。3是用户
            case 1:
                llMallVip.setVisibility(View.VISIBLE);
                llUserVip.setVisibility(View.GONE);
                llMallShopJiedan.setVisibility(View.VISIBLE);
                llWeddingShopJiedan.setVisibility(View.GONE);
                llShopManage.setVisibility(View.VISIBLE);
                llPostShop.setVisibility(View.GONE);
                setDianpuManagerMall();
                setToolsMall();
                break;

            case 2:
                llMallVip.setVisibility(View.VISIBLE);
                llUserVip.setVisibility(View.GONE);
                llMallShopJiedan.setVisibility(View.GONE);
                llWeddingShopJiedan.setVisibility(View.VISIBLE);
                llShopManage.setVisibility(View.VISIBLE);
                llPostShop.setVisibility(View.GONE);
                setDianpuManagerWedding();
                setToolsWedding();
                break;

            case 3:
                llUserVip.setVisibility(View.VISIBLE);
                llMallVip.setVisibility(View.GONE);
                llMallShopJiedan.setVisibility(View.GONE);
                llWeddingShopJiedan.setVisibility(View.GONE);
                llShopManage.setVisibility(View.GONE);
                llPostShop.setVisibility(View.VISIBLE);
                setTools();
                break;
        }
    }


    /***
     * 初始化相关布局管理器
     * 并设置初始布局样式
     */
    private void setData() {
        manager1 = new GridLayoutManager(getActivity(), 5) {
            @Override
            public boolean canScrollVertically() {
                return false;
            }
        };
        mallmanager = new GridLayoutManager(getActivity(), 5) {
            @Override
            public boolean canScrollVertically() {
                return false;
            }
        };
        weddingmanager = new GridLayoutManager(getActivity(), 5) {
            @Override
            public boolean canScrollVertically() {
                return false;
            }
        };
        manager2 = new GridLayoutManager(getActivity(), 5) {
            @Override
            public boolean canScrollVertically() {
                return false;
            }
        };
        manager3 = new GridLayoutManager(getActivity(), 4) {
            @Override
            public boolean canScrollVertically() {
                return false;
            }
        };
        manager4 = new GridLayoutManager(getActivity(), 4) {
            @Override
            public boolean canScrollVertically() {
                return false;
            }
        };
        manager5 = new GridLayoutManager(getActivity(), 4) {
            @Override
            public boolean canScrollVertically() {
                return false;
            }
        };
        orderRecycle.setLayoutManager(manager1);
        mallorderRecycle.setLayoutManager(mallmanager);
        weddingJiedanRecycle.setLayoutManager(weddingmanager);
        jiedanRecycle.setLayoutManager(manager2);
        toolsRecycle.setLayoutManager(manager3);
        managerRecycle.setLayoutManager(manager4);
        userToolsRecycle.setLayoutManager(manager5);

        order_list = new ArrayList<>();
        mall_order_list = new ArrayList<>();
        wedding_jiedan_list = new ArrayList<>();
        jiedan_list = new ArrayList<>();
        dianpu_manager = new ArrayList<>();
        other_tools = new ArrayList<>();
        user_tools = new ArrayList<>();

        //初始化页面布局
        weddingAdapter = new MineLableAdapter(getActivity(), new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int postion) {
                Intent intent = new Intent(getActivity(), NewHunQinOrderActivity.class);
                intent.putExtra("index", postion);
                intent.putExtra("title", "婚庆订单");
                intent.putExtra("intentType", 0);
                startActivity(intent);
            }
        });
        orderRecycle.setAdapter(weddingAdapter);

        mallAdapter = new MineLableAdapter(getActivity(), new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int postion) {
                Intent intent = new Intent(getActivity(), NewHunQinOrderActivity.class);
                intent.putExtra("index", postion);
                intent.putExtra("title", "商城订单");
                intent.putExtra("intentType", 1);
                startActivity(intent);
            }
        });
        mallorderRecycle.setAdapter(mallAdapter);

        weddingjiedanAdapter = new MineLableAdapter(getActivity(), new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int postion) {
//                Intent intent = new Intent(getActivity(), HunQinJieDanActivity.class);
//                startActivity(intent);
                if (!LoginUtil.isLogin()) {
                    LoginActivity.startAction(getActivity());
                    return;
                }
                Intent intent = new Intent(getActivity(), NewHunQinOrderActivity.class);
                intent.putExtra("index", postion);
                intent.putExtra("title", "婚庆接单");
                intent.putExtra("intentType", 2);
                startActivity(intent);
            }
        });
        weddingJiedanRecycle.setAdapter(weddingjiedanAdapter);

        mAdapter2 = new MineLableAdapter(getActivity(), new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int postion) {
//                Intent intent = new Intent(getActivity(), ShangchengOrderActivity.class);
//                startActivity(intent);
                if (!LoginUtil.isLogin()) {
                    LoginActivity.startAction(getActivity());
                    return;
                }
                Intent intent = new Intent(getActivity(), NewHunQinOrderActivity.class);
                intent.putExtra("index", postion);
                intent.putExtra("title", "商城接单");
                intent.putExtra("intentType", 3);
                startActivity(intent);
            }
        });
        jiedanRecycle.setAdapter(mAdapter2);
        mAdapter3 = new MineLableAdapter(getActivity(), new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int postion) {
                if (!LoginUtil.isLogin()) {
                    LoginActivity.startAction(getActivity());
                    return;
                }
                Intent intent;
                switch (other_tools.get(postion).getId()) {
                    case 0:
                        intent = new Intent(getActivity(), ChooseRZTypeActivity.class);
                        startActivity(intent);
                        break;
                    case 1:
                        intent = new Intent(getActivity(), MineNeedActivity.class);
                        startActivity(intent);
                        break;
                    case 2:
                        if (associationid == 0) {
                            intent = new Intent(getActivity(), MineTeamActivity.class);
                            startActivity(intent);
                        } else {
                            intent = new Intent(getActivity(), TeamCenterActivity.class);
                            startActivity(intent);
                        }

                        break;
                    case 3:
                        intent = new Intent(getActivity(), MineInvatedActivity.class);
                        startActivity(intent);
                        break;
                    case 4:
                        intent = new Intent(getActivity(), MineHunLiNewsActivity.class);
                        startActivity(intent);
//                        intent = new Intent(getActivity(), MinePingjiaActivity.class);
//                        startActivity(intent);
                        break;
                    case 5:
                        intent = new Intent(getActivity(), MineHistoryActivity.class);
                        startActivity(intent);
                        break;
                    case 6:
                        intent = new Intent(getActivity(), MineHunLiNewsActivity.class);
                        startActivity(intent);
                        break;
                    case 7:
                        intent = new Intent(getActivity(), IntegralMallActivity.class);
                        startActivity(intent);
//                        ArrayList<Integer> list = new ArrayList<>();
//                        list.add(1);
//                        list.add(2);
//                        list.add(3);
//                        list.add(4);
//                        list.add(5);
//                        list.add(6);
//                        list.add(7);
//                        SignInBean signInBean = new SignInBean();
//                        signInBean.setHuodejifen(3);
//                        signInBean.setLianxutianshu(3);
//                        signInBean.setJifen(list);
//                        new SignInDialog(getActivity(), signInBean).show();
                        break;
                    case 8:
                        getHouDongUrl();
                        break;
                }
            }
        });
        toolsRecycle.setAdapter(mAdapter3);

        mAdapter4 = new MineLableAdapter(getActivity(), new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int postion) {
                if (!LoginUtil.isLogin()) {
                    LoginActivity.startAction(getActivity());
                    return;
                }
                Intent intent;
                switch (dianpu_manager.get(postion).getId()) {
                    case 0:
                        intent = new Intent(getActivity(), DianPuMsgActivity.class);
                        startActivity(intent);
                        break;
                    case 1:
                        intent = new Intent(getActivity(), DianPuRenZhengActivity.class);
                        startActivity(intent);
                        break;
                    case 2:
                        intent = new Intent(getActivity(), MineDangqiActivity.class);
                        startActivity(intent);
                        break;
                    case 3:
//                        intent=new Intent(getActivity(),MineBaojiarActivity.class);
//                        startActivity(intent);
                        MineListActivity.startActivity(getActivity(), MineListActivity.TYPE_BAOJIA);
                        break;
                    case 4:
                        MineListActivity.startActivity(getActivity(), MineListActivity.TYPE_COMMODITY);
                        break;
                    case 5:
//                        intent=new Intent(getActivity(),MineTuCeActivity.class);
//                        startActivity(intent);
                        MineListActivity.startActivity(getActivity(), MineListActivity.TYPE_TUCE);
                        break;
                    case 6:
//                        intent=new Intent(getActivity(),MineVadioActivity.class);
//                        startActivity(intent);
                        MineListActivity.startActivity(getActivity(), MineListActivity.TYPE_SHIPING);
                        break;
                    case 7:
//                        intent=new Intent(getActivity(),MineExampleActivity.class);
//                        startActivity(intent);
                        MineListActivity.startActivity(getActivity(), MineListActivity.TYPE_ANLI);
                        break;
                    case 8:
                        intent = new Intent(getActivity(), MineCityActivity.class);
                        startActivity(intent);
                        break;
                    case 9:
                        intent = new Intent(getActivity(), MineTuijianActivity.class);
                        startActivity(intent);
                        break;
                    case 10:
//                        intent = new Intent(getActivity(), MineChakanNeed2Activity.class);
//                        startActivity(intent);
                        intent=new Intent(getActivity(),FayanListActivity.class);
                        startActivity(intent);
                        break;
//                    case 11:
//                        intent = new Intent(getActivity(), MineTuiGuangActivity.class);
//                        startActivity(intent);
//                        break;
                    case 12:
                        if ((int) SPUtil.get("usertype", SPUtil.Type.INT) == 1) {
                            Intent intent1 = new Intent(getActivity(), NewShopMallDetailsActivity.class);
                            intent1.putExtra("shop_id", shop_id);
                            getActivity().startActivity(intent1);
                        } else if ((int) SPUtil.get("usertype", SPUtil.Type.INT) == 2) {
                            Intent intent1 = new Intent(getActivity(), NewMallDetailsActivity.class);
                            intent1.putExtra("shop_id", shop_id);
                            getActivity().startActivity(intent1);
                        }
                        break;
                }
            }
        });
        managerRecycle.setAdapter(mAdapter4);

        mAdapter5 = new MineLableAdapter(getActivity(), new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int postion) {
                if (!LoginUtil.isLogin()) {
                    LoginActivity.startAction(getActivity());
                    return;
                }
                Intent intent;
                switch (postion) {
                    case 0:
                        intent = new Intent(getActivity(), ForNeedActivity.class);
                        startActivity(intent);
                        break;
                    case 1:
                        intent = new Intent(getActivity(), GoodDayActivity.class);
                        startActivity(intent);
                        break;
                    case 2:
                        intent = new Intent(getActivity(), NewElectronicinvitationActivity.class);
                        startActivity(intent);
                        break;
                    case 3:
                        intent = new Intent(getActivity(), RichengActivity.class);
                        startActivity(intent);
                        break;
                    case 4:
                        intent = new Intent(getActivity(), FayanListActivity.class);
                        startActivity(intent);
                        break;
                    case 5:
                        intent = new Intent(getActivity(), MineHunLiLiuChengActivity.class);
                        startActivity(intent);
                        break;
                    case 6:
                        intent = new Intent(getActivity(), MineJizhangzhushouActivity.class);
                        startActivity(intent);
                        break;
                    case 7:
                        intent = new Intent(getActivity(), HunYinDengjiChu2Activity.class);
                        startActivity(intent);
                        break;
                }
            }
        });
        userToolsRecycle.setAdapter(mAdapter5);

        setOrder();
        setOrder2();
        setJiedan();
        setJiedan2();
        setTools();
        setDianpuManager();
        setUserTools();

        //各类点击事件相关

        ivHeadImg.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (!LoginUtil.isLogin()) {
                    LoginActivity.startAction(getActivity());
                    return;
                }
                Intent intent = new Intent(getActivity(), SettingActivity.class);
                startActivity(intent);
            }
        });

        llFans.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (!LoginUtil.isLogin()) {
                    LoginActivity.startAction(getActivity());
                    return;
                }
                Intent intent = new Intent(getActivity(), MineFansActivity.class);
                startActivity(intent);
            }
        });

        llCare.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (!LoginUtil.isLogin()) {
                    LoginActivity.startAction(getActivity());
                    return;
                }
                Intent intent = new Intent(getActivity(), MineCaresActivity.class);
                startActivity(intent);
            }
        });

        llYue.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (!LoginUtil.isLogin()) {
                    LoginActivity.startAction(getActivity());
                    return;
                }
                Intent intent = new Intent(getActivity(), MineYuEActivity.class);
                startActivity(intent);
            }
        });

        llZhekou.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (!LoginUtil.isLogin()) {
                    LoginActivity.startAction(getActivity());
                    return;
                }
//                Intent intent = new Intent(getActivity(), MineDikouquanActivity.class);
//                startActivity(intent);
                MineDikouquanActivity.startAction(getActivity(), price);
            }
        });

        llBoyixueyuan.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (!LoginUtil.isLogin()) {
                    LoginActivity.startAction(getActivity());
                    return;
                }
                Intent intent = new Intent(getActivity(), MineBYXYActivity.class);
                startActivity(intent);
            }
        });
        llMallVip.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (!LoginUtil.isLogin()) {
                    LoginActivity.startAction(getActivity());
                    return;
                }
                Intent intent = new Intent(getActivity(), BYVipActivity.class);
                intent.putExtra("type", 0);
                startActivity(intent);
            }
        });
        llUserVip.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (!LoginUtil.isLogin()) {
                    LoginActivity.startAction(getActivity());
                    return;
                }
                Intent intent = new Intent(getActivity(), BYVipActivity.class);
                intent.putExtra("type", 1);
                startActivity(intent);
            }
        });
        /*llInvatedFri.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (!LoginUtil.isLogin()) {
                    LoginActivity.startAction(getActivity());
                    return;
                }
                Intent intent = new Intent(getActivity(), MineInvatedFriActivity.class);
                startActivity(intent);
            }
        });*/
        llAboutUs.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
//                if (!LoginUtil.isLogin()) {
//                    LoginActivity.startAction(getActivity());
//                    return;
//                }
                Intent intent = new Intent(getActivity(), AboutUsActivity.class);
                startActivity(intent);
                //startActivity(new Intent(getActivity(), New_Test_Activity.class));
            }
        });
    }

    /**
     * 婚庆订单
     */
    private void setOrder() {
        order_list.clear();

        order_list.add(new MineLableBean().setId(0).setTitle("全部订单").setUrl(R.mipmap.icon_mine_order_all));
        order_list.add(new MineLableBean().setId(1).setTitle("待付款").setUrl(R.mipmap.icon_mine_order_daifukuan));
        order_list.add(new MineLableBean().setId(2).setTitle("待接单").setUrl(R.mipmap.icon_mine_order_daijiedan));
        order_list.add(new MineLableBean().setId(3).setTitle("待服务").setUrl(R.mipmap.icon_mine_order_daifuwu));
        order_list.add(new MineLableBean().setId(4).setTitle("待评价").setUrl(R.mipmap.icon_mine_order_daipingjia));

        weddingAdapter.setData(order_list);
    }

    /**
     * 商城订单
     */
    private void setOrder2() {
        mall_order_list.clear();

        mall_order_list.add(new MineLableBean().setId(0).setTitle("全部订单").setUrl(R.mipmap.icon_mine_order_mall_all));
        mall_order_list.add(new MineLableBean().setId(1).setTitle("待付款").setUrl(R.mipmap.icon_mine_order_mall_daifukuan));
        mall_order_list.add(new MineLableBean().setId(2).setTitle("待发货").setUrl(R.mipmap.icon_mine_order_mall_daifahuo));
        mall_order_list.add(new MineLableBean().setId(3).setTitle("待收货").setUrl(R.mipmap.icon_mine_order_mall_daishouhuo));
        mall_order_list.add(new MineLableBean().setId(4).setTitle("待评价").setUrl(R.mipmap.icon_mine_order_mall_daipingjia));

        mallAdapter.setData(mall_order_list);
    }

    /**
     * 婚庆接单
     */
    private void setJiedan() {

        wedding_jiedan_list.clear();

        wedding_jiedan_list.add(new MineLableBean().setId(0).setTitle("全部订单").setUrl(R.mipmap.icon_mine_jiedan_all));
        wedding_jiedan_list.add(new MineLableBean().setId(1).setTitle("待付款").setUrl(R.mipmap.icon_mine_jiedan_daifukuan));
        wedding_jiedan_list.add(new MineLableBean().setId(2).setTitle("待接单").setUrl(R.mipmap.icon_mine_jiedan_daijiedan));
        wedding_jiedan_list.add(new MineLableBean().setId(3).setTitle("待服务").setUrl(R.mipmap.icon_mine_jiedan_daifuwu));
        wedding_jiedan_list.add(new MineLableBean().setId(4).setTitle("待评价").setUrl(R.mipmap.icon_mine_jiedan_daipingjia));

        weddingjiedanAdapter.setData(wedding_jiedan_list);
    }

    /**
     * 商城接单
     */
    private void setJiedan2() {

        jiedan_list.clear();

        jiedan_list.add(new MineLableBean().setId(0).setTitle("全部订单").setUrl(R.mipmap.icon_mine_jiedan_mall_all));
        jiedan_list.add(new MineLableBean().setId(1).setTitle("待付款").setUrl(R.mipmap.icon_mine_jiedan_mall_daifukuan));
        jiedan_list.add(new MineLableBean().setId(2).setTitle("待发货").setUrl(R.mipmap.icon_mine_jiedan_mall_daifahuo));
        jiedan_list.add(new MineLableBean().setId(3).setTitle("待收货").setUrl(R.mipmap.icon_mine_jiedan_mall_daishouhuo));
        jiedan_list.add(new MineLableBean().setId(4).setTitle("待评价").setUrl(R.mipmap.icon_mine_jiedan_mall_daipingjia));

        mAdapter2.setData(jiedan_list);
    }

    /**
     * 其他常用工具类 商城
     */
    private void setToolsMall() {
        other_tools.clear();

        other_tools.add(new MineLableBean().setId(0).setTitle("实名认证").setUrl(R.mipmap.shimingrenzheng_icon));
        other_tools.add(new MineLableBean().setId(1).setTitle("我的需求").setUrl(R.mipmap.wodexuqiu_icon));
        other_tools.add(new MineLableBean().setId(2).setTitle("我的社团").setUrl(R.mipmap.wodeshetuan_icon));
        other_tools.add(new MineLableBean().setId(3).setTitle("我的邀请").setUrl(R.mipmap.wodeyaoqing));
//        other_tools.add(new MineLableBean().setId(4).setTitle("评价管理").setUrl(R.mipmap.pingjiaguanli_icon));
//        other_tools.add(new MineLableBean().setId(5).setTitle("浏览记录").setUrl(R.mipmap.liulanjilu_icon));
        other_tools.add(new MineLableBean().setId(6).setTitle("婚礼新闻").setUrl(R.mipmap.hunlixinwen_icon));
//        other_tools.add(new MineLableBean().setId(7).setTitle("积分商城").setUrl(R.mipmap.jifen_mall_icon));
        other_tools.add(new MineLableBean().setId(8).setTitle("活动投票").setUrl(R.mipmap.huodong_toupiao_icon));
        mAdapter3.setData(other_tools);
    }

    /**
     * 其他常用工具类 婚庆
     */
    private void setToolsWedding() {
        other_tools.clear();

        other_tools.add(new MineLableBean().setId(0).setTitle("实名认证").setUrl(R.mipmap.shimingrenzheng_icon));
        other_tools.add(new MineLableBean().setId(1).setTitle("我的需求").setUrl(R.mipmap.wodexuqiu_icon));
        other_tools.add(new MineLableBean().setId(2).setTitle("我的社团").setUrl(R.mipmap.wodeshetuan_icon));
        other_tools.add(new MineLableBean().setId(3).setTitle("我的邀请").setUrl(R.mipmap.wodeyaoqing));
//        other_tools.add(new MineLableBean().setId(4).setTitle("评价管理").setUrl(R.mipmap.pingjiaguanli_icon));
//        other_tools.add(new MineLableBean().setId(5).setTitle("浏览记录").setUrl(R.mipmap.liulanjilu_icon));
        other_tools.add(new MineLableBean().setId(6).setTitle("婚礼新闻").setUrl(R.mipmap.hunlixinwen_icon));
//        other_tools.add(new MineLableBean().setId(7).setTitle("积分商城").setUrl(R.mipmap.jifen_mall_icon));
        other_tools.add(new MineLableBean().setId(8).setTitle("活动投票").setUrl(R.mipmap.huodong_toupiao_icon));
        mAdapter3.setData(other_tools);
    }

    /**
     * 其他常用工具类 用户
     */
    private void setTools() {
        other_tools.clear();

        other_tools.add(new MineLableBean().setId(0).setTitle("实名认证").setUrl(R.mipmap.shimingrenzheng_icon));
        other_tools.add(new MineLableBean().setId(1).setTitle("我的需求").setUrl(R.mipmap.wodexuqiu_icon));
        //other_tools.add(new MineLableBean().setId(2).setTitle("我的社团").setUrl(R.mipmap.wodeshetuan_icon));
        other_tools.add(new MineLableBean().setId(3).setTitle("我的邀请").setUrl(R.mipmap.wodeyaoqing));
//        other_tools.add(new MineLableBean().setId(4).setTitle("评价管理").setUrl(R.mipmap.pingjiaguanli_icon));
//        other_tools.add(new MineLableBean().setId(5).setTitle("浏览记录").setUrl(R.mipmap.liulanjilu_icon));
        other_tools.add(new MineLableBean().setId(6).setTitle("婚礼新闻").setUrl(R.mipmap.hunlixinwen_icon));
//        other_tools.add(new MineLableBean().setId(7).setTitle("积分商城").setUrl(R.mipmap.jifen_mall_icon));
        other_tools.add(new MineLableBean().setId(8).setTitle("活动投票").setUrl(R.mipmap.huodong_toupiao_icon));

        mAdapter3.setData(other_tools);
    }

    /**
     * 店铺管理 商城
     */
    private void setDianpuManagerMall() {
        dianpu_manager.clear();

        dianpu_manager.add(new MineLableBean().setId(0).setTitle("店铺信息").setUrl(R.mipmap.dianpuxinxi_icon));
        dianpu_manager.add(new MineLableBean().setId(1).setTitle("我的认证").setUrl(R.mipmap.dianpurenzheng_icon));
        //dianpu_manager.add(new MineLableBean().setId(2).setTitle("发布档期").setUrl(R.mipmap.wodedangqi_icon));
        //dianpu_manager.add(new MineLableBean().setId(3).setTitle("发布报价").setUrl(R.mipmap.wodebaojia_icon));
        dianpu_manager.add(new MineLableBean().setId(4).setTitle("我的商品").setUrl(R.mipmap.wodeshangpin_icon));
        //dianpu_manager.add(new MineLableBean().setId(5).setTitle("上传图片").setUrl(R.mipmap.wodetuce_icon));
        //dianpu_manager.add(new MineLableBean().setId(6).setTitle("上传视频").setUrl(R.mipmap.wodeshiping_icon));
        //dianpu_manager.add(new MineLableBean().setId(7).setTitle("上传案例").setUrl(R.mipmap.wodeanli_icon));
        //dianpu_manager.add(new MineLableBean().setId(8).setTitle("服务城市").setUrl(R.mipmap.fuwuchengshi_icon));
        dianpu_manager.add(new MineLableBean().setId(9).setTitle("推荐团队").setUrl(R.mipmap.tuijiantuandui_icon));
        dianpu_manager.add(new MineLableBean().setId(10).setTitle("查看需求").setUrl(R.mipmap.icon_jizhang));
        //dianpu_manager.add(new MineLableBean().setId(11).setTitle("推广助手").setUrl(R.mipmap.tuiguangzhushou));
        dianpu_manager.add(new MineLableBean().setId(12).setTitle("店铺主页").setUrl(R.mipmap.dianpuzhuye_icon));

        mAdapter4.setData(dianpu_manager);
    }

    /**
     * 店铺管理 婚庆
     */
    private void setDianpuManagerWedding() {
        dianpu_manager.clear();

        dianpu_manager.add(new MineLableBean().setId(0).setTitle("店铺信息").setUrl(R.mipmap.dianpuxinxi_icon));
        dianpu_manager.add(new MineLableBean().setId(1).setTitle("我的认证").setUrl(R.mipmap.dianpurenzheng_icon));
        dianpu_manager.add(new MineLableBean().setId(2).setTitle("发布档期").setUrl(R.mipmap.wodedangqi_icon));
        dianpu_manager.add(new MineLableBean().setId(3).setTitle("发布报价").setUrl(R.mipmap.wodebaojia_icon));
        //dianpu_manager.add(new MineLableBean().setId(4).setTitle("我的商品").setUrl(R.mipmap.wodeshangpin_icon));
        dianpu_manager.add(new MineLableBean().setId(5).setTitle("上传图片").setUrl(R.mipmap.wodetuce_icon));
        dianpu_manager.add(new MineLableBean().setId(6).setTitle("上传视频").setUrl(R.mipmap.wodeshiping_icon));
        dianpu_manager.add(new MineLableBean().setId(7).setTitle("上传案例").setUrl(R.mipmap.wodeanli_icon));
        dianpu_manager.add(new MineLableBean().setId(8).setTitle("服务城市").setUrl(R.mipmap.fuwuchengshi_icon));
        dianpu_manager.add(new MineLableBean().setId(9).setTitle("推荐团队").setUrl(R.mipmap.tuijiantuandui_icon));
        dianpu_manager.add(new MineLableBean().setId(10).setTitle("婚礼宝典").setUrl(R.mipmap.fayangao_icon));//查看需求
        //dianpu_manager.add(new MineLableBean().setId(11).setTitle("推广助手").setUrl(R.mipmap.tuiguangzhushou));
        dianpu_manager.add(new MineLableBean().setId(12).setTitle("店铺主页").setUrl(R.mipmap.dianpuzhuye_icon));

        mAdapter4.setData(dianpu_manager);
    }

    /**
     * 店铺管理
     */
    private void setDianpuManager() {
        dianpu_manager.clear();

        dianpu_manager.add(new MineLableBean().setId(0).setTitle("店铺信息").setUrl(R.mipmap.dianpuxinxi_icon));
        dianpu_manager.add(new MineLableBean().setId(1).setTitle("我的认证").setUrl(R.mipmap.dianpurenzheng_icon));
        dianpu_manager.add(new MineLableBean().setId(2).setTitle("发布档期").setUrl(R.mipmap.wodedangqi_icon));
        dianpu_manager.add(new MineLableBean().setId(3).setTitle("发布报价").setUrl(R.mipmap.wodebaojia_icon));
        dianpu_manager.add(new MineLableBean().setId(4).setTitle("我的商品").setUrl(R.mipmap.wodeshangpin_icon));
        dianpu_manager.add(new MineLableBean().setId(5).setTitle("上传图片").setUrl(R.mipmap.wodetuce_icon));
        dianpu_manager.add(new MineLableBean().setId(6).setTitle("上传视频").setUrl(R.mipmap.wodeshiping_icon));
        dianpu_manager.add(new MineLableBean().setId(7).setTitle("上传案例").setUrl(R.mipmap.wodeanli_icon));
        dianpu_manager.add(new MineLableBean().setId(8).setTitle("服务城市").setUrl(R.mipmap.fuwuchengshi_icon));
        dianpu_manager.add(new MineLableBean().setId(9).setTitle("推荐团队").setUrl(R.mipmap.tuijiantuandui_icon));
        dianpu_manager.add(new MineLableBean().setId(10).setTitle("查看需求").setUrl(R.mipmap.chakanxuqiu_icon));
        //dianpu_manager.add(new MineLableBean().setId(11).setTitle("推广助手").setUrl(R.mipmap.tuiguangzhushou));
        dianpu_manager.add(new MineLableBean().setId(12).setTitle("店铺主页").setUrl(R.mipmap.dianpuzhuye_icon));

        mAdapter4.setData(dianpu_manager);
    }

    /**
     * 用户常用工具
     */
    private void setUserTools() {
        user_tools.clear();

        user_tools.add(new MineLableBean().setId(0).setTitle("发布需求").setUrl(R.mipmap.fabuxuqiu_icon));
        user_tools.add(new MineLableBean().setId(1).setTitle("黄道吉日").setUrl(R.mipmap.huangdaojiri_icon));
        user_tools.add(new MineLableBean().setId(2).setTitle("电子请柬").setUrl(R.mipmap.dianziqingjian_icon));
        user_tools.add(new MineLableBean().setId(3).setTitle("日程安排").setUrl(R.mipmap.richeng_icon));
        user_tools.add(new MineLableBean().setId(4).setTitle("婚礼宝典").setUrl(R.mipmap.fayangao_icon));
        user_tools.add(new MineLableBean().setId(5).setTitle("婚礼流程").setUrl(R.mipmap.hunliliuchen_icon));
        user_tools.add(new MineLableBean().setId(6).setTitle("记账助手").setUrl(R.mipmap.jizhangzhushou_icon));
        user_tools.add(new MineLableBean().setId(7).setTitle("婚姻登记处").setUrl(R.mipmap.hunyindengjichu_icon));
        mAdapter5.setData(user_tools);
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
         
        EventBusUtil.unregister(this);
    }

    @OnClick({R.id.img_setting, R.id.ll_boyixueyuan, R.id.ll_mall_vip, R.id.ll_user_vip, R.id.ll_mall_charge,R.id.ll_daili_zhaomu, R.id.ll_show_fri_hunli, R.id.ll_about_us, R.id.ll_post_shop, R.id.ll_invated_shop})
    //@OnClick({R.id.img_setting, R.id.ll_boyixueyuan, R.id.ll_mall_vip, R.id.ll_user_vip, R.id.ll_invated_fri, R.id.ll_daili_zhaomu, R.id.ll_show_fri_hunli, R.id.ll_about_us, R.id.ll_post_shop, R.id.ll_invated_shop})
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.ll_boyixueyuan:
                break;
            case R.id.ll_mall_vip:
                break;
            case R.id.ll_user_vip:
                break;
            case R.id.ll_mall_charge:
                if (!LoginUtil.isLogin()) {
                    LoginActivity.startAction(getActivity());
                    break;
                }
                Intent intent = new Intent(getActivity(), ChargeActivity.class);
                startActivity(intent);
                break;
           /* case R.id.ll_invated_fri:
                break;*/
            case R.id.ll_daili_zhaomu:
                if (!LoginUtil.isLogin()) {
                    LoginActivity.startAction(getActivity());
                    break;
                }
                Intent intent2 = new Intent(getActivity(), WenzhangDetailsActivity.class);
                intent2.putExtra("url", "http://www.boyihunjia.com/wap/Agency/index.html");
                intent2.putExtra("title", "代理招募");
                getActivity().startActivity(intent2);
                break;
            case R.id.ll_show_fri_hunli:
                break;
            case R.id.ll_about_us:
                break;
            case R.id.img_setting:
                if (!LoginUtil.isLogin()) {
                    LoginActivity.startAction(getActivity());
                    break;
                }
                intent = new Intent(getActivity(), SettingActivity.class);
                startActivity(intent);
                break;
            case R.id.ll_invated_shop:
                if (!LoginUtil.isLogin()) {
                    LoginActivity.startAction(getActivity());
                    return;
                }
                Intent intent3 = new Intent(getActivity(), MineInvatedShopActivity.class);
                startActivity(intent3);
                break;
            case R.id.ll_post_shop:
                if (!LoginUtil.isLogin()) {
                    LoginActivity.startAction(getActivity());
                    break;
                }
                Intent intent1 = new Intent(getActivity(), RegisterStepActivity.class);
                intent1.putExtra("form_type", 1);
                intent1.putExtra("user_id", user_id);
                getActivity().startActivity(intent1);
                break;
        }
    }

    private void refreshView(UserInfoBean bean) {
        GlideLoad.GlideLoadCircle(bean.getHead(), ivHeadImg);
        tvUserName.setText(bean.getNickname());
        tvTeam.setText("" + bean.getAssociation());
        tvYue.setText("" + bean.getMoney());
        tvZekou.setText("" + bean.getVouchers());
        tvFansNum.setText("" + bean.getFans());
        tvCareNum.setText("" + bean.getFollownumber());
        price = bean.getVouchers();
    }

    private int associationid;//区分社团
    private int shop_id;
    private int user_id;

    private void getData() {
        ApiManager.getUserInfo(new OnRequestFinish<BaseBean<UserInfoBean>>() {
            @Override
            public void onFinished() {
            }

            @Override
            public void onSuccess(BaseBean<UserInfoBean> data) {
                if (data.getData() != null) {
                    refreshView(data.getData());
                    associationid = data.getData().getAssociationid();
                    user_type = data.getData().getUsertype();
                    shop_id = data.getData().getUserid();
                    user_id = data.getData().getUserid();
                    ctrlViewByUserRule();
                } else
                    NToast.show(data.getMessage());
            }

            @Override
            public void onError(Exception ex) {

            }
        });
    }

    private void getHouDongUrl() {
        LoadDialog.showDialog(getActivity());
        ApiManager.getTouPiaoUrl(new OnRequestFinish<BaseBean<String>>() {
            @Override
            public void onFinished() {

            }

            @Override
            public void onSuccess(BaseBean<String> data) {
                Intent intent = new Intent(getActivity(), WenzhangDetailsActivity.class);
                intent.putExtra("title", "活动投票");
                intent.putExtra("url", data.getData());
                intent.putExtra("isShowShare", true);
                intent.putExtra("isHouDongShare", 1);
                startActivity(intent);
            }

            @Override
            public void onError(Exception ex) {
                LoadDialog.CancelDialog();
            }
        });
    }

    @Override
    public void onResume() {
        super.onResume();
        if (LoginUtil.isLogin()) {
            getData();
        } else {
            GlideLoad.GlideLoadCircle("android.resource://com.linzi.xiguwen/mipmap/" + R.mipmap.icon_placeholder, ivHeadImg);
            tvUserName.setText("未登录");
            tvFansNum.setText("0");
            tvYue.setText("0");
            tvZekou.setText("0");
            tvTeam.setText("");
            tvCareNum.setText("0");
        }
        ctrlViewByUserRule();
    }

    @Subscribe(threadMode = ThreadMode.MAIN)
    public void receiveEvent(Event entity) {
        if (entity == null)
            return;
        try {
            int code = entity.getCode();
            switch (code) {
                case EventCode.LOGIN_SUCCESS:
                    getData();
                    ctrlViewByUserRule();
                    break;
                case EventCode.PAY_SUCCRSS:
                    getData();
                    break;
            }
        } catch (Exception e) {
        }

    }
}
