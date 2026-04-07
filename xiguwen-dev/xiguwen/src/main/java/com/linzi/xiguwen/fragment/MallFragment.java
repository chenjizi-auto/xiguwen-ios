package com.linzi.xiguwen.fragment;

import android.content.Intent;
import android.os.Bundle;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.viewpager.widget.ViewPager;
import androidx.recyclerview.widget.LinearLayoutManager;
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
import com.linzi.xiguwen.adapter.GuessLoveGoodsAdapter;
import com.linzi.xiguwen.adapter.HotGoodsAdapter;
import com.linzi.xiguwen.adapter.MenuAdapter;
import com.linzi.xiguwen.adapter.MenuPagerAdapter;
import com.linzi.xiguwen.bean.MenuBean;
import com.linzi.xiguwen.network.ApiManager;
import com.linzi.xiguwen.utils.CallBack;
import com.linzi.xiguwen.utils.GlideImageLoader;
import com.linzi.xiguwen.utils.LoadDialog;
import com.linzi.xiguwen.utils.NToast;
import com.linzi.xiguwen.utils.SPUtil;
import com.youth.banner.Banner;
import com.youth.banner.BannerConfig;
import com.youth.banner.view.BannerViewPager;

import org.xutils.common.Callback;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2017/12/11.
 */

public class MallFragment extends Fragment {
    @BindView(R.id.banner)
    Banner banner;
    @BindView(R.id.menu_pager)
    BannerViewPager menuPager;
    @BindView(R.id.ll_point)
    LinearLayout llPoint;
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
    @BindView(R.id.iv_activities)
    ImageView ivActivities;
    @BindView(R.id.tv_more_love)
    TextView tvMoreLove;
    @BindView(R.id.hot_recycle)
    RecyclerView hotRecycle;
    @BindView(R.id.recycle_guess)
    RecyclerView recycleGuess;
    @BindView(R.id.tv_get_more)
    TextView tvGetMore;

    List<String> mBannerData = new ArrayList<>();

    MenuBean mIcon = new MenuBean();
    List<View> menu_pager;
    MenuAdapter mAdapter;

    HotGoodsAdapter mHotGoodsAdapter;
    GuessLoveGoodsAdapter guessAdapter;

    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = LayoutInflater.from(getActivity()).inflate(R.layout.fragment_mall_layout, null);
        ButterKnife.bind(this, view);
        initViews();
        return view;
    }

    private void initViews() {
        setBanber();
        setMenuPager();
        setGoodsList();
        setGuessLove();
    }

    private void setGoodsList() {
        LinearLayoutManager manager = new LinearLayoutManager(getActivity()) {
            @Override
            public boolean canScrollVertically() {
                // 直接禁止垂直滑动
                return false;
            }
        };
        hotRecycle.setLayoutManager(manager);
        mHotGoodsAdapter = new HotGoodsAdapter(getActivity());
        hotRecycle.setAdapter(mHotGoodsAdapter);
    }

    private void setGuessLove(){
        LinearLayoutManager manager = new LinearLayoutManager(getActivity()) {
            @Override
            public boolean canScrollVertically() {
                // 直接禁止垂直滑动
                return false;
            }
        };
        recycleGuess.setLayoutManager(manager);
        guessAdapter=new GuessLoveGoodsAdapter(getActivity());
        recycleGuess.setAdapter(guessAdapter);
    }

    private void setBanber() {
        mBannerData.add("https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1511255170196&di=7e4fba7a2af565b2f839978a3c8d8a67&imgtype=0&src=http%3A%2F%2Fjoymepic.joyme.com%2Farticle%2Fuploads%2F20177%2F11501557343644187.jpeg");
        mBannerData.add("https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1511255206399&di=e709c7d1f05d577997ca8e0a24da6b3b&imgtype=0&src=http%3A%2F%2Fi2.hdslb.com%2Fbfs%2Farchive%2F26580541a36aba1e49e70c98da4fbc94950232bb.jpg");
        mBannerData.add("https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1511255379272&di=26a484f71a8991e7603f5dee6a20a083&imgtype=0&src=http%3A%2F%2Fi1.hdslb.com%2Fbfs%2Farchive%2Fe394736c4b866d06cfc3b4881f82e01e1323eb93.jpg");
        banner.setImages(mBannerData)
                .setImageLoader(new GlideImageLoader())
                .setIndicatorGravity(BannerConfig.CENTER)
                .setDelayTime(2000)
                .start();
    }

    private void setMenuPager() {
        setMenuIcon();
        int menu_page_size = 0;
        if ((mIcon.getMenus().size() % 10) == 0) {
            menu_page_size = (mIcon.getMenus().size() / 10);
        } else {
            menu_page_size = ((int) (mIcon.getMenus().size() / 10)) + 1;
        }
        List<MenuBean.Menu> mData;
        menu_pager = new ArrayList<>();
        final List<RadioButton> point_list = new ArrayList<>();
        llPoint.removeAllViews();
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
                    Intent intent;
                    switch (position) {
//                        case 0:
//                            intent=new Intent(getActivity(),AllClassicActivity.class);
//                            startActivity(intent);
//                            break;
//                        case 1:
//                            intent=new Intent(getActivity(),LoginActivity.class);
//                            startActivity(intent);
//                            break;
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

    private void getIndex(){
        LoadDialog.showDialog(getActivity());
        new ApiManager().getHomtList(MainIndexFragment.instence.city_code, SPUtil.get("token", "")
                , SPUtil.get("userid", 0),new Callback.CommonCallback<String>(){

                    @Override
                    public void onSuccess(String result) {

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

    private void setMenuIcon() {
        mIcon = new MenuBean();
        List<MenuBean.Menu> list = new ArrayList<>();
        for (int x = 0; x < 30; x++) {
            MenuBean.Menu menu = new MenuBean.Menu();
            menu.setId(x);
            menu.setIcon("https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1511259771079&di=025b38ae93fa462a65ca9dc2dfddd140&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2Ff703738da977391206c8f85cf3198618367ae225.jpg");
            menu.setTitle("标题" + x);
            list.add(menu);
        }
        mIcon.setMenus(list);
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
         
    }
}
