package com.linzi.xiguwen.adapter;

import android.content.Context;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.utils.CallBack;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/2/12.
 */

public class BYXYVideoFragmentAdapter extends RecyclerView.Adapter<BYXYVideoFragmentAdapter.ViewHolder> {
    Context mContext;
    CallBack.MoreListener moreListener;

    public void setMoreListener(CallBack.MoreListener moreListener) {
        this.moreListener = moreListener;
    }

    public BYXYVideoFragmentAdapter(Context mContext) {
        this.mContext = mContext;
    }

    @Override
    public BYXYVideoFragmentAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_byxy_video_layout, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(BYXYVideoFragmentAdapter.ViewHolder vh, final int position) {
        vh.tvBiaoqian.setText("热门");
        if (moreListener != null) {
            vh.llMore.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    moreListener.more(position);
                }
            });
        }
        GridLayoutManager manager=new GridLayoutManager(mContext,2){
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
        @BindView(R.id.tv_biaoqian)
        TextView tvBiaoqian;
        @BindView(R.id.ll_more)
        LinearLayout llMore;
        @BindView(R.id.recycle)
        RecyclerView recycle;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
        }
    }

    public class ItemAdapter extends RecyclerView.Adapter<ItemAdapter.ViewHolder> {

        @Override
        public ItemAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
            View view = LayoutInflater.from(mContext).inflate(R.layout.item_byxy_video_item, parent, false);
            return new ViewHolder(view);
        }

        @Override
        public void onBindViewHolder(ItemAdapter.ViewHolder vh, int position) {

        }

        @Override
        public int getItemCount() {
            return 4;
        }

        class ViewHolder extends RecyclerView.ViewHolder {
            @BindView(R.id.iv_head)
            ImageView ivHead;
            @BindView(R.id.iv_is_vip)
            ImageView ivIsVip;
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
}
