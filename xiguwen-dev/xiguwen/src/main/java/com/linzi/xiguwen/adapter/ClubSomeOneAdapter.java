package com.linzi.xiguwen.adapter;

import android.content.Context;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.network.Constans;
import com.linzi.xiguwen.utils.GlideLoad;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2017/12/21.
 */

public class ClubSomeOneAdapter extends RecyclerView.Adapter<ClubSomeOneAdapter.ViewHolder> {
    Context mContext;

    public ClubSomeOneAdapter(Context mContext) {
        this.mContext = mContext;
    }

    @Override
    public ClubSomeOneAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_club_someone_layout, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(ClubSomeOneAdapter.ViewHolder vh, int position) {
        LinearLayoutManager manager = new LinearLayoutManager(mContext) {
            @Override
            public boolean canScrollVertically() {
                return false;
            }
        };
        vh.recycle.setLayoutManager(manager);
        PeoAdapter adapter;
        switch (position) {
            case 0:
                vh.tvZhiwei.setText("创始人");
                adapter=new PeoAdapter(1);
                vh.recycle.setAdapter(adapter);
                break;
            case 1:
                vh.tvZhiwei.setText("社团成员");
                adapter=new PeoAdapter(10);
                vh.recycle.setAdapter(adapter);
                break;
        }
    }

    @Override
    public int getItemCount() {
        return 2;
    }

    class ViewHolder extends RecyclerView.ViewHolder {
        @BindView(R.id.tv_zhiwei)
        TextView tvZhiwei;
        @BindView(R.id.recycle)
        RecyclerView recycle;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
        }
    }

    class PeoAdapter extends RecyclerView.Adapter<PeoAdapter.VH> {
        int size = 0;

        public PeoAdapter(int size) {
            this.size = size;
        }

        @Override
        public PeoAdapter.VH onCreateViewHolder(ViewGroup parent, int viewType) {
            View view = LayoutInflater.from(mContext).inflate(R.layout.item_club_someone_item, parent, false);
            return new VH(view);
        }

        @Override
        public void onBindViewHolder(PeoAdapter.VH vh, int position) {
            GlideLoad.GlideLoadCircle(mContext, "http://img0.imgtn.bdimg.com/it/u=1950620400,3641542324&fm=27&gp=0.jpg", vh.ivHead);
            vh.tvName.setText("林子");
            vh.tvZhiwu.setText("策划师");
            vh.tvPrice.setText(Constans.RMB+2000.00+"起");
        }

        @Override
        public int getItemCount() {
            return size;
        }

        class VH extends RecyclerView.ViewHolder {
            @BindView(R.id.iv_head)
            ImageView ivHead;
            @BindView(R.id.tv_name)
            TextView tvName;
            @BindView(R.id.tv_zhiwu)
            TextView tvZhiwu;
            @BindView(R.id.tv_price)
            TextView tvPrice;

            VH(View view) {
                super(view);
                ButterKnife.bind(this, view);
            }
        }
    }
}
