package com.linzi.xiguwen.adapter;

import android.content.Context;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.CheckCaseDetailsBean;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by pc on 2018/3/22.
 */

public class CheckCaseDetailsChildAdapter extends RecyclerView.Adapter<CheckCaseDetailsChildAdapter.ViewHolder> {

    private Context mContext;
    private List<CheckCaseDetailsBean.DataBeanX.DataBean> mlist;

    public void setData(List<CheckCaseDetailsBean.DataBeanX.DataBean> mlist) {
        this.mlist = mlist;
        this.notifyDataSetChanged();
    }

    public CheckCaseDetailsChildAdapter(Context mContext) {
        this.mContext = mContext;
    }

    @Override
    public CheckCaseDetailsChildAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.checkcasedetails_item_child, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(CheckCaseDetailsChildAdapter.ViewHolder holder, int position) {
        holder.tvName.setText(mlist.get(position).getA() + "");
        holder.tvPrice.setText("￥" + mlist.get(position).getB());
    }

    @Override
    public int getItemCount() {
        if (mlist != null) {
            return mlist.size();
        } else {
            return 0;
        }
    }

    class ViewHolder extends RecyclerView.ViewHolder {
        @BindView(R.id.tv_name)
        TextView tvName;
        @BindView(R.id.tv_price)
        TextView tvPrice;

        public ViewHolder(View itemView) {
            super(itemView);
            ButterKnife.bind(this, itemView);
        }
    }
}
