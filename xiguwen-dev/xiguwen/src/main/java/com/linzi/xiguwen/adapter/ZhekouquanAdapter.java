package com.linzi.xiguwen.adapter;

import android.content.Context;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.linzi.xiguwen.R;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/2/4.
 */

public class ZhekouquanAdapter extends RecyclerView.Adapter<ZhekouquanAdapter.ViewHolder> {
    private Context mContext;

    private List<String> prices = new ArrayList<>();

    public void addPrice(String price) {
        prices.add(price);
        notifyDataSetChanged();
    }

    public ZhekouquanAdapter(Context mContext) {
        this.mContext = mContext;
    }

    @Override
    public ZhekouquanAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_zhekouquan_layout, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(ZhekouquanAdapter.ViewHolder vh, int position) {
        vh.tvPrice.setText(prices.get(position) + "");
    }

    @Override
    public int getItemCount() {
        return prices == null ? 0 : prices.size();
    }

    class ViewHolder extends RecyclerView.ViewHolder {
        @BindView(R.id.tv_name)
        TextView tvName;
        @BindView(R.id.tv_context)
        TextView tvContext;
        @BindView(R.id.tv_time)
        TextView tvTime;
        @BindView(R.id.tv_price)
        TextView tvPrice;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
        }
    }
}
