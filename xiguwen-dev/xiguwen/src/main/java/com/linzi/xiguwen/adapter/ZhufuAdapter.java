package com.linzi.xiguwen.adapter;

import android.content.Context;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.ZhuFuBean;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/1/25.
 */

public class ZhufuAdapter extends RecyclerView.Adapter<ZhufuAdapter.ViewHolder> {
    Context mContext;
    private List<ZhuFuBean.InfoBean> mDatas;

    public ZhufuAdapter(Context mContext, List<ZhuFuBean.InfoBean> datas) {
        this.mContext = mContext;
        this.mDatas = datas;
    }

    @Override
    public ZhufuAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_layout_binkezhufu, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(ZhufuAdapter.ViewHolder vh, int position) {
        ZhuFuBean.InfoBean zhuFu = mDatas.get(position);
        vh.tvName.setText(zhuFu.getName());
        vh.tvTime.setText(zhuFu.getCreateti());
        vh.tvReply.setText(zhuFu.getCont());
    }

    @Override
    public int getItemCount() {
        return mDatas == null ? 0 : mDatas.size();
    }

    class ViewHolder extends RecyclerView.ViewHolder {
        @BindView(R.id.tv_name)
        TextView tvName;
        @BindView(R.id.tv_time)
        TextView tvTime;
        @BindView(R.id.tv_reply)
        TextView tvReply;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
        }
    }
}
