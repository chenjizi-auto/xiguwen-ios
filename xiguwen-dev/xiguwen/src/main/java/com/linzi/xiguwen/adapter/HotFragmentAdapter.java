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
import com.linzi.xiguwen.bean.WeddingTypeListBean;
import com.linzi.xiguwen.network.Constans;
import com.linzi.xiguwen.utils.GlideLoad;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2017/12/11.
 */

public class HotFragmentAdapter extends RecyclerView.Adapter<HotFragmentAdapter.ViewHolder> {
    Context mContext;
    com.jcodecraeer.xrecyclerview.OnItemClickListener mListener;
    private List<WeddingTypeListBean.DataBean> list;

    public HotFragmentAdapter(Context mContext, com.jcodecraeer.xrecyclerview.OnItemClickListener mListener) {
        this.mContext = mContext;
        this.mListener = mListener;
    }

    public void setList(List<WeddingTypeListBean.DataBean> list) {
        if (this.list != null && list.size() > 0) {
            this.list.clear();
        }
        this.list = list;
        notifyDataSetChanged();
    }

    public void addList(List<WeddingTypeListBean.DataBean> list) {
        if (list != null) {
            this.list.addAll(list);
        }
        notifyDataSetChanged();
    }

    private void clearList() {
        if (list != null && list.size() > 0) {
            list.clear();
            notifyDataSetChanged();
        }
    }


    @Override
    public HotFragmentAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_hot_fragment_layout, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(HotFragmentAdapter.ViewHolder vh, int position) {
        GlideLoad.GlideLoadImg(mContext, list.get(position).getHead(), vh.ivImg);
        vh.tvName.setText(list.get(position).getNickname() + "");
        vh.tvZhiwu.setText(list.get(position).getOccupationid());
        vh.tvPrice.setText(Constans.RMB + list.get(position).getZuidijia() + "起");
        vh.tvHp.setText("商品   " + list.get(position).getShopnum());
        vh.tvPl.setText("案例   " + list.get(position).getAnlinum());
        vh.tvFens.setText("评价   " + list.get(position).getEvaluate());
        vh.ivRzPt.setVisibility(list.get(position).getPlatform() == 1 ? View.VISIBLE : View.GONE);
        vh.ivRzCx.setVisibility(list.get(position).getSincerity() == 1 ? View.VISIBLE : View.GONE);
        vh.ivRzXy.setVisibility(list.get(position).getCollege() == 1 ? View.VISIBLE : View.GONE);
        vh.ivRz.setVisibility(list.get(position).getIsshopvip() == 1 ? View.VISIBLE : View.GONE);
    }

    @Override
    public int getItemCount() {
        return list == null ? 0 : list.size();
    }

    class ViewHolder extends RecyclerView.ViewHolder {
        @BindView(R.id.iv_img)
        ImageView ivImg;
        @BindView(R.id.iv_rz)
        ImageView ivRz;
        @BindView(R.id.tv_name)
        TextView tvName;
        @BindView(R.id.tv_zhiwu)
        TextView tvZhiwu;
        @BindView(R.id.tv_price)
        TextView tvPrice;
        @BindView(R.id.iv_rz_cx)
        ImageView ivRzCx;
        @BindView(R.id.iv_rz_pt)
        ImageView ivRzPt;
        @BindView(R.id.iv_rz_xy)
        ImageView ivRzXy;
        @BindView(R.id.tv_hp)
        TextView tvHp;
        @BindView(R.id.tv_pl)
        TextView tvPl;
        @BindView(R.id.tv_fens)
        TextView tvFens;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
            if (mListener != null) {
                view.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        mListener.onItemClick(view, getPosition());
                    }
                });
            }
        }
    }
}
