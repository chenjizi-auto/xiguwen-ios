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
 * Created by jiang on 2018/1/29.
 */

public class ForTuijianAdapter extends RecyclerView.Adapter<ForTuijianAdapter.ViewHolder> {
    Context mContext;

    public ForTuijianAdapter(Context mContext) {
        this.mContext = mContext;
    }

    @Override
    public ForTuijianAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_for_tuijian_layout, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(ForTuijianAdapter.ViewHolder vh, int position) {
        GlideLoad.GlideLoadImg(mContext,"http://pic41.nipic.com/20140503/18641501_163214498000_2.jpg",vh.ivImg);
        vh.tvTitle.setText("熙子");
        vh.tvZhiwei.setText("策划师");
        vh.tvPrice.setText(Constans.RMB+"2000");
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
        @BindView(R.id.tv_zhiwei)
        TextView tvZhiwei;
        @BindView(R.id.tv_price)
        TextView tvPrice;
        @BindView(R.id.iv_cx)
        ImageView ivCx;
        @BindView(R.id.iv_pt)
        ImageView ivPt;
        @BindView(R.id.iv_xy)
        ImageView ivXy;
        @BindView(R.id.tv_haoping)
        TextView tvHaoping;
        @BindView(R.id.tv_pinglun_count)
        TextView tvPinglunCount;
        @BindView(R.id.tv_renshu)
        TextView tvRenshu;
        @BindView(R.id.iv_vip)
        ImageView ivVip;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
        }
    }
}
