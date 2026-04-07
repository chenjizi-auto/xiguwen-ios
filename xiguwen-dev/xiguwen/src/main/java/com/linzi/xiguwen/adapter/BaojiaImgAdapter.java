package com.linzi.xiguwen.adapter;

import android.content.Context;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.CaseDetailsBean;
import com.linzi.xiguwen.utils.GlideLoad;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/1/5.
 */

public class BaojiaImgAdapter extends RecyclerView.Adapter<BaojiaImgAdapter.ViewHolder> {
    Context mContext;
    private List<CaseDetailsBean.DataBean.InfoBean.PhotourlBean> mlist;
    private com.jcodecraeer.xrecyclerview.OnItemClickListener listener;

    public void setListener(com.jcodecraeer.xrecyclerview.OnItemClickListener listener) {
        this.listener = listener;
        this.notifyDataSetChanged();
    }

    public BaojiaImgAdapter(Context mContext, com.jcodecraeer.xrecyclerview.OnItemClickListener itemClickListener) {
        this.mContext = mContext;
        this.listener = itemClickListener;
    }

    @Override
    public BaojiaImgAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_baojia_img_layout, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(BaojiaImgAdapter.ViewHolder vh, int position) {
        GlideLoad.GlideLoadImg(mContext, mlist.get(position).getPhotourl(), vh.ivImg);

    }

    @Override
    public int getItemCount() {
        if (mlist == null) {
            return 0;
        } else {
            return mlist.size();
        }
    }

    class ViewHolder extends RecyclerView.ViewHolder {
        @BindView(R.id.iv_img)
        ImageView ivImg;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
            if (listener != null) {
                view.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        listener.onItemClick(view, getPosition());
                    }
                });
            }
        }
    }

    public void setData(List<CaseDetailsBean.DataBean.InfoBean.PhotourlBean> mlist) {
        this.mlist = mlist;
        this.notifyDataSetChanged();
    }
}
