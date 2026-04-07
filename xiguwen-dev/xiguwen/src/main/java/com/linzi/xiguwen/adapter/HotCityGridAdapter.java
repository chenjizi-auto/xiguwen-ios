package com.linzi.xiguwen.adapter;

import android.content.Context;
import androidx.recyclerview.widget.RecyclerView;
import androidx.recyclerview.widget.RecyclerView.Adapter;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.CityBean;
import com.linzi.xiguwen.utils.CallBack;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2017/11/28.
 */

public class HotCityGridAdapter extends Adapter<HotCityGridAdapter.ViewHolder> {
    private List<CityBean.DataBean.NewsiteBean> newsite;
    private Context mContext;
    private CallBack.OnMenuItemClickListener clickListener;

    public HotCityGridAdapter(List<CityBean.DataBean.NewsiteBean> newsite, Context mContext, CallBack.OnMenuItemClickListener clickListener) {
        this.newsite = newsite;
        this.mContext = mContext;
        this.clickListener = clickListener;
    }

    @Override
    public HotCityGridAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_recycle_hot_city_layout, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(HotCityGridAdapter.ViewHolder vh, final int position) {
        vh.btCity.setText(newsite.get(position).getName());
        if(clickListener!=null) {
            vh.btCity.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    clickListener.itemClick(position);
                }
            });
        }
    }

    @Override
    public int getItemCount() {
        return newsite==null?0:newsite.size();
    }

    class ViewHolder extends RecyclerView.ViewHolder{
        @BindView(R.id.bt_city)
        Button btCity;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
        }
    }
}
