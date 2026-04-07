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
import com.linzi.xiguwen.bean.AtlasBean;
import com.linzi.xiguwen.utils.GlideLoad;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/2/12.
 */

public class MineTuCeAdapter extends RecyclerView.Adapter<MineTuCeAdapter.ViewHolder> {
    Context mContext;
    List<AtlasBean> mDatas;
    com.jcodecraeer.xrecyclerview.OnItemClickListener itemClickListener;

    public MineTuCeAdapter(Context mContext, List<AtlasBean> datas, com.jcodecraeer.xrecyclerview.OnItemClickListener itemClickListener) {
        this.mContext = mContext;
        this.itemClickListener = itemClickListener;
        mDatas = datas;
    }

    public MineTuCeAdapter(Context mContext, List<AtlasBean> datas) {
        this.mContext = mContext;
        mDatas = datas;
    }

    @Override
    public MineTuCeAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_baojia_fragment, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(MineTuCeAdapter.ViewHolder vh, int position) {
        AtlasBean atlasBean = mDatas.get(position);
        switch(atlasBean.getStatus()){
            case AtlasBean.STATE_NO_SUBMIT_0:
                vh.ivStatus.setBackgroundDrawable(mContext.getResources().getDrawable(R.mipmap.icon_daitijiao));
            break;
            case AtlasBean.STATE_ON:
                vh.ivStatus.setBackgroundDrawable(mContext.getResources().getDrawable(R.mipmap.icon_shenhezhong));
            break;
            case AtlasBean.STATE_PASS:
                vh.ivStatus.setBackgroundDrawable(mContext.getResources().getDrawable(R.mipmap.icon_yishangjia));
            break;
            case AtlasBean.STATE_FAILED:
                vh.ivStatus.setBackgroundDrawable(mContext.getResources().getDrawable(R.mipmap.icon_weitongguo));
            break;
        }
        vh.tvPrice.setText(atlasBean.getName());
        if (atlasBean.getCover() == null) {
            GlideLoad.GlideLoadImg(mContext, R.mipmap.icon_placeholder, vh.ivImg);
        } else {
            GlideLoad.GlideLoadRoundedImg(atlasBean.getCover(), vh.ivImg, 6);
        }
    }

    @Override
    public int getItemCount() {
        return mDatas == null ? 0 : mDatas.size();
    }

     class ViewHolder extends RecyclerView.ViewHolder{
        @BindView(R.id.iv_img)
        ImageView ivImg;
        @BindView(R.id.tv_title)
        TextView tvTitle;
        @BindView(R.id.tv_price)
        TextView tvPrice;
        @BindView(R.id.iv_status)
        ImageView ivStatus;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
            tvPrice.setTextSize(13);
            tvPrice.setTextColor(mContext.getResources().getColor(R.color.colorHint));
            if(itemClickListener!=null){
                view.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        itemClickListener.onItemClick(v,getPosition());
                    }
                });
            }
        }
    }
}
