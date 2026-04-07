package com.linzi.xiguwen.adapter;

import android.content.Context;
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
 * Created by jiang on 2017/12/11.
 */

public class GuessLoveGoodsAdapter extends RecyclerView.Adapter<GuessLoveGoodsAdapter.ViewHolder> {
    Context mContext;

    public GuessLoveGoodsAdapter(Context mContext) {
        this.mContext = mContext;
    }

    @Override
    public GuessLoveGoodsAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_guess_goods_layout, parent, false);

        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(GuessLoveGoodsAdapter.ViewHolder vh, int position) {
        GlideLoad.GlideLoadImg(mContext, "http://img3.imgtn.bdimg.com/it/u=1456724845,1165243952&fm=27&gp=0.jpg", vh.ivImg);
        vh.tvGoodsName.setText("秋冬新品！2017新款中式立领结婚嫁衣秀禾服订婚回…");
        vh.tvLab1.setText("中式立领");
        vh.tvLab2.setText("汉服");
        vh.tvPrice.setText(Constans.RMB+2000);
        vh.tvNumLove.setText(100+"人喜欢");
        vh.tvLocation.setText("成都");
    }

    @Override
    public int getItemCount() {
        return 15;
    }

    class ViewHolder extends RecyclerView.ViewHolder{
        @BindView(R.id.iv_img)
        ImageView ivImg;
        @BindView(R.id.tv_goods_name)
        TextView tvGoodsName;
        @BindView(R.id.tv_lab1)
        TextView tvLab1;
        @BindView(R.id.tv_lab2)
        TextView tvLab2;
        @BindView(R.id.tv_price)
        TextView tvPrice;
        @BindView(R.id.tv_num_love)
        TextView tvNumLove;
        @BindView(R.id.tv_location)
        TextView tvLocation;
        @BindView(R.id.tv_into_mall)
        TextView tvIntoMall;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
        }
    }
}
