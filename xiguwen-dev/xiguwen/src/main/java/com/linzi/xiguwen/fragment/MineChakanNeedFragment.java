package com.linzi.xiguwen.fragment;

import android.content.Intent;
import android.graphics.drawable.ColorDrawable;
import android.os.Bundle;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.PopupWindow;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.MineChakanNeedAdapter;
import com.linzi.xiguwen.adapter.PopArrowAdapter;
import com.linzi.xiguwen.base.BaseFragment;
import com.linzi.xiguwen.ui.MainNeedDetailsActivity;
import com.linzi.xiguwen.view.CusRadioButton;

import java.util.Arrays;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

/**
 * Created by jiang on 2017/12/11.
 */

public class MineChakanNeedFragment extends BaseFragment {

    @BindView(R.id.rb_all)
    CusRadioButton rbAll;
    @BindView(R.id.rb_sort)
    CusRadioButton rbSort;
    @BindView(R.id.rb_location)
    CusRadioButton rbLocation;
    @BindView(R.id.rb_saixuan)
    CusRadioButton rbSaixuan;
    @BindView(R.id.ll_group)
    LinearLayout llGroup;
    @BindView(R.id.recycle)
    RecyclerView recycle;
    private int flag = -1;

    private boolean isPrepare = false;

    String[] arrow = {"全部", "策划师", "摄像师", "主持人", "化妆师", "摄影师", "灯光师", "音响师"};
    private int position_all=0;

    MineChakanNeedAdapter mAdapter;


    public static MineChakanNeedFragment newInstance(int FLAG) {
        Bundle args = new Bundle();
        args.putInt("type", FLAG);
        MineChakanNeedFragment fragment = new MineChakanNeedFragment();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View view = LayoutInflater.from(getActivity()).inflate(R.layout.fragment_mine_chakan_need, null);
        ButterKnife.bind(this, view);
        return view;
    }

    @Override
    public void onActivityCreated(Bundle savedInstanceState) {
        super.onActivityCreated(savedInstanceState);
        initViews();
    }

    private void initViews() {
        Bundle bu = getArguments();
        flag = bu.getInt("type");

        LinearLayoutManager manager = new LinearLayoutManager(getActivity());
//        recycleView.setRefreshProgressStyle(ProgressStyle.BallTrianglePath);
//        recycleView.setLoadingMoreProgressStyle(ProgressStyle.BallScaleRipple);
//        recycleView.setLoadingMoreEnabled(true);
        recycle.setLayoutManager(manager);
        mAdapter = new MineChakanNeedAdapter(getActivity(), flag, new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int postion) {
                Intent intent = new Intent(getActivity(), MainNeedDetailsActivity.class);
                intent.putExtra("tag", flag);
                startActivity(intent);
            }
        });
        recycle.setAdapter(mAdapter);
    }

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
                pop.dismiss();
            }
        });
        adapter.setSelect(0);
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

    @Override
    protected void lazyLoad() {
        if (!isVisible || !isPrepare) {
            return;
        }
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
         
    }

    @OnClick({R.id.rb_all, R.id.rb_sort, R.id.rb_location, R.id.rb_saixuan})
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.rb_all:
                setPop(view);
                break;
            case R.id.rb_sort:
                break;
            case R.id.rb_location:
                break;
            case R.id.rb_saixuan:
                break;
        }
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
