package com.linzi.xiguwen.adapter;

import android.content.Context;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.ServiceCity;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/2/12.
 */

public class MineServiceAdapter extends RecyclerView.Adapter<MineServiceAdapter.ViewHolder> {
    Context mContext;
    com.jcodecraeer.xrecyclerview.OnItemClickListener itemClickListener;
    private List<ServiceCity> mDatas;

    public MineServiceAdapter(Context mContext,List<ServiceCity> datas, com.jcodecraeer.xrecyclerview.OnItemClickListener itemClickListener) {
        this.mContext = mContext;
        this.itemClickListener = itemClickListener;
        this.mDatas = datas;
    }

    @Override
    public MineServiceAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_mine_service_city, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(MineServiceAdapter.ViewHolder vh, int position) {
        ServiceCity serviceCity = mDatas.get(position);
        vh.tvProvince.setText(serviceCity.getProvince());
        vh.tvCity.setText(serviceCity.getCity());
    }

    @Override
    public int getItemCount() {
        return mDatas == null ? 0 : mDatas.size();
    }

     class ViewHolder extends RecyclerView.ViewHolder{
         @BindView(R.id.tv_province)
         TextView tvProvince;
        @BindView(R.id.tv_city)
        TextView tvCity;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
        }
    }
}
