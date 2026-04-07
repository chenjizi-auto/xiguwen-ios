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
import com.linzi.xiguwen.bean.BaoJiaBean;
import com.linzi.xiguwen.bean.BaseStatusBean;
import com.linzi.xiguwen.bean.CommodityBean;
import com.linzi.xiguwen.bean.MyExampleBean;
import com.linzi.xiguwen.utils.GlideLoad;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/2/12.
 */

public class MineListAdapter extends RecyclerView.Adapter<MineListAdapter.ViewHolder> {
    Context mContext;
    List<BaseStatusBean> mDatas;
    com.jcodecraeer.xrecyclerview.OnItemClickListener itemClickListener;

    public MineListAdapter(Context mContext, List<BaseStatusBean> datas, com.jcodecraeer.xrecyclerview.OnItemClickListener itemClickListener) {
        this.mContext = mContext;
        this.itemClickListener = itemClickListener;
        mDatas = datas;
    }

    public MineListAdapter(Context mContext, List<BaseStatusBean> datas) {
        this.mContext = mContext;
        mDatas = datas;
    }

    @Override
    public MineListAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_baojia_fragment, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(MineListAdapter.ViewHolder vh, int position) {
        BaseStatusBean bean = mDatas.get(position);
        switch(bean.getMyState()){
            case BaseStatusBean.STATE_NO_SUBMIT_0:
            case BaseStatusBean.STATE_NO_SUBMIT_4:
                vh.ivStatus.setBackgroundDrawable(mContext.getResources().getDrawable(R.mipmap.icon_daitijiao));
            break;
            case BaseStatusBean.STATE_ON:
                vh.ivStatus.setBackgroundDrawable(mContext.getResources().getDrawable(R.mipmap.icon_shenhezhong));
            break;
            case BaseStatusBean.STATE_PASS:
                if(bean.getMyStatus() == BaseStatusBean.STATUS_PUT_ON_SHELVES){
                    vh.ivStatus.setBackgroundDrawable(mContext.getResources().getDrawable(R.mipmap.icon_yishangjia));
                }else{
                    vh.ivStatus.setBackgroundDrawable(mContext.getResources().getDrawable(R.mipmap.icon_weishangjia));
                }
            break;
            case BaseStatusBean.STATE_FAILED:
                vh.ivStatus.setBackgroundDrawable(mContext.getResources().getDrawable(R.mipmap.icon_weitongguo));
            break;
        }
        vh.tvTitle.setText(bean.getMyTitle());
        vh.tvPrice.setText(bean.getMyContent());
        if(bean.getMyCover() == null){
            GlideLoad.GlideLoadImg(mContext, R.mipmap.icon_placeholder, vh.ivImg);
        }else{
            GlideLoad.GlideLoadRoundedImg(bean.getMyCover(), vh.ivImg, 6);
        }

        if(bean instanceof MyExampleBean || bean instanceof BaoJiaBean || bean instanceof CommodityBean){
            // 设置红色
            vh.tvPrice.setTextColor(mContext.getResources().getColor(R.color.main_red));
        }else{
            vh.tvPrice.setTextColor(mContext.getResources().getColor(R.color.colorHint));
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
