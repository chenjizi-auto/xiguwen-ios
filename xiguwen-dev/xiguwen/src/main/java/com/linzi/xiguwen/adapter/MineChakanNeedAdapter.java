package com.linzi.xiguwen.adapter;

import android.content.Context;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/2/12.
 */

public class MineChakanNeedAdapter extends RecyclerView.Adapter<MineChakanNeedAdapter.ViewHolder> {
    Context mContext;
    com.jcodecraeer.xrecyclerview.OnItemClickListener itemClickListener;
    int tag;

    public MineChakanNeedAdapter(Context mContext,int tag, com.jcodecraeer.xrecyclerview.OnItemClickListener itemClickListener) {
        this.mContext = mContext;
        this.itemClickListener = itemClickListener;
        this.tag=tag;
    }

    @Override
    public MineChakanNeedAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_chakan_need_layout, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(MineChakanNeedAdapter.ViewHolder vh, int position) {

    }

    @Override
    public int getItemCount() {
        return 10;
    }

     class ViewHolder extends RecyclerView.ViewHolder{
        @BindView(R.id.tv_title)
        TextView tvTitle;
        @BindView(R.id.tv_price)
        TextView tvPrice;
        @BindView(R.id.tv_time)
        TextView tvTime;
        @BindView(R.id.tv_liulan)
        TextView tvLiulan;
        @BindView(R.id.tv_canyu)
        TextView tvCanyu;
        @BindView(R.id.tv_shengyushijian)
        TextView tvShengyushijian;
        @BindView(R.id.ll_location)
        TextView llLocation;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
            if(itemClickListener!=null){
                view.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        itemClickListener.onItemClick(v,getPosition());
                    }
                });
            }
        }
    }
}
