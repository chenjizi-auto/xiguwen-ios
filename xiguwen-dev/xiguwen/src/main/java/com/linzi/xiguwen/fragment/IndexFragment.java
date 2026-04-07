package com.linzi.xiguwen.fragment;

import android.content.Intent;
import android.os.Bundle;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
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

import com.alibaba.fastjson.JSONObject;
import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.MainIndexFragment;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.GoodsListAdapter;
import com.linzi.xiguwen.adapter.HotMallListAdapter;
import com.linzi.xiguwen.adapter.MenuAdapter;
import com.linzi.xiguwen.adapter.MenuPagerAdapter;
import com.linzi.xiguwen.bean.BaseBean;
import com.linzi.xiguwen.bean.GuessYouLikeBean;
import com.linzi.xiguwen.bean.HunQinMenuBean;
import com.linzi.xiguwen.bean.IndexBean;
import com.linzi.xiguwen.bean.IndexGoodsVadioBean;
import com.linzi.xiguwen.bean.MenuBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.ui.AllClassicActivity;
import com.linzi.xiguwen.ui.BaojiaDetailsActivity;
import com.linzi.xiguwen.ui.ExampleDetailsActivity;
import com.linzi.xiguwen.ui.ExampleListActivity;
import com.linzi.xiguwen.ui.ForNeedActivity;
import com.linzi.xiguwen.ui.GetSuggestActivity;
import com.linzi.xiguwen.ui.GoodDayActivity;
import com.linzi.xiguwen.ui.GoodsDetailsActivity;
import com.linzi.xiguwen.ui.MallDetailsActivity;
import com.linzi.xiguwen.ui.MallListActivity;
import com.linzi.xiguwen.ui.MineChakanNeed2Activity;
import com.linzi.xiguwen.ui.RichengActivity;
import com.linzi.xiguwen.ui.WenzhangDetailsActivity;
import com.linzi.xiguwen.utils.CallBack;
import com.linzi.xiguwen.utils.GlideImageLoader;
import com.linzi.xiguwen.utils.GlideLoad;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.SPUtil;
import com.youth.banner.Banner;
import com.youth.banner.BannerConfig;
import com.youth.banner.listener.OnBannerListener;
import com.youth.banner.view.BannerViewPager;

import org.xutils.common.Callback;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2017/11/21.
 */

public class IndexFragment extends Fragment {
    @BindView(R.id.banner)
    Banner banner;
    @BindView(R.id.menu_pager)
    BannerViewPager mMenuPager;
    @BindView(R.id.ll_point)
    LinearLayout llPoint;
    @BindView(R.id.iv_zhekou_img)
    ImageView ivZhekouImg;
    @BindView(R.id.bt_enter_red)
    Button btEnterRed;
    @BindView(R.id.iv_youhui_img)
    ImageView ivYouhuiImg;
    @BindView(R.id.bt_enter_org)
    Button btEnterOrg;
    @BindView(R.id.tv_more)
    TextView tvMore;
    @BindView(R.id.iv_xuqiu)
    ImageView ivXuqiu;
    @BindView(R.id.iv_huangli)
    ImageView ivHuangli;
    @BindView(R.id.iv_qingjian)
    ImageView ivQingjian;
    @BindView(R.id.iv_richeng)
    ImageView ivRicheng;
    @BindView(R.id.iv_fayangao)
    ImageView ivFayangao;
    @BindView(R.id.ll_tools)
    LinearLayout llTools;
    @BindView(R.id.recycle_person_mall)
    RecyclerView recyclePersonMall;
    @BindView(R.id.ll_mall_person)
    LinearLayout llMallPerson;
    @BindView(R.id.recycle_company_mall)
    RecyclerView recycleCompanyMall;
    @BindView(R.id.ll_mall_company)
    LinearLayout llMallCompany;
    @BindView(R.id.iv_activities)
    ImageView ivActivities;
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
    @BindView(R.id.ll_activities)
    LinearLayout llActivities;
    @BindView(R.id.tv_more_love)
    TextView tvMoreLove;
    @BindView(R.id.recycle_guess)
    RecyclerView recycleGuess;
    @BindView(R.id.tv_get_more)
    TextView tvGetMore;
    @BindView(R.id.ll_guess_love)
    LinearLayout llGuessLove;



    List<String> mBannerData = new ArrayList<>();

    MenuBean mIcon = new MenuBean();
    List<View> menu_pager;
    MenuAdapter mAdapter;

    HotMallListAdapter mallListAdapter;
    HotMallListAdapter mallListAdapter2;

    GoodsListAdapter goodsListAdapter;

    public static IndexFragment instence;

    IndexBean mBean;

    List<IndexGoodsVadioBean>mGoodsBean;

    List<MenuBean.Menu> mData;

    int page=0;

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = LayoutInflater.from(getActivity()).inflate(R.layout.fragment_index, null);
        ButterKnife.bind(this, view);
        instence=this;
        initView();
        return view;
    }

    private void initView() {
        setMenuIcon();

        LinearLayoutManager manager=new LinearLayoutManager(getActivity()){
            @Override
            public boolean canScrollVertically() {
                // 直接禁止垂直滑动
                return false;
            }
        };
        recycleGuess.setLayoutManager(manager);

        getIndex();

        GlideLoad.GlideLoadImg(getActivity(),"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1520278561822&di=4159470e091787652e9c8b5b0c8c005b&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F3b292df5e0fe992532fd5c7e3fa85edf8db1712e.jpg",ivZhekouImg);
        GlideLoad.GlideLoadImg(getActivity(),"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1520278561818&di=a4b46425f1d493dc2a74340662d0eb1d&imgtype=0&src=http%3A%2F%2Fpic8.nipic.com%2F20100802%2F2531170_184409970932_2.jpg",ivYouhuiImg);

        btEnterRed.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent=new Intent(getActivity(),ExampleListActivity.class);
                startActivity(intent);
            }
        });

        btEnterOrg.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent=new Intent(getActivity(),GetSuggestActivity.class);
                startActivity(intent);
            }
        });

        ivXuqiu.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent=new Intent(getActivity(),ForNeedActivity.class);
                startActivity(intent);
            }
        });
        ivHuangli.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent=new Intent(getActivity(),GoodDayActivity.class);
                startActivity(intent);
            }
        });
        ivQingjian.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
//                Intent intent=new Intent(getActivity(),QingJianActivity.class);
//                startActivity(intent);
                NToast.show("重磅功能即将上线");
            }
        });

        ivFayangao.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent   intent = new Intent(getActivity(), MineChakanNeed2Activity.class);
                startActivity(intent);

//                Intent intent=new Intent(getActivity(),FayanListActivity.class);
//                startActivity(intent);
            }
        });
        ivRicheng.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent=new Intent(getActivity(),RichengActivity.class);
                startActivity(intent);
            }
        });
    }

    private void setGoodsList(){
        if(goodsListAdapter==null) {
            goodsListAdapter = new GoodsListAdapter(getActivity());
            recycleGuess.setAdapter(goodsListAdapter);
            goodsListAdapter.setData(mGoodsBean);
        }else{
            goodsListAdapter.setData(mGoodsBean);
        }
        goodsListAdapter.setListener(new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int postion) {
                if(mGoodsBean.get(postion).getIsCare()==1){
                    delCare(mGoodsBean.get(postion).getId());
                }else{
                    addCare(mGoodsBean.get(postion).getId());
                }
            }
        });
    }

    private void setMallList() {
        LinearLayoutManager manager = new LinearLayoutManager(getActivity(), OrientationHelper.HORIZONTAL, false);
        LinearLayoutManager manager2 = new LinearLayoutManager(getActivity(), OrientationHelper.HORIZONTAL, false);
//        mallListAdapter = new HotMallListAdapter(getActivity(), mBean.getData().getRemengeren().getData(), new CallBack.OnMenuItemClickListener() {
//            @Override
//            public void itemClick(int position) {
////                Intent intent=new Intent(getActivity(), HotMallActivity.class);
////                getActivity().startActivity(intent);
//                Intent intent;
//                if(mBean.getData().getRemengeren().getData().get(position).getSrc()!=null) {
//                    intent = new Intent(getActivity(), WenzhangDetailsActivity.class);
//                    intent.putExtra("url",mBean.getData().getRemengeren().getData().get(position).getSrc());
//                    startActivity(intent);
//                }else{
//                    switch(mBean.getData().getRemengeren().getData().get(position).getAptype()){
//                        case 1:
//                            intent=new Intent(getActivity(),MallDetailsActivity.class);
//                            intent.putExtra("id",mBean.getData().getRemengeren().getData().get(position).getAptid());
//                            startActivity(intent);
//                            break;
//                        case 2:
//                            intent=new Intent(getActivity(),MallDetailsActivity.class);
//                            intent.putExtra("id",mBean.getData().getRemengeren().getData().get(position).getAptid());
//                            startActivity(intent);
//                            break;
//                        case 3:
//                            intent=new Intent(getActivity(),ExampleDetailsActivity.class);
//                            intent.putExtra("id",mBean.getData().getRemengeren().getData().get(position).getAptid());
//                            startActivity(intent);
//                            break;
//                        case 5:
//                            intent=new Intent(getActivity(),GoodsDetailsActivity.class);
//                            intent.putExtra("id",mBean.getData().getRemengeren().getData().get(position).getAptid());
//                            startActivity(intent);
//                            break;
//                        case 6:
//                            intent=new Intent(getActivity(),BaojiaDetailsActivity.class);
//                            intent.putExtra("id",mBean.getData().getRemengeren().getData().get(position).getAptid());
//                            startActivity(intent);
//                            break;
//                    }
//                }
//            }
//        });
//        mallListAdapter2 = new HotMallListAdapter(getActivity(), mBean.getData().getRementuandui().getData(), new CallBack.OnMenuItemClickListener() {
//            @Override
//            public void itemClick(int position) {
////                Intent intent=new Intent(getActivity(), HotTeamActivity.class);
////                getActivity().startActivity(intent);
//                Intent intent;
//                if(mBean.getData().getRementuandui().getData().get(position).getSrc()!=null) {
//                    intent = new Intent(getActivity(), WenzhangDetailsActivity.class);
//                    intent.putExtra("url",mBean.getData().getRementuandui().getData().get(position).getSrc());
//                    startActivity(intent);
//                }else{
//                    switch(mBean.getData().getRementuandui().getData().get(position).getAptype()){
//                        case 1:
//                            intent=new Intent(getActivity(),MallDetailsActivity.class);
//                            intent.putExtra("id",mBean.getData().getRementuandui().getData().get(position).getAptid());
//                            startActivity(intent);
//                            break;
//                        case 2:
//                            intent=new Intent(getActivity(),MallDetailsActivity.class);
//                            intent.putExtra("id",mBean.getData().getRementuandui().getData().get(position).getAptid());
//                            startActivity(intent);
//                            break;
//                        case 3:
//                            intent=new Intent(getActivity(),ExampleDetailsActivity.class);
//                            intent.putExtra("id",mBean.getData().getRementuandui().getData().get(position).getAptid());
//                            startActivity(intent);
//                            break;
//                        case 5:
//                            intent=new Intent(getActivity(),GoodsDetailsActivity.class);
//                            intent.putExtra("id",mBean.getData().getRementuandui().getData().get(position).getAptid());
//                            startActivity(intent);
//                            break;
//                        case 6:
//                            intent=new Intent(getActivity(),BaojiaDetailsActivity.class);
//                            intent.putExtra("id",mBean.getData().getRementuandui().getData().get(position).getAptid());
//                            startActivity(intent);
//                            break;
//                    }
//                }
//            }
//        });
        recyclePersonMall.setLayoutManager(manager);
        recyclePersonMall.setAdapter(mallListAdapter);
        recycleCompanyMall.setLayoutManager(manager2);
        recycleCompanyMall.setAdapter(mallListAdapter2);


    }

    private void setBanber() {
        NToast.log("banner数量",""+mBean.getData().getGuanggaolunbo().size());
        for(int x=0;x<mBean.getData().getGuanggaolunbo().size();x++){
            mBannerData.add(mBean.getData().getGuanggaolunbo().get(x).getWapimg());
        }
        banner.setImages(mBannerData)
                .setImageLoader(new GlideImageLoader())
                .setIndicatorGravity(BannerConfig.CENTER)
                .setDelayTime(2000)
                .start();
        banner.setOnBannerListener(new OnBannerListener() {
            @Override
            public void OnBannerClick(int position) {
                Intent intent;
                if(mBean.getData().getGuanggaolunbo().get(position).getSrc()!=null) {
                     intent = new Intent(getActivity(), WenzhangDetailsActivity.class);
                    intent.putExtra("url",mBean.getData().getGuanggaolunbo().get(position).getSrc());
                    startActivity(intent);
                }else{
                    switch(mBean.getData().getGuanggaolunbo().get(position).getAptype()){
                        case 1:
                             intent=new Intent(getActivity(),MallDetailsActivity.class);
                            intent.putExtra("id",mBean.getData().getGuanggaolunbo().get(position).getAptid());
                            startActivity(intent);
                        break;
                        case 2:
                             intent=new Intent(getActivity(),MallDetailsActivity.class);
                            intent.putExtra("id",mBean.getData().getGuanggaolunbo().get(position).getAptid());
                            startActivity(intent);
                        break;
                        case 3:
                            intent=new Intent(getActivity(),ExampleDetailsActivity.class);
                            intent.putExtra("id",mBean.getData().getGuanggaolunbo().get(position).getAptid());
                            startActivity(intent);
                        break;
                        case 5:
                            intent=new Intent(getActivity(),GoodsDetailsActivity.class);
                            intent.putExtra("id",mBean.getData().getGuanggaolunbo().get(position).getAptid());
                            startActivity(intent);
                        break;
                        case 6:
                            intent=new Intent(getActivity(),BaojiaDetailsActivity.class);
                            intent.putExtra("id",mBean.getData().getGuanggaolunbo().get(position).getAptid());
                            startActivity(intent);
                        break;
                    }
                }
            }
        });
        GlideLoad.GlideLoadImg(getActivity(),mBean.getData().getXiaoguanggaoyi().get(0).getWapimg(),ivActivities);
        ivActivities.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent;
                if(mBean.getData().getXiaoguanggaoyi().get(0).getSrc()!=null) {
                    intent = new Intent(getActivity(), WenzhangDetailsActivity.class);
                    intent.putExtra("url",mBean.getData().getXiaoguanggaoyi().get(0).getSrc());
                    startActivity(intent);
                }else{
                    switch(mBean.getData().getXiaoguanggaoyi().get(0).getAptype()){
                        case 1:
                            intent=new Intent(getActivity(),MallDetailsActivity.class);
                            intent.putExtra("id",mBean.getData().getXiaoguanggaoyi().get(0).getAptid());
                            startActivity(intent);
                            break;
                        case 2:
                            intent=new Intent(getActivity(),MallDetailsActivity.class);
                            intent.putExtra("id",mBean.getData().getXiaoguanggaoyi().get(0).getAptid());
                            startActivity(intent);
                            break;
                        case 3:
                            intent=new Intent(getActivity(),ExampleDetailsActivity.class);
                            intent.putExtra("id",mBean.getData().getXiaoguanggaoyi().get(0).getAptid());
                            startActivity(intent);
                            break;
                        case 5:
                            intent=new Intent(getActivity(),GoodsDetailsActivity.class);
                            intent.putExtra("id",mBean.getData().getXiaoguanggaoyi().get(0).getAptid());
                            startActivity(intent);
                            break;
                        case 6:
                            intent=new Intent(getActivity(),BaojiaDetailsActivity.class);
                            intent.putExtra("id",mBean.getData().getXiaoguanggaoyi().get(0).getAptid());
                            startActivity(intent);
                            break;
                    }
                }
            }
        });
    }

    private void setMenuPager() {
        int menu_page_size = 0;
        if ((mIcon.getMenus().size() % 10) == 0) {
            menu_page_size = (mIcon.getMenus().size() / 10);
        } else {
            menu_page_size = ((int) (mIcon.getMenus().size() / 10)) + 1;
        }
        menu_pager = new ArrayList<>();
        final List<RadioButton> point_list = new ArrayList<>();
        llPoint.removeAllViews();
        for (int x = 0; x < menu_page_size; x++) {
            View view = LayoutInflater.from(getActivity()).inflate(R.layout.item_main_menu_pager, null);
            GridView grid = (GridView) view.findViewById(R.id.gridview);
            mData = new ArrayList<>();
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
                    Intent intent;
//                    switch(position){
//                        case -1:
//                            intent=new Intent(getActivity(),AllClassicActivity.class);
//                            startActivity(intent);
//                        break;
//                        case 1:
//                            intent=new Intent(getActivity(),MallListActivity.class);
//                            intent.putExtra("city",MainIndexFragment.instence.tvLocation.getText().toString());
//                            intent.putExtra("id",mData.get(position).getId());
//                            startActivity(intent);
//                            break;
//                    }
                    if(position==-1){
                        intent=new Intent(getActivity(),AllClassicActivity.class);
                        startActivity(intent);
                    }else{
                        intent=new Intent(getActivity(),MallListActivity.class);
                        intent.putExtra("city",MainIndexFragment.instence.tvLocation.getText().toString());
                        intent.putExtra("id",position);
                        startActivity(intent);
                    }
                }

                @Override
                public void itemClick(int position, String name) {

                }
            });
            grid.setAdapter(mAdapter);
            menu_pager.add(view);

            View point_view = LayoutInflater.from(getActivity()).inflate(R.layout.index_point_rb, null);
            RadioButton rb = (RadioButton) point_view.findViewById(R.id.rb);
            point_list.add(rb);
            llPoint.addView(point_view);
        }
        mMenuPager.setAdapter(new MenuPagerAdapter(getActivity(), menu_pager));
        point_list.get(0).setChecked(true);
        mMenuPager.setOnPageChangeListener(new ViewPager.OnPageChangeListener() {
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

    private void setMenuIcon() {
        mIcon = new MenuBean();
//        List<MenuBean.Menu> list = new ArrayList<>();
//        for (int x = 0; x < 30; x++) {
//            MenuBean.Menu menu = new MenuBean.Menu();
//            menu.setId(x);
//            menu.setIcon("https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1511259771079&di=025b38ae93fa462a65ca9dc2dfddd140&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2Ff703738da977391206c8f85cf3198618367ae225.jpg");
//            menu.setTitle("标题" + x);
//            list.add(menu);
//        }
        LoadDialog.showDialog(getActivity());
        new ApiManager().getHunQinMenu(1, new Callback.CommonCallback<String>() {
            @Override
            public void onSuccess(String result) {
                NToast.log("菜单项",result);
                HunQinMenuBean bean=JSONObject.parseObject(result,HunQinMenuBean.class);
                List<MenuBean.Menu> list = new ArrayList<>();
                for (int x = 0; x < bean.getData().size()+1; x++) {
                    if(x!=0) {
                        MenuBean.Menu menu = new MenuBean.Menu();
                        menu.setId(bean.getData().get(x-1).getOccupationid());
                        menu.setIcon(bean.getData().get(x-1).getWapimg());
                        menu.setTitle(bean.getData().get(x-1).getProname());
                        list.add(menu);
                    }else{
                        MenuBean.Menu menu = new MenuBean.Menu();
                        menu.setId(-1);
                        menu.setIcon("http://pic.35pic.com/normal/09/23/84/9667805_110103342174_2.jpg");
                        menu.setTitle("全部");
                        list.add(menu);
                    }
                }
                mIcon.setMenus(list);
                setMenuPager();
            }

            @Override
            public void onError(Throwable ex, boolean isOnCallback) {

            }

            @Override
            public void onCancelled(CancelledException cex) {

            }

            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }
        });
    }

    public void getIndex(){
        LoadDialog.showDialog(getActivity());
        new ApiManager().getIndex("" + MainIndexFragment.instence.city_code, SPUtil.get("token", SPUtil.Type.STR).toString(), ""+(int)SPUtil.get("userid", SPUtil.Type.INT), page, new Callback.CommonCallback<String>() {
            @Override
            public void onSuccess(String result) {
                NToast.log("结果",result);
                mBean=JSONObject.parseObject(result,IndexBean.class);
                NToast.log("code",""+mBean.getCode());
                setBanber();
                setMallList();

                GlideLoad.GlideLoadImg(getActivity(),mBean.getData().getRemenhuodong().getRmhd1().getWapimg(),ivActivity1);
                GlideLoad.GlideLoadImg(getActivity(),mBean.getData().getRemenhuodong().getRmhd2().getWapimg(),ivActivity2);
                GlideLoad.GlideLoadImg(getActivity(),mBean.getData().getRemenhuodong().getRmhd3().getWapimg(),ivActivity3);
                GlideLoad.GlideLoadImg(getActivity(),mBean.getData().getRemenhuodong().getRmhd4().getWapimg(),ivActivity4);
                GlideLoad.GlideLoadImg(getActivity(),mBean.getData().getRemenhuodong().getRmhd5().getWapimg(),ivActivity5);

                ivActivity1.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        if(mBean.getData().getRemenhuodong().getRmhd1().getSrc()!=null){
                            Intent intent=new Intent(getActivity(),WenzhangDetailsActivity.class);
                            intent.putExtra("url",mBean.getData().getRemenhuodong().getRmhd1().getSrc());
                            startActivity(intent);
                        }
                    }
                });
                ivActivity2.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        if(mBean.getData().getRemenhuodong().getRmhd2().getSrc()!=null){
                            Intent intent=new Intent(getActivity(),WenzhangDetailsActivity.class);
                            intent.putExtra("url",mBean.getData().getRemenhuodong().getRmhd2().getSrc());
                            startActivity(intent);
                        }
                    }
                });
                ivActivity3.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        if(mBean.getData().getRemenhuodong().getRmhd3().getSrc()!=null){
                            Intent intent=new Intent(getActivity(),WenzhangDetailsActivity.class);
                            intent.putExtra("url",mBean.getData().getRemenhuodong().getRmhd3().getSrc());
                            startActivity(intent);
                        }
                    }
                });
                ivActivity4.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        if(mBean.getData().getRemenhuodong().getRmhd4().getSrc()!=null){
                            Intent intent=new Intent(getActivity(),WenzhangDetailsActivity.class);
                            intent.putExtra("url",mBean.getData().getRemenhuodong().getRmhd4().getSrc());
                            startActivity(intent);
                        }
                    }
                });
                ivActivity5.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        if(mBean.getData().getRemenhuodong().getRmhd5().getSrc()!=null){
                            Intent intent=new Intent(getActivity(),WenzhangDetailsActivity.class);
                            intent.putExtra("url",mBean.getData().getRemenhuodong().getRmhd5().getSrc());
                            startActivity(intent);
                        }
                    }
                });

                if(mGoodsBean==null){
                    mGoodsBean=new ArrayList<IndexGoodsVadioBean>();
                }else{
                    mGoodsBean.clear();
                }
                List<GuessYouLikeBean>guessBean=JSONObject.parseArray(mBean.getData().getYoulike(),GuessYouLikeBean.class);
                for(int x=0;x<guessBean.size();x++){
                    IndexGoodsVadioBean igvBean=new IndexGoodsVadioBean();
                    igvBean.setId(x);
                    igvBean.setHead_img(guessBean.get(x).getHead());
                    igvBean.setZhiye(guessBean.get(x).getOccupationid());
                    if(guessBean.get(x).getVideo_url()!=null){
                        igvBean.setType(1);
                        igvBean.setImg_url(guessBean.get(x).getWeddingcover());
                    }else if(guessBean.get(x).getPhotourl() != null){
                        igvBean.setType(2);
                        List<IndexGoodsVadioBean.Tuce> tuce_list = new ArrayList<IndexGoodsVadioBean.Tuce>();
//                        if (guessBean.get(x).getPhotourl() != null) {
                            for (int y = 0; y < guessBean.get(x).getPhotourl().size(); y++) {
                                IndexGoodsVadioBean.Tuce tuce = new IndexGoodsVadioBean().new Tuce();
                                tuce.setId(guessBean.get(x).getPhotourl().get(y).getId());
                                tuce.setUrl(guessBean.get(x).getPhotourl().get(y).getPhoto());
                                tuce_list.add(tuce);
                            }
//                        }
                        igvBean.setTuce(tuce_list);
                    }else{
                        igvBean.setType(0);
                        igvBean.setImg_url(guessBean.get(x).getWeddingcover());
                    }
                    igvBean.setContent(guessBean.get(x).getWeddingdescribe());
                    igvBean.setTitle(guessBean.get(x).getTitle());
                    igvBean.setIsCare(guessBean.get(x).getFollow());
                    igvBean.setGuanzhuliang(guessBean.get(x).getFollowed());
                    igvBean.setDianjiliang(guessBean.get(x).getClicked());
                    igvBean.setPinglunliang(guessBean.get(x).getPinluns());
                    igvBean.setPrice(""+guessBean.get(x).getWeddingexpenses());
                    igvBean.setName(guessBean.get(x).getNickname());
                    mGoodsBean.add(igvBean);
                }
                setGoodsList();
            }

            @Override
            public void onError(Throwable ex, boolean isOnCallback) {
                com.linzi.xiguwen.utils.LogUtil.printStackTrace(ex);
            }

            @Override
            public void onCancelled(CancelledException cex) {

            }

            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }
        });
    }

    private void addCare(int id){
        LoadDialog.showDialog(getActivity());
        new ApiManager().addALCare(SPUtil.get("userid", 0), SPUtil.get("token", ""), id, new Callback.CommonCallback<String>() {
            @Override
            public void onSuccess(String result) {
                NToast.log("关注结果",result);
                BaseBean base=JSONObject.parseObject(result,BaseBean.class);
                getIndex();
            }

            @Override
            public void onError(Throwable ex, boolean isOnCallback) {

            }

            @Override
            public void onCancelled(CancelledException cex) {

            }

            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }
        });
    }

    private void delCare(int id){
        LoadDialog.showDialog(getActivity());
        new ApiManager().delALCare(SPUtil.get("userid", 0), SPUtil.get("token", ""), id, new Callback.CommonCallback<String>() {
            @Override
            public void onSuccess(String result) {
                NToast.log("取关结果",result);
                BaseBean base=JSONObject.parseObject(result,BaseBean.class);
                getIndex();
            }

            @Override
            public void onError(Throwable ex, boolean isOnCallback) {

            }

            @Override
            public void onCancelled(CancelledException cex) {

            }

            @Override
            public void onFinished() {
                LoadDialog.CancelDialog();
            }
        });
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
         
    }
}
