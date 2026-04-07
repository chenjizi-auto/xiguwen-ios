package com.linzi.xiguwen.fragment.vm.find;

import android.graphics.drawable.ColorDrawable;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.PopupWindow;
import android.widget.TextView;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.adapter.PopArrowAdapter;
import com.linzi.xiguwen.fragment.vm.model.BaseModel;

import java.util.ArrayList;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by pc on 2018/3/28.
 */

public abstract class PopwindowVm {
    private int position_all = 0;//标记选择的item
    private TextView rbAll;
    private View parent;
    protected BaseModel mBaseModel;
    private PopArrowAdapter mAdapter;
    private ArrayList<String> mStringArrayList = new ArrayList<>();//标题list

    private PopwindowVm.RequestListDelegate mRequestListDelegate;

    public interface RequestListDelegate {
        void method();
    }

    public PopwindowVm setRequestListDelegate(PopwindowVm.RequestListDelegate requestListDelegate) {
        mRequestListDelegate = requestListDelegate;
        return this;
    }

    public PopwindowVm addModel(BaseModel model) {
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
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.find_pop_layout, null);
        PopwindowVm.PopViewHolder pv = new PopwindowVm.PopViewHolder(view);
        createAdapter(parent, pop);
        mAdapter.setSelect(position_all);
        pv.popRecycle.setAdapter(mAdapter);
        // 设置弹出窗体可点击
        pop.setFocusable(true);
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

    //创建适配器
    private void createAdapter(View parent, final PopupWindow pop) {
        mAdapter = new PopArrowAdapter(parent.getContext(), mStringArrayList, new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int postion) {
                position_all = postion;
                rbAll.setText(mStringArrayList.get(postion));
                PopwindowVm.this.onItemClick(position_all);
                if (mRequestListDelegate != null) mRequestListDelegate.method();
                pop.dismiss();
            }
        });
    }


    //绑定数据
    abstract void bindData(ArrayList<String> arrayList);

    //item点击
    abstract void onItemClick(int position);

    public void onTitleClick() {
        if (mRequestListDelegate != null) mRequestListDelegate.method();
    }

    class PopViewHolder {
        @BindView(R.id.recycleview)
        RecyclerView popRecycle;

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
