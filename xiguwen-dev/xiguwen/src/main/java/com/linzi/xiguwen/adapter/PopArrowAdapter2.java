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
import com.linzi.xiguwen.bean.ClassificationBean;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2017/12/15.
 */

public class PopArrowAdapter2 extends RecyclerView.Adapter<PopArrowAdapter2.ViewHolder> {
    Context mContext;
    List<ClassificationBean> arrow;
    com.jcodecraeer.xrecyclerview.OnItemClickListener itemClickListener;
    int select_point=0;

    public PopArrowAdapter2(Context mContext, List<ClassificationBean> arrow, com.jcodecraeer.xrecyclerview.OnItemClickListener itemClickListener) {
        this.mContext = mContext;
        this.arrow = arrow;
        this.itemClickListener = itemClickListener;
    }

    @Override
    public PopArrowAdapter2.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.pop_item_arrow_list, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(final PopArrowAdapter2.ViewHolder vh, int position) {
        if(select_point==position){
            vh.ivSelect.setVisibility(View.VISIBLE);
            vh.tvSelectTxt.setTextColor(mContext.getResources().getColor(R.color.colorTitleRed));
        }else{
            vh.ivSelect.setVisibility(View.GONE);
            vh.tvSelectTxt.setTextColor(mContext.getResources().getColor(R.color.title_sign));
        }
        vh.tvSelectTxt.setText(arrow.get(position).getProname());
    }

    @Override
    public int getItemCount() {
        return arrow==null?0:arrow.size();
    }

    public void setSelect(int position){
        select_point=position;
    }

    class ViewHolder extends RecyclerView.ViewHolder{
        @BindView(R.id.tv_select_txt)
        TextView tvSelectTxt;
        @BindView(R.id.iv_select)
        ImageView ivSelect;

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
