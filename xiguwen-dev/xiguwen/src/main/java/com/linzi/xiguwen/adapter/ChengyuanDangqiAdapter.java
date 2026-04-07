package com.linzi.xiguwen.adapter;

import android.content.Context;
import android.content.Intent;
import androidx.recyclerview.widget.RecyclerView;
import androidx.recyclerview.widget.RecyclerView.Adapter;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.CommunityScheduleEntity;
import com.linzi.xiguwen.ui.NewMallDetailsActivity;
import com.linzi.xiguwen.utils.GlideLoad;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/2/11.
 */

public class ChengyuanDangqiAdapter extends Adapter<ChengyuanDangqiAdapter.ViewHolder> {
    Context mContext;
    private List<CommunityScheduleEntity> mBens;

    public ChengyuanDangqiAdapter(Context mContext) {
        this.mContext = mContext;
    }

    public void addData(List<CommunityScheduleEntity> mBens) {
        this.mBens = mBens;
        notifyDataSetChanged();
    }

    @Override
    public ChengyuanDangqiAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_chengyuan_dangqi_layout, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(ChengyuanDangqiAdapter.ViewHolder vh, int position) {
        CommunityScheduleEntity entity = mBens.get(position);
        vh.tvName.setText(entity.getNickname() + "");
        vh.tvPrice.setText("￥" + entity.getZuidijia() + "起");
        vh.tvZhiye.setText(entity.getOccupationid() + "");
        GlideLoad.GlideLoadCircle(entity.getHead(), vh.ivHead);
    }

    @Override
    public int getItemCount() {
        return mBens == null ? 0 : mBens.size();
    }

    class ViewHolder extends RecyclerView.ViewHolder {
        @BindView(R.id.iv_head)
        ImageView ivHead;
        @BindView(R.id.tv_name)
        TextView tvName;
        @BindView(R.id.tv_zhiye)
        TextView tvZhiye;
        @BindView(R.id.tv_price)
        TextView tvPrice;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
            ivHead.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    Intent intent = new Intent(mContext, NewMallDetailsActivity.class);
                    intent.putExtra("shop_id", mBens.get(getPosition()).getUserid());
                    intent.putExtra("current",5);
                    mContext.startActivity(intent);
                }
            });
        }
    }
}
