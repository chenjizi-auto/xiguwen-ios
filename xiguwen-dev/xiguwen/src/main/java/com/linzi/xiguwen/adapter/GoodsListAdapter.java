package com.linzi.xiguwen.adapter;

import android.content.Context;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.jcodecraeer.xrecyclerview.XRecyclerView;
import com.linzi.xiguwen.R;
import com.linzi.xiguwen.bean.IndexGoodsVadioBean;
import com.linzi.xiguwen.network.Constans;
import com.linzi.xiguwen.utils.GlideLoad;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2017/11/27.
 */

public class GoodsListAdapter extends RecyclerView.Adapter<GoodsListAdapter.ViewHolder> {
    private Context mContext;
    private List<IndexGoodsVadioBean>mList;
    private com.jcodecraeer.xrecyclerview.OnItemClickListener listener;

    public void setListener(com.jcodecraeer.xrecyclerview.OnItemClickListener listener) {
        this.listener = listener;
        this.notifyDataSetChanged();
    }

    public GoodsListAdapter(Context mContext) {
        this.mContext = mContext;
    }

    @Override
    public GoodsListAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_love_list_layout, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(GoodsListAdapter.ViewHolder vh, final int position) {
        if(mList.get(position).getIsCare()==1){
            vh.btCare.setBackgroundResource(R.mipmap.icon_close_care);
        }else{
            vh.btCare.setBackgroundResource(R.mipmap.icon_add_care);
        }
        GlideLoad.GlideLoadCircle(mContext,mList.get(position).getHead_img(),vh.ivHeadImg);
        vh.tvMallName.setText(mList.get(position).getName());
        vh.tvMallSign.setText(mList.get(position).getZhiye());
        if(mList.get(position).getType()==2){
            vh.llIsVideo.setVisibility(View.GONE);
            if(mList.get(position).getTuce()!=null) {
                if (mList.get(position).getTuce().size() >= 3) {
                    GlideLoad.GlideLoadImg(mContext, mList.get(position).getTuce().get(0).getUrl(), vh.ivImg1);
                    vh.llMuchImg.setVisibility(View.VISIBLE);
                    vh.tvImgMore.setVisibility(View.VISIBLE);
                    vh.tvImgMore.setText("+" + mList.get(position).getTuce().size());
                    vh.ivImg2.setVisibility(View.VISIBLE);
                    vh.ivImg3.setVisibility(View.VISIBLE);
                    GlideLoad.GlideLoadImg(mContext, mList.get(position).getTuce().get(1).getUrl(), vh.ivImg2);
                    GlideLoad.GlideLoadImg(mContext, mList.get(position).getTuce().get(2).getUrl(), vh.ivImg3);
                } else if (mList.get(position).getTuce().size() == 2) {
                    GlideLoad.GlideLoadImg(mContext, mList.get(position).getTuce().get(0).getUrl(), vh.ivImg1);
                    vh.llMuchImg.setVisibility(View.GONE);
                    vh.tvImgMore.setVisibility(View.GONE);
                    vh.ivImg2.setVisibility(View.VISIBLE);
                    vh.ivImg3.setVisibility(View.INVISIBLE);
                    vh.tvImgMore.setText("+" + mList.get(position).getTuce().size());
                    GlideLoad.GlideLoadImg(mContext, mList.get(position).getTuce().get(1).getUrl(), vh.ivImg2);
                } else if (mList.get(position).getTuce().size() == 1) {
                    GlideLoad.GlideLoadImg(mContext, mList.get(position).getTuce().get(0).getUrl(), vh.ivImg1);
                    vh.llMuchImg.setVisibility(View.GONE);
                    vh.tvImgMore.setVisibility(View.GONE);
                }
            }
        }else if(mList.get(position).getType()==1){
            vh.llMuchImg.setVisibility(View.GONE);
            vh.llIsVideo.setVisibility(View.VISIBLE);
            GlideLoad.GlideLoadImg(mContext,mList.get(position).getImg_url(),vh.ivImg1);
        }else {
            vh.llMuchImg.setVisibility(View.GONE);
            vh.llIsVideo.setVisibility(View.GONE);
            GlideLoad.GlideLoadImg(mContext,mList.get(position).getImg_url(),vh.ivImg1);
        }
        vh.tvGoodsName.setText(mList.get(position).getTitle());
        if(mList.get(position).getContent()!=null) {
            vh.tvGoodsContruduction.setVisibility(View.VISIBLE);
        }else{
            vh.tvGoodsContruduction.setVisibility(View.GONE);
        }
        vh.tvGoodsContruduction.setText(mList.get(position).getContent());
        vh.tvGoodsPrice.setText(Constans.RMB+mList.get(position).getPrice());
        vh.tvSeeCount.setText(""+mList.get(position).getDianjiliang());
        vh.tvCareCount.setText(""+mList.get(position).getGuanzhuliang());
        vh.tvPingjiaCount.setText(""+mList.get(position).getPinglunliang());

        if(listener!=null){
            vh.btCare.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    listener.onItemClick(v,position);
                }
            });
        }
    }

    public void setData(List<IndexGoodsVadioBean>mList){
        this.mList=mList;
        this.notifyDataSetChanged();
    }

    @Override
    public int getItemCount() {
        return mList==null?0:mList.size();
    }

    class ViewHolder extends RecyclerView.ViewHolder{
        @BindView(R.id.iv_head_img)
        ImageView ivHeadImg;
        @BindView(R.id.tv_mall_name)
        TextView tvMallName;
        @BindView(R.id.tv_mall_sign)
        TextView tvMallSign;
        @BindView(R.id.bt_care)
        Button btCare;
        @BindView(R.id.iv_img_1)
        ImageView ivImg1;
        @BindView(R.id.ll_is_video)
        LinearLayout llIsVideo;
        @BindView(R.id.iv_img_2)
        ImageView ivImg2;
        @BindView(R.id.iv_img_3)
        ImageView ivImg3;
        @BindView(R.id.tv_img_more)
        TextView tvImgMore;
        @BindView(R.id.ll_much_img)
        LinearLayout llMuchImg;
        @BindView(R.id.tv_goods_name)
        TextView tvGoodsName;
        @BindView(R.id.tv_goods_price)
        TextView tvGoodsPrice;
        @BindView(R.id.tv_goods_contruduction)
        TextView tvGoodsContruduction;
        @BindView(R.id.tv_see_count)
        TextView tvSeeCount;
        @BindView(R.id.tv_care_count)
        TextView tvCareCount;
        @BindView(R.id.tv_pingjia_count)
        TextView tvPingjiaCount;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
        }
    }
}
