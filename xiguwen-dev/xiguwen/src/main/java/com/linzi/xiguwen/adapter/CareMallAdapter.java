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
import com.linzi.xiguwen.bean.MerchantEntity;
import com.linzi.xiguwen.ui.NewMallDetailsActivity;
import com.linzi.xiguwen.utils.GlideLoad;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/2/3.
 */

public class CareMallAdapter extends RecyclerView.Adapter<CareMallAdapter.ViewHolder> {
    Context mContext;
    private List<MerchantEntity> mBens;

    public CareMallAdapter(Context mContext) {
        this.mContext = mContext;
    }

    public void addMore(List<MerchantEntity> bens) {
        if (bens == null || bens.isEmpty())
            return;
        if (mBens == null) {
            mBens = new ArrayList<>();
        }
        mBens.addAll(bens);
        notifyDataSetChanged();

    }

    public void addFirst(List<MerchantEntity> bens) {
        if (mBens == null) {
            mBens = new ArrayList<>();
        }
        mBens.clear();
        if (bens != null && !bens.isEmpty()) {
            mBens.addAll(bens);
        }
        notifyDataSetChanged();
    }


    @Override
    public CareMallAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.fragment_care_mall_layout, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(CareMallAdapter.ViewHolder vh, int position) {
        MerchantEntity entity = mBens.get(position);

        GlideLoad.GlideLoadCircle(mContext, entity.getHead(), vh.ivHeadImg);
        vh.tvName.setText(entity.getNickname()+"");
        vh.tvCity.setText(entity.getAddress()+"");
        vh.tvZhiye.setText(entity.getOccupationid()+"");

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
        ImageView btIsCare;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
            view.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    Intent intent = new Intent(mContext, NewMallDetailsActivity.class);
                    intent.putExtra("shop_id", mBens.get(getPosition()).getUserid());
                    mContext.startActivity(intent);
                }
            });
        }
    }
}
