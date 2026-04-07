package com.linzi.xiguwen.adapter;

import android.content.Context;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/2/12.
 */

public class MineDangqiAdapter extends RecyclerView.Adapter<MineDangqiAdapter.ViewHolder> {
    Context mContext;
    com.jcodecraeer.xrecyclerview.OnItemClickListener itemClickListener;

    public void setItemClickListener(com.jcodecraeer.xrecyclerview.OnItemClickListener itemClickListener) {
        this.itemClickListener = itemClickListener;
    }

    public MineDangqiAdapter(Context mContext) {
        this.mContext = mContext;
    }

    @Override
    public MineDangqiAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_dangqi_layout, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(MineDangqiAdapter.ViewHolder vh, int position) {
        LinearLayoutManager manager=new LinearLayoutManager(mContext){
            @Override
            public boolean canScrollVertically() {
                return false;
            }
        };
        vh.recycle.setLayoutManager(manager);
        ItemAdapter adapter=new ItemAdapter();
        vh.recycle.setAdapter(adapter);
    }

    @Override
    public int getItemCount() {
        return 10;
    }

    class ViewHolder extends RecyclerView.ViewHolder {
        @BindView(R.id.tv_data)
        TextView tvData;
        @BindView(R.id.tv_order_num)
        TextView tvOrderNum;
        @BindView(R.id.recycle)
        RecyclerView recycle;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
        }
    }

    class ItemAdapter extends RecyclerView.Adapter<ItemAdapter.VH> {

        @Override
        public ItemAdapter.VH onCreateViewHolder(ViewGroup parent, int viewType) {
            View view = LayoutInflater.from(mContext).inflate(R.layout.item_dangqi_item_layout, parent, false);
            return new VH(view);
        }

        @Override
        public void onBindViewHolder(ItemAdapter.VH vh, int position) {

        }

        @Override
        public int getItemCount() {
            return 5;
        }

        class VH  extends RecyclerView.ViewHolder{
            @BindView(R.id.tv_when_name)
            TextView tvWhenName;
            @BindView(R.id.iv_is_tixing)
            ImageView ivIsTixing;
            @BindView(R.id.iv_is_shengcheng)
            ImageView ivIsShengcheng;

            VH(View view) {
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
}
