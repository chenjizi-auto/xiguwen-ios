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
import com.linzi.xiguwen.network.Constans;
import com.linzi.xiguwen.utils.GlideLoad;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/2/12.
 */

public class MineBaojiaAdapter extends RecyclerView.Adapter<MineBaojiaAdapter.ViewHolder> {
    Context mContext;
    List<BaoJiaBean> mDatas;

    com.jcodecraeer.xrecyclerview.OnItemClickListener itemClickListener;

    public MineBaojiaAdapter(Context mContext, List<BaoJiaBean> datas, com.jcodecraeer.xrecyclerview.OnItemClickListener itemClickListener) {
        this.mContext = mContext;
//        this.type = type;
        mDatas = datas;
        this.itemClickListener = itemClickListener;
    }

    public MineBaojiaAdapter(Context mContext, List<BaoJiaBean> datas) {
        this.mContext = mContext;
    }

    @Override
    public MineBaojiaAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_baojia_fragment, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(MineBaojiaAdapter.ViewHolder vh, int position) {
//        switch(type){
//            case BaoJiaBean.CHECK_WAIT:
//                vh.ivStatus.setBackgroundDrawable(mContext.getResources().getDrawable(R.mipmap.icon_daitijiao));
//            break;
//            case BaoJiaBean.CHECK_ON:
//                vh.ivStatus.setBackgroundDrawable(mContext.getResources().getDrawable(R.mipmap.icon_shenhezhong));
//            break;
//            case BaoJiaBean.CHECK_FINISH:
//                vh.ivStatus.setBackgroundDrawable(mContext.getResources().getDrawable(R.mipmap.icon_yishangjia));
//            break;
//            case BaoJiaBean.CHECK_ERR:
//                vh.ivStatus.setBackgroundDrawable(mContext.getResources().getDrawable(R.mipmap.icon_weitongguo));
//            break;
//        }
        BaoJiaBean baoJiaBean = mDatas.get(position);
        switch(baoJiaBean.getState()){
            case BaoJiaBean.STATE_NO_SUBMIT_0:
                vh.ivStatus.setBackgroundDrawable(mContext.getResources().getDrawable(R.mipmap.icon_daitijiao));
            break;
            case BaoJiaBean.STATE_ON:
                vh.ivStatus.setBackgroundDrawable(mContext.getResources().getDrawable(R.mipmap.icon_shenhezhong));
            break;
            case BaoJiaBean.STATE_PASS:
                if(baoJiaBean.getStatus() == BaoJiaBean.STATUS_PUT_ON_SHELVES){
                    vh.ivStatus.setBackgroundDrawable(mContext.getResources().getDrawable(R.mipmap.icon_yishangjia));
                }else{
                    vh.ivStatus.setBackgroundDrawable(mContext.getResources().getDrawable(R.mipmap.icon_weishangjia));
                }
            break;
            case BaoJiaBean.STATE_FAILED:
                vh.ivStatus.setBackgroundDrawable(mContext.getResources().getDrawable(R.mipmap.icon_weitongguo));
            break;
        }
        if(baoJiaBean.getImglist() != null && baoJiaBean.getImglist().size() > 0){
            GlideLoad.GlideLoadRoundedImg(baoJiaBean.getImglist().get(0), vh.ivImg, 6);
        }else{
            GlideLoad.GlideLoadImg(mContext, R.mipmap.icon_placeholder, vh.ivImg);
        }

        vh.tvTitle.setText(baoJiaBean.getName());
        vh.tvPrice.setText(Constans.RMB + baoJiaBean.getPrice());
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
