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
import com.linzi.xiguwen.bean.MineNeedDetailBean;
import com.linzi.xiguwen.network.Constans;
import com.linzi.xiguwen.utils.GlideLoad;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/2/11.
 */

public class NeedJoinAdapter extends RecyclerView.Adapter<NeedJoinAdapter.ViewHolder> {
    Context mContext;
    com.jcodecraeer.xrecyclerview.OnItemClickListener itemClickListener;
    private List<MineNeedDetailBean.AffiliatedPerson> mDatas;

    public void setItemClickListener(com.jcodecraeer.xrecyclerview.OnItemClickListener itemClickListener) {
        this.itemClickListener = itemClickListener;
    }

    public NeedJoinAdapter(Context mContext) {
        this.mContext = mContext;
    }

    public void setData(List<MineNeedDetailBean.AffiliatedPerson> datas){
        this.mDatas = datas;
        notifyDataSetChanged();
    }

    @Override
    public NeedJoinAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_layout_need_jion_peo, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(NeedJoinAdapter.ViewHolder vh, int position) {
        MineNeedDetailBean.AffiliatedPerson person = mDatas.get(position);
        if(person.getStatus_j() == MineNeedDetailBean.AffiliatedPerson.STATUS_BINGO){
            vh.ivIsZhong.setVisibility(View.VISIBLE);
        }else{
            vh.ivIsZhong.setVisibility(View.GONE);
        }
        GlideLoad.GlideLoadImg(mContext, person.getHead(), vh.tvHead);
        vh.btPrice.setText(Constans.RMB + person.getMinimumprice() + "起");
        vh.tvName.setText(person.getNickname());
        vh.tvZhiwei.setText(person.getOccupationid());
    }

    @Override
    public int getItemCount() {
        return mDatas == null ? 0 : mDatas.size();
    }

     class ViewHolder extends RecyclerView.ViewHolder{
        @BindView(R.id.tv_head)
        ImageView tvHead;
        @BindView(R.id.tv_name)
        TextView tvName;
        @BindView(R.id.tv_zhiwei)
        TextView tvZhiwei;
        @BindView(R.id.bt_price)
        Button btPrice;
        @BindView(R.id.iv_is_zhong)
        ImageView ivIsZhong;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
            if(itemClickListener!=null){
                view.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        itemClickListener.onItemClick(v,getPosition());
                    }
                });
            }
        }
    }
}
