package com.linzi.xiguwen.adapter;

import android.content.Context;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.TextView;

import com.linzi.xiguwen.R;
import com.linzi.xiguwen.network.Constans;
import com.linzi.xiguwen.utils.GlideLoad;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by jiang on 2018/1/30.
 */

public class SureOrderAdapter extends RecyclerView.Adapter<SureOrderAdapter.ViewHolder> {
    private Context mContext;

    public SureOrderAdapter(Context mContext) {
        this.mContext = mContext;
    }

    @Override
    public SureOrderAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(mContext).inflate(R.layout.item_sure_order_layout, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(SureOrderAdapter.ViewHolder vh, int position) {
        GoodsAdapter adapter=new GoodsAdapter();
        vh.tvName.setText("策划师 林子");
        vh.tvPeice.setText(Constans.RMB + 1000);
        vh.tvGoodsNum.setText("共" + adapter.getItemCount() + "件商品");
        vh.tvPeisongType.setText("快递  " + Constans.RMB + 12);
        LinearLayoutManager manager=new LinearLayoutManager(mContext){
            @Override
            public boolean canScrollVertically() {
                return false;
            }
        };
        vh.goodsRecycle.setLayoutManager(manager);
        vh.goodsRecycle.setAdapter(adapter);

//        vh.edLiuyan.setFocusableInTouchMode(true);
//        vh.edLiuyan.requestFocus();
//        vh.edLiuyan.getParent().requestDisallowInterceptTouchEvent(true);
    }

    @Override
    public int getItemCount() {
        return 4;
    }

    class ViewHolder extends RecyclerView.ViewHolder {
        @BindView(R.id.goods_recycle)
        RecyclerView goodsRecycle;
        @BindView(R.id.tv_peisong_type)
        TextView tvPeisongType;
        @BindView(R.id.ed_liuyan)
        EditText edLiuyan;
        @BindView(R.id.tv_goods_num)
        TextView tvGoodsNum;
        @BindView(R.id.tv_peice)
        TextView tvPeice;
        @BindView(R.id.tv_name)
        TextView tvName;

        ViewHolder(View view) {
            super(view);
            ButterKnife.bind(this, view);
        }
    }

   public  class GoodsAdapter extends RecyclerView.Adapter<GoodsAdapter.VH> {

        @Override
        public GoodsAdapter.VH onCreateViewHolder(ViewGroup parent, int viewType) {
            View view = LayoutInflater.from(mContext).inflate(R.layout.item_sure_item_layout, parent, false);
            return new VH(view);
        }

        @Override
        public void onBindViewHolder(GoodsAdapter.VH vh, int position) {
            GlideLoad.GlideLoadImg(mContext,"http://pic41.nipic.com/20140503/18641501_163214498000_2.jpg",vh.ivImg);
            vh.tvTitle.setText("酒店室内浪漫婚礼");
            vh.tvTime.setText("2018-01-01  中午");
            vh.tvDanjia.setText(Constans.RMB+1000);
            vh.tvDingjin.setText(Constans.RMB+1000);
            vh.tvPayType.setText("定金");
            vh.tvNum.setText(""+1);
        }

        @Override
        public int getItemCount() {
            return 3;
        }

        class VH extends RecyclerView.ViewHolder{
            @BindView(R.id.iv_img)
            ImageView ivImg;
            @BindView(R.id.tv_title)
            TextView tvTitle;
            @BindView(R.id.tv_time)
            TextView tvTime;
            @BindView(R.id.tv_danjia)
            TextView tvDanjia;
            @BindView(R.id.tv_dingjin)
            TextView tvDingjin;
            @BindView(R.id.tv_pay_type)
            TextView tvPayType;
            @BindView(R.id.tv_num)
            TextView tvNum;

            VH(View view) {
                super(view);
                ButterKnife.bind(this, view);
            }
        }
    }
}
