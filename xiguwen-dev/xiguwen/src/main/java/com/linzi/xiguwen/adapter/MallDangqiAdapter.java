package com.linzi.xiguwen.adapter;

import android.content.Context;
import androidx.recyclerview.widget.GridLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.ScheduleBean;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/1/5.
 */

public class MallDangqiAdapter extends RecyclerView.Adapter<MallDangqiAdapter.ViewHolder> {
    Context mContext;
    private List<ScheduleBean> list;


    public void setData(List<ScheduleBean> list) {
        this.list = list;
        notifyDataSetChanged();
    }

    public MallDangqiAdapter(Context mContext) {
        this.mContext = mContext;
    }

    @Override
    public MallDangqiAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_mall_dangqi_layout, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(MallDangqiAdapter.ViewHolder vh, int position) {
        vh.tvMonth.setText(list.get(position).getDateye() + "");
        GridLayoutManager manager = new GridLayoutManager(mContext, 7) {
            @Override
            public boolean canScrollVertically() {
                return false;
            }
        };
        vh.recycle.setLayoutManager(manager);
        ItemAdapter adapter = new ItemAdapter();
        vh.recycle.setAdapter(adapter);
        adapter.setData(list.get(position).getDangqi());
    }

    @Override
    public int getItemCount() {
        return list == null ? 0 : list.size();
    }

    class ViewHolder extends RecyclerView.ViewHolder {
        @BindView(R.id.tv_month)
        TextView tvMonth;
        @BindView(R.id.recycle)
        RecyclerView recycle;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
        }
    }

    public class ItemAdapter extends RecyclerView.Adapter<ItemAdapter.VHTime> {
        private List<ScheduleBean.DangqiBean> mlist;

        public void setData(List<ScheduleBean.DangqiBean> mlist) {
            this.mlist = mlist;
            notifyDataSetChanged();
        }

        @Override
        public ItemAdapter.VHTime onCreateViewHolder(ViewGroup parent, int viewType) {
            View view = LayoutInflater.from(mContext).inflate(R.layout.item_mall_dangqi_item_layout, parent, false);
            return new VHTime(view);
        }

        @Override
        public void onBindViewHolder(ItemAdapter.VHTime vh, int position) {
            vh.tvDay.setText(mlist.get(position).getDate() + "");
            vh.tvTime.setText(mlist.get(position).getTimeslot() + "");
        }

        @Override
        public int getItemCount() {
            return mlist == null ? 0 : mlist.size();
        }

        class VHTime extends RecyclerView.ViewHolder {
            @BindView(R.id.tv_day)
            TextView tvDay;
            @BindView(R.id.tv_time)
            TextView tvTime;

            VHTime(View view) {
                super(view);
                ButterKnife.bind(this, view);
            }
        }
    }
}
