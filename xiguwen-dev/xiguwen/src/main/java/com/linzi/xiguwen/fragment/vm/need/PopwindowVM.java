package com.linzi.xiguwen.fragment.vm.need;


import android.app.Activity;
import android.graphics.Rect;
import android.graphics.drawable.ColorDrawable;
import android.os.Build;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.PopupWindow;
import android.widget.TextView;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.PopArrowAdapter4;
import com.linzi.xiguwen.fragment.vm.model.BaseModel;
import com.linzi.xiguwen.fragment.vm.need.bean.BaseBean;

import java.util.ArrayList;

import butterknife.BindView;
import butterknife.ButterKnife;


public abstract class PopwindowVM {
    private int position_all = 0;
    private TextView rbAll;
    private View parent;
    protected BaseModel mBaseModel;
    protected PopArrowAdapter4 mAdapter;

    public interface RequestListDelegate {
        void method(BaseBean baseBean);
    }

    private PopwindowVM.RequestListDelegate mRequestListDelegate;

    public PopwindowVM setRequestListDelegate(PopwindowVM.RequestListDelegate requestListDelegate) {
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

    public PopwindowVM addModel(BaseModel model) {
        this.mBaseModel = model;
        bindData(mStringArrayList);
        return this;
    }

    private void setPop(View parent) {
        if (mStringArrayList.size() == 0) {
            return;
        }
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.pop_layout_arrow_list2, null);
//        final PopupWindow pop = new PopupWindow(parent.getContext());
        PopwindowVM.PopViewHolder pv = new PopwindowVM.PopViewHolder(view);
        final PopupWindow pop = new PopupWindow(view, ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT){
            @Override
            public void showAsDropDown(View anchor) {
                if(Build.VERSION.SDK_INT == 24) {
                    Rect rect = new Rect();
                    anchor.getGlobalVisibleRect(rect);
                    int h = anchor.getResources().getDisplayMetrics().heightPixels - rect.bottom;
                    setHeight(h);
                }
                super.showAsDropDown(anchor);
            }
            @Override
            public void showAsDropDown(View anchor, int xoff, int yoff) {
                if(Build.VERSION.SDK_INT == 24) {
                    Rect rect = new Rect();
                    anchor.getGlobalVisibleRect(rect);
                    int h = anchor.getResources().getDisplayMetrics().heightPixels - rect.bottom;
                    setHeight(h);
                }
                super.showAsDropDown(anchor, xoff, yoff);
            }
        };
        view.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                pop.dismiss();
            }
        });
        createAdapter(parent, pop);
        mAdapter.setSelect(position_all);
        pv.popRecycle.setAdapter(mAdapter);
        // 设置弹出窗体可点击
        pop.setFocusable(true);
        int w = ((Activity) parent.getContext()).getWindowManager().getDefaultDisplay().getWidth();
        int h = (((Activity) parent.getContext()).getWindowManager().getDefaultDisplay().getHeight());
        //pop.setWidth(w);
        //pop.setHeight((int) (h *0.5));
        // 实例化一个ColorDrawable颜色为半透明
        ColorDrawable dw = new ColorDrawable(0x30000000);
        // 设置弹出窗体的背景
        pop.setBackgroundDrawable(dw);
        // 设置弹出窗体显示时的动画，从底部向上弹出
        pop.setAnimationStyle(R.style.AnimationPreview2);
        pop.setContentView(view);
        pop.update();
        pop.setOutsideTouchable(true);
        pop.showAsDropDown(parent);
    }

    private void createAdapter(View parent, final PopupWindow pop) {
        mAdapter = new PopArrowAdapter4(parent.getContext(), mStringArrayList, new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int postion) {
                position_all = postion;
                rbAll.setText(mStringArrayList.get(postion).getName());
                PopwindowVM.this.onItemClick(position_all);
                if (mRequestListDelegate != null) mRequestListDelegate.method(mStringArrayList.get(position_all));
                pop.dismiss();
            }
        });
    }


    private ArrayList<BaseBean> mStringArrayList = new ArrayList<>();

    abstract void bindData(ArrayList<BaseBean> arrayList);

    abstract void onItemClick(int position);


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
