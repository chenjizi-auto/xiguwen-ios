package com.linzi.xiguwen.adapter;

import android.content.Context;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.NewMineInvitationBean;
import com.linzi.xiguwen.utils.GlideLoad;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/1/23.
 */

public class MobanAdapter extends RecyclerView.Adapter<MobanAdapter.ViewHolder> {
    Context mContext;
    com.jcodecraeer.xrecyclerview.OnItemClickListener onItemClickListener;
    List<NewMineInvitationBean.UserBean>mList;

    public void setmList(List<NewMineInvitationBean.UserBean> mList) {
        this.mList = mList;
        this.notifyDataSetChanged();
    }

    public MobanAdapter(Context mContext, com.jcodecraeer.xrecyclerview.OnItemClickListener onItemClickListener) {
        this.mContext = mContext;
        this.onItemClickListener = onItemClickListener;
    }

    @Override
    public MobanAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.mine_item_layout_qingjian, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(MobanAdapter.ViewHolder vh, final int position) {
        GlideLoad.GlideLoadImg2(mList.get(position).getCover(), vh.ivImg);
        vh.itemView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if(onItemClickListener != null){
                        onItemClickListener.onItemClick(v, position);
                }
            }
        });
    }

    @Override
    public int getItemCount() {
        return mList==null?0:mList.size();
    }

    class ViewHolder extends RecyclerView.ViewHolder{
        @BindView(R.id.iv_img)
        ImageView ivImg;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
        }
    }
}
