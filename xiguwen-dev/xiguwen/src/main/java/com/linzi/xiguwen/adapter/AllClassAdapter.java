package com.linzi.xiguwen.adapter;

import android.content.Context;
import android.content.Intent;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.ClassificationBean;
import com.linzi.xiguwen.bean.MenuTypeBean;
import com.linzi.xiguwen.ui.MallListByMenuActivity;
import com.linzi.xiguwen.ui.ShopListByMenuActivity;
import com.linzi.xiguwen.utils.CallBack;
import com.linzi.xiguwen.utils.GlideLoad;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2017/12/4.
 */

public class AllClassAdapter extends RecyclerView.Adapter<AllClassAdapter.ViewHolder> {
    private Context mContext;
    CallBack.OnMenuItemClickListener menuItemClickListener;
    private List<MenuTypeBean> list;
    private int type;//0婚庆1商城

    public AllClassAdapter(Context mContext, CallBack.OnMenuItemClickListener menuItemClickListener, List<MenuTypeBean> list, int type) {
        this.mContext = mContext;
        this.menuItemClickListener = menuItemClickListener;
        this.list = list;
        this.type = type;
    }

    public AllClassAdapter(Context mContext, CallBack.OnMenuItemClickListener menuItemClickListener, List<MenuTypeBean> list) {
        this.mContext = mContext;
        this.menuItemClickListener = menuItemClickListener;
        this.list = list;
    }

    public MenuTypeBean getBean(int positon) {
        return list.get(positon);
    }

    @Override
    public AllClassAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_class_layout, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(AllClassAdapter.ViewHolder vh, int position) {
        GlideLoad.GlideLoadCircle(list.get(position).getWapimg(), vh.ivIcon);
        vh.tvTitle.setText(list.get(position).getWapname() + "");

        GridLayoutManager manager = new GridLayoutManager(mContext, 4) {
            @Override
            public boolean canScrollVertically() {
                // 直接禁止垂直滑动
                return false;
            }
        };
        vh.recycle.setLayoutManager(manager);
        MenuAdapter adapter = new MenuAdapter();
        vh.recycle.setAdapter(adapter);
        adapter.setBean(list.get(position).getChildren());
    }

    @Override
    public int getItemCount() {
        return list == null ? 0 : list.size();
    }

    class ViewHolder extends RecyclerView.ViewHolder {
        @BindView(R.id.iv_icon)
        ImageView ivIcon;
        @BindView(R.id.tv_title)
        TextView tvTitle;
        @BindView(R.id.recycle)
        RecyclerView recycle;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
        }
    }

    class MenuAdapter extends RecyclerView.Adapter<MenuAdapter.ViewHolder> {
        private List<MenuTypeBean.ChildrenBean> bean;

        public void setBean(List<MenuTypeBean.ChildrenBean> bean) {
            this.bean = bean;
            this.notifyDataSetChanged();
        }

        @Override
        public MenuAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
            View view = LayoutInflater.from(mContext).inflate(R.layout.item_class_menu_layout, parent, false);
            return new ViewHolder(view);
        }

        @Override
        public void onBindViewHolder(MenuAdapter.ViewHolder vh, final int position) {
            vh.tvMenu.setText(bean.get(position).getWapname() + "");

            vh.tvMenu.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Intent intent = new Intent();
                    if (type == 0) {
                        intent.setClass(mContext, MallListByMenuActivity.class);
                    } else {
                        intent.setClass(mContext, ShopListByMenuActivity.class);
                    }
                    List<ClassificationBean> arrayListlist = new ArrayList<>();
                    for (int j = 0; j < bean.size(); j++) {
                        ClassificationBean caseTypeEntity = new ClassificationBean();
                        caseTypeEntity.setOccupationid(bean.get(j).getId());
                        caseTypeEntity.setProname(bean.get(j).getWapname());
                        arrayListlist.add(caseTypeEntity);
                    }
                    intent.putExtra("list", (Serializable) arrayListlist);
                    intent.putExtra("name", bean.get(position).getWapname());
                    intent.putExtra("id", bean.get(position).getId());
                    mContext.startActivity(intent);
                }
            });
        }

        @Override
        public int getItemCount() {
            return bean == null ? 0 : bean.size();
        }

        class ViewHolder extends RecyclerView.ViewHolder {
            @BindView(R.id.tv_menu)
            TextView tvMenu;

            ViewHolder(View view) {
                super(view);
                ButterKnife.bind(this, view);
            }
        }
    }
}
