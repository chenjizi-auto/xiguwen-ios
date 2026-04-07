package com.linzi.xiguwen.adapter;

import android.content.Context;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.CommunityDanEntity;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/2/11.
 */

public class TodayAddAdapter extends RecyclerView.Adapter<TodayAddAdapter.ViewHolder> {
    Context mContext;
    private List<CommunityDanEntity> mBens;

    public void addData(List<CommunityDanEntity> mBens) {
        this.mBens = mBens;
        notifyDataSetChanged();
    }

    public TodayAddAdapter(Context mContext) {
        this.mContext = mContext;
    }

    @Override
    public TodayAddAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_layout_today_add_team, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(TodayAddAdapter.ViewHolder vh, int position) {
//        if (position < 3) {
//            vh.ivNew.setVisibility(View.VISIBLE);
//        } else {
//            vh.ivNew.setVisibility(View.GONE);
//        }
        CommunityDanEntity entity = mBens.get(position);
        vh.tvName.setText(entity.getNickname() + "");
        vh.tvTime.setVisibility(View.GONE);
        String day;
        if (entity.getTimeslot() == 1) {
            day = "上午";
        } else if (entity.getTimeslot() == 2) {
            day = "中午";
        } else if (entity.getTimeslot() == 3) {
            day = "下午";
        } else if (entity.getTimeslot() == 4) {
            day = "晚上";
        } else if (entity.getTimeslot() == 5) {
            day = "全天";
        } else {
            day = "不接单";
        }
        vh.tvWhen.setText(entity.getDate() + " " + day + "");
    }

    @Override
    public int getItemCount() {
        return mBens == null ? 0 : mBens.size();
    }

    class ViewHolder extends RecyclerView.ViewHolder {
        @BindView(R.id.tv_name)
        TextView tvName;
        @BindView(R.id.tv_time)
        TextView tvTime;
        @BindView(R.id.iv_new)
        ImageView ivNew;
        @BindView(R.id.tv_when)
        TextView tvWhen;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
        }
    }
}
