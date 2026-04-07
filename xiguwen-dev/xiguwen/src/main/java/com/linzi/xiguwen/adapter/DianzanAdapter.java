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
import com.linzi.xiguwen.bean.SynamicdetailsBean;
import com.linzi.xiguwen.utils.GlideLoad;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/1/29.
 */

public class DianzanAdapter extends RecyclerView.Adapter<DianzanAdapter.ViewHolder> {
    private Context mContext;
    private com.jcodecraeer.xrecyclerview.OnItemClickListener listener;

    private List<SynamicdetailsBean.ZanlistBean> mBens;


    public void addMore(List<SynamicdetailsBean.ZanlistBean> bens) {
        if (bens == null)
            return;
        if (mBens == null) {
            mBens = new ArrayList<>();
        }
        mBens.addAll(bens);
        notifyDataSetChanged();

    }

    public void addFirst(List<SynamicdetailsBean.ZanlistBean> bens) {
        if (mBens == null) {
            mBens = new ArrayList<>();
        }
        mBens.clear();
        mBens.addAll(bens);
        notifyDataSetChanged();
    }

    public DianzanAdapter(Context mContext, com.jcodecraeer.xrecyclerview.OnItemClickListener listener) {
        this.mContext = mContext;
        this.listener = listener;
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_dianzan_layout, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(ViewHolder vh, final int position) {
        SynamicdetailsBean.ZanlistBean bean = mBens.get(position);
        GlideLoad.GlideLoadCircle(mContext, bean.getHead(), vh.ivHead);
        vh.tvTitle.setText(bean.getNickname());
    }

    @Override
    public int getItemCount() {
        return mBens == null ? 0 : mBens.size();
    }

    class ViewHolder extends RecyclerView.ViewHolder {
        @BindView(R.id.iv_head)
        ImageView ivHead;
        @BindView(R.id.tv_title)
        TextView tvTitle;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
            if (listener != null) {
                view.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        listener.onItemClick(view, getPosition());
                    }
                });
            }
        }
    }
}
