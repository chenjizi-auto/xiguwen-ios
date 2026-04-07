package com.linzi.xiguwen.adapter;

import android.content.Context;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/2/11.
 */

public class HistoryPeoAdapter extends RecyclerView.Adapter<HistoryPeoAdapter.ViewHolder> {
    Context mContext;

    public HistoryPeoAdapter(Context mContext) {
        this.mContext = mContext;
    }

    @Override
    public HistoryPeoAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_history_peo_layout, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(HistoryPeoAdapter.ViewHolder vh, int position) {
        vh.tvDay.setText("01月01日");
        LinearLayoutManager manager=new LinearLayoutManager(mContext){
            @Override
            public boolean canScrollVertically() {
                return false;
            }
        };
        vh.recycle.setLayoutManager(manager);
        HistoryAdapter mAdapter=new HistoryAdapter(mContext, new com.jcodecraeer.xrecyclerview.OnItemClickListener() {
            @Override
            public void onItemClick(View view, int postion) {

            }
        },0);
        vh.recycle.setAdapter(mAdapter);
    }

    @Override
    public int getItemCount() {
        return 10;
    }

     class ViewHolder extends RecyclerView.ViewHolder{
        @BindView(R.id.tv_day)
        TextView tvDay;
        @BindView(R.id.recycle)
        RecyclerView recycle;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
        }
    }
}
