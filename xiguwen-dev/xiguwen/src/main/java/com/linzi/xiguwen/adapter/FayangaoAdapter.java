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
import com.linzi.xiguwen.bean.FaYanGaoBean;
import com.linzi.xiguwen.utils.CallBack;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/1/25.
 */

public class FayangaoAdapter extends RecyclerView.Adapter<FayangaoAdapter.ViewHolder> {
    private final List<FaYanGaoBean> mData;
    Context mContext;
    CallBack.FayangaoEditListener editListener;
    CallBack.FayangaoDelListener delListener;
    com.jcodecraeer.xrecyclerview.OnItemClickListener itemClickListener;

    public FayangaoAdapter(Context mContext, List<FaYanGaoBean> datas, CallBack.FayangaoEditListener editListener, CallBack.FayangaoDelListener delListener, com.jcodecraeer.xrecyclerview.OnItemClickListener itemClickListener) {
        this.mContext = mContext;
        this.mData = datas;
        this.editListener = editListener;
        this.delListener = delListener;
        this.itemClickListener = itemClickListener;
    }

    @Override
    public FayangaoAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_fayangao_layout, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(FayangaoAdapter.ViewHolder vh, final int position) {
        FaYanGaoBean data = mData.get(position);
        vh.tvTitle.setText(data.getTitle());
        vh.tvType.setText("");
        vh.tvContext.setText(data.getContent());
        if(delListener!=null){
            vh.ivDel.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    delListener.delListener(position);
                }
            });
        }
        if(editListener!=null){
            vh.ivEdit.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    editListener.editListener(position);
                }
            });
        }
    }

    @Override
    public int getItemCount() {
        return mData == null ? 0 : mData.size();
    }

     class ViewHolder extends RecyclerView.ViewHolder{
        @BindView(R.id.tv_title)
        TextView tvTitle;
        @BindView(R.id.tv_type)
        TextView tvType;
        @BindView(R.id.iv_del)
        ImageView ivDel;
        @BindView(R.id.iv_edit)
        ImageView ivEdit;
        @BindView(R.id.tv_context)
        TextView tvContext;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
            if(itemClickListener!=null){
                view.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        itemClickListener.onItemClick(view,getPosition());
                    }
                });
            }
        }
    }
}
