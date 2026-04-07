package com.linzi.xiguwen.adapter;

import android.content.Context;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.InvitationsTemplateBean;
import com.linzi.xiguwen.utils.GlideLoad;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/1/23.
 */

public class Moban2Adapter extends RecyclerView.Adapter<Moban2Adapter.ViewHolder> {
    Context mContext;
    com.jcodecraeer.xrecyclerview.OnItemClickListener onItemClickListener;
    List<InvitationsTemplateBean.DataBean> mList;

    public void setmList(List<InvitationsTemplateBean.DataBean> mList) {
        this.mList = mList;
        this.notifyDataSetChanged();
    }

    public Moban2Adapter(Context mContext, com.jcodecraeer.xrecyclerview.OnItemClickListener onItemClickListener) {
        this.mContext = mContext;
        this.onItemClickListener = onItemClickListener;
    }

    @Override
    public Moban2Adapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_layout_qingjian, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(Moban2Adapter.ViewHolder vh, int position) {
        GlideLoad.GlideLoadImg2(mList.get(position).getCover(), vh.ivImg);
        vh.tvName.setText(mList.get(position).getTitle());
    }

    @Override
    public int getItemCount() {
        return mList == null ? 0 : mList.size();
    }

    class ViewHolder extends RecyclerView.ViewHolder {
        @BindView(R.id.iv_img)
        ImageView ivImg;
        @BindView(R.id.tv_name)
        TextView tvName;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
            if (onItemClickListener != null) {
                view.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        onItemClickListener.onItemClick(view, getPosition());
                    }
                });
            }
        }
    }
}
