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
import com.linzi.xiguwen.bean.ListPeoBean;
import com.linzi.xiguwen.utils.GlideLoad;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/2/11.
 */

public class InvatedNewAdapter extends RecyclerView.Adapter<InvatedNewAdapter.ViewHolder> {
    Context mContext;
    int tag = 0;
    com.jcodecraeer.xrecyclerview.OnItemClickListener itemClickListener;

    List<ListPeoBean> mList;

    public void setmList(List<ListPeoBean> mList) {
        this.mList = mList;
    }

    public void setItemClickListener(com.jcodecraeer.xrecyclerview.OnItemClickListener itemClickListener) {
        this.itemClickListener = itemClickListener;
    }

    public InvatedNewAdapter(Context mContext, int tag) {
        this.mContext = mContext;
        this.tag = tag;
    }


    @Override
    public InvatedNewAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_invated_new_peo_layout, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(InvatedNewAdapter.ViewHolder vh, final int position) {
        if(tag==0){
            vh.tvZhiwei.setVisibility(View.VISIBLE);
        }else{
            vh.tvZhiwei.setVisibility(View.GONE);
            GlideLoad.GlideLoadCircle(mContext,R.mipmap.app_icon,vh.ivHead);
            vh.tvName.setText(mList.get(position).getName());
            vh.tvPhone.setText(mList.get(position).getPhone());
        }

        vh.btInvated.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                itemClickListener.onItemClick(v,position);
            }
        });
    }

    @Override
    public int getItemCount() {
        int size=0;
        if(tag==0){
           size=10;
        }else{
            size=(mList==null?0:mList.size());
        }
        return size;
    }

     class ViewHolder extends RecyclerView.ViewHolder{
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
