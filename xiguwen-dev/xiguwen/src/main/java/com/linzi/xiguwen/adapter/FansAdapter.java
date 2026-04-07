package com.linzi.xiguwen.adapter;

import android.content.Context;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.FensEntity;
import com.linzi.xiguwen.utils.CallBack;
import com.linzi.xiguwen.utils.GlideLoad;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/2/3.
 */

public class FansAdapter extends RecyclerView.Adapter<FansAdapter.ViewHolder> {
    Context mContext;

    private List<FensEntity> mBens;
    private CallBack.CaseCareClikListener careClikListener;

    public FansAdapter(Context mContext) {
        this.mContext = mContext;

    }

    public void setCareClikListener(CallBack.CaseCareClikListener careClikListener) {
        this.careClikListener = careClikListener;
    }

    public void addMore(List<FensEntity> bens) {
        if (bens == null)
            return;
        if (mBens == null) {
            mBens = new ArrayList<>();
        }
        mBens.addAll(bens);
        notifyDataSetChanged();

    }

    public void addFirst(List<FensEntity> bens) {
        if (mBens == null) {
            mBens = new ArrayList<>();
        }
        mBens.clear();
        mBens.addAll(bens);
        notifyDataSetChanged();
    }

    public List<FensEntity> getDatas() {
        return mBens;
    }


    @Override
    public FansAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_fans_layout, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(FansAdapter.ViewHolder vh, final int position) {
        FensEntity entity = mBens.get(position);
        GlideLoad.GlideLoadCircle(mContext, entity.getHead(), vh.ivHeadImg);
        vh.tvName.setText(entity.getNickname() + "");
        vh.tvCity.setText(entity.getDiqu() + "");
        vh.tvZhiye.setText(entity.getOccupationid() == null ? "" : entity.getOccupationid());
        if (entity.getFollow() == 1) {
            vh.btIsCare.setBackgroundResource(R.mipmap.icon_close_care);
        } else {
            vh.btIsCare.setBackgroundResource(R.mipmap.icon_add_care);
        }

        vh.btIsCare.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (careClikListener != null) {
                    careClikListener.CaseCareClik(position);
                }
            }
        });
    }

    @Override
    public int getItemCount() {
        return mBens == null ? 0 : mBens.size();
    }

    class ViewHolder extends RecyclerView.ViewHolder {
        @BindView(R.id.iv_head_img)
        ImageView ivHeadImg;
        @BindView(R.id.tv_name)
        TextView tvName;
        @BindView(R.id.tv_zhiye)
        TextView tvZhiye;
        @BindView(R.id.tv_city)
        TextView tvCity;
        @BindView(R.id.bt_is_care)
        Button btIsCare;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
        }
    }
}
