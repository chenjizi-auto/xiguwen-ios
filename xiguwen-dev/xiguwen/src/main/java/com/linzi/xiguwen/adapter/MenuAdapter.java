package com.linzi.xiguwen.adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import com.bumptech.glide.Glide;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.MenuBean;
import com.linzi.xiguwen.utils.CallBack;
import com.bumptech.glide.request.RequestOptions;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2017/11/22.
 */

public class MenuAdapter extends BaseAdapter {
    private Context mContext;
    private List<MenuBean.Menu> menuBeanList;
    private CallBack.OnMenuItemClickListener mListener;

    public MenuAdapter(Context mContext, List<MenuBean.Menu> menuBeanList, CallBack.OnMenuItemClickListener mListener) {
        this.mContext = mContext;
        this.menuBeanList = menuBeanList;
        this.mListener = mListener;
    }

    @Override
    public int getCount() {
        return menuBeanList == null ? 0 : menuBeanList.size();
    }

    @Override
    public Object getItem(int i) {
        return menuBeanList.get(i);
    }

    @Override
    public long getItemId(int i) {
        return menuBeanList.get(i).getId();
    }

    @Override
    public View getView(final int i, View view, ViewGroup viewGroup) {
        ViewHolder vh;
        if (view == null) {
            view = LayoutInflater.from(mContext).inflate(R.layout.item_main_menu_grid, null);
            vh = new ViewHolder(view);
            view.setTag(vh);
        } else {
            vh = (ViewHolder) view.getTag();
        }
        if (menuBeanList.get(i).getId() == -1) {
            vh.ivIcon.setImageResource(R.mipmap.index_wedding_fenlei);
        } else {
            RequestOptions requestOptions = new RequestOptions()
                    .placeholder(R.mipmap.icon_placeholder)
                    .error(R.mipmap.load_img_erro)
                    .centerCrop();
            Glide.with(mContext)
                    .load(menuBeanList.get(i).getIcon())
                    .apply(requestOptions)
                    .into(vh.ivIcon);
        }

        vh.tvName.setText(menuBeanList.get(i).getTitle());
        view.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                mListener.itemClick(menuBeanList.get(i).getId(), menuBeanList.get(i).getTitle());
            }
        });
        return view;
    }

    class ViewHolder {
        @BindView(R.id.iv_icon)
        ImageView ivIcon;
        @BindView(R.id.tv_name)
        TextView tvName;

        ViewHolder(View view) {
            ButterKnife.bind(this, view);
        }
    }
}
