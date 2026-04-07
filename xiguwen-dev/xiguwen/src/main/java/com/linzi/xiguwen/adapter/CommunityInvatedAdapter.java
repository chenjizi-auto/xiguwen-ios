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
import com.linzi.xiguwen.bean.CommuntiyInvitationEntity;
import com.linzi.xiguwen.utils.GlideLoad;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * 邀请成员
 * Created by PC on 2018-04-21.
 */

public class CommunityInvatedAdapter extends RecyclerView.Adapter<CommunityInvatedAdapter.ViewHolder> {
    Context mContext;
    com.jcodecraeer.xrecyclerview.OnItemClickListener1 itemClickListener;

    List<CommuntiyInvitationEntity> mList;

    public void setmList(List<CommuntiyInvitationEntity> mList) {
        this.mList = mList;
        notifyDataSetChanged();
    }

    public void setItemClickListener(com.jcodecraeer.xrecyclerview.OnItemClickListener1 itemClickListener) {
        this.itemClickListener = itemClickListener;
    }

    public CommunityInvatedAdapter(Context mContext) {
        this.mContext = mContext;

    }


    @Override
    public CommunityInvatedAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_invated_new_peo_layout, parent, false);
        return new CommunityInvatedAdapter.ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(CommunityInvatedAdapter.ViewHolder vh, final int position) {

        final CommuntiyInvitationEntity entity = mList.get(position);

        GlideLoad.GlideLoadCircle(entity.getHead(), vh.ivHead);
        vh.tvName.setText(entity.getNickname() + "");
        vh.tvPhone.setText(entity.getMobile() + "");
        vh.tvZhiwei.setText(entity.getOccupationid() + "");

        vh.btInvated.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (itemClickListener != null) {
                    itemClickListener.onItemClick(v, position, entity);
                }

            }
        });
    }

    @Override
    public int getItemCount() {
        return mList == null ? 0 : mList.size();
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
        @BindView(R.id.bt_invated)
        Button btInvated;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
        }
    }

}
