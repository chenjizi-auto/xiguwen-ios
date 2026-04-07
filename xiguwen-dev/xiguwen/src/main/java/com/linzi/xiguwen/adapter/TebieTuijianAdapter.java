package com.linzi.xiguwen.adapter;

import android.content.Context;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.bumptech.glide.Glide;
import com.linzi.xiguwen.R;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/1/26.
 */

public class TebieTuijianAdapter extends RecyclerView.Adapter<TebieTuijianAdapter.ViewHolder> {
    Context mContext;

    public TebieTuijianAdapter(Context mContext) {
        this.mContext = mContext;
    }

    @Override
    public TebieTuijianAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_tebie_tuijian_layout, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(TebieTuijianAdapter.ViewHolder vh, int position) {
        Glide.with(mContext).load("https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1516957237720&di=c3e5e8fef2f4bce4c84c89d0e882e97f&imgtype=0&src=http%3A%2F%2Fpic28.photophoto.cn%2F20130830%2F0005018353343927_b.jpg").into(vh.ivImg);
        vh.tvTitle.setText("酒店浪漫婚礼—刚好遇见你");
        vh.tvContext.setText("爱情，于千万人之中遇见你所要遇见的人，于千万年之中，那时间无涯的荒野里，没有早一步，也没有晚一…");
    }

    @Override
    public int getItemCount() {
        return 10;
    }

     class ViewHolder extends RecyclerView.ViewHolder{
        @BindView(R.id.iv_img)
        ImageView ivImg;
        @BindView(R.id.tv_title)
        TextView tvTitle;
        @BindView(R.id.tv_context)
        TextView tvContext;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
        }
    }
}
