package com.linzi.xiguwen.adapter;

import android.content.Context;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.CommunityUserEntity;
import com.linzi.xiguwen.utils.GlideLoad;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/2/11.
 */

public class DaiTongGuoAdapter extends RecyclerView.Adapter<DaiTongGuoAdapter.ViewHolder> {
    Context mContext;
    com.jcodecraeer.xrecyclerview.OnItemClickListener1 agreeListener;
    com.jcodecraeer.xrecyclerview.OnItemClickListener1 refuseListener;
    private List<CommunityUserEntity> mBens;

    public void addMore(List<CommunityUserEntity> bens) {
        if (bens == null)
            return;
        if (mBens == null) {
            mBens = new ArrayList<>();
        }
        mBens.addAll(bens);
        notifyDataSetChanged();

    }

    public void addFirst(List<CommunityUserEntity> bens) {
        if (mBens == null) {
            mBens = new ArrayList<>();
        }
        mBens.clear();
        mBens.addAll(bens);
        notifyDataSetChanged();
    }

    public void setAgreeListener(com.jcodecraeer.xrecyclerview.OnItemClickListener1 agreeListener) {
        this.agreeListener = agreeListener;
    }

    public void setRefuseListener(com.jcodecraeer.xrecyclerview.OnItemClickListener1 refuseListener) {
        this.refuseListener = refuseListener;
    }

    public DaiTongGuoAdapter(Context mContext) {
        this.mContext = mContext;
    }

    public void remove(int position) {
        if (mBens != null) {
            mBens.remove(position);
            notifyDataSetChanged();
        }

    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_dai_tong_guo_layout, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(ViewHolder vh, final int position) {
        final CommunityUserEntity entity = mBens.get(position);
        vh.tvName.setText(entity.getNickname() + "");
        vh.tvPhone.setText(entity.getDizhi() + "");
        vh.tvZhiwei.setText(entity.getOccupationid() + "");
        GlideLoad.GlideLoadCircle(entity.getHead(), vh.ivHead);

        vh.btDisargee.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (refuseListener != null) {
                    refuseListener.onItemClick(v, position, entity);
                }
            }
        });
        vh.btArgee.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (agreeListener != null) {
                    agreeListener.onItemClick(v, position, entity);
                }
            }
        });
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
        @BindView(R.id.tv_zhiwei)
        TextView tvZhiwei;
        @BindView(R.id.tv_phone)
        TextView tvPhone;
        @BindView(R.id.bt_argee)
        Button btArgee;
        @BindView(R.id.bt_disargee)
        Button btDisargee;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
        }
    }

}
