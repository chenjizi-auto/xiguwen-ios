package com.linzi.xiguwen.adapter;

import android.content.Context;

import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.BillDataBean;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/2/12.
 */

public class MineJizhangAdapter extends RecyclerView.Adapter<RecyclerView.ViewHolder> {
    public static final int TYPE_GROUP = 0x100;
    public static final int TYPE_CHILD = 0x101;

    Context mContext;
    private BillDataBean mDatas;

    public MineJizhangAdapter(Context mContext) {
        this.mContext = mContext;
    }

    @Override
    public int getItemViewType(int position) {
        int cache = 0;
        for (BillDataBean.BillList billList : mDatas.getList()) {
            if(position == cache){
                return TYPE_GROUP;
            }else if(position > cache && position <= cache + billList.getTian().size()){
                return TYPE_CHILD;
            }
            cache ++;
            cache += billList.getTian().size();
        }
        return TYPE_CHILD;
    }


    public BillDataBean.BillList getGroup(int position){
        int cache = 0;
        for (BillDataBean.BillList billList : mDatas.getList()) {
            cache ++;
            cache += billList.getTian().size();
            if(position < cache){
                return billList;
            }
        }
        return null;
    }

    public BillDataBean.Bill getChild(int positon){
        int group = 0;
        for (BillDataBean.BillList billList : mDatas.getList()) {
            if(positon > billList.getTian().size()){
                group ++;
                positon --;
                positon -= billList.getTian().size();
            }else if(positon >= 0){
                return getChild(group, positon - 1);
            }else{
                return null;
            }
        }
        return null;
    }

    public BillDataBean.Bill getChild(int group, int position){
        return mDatas.getList().get(group).getTian().get(position);
    }

    @Override
    public RecyclerView.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        if(viewType == TYPE_GROUP){
            return new GroupViewHolder(LayoutInflater.from(mContext).inflate(R.layout.item_jizhang_layout, parent, false));
        }else{
            return new ChildViewHolder(LayoutInflater.from(mContext).inflate(R.layout.item_jizhang_item_layout, parent, false));
        }
    }

    @Override
    public void onBindViewHolder(RecyclerView.ViewHolder vh, int position) {
        if(vh instanceof GroupViewHolder){
            BillDataBean.BillList group = getGroup(position);
            if(group != null){
                ((GroupViewHolder) vh).tvDate.setText(group.getRiqi());
                ((GroupViewHolder) vh).tvNotice.setText("日统计：" + group.getRitongji());
            }
        }else{
            ChildViewHolder childVH = (ChildViewHolder) vh;
            BillDataBean.Bill child = getChild(position);
            if(child != null){
                childVH.ivType.setImageResource(child.getType() == BillDataBean.TYPE_SHOURU ? R.mipmap.icon_shouru : R.mipmap.icon_zhichu);
                childVH.tvTitle.setText(child.getRemarks());
                childVH.tvPrice.setText(child.getType() == BillDataBean.TYPE_SHOURU ? "" + child.getAftermoney() : "- " + child.getAftermoney());
            }
        }
    }

    @Override
    public int getItemCount() {
        int count = 0;
        if(mDatas != null){
            List<BillDataBean.BillList> list = mDatas.getList();
            if(list != null){
                count += list.size();
                for (BillDataBean.BillList billList : list) {
                    if(billList.getTian() != null){
                        count += billList.getTian().size();
                    }
                }
            }
        }
        return count;
    }

    public void setData(BillDataBean datas) {
        mDatas = datas;
        notifyDataSetChanged();
    }

    class GroupViewHolder extends RecyclerView.ViewHolder {
        @BindView(R.id.tv_date)
        TextView tvDate;
        @BindView(R.id.tv_notice)
        TextView tvNotice;

        GroupViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
        }
    }

    class ChildViewHolder extends RecyclerView.ViewHolder{
        @BindView(R.id.iv_type)
        ImageView ivType;
        @BindView(R.id.tv_title)
        TextView tvTitle;
        @BindView(R.id.tv_price)
        TextView tvPrice;

        ChildViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
        }
    }
}
