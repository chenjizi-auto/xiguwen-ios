package com.linzi.xiguwen.adapter;

import android.content.Context;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.utils.GlideLoad;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/2/3.
 */

public class CareUserAdapter extends RecyclerView.Adapter<CareUserAdapter.ViewHolder> {
    Context mContext;

    public CareUserAdapter(Context mContext) {
        this.mContext = mContext;
    }

    @Override
    public CareUserAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.fragment_care_user_layout, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(CareUserAdapter.ViewHolder vh, int position) {
        GlideLoad.GlideLoadCircle(mContext,"http://img0.imgtn.bdimg.com/it/u=1950620400,3641542324&fm=27&gp=0.jpg",vh.ivHeadImg);
    }

    @Override
    public int getItemCount() {
        return 20;
    }

    class ViewHolder extends RecyclerView.ViewHolder{
        @BindView(R.id.iv_head_img)
        ImageView ivHeadImg;
        @BindView(R.id.tv_name)
        TextView tvName;
        @BindView(R.id.tv_zhiye)
        TextView tvZhiye;
        @BindView(R.id.tv_city)
        TextView tvCity;
        @BindView(R.id.bt_is_care)
        ImageView btIsCare;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
        }
    }
}
