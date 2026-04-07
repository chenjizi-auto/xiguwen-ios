package com.linzi.xiguwen.adapter;

import android.content.Context;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.YuEDetailEntity;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/2/4.
 */

public class YuEDetailsAdapter extends RecyclerView.Adapter<YuEDetailsAdapter.ViewHolder> {
    private Context mContext;
    private List<YuEDetailEntity> mBens;

    public YuEDetailsAdapter(Context mContext) {
        this.mContext = mContext;
    }

    public void addMore(List<YuEDetailEntity> bens) {
        if (bens == null)
            return;
        if (mBens == null) {
            mBens = new ArrayList<>();
        }
        mBens.addAll(bens);
        notifyDataSetChanged();

    }

    public void addFirst(List<YuEDetailEntity> bens) {
        if (mBens == null) {
            mBens = new ArrayList<>();
        }
        mBens.clear();
        mBens.addAll(bens);
        notifyDataSetChanged();
    }

    @Override
    public YuEDetailsAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_mine_yue_details, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(YuEDetailsAdapter.ViewHolder vh, int position) {
        YuEDetailEntity entity = mBens.get(position);
        vh.tvType.setText(entity.getSubject() + "");
        vh.tvDate.setText(entity.getCreated_at() + "");
        vh.tvYue.setText("余额：" + entity.getAftermoney());

        if (entity.getTrade_type() == 1) {
            vh.tvCount.setText("+" + entity.getInmoney());
        } else {
            vh.tvCount.setText("-" + entity.getOutmoney());
        }
    }

    @Override
    public int getItemCount() {
        return mBens == null ? 0 : mBens.size();
    }

    class ViewHolder extends RecyclerView.ViewHolder {
        @BindView(R.id.tv_type)
        TextView tvType;
        @BindView(R.id.tv_date)
        TextView tvDate;
        @BindView(R.id.tv_yue)
        TextView tvYue;
        @BindView(R.id.tv_count)
        TextView tvCount;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
        }
    }
}
