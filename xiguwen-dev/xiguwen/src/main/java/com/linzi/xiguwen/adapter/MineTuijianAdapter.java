package com.linzi.xiguwen.adapter;

import android.content.Context;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.RecommendedTeam;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/2/12.
 */

public class MineTuijianAdapter extends RecyclerView.Adapter<MineTuijianAdapter.ViewHolder> {
    Context mContext;
    com.jcodecraeer.xrecyclerview.OnItemClickListener itemClickListener;
    private List<RecommendedTeam> mDatas;

    public MineTuijianAdapter(Context mContext, List<RecommendedTeam> datas, com.jcodecraeer.xrecyclerview.OnItemClickListener itemClickListener) {
        this.mContext = mContext;
        this.itemClickListener = itemClickListener;
        this.mDatas = datas;
    }

    @Override
    public MineTuijianAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_mine_tuijian_layout, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(MineTuijianAdapter.ViewHolder vh, int position) {
        RecommendedTeam team = mDatas.get(position);
        vh.tvDianpuNum.setText(team.getShopcode());
        vh.tvName.setText(team.getNickname());
        vh.tvWeight.setText(team.getWeight() + "");
    }

    @Override
    public int getItemCount() {
        return mDatas == null ? 0 : mDatas.size();
    }

     class ViewHolder extends RecyclerView.ViewHolder{
        @BindView(R.id.tv_dianpu_num)
        TextView tvDianpuNum;
        @BindView(R.id.tv_name)
        TextView tvName;
        @BindView(R.id.tv_weight)
        TextView tvWeight;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
        }
    }
}
