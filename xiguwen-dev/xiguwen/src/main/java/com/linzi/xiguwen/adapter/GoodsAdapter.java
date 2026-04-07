package com.linzi.xiguwen.adapter;

import android.content.Context;
import android.content.Intent;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.network.Constans;
import com.linzi.xiguwen.ui.BaijiaDetailsActivity;
import com.linzi.xiguwen.utils.GlideLoad;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/2/11.
 */

public class GoodsAdapter extends RecyclerView.Adapter<GoodsAdapter.VH> {
    private int type = 0;
    private Context mContext;

    public GoodsAdapter(int type, Context mContext) {
        this.type = type;
        this.mContext = mContext;
    }

    public GoodsAdapter(int type) {
        this.type = type;
    }

    @Override
    public GoodsAdapter.VH onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_mall_index_works_layout, parent, false);
        return new GoodsAdapter.VH(view);
    }

    @Override
    public void onBindViewHolder(GoodsAdapter.VH vh, int position) {
        if (type == 0) {
            vh.tvContext.setVisibility(View.GONE);
            vh.tvSaleCount.setVisibility(View.VISIBLE);
            vh.tvSeeCount.setVisibility(View.GONE);
            vh.tvSaleCount.setText("已售 " + 100);
        } else if (type == 1) {
            vh.tvContext.setVisibility(View.VISIBLE);
            vh.tvSaleCount.setVisibility(View.GONE);
            vh.tvSeeCount.setVisibility(View.VISIBLE);
            vh.tvContext.setText("婚礼色系花案或许一些新人觉得过于花哨或是繁复，可这…");
            vh.tvSeeCount.setText("" + 100);
        }
        GlideLoad.GlideLoadImg(mContext, "http://img3.imgtn.bdimg.com/it/u=1456724845,1165243952&fm=27&gp=0.jpg", vh.ivImg);
        vh.tvTitle.setText("林子");
        vh.tvPrice.setText(Constans.RMB + 1000.0);
    }

    @Override
    public int getItemCount() {
        return 8;
    }

    class VH extends RecyclerView.ViewHolder {
        @BindView(R.id.iv_img)
        ImageView ivImg;
        @BindView(R.id.tv_title)
        TextView tvTitle;
        @BindView(R.id.tv_context)
        TextView tvContext;
        @BindView(R.id.tv_price)
        TextView tvPrice;
        @BindView(R.id.tv_sale_count)
        TextView tvSaleCount;
        @BindView(R.id.tv_see_count)
        TextView tvSeeCount;

        VH(View view) {
            super(view);
            ButterKnife.bind(this, view);

            view.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    mContext.startActivity(new Intent(mContext, BaijiaDetailsActivity.class));
                }
            });
        }
    }
}
