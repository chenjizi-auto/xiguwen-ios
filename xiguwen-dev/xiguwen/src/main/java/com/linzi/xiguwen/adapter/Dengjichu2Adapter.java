package com.linzi.xiguwen.adapter;

import android.content.Context;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.TextView;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.RegistryOfMarriageBean;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/1/24.
 */

public class Dengjichu2Adapter extends RecyclerView.Adapter<Dengjichu2Adapter.ViewHolder> {
    Context mContext;
    com.jcodecraeer.xrecyclerview.OnItemClickListener listener;
    List<RegistryOfMarriageBean> mInfo;
    private com.jcodecraeer.xrecyclerview.OnItemClickListener mMapListener;

    public Dengjichu2Adapter(Context mContext, com.jcodecraeer.xrecyclerview.OnItemClickListener listener) {
        this.mContext = mContext;
        this.listener = listener;
    }

    public void setData(List<RegistryOfMarriageBean> datas){
        this.mInfo = datas;
        notifyDataSetChanged();
    }

    public void setOnMapClickListener(com.jcodecraeer.xrecyclerview.OnItemClickListener listener){
        this.mMapListener = listener;
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_layout_dengjichu, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(ViewHolder vh, int position) {
        RegistryOfMarriageBean bean = mInfo.get(position);
        vh.tvName.setText(bean.getTitle());
        vh.tvPhone.setText(bean.getPhone());
        vh.tvLocation.setText(bean.getAddress());
    }

    @Override
    public int getItemCount() {
        return mInfo == null ? 0 : mInfo.size();
    }

    class ViewHolder extends RecyclerView.ViewHolder implements View.OnClickListener {
        @BindView(R.id.tv_name)
        TextView tvName;
        @BindView(R.id.tv_phone)
        TextView tvPhone;
        @BindView(R.id.tv_location)
        TextView tvLocation;
        @BindView(R.id.bt_enter)
        Button btEnter;

        public ViewHolder(View itemView) {
            super(itemView);
            ButterKnife.bind(this,itemView);
            if (listener != null) {
                itemView.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        listener.onItemClick(view, getPosition());
                    }
                });
            }
            btEnter.setOnClickListener(this);
        }

        @Override
        public void onClick(View v) {
            if(mMapListener != null){
                mMapListener.onItemClick(v, getAdapterPosition());
            }
        }
    }

    //将dp转换为px
    public int dip2px(Context context, float dpValue) {
        final float scale = context.getResources().getDisplayMetrics().density;
        return (int) (dpValue * scale + 0.5f);
    }
}
