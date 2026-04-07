package com.linzi.xiguwen.adapter;

import android.content.Context;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.MineInvitationInfoBean;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/2/11.
 */

public class InvatedDetailsAdapter extends RecyclerView.Adapter<InvatedDetailsAdapter.ViewHolder> {
    Context mContext;
    private List<MineInvitationInfoBean.InvitationDetail> mDatas;

    public InvatedDetailsAdapter(Context mContext) {
        this.mContext = mContext;
    }

    @Override
    public InvatedDetailsAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_invated_details_layout, parent, false);
        return new ViewHolder(view);
    }

    public void setDatas(List<MineInvitationInfoBean.InvitationDetail> datas){
        mDatas = datas;
        notifyDataSetChanged();
    }

    @Override
    public void onBindViewHolder(InvatedDetailsAdapter.ViewHolder vh, int position) {

    }

    @Override
    public int getItemCount() {
        return mDatas == null ? 0 : mDatas.size();
    }

     class ViewHolder extends RecyclerView.ViewHolder {
        @BindView(R.id.tv_phone)
        TextView tvPhone;
        @BindView(R.id.tv_time)
        TextView tvTime;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
        }
    }
}
