package com.linzi.xiguwen.adapter;

import android.content.Context;
import androidx.recyclerview.widget.LinearLayoutManager;
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
 * 案例查看明细适配器
 */

public class CheckCaseDetailsAdapter extends RecyclerView.Adapter<CheckCaseDetailsAdapter.ViewHolder> {

    private Context mContext;
    private List<CheckCaseDetailsBean.DataBeanX> titlelist;


    public void setTitleData(List<CheckCaseDetailsBean.DataBeanX> titlelist) {
        this.titlelist = titlelist;
        notifyDataSetChanged();
    }

    public CheckCaseDetailsAdapter(Context mContext) {
        this.mContext = mContext;
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.checkcasedetails_item, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(ViewHolder holder, int position) {
        CheckCaseDetailsChildAdapter adapter = new CheckCaseDetailsChildAdapter(mContext);
        LinearLayoutManager manager2 = new LinearLayoutManager(mContext);
        holder.recycle.setLayoutManager(manager2);
        holder.recycle.setAdapter(adapter);
        adapter.setData(titlelist.get(position).getData());
        holder.tvZhiwei.setText(titlelist.get(position).getTitle());
        holder.tvName.setText("小计");
        holder.tvPrice.setText("￥" + titlelist.get(position).getXiaoji());
    }

    @Override
    public int getItemCount() {
        if (titlelist != null) {
            return titlelist.size();
        } else {
            return 0;
        }
    }

    class ViewHolder extends RecyclerView.ViewHolder {
        @BindView(R.id.tv_zhiwei)
        TextView tvZhiwei;
        @BindView(R.id.recycle)
        RecyclerView recycle;
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
