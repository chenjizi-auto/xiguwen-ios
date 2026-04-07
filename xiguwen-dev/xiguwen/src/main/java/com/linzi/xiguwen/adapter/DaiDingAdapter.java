package com.linzi.xiguwen.adapter;

import android.content.Context;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.FuYanBean;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by pc on 2018/6/14.
 */

public class DaiDingAdapter extends RecyclerView.Adapter<DaiDingAdapter.ViewHolder> {
    Context mContext;
    private List<FuYanBean.InfoBean> mDatas;

    public DaiDingAdapter(Context mContext, List<FuYanBean.InfoBean> datas) {
        this.mContext = mContext;
        this.mDatas = datas;
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_layout_daiding, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(ViewHolder vh, int position) {
        FuYanBean.InfoBean fuYan = mDatas.get(position);
        vh.tvName.setText(fuYan.getName());
        vh.tvTime.setText(fuYan.getCreateti());
//        vh.tvNum.setText("" + fuYan.getCont());
        vh.tvPhone.setText(fuYan.getTelephone()+"");
        //vh.tvType.setText(fuYan.getFuyan());
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
        @BindView(R.id.tv_phone)
        TextView tvPhone;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
        }
    }
}
