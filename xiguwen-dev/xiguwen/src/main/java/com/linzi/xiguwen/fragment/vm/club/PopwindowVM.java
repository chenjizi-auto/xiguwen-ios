package com.linzi.xiguwen.fragment.vm.club;

import android.app.Activity;
import android.graphics.drawable.ColorDrawable;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.PopupWindow;
import android.widget.TextView;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.PopArrowAdapter;
import com.linzi.xiguwen.fragment.vm.model.BaseModel;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Title:
 * Description:
 * Copyright:Copyright(c)2018
 * Company: Cree
 * CreateTime:2018/3/22  11:30
 *
 * @author luyongjiang
 * @version 1.0
 */
public abstract class PopwindowVM {
    private List<String> data;
    private int position_all = 0;
    private String[] arrow = {"全部", "策划师", "摄像师", "主持人", "化妆师", "摄影师", "灯光师", "音响师"};
    private TextView rbAll;
    private View parent;
    protected BaseModel mBaseModel;
    private PopArrowAdapter mAdapter;

    public interface RequestListDelegate {
        void method();
    }

    private RequestListDelegate mRequestListDelegate;

    public PopwindowVM setRequestListDelegate(RequestListDelegate requestListDelegate) {
        mRequestListDelegate = requestListDelegate;
        return this;
    }

    public PopwindowVM(final View parent, TextView rbAll) {
        this.parent = parent;
        this.rbAll = rbAll;
        rbAll.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                setPop(parent);
            }
        });
    }


    public static PopwindowVM initPopwindowVM(View parent, TextView rbAll) {
        return new PopwindowVM(parent, rbAll) {
            @Override
            void bindData(ArrayList<String> arrayList) {

            }

            @Override
            void onItemClick(int position) {

            }
        };
    }

    public PopwindowVM addModel(BaseModel model) {
        this.mBaseModel = model;
        bindData(mStringArrayList);
        return this;
    }

    private void setPop(View parent) {
        if (mStringArrayList.size() == 0) {
            onTitleClick();
            return;
        }
        final PopupWindow pop = new PopupWindow(parent.getContext());
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.pop_layout_arrow_list, null);
        PopViewHolder pv = new PopViewHolder(view);
        createAdapter(parent, pop);
        mAdapter.setSelect(position_all);
        pv.popRecycle.setAdapter(mAdapter);
        // 设置弹出窗体可点击
        pop.setFocusable(true);
        int w = ((Activity) parent.getContext()).getWindowManager().getDefaultDisplay().getWidth();
        int h = (((Activity) parent.getContext()).getWindowManager().getDefaultDisplay().getHeight());
        pop.setWidth(w);
        pop.setHeight((int) (h *0.5));
        // 实例化一个ColorDrawable颜色为半透明
        ColorDrawable dw = new ColorDrawable(0x30000000);
        // 设置弹出窗体的背景
        pop.setBackgroundDrawable(dw);
        // 设置弹出窗体显示时的动画，从底部向上弹出
        pop.setAnimationStyle(R.style.AnimationPreview2);
        pop.setContentView(view);
        pop.update();
        pop.showAsDropDown(parent);
    }

    private void createAdapter(View parent, final PopupWindow pop) {
        mAdapter = new PopArrowAdapter(parent.getContext(), mStringArrayList, new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int postion) {
                position_all = postion;
                rbAll.setText(mStringArrayList.get(postion));
                PopwindowVM.this.onItemClick(position_all);
                if (mRequestListDelegate != null) mRequestListDelegate.method();
                pop.dismiss();
            }
        });
    }


    private ArrayList<String> mStringArrayList = new ArrayList<>();

    abstract void bindData(ArrayList<String> arrayList);

    abstract void onItemClick(int position);

    public void onTitleClick() {
        if (mRequestListDelegate != null) mRequestListDelegate.method();
    }

    class PopViewHolder {
        @BindView(R.id.pop_recycle)
        RecyclerView popRecycle;
        @BindView(R.id.ll_bg)
        LinearLayout llBg;

        PopViewHolder(View view) {
            ButterKnife.bind(this, view);
            init();
        }

        private void init() {
            LinearLayoutManager manager = new LinearLayoutManager(parent.getContext());
            popRecycle.setLayoutManager(manager);
        }
    }
}
