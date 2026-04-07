package com.linzi.xiguwen.adapter;

import android.content.Context;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.network.Constans;
import com.linzi.xiguwen.utils.GlideLoad;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/1/2.
 */

public class ClubWorksAdapter extends RecyclerView.Adapter<ClubWorksAdapter.ViewHolder> {
    Context mContext;
    ItemAdapter adapter;

    public ClubWorksAdapter(Context mContext) {
        this.mContext = mContext;
    }

    @Override
    public ClubWorksAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_club_works_layout, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(ClubWorksAdapter.ViewHolder vh, int position) {
        if (position == 0) {
            vh.tvShenfen.setText("管理员");
            LinearLayoutManager manager = new LinearLayoutManager(mContext) {
                @Override
                public boolean canScrollVertically() {
                    return false;
                }
            };
            vh.recycle.setLayoutManager(manager);
        } else {
            vh.tvShenfen.setText("社团成员");
            GridLayoutManager manager = new GridLayoutManager(mContext, 2) {
                @Override
                public boolean canScrollVertically() {
                    return false;
                }
            };
            vh.recycle.setLayoutManager(manager);
        }
        adapter = new ItemAdapter(position);
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
            View view = LayoutInflater.from(mContext).inflate(R.layout.item_club_works_item_layout, parent, false);
            return new VH(view);
        }

        @Override
        public void onBindViewHolder(ItemAdapter.VH vh, int position) {
            if (tag == 0) {
                vh.llCreater.setVisibility(View.VISIBLE);
                vh.llOther.setVisibility(View.GONE);
                GlideLoad.GlideLoadImg(mContext, "http://img3.imgtn.bdimg.com/it/u=1456724845,1165243952&fm=27&gp=0.jpg", vh.ivImg);
                vh.tvTitle.setText("花语园丁");
                vh.tvSee.setText("" + 200);
                vh.tvPrice.setText(Constans.RMB + 2000.0);
                vh.tvContent.setText("清晨第一缕阳光醒来时，我在想你；当阳光下第一朵小花盛开时，我在想你；当午后第一丝轻风吹过时，我…");
            } else {
                vh.llCreater.setVisibility(View.GONE);
                vh.llOther.setVisibility(View.VISIBLE);
                GlideLoad.GlideLoadImg(mContext, "http://img3.imgtn.bdimg.com/it/u=1456724845,1165243952&fm=27&gp=0.jpg", vh.ivImg2);
                vh.tvTitle2.setText("花语园丁");
                vh.tvSee2.setText("" + 200);
                vh.tvPrice2.setText(Constans.RMB + 2000.0);
                vh.tvContent2.setText("清晨第一缕阳光醒来时，我在想你；当阳光下第一朵小花盛开时，我在想你；当午后第一丝轻风吹过时，我…");
            }
        }

        @Override
        public int getItemCount() {
            int size = 0;
            if (tag == 0) {
                size = 1;
            } else {
                size = 10;
            }
            return size;
        }

        class VH extends RecyclerView.ViewHolder {
            @BindView(R.id.iv_img)
            ImageView ivImg;
            @BindView(R.id.tv_title)
            TextView tvTitle;
            @BindView(R.id.tv_see)
            TextView tvSee;
            @BindView(R.id.tv_price)
            TextView tvPrice;
            @BindView(R.id.tv_content)
            TextView tvContent;
            @BindView(R.id.ll_creater)
            LinearLayout llCreater;
            @BindView(R.id.iv_img2)
            ImageView ivImg2;
            @BindView(R.id.tv_title2)
            TextView tvTitle2;
            @BindView(R.id.tv_content2)
            TextView tvContent2;
            @BindView(R.id.tv_price2)
            TextView tvPrice2;
            @BindView(R.id.tv_see2)
            TextView tvSee2;
            @BindView(R.id.ll_other)
            LinearLayout llOther;

            VH(View view) {
                super(view);
                ButterKnife.bind(this, view);
            }
        }
    }

}
