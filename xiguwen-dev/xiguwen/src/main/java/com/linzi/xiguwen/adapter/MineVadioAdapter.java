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
import com.linzi.xiguwen.bean.VideoBean;
import com.linzi.xiguwen.utils.GlideLoad;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/2/12.
 */

public class MineVadioAdapter extends RecyclerView.Adapter<MineVadioAdapter.ViewHolder> {
    Context mContext;
    int type = 0;
    List<VideoBean> mDatas;

    com.jcodecraeer.xrecyclerview.OnItemClickListener itemClickListener;

    public MineVadioAdapter(Context mContext, List<VideoBean> datas, int type, com.jcodecraeer.xrecyclerview.OnItemClickListener itemClickListener) {
        this.mContext = mContext;
        this.mDatas = datas;
        this.type = type;
        this.itemClickListener = itemClickListener;
    }

    public MineVadioAdapter(Context mContext, List<VideoBean> datas, int type) {
        this.mContext = mContext;
        this.mDatas = datas;
        this.type = type;
    }

    @Override
    public MineVadioAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_baojia_fragment, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(MineVadioAdapter.ViewHolder vh, int position) {
        VideoBean bean = mDatas.get(position);
        switch(type){
            case 0:
                vh.ivStatus.setBackgroundDrawable(mContext.getResources().getDrawable(R.mipmap.icon_daitijiao));
            break;
            case 1:
                vh.ivStatus.setBackgroundDrawable(mContext.getResources().getDrawable(R.mipmap.icon_shenhezhong));
            break;
            case 2:
                vh.ivStatus.setBackgroundDrawable(mContext.getResources().getDrawable(R.mipmap.icon_yishangjia));
            break;
            case 3:
                vh.ivStatus.setBackgroundDrawable(mContext.getResources().getDrawable(R.mipmap.icon_weitongguo));
            break;
        }
        vh.tvTitle.setText(bean.getTitle());
        vh.tvPrice.setTextSize(13);
        vh.tvPrice.setTextColor(mContext.getResources().getColor(R.color.colorHint));
        vh.tvPrice.setText(bean.getVideo_url());
        if (bean.getCover() == null) {
            GlideLoad.GlideLoadImg(mContext, R.mipmap.icon_placeholder, vh.ivImg);
        } else {
            GlideLoad.GlideLoadRoundedImg(bean.getCover(), vh.ivImg, 6);
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
