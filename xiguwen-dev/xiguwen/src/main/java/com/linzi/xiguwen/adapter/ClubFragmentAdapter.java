package com.linzi.xiguwen.adapter;

import android.content.Context;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.AssociationBean;
import com.linzi.xiguwen.network.Constans;
import com.linzi.xiguwen.utils.GlideLoad;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2017/12/11.
 */

public class ClubFragmentAdapter extends RecyclerView.Adapter<ClubFragmentAdapter.ViewHolder> {
    Context mContext;
    com.jcodecraeer.xrecyclerview.OnItemClickListener mListener;
    private AssociationBean mAssociationBeans;

    public void setData(AssociationBean bean) {
        if (mAssociationBeans == null) {
            mAssociationBeans = bean;
            notifyDataSetChanged();
            return;
        }
        mAssociationBeans.getShetuan().clear();
        addData(bean);
    }

    public void appendData(AssociationBean bean) {
        addData(bean);
    }

    private void addData(AssociationBean bean) {
        mAssociationBeans.getShetuan().addAll(bean.getShetuan());
        notifyDataSetChanged();

    }

    public AssociationBean.ShetuanBean getItemBean(int positon) {
        return mAssociationBeans.getShetuan().get(positon);
    }

    public ClubFragmentAdapter(Context mContext, com.jcodecraeer.xrecyclerview.OnItemClickListener mListener) {
        this.mContext = mContext;
        this.mListener = mListener;
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_club_list_fragment, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(ViewHolder vh, int position) {
        vh.displayBean(mAssociationBeans.getShetuan().get(position));
    }

    @Override
    public int getItemCount() {
        return mAssociationBeans == null ? 0 : mAssociationBeans.getShetuan().size();
    }

    class ViewHolder extends RecyclerView.ViewHolder {
        @BindView(R.id.iv_img)
        ImageView ivImg;
        @BindView(R.id.tv_name)
        TextView tvName;
        @BindView(R.id.tv_price)
        TextView tvPrice;
        @BindView(R.id.tv_club_peo)
        TextView tvClubPeo;
        @BindView(R.id.tv_zhiwu)
        TextView tvZhiwu;
        @BindView(R.id.tv_location)
        TextView tvLocation;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
            if (mListener != null) {
                view.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        mListener.onItemClick(view, getPosition());
                    }
                });
            }
        }

        void displayBean(AssociationBean.ShetuanBean bean) {
            GlideLoad.GlideLoadImg2(bean.getLogourl(), ivImg);
            tvName.setText(bean.getName());
            tvPrice.setText(Constans.RMB + bean.getMinimumprice() + "起");
            tvClubPeo.setText("成员:" + bean.getMembersnum());
            tvZhiwu.setText(bean.getType());
            tvLocation.setText(bean.getAddress());

        }
    }
}
