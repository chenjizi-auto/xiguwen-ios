package com.linzi.xiguwen.adapter;

import android.content.Context;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.WeddingFlowBean;
import com.linzi.xiguwen.utils.CallBack;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/2/12.
 */

public class HunliLiuchengAdapter extends RecyclerView.Adapter<HunliLiuchengAdapter.ViewHolder> {
    private final List<WeddingFlowBean> mDatas;
    Context mContex;
    CallBack.EditListener editListener;
    CallBack.DelListener delListener;

    public HunliLiuchengAdapter(Context mContex, List<WeddingFlowBean> datas) {
        this.mContex = mContex;
        this.mDatas = datas;
    }

    public void setEditListener(CallBack.EditListener editListener) {
        this.editListener = editListener;
    }

    public void setDelListener(CallBack.DelListener delListener) {
        this.delListener = delListener;
    }

    @Override
    public HunliLiuchengAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContex).inflate(R.layout.item_hunli_liucheng, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(HunliLiuchengAdapter.ViewHolder vh, final int position) {
        if(editListener!=null){
            vh.ivEdit.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    editListener.edit(position);
                }
            });
        }
        if(delListener!=null){
            vh.ivDel.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    delListener.del(position);
                }
            });
        }
        WeddingFlowBean data = mDatas.get(position);
        vh.tvTitle.setText(data.getTitle());
        vh.tvTime.setText(data.getShijian());
        vh.tvThings.setText(data.getShixiang());
        vh.tvPeo.setText(data.getRenyuan());
    }

    @Override
    public int getItemCount() {
        return mDatas == null ? 0 : mDatas.size();
    }

     class ViewHolder extends RecyclerView.ViewHolder{
        @BindView(R.id.tv_title)
        TextView tvTitle;
        @BindView(R.id.iv_edit)
        ImageView ivEdit;
        @BindView(R.id.iv_del)
        ImageView ivDel;
        @BindView(R.id.tv_time)
        TextView tvTime;
        @BindView(R.id.tv_things)
        TextView tvThings;
        @BindView(R.id.tv_peo)
        TextView tvPeo;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
        }
    }
}
