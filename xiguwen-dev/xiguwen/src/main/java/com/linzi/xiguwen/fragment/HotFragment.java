package com.linzi.xiguwen.fragment;

import android.content.Context;
import android.content.Intent;
import android.graphics.drawable.ColorDrawable;
import android.os.Bundle;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.widget.LinearLayout;
import android.widget.PopupWindow;
import android.widget.RelativeLayout;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.HotFragmentAdapter;
import com.linzi.xiguwen.adapter.PopArrowAdapter;
import com.linzi.xiguwen.ui.MallDetailsActivity;
import com.linzi.xiguwen.ui.TebieTuijianActivity;
import com.linzi.xiguwen.utils.GlideImageLoader;
import com.linzi.xiguwen.view.CusRadioButton;
import com.linzi.xiguwen.view.CusScrollView;
import com.youth.banner.Banner;
import com.youth.banner.BannerConfig;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

/**
 * Created by jiang on 2017/12/12.
 */

public class HotFragment extends Fragment {
    @BindView(R.id.banner)
    Banner banner;

    List<String> mBannerData = new ArrayList<>();
    @BindView(R.id.rl_today_top)
    RelativeLayout rlTodayTop;
    @BindView(R.id.rl_week_peo)
    RelativeLayout rlWeekPeo;
    @BindView(R.id.rl_month_peo)
    RelativeLayout rlMonthPeo;
    @BindView(R.id.rl_week_hot)
    RelativeLayout rlWeekHot;
    @BindView(R.id.rl_month_hot)
    RelativeLayout rlMonthHot;
    @BindView(R.id.rb_all)
    CusRadioButton rbAll;
    @BindView(R.id.rb_sort)
    CusRadioButton rbSort;
    @BindView(R.id.rb_location)
    CusRadioButton rbLocation;
    @BindView(R.id.rb_saixuan)
    CusRadioButton rbSaixuan;
    @BindView(R.id.hot_recycle)
    RecyclerView hotRecycle;
    @BindView(R.id.rb_all2)
    CusRadioButton rbAll2;
    @BindView(R.id.rb_sort2)
    CusRadioButton rbSort2;
    @BindView(R.id.rb_location2)
    CusRadioButton rbLocation2;
    @BindView(R.id.rb_saixuan2)
    CusRadioButton rbSaixuan2;
    @BindView(R.id.ll_group2)
    LinearLayout llGroup2;
    @BindView(R.id.ll_group)
    LinearLayout llGroup;
    @BindView(R.id.scrollView)
    CusScrollView scrollView;

    HotFragmentAdapter mAdapter;

    String[] arrow = {"全部", "策划师", "摄像师", "主持人", "化妆师", "摄影师", "灯光师", "音响师"};


    private int position_all=0;


    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = LayoutInflater.from(getActivity()).inflate(R.layout.fragment_hot_layout, null);
        ButterKnife.bind(this, view);
        initViews();
        return view;
    }

    private void initViews() {
        setBanber();
        setData();
        setListHead();

        rlTodayTop.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Intent intent=new Intent(getActivity(),TebieTuijianActivity.class);
                startActivity(intent);
            }
        });
    }

    private void setListHead() {
        scrollView.setScrollViewListener(new CusScrollView.ScrollViewListener() {
            @Override
            public void onScrollChanged(CusScrollView scrollView, int x, int y, int oldx, int oldy) {

                if (y >= dip2px(getActivity(), 259)) {
                    llGroup.setVisibility(View.GONE);
                    llGroup2.setVisibility(View.VISIBLE);
                } else {
                    llGroup.setVisibility(View.VISIBLE);
                    llGroup2.setVisibility(View.GONE);
                }
            }
        });
        rbAll.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                runnable.run();
                setPop(llGroup2);
            }
        });

        rbAll2.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                setPop(llGroup2);
            }
        });

    }

    private Runnable runnable = new Runnable() {

        @Override
        public void run() {
            scrollView.scrollTo(0, dip2px(getActivity(), 259));// 改变滚动条的位置
            rbAll2.setChecked(true);
        }
    };

    private void setPop(View parent) {
        final PopupWindow pop = new PopupWindow(getActivity());
        View view = LayoutInflater.from(getActivity()).inflate(R.layout.pop_layout_arrow_list, null);
        PopView pv=new PopView(view);
        LinearLayoutManager manager=new LinearLayoutManager(getActivity()){
            @Override
            public boolean canScrollVertically() {
                // 直接禁止垂直滑动
                return false;
            }
        };
        pv.popRecycle.setLayoutManager(manager);
        PopArrowAdapter adapter=new PopArrowAdapter(getActivity(), Arrays.asList(arrow), new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int postion) {
                position_all=postion;
                rbAll.setText(arrow[postion]);
                rbAll2.setText(arrow[postion]);
                pop.dismiss();
            }
        });
        adapter.setSelect(position_all);
        pv.popRecycle.setAdapter(adapter);
        // 设置弹出窗体可点击
        pop.setFocusable(true);
        int w = getActivity().getWindowManager().getDefaultDisplay().getWidth();
        int h = (getActivity().getWindowManager().getDefaultDisplay().getHeight());
        pop.setWidth(w);
        pop.setHeight(h-(h/3));
        // 实例化一个ColorDrawable颜色为半透明
        ColorDrawable dw = new ColorDrawable(0x00000000);
        // 设置弹出窗体的背景
        pop.setBackgroundDrawable(dw);
        // 设置弹出窗体显示时的动画，从底部向上弹出
        pop.setAnimationStyle(R.style.AnimationPreview2);
        pop.setContentView(view);
        pop.update();
        pop.showAsDropDown(parent);
    }

    private void setData() {
        LinearLayoutManager manager = new LinearLayoutManager(getActivity()) {
            @Override
            public boolean canScrollVertically() {
                // 直接禁止垂直滑动
                return false;
            }
        };
        hotRecycle.setLayoutManager(manager);
        mAdapter = new HotFragmentAdapter(getActivity(), new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int postion) {
                Intent intent=new Intent(getActivity(),MallDetailsActivity.class);
                startActivity(intent);
            }
        });
        hotRecycle.setAdapter(mAdapter);

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

    @Override
    public void onDestroyView() {
        super.onDestroyView();
         
    }

    @OnClick({R.id.rl_today_top, R.id.rl_week_peo, R.id.rl_month_peo, R.id.rl_week_hot, R.id.rl_month_hot, R.id.rb_all, R.id.rb_sort, R.id.rb_location, R.id.rb_saixuan})
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.rl_today_top:
                break;
            case R.id.rl_week_peo:
                break;
            case R.id.rl_month_peo:
                break;
            case R.id.rl_week_hot:
                break;
            case R.id.rl_month_hot:
                break;
            case R.id.rb_all:
                break;
            case R.id.rb_sort:
                break;
            case R.id.rb_location:
                break;
            case R.id.rb_saixuan:
                break;
        }
    }

    //将dp转换为px
    public int dip2px(Context context, float dpValue) {
        final float scale = context.getResources().getDisplayMetrics().density;
        return (int) (dpValue * scale + 0.5f);
    }

    public void lightoff(boolean isoff) {
        WindowManager.LayoutParams lp = getActivity().getWindow().getAttributes();
        if (isoff) {
            lp.alpha = 0.3f;
        } else {
            lp.alpha = 1f;
        }
        getActivity().getWindow().setAttributes(lp);
    }

     class PopView {
        @BindView(R.id.pop_recycle)
        RecyclerView popRecycle;
        @BindView(R.id.ll_bg)
        LinearLayout llBg;

         PopView(View view) {
            ButterKnife.bind(this, view);
        }
    }
}
