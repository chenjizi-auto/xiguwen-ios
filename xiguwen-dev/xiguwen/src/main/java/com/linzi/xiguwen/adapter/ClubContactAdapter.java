package com.linzi.xiguwen.adapter;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.linzi.xiguwen.R;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/1/2.
 */

public class ClubContactAdapter extends RecyclerView.Adapter<ClubContactAdapter.ViewHolder> {
    Context mContext;

    ItemAdapter adapter;

    public ClubContactAdapter(Context mContext) {
        this.mContext = mContext;
    }

    @Override
    public ClubContactAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_club_works_layout, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(ClubContactAdapter.ViewHolder vh, int position) {
        LinearLayoutManager manager = new LinearLayoutManager(mContext) {
            @Override
            public boolean canScrollVertically() {
                return false;
            }
        };
        vh.recycle.setLayoutManager(manager);
        if (position == 0) {
            vh.tvShenfen.setText("管理员");
        } else {
            vh.tvShenfen.setText("社团成员");
        }
        adapter=new ItemAdapter(position);
        vh.recycle.setAdapter(adapter);
    }

    @Override
    public int getItemCount() {
        return 2;
    }

    class ViewHolder extends RecyclerView.ViewHolder {
        @BindView(R.id.tv_shenfen)
        TextView tvShenfen;
        @BindView(R.id.recycle)
        RecyclerView recycle;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
        }
    }

    class ItemAdapter extends RecyclerView.Adapter<ItemAdapter.VH> {
        private int tag = 0;

        public ItemAdapter(int tag) {
            this.tag = tag;
        }

        @Override
        public ItemAdapter.VH onCreateViewHolder(ViewGroup parent, int viewType) {
            View view = LayoutInflater.from(mContext).inflate(R.layout.item_club_contact_layout, parent, false);
            return new VH(view);
        }

        @Override
        public void onBindViewHolder(final ItemAdapter.VH vh, int position) {
            vh.tvName.setText("林子");
            vh.tvPhone.setText("18482180351");
            vh.ivCall.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    Intent intent = new Intent(Intent.ACTION_DIAL, Uri.parse("tel:"+vh.tvPhone.getText().toString()));
                    intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
                    mContext.startActivity(intent);
                }
            });
        }

        @Override
        public int getItemCount() {
            int size = 0;
            if (tag == 0) {
                size = 1;
            } else {
                size = 20;
            }
            return size;
        }

         class VH extends RecyclerView.ViewHolder {
            @BindView(R.id.tv_name)
            TextView tvName;
            @BindView(R.id.tv_phone)
            TextView tvPhone;
            @BindView(R.id.iv_call)
            ImageView ivCall;

            VH(View view){
                super(view);
                ButterKnife.bind(this, view);
            }
        }
    }

}
