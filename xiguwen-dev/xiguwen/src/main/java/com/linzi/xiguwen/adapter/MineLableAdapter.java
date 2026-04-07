package com.linzi.xiguwen.adapter;

import android.content.Context;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.MineLableBean;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/2/2.
 */

public class MineLableAdapter extends RecyclerView.Adapter<MineLableAdapter.ViewHolder> {
    Context mContext;
    List<MineLableBean> mList;
    com.jcodecraeer.xrecyclerview.OnItemClickListener itemClickListener;

    public MineLableAdapter(Context mContext, com.jcodecraeer.xrecyclerview.OnItemClickListener itemClickListener) {
        this.mContext = mContext;
        this.itemClickListener = itemClickListener;
    }

    @Override
    public MineLableAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_mine_fragment_layout, parent, false);
        return new ViewHolder(view);
    }

    public void setData(List<MineLableBean> mList) {
        this.mList = mList;
        this.notifyDataSetChanged();
    }

    @Override
    public void onBindViewHolder(MineLableAdapter.ViewHolder vh, int position) {
        vh.ivIcon.setBackgroundResource(mList.get(position).getUrl());
        vh.tvTitle.setText(mList.get(position).getTitle());
    }

    @Override
    public int getItemCount() {
        return mList == null ? 0 : mList.size();
    }

    class ViewHolder extends RecyclerView.ViewHolder {
        @BindView(R.id.iv_icon)
        ImageView ivIcon;
        @BindView(R.id.tv_title)
        TextView tvTitle;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
            if (itemClickListener != null) {
                view.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        itemClickListener.onItemClick(view, getPosition());
                    }
                });
            }
        }
    }

}
